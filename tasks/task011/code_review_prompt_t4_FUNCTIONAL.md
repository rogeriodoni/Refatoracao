# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (134)
- [CARGA-DADOS] Metodo ValidarAcabamento faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarConquilha faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarCorFaseP faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarTamFaseP faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarGruccus faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarClfiscal faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarOrigmerc faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarSittricm faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarCodServs faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarTpTrib faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarAliqIPI faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarMvalor faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [METODO-INEXISTENTE] Metodo 'THIS.MontarFiltro()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDPRO.Pagina.Lista.cntMensagem): Top original=32 vs migrado 'lbl_4c_Label10' Top=256 (diff=224px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Top original=171 vs migrado 'cnt_4c_Botoes' Top=28 (diff=143px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Left original=959 vs migrado 'cnt_4c_Botoes' Left=542 (diff=417px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Top original=32 vs migrado 'lbl_4c_Say5' Top=316 (diff=284px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Left original=31 vs migrado 'lbl_4c_Say5' Left=85 (diff=54px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Top original=10 vs migrado 'lbl_4c_Say18' Top=341 (diff=331px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Top original=61 vs migrado 'lbl_4c_Say22' Top=542 (diff=481px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Top original=10 vs migrado 'lbl_4c_Say3' Top=266 (diff=256px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Left original=223 vs migrado 'lbl_4c_Say3' Left=74 (diff=149px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say12' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Top original=10 vs migrado 'lbl_4c_Say12' Top=433 (diff=423px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say12' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Left original=272 vs migrado 'lbl_4c_Say12' Left=124 (diff=148px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblGrupo' (parent: SIGCDPRO.Pagina.Lista.cntFiltros): Top original=18 vs migrado 'lbl_4c_LblGrupo' Top=182 (diff=164px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblGrupo' (parent: SIGCDPRO.Pagina.Lista.cntFiltros): Left original=21 vs migrado 'lbl_4c_LblGrupo' Left=73 (diff=52px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Top original=5 vs migrado 'lbl_4c_Label8' Top=281 (diff=276px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Left original=8 vs migrado 'lbl_4c_Label8' Left=72 (diff=64px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=379 vs migrado 'lbl_4c_Say3' Top=266 (diff=113px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=546 vs migrado 'lbl_4c_Say3' Left=74 (diff=472px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=400 vs migrado 'lbl_4c_Say41' Top=290 (diff=110px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=505 vs migrado 'lbl_4c_Say41' Left=558 (diff=53px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say6' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=422 vs migrado 'lbl_4c_Say6' Top=291 (diff=131px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say6' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=539 vs migrado 'lbl_4c_Say6' Left=48 (diff=491px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=134 vs migrado 'lbl_4c_Label2' Top=331 (diff=197px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=451 vs migrado 'lbl_4c_Label10' Top=256 (diff=195px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=967 vs migrado 'lbl_4c_Label10' Left=74 (diff=893px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=451 vs migrado 'lbl_4c_Label9' Top=231 (diff=220px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=884 vs migrado 'lbl_4c_Label9' Left=58 (diff=826px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say11' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=278 vs migrado 'lbl_4c_Say11' Top=433 (diff=155px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say11' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=47 vs migrado 'lbl_4c_Say11' Left=494 (diff=447px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say12' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=301 vs migrado 'lbl_4c_Say12' Top=433 (diff=132px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say12' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=23 vs migrado 'lbl_4c_Say12' Left=124 (diff=101px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say15' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=157 vs migrado 'lbl_4c_Say15' Top=458 (diff=301px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say15' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=590 vs migrado 'lbl_4c_Say15' Left=498 (diff=92px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say16' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=230 vs migrado 'lbl_4c_Say16' Top=165 (diff=65px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say16' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=77 vs migrado 'lbl_4c_Say16' Left=138 (diff=61px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say17' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=253 vs migrado 'lbl_4c_Say17' Top=189 (diff=64px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say17' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=25 vs migrado 'lbl_4c_Say17' Left=138 (diff=113px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say8' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=182 vs migrado 'lbl_4c_Say8' Top=291 (diff=109px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say8' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=73 vs migrado 'lbl_4c_Say8' Left=250 (diff=177px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say9' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=206 vs migrado 'lbl_4c_Say9' Top=320 (diff=114px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say9' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=56 vs migrado 'lbl_4c_Say9' Left=756 (diff=700px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=181 vs migrado 'lbl_4c_Say18' Top=341 (diff=160px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=568 vs migrado 'lbl_4c_Say18' Left=117 (diff=451px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=137 vs migrado 'lbl_4c_Say22' Top=542 (diff=405px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=560 vs migrado 'lbl_4c_Say22' Left=9 (diff=551px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say10' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=158 vs migrado 'lbl_4c_Say10' Top=483 (diff=325px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say10' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=55 vs migrado 'lbl_4c_Say10' Left=147 (diff=92px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say14' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=398 vs migrado 'lbl_4c_Say14' Top=542 (diff=144px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say14' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=41 vs migrado 'lbl_4c_Say14' Left=360 (diff=319px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say13' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=203 vs migrado 'lbl_4c_Say13' Top=316 (diff=113px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say13' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=553 vs migrado 'lbl_4c_Say13' Left=495 (diff=58px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=374 vs migrado 'lbl_4c_Say5' Top=316 (diff=58px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=364 vs migrado 'lbl_4c_Say5' Left=85 (diff=279px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say18' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=398 vs migrado 'lbl_4c_Say18' Top=341 (diff=57px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say18' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=301 vs migrado 'lbl_4c_Say18' Left=117 (diff=184px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say24' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=384 vs migrado 'lbl_4c_Say24' Top=542 (diff=158px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say24' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=833 vs migrado 'lbl_4c_Say24' Left=324 (diff=509px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say25' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=384 vs migrado 'lbl_4c_Say25' Top=581 (diff=197px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say25' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=914 vs migrado 'lbl_4c_Say25' Left=678 (diff=236px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=269 vs migrado 'lbl_4c_Say7' Top=523 (diff=254px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=558 vs migrado 'lbl_4c_Say7' Left=25 (diff=533px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say31' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=448 vs migrado 'lbl_4c_Say31' Top=144 (diff=304px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say31' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=23 vs migrado 'lbl_4c_Say31' Left=583 (diff=560px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say41' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=502 vs migrado 'lbl_4c_Say41' Top=290 (diff=212px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say41' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=775 vs migrado 'lbl_4c_Say41' Left=558 (diff=217px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say42' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=323 vs migrado 'lbl_4c_Say42' Left=609 (diff=286px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say22' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=247 vs migrado 'lbl_4c_Say22' Top=542 (diff=295px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say22' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=529 vs migrado 'lbl_4c_Say22' Left=9 (diff=520px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say6' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=581 vs migrado 'lbl_4c_Say6' Top=291 (diff=290px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say6' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=10 vs migrado 'lbl_4c_Say6' Left=48 (diff=38px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say8' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=542 vs migrado 'lbl_4c_Say8' Top=291 (diff=251px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say8' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=161 vs migrado 'lbl_4c_Say8' Left=250 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=473 vs migrado 'lbl_4c_Say18' Top=341 (diff=132px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=47 vs migrado 'lbl_4c_Say18' Left=117 (diff=70px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=474 vs migrado 'lbl_4c_Say22' Top=542 (diff=68px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=361 vs migrado 'lbl_4c_Say22' Left=9 (diff=352px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say13' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=542 vs migrado 'lbl_4c_Say13' Top=316 (diff=226px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say13' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=416 vs migrado 'lbl_4c_Say13' Left=495 (diff=79px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say12' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=542 vs migrado 'lbl_4c_Say12' Top=433 (diff=109px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say12' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=563 vs migrado 'lbl_4c_Say12' Left=124 (diff=439px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say15' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=324 vs migrado 'lbl_4c_Say15' Top=458 (diff=134px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say15' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=421 vs migrado 'lbl_4c_Say15' Left=498 (diff=77px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say16' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=324 vs migrado 'lbl_4c_Say16' Top=165 (diff=159px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say16' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=45 vs migrado 'lbl_4c_Say16' Left=138 (diff=93px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=435 vs migrado 'lbl_4c_Say3' Top=266 (diff=169px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=39 vs migrado 'lbl_4c_Say3' Left=74 (diff=35px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=435 vs migrado 'lbl_4c_Say5' Top=316 (diff=119px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=465 vs migrado 'lbl_4c_Say5' Left=85 (diff=380px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=36 vs migrado 'lbl_4c_Say41' Left=558 (diff=522px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=581 vs migrado 'lbl_4c_Say7' Top=523 (diff=58px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=161 vs migrado 'lbl_4c_Say7' Left=25 (diff=136px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Top original=216 vs migrado 'lbl_4c_Say18' Top=341 (diff=125px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Top original=241 vs migrado 'lbl_4c_Say22' Top=542 (diff=301px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Left original=87 vs migrado 'lbl_4c_Say22' Left=9 (diff=78px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Top original=458 vs migrado 'lbl_4c_Say7' Top=523 (diff=65px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Left original=122 vs migrado 'lbl_4c_Say7' Left=25 (diff=97px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Left original=395 vs migrado 'lbl_4c_Say41' Left=558 (diff=163px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Top original=474 vs migrado 'lbl_4c_Say18' Top=341 (diff=133px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Left original=527 vs migrado 'lbl_4c_Say18' Left=117 (diff=410px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say13' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Top original=156 vs migrado 'lbl_4c_Say13' Top=316 (diff=160px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say13' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Left original=33 vs migrado 'lbl_4c_Say13' Left=495 (diff=462px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Top original=306 vs migrado 'lbl_4c_Say7' Top=523 (diff=217px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Left original=72 vs migrado 'lbl_4c_Say7' Left=25 (diff=47px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Top original=331 vs migrado 'lbl_4c_Say22' Top=542 (diff=211px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Left original=45 vs migrado 'lbl_4c_Say22' Left=9 (diff=36px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say8' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Left original=72 vs migrado 'lbl_4c_Say8' Left=250 (diff=178px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say9' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Top original=231 vs migrado 'lbl_4c_Say9' Top=320 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say9' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Left original=58 vs migrado 'lbl_4c_Say9' Left=756 (diff=698px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Top original=181 vs migrado 'lbl_4c_Say5' Top=316 (diff=135px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say10' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Top original=256 vs migrado 'lbl_4c_Say10' Top=483 (diff=227px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say10' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Left original=74 vs migrado 'lbl_4c_Say10' Left=147 (diff=73px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Top original=206 vs migrado 'lbl_4c_Say41' Top=290 (diff=84px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Left original=79 vs migrado 'lbl_4c_Say41' Left=558 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP): Top original=521 vs migrado 'lbl_4c_Say18' Top=341 (diff=180px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP): Left original=642 vs migrado 'lbl_4c_Say18' Left=117 (diff=525px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say16' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto): Top original=415 vs migrado 'lbl_4c_Say16' Top=165 (diff=250px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say16' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto): Left original=52 vs migrado 'lbl_4c_Say16' Left=138 (diff=86px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto): Top original=159 vs migrado 'lbl_4c_Say18' Top=341 (diff=182px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto): Top original=415 vs migrado 'lbl_4c_Say22' Top=542 (diff=127px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto): Left original=479 vs migrado 'lbl_4c_Say22' Left=9 (diff=470px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto): Top original=445 vs migrado 'lbl_4c_Say3' Top=266 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto): Left original=35 vs migrado 'lbl_4c_Say3' Left=74 (diff=39px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (11493 linhas total):

*-- Linhas 29 a 163:
29:     this_cMensagemErro    = ""    && OBRIGATORIO - nao herdado de FormBase
30: 
31:     *-- Guardas para evitar revalidacao desnecessaria em LostFocus
32:     this_cUltimoConquilhaValidado  = ""
33:     this_cUltimoCorValidado        = ""
34:     this_cUltimoTamValidado        = ""
35:     this_cUltimoAcabamentoValidado = ""
36: 
37:     *--------------------------------------------------------------------------
38:     * Init - Inicializacao do formulario
39:     *--------------------------------------------------------------------------
40:     PROCEDURE Init()
41:         *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
42:         RETURN DODEFAULT()
43:     ENDPROC
44: 
45:     *--------------------------------------------------------------------------
46:     * InicializarForm - Configuracao inicial do formulario
47:     *--------------------------------------------------------------------------
48:     PROTECTED PROCEDURE InicializarForm()
49:         LOCAL loc_lSucesso
50:         loc_lSucesso = .F.
51: 
52:         TRY
53:             *-- Criar instancia do Business Object
54:             THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")
55: 
56:             IF ISNULL(THIS.this_oBusinessObject)
57:                 MostrarErro("Erro ao criar Business Object ProdutoBO", "Erro Cr" + CHR(237) + "tico")
58:             ELSE
59:                 THIS.ConfigurarPageFrame()
60:                 THIS.ConfigurarPaginaLista()
61:                 THIS.ConfigurarPaginaDados()
62:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
63: 
64:                 *-- Pula CarregarLista() se estiver validando UI (sem conexao SQL)
65:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
66:                     IF !THIS.CarregarLista()
67:                         *-- Se falhar ao carregar, nao impede abertura
68:                     ENDIF
69:                 ENDIF
70: 
71:                 THIS.AjustarBotoesPorModo()
72:                 THIS.pgf_4c_Paginas.Visible = .T.
73:                 THIS.pgf_4c_Paginas.ActivePage = 1
74:                 THIS.this_cModoAtual = "LISTA"
75:                 loc_lSucesso = .T.
76:             ENDIF
77: 
78:         CATCH TO loc_oErro
79:             MostrarErro("Erro ao inicializar FormProduto:" + CHR(13) + ;
80:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
81:                 loc_oErro.Message, "Erro")
82:             loc_lSucesso = .F.
83:         ENDTRY
84: 
85:         RETURN loc_lSucesso
86:     ENDPROC
87: 
88:     *--------------------------------------------------------------------------
89:     * ConfigurarPageFrame - Configura o PageFrame principal
90:     * Legado: Pagina Top=-29 (oculta abas), Width=1003, Height=631
91:     * Compensacao +29 aplicada em controles das Pages
92:     *--------------------------------------------------------------------------
93:     PROTECTED PROCEDURE ConfigurarPageFrame()
94:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
95: 
96:         WITH THIS.pgf_4c_Paginas
97:             .Top       = -29
98:             .Left      = 0
99:             .Width     = 1003
100:             .Height    = 631
101:             .PageCount = 2
102:             .Tabs      = .F.
103:             .Visible   = .T.
104: 
105:             *-- Page1 - Lista
106:             .Page1.Caption  = "Lista"
107:             .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
108:             .Page1.BackColor = RGB(255, 255, 255)
109: 
110:             *-- Page2 - Dados
111:             .Page2.Caption  = "Dados"
112:             .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113:             .Page2.BackColor = RGB(255, 255, 255)
114:         ENDWITH
115:     ENDPROC
116: 
117:     *--------------------------------------------------------------------------
118:     * ConfigurarPaginaLista - Configura Page1 (Lista)
119:     * Top original = -1 dos grupos -> compensado para 28 (+29)
120:     * Grade: Top=173, Left=38, Width=922, Height=409 (7 colunas)
121:     * cntFiltros: Top=82, Left=0, Width=383, Height=87
122:     *--------------------------------------------------------------------------
123:     PROTECTED PROCEDURE ConfigurarPaginaLista()
124:         LOCAL loc_oPagina, loc_oGrade
125:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
126: 
127:         *-- Container de cabecalho (cntSombra: Top=1+29=30, Width=1000, Height=80)
128:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
129:         WITH loc_oPagina.cnt_4c_Cabecalho
130:             .Top         = 30
131:             .Left        = 0
132:             .Width       = 1000
133:             .Height      = 80
134:             .BackStyle   = 1
135:             .BackColor   = RGB(53, 53, 53)
136:             .BorderWidth = 0
137:             .Visible     = .T.
138:         ENDWITH
139: 
140:         *-- Label titulo no cabecalho
141:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
142:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
143:             .Caption   = "Cadastro de Produtos"
144:             .Top       = 20
145:             .Left      = 20
146:             .Width     = 400
147:             .Height    = 30
148:             .FontName  = "Tahoma"
149:             .FontSize  = 14
150:             .FontBold  = .T.
151:             .BackStyle = 0
152:             .ForeColor = RGB(255, 255, 255)
153:             .Visible   = .T.
154:         ENDWITH
155: 
156:         *-- Container de filtros (cntFiltros: Top=82+29=111, Left=0, W=383, H=87)
157:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
158:         WITH loc_oPagina.cnt_4c_Filtros
159:             .Top         = 111
160:             .Left        = 0
161:             .Width       = 383
162:             .Height      = 87
163:             .BackStyle   = 0

*-- Linhas 193 a 236:
193:             .Themes   = .F.
194:             .Visible  = .T.
195:         ENDWITH
196:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_FilCgru, "KeyPress", THIS, "TxtFilCgruKeyPress")
197: 
198:         *-- TextBox Dgru (getDgru: Top=14, Left=149, W=156, H=23)
199:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FilDgru", "TextBox")
200:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FilDgru
201:             .Value    = ""
202:             .Top      = 14
203:             .Left     = 149
204:             .Width    = 156
205:             .Height   = 23
206:             .FontName = "Tahoma"
207:             .FontSize = 8
208:             .Themes   = .F.
209:             .ReadOnly = .T.
210:             .Visible  = .T.
211:         ENDWITH
212: 
213:         *-- Label Ultima Alteracao
214:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData1", "Label")
215:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData1
216:             .Caption   = CHR(218) + "ltima Altera" + CHR(231) + CHR(227) + "o :"
217:             .Top       = 43
218:             .Left      = 28
219:             .Width     = 87
220:             .Height    = 15
221:             .BackStyle = 0
222:             .ForeColor = RGB(90, 90, 90)
223:             .FontName  = "Tahoma"
224:             .FontSize  = 8
225:             .Visible   = .T.
226:         ENDWITH
227: 
228:         *-- TextBox DtIni (getDtIni: Top=39, Left=116, H=23)
229:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FilDtIni", "TextBox")
230:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FilDtIni
231:             .Value       = {}
232:             .Top         = 39
233:             .Left        = 116
234:             .Width       = 85
235:             .Height      = 23
236:             .FontName    = "Tahoma"

*-- Linhas 270 a 501:
270:             .Visible     = .T.
271:         ENDWITH
272: 
273:         *-- OptionGroup Situacao (optFilSituas: Top=19, Left=303, W=78, H=46, ButtonCount=3)
274:         loc_oPagina.cnt_4c_Filtros.AddObject("obj_4c_OptFilSituas", "OptionGroup")
275:         WITH loc_oPagina.cnt_4c_Filtros.obj_4c_OptFilSituas
276:             .ButtonCount = 3
277:             .Top         = 19
278:             .Left        = 303
279:             .Width       = 78
280:             .Height      = 46
281:             .BorderStyle = 0
282:             .Visible     = .T.
283:         ENDWITH
284:         WITH loc_oPagina.cnt_4c_Filtros.obj_4c_OptFilSituas.Buttons(1)
285:             .Caption  = "Todos"
286:             .Top      = 2
287:             .Left     = 2
288:             .AutoSize = .T.
289:             .FontName = "Tahoma"
290:             .FontSize = 8
291:             .Themes   = .F.
292:             .Value    = 1
293:             .Visible  = .T.
294:         ENDWITH
295:         WITH loc_oPagina.cnt_4c_Filtros.obj_4c_OptFilSituas.Buttons(2)
296:             .Caption  = "Ativo"
297:             .Top      = 16
298:             .Left     = 2
299:             .AutoSize = .T.
300:             .FontName = "Tahoma"
301:             .FontSize = 8
302:             .Themes   = .F.
303:             .Visible  = .T.
304:         ENDWITH
305:         WITH loc_oPagina.cnt_4c_Filtros.obj_4c_OptFilSituas.Buttons(3)
306:             .Caption  = "Inativo"
307:             .Top      = 30
308:             .Left     = 2
309:             .AutoSize = .T.
310:             .FontName = "Tahoma"
311:             .FontSize = 8
312:             .Themes   = .F.
313:             .Visible  = .T.
314:         ENDWITH
315:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.obj_4c_OptFilSituas, "InteractiveChange", THIS, "FiltroSituacaoChange")
316: 
317:         *-- Container de botoes CRUD (Grupo_op: Left=542, Top=-1+29=28)
318:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
319:         WITH loc_oPagina.cnt_4c_Botoes
320:             .Top         = 28
321:             .Left        = 542
322:             .Width       = 400
323:             .Height      = 85
324:             .BackStyle = 1
325:             .BackColor = RGB(53, 53, 53)
326:             .BorderWidth = 0
327:             .Visible     = .T.
328:         ENDWITH
329: 
330:         *-- Botao Incluir (Inserir: Left=5)
331:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
332:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
333:             .Caption         = "Incluir"
334:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
335:             .PicturePosition = 13
336:             .Width           = 75
337:             .Height          = 75
338:             .Left            = 5
339:             .Top             = 5
340:             .FontName        = "Tahoma"
341:             .FontSize        = 8
342:             .Themes          = .F.
343:             .SpecialEffect   = 0
344:             .BackColor       = RGB(255, 255, 255)
345:             .ForeColor       = RGB(90, 90, 90)
346:             .Visible         = .T.
347:         ENDWITH
348:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
349: 
350:         *-- Botao Visualizar (Consultar: Left=80)
351:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
352:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
353:             .Caption         = "Visualizar"
354:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
355:             .PicturePosition = 13
356:             .Width           = 75
357:             .Height          = 75
358:             .Left            = 80
359:             .Top             = 5
360:             .FontName        = "Tahoma"
361:             .FontSize        = 8
362:             .Themes          = .F.
363:             .SpecialEffect   = 0
364:             .BackColor       = RGB(255, 255, 255)
365:             .ForeColor       = RGB(90, 90, 90)
366:             .Visible         = .T.
367:         ENDWITH
368:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
369: 
370:         *-- Botao Alterar (Left=155)
371:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
372:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
373:             .Caption         = "Alterar"
374:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
375:             .PicturePosition = 13
376:             .Width           = 75
377:             .Height          = 75
378:             .Left            = 155
379:             .Top             = 5
380:             .FontName        = "Tahoma"
381:             .FontSize        = 8
382:             .Themes          = .F.
383:             .SpecialEffect   = 0
384:             .BackColor       = RGB(255, 255, 255)
385:             .ForeColor       = RGB(90, 90, 90)
386:             .Visible         = .T.
387:         ENDWITH
388:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
389: 
390:         *-- Botao Excluir (Left=230)
391:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
392:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
393:             .Caption         = "Excluir"
394:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
395:             .PicturePosition = 13
396:             .Width           = 75
397:             .Height          = 75
398:             .Left            = 230
399:             .Top             = 5
400:             .FontName        = "Tahoma"
401:             .FontSize        = 8
402:             .Themes          = .F.
403:             .SpecialEffect   = 0
404:             .BackColor       = RGB(255, 255, 255)
405:             .ForeColor       = RGB(90, 90, 90)
406:             .Visible         = .T.
407:         ENDWITH
408:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
409: 
410:         *-- Botao Procurar (Left=305)
411:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Procurar", "CommandButton")
412:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Procurar
413:             .Caption         = "Procurar"
414:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
415:             .PicturePosition = 13
416:             .Width           = 75
417:             .Height          = 75
418:             .Left            = 305
419:             .Top             = 5
420:             .FontName        = "Tahoma"
421:             .FontSize        = 8
422:             .Themes          = .F.
423:             .SpecialEffect   = 0
424:             .BackColor       = RGB(255, 255, 255)
425:             .ForeColor       = RGB(90, 90, 90)
426:             .Visible         = .T.
427:         ENDWITH
428:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Procurar, "Click", THIS, "BtnProcurarClick")
429: 
430:         *-- Container Sair (Grupo_Saida: Left=917, Top=-1+29=28)
431:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
432:         WITH loc_oPagina.cnt_4c_Saida
433:             .Top         = 28
434:             .Left        = 917
435:             .Width       = 80
436:             .Height      = 85
437:             .BackStyle = 1
438:             .BackColor = RGB(53, 53, 53)
439:             .BorderWidth = 0
440:             .Visible     = .T.
441:         ENDWITH
442: 
443:         *-- Botao Sair (Sair: Left=5)
444:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Sair", "CommandButton")
445:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Sair
446:             .Caption         = "Sair"
447:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
448:             .PicturePosition = 13
449:             .Width           = 75
450:             .Height          = 75
451:             .Left            = 5
452:             .Top             = 5
453:             .FontName        = "Tahoma"
454:             .FontSize        = 8
455:             .Themes          = .F.
456:             .SpecialEffect   = 0
457:             .BackColor       = RGB(255, 255, 255)
458:             .ForeColor       = RGB(90, 90, 90)
459:             .Visible         = .T.
460:         ENDWITH
461:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
462: 
463:         *-- Grade principal (Grade: Left=38, Top=173+29=202, W=922, H=409, 7 colunas)
464:         *-- IMPORTANTE: RecordMark=.F., DeleteMark=.F.
465:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
466:         loc_oGrade = loc_oPagina.grd_4c_Dados
467:         WITH loc_oGrade
468:             .Top           = 202
469:             .Left          = 38
470:             .Width         = 922
471:             .Height        = 409
472:             .FontName      = "Arial"
473:             .FontSize      = 8
474:             .RecordMark    = .F.
475:             .DeleteMark    = .F.
476:             .GridLines     = 3
477:             .ReadOnly      = .T.
478:             .Themes        = .F.
479:             .ColumnCount   = 7
480:             .Visible       = .T.
481:         ENDWITH
482: 
483:         *-- Configurar colunas APOS ColumnCount (cabecalhos serao re-aplicados pos RecordSource)
484:         WITH loc_oGrade.Column1
485:             .Width     = 110
486:             .Movable   = .F.
487:             .Resizable = .F.
488:             .ReadOnly  = .T.
489:         ENDWITH
490:         WITH loc_oGrade.Column2
491:             .Width     = 408
492:             .Movable   = .F.
493:             .Resizable = .F.
494:             .ReadOnly  = .T.
495:         ENDWITH
496:         WITH loc_oGrade.Column3
497:             .Width     = 40
498:             .Movable   = .F.
499:             .Resizable = .F.
500:             .ReadOnly  = .T.
501:         ENDWITH

*-- Linhas 546 a 743:
546:             .Visible   = .T.
547:         ENDWITH
548: 
549:         THIS.TornarControlesVisiveis(loc_oPagina)
550:     ENDPROC
551: 
552:     *--------------------------------------------------------------------------
553:     * ConfigurarPaginaDados - Configura Page2 (Dados)
554:     * Estrutura: botoes Salvar/Cancelar + PageFrame interno (7 abas)
555:     * Grupo_Salva: Left=842, Top=5+29=34, H=85
556:     * pgframeDados: Top=-54+29=-25, Left=-1, W=1003, H=656, 7 paginas
557:     *--------------------------------------------------------------------------
558:     PROTECTED PROCEDURE ConfigurarPaginaDados()
559:         LOCAL loc_oPagina, loc_oPgf
560:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
561: 
562:         *-- Container de botoes Salvar/Cancelar (Grupo_Salva)
563:         loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
564:         WITH loc_oPagina.cnt_4c_BotoesDados
565:             .Top         = 34
566:             .Left        = 842
567:             .Width       = 155
568:             .Height      = 85
569:             .BackStyle = 1
570:             .BackColor = RGB(53, 53, 53)
571:             .BorderWidth = 0
572:             .Visible     = .T.
573:         ENDWITH
574: 
575:         *-- Botao Salvar (Salva: Left=5)
576:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
577:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
578:             .Caption         = "Salvar"
579:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
580:             .PicturePosition = 13
581:             .Width           = 75
582:             .Height          = 75
583:             .Left            = 5
584:             .Top             = 5
585:             .FontName        = "Tahoma"
586:             .FontSize        = 8
587:             .Themes          = .F.
588:             .SpecialEffect   = 0
589:             .BackColor       = RGB(255, 255, 255)
590:             .ForeColor       = RGB(90, 90, 90)
591:             .Visible         = .T.
592:         ENDWITH
593:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
594: 
595:         *-- Botao Cancelar (Cancelar: Left=80)
596:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
597:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
598:             .Caption         = "Cancelar"
599:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
600:             .PicturePosition = 13
601:             .Width           = 75
602:             .Height          = 75
603:             .Left            = 80
604:             .Top             = 5
605:             .FontName        = "Tahoma"
606:             .FontSize        = 8
607:             .Themes          = .F.
608:             .SpecialEffect   = 0
609:             .BackColor       = RGB(255, 255, 255)
610:             .ForeColor       = RGB(90, 90, 90)
611:             .Visible         = .T.
612:         ENDWITH
613:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
614: 
615:         *-- PageFrame interno (pgframeDados: Top=-54+29=-25, Left=-1, W=1003, H=656, 7 pags)
616:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
617:         loc_oPgf = loc_oPagina.pgf_4c_Dados
618:         WITH loc_oPgf
619:             .Top       = -25
620:             .Left      = -1
621:             .Width     = 1003
622:             .Height    = 656
623:             .PageCount = 7
624:             .Tabs      = .F.
625:             .Visible   = .T.
626:         ENDWITH
627: 
628:         *-- Configurar abas do PageFrame interno
629:         WITH loc_oPgf
630:             .Page1.Caption = "Dados"
631:             .Page2.Caption = "Composi" + CHR(231) + CHR(227) + "o"
632:             .Page3.Caption = "Dados Fiscais"
633:             .Page4.Caption = "Fases P."
634:             .Page5.Caption = "Cons. P."
635:             .Page6.Caption = "Custo"
636:             .Page7.Caption = "Designer"
637:         ENDWITH
638: 
639:         *-- Configurar pgDados (Page1 do PageFrame interno)
640:         THIS.ConfigurarPaginaDadosPrincipal(loc_oPgf.Page1)
641: 
642:         *-- Configurar pgComposicao (Page2 do PageFrame interno)
643:         THIS.ConfigurarPgpgComposicao(loc_oPgf.Page2)
644: 
645:         *-- Configurar pgCusto (Page6 do PageFrame interno)
646:         THIS.ConfigurarPgpgCusto(loc_oPgf.Page6)
647: 
648:         *-- Configurar PgDadosFaseP (Page4 do PageFrame interno)
649:         THIS.ConfigurarPgPgDadosFaseP(loc_oPgf.Page4)
650: 
651:         *-- Configurar PgDadosConsP (Page5 do PageFrame interno)
652:         THIS.ConfigurarPgPgDadosConsP(loc_oPgf.Page5)
653: 
654:         *-- Configurar pgDadosFiscais (Page3 do PageFrame interno)
655:         THIS.ConfigurarPgpgDadosFiscais(loc_oPgf.Page3)
656: 
657:         *-- Configurar pgDesigner (Page7 do PageFrame interno)
658:         THIS.ConfigurarPgpgDesigner(loc_oPgf.Page7)
659: 
660:         THIS.TornarControlesVisiveis(loc_oPagina)
661:     ENDPROC
662: 
663:     *--------------------------------------------------------------------------
664:     * ConfigurarPaginaDadosPrincipal - Aba "Dados" do PageFrame interno (pgDados)
665:     * Fase 5: Campos principais parte 1 (50%)
666:     * Posicoes = valores ORIGINAIS do layout.json (pgf_4c_Dados.Tabs=.F. -> sem +29)
667:     * Colunas SigCdPro: cpros, dpros, dpro2s, cgrus, cods, cbars, clins, ccols, ifors, reffs
668:     *--------------------------------------------------------------------------
669:     PROTECTED PROCEDURE ConfigurarPaginaDadosPrincipal(par_oPage)
670:         LOCAL loc_oPg
671:         loc_oPg = par_oPage
672: 
673:         *-- ===================================================================
674:         *-- LINHA 1 (top=130): getCpro + getDpro
675:         *-- ===================================================================
676:         loc_oPg.AddObject("lbl_4c_LblProduto", "Label")
677:         WITH loc_oPg.lbl_4c_LblProduto
678:             .Caption   = "Produto :"
679:             .Top       = 134
680:             .Left      = 58
681:             .Width     = 53
682:             .Height    = 15
683:             .BackStyle = 0
684:             .ForeColor = RGB(90, 90, 90)
685:             .FontName  = "Tahoma"
686:             .FontSize  = 8
687:             .Visible   = .T.
688:         ENDWITH
689: 
690:         *-- TextBox getCpro (cpros: Top=130, Left=113, W=108, H=23)
691:         loc_oPg.AddObject("txt_4c_Cpros", "TextBox")
692:         WITH loc_oPg.txt_4c_Cpros
693:             .Value    = ""
694:             .Top      = 130
695:             .Left     = 113
696:             .Width    = 108
697:             .Height   = 23
698:             .FontName = "Tahoma"
699:             .FontSize = 8
700:             .Themes   = .F.
701:             .Visible  = .T.
702:         ENDWITH
703:         BINDEVENT(loc_oPg.txt_4c_Cpros, "KeyPress", THIS, "TxtCprosKeyPress")
704: 
705:         *-- TextBox getDpro (dpros: Top=130, Left=222, W=290, H=23 - READ ONLY)
706:         loc_oPg.AddObject("txt_4c_Dpros", "TextBox")
707:         WITH loc_oPg.txt_4c_Dpros
708:             .Value     = ""
709:             .Top       = 130
710:             .Left      = 222
711:             .Width     = 290
712:             .Height    = 23
713:             .FontName  = "Tahoma"
714:             .FontSize  = 8
715:             .ReadOnly  = .T.
716:             .BackColor = RGB(224, 235, 235)
717:             .Themes    = .F.
718:             .Visible   = .T.
719:         ENDWITH
720: 
721:         *-- ===================================================================
722:         *-- LINHA 2 (top=154): getDPro2s | getCbar (right, top=155)
723:         *-- ===================================================================
724: 
725:         *-- TextBox getDPro2s (dpro2s: Top=154, Left=113, W=399, H=23 - segunda descricao)
726:         loc_oPg.AddObject("txt_4c_DPro2s", "TextBox")
727:         WITH loc_oPg.txt_4c_DPro2s
728:             .Value    = ""
729:             .Top      = 154
730:             .Left     = 113
731:             .Width    = 399
732:             .Height   = 23
733:             .FontName = "Tahoma"
734:             .FontSize = 8
735:             .Themes   = .F.
736:             .Visible  = .T.
737:         ENDWITH
738: 
739:         *-- Label Barra
740:         loc_oPg.AddObject("lbl_4c_LblCbar", "Label")
741:         WITH loc_oPg.lbl_4c_LblCbar
742:             .Caption   = "Barra :"
743:             .Top       = 159

*-- Linhas 795 a 838:
795:             .Themes   = .F.
796:             .Visible  = .T.
797:         ENDWITH
798:         BINDEVENT(loc_oPg.txt_4c_Cgrus, "KeyPress", THIS, "TxtCgrusKeyPress")
799: 
800:         *-- TextBox getDgru display (dgrus: Top=178, Left=145, W=171, H=23 - READ ONLY)
801:         loc_oPg.AddObject("txt_4c_DgruDisplay", "TextBox")
802:         WITH loc_oPg.txt_4c_DgruDisplay
803:             .Value     = ""
804:             .Top       = 178
805:             .Left      = 145
806:             .Width     = 171
807:             .Height    = 23
808:             .FontName  = "Tahoma"
809:             .FontSize  = 8
810:             .ReadOnly  = .T.
811:             .BackColor = RGB(224, 235, 235)
812:             .Themes    = .F.
813:             .Visible   = .T.
814:         ENDWITH
815: 
816:         *-- ===================================================================
817:         *-- LINHA 4 (top=202): GetCSGru + GetDsGru
818:         *-- ===================================================================
819:         loc_oPg.AddObject("lbl_4c_LblSubgrupo", "Label")
820:         WITH loc_oPg.lbl_4c_LblSubgrupo
821:             .Caption   = "Subgrupo :"
822:             .Top       = 206
823:             .Left      = 56
824:             .Width     = 55
825:             .Height    = 15
826:             .BackStyle = 0
827:             .ForeColor = RGB(90, 90, 90)
828:             .FontName  = "Tahoma"
829:             .FontSize  = 8
830:             .Visible   = .T.
831:         ENDWITH
832: 
833:         *-- TextBox GetCSGru (cods: Top=202, Left=113, W=52, H=23)
834:         loc_oPg.AddObject("txt_4c_Cods", "TextBox")
835:         WITH loc_oPg.txt_4c_Cods
836:             .Value    = ""
837:             .Top      = 202
838:             .Left     = 113

*-- Linhas 890 a 1029:
890:             .Themes   = .F.
891:             .Visible  = .T.
892:         ENDWITH
893:         BINDEVENT(loc_oPg.txt_4c_Lin, "KeyPress", THIS, "TxtLinKeyPress")
894: 
895:         *-- TextBox GetDLin display (dlins: Top=226, Left=194, W=318, H=23 - READ ONLY)
896:         loc_oPg.AddObject("txt_4c_DLinDisplay", "TextBox")
897:         WITH loc_oPg.txt_4c_DLinDisplay
898:             .Value     = ""
899:             .Top       = 226
900:             .Left      = 194
901:             .Width     = 318
902:             .Height    = 23
903:             .FontName  = "Tahoma"
904:             .FontSize  = 8
905:             .ReadOnly  = .T.
906:             .BackColor = RGB(224, 235, 235)
907:             .Themes    = .F.
908:             .Visible   = .T.
909:         ENDWITH
910: 
911:         *-- ===================================================================
912:         *-- LINHA 6 (top=250): GetCol + GetDCol (Grupo de Venda / SigCdCol)
913:         *-- ===================================================================
914:         loc_oPg.AddObject("lbl_4c_LblCol", "Label")
915:         WITH loc_oPg.lbl_4c_LblCol
916:             .Caption   = "Grupo Venda :"
917:             .Top       = 254
918:             .Left      = 42
919:             .Width     = 69
920:             .Height    = 15
921:             .BackStyle = 0
922:             .ForeColor = RGB(90, 90, 90)
923:             .FontName  = "Tahoma"
924:             .FontSize  = 8
925:             .Visible   = .T.
926:         ENDWITH
927: 
928:         *-- TextBox GetCol (ccols: Top=250, Left=113, W=80, H=23)
929:         loc_oPg.AddObject("txt_4c_Col", "TextBox")
930:         WITH loc_oPg.txt_4c_Col
931:             .Value    = ""
932:             .Top      = 250
933:             .Left     = 113
934:             .Width    = 80
935:             .Height   = 23
936:             .FontName = "Tahoma"
937:             .FontSize = 8
938:             .Themes   = .F.
939:             .Visible  = .T.
940:         ENDWITH
941:         BINDEVENT(loc_oPg.txt_4c_Col, "KeyPress", THIS, "TxtColKeyPress")
942: 
943:         *-- TextBox GetDCol display (dcols: Top=250, Left=194, W=318, H=23 - READ ONLY)
944:         loc_oPg.AddObject("txt_4c_DColDisplay", "TextBox")
945:         WITH loc_oPg.txt_4c_DColDisplay
946:             .Value     = ""
947:             .Top       = 250
948:             .Left      = 194
949:             .Width     = 318
950:             .Height    = 23
951:             .FontName  = "Tahoma"
952:             .FontSize  = 8
953:             .ReadOnly  = .T.
954:             .BackColor = RGB(224, 235, 235)
955:             .Themes    = .F.
956:             .Visible   = .T.
957:         ENDWITH
958: 
959:         *-- ===================================================================
960:         *-- LINHA 7 (top=274): getIfor + getDfor (Fornecedor)
961:         *-- ===================================================================
962:         loc_oPg.AddObject("lbl_4c_LblIfor", "Label")
963:         WITH loc_oPg.lbl_4c_LblIfor
964:             .Caption   = "Fornecedor :"
965:             .Top       = 278
966:             .Left      = 44
967:             .Width     = 67
968:             .Height    = 15
969:             .BackStyle = 0
970:             .ForeColor = RGB(90, 90, 90)
971:             .FontName  = "Tahoma"
972:             .FontSize  = 8
973:             .Visible   = .T.
974:         ENDWITH
975: 
976:         *-- TextBox getIfor (ifors: Top=274, Left=113, W=80, H=23)
977:         loc_oPg.AddObject("txt_4c_Ifor", "TextBox")
978:         WITH loc_oPg.txt_4c_Ifor
979:             .Value    = ""
980:             .Top      = 274
981:             .Left     = 113
982:             .Width    = 80
983:             .Height   = 23
984:             .FontName = "Tahoma"
985:             .FontSize = 8
986:             .Themes   = .F.
987:             .Visible  = .T.
988:         ENDWITH
989:         BINDEVENT(loc_oPg.txt_4c_Ifor, "KeyPress", THIS, "TxtIforKeyPress")
990: 
991:         *-- TextBox getDfor display (nome fornecedor: Top=274, Left=194, W=318, H=23 - READ ONLY)
992:         loc_oPg.AddObject("txt_4c_DforDisplay", "TextBox")
993:         WITH loc_oPg.txt_4c_DforDisplay
994:             .Value     = ""
995:             .Top       = 274
996:             .Left      = 194
997:             .Width     = 318
998:             .Height    = 23
999:             .FontName  = "Tahoma"
1000:             .FontSize  = 8
1001:             .ReadOnly  = .T.
1002:             .BackColor = RGB(224, 235, 235)
1003:             .Themes    = .F.
1004:             .Visible   = .T.
1005:         ENDWITH
1006: 
1007:         *-- ===================================================================
1008:         *-- LINHA 8 (top=298): getRefs (Referencia do Fornecedor)
1009:         *-- ===================================================================
1010:         loc_oPg.AddObject("lbl_4c_LblRefs", "Label")
1011:         WITH loc_oPg.lbl_4c_LblRefs
1012:             .Caption   = "Ref. Fornecedor :"
1013:             .Top       = 302
1014:             .Left      = 20
1015:             .Width     = 91
1016:             .Height    = 15
1017:             .BackStyle = 0
1018:             .ForeColor = RGB(90, 90, 90)
1019:             .FontName  = "Tahoma"
1020:             .FontSize  = 8
1021:             .Visible   = .T.
1022:         ENDWITH
1023: 
1024:         *-- TextBox getRefs (reffs: Top=298, Left=113, W=152, H=23)
1025:         loc_oPg.AddObject("txt_4c_Refs", "TextBox")
1026:         WITH loc_oPg.txt_4c_Refs
1027:             .Value    = ""
1028:             .Top      = 298
1029:             .Left     = 113

*-- Linhas 1065 a 1139:
1065:             .Themes   = .F.
1066:             .Visible  = .T.
1067:         ENDWITH
1068:         BINDEVENT(loc_oPg.txt_4c_Cor, "KeyPress", THIS, "TxtCorKeyPress")
1069:         BINDEVENT(loc_oPg.txt_4c_Cor, "DblClick", THIS, "AbrirLookupCor")
1070: 
1071:         loc_oPg.AddObject("lbl_4c_LblTam", "Label")
1072:         WITH loc_oPg.lbl_4c_LblTam
1073:             .Caption   = "Tam :"
1074:             .Top       = 302
1075:             .Left      = 445
1076:             .Width     = 27
1077:             .Height    = 15
1078:             .BackStyle = 0
1079:             .ForeColor = RGB(90, 90, 90)
1080:             .FontName  = "Tahoma"
1081:             .FontSize  = 8
1082:             .Visible   = .T.
1083:         ENDWITH
1084: 
1085:         *-- TextBox getTam (codtams: Top=298, Left=474, W=38, H=23)
1086:         loc_oPg.AddObject("txt_4c_Tam", "TextBox")
1087:         WITH loc_oPg.txt_4c_Tam
1088:             .Value    = ""
1089:             .Top      = 298
1090:             .Left     = 474
1091:             .Width    = 38
1092:             .Height   = 23
1093:             .FontName = "Tahoma"
1094:             .FontSize = 8
1095:             .Themes   = .F.
1096:             .Visible  = .T.
1097:         ENDWITH
1098:         BINDEVENT(loc_oPg.txt_4c_Tam, "KeyPress", THIS, "TxtTamKeyPress")
1099:         BINDEVENT(loc_oPg.txt_4c_Tam, "DblClick", THIS, "AbrirLookupTam")
1100: 
1101:         *-- RIGHT SIDE top area: getDtSituas (T:132, L:878)
1102:         loc_oPg.AddObject("lbl_4c_LblDtSitua", "Label")
1103:         WITH loc_oPg.lbl_4c_LblDtSitua
1104:             .Caption   = "Dt.Situa" + CHR(231) + CHR(227) + "o :"
1105:             .Top       = 120
1106:             .Left      = 785
1107:             .Width     = 91
1108:             .Height    = 15
1109:             .BackStyle = 0
1110:             .ForeColor = RGB(90, 90, 90)
1111:             .FontName  = "Tahoma"
1112:             .FontSize  = 8
1113:             .Visible   = .T.
1114:         ENDWITH
1115: 
1116:         *-- TextBox getDtSituas (dtsituas: Top=132, Left=878, W=80, H=21)
1117:         loc_oPg.AddObject("txt_4c_DtSituas", "TextBox")
1118:         WITH loc_oPg.txt_4c_DtSituas
1119:             .Value     = {}
1120:             .Top       = 132
1121:             .Left      = 878
1122:             .Width     = 80
1123:             .Height    = 21
1124:             .FontName  = "Tahoma"
1125:             .FontSize  = 8
1126:             .Format    = "D"
1127:             .ReadOnly  = .T.
1128:             .BackColor = RGB(224, 235, 235)
1129:             .Themes    = .F.
1130:             .Visible   = .T.
1131:         ENDWITH
1132: 
1133:         *-- ===================================================================
1134:         *-- LINHA 9 (top=322): getCodFinP + getDesFinP + getPesoBs
1135:         *-- ===================================================================
1136:         loc_oPg.AddObject("lbl_4c_LblFinP", "Label")
1137:         WITH loc_oPg.lbl_4c_LblFinP
1138:             .Caption   = "Ficha :"
1139:             .Top       = 326

*-- Linhas 1160 a 1204:
1160:             .Themes   = .F.
1161:             .Visible  = .T.
1162:         ENDWITH
1163:         BINDEVENT(loc_oPg.txt_4c_CodFinP, "KeyPress", THIS, "TxtCodFinPKeyPress")
1164:         BINDEVENT(loc_oPg.txt_4c_CodFinP, "DblClick", THIS, "AbrirLookupFinP")
1165: 
1166:         *-- TextBox getDesFinP (desc ficha: Top=322, Left=145, W=150, H=23 - READ ONLY)
1167:         loc_oPg.AddObject("txt_4c_DesFinP", "TextBox")
1168:         WITH loc_oPg.txt_4c_DesFinP
1169:             .Value     = ""
1170:             .Top       = 322
1171:             .Left      = 145
1172:             .Width     = 150
1173:             .Height    = 23
1174:             .FontName  = "Tahoma"
1175:             .FontSize  = 8
1176:             .ReadOnly  = .T.
1177:             .BackColor = RGB(224, 235, 235)
1178:             .Themes    = .F.
1179:             .Visible   = .T.
1180:         ENDWITH
1181: 
1182:         loc_oPg.AddObject("lbl_4c_LblPesoB", "Label")
1183:         WITH loc_oPg.lbl_4c_LblPesoB
1184:             .Caption   = "Peso Base :"
1185:             .Top       = 326
1186:             .Left      = 316
1187:             .Width     = 64
1188:             .Height    = 15
1189:             .BackStyle = 0
1190:             .ForeColor = RGB(90, 90, 90)
1191:             .FontName  = "Tahoma"
1192:             .FontSize  = 8
1193:             .Visible   = .T.
1194:         ENDWITH
1195: 
1196:         *-- TextBox getPesoBs (pesobs: Top=322, Left=401, W=111, H=23)
1197:         loc_oPg.AddObject("txt_4c_PesoB", "TextBox")
1198:         WITH loc_oPg.txt_4c_PesoB
1199:             .Value    = 0.0
1200:             .Top      = 322
1201:             .Left     = 401
1202:             .Width    = 111
1203:             .Height   = 23
1204:             .FontName = "Tahoma"

*-- Linhas 1237 a 1281:
1237:             .Themes   = .F.
1238:             .Visible  = .T.
1239:         ENDWITH
1240:         BINDEVENT(loc_oPg.txt_4c_CodAcb, "KeyPress", THIS, "TxtCodAcbKeyPress")
1241:         BINDEVENT(loc_oPg.txt_4c_CodAcb, "DblClick", THIS, "AbrirLookupAcb")
1242: 
1243:         *-- TextBox get_Dacb (desc acabamento: Top=346, Left=145, W=150, H=23 - READ ONLY)
1244:         loc_oPg.AddObject("txt_4c_DacbDisplay", "TextBox")
1245:         WITH loc_oPg.txt_4c_DacbDisplay
1246:             .Value     = ""
1247:             .Top       = 346
1248:             .Left      = 145
1249:             .Width     = 150
1250:             .Height    = 23
1251:             .FontName  = "Tahoma"
1252:             .FontSize  = 8
1253:             .ReadOnly  = .T.
1254:             .BackColor = RGB(224, 235, 235)
1255:             .Themes    = .F.
1256:             .Visible   = .T.
1257:         ENDWITH
1258: 
1259:         loc_oPg.AddObject("lbl_4c_LblPmedio", "Label")
1260:         WITH loc_oPg.lbl_4c_LblPmedio
1261:             .Caption   = "Pr." + CHR(233) + "dio :"
1262:             .Top       = 350
1263:             .Left      = 316
1264:             .Width     = 64
1265:             .Height    = 15
1266:             .BackStyle = 0
1267:             .ForeColor = RGB(90, 90, 90)
1268:             .FontName  = "Tahoma"
1269:             .FontSize  = 8
1270:             .Visible   = .T.
1271:         ENDWITH
1272: 
1273:         *-- TextBox getPmedio (pcuss: Top=346, Left=401, W=111, H=23 - READ ONLY custo)
1274:         loc_oPg.AddObject("txt_4c_Pmedio", "TextBox")
1275:         WITH loc_oPg.txt_4c_Pmedio
1276:             .Value     = 0.0
1277:             .Top       = 346
1278:             .Left      = 401
1279:             .Width     = 111
1280:             .Height    = 23
1281:             .FontName  = "Tahoma"

*-- Linhas 1316 a 1532:
1316:             .Themes   = .F.
1317:             .Visible  = .T.
1318:         ENDWITH
1319:         BINDEVENT(loc_oPg.txt_4c_Class, "KeyPress", THIS, "TxtClassKeyPress")
1320:         BINDEVENT(loc_oPg.txt_4c_Class, "DblClick", THIS, "AbrirLookupClass")
1321: 
1322:         *-- TextBox Get_DClass (desc classe: Top=370, Left=145, W=150, H=23 - READ ONLY)
1323:         loc_oPg.AddObject("txt_4c_DClassDisplay", "TextBox")
1324:         WITH loc_oPg.txt_4c_DClassDisplay
1325:             .Value     = ""
1326:             .Top       = 370
1327:             .Left      = 145
1328:             .Width     = 150
1329:             .Height    = 23
1330:             .FontName  = "Tahoma"
1331:             .FontSize  = 8
1332:             .ReadOnly  = .T.
1333:             .BackColor = RGB(224, 235, 235)
1334:             .Themes    = .F.
1335:             .Visible   = .T.
1336:         ENDWITH
1337: 
1338:         loc_oPg.AddObject("lbl_4c_LblLocal", "Label")
1339:         WITH loc_oPg.lbl_4c_LblLocal
1340:             .Caption   = "Local :"
1341:             .Top       = 374
1342:             .Left      = 346
1343:             .Width     = 36
1344:             .Height    = 15
1345:             .BackStyle = 0
1346:             .ForeColor = RGB(90, 90, 90)
1347:             .FontName  = "Tahoma"
1348:             .FontSize  = 8
1349:             .Visible   = .T.
1350:         ENDWITH
1351: 
1352:         *-- TextBox Get_Local (locals: Top=370, Left=401, W=111, H=23)
1353:         loc_oPg.AddObject("txt_4c_Local", "TextBox")
1354:         WITH loc_oPg.txt_4c_Local
1355:             .Value    = ""
1356:             .Top      = 370
1357:             .Left     = 401
1358:             .Width    = 111
1359:             .Height   = 23
1360:             .FontName = "Tahoma"
1361:             .FontSize = 8
1362:             .Themes   = .F.
1363:             .Visible  = .T.
1364:         ENDWITH
1365:         BINDEVENT(loc_oPg.txt_4c_Local, "KeyPress", THIS, "TxtLocalKeyPress")
1366:         BINDEVENT(loc_oPg.txt_4c_Local, "DblClick", THIS, "AbrirLookupLocal")
1367: 
1368:         *-- RIGHT SIDE: Custo Total + Moeda Custo (top=362/375)
1369:         loc_oPg.AddObject("lbl_4c_LblCtotal", "Label")
1370:         WITH loc_oPg.lbl_4c_LblCtotal
1371:             .Caption   = "Custo :"
1372:             .Top       = 362
1373:             .Left      = 572
1374:             .Width     = 53
1375:             .Height    = 15
1376:             .BackStyle = 0
1377:             .ForeColor = RGB(90, 90, 90)
1378:             .FontName  = "Tahoma"
1379:             .FontSize  = 8
1380:             .Visible   = .T.
1381:         ENDWITH
1382: 
1383:         *-- TextBox getCtotal (custofs: Top=375, Left=626, W=127, H=21 - READ ONLY)
1384:         loc_oPg.AddObject("txt_4c_Ctotal", "TextBox")
1385:         WITH loc_oPg.txt_4c_Ctotal
1386:             .Value     = 0.0
1387:             .Top       = 375
1388:             .Left      = 626
1389:             .Width     = 127
1390:             .Height    = 21
1391:             .FontName  = "Tahoma"
1392:             .FontSize  = 8
1393:             .ReadOnly  = .T.
1394:             .BackColor = RGB(224, 235, 235)
1395:             .Themes    = .F.
1396:             .Visible   = .T.
1397:         ENDWITH
1398: 
1399:         *-- TextBox getMctotal (moecs: Top=375, Left=754, W=31, H=21)
1400:         loc_oPg.AddObject("txt_4c_Mctotal", "TextBox")
1401:         WITH loc_oPg.txt_4c_Mctotal
1402:             .Value    = ""
1403:             .Top      = 375
1404:             .Left     = 754
1405:             .Width    = 31
1406:             .Height   = 21
1407:             .FontName = "Tahoma"
1408:             .FontSize = 8
1409:             .Themes   = .F.
1410:             .Visible  = .T.
1411:         ENDWITH
1412:         BINDEVENT(loc_oPg.txt_4c_Mctotal, "KeyPress", THIS, "TxtMctotalKeyPress")
1413:         BINDEVENT(loc_oPg.txt_4c_Mctotal, "DblClick", THIS, "AbrirLookupMctotal")
1414: 
1415:         *-- ===================================================================
1416:         *-- LINHA 12 (top=394): Get_Cuni + Get_Duni + Get_cunip + get_dunip
1417:         *-- ===================================================================
1418:         loc_oPg.AddObject("lbl_4c_LblCuni", "Label")
1419:         WITH loc_oPg.lbl_4c_LblCuni
1420:             .Caption   = "Unidade :"
1421:             .Top       = 398
1422:             .Left      = 55
1423:             .Width     = 57
1424:             .Height    = 15
1425:             .BackStyle = 0
1426:             .ForeColor = RGB(90, 90, 90)
1427:             .FontName  = "Tahoma"
1428:             .FontSize  = 8
1429:             .Visible   = .T.
1430:         ENDWITH
1431: 
1432:         *-- TextBox Get_Cuni (cunis: Top=394, Left=113, W=31, H=23)
1433:         loc_oPg.AddObject("txt_4c_Cuni", "TextBox")
1434:         WITH loc_oPg.txt_4c_Cuni
1435:             .Value    = ""
1436:             .Top      = 394
1437:             .Left     = 113
1438:             .Width    = 31
1439:             .Height   = 23
1440:             .FontName = "Tahoma"
1441:             .FontSize = 8
1442:             .Themes   = .F.
1443:             .Visible  = .T.
1444:         ENDWITH
1445:         BINDEVENT(loc_oPg.txt_4c_Cuni, "KeyPress", THIS, "TxtCuniKeyPress")
1446:         BINDEVENT(loc_oPg.txt_4c_Cuni, "DblClick", THIS, "AbrirLookupUni")
1447: 
1448:         *-- TextBox Get_Duni (desc unidade: Top=394, Left=145, W=150, H=23 - READ ONLY)
1449:         loc_oPg.AddObject("txt_4c_DuniDisplay", "TextBox")
1450:         WITH loc_oPg.txt_4c_DuniDisplay
1451:             .Value     = ""
1452:             .Top       = 394
1453:             .Left      = 145
1454:             .Width     = 150
1455:             .Height    = 23
1456:             .FontName  = "Tahoma"
1457:             .FontSize  = 8
1458:             .ReadOnly  = .T.
1459:             .BackColor = RGB(224, 235, 235)
1460:             .Themes    = .F.
1461:             .Visible   = .T.
1462:         ENDWITH
1463: 
1464:         loc_oPg.AddObject("lbl_4c_LblCunip", "Label")
1465:         WITH loc_oPg.lbl_4c_LblCunip
1466:             .Caption   = "Uni.Ped. :"
1467:             .Top       = 398
1468:             .Left      = 278
1469:             .Width     = 51
1470:             .Height    = 15
1471:             .BackStyle = 0
1472:             .ForeColor = RGB(90, 90, 90)
1473:             .FontName  = "Tahoma"
1474:             .FontSize  = 8
1475:             .Visible   = .T.
1476:         ENDWITH
1477: 
1478:         *-- TextBox Get_cunip (cunips: Top=394, Left=330, W=31, H=23)
1479:         loc_oPg.AddObject("txt_4c_Cunip", "TextBox")
1480:         WITH loc_oPg.txt_4c_Cunip
1481:             .Value    = ""
1482:             .Top      = 394
1483:             .Left     = 330
1484:             .Width    = 31
1485:             .Height   = 23
1486:             .FontName = "Tahoma"
1487:             .FontSize = 8
1488:             .Themes   = .F.
1489:             .Visible  = .T.
1490:         ENDWITH
1491:         BINDEVENT(loc_oPg.txt_4c_Cunip, "KeyPress", THIS, "TxtCunipKeyPress")
1492:         BINDEVENT(loc_oPg.txt_4c_Cunip, "DblClick", THIS, "AbrirLookupUniP")
1493: 
1494:         *-- TextBox get_dunip (desc uni.pedido: Top=394, Left=362, W=150, H=23 - READ ONLY)
1495:         loc_oPg.AddObject("txt_4c_DunipDisplay", "TextBox")
1496:         WITH loc_oPg.txt_4c_DunipDisplay
1497:             .Value     = ""
1498:             .Top       = 394
1499:             .Left      = 362
1500:             .Width     = 150
1501:             .Height    = 23
1502:             .FontName  = "Tahoma"
1503:             .FontSize  = 8
1504:             .ReadOnly  = .T.
1505:             .BackColor = RGB(224, 235, 235)
1506:             .Themes    = .F.
1507:             .Visible   = .T.
1508:         ENDWITH
1509: 
1510:         *-- RIGHT SIDE: P.Venda + Moeda Pvenda + Datas Inc/Alt (top=384/397)
1511:         loc_oPg.AddObject("lbl_4c_LblPvenda", "Label")
1512:         WITH loc_oPg.lbl_4c_LblPvenda
1513:             .Caption   = "P.Venda :"
1514:             .Top       = 384
1515:             .Left      = 572
1516:             .Width     = 53
1517:             .Height    = 15
1518:             .BackStyle = 0
1519:             .ForeColor = RGB(90, 90, 90)
1520:             .FontName  = "Tahoma"
1521:             .FontSize  = 8
1522:             .Visible   = .T.
1523:         ENDWITH
1524: 
1525:         *-- TextBox getPvenda (pvens: Top=397, Left=626, W=127, H=21)
1526:         loc_oPg.AddObject("txt_4c_Pvenda", "TextBox")
1527:         WITH loc_oPg.txt_4c_Pvenda
1528:             .Value    = 0.0
1529:             .Top      = 397
1530:             .Left     = 626
1531:             .Width    = 127
1532:             .Height   = 21

*-- Linhas 1549 a 1593:
1549:             .Themes   = .F.
1550:             .Visible  = .T.
1551:         ENDWITH
1552:         BINDEVENT(loc_oPg.txt_4c_Mpvenda, "KeyPress", THIS, "TxtMpvendaKeyPress")
1553:         BINDEVENT(loc_oPg.txt_4c_Mpvenda, "DblClick", THIS, "AbrirLookupMpvenda")
1554: 
1555:         loc_oPg.AddObject("lbl_4c_LblInc", "Label")
1556:         WITH loc_oPg.lbl_4c_LblInc
1557:             .Caption   = "Inc."
1558:             .Top       = 384
1559:             .Left      = 793
1560:             .Width     = 39
1561:             .Height    = 15
1562:             .BackStyle = 0
1563:             .ForeColor = RGB(90, 90, 90)
1564:             .FontName  = "Tahoma"
1565:             .FontSize  = 8
1566:             .Visible   = .T.
1567:         ENDWITH
1568: 
1569:         *-- TextBox getDtIncs (dtincs: Top=397, Left=833, W=79, H=21 - READ ONLY)
1570:         loc_oPg.AddObject("txt_4c_DtIncs", "TextBox")
1571:         WITH loc_oPg.txt_4c_DtIncs
1572:             .Value     = {}
1573:             .Top       = 397
1574:             .Left      = 833
1575:             .Width     = 79
1576:             .Height    = 21
1577:             .FontName  = "Tahoma"
1578:             .FontSize  = 8
1579:             .Format    = "D"
1580:             .ReadOnly  = .T.
1581:             .BackColor = RGB(224, 235, 235)
1582:             .Themes    = .F.
1583:             .Visible   = .T.
1584:         ENDWITH
1585: 
1586:         loc_oPg.AddObject("lbl_4c_LblAlt", "Label")
1587:         WITH loc_oPg.lbl_4c_LblAlt
1588:             .Caption   = "Alt."
1589:             .Top       = 384
1590:             .Left      = 876
1591:             .Width     = 36
1592:             .Height    = 15
1593:             .BackStyle = 0

*-- Linhas 1687 a 1731:
1687:             .Themes   = .F.
1688:             .Visible  = .T.
1689:         ENDWITH
1690:         BINDEVENT(loc_oPg.txt_4c_Mfvenda, "KeyPress", THIS, "TxtMfvendaKeyPress")
1691:         BINDEVENT(loc_oPg.txt_4c_Mfvenda, "DblClick", THIS, "AbrirLookupMfvenda")
1692: 
1693:         *-- TextBox Get_Usuario (usuincs: Top=419, Left=833, W=79, H=21 - READ ONLY)
1694:         loc_oPg.AddObject("txt_4c_UsuIncs", "TextBox")
1695:         WITH loc_oPg.txt_4c_UsuIncs
1696:             .Value     = ""
1697:             .Top       = 419
1698:             .Left      = 833
1699:             .Width     = 79
1700:             .Height    = 21
1701:             .FontName  = "Tahoma"
1702:             .FontSize  = 8
1703:             .ReadOnly  = .T.
1704:             .BackColor = RGB(224, 235, 235)
1705:             .Themes    = .F.
1706:             .Visible   = .T.
1707:         ENDWITH
1708: 
1709:         *-- TextBox getUsuaAlts (usuaalts: Top=419, Left=914, W=79, H=21 - READ ONLY)
1710:         loc_oPg.AddObject("txt_4c_UsuaAlts", "TextBox")
1711:         WITH loc_oPg.txt_4c_UsuaAlts
1712:             .Value     = ""
1713:             .Top       = 419
1714:             .Left      = 914
1715:             .Width     = 79
1716:             .Height    = 21
1717:             .FontName  = "Tahoma"
1718:             .FontSize  = 8
1719:             .ReadOnly  = .T.
1720:             .BackColor = RGB(224, 235, 235)
1721:             .Themes    = .F.
1722:             .Visible   = .T.
1723:         ENDWITH
1724: 
1725:         *-- ===================================================================
1726:         *-- LINHA 14 (top=448): getdsccompras + checkboxes FabrProprs/Consig/Encoms
1727:         *-- ===================================================================
1728:         loc_oPg.AddObject("lbl_4c_LblDscComp", "Label")
1729:         WITH loc_oPg.lbl_4c_LblDscComp
1730:             .Caption   = "Descr.Compras :"
1731:             .Top       = 435

*-- Linhas 1858 a 1917:
1858:         ENDWITH
1859: 
1860:         *-- ===================================================================
1861:         *-- DBLCLICK BINDEVENTS para campos com lookup (Fase 5 + Fase 6)
1862:         *-- ===================================================================
1863:         BINDEVENT(loc_oPg.txt_4c_Cpros, "DblClick", THIS, "AbrirLookupProduto")
1864:         BINDEVENT(loc_oPg.txt_4c_Cgrus, "DblClick", THIS, "AbrirLookupGrupo")
1865:         BINDEVENT(loc_oPg.txt_4c_Lin,   "DblClick", THIS, "AbrirLookupLin")
1866:         BINDEVENT(loc_oPg.txt_4c_Col,   "DblClick", THIS, "AbrirLookupCol")
1867:         BINDEVENT(loc_oPg.txt_4c_Ifor,  "DblClick", THIS, "AbrirLookupIfor")
1868:     ENDPROC
1869: 
1870:     *--------------------------------------------------------------------------
1871:     * ConfigurarPgpgComposicao - Aba "Composicao" (Page2 de pgf_4c_Dados)
1872:     * Contem: grd_4c_Compo (14 cols), grd_4c_SubCp (15 cols), grd_4c_TotGrupo (3 cols)
1873:     *         cntMtPrima + ~30 textboxes + labels + checkboxes + commandgroups
1874:     * Posicoes = valores ORIGINAIS do layout.json (Tabs=.F. -> sem deslocamento)
1875:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1876:     *--------------------------------------------------------------------------
1877:     PROTECTED PROCEDURE ConfigurarPgpgComposicao(par_oPage)
1878:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2, loc_oGrd3, loc_oCnt
1879: 
1880:         loc_oPg = par_oPage
1881: 
1882:         *-- ===================================================================
1883:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
1884:         *-- ===================================================================
1885: 
1886:         *-- cursor_4c_Compo - composicao do produto (SIGPRCPO)
1887:         IF USED("cursor_4c_Compo")
1888:             USE IN cursor_4c_Compo
1889:         ENDIF
1890:         SET NULL ON
1891:         CREATE CURSOR cursor_4c_Compo ( ;
1892:             mats      C(14), dcompos C(40), unicompos C(3),  ;
1893:             pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
1894:             moeds     C(3),  obscompos C(10), etiqs C(1),    ;
1895:             qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
1896:             ordems    N(2,0), tipos C(20))
1897:         SET NULL OFF
1898: 
1899:         *-- cursor_4c_SubCp - sub-composicao (sigsubcp)
1900:         IF USED("cursor_4c_SubCp")
1901:             USE IN cursor_4c_SubCp
1902:         ENDIF
1903:         SET NULL ON
1904:         CREATE CURSOR cursor_4c_SubCp ( ;
1905:             mats      C(14), dcompos C(40), unicompos C(3),  ;
1906:             pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
1907:             moeds     C(3),  obscompos C(10), etiqs C(1),    ;
1908:             qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
1909:             ordems    N(2,0), matsubs C(14), codtams C(4))
1910:         SET NULL OFF
1911: 
1912:         *-- cursor_4c_TotGrupo - totais por grupo (calculado)
1913:         IF USED("cursor_4c_TotGrupo")
1914:             USE IN cursor_4c_TotGrupo
1915:         ENDIF
1916:         SET NULL ON
1917:         CREATE CURSOR cursor_4c_TotGrupo ( ;

*-- Linhas 2072 a 2116:
2072:         loc_oGrd.Column13.Width = 24
2073:         loc_oGrd.Column14.Width = 108
2074: 
2075:         *-- BINDEVENT grd_4c_Compo
2076:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")
2077: 
2078:         *-- ===================================================================
2079:         *-- GRID grd_4c_SubCp - Sub-composicao (grdsubcp: top=348, left=6, w=943, h=83)
2080:         *-- 15 colunas de sigsubcp
2081:         *-- ===================================================================
2082:         loc_oPg.AddObject("grd_4c_SubCp", "Grid")
2083:         loc_oGrd2 = loc_oPg.grd_4c_SubCp
2084:         WITH loc_oGrd2
2085:             .Top         = 348
2086:             .Left        = 6
2087:             .Width       = 943
2088:             .Height      = 83
2089:             .FontName    = "Tahoma"
2090:             .FontSize    = 8
2091:             .RecordMark  = .F.
2092:             .DeleteMark  = .F.
2093:             .GridLines   = 3
2094:             .ReadOnly    = .F.
2095:             .RowHeight   = 16
2096:             .ScrollBars  = 2
2097:             .Themes      = .F.
2098:             .ColumnCount = 15
2099:             .Visible     = .T.
2100:         ENDWITH
2101: 
2102:         *-- Colunas grd_4c_SubCp
2103:         WITH loc_oGrd2.Column1
2104:             .Width = 108
2105:             .Movable = .F.
2106:             .Resizable = .F.
2107:         ENDWITH
2108:         WITH loc_oGrd2.Column2
2109:             .Width = 149
2110:             .Movable = .F.
2111:             .Resizable = .F.
2112:         ENDWITH
2113:         WITH loc_oGrd2.Column3
2114:             .Width = 24
2115:             .Movable = .F.
2116:             .Resizable = .F.

*-- Linhas 2223 a 2267:
2223:         loc_oGrd2.Column14.Width = 108
2224:         loc_oGrd2.Column15.Width = 38
2225: 
2226:         *-- BINDEVENT grd_4c_SubCp
2227:         BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdSubCpAfterRowColChange")
2228: 
2229:         *-- ===================================================================
2230:         *-- GRID grd_4c_TotGrupo - Totais por grupo (GradeGRUPO: top=34, left=582, w=229, h=107)
2231:         *-- 3 colunas, ReadOnly
2232:         *-- ===================================================================
2233:         loc_oPg.AddObject("grd_4c_TotGrupo", "Grid")
2234:         loc_oGrd3 = loc_oPg.grd_4c_TotGrupo
2235:         WITH loc_oGrd3
2236:             .Top         = 34
2237:             .Left        = 582
2238:             .Width       = 229
2239:             .Height      = 107
2240:             .FontName    = "Courier New"
2241:             .FontSize    = 8
2242:             .RecordMark  = .F.
2243:             .DeleteMark  = .F.
2244:             .GridLines   = 3
2245:             .ReadOnly    = .T.
2246:             .RowHeight   = 17
2247:             .Themes      = .F.
2248:             .ColumnCount = 3
2249:             .Visible     = .T.
2250:         ENDWITH
2251: 
2252:         WITH loc_oGrd3.Column1
2253:             .Width     = 35
2254:             .Movable   = .F.
2255:             .Resizable = .F.
2256:             .ReadOnly  = .T.
2257:         ENDWITH
2258:         WITH loc_oGrd3.Column2
2259:             .Width     = 134
2260:             .Movable   = .F.
2261:             .Resizable = .F.
2262:             .ReadOnly  = .T.
2263:             .InputMask = "999,999,999.999"
2264:         ENDWITH
2265:         WITH loc_oGrd3.Column3
2266:             .Width     = 37
2267:             .Movable   = .F.

*-- Linhas 2685 a 2743:
2685:             .Themes   = .F.
2686:             .Visible  = .T.
2687:         ENDWITH
2688:         BINDEVENT(loc_oPg.chk_4c_LiberaCusto, "Click", THIS, "ChkLiberaCustoClick")
2689: 
2690:         *-- chkLiberaVenda: liberar venda (top=459, left=323, w=39, h=38)
2691:         loc_oPg.AddObject("chk_4c_LiberaVenda", "CheckBox")
2692:         WITH loc_oPg.chk_4c_LiberaVenda
2693:             .Caption  = ""
2694:             .Top      = 459
2695:             .Left     = 323
2696:             .Width    = 39
2697:             .Height   = 38
2698:             .FontName = "Tahoma"
2699:             .FontSize = 8
2700:             .Themes   = .F.
2701:             .Visible  = .T.
2702:         ENDWITH
2703:         BINDEVENT(loc_oPg.chk_4c_LiberaVenda, "Click", THIS, "ChkLiberaVendaClick")
2704: 
2705:         *-- chkPlanCus: planejamento custo (top=556, left=36, w=25, h=25)
2706:         loc_oPg.AddObject("chk_4c_PlanCus", "CheckBox")
2707:         WITH loc_oPg.chk_4c_PlanCus
2708:             .Caption  = ""
2709:             .Top      = 556
2710:             .Left     = 36
2711:             .Width    = 25
2712:             .Height   = 25
2713:             .FontName = "Tahoma"
2714:             .FontSize = 8
2715:             .Themes   = .F.
2716:             .Visible  = .T.
2717:         ENDWITH
2718: 
2719:         *-- chkPlanVen: planejamento venda (top=556, left=387, w=25, h=25)
2720:         loc_oPg.AddObject("chk_4c_PlanVen", "CheckBox")
2721:         WITH loc_oPg.chk_4c_PlanVen
2722:             .Caption  = ""
2723:             .Top      = 556
2724:             .Left     = 387
2725:             .Width    = 25
2726:             .Height   = 25
2727:             .FontName = "Tahoma"
2728:             .FontSize = 8
2729:             .Themes   = .F.
2730:             .Visible  = .T.
2731:         ENDWITH
2732: 
2733:         *-- Chk_Pvenda: usar preco de venda (top=595, left=387, w=25, h=25)
2734:         loc_oPg.AddObject("chk_4c_Pvenda", "CheckBox")
2735:         WITH loc_oPg.chk_4c_Pvenda
2736:             .Caption  = ""
2737:             .Top      = 595
2738:             .Left     = 387
2739:             .Width    = 25
2740:             .Height   = 25
2741:             .FontName = "Tahoma"
2742:             .FontSize = 8
2743:             .Themes   = .F.

*-- Linhas 2776 a 2881:
2776:             .Themes   = .F.
2777:             .Visible  = .T.
2778:         ENDWITH
2779:         BINDEVENT(loc_oPg.txt_4c_Moec, "KeyPress", THIS, "TxtMoecKeyPress")
2780: 
2781:         *-- getPcus: preco de custo moeda1 (top=517, left=9, w=115, h=23)
2782:         loc_oPg.AddObject("txt_4c_Pcus", "TextBox")
2783:         WITH loc_oPg.txt_4c_Pcus
2784:             .Value     = 0
2785:             .Top       = 517
2786:             .Left      = 9
2787:             .Width     = 115
2788:             .Height    = 23
2789:             .FontName  = "Tahoma"
2790:             .FontSize  = 8
2791:             .InputMask = "99999,999.99999"
2792:             .Themes    = .F.
2793:             .Visible   = .T.
2794:         ENDWITH
2795:         BINDEVENT(loc_oPg.txt_4c_Pcus, "LostFocus", THIS, "TxtPcusValid")
2796: 
2797:         *-- lblCuVda: "Fator de Custo (Moeda 2)" (top=502, left=161, w=126, h=15)
2798:         loc_oPg.AddObject("lbl_4c_LblCuVda", "Label")
2799:         WITH loc_oPg.lbl_4c_LblCuVda
2800:             .Caption   = "Fator de Custo (Moeda 2)"
2801:             .Top       = 502
2802:             .Left      = 161
2803:             .Width     = 126
2804:             .Height    = 15
2805:             .BackStyle = 0
2806:             .ForeColor = RGB(90, 90, 90)
2807:             .FontName  = "Tahoma"
2808:             .FontSize  = 8
2809:             .Visible   = .T.
2810:         ENDWITH
2811: 
2812:         *-- getMoepc: moeda preco custo moeda2 (top=517, left=279, w=31, h=23)
2813:         loc_oPg.AddObject("txt_4c_Moepc", "TextBox")
2814:         WITH loc_oPg.txt_4c_Moepc
2815:             .Value    = ""
2816:             .Top      = 517
2817:             .Left     = 279
2818:             .Width    = 31
2819:             .Height   = 23
2820:             .FontName = "Tahoma"
2821:             .FontSize = 8
2822:             .Themes   = .F.
2823:             .Visible  = .T.
2824:         ENDWITH
2825:         BINDEVENT(loc_oPg.txt_4c_Moepc, "KeyPress", THIS, "TxtMoepcKeyPress")
2826: 
2827:         *-- getFcusto: fator de custo moeda2 (top=517, left=161, w=115, h=23)
2828:         loc_oPg.AddObject("txt_4c_Fcusto", "TextBox")
2829:         WITH loc_oPg.txt_4c_Fcusto
2830:             .Value     = 0
2831:             .Top       = 517
2832:             .Left      = 161
2833:             .Width     = 115
2834:             .Height    = 23
2835:             .FontName  = "Tahoma"
2836:             .FontSize  = 8
2837:             .InputMask = "99999,999.99999"
2838:             .Themes    = .F.
2839:             .Visible   = .T.
2840:         ENDWITH
2841:         BINDEVENT(loc_oPg.txt_4c_Fcusto, "LostFocus", THIS, "TxtFcustoValid")
2842: 
2843:         *-- Say8: "Total " (top=542, left=161, w=29, h=15)
2844:         loc_oPg.AddObject("lbl_4c_Say8", "Label")
2845:         WITH loc_oPg.lbl_4c_Say8
2846:             .Caption   = "Total "
2847:             .Top       = 542
2848:             .Left      = 161
2849:             .Width     = 29
2850:             .Height    = 15
2851:             .BackStyle = 0
2852:             .ForeColor = RGB(90, 90, 90)
2853:             .FontName  = "Tahoma"
2854:             .FontSize  = 8
2855:             .Visible   = .T.
2856:         ENDWITH
2857: 
2858:         *-- getMoecusf: moeda custo fator (top=557, left=279, w=31, h=23)
2859:         loc_oPg.AddObject("txt_4c_Moecusf", "TextBox")
2860:         WITH loc_oPg.txt_4c_Moecusf
2861:             .Value    = ""
2862:             .Top      = 557
2863:             .Left     = 279
2864:             .Width    = 31
2865:             .Height   = 23
2866:             .FontName = "Tahoma"
2867:             .FontSize = 8
2868:             .ReadOnly = .T.
2869:             .BackColor = RGB(224, 235, 235)
2870:             .Themes   = .F.
2871:             .Visible  = .T.
2872:         ENDWITH
2873: 
2874:         *-- getCustof: custo total fatorado (top=557, left=161, w=115, h=23)
2875:         loc_oPg.AddObject("txt_4c_Custof", "TextBox")
2876:         WITH loc_oPg.txt_4c_Custof
2877:             .Value     = 0
2878:             .Top       = 557
2879:             .Left      = 161
2880:             .Width     = 115
2881:             .Height    = 23

*-- Linhas 2933 a 3007:
2933:             .BackColor     = RGB(255, 255, 255)
2934:             .Visible       = .T.
2935:         ENDWITH
2936:         BINDEVENT(loc_oPg.cmd_4c_PesoM, "Click", THIS, "CmdPesoMClick")
2937: 
2938:         *-- Say7: "Cotacao" (top=581, left=161, w=42, h=15)
2939:         loc_oPg.AddObject("lbl_4c_Say7", "Label")
2940:         WITH loc_oPg.lbl_4c_Say7
2941:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
2942:             .Top       = 581
2943:             .Left      = 161
2944:             .Width     = 42
2945:             .Height    = 15
2946:             .BackStyle = 0
2947:             .ForeColor = RGB(90, 90, 90)
2948:             .FontName  = "Tahoma"
2949:             .FontSize  = 8
2950:             .Visible   = .T.
2951:         ENDWITH
2952: 
2953:         *-- GetCotaCalcP: cotacao calculada (top=596, left=161, w=115, h=23)
2954:         loc_oPg.AddObject("txt_4c_CotaCalcP", "TextBox")
2955:         WITH loc_oPg.txt_4c_CotaCalcP
2956:             .Value     = 0
2957:             .Top       = 596
2958:             .Left      = 161
2959:             .Width     = 115
2960:             .Height    = 23
2961:             .FontName  = "Tahoma"
2962:             .FontSize  = 8
2963:             .InputMask = "99999.999999"
2964:             .Themes    = .F.
2965:             .Visible   = .T.
2966:         ENDWITH
2967:         BINDEVENT(loc_oPg.txt_4c_CotaCalcP, "LostFocus", THIS, "TxtCotaCalcPValid")
2968: 
2969:         *-- ===================================================================
2970:         *-- SECAO CUSTO - MKP e Fator (lado custo)
2971:         *-- ===================================================================
2972: 
2973:         *-- Say22: "MKP" (top=542, left=9, w=22, h=15)
2974:         loc_oPg.AddObject("lbl_4c_Say22", "Label")
2975:         WITH loc_oPg.lbl_4c_Say22
2976:             .Caption   = "MKP"
2977:             .Top       = 542
2978:             .Left      = 9
2979:             .Width     = 22
2980:             .Height    = 15
2981:             .BackStyle = 0
2982:             .ForeColor = RGB(90, 90, 90)
2983:             .FontName  = "Tahoma"
2984:             .FontSize  = 8
2985:             .Visible   = .T.
2986:         ENDWITH
2987: 
2988:         *-- Get_cmkpc: MKP custo (top=557, left=9, w=24, h=23)
2989:         loc_oPg.AddObject("txt_4c_Cftiocs", "TextBox")
2990:         WITH loc_oPg.txt_4c_Cftiocs
2991:             .Value    = ""
2992:             .Top      = 557
2993:             .Left     = 9
2994:             .Width    = 24
2995:             .Height   = 23
2996:             .FontName = "Tahoma"
2997:             .FontSize = 8
2998:             .ReadOnly = .T.
2999:             .BackColor = RGB(224, 235, 235)
3000:             .Themes   = .F.
3001:             .Visible  = .T.
3002:         ENDWITH
3003: 
3004:         *-- lblValAdics: "Valor Adicional" (top=542, left=64, w=71, h=15)
3005:         loc_oPg.AddObject("lbl_4c_LblValAdics", "Label")
3006:         WITH loc_oPg.lbl_4c_LblValAdics
3007:             .Caption   = "Valor Adicional"

*-- Linhas 3066 a 3125:
3066:             .Themes    = .F.
3067:             .Visible   = .T.
3068:         ENDWITH
3069:         BINDEVENT(loc_oPg.txt_4c_Margem, "LostFocus", THIS, "TxtMargemValid")
3070: 
3071:         *-- getMarkupA: markup aplicado (top=596, left=323, w=62, h=23)
3072:         loc_oPg.AddObject("txt_4c_MarkupA", "TextBox")
3073:         WITH loc_oPg.txt_4c_MarkupA
3074:             .Value     = 0
3075:             .Top       = 596
3076:             .Left      = 323
3077:             .Width     = 62
3078:             .Height    = 23
3079:             .FontName  = "Tahoma"
3080:             .FontSize  = 8
3081:             .InputMask = "9999.999"
3082:             .Themes    = .F.
3083:             .Visible   = .T.
3084:         ENDWITH
3085:         BINDEVENT(loc_oPg.txt_4c_MarkupA, "LostFocus", THIS, "TxtMarkupAValid")
3086: 
3087:         *-- lblMkpApl: "MKP Aplic." (top=581, left=324, w=51, h=15)
3088:         loc_oPg.AddObject("lbl_4c_LblMkpApl", "Label")
3089:         WITH loc_oPg.lbl_4c_LblMkpApl
3090:             .Caption   = "MKP Aplic."
3091:             .Top       = 581
3092:             .Left      = 324
3093:             .Width     = 51
3094:             .Height    = 15
3095:             .BackStyle = 0
3096:             .ForeColor = RGB(90, 90, 90)
3097:             .FontName  = "Tahoma"
3098:             .FontSize  = 8
3099:             .Visible   = .T.
3100:         ENDWITH
3101: 
3102:         *-- Say14: "MKP" (top=542, left=360, w=22, h=15) - FT/IO custo
3103:         loc_oPg.AddObject("lbl_4c_Say14", "Label")
3104:         WITH loc_oPg.lbl_4c_Say14
3105:             .Caption   = "MKP"
3106:             .Top       = 542
3107:             .Left      = 360
3108:             .Width     = 22
3109:             .Height    = 15
3110:             .BackStyle = 0
3111:             .ForeColor = RGB(90, 90, 90)
3112:             .FontName  = "Tahoma"
3113:             .FontSize  = 8
3114:             .Visible   = .T.
3115:         ENDWITH
3116: 
3117:         *-- Getftio: fator tipo IO custo (top=557, left=360, w=24, h=23)
3118:         loc_oPg.AddObject("txt_4c_Cftios", "TextBox")
3119:         WITH loc_oPg.txt_4c_Cftios
3120:             .Value    = ""
3121:             .Top      = 557
3122:             .Left     = 360
3123:             .Width    = 24
3124:             .Height   = 23
3125:             .FontName = "Tahoma"

*-- Linhas 3196 a 3239:
3196:             .Themes   = .F.
3197:             .Visible  = .T.
3198:         ENDWITH
3199:         BINDEVENT(loc_oPg.txt_4c_Moeda, "KeyPress", THIS, "TxtMoedaKeyPress")
3200: 
3201:         *-- getPvideal: preco de venda ideal (top=517, left=416, w=110, h=23)
3202:         loc_oPg.AddObject("txt_4c_Pvideal", "TextBox")
3203:         WITH loc_oPg.txt_4c_Pvideal
3204:             .Value     = 0
3205:             .Top       = 517
3206:             .Left      = 416
3207:             .Width     = 110
3208:             .Height    = 23
3209:             .FontName  = "Tahoma"
3210:             .FontSize  = 8
3211:             .InputMask = "99999,999.99999"
3212:             .Themes    = .F.
3213:             .Visible   = .T.
3214:         ENDWITH
3215: 
3216:         *-- lblFIdeals: "Fator Ideal" (top=503, left=563, w=55, h=15)
3217:         loc_oPg.AddObject("lbl_4c_LblFIdeals", "Label")
3218:         WITH loc_oPg.lbl_4c_LblFIdeals
3219:             .Caption   = "Fator Ideal"
3220:             .Top       = 503
3221:             .Left      = 563
3222:             .Width     = 55
3223:             .Height    = 15
3224:             .BackStyle = 0
3225:             .ForeColor = RGB(90, 90, 90)
3226:             .FontName  = "Tahoma"
3227:             .FontSize  = 8
3228:             .Visible   = .T.
3229:         ENDWITH
3230: 
3231:         *-- getFIdeals: fator ideal (top=517, left=563, w=110, h=23)
3232:         loc_oPg.AddObject("txt_4c_Fideals", "TextBox")
3233:         WITH loc_oPg.txt_4c_Fideals
3234:             .Value     = 0
3235:             .Top       = 517
3236:             .Left      = 563
3237:             .Width     = 110
3238:             .Height    = 23
3239:             .FontName  = "Tahoma"

*-- Linhas 3351 a 3394:
3351:             .Themes   = .F.
3352:             .Visible  = .T.
3353:         ENDWITH
3354:         BINDEVENT(loc_oPg.txt_4c_Moepv, "KeyPress", THIS, "TxtMoepvKeyPress")
3355: 
3356:         *-- getPven: preco de venda (top=596, left=416, w=110, h=23)
3357:         loc_oPg.AddObject("txt_4c_Pvens", "TextBox")
3358:         WITH loc_oPg.txt_4c_Pvens
3359:             .Value     = 0
3360:             .Top       = 596
3361:             .Left      = 416
3362:             .Width     = 110
3363:             .Height    = 23
3364:             .FontName  = "Tahoma"
3365:             .FontSize  = 8
3366:             .InputMask = "99999,999.99999"
3367:             .Themes    = .F.
3368:             .Visible   = .T.
3369:         ENDWITH
3370: 
3371:         *-- lblFAtuals: "Fator Atual" (top=581, left=563, w=56, h=15)
3372:         loc_oPg.AddObject("lbl_4c_LblFAtuals", "Label")
3373:         WITH loc_oPg.lbl_4c_LblFAtuals
3374:             .Caption   = "Fator Atual"
3375:             .Top       = 581
3376:             .Left      = 563
3377:             .Width     = 56
3378:             .Height    = 15
3379:             .BackStyle = 0
3380:             .ForeColor = RGB(90, 90, 90)
3381:             .FontName  = "Tahoma"
3382:             .FontSize  = 8
3383:             .Visible   = .T.
3384:         ENDWITH
3385: 
3386:         *-- getMoev: moeda venda atual (top=596, left=529, w=31, h=23)
3387:         loc_oPg.AddObject("txt_4c_Moevs", "TextBox")
3388:         WITH loc_oPg.txt_4c_Moevs
3389:             .Value    = ""
3390:             .Top      = 596
3391:             .Left     = 529
3392:             .Width    = 31
3393:             .Height   = 23
3394:             .FontName = "Tahoma"

*-- Linhas 3467 a 3510:
3467:             .BackColor     = RGB(255, 255, 255)
3468:             .Visible       = .T.
3469:         ENDWITH
3470:         BINDEVENT(loc_oPg.cmd_4c_CalcVals, "Click", THIS, "CmdCalcValsClick")
3471: 
3472:         *-- ===================================================================
3473:         *-- COMMANDGROUP cmdgCompo - 5 botoes (top=145, left=947, w=50, h=210)
3474:         *-- ===================================================================
3475:         loc_oPg.AddObject("obj_4c_CmdgCompo", "CommandGroup")
3476:         WITH loc_oPg.obj_4c_CmdgCompo
3477:             .ButtonCount   = 5
3478:             .BorderStyle   = 0
3479:             .Top           = 145
3480:             .Left          = 947
3481:             .Width         = 50
3482:             .Height        = 210
3483:             .BackColor     = RGB(162, 214, 242)
3484:             .Themes        = .F.
3485:             .Visible       = .T.
3486:         ENDWITH
3487:         WITH loc_oPg.obj_4c_CmdgCompo
3488:             .Buttons(1).Top          = 5
3489:             .Buttons(1).Left         = 5
3490:             .Buttons(1).Height       = 40
3491:             .Buttons(1).Width        = 40
3492:             .Buttons(1).Caption      = ""
3493:             .Buttons(1).Picture      = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
3494:             .Buttons(1).ToolTipText  = "Inserir Item"
3495:             .Buttons(1).SpecialEffect = 0
3496:             .Buttons(1).BackColor    = RGB(255, 255, 255)
3497:             .Buttons(1).ForeColor    = RGB(0, 0, 0)
3498:             .Buttons(1).Themes       = .F.
3499:             .Buttons(2).Top          = 45
3500:             .Buttons(2).Left         = 5
3501:             .Buttons(2).Height       = 40
3502:             .Buttons(2).Width        = 40
3503:             .Buttons(2).Caption      = ""
3504:             .Buttons(2).Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3505:             .Buttons(2).ToolTipText  = "Excluir Item"
3506:             .Buttons(2).SpecialEffect = 0
3507:             .Buttons(2).BackColor    = RGB(255, 255, 255)
3508:             .Buttons(2).ForeColor    = RGB(0, 0, 0)
3509:             .Buttons(2).Themes       = .F.
3510:             .Buttons(3).Top          = 85

*-- Linhas 3537 a 3631:
3537:             .Buttons(5).BackColor    = RGB(255, 255, 255)
3538:             .Buttons(5).Themes       = .F.
3539:         ENDWITH
3540:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo, "Click", THIS, "CmdgCompoClick")
3541: 
3542:         *-- ===================================================================
3543:         *-- COMMANDGROUP cmdgSubCp - 2 botoes (top=345, left=947, w=50, h=90)
3544:         *-- ===================================================================
3545:         loc_oPg.AddObject("obj_4c_CmdgSubCp", "CommandGroup")
3546:         WITH loc_oPg.obj_4c_CmdgSubCp
3547:             .ButtonCount   = 2
3548:             .BorderStyle   = 0
3549:             .Top           = 345
3550:             .Left          = 947
3551:             .Width         = 50
3552:             .Height        = 90
3553:             .BackColor     = RGB(162, 214, 242)
3554:             .Themes        = .F.
3555:             .Visible       = .T.
3556:         ENDWITH
3557:         WITH loc_oPg.obj_4c_CmdgSubCp
3558:             .Buttons(1).Top          = 5
3559:             .Buttons(1).Left         = 5
3560:             .Buttons(1).Height       = 40
3561:             .Buttons(1).Width        = 40
3562:             .Buttons(1).Caption      = ""
3563:             .Buttons(1).Picture      = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
3564:             .Buttons(1).ToolTipText  = "Inserir Item"
3565:             .Buttons(1).SpecialEffect = 0
3566:             .Buttons(1).BackColor    = RGB(255, 255, 255)
3567:             .Buttons(1).ForeColor    = RGB(0, 0, 0)
3568:             .Buttons(1).Themes       = .F.
3569:             .Buttons(2).Top          = 45
3570:             .Buttons(2).Left         = 5
3571:             .Buttons(2).Height       = 40
3572:             .Buttons(2).Width        = 40
3573:             .Buttons(2).Caption      = ""
3574:             .Buttons(2).Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3575:             .Buttons(2).ToolTipText  = "Excluir Item"
3576:             .Buttons(2).SpecialEffect = 0
3577:             .Buttons(2).BackColor    = RGB(255, 255, 255)
3578:             .Buttons(2).ForeColor    = RGB(0, 0, 0)
3579:             .Buttons(2).Themes       = .F.
3580:         ENDWITH
3581:         BINDEVENT(loc_oPg.obj_4c_CmdgSubCp, "Click", THIS, "CmdgSubCpClick")
3582: 
3583:     ENDPROC
3584: 
3585:     *--------------------------------------------------------------------------
3586:     * ConfigurarPgpgDadosFiscais - Aba "Dados Fiscais" do PageFrame interno (pgDadosFiscais)
3587:     * Fase 13: Sub-pagina Dados Fiscais - 54 controles do original
3588:     * Posicoes: valores do layout.json (pgf_4c_Dados.Tabs=.F. -> sem +29)
3589:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
3590:     *--------------------------------------------------------------------------
3591:     PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais(par_oPage)
3592:         LOCAL loc_oPg, loc_oGrd
3593:         loc_oPg = par_oPage
3594: 
3595:         *-- ===================================================================
3596:         *-- CURSOR PLACEHOLDER (criar ANTES do grid)
3597:         *-- ===================================================================
3598: 
3599:         *-- cursor_4c_Cmv - historico valor do grama produzido (grdCmv)
3600:         IF USED("cursor_4c_Cmv")
3601:             USE IN cursor_4c_Cmv
3602:         ENDIF
3603:         SET NULL ON
3604:         CREATE CURSOR cursor_4c_Cmv (datas C(7), valcuss N(10,2), moedas C(3))
3605:         SET NULL OFF
3606: 
3607:         *-- ===================================================================
3608:         *-- LABELS
3609:         *-- ===================================================================
3610: 
3611:         *-- Say16: Grupo C.C.
3612:         loc_oPg.AddObject("lbl_4c_Say16", "Label")
3613:         WITH loc_oPg.lbl_4c_Say16
3614:             .Caption  = "Grupo C.C. :"
3615:             .Top      = 165
3616:             .Left     = 138
3617:             .Width    = 63
3618:             .Height   = 15
3619:             .FontName = "Tahoma"
3620:             .FontSize = 8
3621:             .AutoSize = .F.
3622:             .Visible  = .T.
3623:         ENDWITH
3624: 
3625:         *-- Say17: Conta C.C.
3626:         loc_oPg.AddObject("lbl_4c_Say17", "Label")
3627:         WITH loc_oPg.lbl_4c_Say17
3628:             .Caption  = "Conta C.C. :"
3629:             .Top      = 189
3630:             .Left     = 138
3631:             .Width    = 63

*-- Linhas 3898 a 4199:
3898:             .InputMask = "!!!!!!!!!!"
3899:             .Visible   = .T.
3900:         ENDWITH
3901:         BINDEVENT(loc_oPg.txt_4c_Gruccus, "KeyPress", THIS, "TxtGruccusKeyPress")
3902:         BINDEVENT(loc_oPg.txt_4c_Gruccus, "DblClick", THIS, "AbrirLookupGruccus")
3903: 
3904:         *-- get_dgruccus (txt_4c_Dgruccus): Grupo C.C. descricao - T:161, L:288, W:318, H:23
3905:         loc_oPg.AddObject("txt_4c_Dgruccus", "TextBox")
3906:         WITH loc_oPg.txt_4c_Dgruccus
3907:             .Value    = ""
3908:             .Top      = 161
3909:             .Left     = 288
3910:             .Width    = 318
3911:             .Height   = 23
3912:             .FontName = "Tahoma"
3913:             .FontSize = 8
3914:             .Visible  = .T.
3915:         ENDWITH
3916:         BINDEVENT(loc_oPg.txt_4c_Dgruccus, "KeyPress", THIS, "TxtDgruccusKeyPress")
3917:         BINDEVENT(loc_oPg.txt_4c_Dgruccus, "DblClick", THIS, "AbrirLookupDgruccus")
3918: 
3919:         *-- get_contaccus (txt_4c_Contaccus): Conta C.C. codigo - T:186, L:206, W:80, H:23
3920:         loc_oPg.AddObject("txt_4c_Contaccus", "TextBox")
3921:         WITH loc_oPg.txt_4c_Contaccus
3922:             .Value     = ""
3923:             .Top       = 186
3924:             .Left      = 206
3925:             .Width     = 80
3926:             .Height    = 23
3927:             .FontName  = "Tahoma"
3928:             .FontSize  = 8
3929:             .InputMask = "!!!!!!!!!!"
3930:             .Visible   = .T.
3931:         ENDWITH
3932:         BINDEVENT(loc_oPg.txt_4c_Contaccus, "KeyPress", THIS, "TxtContaccusKeyPress")
3933:         BINDEVENT(loc_oPg.txt_4c_Contaccus, "DblClick", THIS, "AbrirLookupContaccus")
3934: 
3935:         *-- get_dcontaccus (txt_4c_Dcontaccus): Conta C.C. descricao - T:186, L:288, W:318, H:23
3936:         loc_oPg.AddObject("txt_4c_Dcontaccus", "TextBox")
3937:         WITH loc_oPg.txt_4c_Dcontaccus
3938:             .Value    = ""
3939:             .Top      = 186
3940:             .Left     = 288
3941:             .Width    = 318
3942:             .Height   = 23
3943:             .FontName = "Tahoma"
3944:             .FontSize = 8
3945:             .Visible  = .T.
3946:         ENDWITH
3947:         BINDEVENT(loc_oPg.txt_4c_Dcontaccus, "KeyPress", THIS, "TxtDcontaccusKeyPress")
3948:         BINDEVENT(loc_oPg.txt_4c_Dcontaccus, "DblClick", THIS, "AbrirLookupDcontaccus")
3949: 
3950:         *-- ===================================================================
3951:         *-- TEXTBOXES - Classificacao Fiscal (NCM)
3952:         *-- ===================================================================
3953: 
3954:         *-- getClfiscal (txt_4c_Clfiscal): NCM codigo - T:211, L:206, W:94, H:23
3955:         loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
3956:         WITH loc_oPg.txt_4c_Clfiscal
3957:             .Value     = ""
3958:             .Top       = 211
3959:             .Left      = 206
3960:             .Width     = 94
3961:             .Height    = 23
3962:             .FontName  = "Tahoma"
3963:             .FontSize  = 8
3964:             .InputMask = "9999.99.99"
3965:             .Visible   = .T.
3966:         ENDWITH
3967:         BINDEVENT(loc_oPg.txt_4c_Clfiscal, "KeyPress", THIS, "TxtClfiscalKeyPress")
3968:         BINDEVENT(loc_oPg.txt_4c_Clfiscal, "DblClick", THIS, "AbrirLookupClfiscal")
3969: 
3970:         *-- getDclfiscal (txt_4c_Dclfiscal): NCM descricao - T:211, L:303, W:303, H:23
3971:         loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
3972:         WITH loc_oPg.txt_4c_Dclfiscal
3973:             .Value    = ""
3974:             .Top      = 211
3975:             .Left     = 303
3976:             .Width    = 303
3977:             .Height   = 23
3978:             .FontName = "Tahoma"
3979:             .FontSize = 8
3980:             .Visible  = .T.
3981:         ENDWITH
3982:         BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "KeyPress", THIS, "TxtDclfiscalKeyPress")
3983:         BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "DblClick", THIS, "AbrirLookupDclfiscal")
3984: 
3985:         *-- ===================================================================
3986:         *-- TEXTBOXES - Origem da Mercadoria
3987:         *-- ===================================================================
3988: 
3989:         *-- getOrigmerc (txt_4c_Origmerc): Origem codigo - T:236, L:206, W:17, H:23
3990:         loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
3991:         WITH loc_oPg.txt_4c_Origmerc
3992:             .Value     = ""
3993:             .Top       = 236
3994:             .Left      = 206
3995:             .Width     = 17
3996:             .Height    = 23
3997:             .FontName  = "Tahoma"
3998:             .FontSize  = 8
3999:             .MaxLength = 1
4000:             .Visible   = .T.
4001:         ENDWITH
4002:         BINDEVENT(loc_oPg.txt_4c_Origmerc, "KeyPress", THIS, "TxtOrigmercKeyPress")
4003:         BINDEVENT(loc_oPg.txt_4c_Origmerc, "DblClick", THIS, "AbrirLookupOrigmerc")
4004: 
4005:         *-- getDorigmerc (txt_4c_Dorigmerc): Origem descricao - T:236, L:226, W:380, H:23
4006:         loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")
4007:         WITH loc_oPg.txt_4c_Dorigmerc
4008:             .Value    = ""
4009:             .Top      = 236
4010:             .Left     = 226
4011:             .Width    = 380
4012:             .Height   = 23
4013:             .FontName = "Tahoma"
4014:             .FontSize = 8
4015:             .Visible  = .T.
4016:         ENDWITH
4017:         BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "KeyPress", THIS, "TxtDorigmercKeyPress")
4018:         BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "DblClick", THIS, "AbrirLookupDorigmerc")
4019: 
4020:         *-- ===================================================================
4021:         *-- TEXTBOXES - Situacao Tributaria ICMS
4022:         *-- ===================================================================
4023: 
4024:         *-- getSittricm (txt_4c_Sittricm): ICMS codigo - T:261, L:206, W:31, H:23
4025:         loc_oPg.AddObject("txt_4c_Sittricm", "TextBox")
4026:         WITH loc_oPg.txt_4c_Sittricm
4027:             .Value     = ""
4028:             .Top       = 261
4029:             .Left      = 206
4030:             .Width     = 31
4031:             .Height    = 23
4032:             .FontName  = "Tahoma"
4033:             .FontSize  = 8
4034:             .InputMask = "!!!"
4035:             .Visible   = .T.
4036:         ENDWITH
4037:         BINDEVENT(loc_oPg.txt_4c_Sittricm, "KeyPress", THIS, "TxtSittricmKeyPress")
4038:         BINDEVENT(loc_oPg.txt_4c_Sittricm, "DblClick", THIS, "AbrirLookupSittricm")
4039: 
4040:         *-- getDsittricm (txt_4c_Dsittricm): ICMS descricao - T:261, L:240, W:366, H:23
4041:         loc_oPg.AddObject("txt_4c_Dsittricm", "TextBox")
4042:         WITH loc_oPg.txt_4c_Dsittricm
4043:             .Value    = ""
4044:             .Top      = 261
4045:             .Left     = 240
4046:             .Width    = 366
4047:             .Height   = 23
4048:             .FontName = "Tahoma"
4049:             .FontSize = 8
4050:             .Visible  = .T.
4051:         ENDWITH
4052:         BINDEVENT(loc_oPg.txt_4c_Dsittricm, "KeyPress", THIS, "TxtDsittricmKeyPress")
4053:         BINDEVENT(loc_oPg.txt_4c_Dsittricm, "DblClick", THIS, "AbrirLookupDsittricm")
4054: 
4055:         *-- ===================================================================
4056:         *-- TEXTBOXES - Linha de Servicos ICMS, Aliquotas, Tipo, IAT
4057:         *-- ===================================================================
4058: 
4059:         *-- Get_CodServs (txt_4c_CodServs): Codigo de Servicos - T:286, L:206, W:38, H:23
4060:         loc_oPg.AddObject("txt_4c_CodServs", "TextBox")
4061:         WITH loc_oPg.txt_4c_CodServs
4062:             .Value     = ""
4063:             .Top       = 286
4064:             .Left      = 206
4065:             .Width     = 38
4066:             .Height    = 23
4067:             .FontName  = "Tahoma"
4068:             .FontSize  = 8
4069:             .InputMask = "!!!"
4070:             .Visible   = .T.
4071:         ENDWITH
4072:         BINDEVENT(loc_oPg.txt_4c_CodServs, "KeyPress", THIS, "TxtCodServsKeyPress")
4073:         BINDEVENT(loc_oPg.txt_4c_CodServs, "DblClick", THIS, "AbrirLookupCodServs")
4074: 
4075:         *-- getIcms (txt_4c_Icms): Aliquota ICMS - T:286, L:342, W:45, H:23
4076:         loc_oPg.AddObject("txt_4c_Icms", "TextBox")
4077:         WITH loc_oPg.txt_4c_Icms
4078:             .Value     = 0
4079:             .Top       = 286
4080:             .Left      = 342
4081:             .Width     = 45
4082:             .Height    = 23
4083:             .FontName  = "Tahoma"
4084:             .FontSize  = 8
4085:             .InputMask = "999.99"
4086:             .Visible   = .T.
4087:         ENDWITH
4088: 
4089:         *-- Get_TpTrib (txt_4c_TpTrib): Tipo de Tributacao - T:286, L:513, W:38, H:23
4090:         loc_oPg.AddObject("txt_4c_TpTrib", "TextBox")
4091:         WITH loc_oPg.txt_4c_TpTrib
4092:             .Value     = ""
4093:             .Top       = 286
4094:             .Left      = 513
4095:             .Width     = 38
4096:             .Height    = 23
4097:             .FontName  = "Tahoma"
4098:             .FontSize  = 8
4099:             .InputMask = "!!!!"
4100:             .Visible   = .T.
4101:         ENDWITH
4102:         BINDEVENT(loc_oPg.txt_4c_TpTrib, "KeyPress", THIS, "TxtTpTribKeyPress")
4103:         BINDEVENT(loc_oPg.txt_4c_TpTrib, "DblClick", THIS, "AbrirLookupTpTrib")
4104: 
4105:         *-- getiat (txt_4c_Iat): IAT Arredondamento/Truncamento - T:286, L:589, W:17, H:23
4106:         loc_oPg.AddObject("txt_4c_Iat", "TextBox")
4107:         WITH loc_oPg.txt_4c_Iat
4108:             .Value     = ""
4109:             .Top       = 286
4110:             .Left      = 589
4111:             .Width     = 17
4112:             .Height    = 23
4113:             .FontName  = "Tahoma"
4114:             .FontSize  = 8
4115:             .MaxLength = 1
4116:             .InputMask = "!"
4117:             .Visible   = .T.
4118:         ENDWITH
4119:         BINDEVENT(loc_oPg.txt_4c_Iat, "LostFocus", THIS, "ValidarIat")
4120: 
4121:         *-- ===================================================================
4122:         *-- COMBOBOX - Situacao Tributaria IPI
4123:         *-- ===================================================================
4124: 
4125:         *-- cmbIpi (cbo_4c_CmbIpi): Sit. Trib. IPI - T:311, L:206, W:108, H:25
4126:         loc_oPg.AddObject("cbo_4c_CmbIpi", "ComboBox")
4127:         WITH loc_oPg.cbo_4c_CmbIpi
4128:             .Top      = 311
4129:             .Left     = 206
4130:             .Width    = 108
4131:             .Height   = 25
4132:             .FontName = "Tahoma"
4133:             .FontSize = 8
4134:             .Style    = 2
4135:             .Visible  = .T.
4136:         ENDWITH
4137:         loc_oPg.cbo_4c_CmbIpi.AddItem("")
4138:         loc_oPg.cbo_4c_CmbIpi.AddItem("Tributado")
4139:         loc_oPg.cbo_4c_CmbIpi.AddItem("Isento")
4140:         loc_oPg.cbo_4c_CmbIpi.AddItem("Outros")
4141: 
4142:         *-- ===================================================================
4143:         *-- TEXTBOXES - Aliquota IPI e Excecao TIPI
4144:         *-- ===================================================================
4145: 
4146:         *-- Get_AliqIPI (txt_4c_AliqIPI): Aliquota de IPI - T:311, L:425, W:45, H:25
4147:         loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
4148:         WITH loc_oPg.txt_4c_AliqIPI
4149:             .Value     = 0
4150:             .Top       = 311
4151:             .Left      = 425
4152:             .Width     = 45
4153:             .Height    = 25
4154:             .FontName  = "Tahoma"
4155:             .FontSize  = 8
4156:             .InputMask = "999.99"
4157:             .Visible   = .T.
4158:         ENDWITH
4159:         BINDEVENT(loc_oPg.txt_4c_AliqIPI, "LostFocus", THIS, "ValidarAliqIPI")
4160: 
4161:         *-- getextipi (txt_4c_Extipi): Excecao da TIPI - T:311, L:601, W:35, H:25
4162:         loc_oPg.AddObject("txt_4c_Extipi", "TextBox")
4163:         WITH loc_oPg.txt_4c_Extipi
4164:             .Value     = ""
4165:             .Top       = 311
4166:             .Left      = 601
4167:             .Width     = 35
4168:             .Height    = 25
4169:             .FontName  = "Tahoma"
4170:             .FontSize  = 8
4171:             .InputMask = "!!!!!"
4172:             .Visible   = .T.
4173:         ENDWITH
4174: 
4175:         *-- ===================================================================
4176:         *-- EDITBOX - Descricao Fiscal (memo)
4177:         *-- ===================================================================
4178: 
4179:         *-- mgetdescfi (obj_4c_Mgetdescfi): T:338, L:206, W:509, H:89
4180:         loc_oPg.AddObject("obj_4c_Mgetdescfi", "EditBox")
4181:         WITH loc_oPg.obj_4c_Mgetdescfi
4182:             .Value      = ""
4183:             .Top        = 338
4184:             .Left       = 206
4185:             .Width      = 509
4186:             .Height     = 89
4187:             .FontName   = "Tahoma"
4188:             .FontSize   = 8
4189:             .ScrollBars = 2
4190:             .Visible    = .T.
4191:         ENDWITH
4192: 
4193:         *-- ===================================================================
4194:         *-- COMMANDBUTTON - Gerar Descricao Fiscal
4195:         *-- ===================================================================
4196: 
4197:         *-- btnDescFis (cmd_4c_BtnDescFis): T:359, L:162, W:26, H:26
4198:         loc_oPg.AddObject("cmd_4c_BtnDescFis", "CommandButton")
4199:         WITH loc_oPg.cmd_4c_BtnDescFis

*-- Linhas 4207 a 4250:
4207:             .Themes   = .F.
4208:             .Visible  = .T.
4209:         ENDWITH
4210:         BINDEVENT(loc_oPg.cmd_4c_BtnDescFis, "Click", THIS, "CmdBtnDescFisClick")
4211: 
4212:         *-- ===================================================================
4213:         *-- GRID - Historico Valor do Grama Produzido (grdCmv)
4214:         *-- T:338, L:754, W:223, H:141, 3 colunas: Periodo / Valor Custo GR / Moe
4215:         *-- ===================================================================
4216: 
4217:         loc_oPg.AddObject("grd_4c_Dados", "Grid")
4218:         loc_oGrd = loc_oPg.grd_4c_Dados
4219:         WITH loc_oGrd
4220:             .Top         = 338
4221:             .Left        = 754
4222:             .Width       = 223
4223:             .Height      = 141
4224:             .FontName    = "Tahoma"
4225:             .FontSize    = 8
4226:             .RecordMark  = .F.
4227:             .DeleteMark  = .F.
4228:             .GridLines   = 3
4229:             .ReadOnly    = .T.
4230:             .RowHeight   = 16
4231:             .ScrollBars  = 2
4232:             .Themes      = .F.
4233:             .ColumnCount = 3
4234:             .Visible     = .T.
4235:         ENDWITH
4236: 
4237:         *-- Cabecalhos ANTES do RecordSource
4238:         loc_oGrd.Column1.Header1.Caption = "Per" + CHR(237) + "odo"
4239:         loc_oGrd.Column2.Header1.Caption = "Valor Custo GR"
4240:         loc_oGrd.Column3.Header1.Caption = "Moe"
4241: 
4242:         *-- Larguras das colunas
4243:         WITH loc_oGrd.Column1
4244:             .Width     = 60
4245:             .Movable   = .F.
4246:             .Resizable = .F.
4247:         ENDWITH
4248:         WITH loc_oGrd.Column2
4249:             .Width     = 120
4250:             .Movable   = .F.

*-- Linhas 4299 a 4441:
4299:             .InputMask = "!!!!!!!!!!"
4300:             .Visible   = .T.
4301:         ENDWITH
4302:         BINDEVENT(loc_oPg.txt_4c_Metal, "KeyPress", THIS, "TxtMetalKeyPress")
4303:         BINDEVENT(loc_oPg.txt_4c_Metal, "DblClick", THIS, "AbrirLookupMetal")
4304: 
4305:         *-- Get_DesMetal (txt_4c_DesMetal): Metal descricao - T:429, L:564, W:150, H:23 (READ-ONLY)
4306:         loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
4307:         WITH loc_oPg.txt_4c_DesMetal
4308:             .Value    = ""
4309:             .Top      = 429
4310:             .Left     = 564
4311:             .Width    = 150
4312:             .Height   = 23
4313:             .FontName = "Tahoma"
4314:             .FontSize = 8
4315:             .ReadOnly = .T.
4316:             .Visible  = .T.
4317:         ENDWITH
4318: 
4319:         *-- getValor (txt_4c_Valor): Valor Estimado - T:454, L:206, W:108, H:23
4320:         loc_oPg.AddObject("txt_4c_Valor", "TextBox")
4321:         WITH loc_oPg.txt_4c_Valor
4322:             .Value     = 0
4323:             .Top       = 454
4324:             .Left      = 206
4325:             .Width     = 108
4326:             .Height    = 23
4327:             .FontName  = "Tahoma"
4328:             .FontSize  = 8
4329:             .InputMask = "9,999,999.9999"
4330:             .Visible   = .T.
4331:         ENDWITH
4332: 
4333:         *-- GetMvalor (txt_4c_Mvalor): Moeda do Valor Estimado - T:454, L:317, W:31, H:23
4334:         loc_oPg.AddObject("txt_4c_Mvalor", "TextBox")
4335:         WITH loc_oPg.txt_4c_Mvalor
4336:             .Value     = ""
4337:             .Top       = 454
4338:             .Left      = 317
4339:             .Width     = 31
4340:             .Height    = 23
4341:             .FontName  = "Tahoma"
4342:             .FontSize  = 8
4343:             .InputMask = "!!!"
4344:             .Visible   = .T.
4345:         ENDWITH
4346:         BINDEVENT(loc_oPg.txt_4c_Mvalor, "KeyPress", THIS, "TxtMvalorKeyPress")
4347:         BINDEVENT(loc_oPg.txt_4c_Mvalor, "DblClick", THIS, "AbrirLookupMvalor")
4348: 
4349:         *-- Get_teor (txt_4c_Teor): Teor codigo - T:454, L:537, W:24, H:23
4350:         loc_oPg.AddObject("txt_4c_Teor", "TextBox")
4351:         WITH loc_oPg.txt_4c_Teor
4352:             .Value     = ""
4353:             .Top       = 454
4354:             .Left      = 537
4355:             .Width     = 24
4356:             .Height    = 23
4357:             .FontName  = "Tahoma"
4358:             .FontSize  = 8
4359:             .InputMask = "!!!!!!!!!!"
4360:             .Visible   = .T.
4361:         ENDWITH
4362:         BINDEVENT(loc_oPg.txt_4c_Teor, "KeyPress", THIS, "TxtTeorKeyPress")
4363:         BINDEVENT(loc_oPg.txt_4c_Teor, "DblClick", THIS, "AbrirLookupTeor")
4364: 
4365:         *-- Get_DesTeor (txt_4c_DesTeor): Teor descricao - T:454, L:564, W:150, H:23 (READ-ONLY)
4366:         loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
4367:         WITH loc_oPg.txt_4c_DesTeor
4368:             .Value    = ""
4369:             .Top      = 454
4370:             .Left     = 564
4371:             .Width    = 150
4372:             .Height   = 23
4373:             .FontName = "Tahoma"
4374:             .FontSize = 8
4375:             .ReadOnly = .T.
4376:             .Visible  = .T.
4377:         ENDWITH
4378: 
4379:         *-- getIPPTCST (txt_4c_IPPTCST): IPPT/CST - T:479, L:206, W:108, H:23 (READ-ONLY)
4380:         loc_oPg.AddObject("txt_4c_IPPTCST", "TextBox")
4381:         WITH loc_oPg.txt_4c_IPPTCST
4382:             .Value    = ""
4383:             .Top      = 479
4384:             .Left     = 206
4385:             .Width    = 108
4386:             .Height   = 23
4387:             .FontName = "Tahoma"
4388:             .FontSize = 8
4389:             .ReadOnly = .T.
4390:             .Visible  = .T.
4391:         ENDWITH
4392: 
4393:     ENDPROC
4394: 
4395:     *--------------------------------------------------------------------------
4396:     * ConfigurarPgpgCusto - Aba "Custo" do PageFrame interno (pgCusto)
4397:     * Fase 10: Sub-pagina Custo - grdCompo 12 colunas, cmbTipos, cmdgCusto,
4398:     *          GradeGRUPO2 (totais por grupo), labels e shape
4399:     * Posicoes: valores do layout.json (pgf_4c_Dados.Tabs=.F. -> sem +29)
4400:     *--------------------------------------------------------------------------
4401:     PROTECTED PROCEDURE ConfigurarPgpgCusto(par_oPage)
4402:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
4403: 
4404:         loc_oPg = par_oPage
4405: 
4406:         *-- ===================================================================
4407:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
4408:         *-- ===================================================================
4409: 
4410:         *-- cursor_4c_CustoCompo - composicao custo (SIGPRCPO filtrado por tipo)
4411:         IF USED("cursor_4c_CustoCompo")
4412:             USE IN cursor_4c_CustoCompo
4413:         ENDIF
4414:         SET NULL ON
4415:         CREATE CURSOR cursor_4c_CustoCompo ( ;
4416:             mats      C(14), dcompos C(40), unicompos C(3),  ;
4417:             pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
4418:             moeds     C(3), obscompos C(10), etiqs C(1),     ;
4419:             qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
4420:             CGrus     C(3), tipos C(20))
4421:         SET NULL OFF
4422: 
4423:         *-- cursor_4c_TotGrupoCusto - totais por grupo custo (calculado)
4424:         IF USED("cursor_4c_TotGrupoCusto")
4425:             USE IN cursor_4c_TotGrupoCusto
4426:         ENDIF
4427:         SET NULL ON
4428:         CREATE CURSOR cursor_4c_TotGrupoCusto ( ;
4429:             Grupo     C(3), ValGrupo N(11,3), Moeda C(3))
4430:         SET NULL OFF
4431: 
4432:         *-- ===================================================================
4433:         *-- COMBO cbo_4c_CmbTipos (cmbTipos: top=154, left=143, w=187, h=23)
4434:         *-- ===================================================================
4435:         loc_oPg.AddObject("cbo_4c_CmbTipos", "ComboBox")
4436:         WITH loc_oPg.cbo_4c_CmbTipos
4437:             .Top           = 154
4438:             .Left          = 143
4439:             .Width         = 187
4440:             .Height        = 23
4441:             .FontName      = "Tahoma"

*-- Linhas 4447 a 4490:
4447:             .Themes        = .F.
4448:             .Visible       = .T.
4449:         ENDWITH
4450:         BINDEVENT(loc_oPg.cbo_4c_CmbTipos, "InteractiveChange", THIS, "CboTiposCustoInteractiveChange")
4451: 
4452:         *-- LABEL lbl_4c_Label1 (Say1 "Tipo :": top=159, left=112, w=29, h=15)
4453:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
4454:         WITH loc_oPg.lbl_4c_Label1
4455:             .Caption   = "Tipo :"
4456:             .Top       = 159
4457:             .Left      = 112
4458:             .Width     = 29
4459:             .Height    = 15
4460:             .BackStyle = 0
4461:             .ForeColor = RGB(90, 90, 90)
4462:             .FontName  = "Tahoma"
4463:             .FontSize  = 8
4464:             .Visible   = .T.
4465:         ENDWITH
4466: 
4467:         *-- ===================================================================
4468:         *-- GRID grd_4c_CustoCompo (grdCompo: top=178, left=34, w=813, h=230)
4469:         *-- 12 colunas de SIGPRCPO
4470:         *-- ===================================================================
4471:         loc_oPg.AddObject("grd_4c_CustoCompo", "Grid")
4472:         loc_oGrd = loc_oPg.grd_4c_CustoCompo
4473:         WITH loc_oGrd
4474:             .Top         = 178
4475:             .Left        = 34
4476:             .Width       = 813
4477:             .Height      = 230
4478:             .FontName    = "Tahoma"
4479:             .FontSize    = 8
4480:             .RecordMark  = .F.
4481:             .DeleteMark  = .F.
4482:             .GridLines   = 3
4483:             .ReadOnly    = .F.
4484:             .RowHeight   = 16
4485:             .ScrollBars  = 2
4486:             .Themes      = .F.
4487:             .ColumnCount = 12
4488:             .Visible     = .T.
4489:         ENDWITH
4490: 

*-- Linhas 4606 a 4692:
4606:         loc_oGrd.Column11.Width = 59
4607:         loc_oGrd.Column12.Width = 24
4608: 
4609:         *-- BINDEVENT grd_4c_CustoCompo
4610:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdCustoCompoAfterRowColChange")
4611: 
4612:         *-- ===================================================================
4613:         *-- COMMANDGROUP obj_4c_CmdgCusto (cmdgCompo: top=240, left=851, w=50, h=90)
4614:         *-- 2 botoes: Inserir, Excluir
4615:         *-- ===================================================================
4616:         loc_oPg.AddObject("obj_4c_CmdgCusto", "CommandGroup")
4617:         WITH loc_oPg.obj_4c_CmdgCusto
4618:             .ButtonCount   = 2
4619:             .BorderStyle   = 0
4620:             .Top           = 240
4621:             .Left          = 851
4622:             .Width         = 50
4623:             .Height        = 90
4624:             .BackColor     = RGB(162, 214, 242)
4625:             .Themes        = .F.
4626:             .Visible       = .T.
4627:         ENDWITH
4628:         WITH loc_oPg.obj_4c_CmdgCusto
4629:             .Buttons(1).Top           = 5
4630:             .Buttons(1).Left          = 5
4631:             .Buttons(1).Height        = 40
4632:             .Buttons(1).Width         = 40
4633:             .Buttons(1).Caption       = ""
4634:             .Buttons(1).Picture       = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
4635:             .Buttons(1).ToolTipText   = "Inserir Item"
4636:             .Buttons(1).SpecialEffect = 0
4637:             .Buttons(1).BackColor     = RGB(255, 255, 255)
4638:             .Buttons(1).ForeColor     = RGB(0, 0, 0)
4639:             .Buttons(1).Themes        = .F.
4640:             .Buttons(2).Top           = 45
4641:             .Buttons(2).Left          = 5
4642:             .Buttons(2).Height        = 40
4643:             .Buttons(2).Width         = 40
4644:             .Buttons(2).Caption       = ""
4645:             .Buttons(2).Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
4646:             .Buttons(2).ToolTipText   = "Excluir Item"
4647:             .Buttons(2).SpecialEffect = 0
4648:             .Buttons(2).BackColor     = RGB(255, 255, 255)
4649:             .Buttons(2).ForeColor     = RGB(0, 0, 0)
4650:             .Buttons(2).Themes        = .F.
4651:         ENDWITH
4652:         BINDEVENT(loc_oPg.obj_4c_CmdgCusto, "Click", THIS, "CmdgCustoClick")
4653: 
4654:         *-- ===================================================================
4655:         *-- LABEL + TEXTBOX para descricao e grupo do item selecionado
4656:         *-- ===================================================================
4657: 
4658:         *-- LABEL lbl_4c_Label16 (Say16 "Descricao :": top=415, left=52, w=55, h=15)
4659:         loc_oPg.AddObject("lbl_4c_Label16", "Label")
4660:         WITH loc_oPg.lbl_4c_Label16
4661:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
4662:             .Top       = 415
4663:             .Left      = 52
4664:             .Width     = 55
4665:             .Height    = 15
4666:             .BackStyle = 0
4667:             .ForeColor = RGB(90, 90, 90)
4668:             .FontName  = "Tahoma"
4669:             .FontSize  = 8
4670:             .Visible   = .T.
4671:         ENDWITH
4672: 
4673:         *-- TEXTBOX txt_4c_Desc (Get_Desc: top=412, left=116, w=304, h=21, ReadOnly)
4674:         loc_oPg.AddObject("txt_4c_Desc", "TextBox")
4675:         WITH loc_oPg.txt_4c_Desc
4676:             .Value     = ""
4677:             .Top       = 412
4678:             .Left      = 116
4679:             .Width     = 304
4680:             .Height    = 21
4681:             .FontName  = "Tahoma"
4682:             .FontSize  = 8
4683:             .ReadOnly  = .T.
4684:             .BackColor = RGB(224, 235, 235)
4685:             .Themes    = .F.
4686:             .Visible   = .T.
4687:         ENDWITH
4688: 
4689:         *-- LABEL lbl_4c_Label2 (Say2 "Grupo :": top=415, left=479, w=38, h=15)
4690:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
4691:         WITH loc_oPg.lbl_4c_Label2
4692:             .Caption   = "Grupo :"

*-- Linhas 4812 a 4855:
4812:     * Ordem visual: Mats | Dcompos | Qtds | UniCompos | Grupos | Dscgrp | Ordems | QtsCons | Cats
4813:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
4814:     *--------------------------------------------------------------------------
4815:     PROTECTED PROCEDURE ConfigurarPgPgDadosConsP(par_oPage)
4816:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
4817: 
4818:         loc_oPg = par_oPage
4819: 
4820:         *-- ===================================================================
4821:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
4822:         *-- Campos na ORDEM VISUAL das colunas (sem ColumnOrder)
4823:         *-- ===================================================================
4824: 
4825:         *-- cursor_4c_GrdCons - consumo de produto (baseado em crSigPrCpo)
4826:         *-- Ordem: Mats(cod), Dcompos(desc), Qtds(qtde RO), UniCompos(uni RO),
4827:         *--        Grupos(fase), Dscgrp(desc fase), Ordems(ord RO), QtsCons(consumo), Cats(cat)
4828:         IF USED("cursor_4c_GrdCons")
4829:             USE IN cursor_4c_GrdCons
4830:         ENDIF
4831:         SET NULL ON
4832:         CREATE CURSOR cursor_4c_GrdCons ( ;
4833:             Mats      C(14), ;
4834:             Dcompos   C(40), ;
4835:             Qtds      N(12,4), ;
4836:             UniCompos C(3), ;
4837:             Grupos    C(3), ;
4838:             Dscgrp    C(40), ;
4839:             Ordems    N(3,0), ;
4840:             QtsCons   N(12,4), ;
4841:             Cats      C(3))
4842:         SET NULL OFF
4843: 
4844:         *-- cursor_4c_GrDTEMP - tempo por agrupamento (baseado em crSigProTp)
4845:         IF USED("cursor_4c_GrDTEMP")
4846:             USE IN cursor_4c_GrDTEMP
4847:         ENDIF
4848:         SET NULL ON
4849:         CREATE CURSOR cursor_4c_GrDTEMP ( ;
4850:             agrupas   C(3), ;
4851:             pertemps  N(12,3))
4852:         SET NULL OFF
4853: 
4854:         *-- ===================================================================
4855:         *-- GRID grd_4c_GrdCons

*-- Linhas 4972 a 5016:
4972:         loc_oGrd.Column8.Width = 60
4973:         loc_oGrd.Column9.Width = 52
4974: 
4975:         *-- BINDEVENT grd_4c_GrdCons
4976:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdConsAfterRowColChange")
4977: 
4978:         *-- ===================================================================
4979:         *-- GRID grd_4c_GrDTEMP (grDTEMP: top=519, left=821, w=172, h=107, 2 cols)
4980:         *-- ===================================================================
4981:         loc_oPg.AddObject("grd_4c_GrDTEMP", "Grid")
4982:         loc_oGrd2 = loc_oPg.grd_4c_GrDTEMP
4983:         WITH loc_oGrd2
4984:             .Top         = 519
4985:             .Left        = 821
4986:             .Width       = 172
4987:             .Height      = 107
4988:             .FontName    = "Tahoma"
4989:             .FontSize    = 8
4990:             .RecordMark  = .T.
4991:             .DeleteMark  = .F.
4992:             .GridLines   = 3
4993:             .ReadOnly    = .T.
4994:             .RowHeight   = 17
4995:             .ScrollBars  = 2
4996:             .Themes      = .F.
4997:             .ColumnCount = 2
4998:             .Visible     = .T.
4999:         ENDWITH
5000: 
5001:         *-- Col1: Agrupamento/agrupas (80px, ReadOnly)
5002:         WITH loc_oGrd2.Column1
5003:             .Width     = 80
5004:             .Movable   = .F.
5005:             .Resizable = .F.
5006:             .ReadOnly  = .T.
5007:         ENDWITH
5008:         *-- Col2: Tempo %/pertemps (60px, ReadOnly)
5009:         WITH loc_oGrd2.Column2
5010:             .Width      = 60
5011:             .Movable    = .F.
5012:             .Resizable  = .F.
5013:             .ReadOnly   = .T.
5014:             .InputMask  = "999,999,999.999"
5015:         ENDWITH
5016: 

*-- Linhas 5117 a 5160:
5117:     * ImgFigJpg (foto do processo), ImgBorracha (foto da matriz)
5118:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
5119:     *--------------------------------------------------------------------------
5120:     PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP(par_oPage)
5121:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
5122: 
5123:         loc_oPg = par_oPage
5124: 
5125:         *-- ===================================================================
5126:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
5127:         *-- Campos na ORDEM VISUAL das colunas (sem ColumnOrder)
5128:         *-- ===================================================================
5129: 
5130:         *-- cursor_4c_Fase - fases de processo (baseado em crSigCdPrf)
5131:         *-- Ordem visual: Ordems | Grupos | Descrs | UniPrdts | TpMats
5132:         IF USED("cursor_4c_Fase")
5133:             USE IN cursor_4c_Fase
5134:         ENDIF
5135:         SET NULL ON
5136:         CREATE CURSOR cursor_4c_Fase ( ;
5137:             Ordems    N(3,0), ;
5138:             Grupos    C(10), ;
5139:             Descrs    C(40), ;
5140:             UniPrdts  C(10), ;
5141:             TpMats    C(3), ;
5142:             FigProcs  M, ;
5143:             FkChaves  C(30), ;
5144:             GrpOrdem  C(12))
5145:         SET NULL OFF
5146: 
5147:         *-- cursor_4c_Matrizes - matrizes do produto (baseado em crSigPrMtz)
5148:         *-- Ordem visual: CMats | Locals | QMatz
5149:         IF USED("cursor_4c_Matrizes")
5150:             USE IN cursor_4c_Matrizes
5151:         ENDIF
5152:         SET NULL ON
5153:         CREATE CURSOR cursor_4c_Matrizes ( ;
5154:             CMats     C(14), ;
5155:             Locals    C(20), ;
5156:             QMatz     N(5,2), ;
5157:             CPros     C(14), ;
5158:             cIdChaves C(30), ;
5159:             DPros     C(40))
5160:         SET NULL OFF

*-- Linhas 5245 a 5374:
5245:         loc_oGrd.Column4.Width = 100
5246:         loc_oGrd.Column5.Width = 45
5247: 
5248:         *-- BINDEVENT grd_4c_FasePro
5249:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdFaseAfterRowColChange")
5250:         BINDEVENT(loc_oGrd.Column2.Text1, "Valid", THIS, "FaseGrdCol2Valid")
5251:         BINDEVENT(loc_oGrd.Column4.Text1, "Valid", THIS, "FaseGrdCol4Valid")
5252:         BINDEVENT(loc_oGrd.Column5.Text1, "Valid", THIS, "FaseGrdCol5Valid")
5253: 
5254:         *-- ===================================================================
5255:         *-- COMMANDBUTTON cmd_4c_Incluir (inserir: top=152, left=950, 30x30)
5256:         *-- ===================================================================
5257:         loc_oPg.AddObject("cmd_4c_InsFase", "CommandButton")
5258:         WITH loc_oPg.cmd_4c_InsFase
5259:             .Top             = 152
5260:             .Left            = 950
5261:             .Width           = 30
5262:             .Height          = 30
5263:             .Caption         = ""
5264:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
5265:             .PicturePosition = 13
5266:             .ToolTipText     = "Inserir Fase"
5267:             .FontName        = "Tahoma"
5268:             .FontSize        = 8
5269:             .Themes          = .F.
5270:             .SpecialEffect   = 0
5271:             .BackColor       = RGB(255, 255, 255)
5272:             .Visible         = .T.
5273:         ENDWITH
5274:         BINDEVENT(loc_oPg.cmd_4c_InsFase, "Click", THIS, "FaseInserirClick")
5275: 
5276:         *-- COMMANDBUTTON cmd_4c_ExcFase (excluir: top=192, left=950, 30x30)
5277:         loc_oPg.AddObject("cmd_4c_ExcFase", "CommandButton")
5278:         WITH loc_oPg.cmd_4c_ExcFase
5279:             .Top             = 192
5280:             .Left            = 950
5281:             .Width           = 30
5282:             .Height          = 30
5283:             .Caption         = ""
5284:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
5285:             .PicturePosition = 13
5286:             .ToolTipText     = "Excluir Fase"
5287:             .FontName        = "Tahoma"
5288:             .FontSize        = 8
5289:             .Themes          = .F.
5290:             .SpecialEffect   = 0
5291:             .BackColor       = RGB(255, 255, 255)
5292:             .Visible         = .T.
5293:         ENDWITH
5294:         BINDEVENT(loc_oPg.cmd_4c_ExcFase, "Click", THIS, "FaseExcluirClick")
5295: 
5296:         *-- COMMANDBUTTON cmd_4c_AltFase (Alternativa: top=232, left=950, 30x30)
5297:         loc_oPg.AddObject("cmd_4c_AltFase", "CommandButton")
5298:         WITH loc_oPg.cmd_4c_AltFase
5299:             .Top             = 232
5300:             .Left            = 950
5301:             .Width           = 30
5302:             .Height          = 30
5303:             .Caption         = ""
5304:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
5305:             .PicturePosition = 13
5306:             .ToolTipText     = "Fase Alternativa"
5307:             .FontName        = "Tahoma"
5308:             .FontSize        = 8
5309:             .Themes          = .F.
5310:             .SpecialEffect   = 0
5311:             .BackColor       = RGB(255, 255, 255)
5312:             .Visible         = .T.
5313:         ENDWITH
5314:         BINDEVENT(loc_oPg.cmd_4c_AltFase, "Click", THIS, "FaseAlternativaClick")
5315: 
5316:         *-- COMMANDBUTTON cmd_4c_CmdFicha (CmdFicha: top=152, left=482, 30x30)
5317:         loc_oPg.AddObject("cmd_4c_CmdFicha", "CommandButton")
5318:         WITH loc_oPg.cmd_4c_CmdFicha
5319:             .Top             = 152
5320:             .Left            = 482
5321:             .Width           = 30
5322:             .Height          = 30
5323:             .Caption         = ""
5324:             .Picture         = gc_4c_CaminhoIcones + "relatorio_visualizar_26.jpg"
5325:             .PicturePosition = 13
5326:             .ToolTipText     = "Ficha T" + CHR(233) + "cnica"
5327:             .FontName        = "Tahoma"
5328:             .FontSize        = 8
5329:             .Themes          = .F.
5330:             .SpecialEffect   = 0
5331:             .BackColor       = RGB(255, 255, 255)
5332:             .Visible         = .T.
5333:         ENDWITH
5334:         BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaClick")
5335: 
5336:         *-- ===================================================================
5337:         *-- LABEL + TEXTBOX: Say13/getQmin "Qtd. Min. Producao :" (top=156/152, left=33/137)
5338:         *-- ===================================================================
5339:         loc_oPg.AddObject("lbl_4c_Label13", "Label")
5340:         WITH loc_oPg.lbl_4c_Label13
5341:             .Caption   = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
5342:             .Top       = 156
5343:             .Left      = 33
5344:             .Width     = 102
5345:             .Height    = 15
5346:             .BackStyle = 0
5347:             .ForeColor = RGB(90, 90, 90)
5348:             .FontName  = "Tahoma"
5349:             .FontSize  = 8
5350:             .Visible   = .T.
5351:         ENDWITH
5352: 
5353:         loc_oPg.AddObject("txt_4c_Qmin", "TextBox")
5354:         WITH loc_oPg.txt_4c_Qmin
5355:             .Top           = 152
5356:             .Left          = 137
5357:             .Width         = 80
5358:             .Height        = 23
5359:             .FontName      = "Tahoma"
5360:             .FontSize      = 8
5361:             .SpecialEffect = 1
5362:             .Themes        = .F.
5363:             .ReadOnly      = .F.
5364:             .Alignment     = 3
5365:             .InputMask     = "99999.999"
5366:             .Value         = 0
5367:             .Visible       = .T.
5368:         ENDWITH
5369: 
5370:         *-- ===================================================================
5371:         *-- LABEL + TEXTBOX: Say5/getCodGarras "Garra :" (top=181/177, left=99/137)
5372:         *-- getCodGarras.When = .F. -> ReadOnly
5373:         *-- ===================================================================
5374:         loc_oPg.AddObject("lbl_4c_Label5", "Label")

*-- Linhas 5431 a 5474:
5431:             .Value         = ""
5432:             .Visible       = .T.
5433:         ENDWITH
5434:         BINDEVENT(loc_oPg.txt_4c_Conquilha, "LostFocus", THIS, "ValidarConquilha")
5435: 
5436:         *-- ===================================================================
5437:         *-- LABEL + TEXTBOX: Say9/getPesoBris "Peso Brilhante :" (top=231/227, left=58/137)
5438:         *-- ===================================================================
5439:         loc_oPg.AddObject("lbl_4c_Label9", "Label")
5440:         WITH loc_oPg.lbl_4c_Label9
5441:             .Caption   = "Peso Brilhante :"
5442:             .Top       = 231
5443:             .Left      = 58
5444:             .Width     = 77
5445:             .Height    = 15
5446:             .BackStyle = 0
5447:             .ForeColor = RGB(90, 90, 90)
5448:             .FontName  = "Tahoma"
5449:             .FontSize  = 8
5450:             .Visible   = .T.
5451:         ENDWITH
5452: 
5453:         loc_oPg.AddObject("txt_4c_PesoBris", "TextBox")
5454:         WITH loc_oPg.txt_4c_PesoBris
5455:             .Top           = 227
5456:             .Left          = 137
5457:             .Width         = 80
5458:             .Height        = 23
5459:             .FontName      = "Tahoma"
5460:             .FontSize      = 8
5461:             .SpecialEffect = 1
5462:             .Themes        = .F.
5463:             .ReadOnly      = .F.
5464:             .Alignment     = 3
5465:             .InputMask     = "999.9999"
5466:             .Value         = 0
5467:             .Visible       = .T.
5468:         ENDWITH
5469: 
5470:         *-- ===================================================================
5471:         *-- LABEL + TEXTBOX: Say10/getPesoMetal "Peso Metal :" (top=256/252, left=74/137)
5472:         *-- ===================================================================
5473:         loc_oPg.AddObject("lbl_4c_Label10", "Label")
5474:         WITH loc_oPg.lbl_4c_Label10

*-- Linhas 5566 a 5609:
5566:             .Value         = ""
5567:             .Visible       = .T.
5568:         ENDWITH
5569:         BINDEVENT(loc_oPg.txt_4c_Cor, "LostFocus", THIS, "ValidarCorFaseP")
5570: 
5571:         *-- ===================================================================
5572:         *-- CHECKBOX: opc_CravCera "Cravacao em Cera" (top=306, left=180)
5573:         *-- ===================================================================
5574:         loc_oPg.AddObject("chk_4c_CravCera", "CheckBox")
5575:         WITH loc_oPg.chk_4c_CravCera
5576:             .Caption       = "Crava" + CHR(231) + CHR(227) + "o em Cera"
5577:             .Top           = 306
5578:             .Left          = 180
5579:             .Width         = 110
5580:             .Height        = 15
5581:             .FontName      = "Tahoma"
5582:             .FontSize      = 8
5583:             .BackStyle     = 0
5584:             .Alignment     = 0
5585:             .AutoSize      = .T.
5586:             .SpecialEffect = 1
5587:             .ForeColor     = RGB(90, 90, 90)
5588:             .Themes        = .F.
5589:             .Value         = .F.
5590:             .Visible       = .T.
5591:         ENDWITH
5592: 
5593:         *-- ===================================================================
5594:         *-- LABEL + TEXTBOX: Say2/getTam "Tamanho Padrao :" (top=331/327, left=45/137)
5595:         *-- ===================================================================
5596:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
5597:         WITH loc_oPg.lbl_4c_Label2
5598:             .Caption   = "Tamanho Padr" + CHR(227) + "o :"
5599:             .Top       = 331
5600:             .Left      = 45
5601:             .Width     = 90
5602:             .Height    = 15
5603:             .BackStyle = 0
5604:             .ForeColor = RGB(90, 90, 90)
5605:             .FontName  = "Tahoma"
5606:             .FontSize  = 8
5607:             .Visible   = .T.
5608:         ENDWITH
5609: 

*-- Linhas 5621 a 5664:
5621:             .Value         = ""
5622:             .Visible       = .T.
5623:         ENDWITH
5624:         BINDEVENT(loc_oPg.txt_4c_Tam, "LostFocus", THIS, "ValidarTamFaseP")
5625: 
5626:         *-- ===================================================================
5627:         *-- CHECKBOX: fwoption1 "Peso Variavel" (top=331, left=180)
5628:         *-- ===================================================================
5629:         loc_oPg.AddObject("chk_4c_PesoVar", "CheckBox")
5630:         WITH loc_oPg.chk_4c_PesoVar
5631:             .Caption       = "Peso Vari" + CHR(225) + "vel"
5632:             .Top           = 331
5633:             .Left          = 180
5634:             .Width         = 90
5635:             .Height        = 15
5636:             .FontName      = "Tahoma"
5637:             .FontSize      = 8
5638:             .BackStyle     = 0
5639:             .Alignment     = 0
5640:             .AutoSize      = .T.
5641:             .SpecialEffect = 1
5642:             .ForeColor     = RGB(90, 90, 90)
5643:             .Themes        = .F.
5644:             .Value         = .F.
5645:             .Visible       = .T.
5646:         ENDWITH
5647: 
5648:         *-- ===================================================================
5649:         *-- LABEL + TEXTBOX: lblAcabamento/get_codacb/get_Dacb (top=356/352, left=16/137/177)
5650:         *-- get_Dacb.When = .F. -> ReadOnly (preenchido pelo lookup de codacb)
5651:         *-- ===================================================================
5652:         loc_oPg.AddObject("lbl_4c_LblAcabamento", "Label")
5653:         WITH loc_oPg.lbl_4c_LblAcabamento
5654:             .Caption   = "Acabamento :"
5655:             .Top       = 356
5656:             .Left      = 16
5657:             .Width     = 119
5658:             .Height    = 15
5659:             .BackStyle = 0
5660:             .ForeColor = RGB(90, 90, 90)
5661:             .FontName  = "Tahoma"
5662:             .FontSize  = 8
5663:             .Visible   = .T.
5664:         ENDWITH

*-- Linhas 5677 a 5820:
5677:             .Value         = ""
5678:             .Visible       = .T.
5679:         ENDWITH
5680:         BINDEVENT(loc_oPg.txt_4c_CodAcb, "LostFocus", THIS, "ValidarAcabamento")
5681: 
5682:         loc_oPg.AddObject("txt_4c_Dacb", "TextBox")
5683:         WITH loc_oPg.txt_4c_Dacb
5684:             .Top           = 352
5685:             .Left          = 177
5686:             .Width         = 207
5687:             .Height        = 23
5688:             .FontName      = "Tahoma"
5689:             .FontSize      = 8
5690:             .SpecialEffect = 1
5691:             .Themes        = .F.
5692:             .ReadOnly      = .T.
5693:             .Value         = ""
5694:             .Visible       = .T.
5695:         ENDWITH
5696: 
5697:         *-- ===================================================================
5698:         *-- SHAPE shp_4c_ShpFig (shpFig: top=152, left=231, w=244, h=148)
5699:         *-- IMAGE img_4c_ImgFigJpg (ImgFigJpg: top=153, left=232, w=241, h=146)
5700:         *-- ===================================================================
5701:         loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
5702:         WITH loc_oPg.shp_4c_ShpFig
5703:             .Top         = 152
5704:             .Left        = 231
5705:             .Width       = 244
5706:             .Height      = 148
5707:             .BackColor   = RGB(240, 240, 240)
5708:             .BorderColor = RGB(128, 128, 128)
5709:             .BorderWidth = 1
5710:             .Visible     = .T.
5711:         ENDWITH
5712: 
5713:         loc_oPg.AddObject("img_4c_ImgFigJpg", "Image")
5714:         WITH loc_oPg.img_4c_ImgFigJpg
5715:             .Top     = 153
5716:             .Left    = 232
5717:             .Width   = 241
5718:             .Height  = 146
5719:             .Stretch = 2
5720:             .Visible = .F.
5721:         ENDWITH
5722:         BINDEVENT(loc_oPg.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")
5723: 
5724:         *-- ===================================================================
5725:         *-- COMMANDGROUP obj_4c_CmdgFigura (cmdgFigura: top=192, left=482, 40x40, 1 botao)
5726:         *-- Selecionar foto do processo
5727:         *-- ===================================================================
5728:         loc_oPg.AddObject("obj_4c_CmdgFigura", "CommandGroup")
5729:         WITH loc_oPg.obj_4c_CmdgFigura
5730:             .ButtonCount = 1
5731:             .BorderStyle = 0
5732:             .Top         = 192
5733:             .Left        = 482
5734:             .Width       = 40
5735:             .Height      = 40
5736:             .Themes      = .F.
5737:             .Visible     = .T.
5738:         ENDWITH
5739:         WITH loc_oPg.obj_4c_CmdgFigura
5740:             .Buttons(1).Top           = 0
5741:             .Buttons(1).Left          = 0
5742:             .Buttons(1).Height        = 40
5743:             .Buttons(1).Width         = 40
5744:             .Buttons(1).Caption       = ""
5745:             .Buttons(1).Picture       = gc_4c_CaminhoIcones + "geral_foto_26.jpg"
5746:             .Buttons(1).ToolTipText   = "Selecionar Foto"
5747:             .Buttons(1).SpecialEffect = 0
5748:             .Buttons(1).BackColor     = RGB(255, 255, 255)
5749:             .Buttons(1).Themes        = .F.
5750:         ENDWITH
5751:         BINDEVENT(loc_oPg.obj_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")
5752: 
5753:         *-- ===================================================================
5754:         *-- COMMANDGROUP obj_4c_CmdgFigCam (cmdgFigCam: top=232, left=482, 40x40, 1 botao)
5755:         *-- Capturar da camera
5756:         *-- ===================================================================
5757:         loc_oPg.AddObject("obj_4c_CmdgFigCam", "CommandGroup")
5758:         WITH loc_oPg.obj_4c_CmdgFigCam
5759:             .ButtonCount = 1
5760:             .BorderStyle = 0
5761:             .Top         = 232
5762:             .Left        = 482
5763:             .Width       = 40
5764:             .Height      = 40
5765:             .Themes      = .F.
5766:             .Visible     = .T.
5767:         ENDWITH
5768:         WITH loc_oPg.obj_4c_CmdgFigCam
5769:             .Buttons(1).Top           = 0
5770:             .Buttons(1).Left          = 0
5771:             .Buttons(1).Height        = 40
5772:             .Buttons(1).Width         = 40
5773:             .Buttons(1).Caption       = ""
5774:             .Buttons(1).Picture       = gc_4c_CaminhoIcones + "geral_camera_26.jpg"
5775:             .Buttons(1).ToolTipText   = "Capturar da C" + CHR(226) + "mera"
5776:             .Buttons(1).SpecialEffect = 0
5777:             .Buttons(1).BackColor     = RGB(255, 255, 255)
5778:             .Buttons(1).Themes        = .F.
5779:         ENDWITH
5780:         BINDEVENT(loc_oPg.obj_4c_CmdgFigCam, "Click", THIS, "CmdgFigCamClick")
5781: 
5782:         *-- ===================================================================
5783:         *-- LABEL lbl_4c_Label1 "Descricao :" (Say1: top=474, left=527, w=67, h=17)
5784:         *-- TEXTBOX txt_4c_Desc (Get_Desc: top=471, left=595, w=395, h=23)
5785:         *-- EDITBOX obj_4c_GetObs (Get_Obs: top=497, left=527, w=463, h=122)
5786:         *-- ===================================================================
5787:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
5788:         WITH loc_oPg.lbl_4c_Label1
5789:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
5790:             .Top       = 474
5791:             .Left      = 527
5792:             .Width     = 67
5793:             .Height    = 17
5794:             .BackStyle = 0
5795:             .ForeColor = RGB(90, 90, 90)
5796:             .FontName  = "Tahoma"
5797:             .FontSize  = 8
5798:             .Visible   = .T.
5799:         ENDWITH
5800: 
5801:         loc_oPg.AddObject("txt_4c_Desc", "TextBox")
5802:         WITH loc_oPg.txt_4c_Desc
5803:             .Top           = 471
5804:             .Left          = 595
5805:             .Width         = 395
5806:             .Height        = 23
5807:             .FontName      = "Tahoma"
5808:             .FontSize      = 8
5809:             .SpecialEffect = 1
5810:             .Themes        = .F.
5811:             .ReadOnly      = .F.
5812:             .Value         = ""
5813:             .Visible       = .T.
5814:         ENDWITH
5815: 
5816:         loc_oPg.AddObject("obj_4c_GetObs", "EditBox")
5817:         WITH loc_oPg.obj_4c_GetObs
5818:             .Top           = 497
5819:             .Left          = 527
5820:             .Width         = 463

*-- Linhas 5892 a 6017:
5892:         loc_oGrd2.Column2.Width = 116
5893:         loc_oGrd2.Column3.Width = 50
5894: 
5895:         *-- BINDEVENT grd_4c_Matrizes
5896:         BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
5897:         BINDEVENT(loc_oGrd2.Column1.Text1, "Valid", THIS, "MatrizGrdCol1Valid")
5898: 
5899:         *-- ===================================================================
5900:         *-- COMMANDBUTTON cmd_4c_BtnInsereMtx (btnInsereMtx: top=380, left=258, 30x30)
5901:         *-- ===================================================================
5902:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
5903:         WITH loc_oPg.cmd_4c_BtnInsereMtx
5904:             .Top             = 380
5905:             .Left            = 258
5906:             .Width           = 30
5907:             .Height          = 30
5908:             .Caption         = ""
5909:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
5910:             .PicturePosition = 13
5911:             .ToolTipText     = "Inserir Matriz"
5912:             .FontName        = "Tahoma"
5913:             .FontSize        = 8
5914:             .Themes          = .F.
5915:             .SpecialEffect   = 0
5916:             .BackColor       = RGB(255, 255, 255)
5917:             .Visible         = .T.
5918:         ENDWITH
5919:         BINDEVENT(loc_oPg.cmd_4c_BtnInsereMtx, "Click", THIS, "BtnInsereMtxClick")
5920: 
5921:         *-- COMMANDBUTTON cmd_4c_BtnExcluiMtz (btnExcluiMtz: top=420, left=258, 30x30)
5922:         loc_oPg.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
5923:         WITH loc_oPg.cmd_4c_BtnExcluiMtz
5924:             .Top             = 420
5925:             .Left            = 258
5926:             .Width           = 30
5927:             .Height          = 30
5928:             .Caption         = ""
5929:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
5930:             .PicturePosition = 13
5931:             .ToolTipText     = "Excluir Matriz"
5932:             .FontName        = "Tahoma"
5933:             .FontSize        = 8
5934:             .Themes          = .F.
5935:             .SpecialEffect   = 0
5936:             .BackColor       = RGB(255, 255, 255)
5937:             .Visible         = .T.
5938:         ENDWITH
5939:         BINDEVENT(loc_oPg.cmd_4c_BtnExcluiMtz, "Click", THIS, "BtnExcluiMtzClick")
5940: 
5941:         *-- ===================================================================
5942:         *-- SHAPE shp_4c_ShpBorracha (shpBorracha: top=464, left=258, w=236, h=156)
5943:         *-- IMAGE img_4c_ImgBorracha (ImgBorracha: top=465, left=260, w=232, h=154)
5944:         *-- ===================================================================
5945:         loc_oPg.AddObject("shp_4c_ShpBorracha", "Shape")
5946:         WITH loc_oPg.shp_4c_ShpBorracha
5947:             .Top         = 464
5948:             .Left        = 258
5949:             .Width       = 236
5950:             .Height      = 156
5951:             .BackColor   = RGB(240, 240, 240)
5952:             .BorderColor = RGB(128, 128, 128)
5953:             .BorderWidth = 1
5954:             .Visible     = .T.
5955:         ENDWITH
5956: 
5957:         loc_oPg.AddObject("img_4c_ImgBorracha", "Image")
5958:         WITH loc_oPg.img_4c_ImgBorracha
5959:             .Top     = 465
5960:             .Left    = 260
5961:             .Width   = 232
5962:             .Height  = 154
5963:             .Stretch = 2
5964:             .Visible = .F.
5965:         ENDWITH
5966: 
5967:     ENDPROC
5968: 
5969:     *--------------------------------------------------------------------------
5970:     * ConfigurarPgpgDesigner - Aba "Designer" (Page7 do pgf_4c_Dados)
5971:     * Controles: grd_4c_Designer (4 cols tarefas), obj_4c_GetObsTarefas,
5972:     *            cmd_4c_BtnIniTarefa, cmd_4c_BtnFimTarefa,
5973:     *            grd_4c_Arquivos (1 col), cmd_4c_BtnInsArqs/OpnArqs/ExcArqs,
5974:     *            shp_4c_Shape1, img_4c_ImgArqJpg
5975:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
5976:     *--------------------------------------------------------------------------
5977:     PROTECTED PROCEDURE ConfigurarPgpgDesigner(par_oPage)
5978:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
5979: 
5980:         loc_oPg = par_oPage
5981: 
5982:         *-- ===================================================================
5983:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
5984:         *-- Campos na ORDEM VISUAL das colunas (sem ColumnOrder)
5985:         *-- ===================================================================
5986: 
5987:         *-- cursor_4c_Tarefas - tarefas do designer (baseado em crSigPrTar)
5988:         *-- Ordem visual: DtInis | DtFims | Usuars | Tarefas
5989:         IF USED("cursor_4c_Tarefas")
5990:             USE IN cursor_4c_Tarefas
5991:         ENDIF
5992:         SET NULL ON
5993:         CREATE CURSOR cursor_4c_Tarefas ( ;
5994:             DtInis      T, ;
5995:             DtFims      T, ;
5996:             Usuars      C(10), ;
5997:             Tarefas     C(10), ;
5998:             ObsTarefas  M, ;
5999:             CPros       C(14), ;
6000:             pkChaves    C(30))
6001:         SET NULL OFF
6002: 
6003:         *-- cursor_4c_Arquivos - arquivos do designer (baseado em crSigPrArq)
6004:         IF USED("cursor_4c_Arquivos")
6005:             USE IN cursor_4c_Arquivos
6006:         ENDIF
6007:         SET NULL ON
6008:         CREATE CURSOR cursor_4c_Arquivos ( ;
6009:             Arquivos    C(254), ;
6010:             CPros       C(14), ;
6011:             pkChaves    C(30))
6012:         SET NULL OFF
6013: 
6014:         *-- ===================================================================
6015:         *-- GRID grd_4c_Designer (grdDesigner: top=160, left=10, w=495, h=238, 4 cols)
6016:         *-- crSigPrTar: DtInis T | DtFims T | Usuars C(10) | Tarefas C(10)
6017:         *-- ===================================================================

*-- Linhas 6085 a 6130:
6085:         loc_oGrd.Column3.Width = 100
6086:         loc_oGrd.Column4.Width = 155
6087: 
6088:         *-- BINDEVENT grd_4c_Designer
6089:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")
6090:         BINDEVENT(loc_oGrd.Column4.Text1, "Valid", THIS, "DesignerCol4Valid")
6091: 
6092:         *-- ===================================================================
6093:         *-- LABEL lbl_4c_Say31 ("Observacao da Tarefa": top=144, left=583)
6094:         *-- ===================================================================
6095:         loc_oPg.AddObject("lbl_4c_Say31", "Label")
6096:         WITH loc_oPg.lbl_4c_Say31
6097:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
6098:             .Top       = 144
6099:             .Left      = 583
6100:             .Width     = 120
6101:             .Height    = 15
6102:             .BackStyle = 0
6103:             .ForeColor = RGB(90, 90, 90)
6104:             .FontName  = "Tahoma"
6105:             .FontSize  = 8
6106:             .Visible   = .T.
6107:         ENDWITH
6108: 
6109:         *-- ===================================================================
6110:         *-- EDITBOX obj_4c_GetObsTarefas (getObsTarefas: top=160, left=584, w=407, h=238)
6111:         *-- When: InList(pcEscolha, INSERIR, ALTERAR) -> editavel so em modo edicao
6112:         *-- ===================================================================
6113:         loc_oPg.AddObject("obj_4c_GetObsTarefas", "EditBox")
6114:         WITH loc_oPg.obj_4c_GetObsTarefas
6115:             .Value         = ""
6116:             .Top           = 160
6117:             .Left          = 584
6118:             .Width         = 407
6119:             .Height        = 238
6120:             .FontName      = "Tahoma"
6121:             .FontSize      = 8
6122:             .ScrollBars    = 2
6123:             .ReadOnly      = .F.
6124:             .Themes        = .F.
6125:             .ControlSource = "cursor_4c_Tarefas.ObsTarefas"
6126:             .Visible       = .T.
6127:         ENDWITH
6128: 
6129:         *-- ===================================================================
6130:         *-- COMMANDBUTTON cmd_4c_BtnIniTarefa (btnIniTarefa: top=161, left=509, w=42, h=42)

*-- Linhas 6148 a 7401:
6148:             .BackColor       = RGB(255, 255, 255)
6149:             .Visible         = .T.
6150:         ENDWITH
6151:         BINDEVENT(loc_oPg.cmd_4c_BtnIniTarefa, "Click", THIS, "BtnIniTarefaClick")
6152: 
6153:         *-- ===================================================================
6154:         *-- COMMANDBUTTON cmd_4c_BtnFimTarefa (btnFimTarefa: top=203, left=509, w=42, h=42)
6155:         *-- When: InList(pcEscolha, INSERIR, ALTERAR)
6156:         *-- Click: Valida pertencimento + registra DtFims
6157:         *-- ===================================================================
6158:         loc_oPg.AddObject("cmd_4c_BtnFimTarefa", "CommandButton")
6159:         WITH loc_oPg.cmd_4c_BtnFimTarefa
6160:             .Top             = 203
6161:             .Left            = 509
6162:             .Width           = 42
6163:             .Height          = 42
6164:             .Caption         = ""
6165:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
6166:             .PicturePosition = 13
6167:             .ToolTipText     = "Finalizar Tarefa"
6168:             .FontName        = "Tahoma"
6169:             .FontSize        = 8
6170:             .Themes          = .F.
6171:             .SpecialEffect   = 0
6172:             .BackColor       = RGB(255, 255, 255)
6173:             .Visible         = .T.
6174:         ENDWITH
6175:         BINDEVENT(loc_oPg.cmd_4c_BtnFimTarefa, "Click", THIS, "BtnFimTarefaClick")
6176: 
6177:         *-- ===================================================================
6178:         *-- GRID grd_4c_Arquivos (grdArquivos: top=415, left=10, w=495, h=202, 1 col)
6179:         *-- crSigPrArq: Arquivos C(254)
6180:         *-- ===================================================================
6181:         loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
6182:         loc_oGrd2 = loc_oPg.grd_4c_Arquivos
6183:         WITH loc_oGrd2
6184:             .Top         = 415
6185:             .Left        = 10
6186:             .Width       = 495
6187:             .Height      = 202
6188:             .FontName    = "Tahoma"
6189:             .FontSize    = 8
6190:             .RecordMark  = .F.
6191:             .DeleteMark  = .F.
6192:             .GridLines   = 3
6193:             .ReadOnly    = .F.
6194:             .RowHeight   = 17
6195:             .ScrollBars  = 2
6196:             .Themes      = .F.
6197:             .ColumnCount = 1
6198:             .Visible     = .T.
6199:         ENDWITH
6200: 
6201:         *-- Col1: Arquivos (495px, editavel)
6202:         WITH loc_oGrd2.Column1
6203:             .Width     = 495
6204:             .Movable   = .F.
6205:             .Resizable = .F.
6206:             .Sparse    = .F.
6207:         ENDWITH
6208: 
6209:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
6210:         loc_oGrd2.RecordSource = "cursor_4c_Arquivos"
6211: 
6212:         *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
6213:         loc_oGrd2.Column1.ControlSource = "cursor_4c_Arquivos.Arquivos"
6214: 
6215:         *-- Cabecalho APOS RecordSource
6216:         loc_oGrd2.Column1.Header1.Caption = "Arquivos Para Designer"
6217: 
6218:         *-- Largura re-aplicada APOS RecordSource
6219:         loc_oGrd2.Column1.Width = 495
6220: 
6221:         *-- BINDEVENT grd_4c_Arquivos
6222:         BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")
6223: 
6224:         *-- ===================================================================
6225:         *-- COMMANDBUTTON cmd_4c_BtnInsArqs (btnInsArqs: top=416, left=509, w=42, h=42)
6226:         *-- When: InList(pcEscolha, INSERIR, ALTERAR)
6227:         *-- Click: GetFile -> Insert Into cursor_4c_Arquivos
6228:         *-- ===================================================================
6229:         loc_oPg.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
6230:         WITH loc_oPg.cmd_4c_BtnInsArqs
6231:             .Top             = 416
6232:             .Left            = 509
6233:             .Width           = 42
6234:             .Height          = 42
6235:             .Caption         = ""
6236:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
6237:             .PicturePosition = 13
6238:             .ToolTipText     = "Inserir Arquivo"
6239:             .FontName        = "Tahoma"
6240:             .FontSize        = 8
6241:             .Themes          = .F.
6242:             .SpecialEffect   = 0
6243:             .BackColor       = RGB(255, 255, 255)
6244:             .Visible         = .T.
6245:         ENDWITH
6246:         BINDEVENT(loc_oPg.cmd_4c_BtnInsArqs, "Click", THIS, "BtnInsArqsClick")
6247: 
6248:         *-- ===================================================================
6249:         *-- COMMANDBUTTON cmd_4c_BtnExcArqs (btnExcArqs: top=458, left=509, w=42, h=42)
6250:         *-- When: InList(pcEscolha, INSERIR, ALTERAR)
6251:         *-- Click: Delete from cursor_4c_Arquivos
6252:         *-- ===================================================================
6253:         loc_oPg.AddObject("cmd_4c_BtnExcArqs", "CommandButton")
6254:         WITH loc_oPg.cmd_4c_BtnExcArqs
6255:             .Top             = 458
6256:             .Left            = 509
6257:             .Width           = 42
6258:             .Height          = 42
6259:             .Caption         = ""
6260:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
6261:             .PicturePosition = 13
6262:             .ToolTipText     = "Excluir Arquivo"
6263:             .FontName        = "Tahoma"
6264:             .FontSize        = 8
6265:             .Themes          = .F.
6266:             .SpecialEffect   = 0
6267:             .BackColor       = RGB(255, 255, 255)
6268:             .Visible         = .T.
6269:         ENDWITH
6270:         BINDEVENT(loc_oPg.cmd_4c_BtnExcArqs, "Click", THIS, "BtnExcArqsClick")
6271: 
6272:         *-- ===================================================================
6273:         *-- COMMANDBUTTON cmd_4c_BtnOpnArqs (btnOpnArqs: top=500, left=509, w=42, h=42)
6274:         *-- When: sempre habilitado (.T.)
6275:         *-- Click: Shell.Application.Open(arquivo)
6276:         *-- ===================================================================
6277:         loc_oPg.AddObject("cmd_4c_BtnOpnArqs", "CommandButton")
6278:         WITH loc_oPg.cmd_4c_BtnOpnArqs
6279:             .Top             = 500
6280:             .Left            = 509
6281:             .Width           = 42
6282:             .Height          = 42
6283:             .Caption         = ""
6284:             .Picture         = gc_4c_CaminhoIcones + "relatorio_visualizar_26.jpg"
6285:             .PicturePosition = 13
6286:             .ToolTipText     = "Abrir Arquivo"
6287:             .FontName        = "Tahoma"
6288:             .FontSize        = 8
6289:             .Themes          = .F.
6290:             .SpecialEffect   = 0
6291:             .BackColor       = RGB(255, 255, 255)
6292:             .Visible         = .T.
6293:         ENDWITH
6294:         BINDEVENT(loc_oPg.cmd_4c_BtnOpnArqs, "Click", THIS, "BtnOpnArqsClick")
6295: 
6296:         *-- ===================================================================
6297:         *-- SHAPE shp_4c_Shape1 (Shape1: top=415, left=584, w=407, h=202)
6298:         *-- Borda visual ao redor da area de preview de imagem
6299:         *-- ===================================================================
6300:         loc_oPg.AddObject("shp_4c_Shape1", "Shape")
6301:         WITH loc_oPg.shp_4c_Shape1
6302:             .Top         = 415
6303:             .Left        = 584
6304:             .Width       = 407
6305:             .Height      = 202
6306:             .BorderColor = RGB(128, 128, 128)
6307:             .BorderWidth = 1
6308:             .BackStyle   = 0
6309:             .Visible     = .T.
6310:         ENDWITH
6311: 
6312:         *-- ===================================================================
6313:         *-- IMAGE img_4c_ImgArqJpg (imgArqJpg: top=417, left=586, w=403, h=198)
6314:         *-- Visible=.F. por padrao; exibida ao selecionar arquivo JPG/ICO/BMP/JPEG
6315:         *-- Click: Do Form SigOpZom (zoom do arquivo)
6316:         *-- ===================================================================
6317:         loc_oPg.AddObject("img_4c_ImgArqJpg", "Image")
6318:         WITH loc_oPg.img_4c_ImgArqJpg
6319:             .Top     = 417
6320:             .Left    = 586
6321:             .Width   = 403
6322:             .Height  = 198
6323:             .Stretch = 2
6324:             .Visible = .F.
6325:         ENDWITH
6326:         BINDEVENT(loc_oPg.img_4c_ImgArqJpg, "Click", THIS, "ImgArqJpgClick")
6327: 
6328:     ENDPROC
6329: 
6330:     *--------------------------------------------------------------------------
6331:     * GrdDesignerAfterRowColChange - Handler AfterRowColChange do grd_4c_Designer
6332:     * Atualiza exibicao da observacao da tarefa selecionada
6333:     *--------------------------------------------------------------------------
6334:     PROCEDURE GrdDesignerAfterRowColChange(par_nColIndex)
6335:         LOCAL loc_oPg
6336:         TRY
6337:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
6338:             IF PEMSTATUS(loc_oPg, "obj_4c_GetObsTarefas", 5)
6339:                 loc_oPg.obj_4c_GetObsTarefas.Refresh()
6340:             ENDIF
6341:         CATCH TO loc_oErro
6342:             MsgErro(loc_oErro.Message, "Erro")
6343:         ENDTRY
6344:     ENDPROC
6345: 
6346:     *--------------------------------------------------------------------------
6347:     * DesignerCol4Valid - Valid do Column4 (Tarefa) do grd_4c_Designer
6348:     * Lookup: SigCdCad (CodCads, DesCads) - catalogo de tarefas designer
6349:     *--------------------------------------------------------------------------
6350:     PROCEDURE DesignerCol4Valid(par_nColIndex)
6351:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
6352:         loc_lResultado = .T.
6353:         TRY
6354:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer
6355:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column4.Text1.Value, ""))
6356:             IF EMPTY(loc_cCodigo)
6357:                 loc_lResultado = loc_lResultado
6358:             ENDIF
6359:             loc_lcSQL = "SELECT CodCads, DesCads FROM SigCdCad WHERE CodCads = " + EscaparSQL(loc_cCodigo)
6360:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTarefas") <= 0 OR EOF("cursor_4c_ValTarefas")
6361:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6362:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValCad"
6363:                 loc_oLookup.mAddColuna("CodCads", "", "C" + CHR(243) + "digo")
6364:                 loc_oLookup.mAddColuna("DesCads", "", "Descri" + CHR(231) + CHR(227) + "o")
6365:                 loc_oLookup.cTabela     = "SigCdCad"
6366:                 loc_oLookup.cCampoChave = "CodCads"
6367:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6368:                 loc_oLookup.Show()
6369:                 IF loc_oLookup.this_lSelecionou
6370:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6371:                 ELSE
6372:                     loc_cCodigo = ""
6373:                 ENDIF
6374:             ENDIF
6375:             IF USED("cursor_4c_ValTarefas")
6376:                 USE IN cursor_4c_ValTarefas
6377:             ENDIF
6378:             IF USED("cursor_4c_Tarefas") AND !EOF("cursor_4c_Tarefas")
6379:                 SELECT cursor_4c_Tarefas
6380:                 REPLACE Tarefas WITH PADR(loc_cCodigo, 10) IN cursor_4c_Tarefas
6381:                 loc_oGrd.Column4.Text1.Value = loc_cCodigo
6382:             ENDIF
6383:         CATCH TO loc_oErro
6384:             MsgErro(loc_oErro.Message, "Erro")
6385:         ENDTRY
6386:         RETURN loc_lResultado
6387:     ENDPROC
6388: 
6389:     *--------------------------------------------------------------------------
6390:     * GrdArquivosAfterRowColChange - Handler AfterRowColChange do grd_4c_Arquivos
6391:     * Exibe preview de imagem se arquivo for JPG/ICO/BMP/JPEG
6392:     *--------------------------------------------------------------------------
6393:     PROCEDURE GrdArquivosAfterRowColChange(par_nColIndex)
6394:         LOCAL loc_lcArq, loc_oPg, loc_nPonto
6395:         TRY
6396:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
6397:             CLEAR RESOURCES
6398:             loc_oPg.img_4c_ImgArqJpg.Picture = ""
6399:             loc_oPg.img_4c_ImgArqJpg.Visible = .F.
6400:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
6401:                 RETURN
6402:             ENDIF
6403:             loc_lcArq  = ALLTRIM(cursor_4c_Arquivos.Arquivos)
6404:             loc_nPonto = AT(".", loc_lcArq)
6405:             IF !EMPTY(loc_lcArq) AND loc_nPonto > 0 AND ;
6406:                 INLIST(ALLTRIM(UPPER(SUBSTR(loc_lcArq, loc_nPonto, 5))), ".JPG", ".ICO", ".BMP", ".JPEG")
6407:                 loc_oPg.img_4c_ImgArqJpg.Picture = loc_lcArq
6408:                 loc_oPg.img_4c_ImgArqJpg.Visible = .T.
6409:             ENDIF
6410:         CATCH TO loc_oErro
6411:             MsgErro(loc_oErro.Message, "Erro")
6412:         ENDTRY
6413:     ENDPROC
6414: 
6415:     *--------------------------------------------------------------------------
6416:     * BtnIniTarefaClick - Inicia nova tarefa no grd_4c_Designer
6417:     * Valida: sem tarefa aberta para o usuario + sem tarefa sem codigo
6418:     *--------------------------------------------------------------------------
6419:     PROCEDURE BtnIniTarefaClick()
6420:         LOCAL loc_lResultado, loc_oGrd, loc_tDataHora
6421:         loc_lResultado = .F.
6422:         TRY
6423:             IF !USED("cursor_4c_Tarefas")
6424:                 loc_lResultado = loc_lResultado
6425:             ENDIF
6426:             loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer
6427: 
6428:             *-- Validar: nao pode ter tarefa aberta (DtFims vazia) para este usuario
6429:             SELECT cursor_4c_Tarefas
6430:             GO TOP IN cursor_4c_Tarefas
6431:             LOCATE FOR ALLTRIM(Usuars) = ALLTRIM(gc_4c_UsuarioLogado) AND EMPTY(DtFims)
6432:             IF !EOF("cursor_4c_Tarefas")
6433:                 MsgAviso("Existe Uma Tarefa N" + CHR(227) + "o Encerrada Para Esse Usu" + CHR(225) + "rio!!!")
6434:                 loc_oGrd.Column4.SetFocus()
6435:                 loc_lResultado = loc_lResultado
6436:             ENDIF
6437: 
6438:             *-- Validar: nao pode ter tarefa com codigo vazio para este usuario
6439:             SELECT cursor_4c_Tarefas
6440:             GO TOP IN cursor_4c_Tarefas
6441:             LOCATE FOR ALLTRIM(Usuars) = ALLTRIM(gc_4c_UsuarioLogado) AND EMPTY(Tarefas)
6442:             IF !EOF("cursor_4c_Tarefas")
6443:                 MsgAviso("Existe Uma Tarefa Ainda N" + CHR(227) + "o Informada!!!")
6444:                 loc_oGrd.Column4.SetFocus()
6445:                 loc_lResultado = loc_lResultado
6446:             ENDIF
6447: 
6448:             *-- Inserir nova linha com DtInis = agora, DtFims = vazio ({})
6449:             loc_tDataHora = DATETIME()
6450:             INSERT INTO cursor_4c_Tarefas (DtInis, DtFims, Usuars, Tarefas, CPros, pkChaves) ;
6451:                 VALUES (loc_tDataHora, {}, ;
6452:                         PADR(gc_4c_UsuarioLogado, 10), PADR("", 10), ;
6453:                         PADR(THIS.this_oBusinessObject.this_cCpros, 14), "")
6454: 
6455:             SELECT cursor_4c_Tarefas
6456:             GO BOTTOM IN cursor_4c_Tarefas
6457:             loc_oGrd.Refresh()
6458:             loc_oGrd.Column4.SetFocus()
6459:             loc_lResultado = .T.
6460:         CATCH TO loc_oErro
6461:             MsgErro(loc_oErro.Message, "Erro")
6462:         ENDTRY
6463:         RETURN loc_lResultado
6464:     ENDPROC
6465: 
6466:     *--------------------------------------------------------------------------
6467:     * BtnFimTarefaClick - Finaliza tarefa corrente no grd_4c_Designer
6468:     * Valida: tarefa pertence ao usuario + nao esta ja finalizada
6469:     *--------------------------------------------------------------------------
6470:     PROCEDURE BtnFimTarefaClick()
6471:         LOCAL loc_lResultado, loc_oGrd, loc_tDataHora
6472:         loc_lResultado = .F.
6473:         TRY
6474:             IF !USED("cursor_4c_Tarefas") OR EOF("cursor_4c_Tarefas") OR BOF("cursor_4c_Tarefas")
6475:                 loc_lResultado = loc_lResultado
6476:             ENDIF
6477:             loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer
6478: 
6479:             *-- Validar: tarefa deve pertencer ao usuario logado
6480:             IF ALLTRIM(cursor_4c_Tarefas.Usuars) <> ALLTRIM(gc_4c_UsuarioLogado)
6481:                 MsgAviso("Essa Tarefa N" + CHR(227) + "o Pertence a Esse Usu" + CHR(225) + "rio!!!")
6482:                 loc_oGrd.Column4.SetFocus()
6483:                 loc_lResultado = loc_lResultado
6484:             ENDIF
6485: 
6486:             *-- Validar: tarefa nao pode estar ja finalizada
6487:             IF !EMPTY(cursor_4c_Tarefas.DtFims)
6488:                 MsgAviso("Essa Tarefa J" + CHR(225) + " Se Encontra Finalizada!!!")
6489:                 loc_oGrd.Column4.SetFocus()
6490:                 loc_lResultado = loc_lResultado
6491:             ENDIF
6492: 
6493:             *-- Registrar data/hora de finalizacao
6494:             loc_tDataHora = DATETIME()
6495:             SELECT cursor_4c_Tarefas
6496:             REPLACE DtFims WITH loc_tDataHora IN cursor_4c_Tarefas
6497: 
6498:             loc_oGrd.Refresh()
6499:             loc_lResultado = .T.
6500:         CATCH TO loc_oErro
6501:             MsgErro(loc_oErro.Message, "Erro")
6502:         ENDTRY
6503:         RETURN loc_lResultado
6504:     ENDPROC
6505: 
6506:     *--------------------------------------------------------------------------
6507:     * BtnInsArqsClick - Insere arquivo no grd_4c_Arquivos via dialog GetFile
6508:     *--------------------------------------------------------------------------
6509:     PROCEDURE BtnInsArqsClick()
6510:         LOCAL loc_lResultado, loc_lcArq, loc_oGrd
6511:         loc_lResultado = .F.
6512:         TRY
6513:             loc_oGrd  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos
6514:             loc_lcArq = GETFILE("", "Selecione o Arquivo", "Selecione o Arquivo", 0, ;
6515:                 "Sele" + CHR(231) + CHR(227) + "o de Arquivos")
6516:             IF !EMPTY(loc_lcArq)
6517:                 INSERT INTO cursor_4c_Arquivos (CPros, pkChaves, Arquivos) ;
6518:                     VALUES (PADR(THIS.this_oBusinessObject.this_cCpros, 14), "", UPPER(loc_lcArq))
6519:                 loc_oGrd.Refresh()
6520:             ENDIF
6521:             loc_lResultado = .T.
6522:         CATCH TO loc_oErro
6523:             MsgErro(loc_oErro.Message, "Erro")
6524:         ENDTRY
6525:         RETURN loc_lResultado
6526:     ENDPROC
6527: 
6528:     *--------------------------------------------------------------------------
6529:     * BtnOpnArqsClick - Abre arquivo selecionado no grd_4c_Arquivos com Shell
6530:     *--------------------------------------------------------------------------
6531:     PROCEDURE BtnOpnArqsClick()
6532:         LOCAL loc_lResultado, loc_lcArq, loc_oApp
6533:         loc_lResultado = .F.
6534:         TRY
6535:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
6536:                 loc_lResultado = loc_lResultado
6537:             ENDIF
6538:             loc_lcArq = ALLTRIM(cursor_4c_Arquivos.Arquivos)
6539:             IF !EMPTY(loc_lcArq) AND FILE(loc_lcArq)
6540:                 loc_oApp = CREATEOBJECT("Shell.Application")
6541:                 loc_oApp.Open(loc_lcArq)
6542:                 loc_lResultado = .T.
6543:             ELSE
6544:                 MsgAviso("Arquivo N" + CHR(227) + "o Encontrado!!!")
6545:             ENDIF
6546:         CATCH TO loc_oErro
6547:             MsgErro(loc_oErro.Message, "Erro")
6548:         ENDTRY
6549:         RETURN loc_lResultado
6550:     ENDPROC
6551: 
6552:     *--------------------------------------------------------------------------
6553:     * BtnExcArqsClick - Exclui arquivo selecionado do grd_4c_Arquivos
6554:     *--------------------------------------------------------------------------
6555:     PROCEDURE BtnExcArqsClick()
6556:         LOCAL loc_lResultado, loc_oGrd
6557:         loc_lResultado = .F.
6558:         TRY
6559:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos") OR BOF("cursor_4c_Arquivos")
6560:                 loc_lResultado = loc_lResultado
6561:             ENDIF
6562:             loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos
6563:             IF !EMPTY(cursor_4c_Arquivos.Arquivos)
6564:                 SELECT cursor_4c_Arquivos
6565:                 DELETE IN cursor_4c_Arquivos
6566:                 IF !EOF("cursor_4c_Arquivos")
6567:                     SKIP IN cursor_4c_Arquivos
6568:                 ENDIF
6569:                 IF EOF("cursor_4c_Arquivos")
6570:                     GO BOTTOM IN cursor_4c_Arquivos
6571:                 ENDIF
6572:                 PACK IN cursor_4c_Arquivos
6573:             ENDIF
6574:             loc_oGrd.Refresh()
6575:             loc_lResultado = .T.
6576:         CATCH TO loc_oErro
6577:             MsgErro(loc_oErro.Message, "Erro")
6578:         ENDTRY
6579:         RETURN loc_lResultado
6580:     ENDPROC
6581: 
6582:     *--------------------------------------------------------------------------
6583:     * ImgArqJpgClick - Abre visualizador de imagem em tela cheia (SigOpZom)
6584:     *--------------------------------------------------------------------------
6585:     PROCEDURE ImgArqJpgClick()
6586:         LOCAL loc_lResultado, loc_lcArq, loc_nPonto
6587:         loc_lResultado = .F.
6588:         TRY
6589:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
6590:                 loc_lResultado = loc_lResultado
6591:             ENDIF
6592:             loc_lcArq  = ALLTRIM(cursor_4c_Arquivos.Arquivos)
6593:             loc_nPonto = AT(".", loc_lcArq)
6594:             IF !EMPTY(loc_lcArq) AND FILE(loc_lcArq) AND loc_nPonto > 0 AND ;
6595:                 INLIST(ALLTRIM(UPPER(SUBSTR(loc_lcArq, loc_nPonto, 5))), ".JPG", ".ICO", ".BMP", ".JPEG")
6596:                 DO FORM SigOpZom WITH loc_lcArq, "Arquivo : " + loc_lcArq
6597:             ENDIF
6598:             loc_lResultado = .T.
6599:         CATCH TO loc_oErro
6600:             MsgErro(loc_oErro.Message, "Erro")
6601:         ENDTRY
6602:         RETURN loc_lResultado
6603:     ENDPROC
6604: 
6605:     *--------------------------------------------------------------------------
6606:     * GrdConsAfterRowColChange - Handler AfterRowColChange do grd_4c_GrdCons
6607:     *--------------------------------------------------------------------------
6608:     PROCEDURE GrdConsAfterRowColChange(par_nColIndex)
6609:         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
6610:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
6611:         ENDIF
6612:     ENDPROC
6613: 
6614:     *--------------------------------------------------------------------------
6615:     * GrdFaseAfterRowColChange - Handler AfterRowColChange do grd_4c_FasePro
6616:     * Carrega imagem FigProcs do campo memo na img_4c_ImgFigJpg
6617:     *--------------------------------------------------------------------------
6618:     PROCEDURE GrdFaseAfterRowColChange(par_nColIndex)
6619:         LOCAL loc_oPage, loc_lcArquivo
6620:         TRY
6621:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6622:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6623:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6624:                 CLEAR RESOURCES
6625:                 loc_oPage.img_4c_ImgFigJpg.Picture = ""
6626:                 loc_oPage.img_4c_ImgFigJpg.Visible = .F.
6627:                 IF !EMPTY(cursor_4c_Fase.FigProcs) AND !ISNULL(cursor_4c_Fase.FigProcs)
6628:                     IF STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo) > 0
6629:                         loc_oPage.img_4c_ImgFigJpg.Visible = .T.
6630:                         loc_oPage.img_4c_ImgFigJpg.Picture = loc_lcArquivo
6631:                     ENDIF
6632:                 ENDIF
6633:             ENDIF
6634:         CATCH TO loc_oErro
6635:             MsgErro(loc_oErro.Message, "Erro")
6636:         ENDTRY
6637:     ENDPROC
6638: 
6639:     *--------------------------------------------------------------------------
6640:     * GrdMatrizesAfterRowColChange - Handler AfterRowColChange do grd_4c_Matrizes
6641:     * Carrega imagem do produto matriz na img_4c_ImgBorracha via SQL
6642:     *--------------------------------------------------------------------------
6643:     PROCEDURE GrdMatrizesAfterRowColChange(par_nColIndex)
6644:         LOCAL loc_oPage, loc_lcArquivo, loc_lcSQL
6645:         TRY
6646:             IF USED("cursor_4c_Matrizes") AND !EOF("cursor_4c_Matrizes")
6647:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6648:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6649:                 CLEAR RESOURCES
6650:                 loc_oPage.img_4c_ImgBorracha.Picture = ""
6651:                 loc_oPage.img_4c_ImgBorracha.Visible = .F.
6652:                 IF !EMPTY(cursor_4c_Matrizes.CMats)
6653:                     loc_lcSQL = "SELECT FigProcs FROM SigCdPro WHERE CPros = '" + ;
6654:                         EscaparSQL(ALLTRIM(cursor_4c_Matrizes.CMats))
6655:                     IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_BorrachaImg") > 0
6656:                         IF !EOF("cursor_4c_BorrachaImg")
6657:                             IF !EMPTY(cursor_4c_BorrachaImg.FigProcs) AND !ISNULL(cursor_4c_BorrachaImg.FigProcs)
6658:                                 IF STRTOFILE(cursor_4c_BorrachaImg.FigProcs, loc_lcArquivo) > 0
6659:                                     loc_oPage.img_4c_ImgBorracha.Visible = .T.
6660:                                     loc_oPage.img_4c_ImgBorracha.Picture = loc_lcArquivo
6661:                                 ENDIF
6662:                             ENDIF
6663:                         ENDIF
6664:                         IF USED("cursor_4c_BorrachaImg")
6665:                             USE IN cursor_4c_BorrachaImg
6666:                         ENDIF
6667:                     ENDIF
6668:                 ENDIF
6669:                 loc_oPage.grd_4c_Matrizes.Refresh()
6670:             ENDIF
6671:         CATCH TO loc_oErro
6672:             MsgErro(loc_oErro.Message, "Erro")
6673:         ENDTRY
6674:     ENDPROC
6675: 
6676:     *--------------------------------------------------------------------------
6677:     * ImgFigJpgClick - Click na imagem -> amplia em zoom (SigOpZom)
6678:     *--------------------------------------------------------------------------
6679:     PROCEDURE ImgFigJpgClick()
6680:         LOCAL loc_lcArquivo
6681:         TRY
6682:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6683:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6684:                 IF !EMPTY(cursor_4c_Fase.FigProcs) AND !ISNULL(cursor_4c_Fase.FigProcs)
6685:                     STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo)
6686:                     IF FILE(loc_lcArquivo)
6687:                         DO FORM SigOpZom WITH loc_lcArquivo, .F.
6688:                     ENDIF
6689:                 ENDIF
6690:             ENDIF
6691:         CATCH TO loc_oErro
6692:             MsgErro(loc_oErro.Message, "Erro")
6693:         ENDTRY
6694:     ENDPROC
6695: 
6696:     *--------------------------------------------------------------------------
6697:     * CmdgFiguraClick - Seleciona foto do processo via GetPict
6698:     *--------------------------------------------------------------------------
6699:     PROCEDURE CmdgFiguraClick()
6700:         LOCAL loc_lcFigura, loc_lcArquivo, loc_oPage
6701:         TRY
6702:             IF !USED("cursor_4c_Fase") OR EOF("cursor_4c_Fase")
6703:                 RETURN
6704:             ENDIF
6705:             IF THIS.this_cModoAtual = "VISUALIZAR"
6706:                 RETURN
6707:             ENDIF
6708:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6709:             loc_oPage.grd_4c_FasePro.SetFocus()
6710:             loc_lcFigura = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Nome do Arquivo:", "Selecionar")
6711:             IF !EMPTY(loc_lcFigura)
6712:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6713:                 CLEAR RESOURCES
6714:                 SELECT cursor_4c_Fase
6715:                 REPLACE FigProcs WITH FILETOSTR(loc_lcFigura) IN cursor_4c_Fase
6716:                 IF STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo) > 0
6717:                     loc_oPage.img_4c_ImgFigJpg.Visible = .T.
6718:                     loc_oPage.img_4c_ImgFigJpg.Picture = loc_lcArquivo
6719:                 ENDIF
6720:             ENDIF
6721:         CATCH TO loc_oErro
6722:             MsgErro(loc_oErro.Message, "Erro")
6723:         ENDTRY
6724:     ENDPROC
6725: 
6726:     *--------------------------------------------------------------------------
6727:     * CmdgFigCamClick - Captura foto via camera (reutiliza logica de GetPict)
6728:     *--------------------------------------------------------------------------
6729:     PROCEDURE CmdgFigCamClick()
6730:         THIS.CmdgFiguraClick()
6731:     ENDPROC
6732: 
6733:     *--------------------------------------------------------------------------
6734:     * FaseInserirClick - Insere nova linha no grd_4c_FasePro
6735:     *--------------------------------------------------------------------------
6736:     PROCEDURE FaseInserirClick()
6737:         LOCAL loc_lResultado, loc_nOrdem, loc_oPage
6738:         loc_lResultado = .F.
6739:         TRY
6740:             IF !USED("cursor_4c_Fase")
6741:                 loc_lResultado = loc_lResultado
6742:             ENDIF
6743:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6744:             SELECT cursor_4c_Fase
6745:             IF !EOF("cursor_4c_Fase")
6746:                 IF EMPTY(cursor_4c_Fase.Grupos)
6747:                     loc_oPage.grd_4c_FasePro.SetFocus()
6748:                     loc_lResultado = loc_lResultado
6749:                 ENDIF
6750:                 loc_nOrdem = cursor_4c_Fase.Ordems
6751:             ELSE
6752:                 loc_nOrdem = 0
6753:             ENDIF
6754:             *-- Incrementa ordens dos registros apos o atual
6755:             SELECT cursor_4c_Fase
6756:             SCAN FOR Ordems > loc_nOrdem
6757:                 REPLACE Ordems WITH cursor_4c_Fase.Ordems + 1 IN cursor_4c_Fase
6758:             ENDSCAN
6759:             *-- Insere nova linha com ordem logo apos o atual
6760:             INSERT INTO cursor_4c_Fase (Ordems, Grupos, Descrs, UniPrdts, TpMats, FkChaves) ;
6761:                 VALUES (loc_nOrdem + 1, "", "", "", "", "")
6762:             GO TOP IN cursor_4c_Fase
6763:             LOCATE FOR Ordems = loc_nOrdem + 1 AND EMPTY(Grupos)
6764:             loc_oPage.grd_4c_FasePro.Refresh()
6765:             loc_oPage.grd_4c_FasePro.SetFocus()
6766:             loc_lResultado = .T.
6767:         CATCH TO loc_oErro
6768:             MsgErro(loc_oErro.Message, "Erro")
6769:         ENDTRY
6770:         RETURN loc_lResultado
6771:     ENDPROC
6772: 
6773:     *--------------------------------------------------------------------------
6774:     * FaseExcluirClick - Exclui linha atual do grd_4c_FasePro
6775:     *--------------------------------------------------------------------------
6776:     PROCEDURE FaseExcluirClick()
6777:         LOCAL loc_lResultado, loc_oPage
6778:         loc_lResultado = .F.
6779:         TRY
6780:             IF !USED("cursor_4c_Fase") OR EOF("cursor_4c_Fase") OR BOF("cursor_4c_Fase")
6781:                 loc_lResultado = loc_lResultado
6782:             ENDIF
6783:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6784:             SELECT cursor_4c_Fase
6785:             DELETE IN cursor_4c_Fase
6786:             IF !EOF("cursor_4c_Fase")
6787:                 SKIP IN cursor_4c_Fase
6788:             ENDIF
6789:             IF EOF("cursor_4c_Fase")
6790:                 GO BOTTOM IN cursor_4c_Fase
6791:             ENDIF
6792:             PACK IN cursor_4c_Fase
6793:             loc_oPage.grd_4c_FasePro.Refresh()
6794:             loc_oPage.grd_4c_FasePro.SetFocus()
6795:             loc_oPage.grd_4c_FasePro.Column2.SetFocus()
6796:             loc_lResultado = .T.
6797:         CATCH TO loc_oErro
6798:             MsgErro(loc_oErro.Message, "Erro")
6799:         ENDTRY
6800:         RETURN loc_lResultado
6801:     ENDPROC
6802: 
6803:     *--------------------------------------------------------------------------
6804:     * FaseAlternativaClick - Insere fase alternativa (mesma ordem do atual)
6805:     *--------------------------------------------------------------------------
6806:     PROCEDURE FaseAlternativaClick()
6807:         LOCAL loc_lResultado, loc_nOrdem, loc_oPage
6808:         loc_lResultado = .F.
6809:         TRY
6810:             IF !USED("cursor_4c_Fase")
6811:                 loc_lResultado = loc_lResultado
6812:             ENDIF
6813:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6814:             SELECT cursor_4c_Fase
6815:             IF EOF("cursor_4c_Fase") OR BOF("cursor_4c_Fase")
6816:                 loc_oPage.grd_4c_FasePro.SetFocus()
6817:                 loc_lResultado = loc_lResultado
6818:             ENDIF
6819:             loc_nOrdem = cursor_4c_Fase.Ordems
6820:             *-- Insere linha alternativa com mesma ordem (alternativa ao atual)
6821:             INSERT INTO cursor_4c_Fase (Ordems, Grupos, Descrs, UniPrdts, TpMats, FkChaves) ;
6822:                 VALUES (loc_nOrdem, "", "", "", "", "")
6823:             GO TOP IN cursor_4c_Fase
6824:             LOCATE FOR Ordems = loc_nOrdem AND EMPTY(Grupos)
6825:             loc_oPage.grd_4c_FasePro.Refresh()
6826:             loc_oPage.grd_4c_FasePro.SetFocus()
6827:             loc_lResultado = .T.
6828:         CATCH TO loc_oErro
6829:             MsgErro(loc_oErro.Message, "Erro")
6830:         ENDTRY
6831:         RETURN loc_lResultado
6832:     ENDPROC
6833: 
6834:     *--------------------------------------------------------------------------
6835:     * CmdFichaClick - Abre Ficha Tecnica do produto
6836:     *--------------------------------------------------------------------------
6837:     PROCEDURE CmdFichaClick()
6838:         LOCAL loc_lResultado
6839:         loc_lResultado = .F.
6840:         TRY
6841:             MsgAviso("Ficha T" + CHR(233) + "cnica n" + CHR(227) + "o dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", ;
6842:                 "Ficha T" + CHR(233) + "cnica")
6843:         CATCH TO loc_oErro
6844:             MsgErro(loc_oErro.Message, "Erro")
6845:         ENDTRY
6846:         RETURN loc_lResultado
6847:     ENDPROC
6848: 
6849:     *--------------------------------------------------------------------------
6850:     * FaseGrdCol2Valid - Valid do Column2 (Fase/Grupos) do grd_4c_FasePro
6851:     * Lookup: SigCdGcr (Codigos / Descrs)
6852:     *--------------------------------------------------------------------------
6853:     PROCEDURE FaseGrdCol2Valid(par_nColIndex)
6854:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_cDescr, loc_lcSQL
6855:         loc_lResultado = .T.
6856:         TRY
6857:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
6858:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column2.Text1.Value, ""))
6859:             IF EMPTY(loc_cCodigo)
6860:                 loc_lResultado = loc_lResultado
6861:             ENDIF
6862:             loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
6863:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGcr") <= 0 OR EOF("cursor_4c_ValGcr")
6864:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6865:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValGcr"
6866:                 loc_oLookup.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
6867:                 loc_oLookup.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
6868:                 loc_oLookup.cTabela     = "SigCdGcr"
6869:                 loc_oLookup.cCampoChave = "Codigos"
6870:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6871:                 loc_oLookup.Show()
6872:                 IF loc_oLookup.this_lSelecionou
6873:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6874:                     loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
6875:                     IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGcr") > 0 AND !EOF("cursor_4c_ValGcr")
6876:                         loc_cDescr = ALLTRIM(NVL(cursor_4c_ValGcr.Descrs, ""))
6877:                     ELSE
6878:                         loc_cDescr = ""
6879:                     ENDIF
6880:                 ELSE
6881:                     loc_cCodigo = ""
6882:                     loc_cDescr  = ""
6883:                 ENDIF
6884:                 IF USED("cursor_4c_ValGcr")
6885:                     USE IN cursor_4c_ValGcr
6886:                 ENDIF
6887:             ELSE
6888:                 loc_cDescr = ALLTRIM(NVL(cursor_4c_ValGcr.Descrs, ""))
6889:                 IF USED("cursor_4c_ValGcr")
6890:                     USE IN cursor_4c_ValGcr
6891:                 ENDIF
6892:             ENDIF
6893:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6894:                 SELECT cursor_4c_Fase
6895:                 REPLACE Grupos WITH PADR(loc_cCodigo, 10) IN cursor_4c_Fase
6896:                 REPLACE Descrs WITH PADR(loc_cDescr,  40) IN cursor_4c_Fase
6897:                 loc_oGrd.Column2.Text1.Value = loc_cCodigo
6898:                 loc_oGrd.Column3.Text1.Value = loc_cDescr
6899:             ENDIF
6900:         CATCH TO loc_oErro
6901:             MsgErro(loc_oErro.Message, "Erro")
6902:         ENDTRY
6903:         RETURN loc_lResultado
6904:     ENDPROC
6905: 
6906:     *--------------------------------------------------------------------------
6907:     * FaseGrdCol4Valid - Valid do Column4 (Uni. Produtiva/UniPrdts) do grd_4c_FasePro
6908:     * Lookup: SigCdUpd (UniPrdts) filtrado pelo Grupo atual
6909:     *--------------------------------------------------------------------------
6910:     PROCEDURE FaseGrdCol4Valid(par_nColIndex)
6911:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_cGrupo, loc_lcSQL
6912:         loc_lResultado = .T.
6913:         TRY
6914:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
6915:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column4.Text1.Value, ""))
6916:             IF EMPTY(loc_cCodigo)
6917:                 loc_lResultado = loc_lResultado
6918:             ENDIF
6919:             loc_cGrupo = ""
6920:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6921:                 loc_cGrupo = ALLTRIM(cursor_4c_Fase.Grupos)
6922:             ENDIF
6923:             IF !EMPTY(loc_cGrupo)
6924:                 loc_lcSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupo)
6925:             ELSE
6926:                 loc_lcSQL = "SELECT UniPrdts FROM SigCdUpd"
6927:             ENDIF
6928:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValUpd") <= 0
6929:                 IF USED("cursor_4c_ValUpd")
6930:                     USE IN cursor_4c_ValUpd
6931:                 ENDIF
6932:                 loc_lResultado = loc_lResultado
6933:             ENDIF
6934:             SELECT cursor_4c_ValUpd
6935:             LOCATE FOR ALLTRIM(UniPrdts) = loc_cCodigo
6936:             IF EOF("cursor_4c_ValUpd")
6937:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6938:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValUpd"
6939:                 loc_oLookup.mAddColuna("UniPrdts", "", "Uni. Produtiva")
6940:                 loc_oLookup.cTabela     = "SigCdUpd"
6941:                 loc_oLookup.cCampoChave = "UniPrdts"
6942:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6943:                 loc_oLookup.Show()
6944:                 IF loc_oLookup.this_lSelecionou
6945:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6946:                 ELSE
6947:                     loc_cCodigo = ""
6948:                 ENDIF
6949:             ENDIF
6950:             IF USED("cursor_4c_ValUpd")
6951:                 USE IN cursor_4c_ValUpd
6952:             ENDIF
6953:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6954:                 SELECT cursor_4c_Fase
6955:                 REPLACE UniPrdts WITH PADR(loc_cCodigo, 10) IN cursor_4c_Fase
6956:                 loc_oGrd.Column4.Text1.Value = loc_cCodigo
6957:             ENDIF
6958:         CATCH TO loc_oErro
6959:             MsgErro(loc_oErro.Message, "Erro")
6960:         ENDTRY
6961:         RETURN loc_lResultado
6962:     ENDPROC
6963: 
6964:     *--------------------------------------------------------------------------
6965:     * FaseGrdCol5Valid - Valid do Column5 (Material/TpMats) do grd_4c_FasePro
6966:     * Lookup: SigOpOpt (Cods / Descs)
6967:     *--------------------------------------------------------------------------
6968:     PROCEDURE FaseGrdCol5Valid(par_nColIndex)
6969:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
6970:         loc_lResultado = .T.
6971:         TRY
6972:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
6973:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column5.Text1.Value, ""))
6974:             IF EMPTY(loc_cCodigo)
6975:                 loc_lResultado = loc_lResultado
6976:             ENDIF
6977:             loc_lcSQL = "SELECT Cods, Descs FROM SigOpOpt WHERE Cods = " + EscaparSQL(loc_cCodigo)
6978:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOpt") <= 0 OR EOF("cursor_4c_ValOpt")
6979:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6980:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValOpt"
6981:                 loc_oLookup.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
6982:                 loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
6983:                 loc_oLookup.cTabela     = "SigOpOpt"
6984:                 loc_oLookup.cCampoChave = "Cods"
6985:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6986:                 loc_oLookup.Show()
6987:                 IF loc_oLookup.this_lSelecionou
6988:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6989:                 ELSE
6990:                     loc_cCodigo = ""
6991:                 ENDIF
6992:             ENDIF
6993:             IF USED("cursor_4c_ValOpt")
6994:                 USE IN cursor_4c_ValOpt
6995:             ENDIF
6996:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6997:                 SELECT cursor_4c_Fase
6998:                 REPLACE TpMats WITH PADR(loc_cCodigo, 3) IN cursor_4c_Fase
6999:                 loc_oGrd.Column5.Text1.Value = loc_cCodigo
7000:             ENDIF
7001:             loc_oGrd.Refresh()
7002:         CATCH TO loc_oErro
7003:             MsgErro(loc_oErro.Message, "Erro")
7004:         ENDTRY
7005:         RETURN loc_lResultado
7006:     ENDPROC
7007: 
7008:     *--------------------------------------------------------------------------
7009:     * ValidarAcabamento - LostFocus do txt_4c_CodAcb
7010:     * Lookup: SigCdAca (Cods / Descrs) -> preenche txt_4c_Dacb
7011:     *--------------------------------------------------------------------------
7012:     PROCEDURE ValidarAcabamento()
7013:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_cDescr, loc_lcSQL
7014:         loc_lResultado = .T.
7015:         TRY
7016:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7017:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_CodAcb.Value, ""))
7018:             IF loc_cCodigo == THIS.this_cUltimoAcabamentoValidado
7019:                 loc_lResultado = loc_lResultado
7020:             ENDIF
7021:             IF EMPTY(loc_cCodigo)
7022:                 loc_oPage.txt_4c_Dacb.Value = ""
7023:                 loc_lResultado = loc_lResultado
7024:             ENDIF
7025:             loc_lcSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Cods = " + EscaparSQL(loc_cCodigo)
7026:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAca") <= 0 OR EOF("cursor_4c_ValAca")
7027:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7028:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValAca"
7029:                 loc_oLookup.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
7030:                 loc_oLookup.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7031:                 loc_oLookup.cTabela     = "SigCdAca"
7032:                 loc_oLookup.cCampoChave = "Cods"
7033:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7034:                 loc_oLookup.Show()
7035:                 IF loc_oLookup.this_lSelecionou
7036:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7037:                     loc_lcSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Cods = " + EscaparSQL(loc_cCodigo)
7038:                     IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAca") > 0 AND !EOF("cursor_4c_ValAca")
7039:                         loc_cDescr = ALLTRIM(NVL(cursor_4c_ValAca.Descrs, ""))
7040:                     ELSE
7041:                         loc_cDescr = ""
7042:                     ENDIF
7043:                 ELSE
7044:                     loc_cCodigo = ""
7045:                     loc_cDescr  = ""
7046:                 ENDIF
7047:             ELSE
7048:                 loc_cDescr = ALLTRIM(NVL(cursor_4c_ValAca.Descrs, ""))
7049:             ENDIF
7050:             IF USED("cursor_4c_ValAca")
7051:                 USE IN cursor_4c_ValAca
7052:             ENDIF
7053:             loc_oPage.txt_4c_CodAcb.Value = loc_cCodigo
7054:             loc_oPage.txt_4c_Dacb.Value   = loc_cDescr
7055:             THIS.this_cUltimoAcabamentoValidado = loc_cCodigo
7056:             loc_oPage.grd_4c_FasePro.Refresh()
7057:             loc_oPage.Refresh()
7058:         CATCH TO loc_oErro
7059:             MsgErro(loc_oErro.Message, "Erro")
7060:         ENDTRY
7061:         RETURN loc_lResultado
7062:     ENDPROC
7063: 
7064:     *--------------------------------------------------------------------------
7065:     * ValidarConquilha - LostFocus do txt_4c_Conquilha
7066:     * Lookup: SigCdCnq (conquilhas)
7067:     *--------------------------------------------------------------------------
7068:     PROCEDURE ValidarConquilha()
7069:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cValor, loc_lcSQL
7070:         LOCAL loc_cValorAtual
7071:         loc_lResultado = .T.
7072:         loc_cValorAtual = ""
7073:         TRY
7074:             loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7075:             loc_cValor = ALLTRIM(NVL(loc_oPage.txt_4c_Conquilha.Value, ""))
7076:             loc_cValorAtual = loc_cValor
7077:             IF loc_cValorAtual == THIS.this_cUltimoConquilhaValidado
7078:                 loc_lResultado = loc_lResultado
7079:             ENDIF
7080:             IF EMPTY(loc_cValor)
7081:                 loc_lResultado = loc_lResultado
7082:             ENDIF
7083:             loc_lcSQL = "SELECT conquilhas FROM SigCdCnq GROUP BY conquilhas"
7084:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCnq") > 0
7085:                 SELECT cursor_4c_ValCnq
7086:                 LOCATE FOR ALLTRIM(conquilhas) = loc_cValor
7087:                 IF EOF("cursor_4c_ValCnq")
7088:                     loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7089:                     loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaConq"
7090:                     loc_oLookup.mAddColuna("conquilhas", "", "Conquilhas")
7091:                     loc_oLookup.cTabela     = "SigCdCnq"
7092:                     loc_oLookup.cCampoChave = "conquilhas"
7093:                     loc_oLookup.cFiltroIni  = loc_cValor
7094:                     loc_oLookup.Show()
7095:                     IF loc_oLookup.this_lSelecionou
7096:                         loc_cValor = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7097:                     ELSE
7098:                         loc_cValor = ""
7099:                     ENDIF
7100:                 ENDIF
7101:                 IF USED("cursor_4c_ValCnq")
7102:                     USE IN cursor_4c_ValCnq
7103:                 ENDIF
7104:             ENDIF
7105:             loc_oPage.txt_4c_Conquilha.Value = loc_cValor
7106:             THIS.this_cUltimoConquilhaValidado = loc_cValor
7107:             loc_oPage.grd_4c_FasePro.Refresh()
7108:             loc_oPage.Refresh()
7109:         CATCH TO loc_oErro
7110:             MsgErro(loc_oErro.Message, "Erro")
7111:         ENDTRY
7112:         RETURN loc_lResultado
7113:     ENDPROC
7114: 
7115:     *--------------------------------------------------------------------------
7116:     * ValidarCorFaseP - LostFocus do txt_4c_Cor (Page4 FaseP)
7117:     * Lookup: SigCdCor (Cods / Descs)
7118:     *--------------------------------------------------------------------------
7119:     PROCEDURE ValidarCorFaseP()
7120:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
7121:         loc_lResultado = .T.
7122:         TRY
7123:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7124:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Cor.Value, ""))
7125:             IF loc_cCodigo == THIS.this_cUltimoCorValidado
7126:                 loc_lResultado = loc_lResultado
7127:             ENDIF
7128:             IF EMPTY(loc_cCodigo)
7129:                 loc_lResultado = loc_lResultado
7130:             ENDIF
7131:             loc_lcSQL = "SELECT Cods FROM SigCdCor WHERE Cods = " + EscaparSQL(loc_cCodigo)
7132:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCor") <= 0 OR EOF("cursor_4c_ValCor")
7133:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7134:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValCor"
7135:                 loc_oLookup.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
7136:                 loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7137:                 loc_oLookup.cTabela     = "SigCdCor"
7138:                 loc_oLookup.cCampoChave = "Cods"
7139:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7140:                 loc_oLookup.Show()
7141:                 IF loc_oLookup.this_lSelecionou
7142:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7143:                 ELSE
7144:                     loc_cCodigo = ""
7145:                 ENDIF
7146:             ENDIF
7147:             IF USED("cursor_4c_ValCor")
7148:                 USE IN cursor_4c_ValCor
7149:             ENDIF
7150:             loc_oPage.txt_4c_Cor.Value = loc_cCodigo
7151:             loc_oPage.txt_4c_Cor.Refresh()
7152:             THIS.this_cUltimoCorValidado = loc_cCodigo
7153:             loc_oPage.grd_4c_FasePro.Refresh()
7154:             loc_oPage.Refresh()
7155:         CATCH TO loc_oErro
7156:             MsgErro(loc_oErro.Message, "Erro")
7157:         ENDTRY
7158:         RETURN loc_lResultado
7159:     ENDPROC
7160: 
7161:     *--------------------------------------------------------------------------
7162:     * ValidarTamFaseP - LostFocus do txt_4c_Tam (Page4 FaseP)
7163:     * Lookup: SigCdTam (Cods / Descs)
7164:     *--------------------------------------------------------------------------
7165:     PROCEDURE ValidarTamFaseP()
7166:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
7167:         loc_lResultado = .T.
7168:         TRY
7169:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7170:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Tam.Value, ""))
7171:             IF loc_cCodigo == THIS.this_cUltimoTamValidado
7172:                 loc_lResultado = loc_lResultado
7173:             ENDIF
7174:             IF EMPTY(loc_cCodigo)
7175:                 loc_lResultado = loc_lResultado
7176:             ENDIF
7177:             loc_lcSQL = "SELECT Cods FROM SigCdTam WHERE Cods = " + EscaparSQL(loc_cCodigo)
7178:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTam") <= 0 OR EOF("cursor_4c_ValTam")
7179:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7180:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValTam"
7181:                 loc_oLookup.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
7182:                 loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7183:                 loc_oLookup.cTabela     = "SigCdTam"
7184:                 loc_oLookup.cCampoChave = "Cods"
7185:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7186:                 loc_oLookup.Show()
7187:                 IF loc_oLookup.this_lSelecionou
7188:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7189:                 ELSE
7190:                     loc_cCodigo = ""
7191:                 ENDIF
7192:             ENDIF
7193:             IF USED("cursor_4c_ValTam")
7194:                 USE IN cursor_4c_ValTam
7195:             ENDIF
7196:             loc_oPage.txt_4c_Tam.Value = loc_cCodigo
7197:             loc_oPage.txt_4c_Tam.Refresh()
7198:             THIS.this_cUltimoTamValidado = loc_cCodigo
7199:             loc_oPage.grd_4c_FasePro.Refresh()
7200:             loc_oPage.Refresh()
7201:         CATCH TO loc_oErro
7202:             MsgErro(loc_oErro.Message, "Erro")
7203:         ENDTRY
7204:         RETURN loc_lResultado
7205:     ENDPROC
7206: 
7207:     *--------------------------------------------------------------------------
7208:     * BtnInsereMtxClick - Insere nova linha no grd_4c_Matrizes
7209:     *--------------------------------------------------------------------------
7210:     PROCEDURE BtnInsereMtxClick()
7211:         LOCAL loc_lResultado, loc_oPage
7212:         loc_lResultado = .F.
7213:         TRY
7214:             IF !USED("cursor_4c_Matrizes")
7215:                 loc_lResultado = loc_lResultado
7216:             ENDIF
7217:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7218:             SELECT cursor_4c_Matrizes
7219:             *-- Localiza linha vazia (placeholder); se nao houver, insere uma nova
7220:             GO TOP IN cursor_4c_Matrizes
7221:             LOCATE FOR EMPTY(cursor_4c_Matrizes.CMats)
7222:             IF EOF("cursor_4c_Matrizes")
7223:                 INSERT INTO cursor_4c_Matrizes (CMats, Locals, QMatz, CPros, cIdChaves, DPros) ;
7224:                     VALUES ("", "", 0, "", "", "")
7225:             ENDIF
7226:             loc_oPage.grd_4c_Matrizes.Refresh()
7227:             loc_oPage.grd_4c_Matrizes.SetFocus()
7228:             loc_oPage.grd_4c_Matrizes.Column1.SetFocus()
7229:             loc_lResultado = .T.
7230:         CATCH TO loc_oErro
7231:             MsgErro(loc_oErro.Message, "Erro")
7232:         ENDTRY
7233:         RETURN loc_lResultado
7234:     ENDPROC
7235: 
7236:     *--------------------------------------------------------------------------
7237:     * BtnExcluiMtzClick - Exclui linha atual do grd_4c_Matrizes
7238:     * Garante sempre ao menos uma linha vazia no cursor
7239:     *--------------------------------------------------------------------------
7240:     PROCEDURE BtnExcluiMtzClick()
7241:         LOCAL loc_lResultado, loc_oPage
7242:         loc_lResultado = .F.
7243:         TRY
7244:             IF !USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes")
7245:                 loc_lResultado = loc_lResultado
7246:             ENDIF
7247:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7248:             SELECT cursor_4c_Matrizes
7249:             DELETE IN cursor_4c_Matrizes
7250:             PACK IN cursor_4c_Matrizes
7251:             *-- Garante sempre ao menos uma linha vazia
7252:             GO TOP IN cursor_4c_Matrizes
7253:             LOCATE FOR EMPTY(cursor_4c_Matrizes.CMats)
7254:             IF EOF("cursor_4c_Matrizes")
7255:                 INSERT INTO cursor_4c_Matrizes (CMats, Locals, QMatz, CPros, cIdChaves, DPros) ;
7256:                     VALUES ("", "", 0, "", "", "")
7257:             ENDIF
7258:             loc_oPage.grd_4c_Matrizes.Refresh()
7259:             loc_oPage.grd_4c_Matrizes.SetFocus()
7260:             loc_oPage.grd_4c_Matrizes.Column1.SetFocus()
7261:             loc_lResultado = .T.
7262:         CATCH TO loc_oErro
7263:             MsgErro(loc_oErro.Message, "Erro")
7264:         ENDTRY
7265:         RETURN loc_lResultado
7266:     ENDPROC
7267: 
7268:     *--------------------------------------------------------------------------
7269:     * MatrizGrdCol1Valid - Valid do Column1 (Matriz/CMats) do grd_4c_Matrizes
7270:     * Lookup: SigCdPro (CPros / DPros) - produto usado como matriz
7271:     *--------------------------------------------------------------------------
7272:     PROCEDURE MatrizGrdCol1Valid(par_nColIndex)
7273:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
7274:         loc_lResultado = .T.
7275:         TRY
7276:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_Matrizes
7277:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column1.Text1.Value, ""))
7278:             IF EMPTY(loc_cCodigo)
7279:                 loc_lResultado = loc_lResultado
7280:             ENDIF
7281:             loc_lcSQL = "SELECT CPros, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCodigo)
7282:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValMtz") <= 0 OR EOF("cursor_4c_ValMtz")
7283:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7284:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValMtz"
7285:                 loc_oLookup.mAddColuna("CPros", "", "Matriz")
7286:                 loc_oLookup.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
7287:                 loc_oLookup.cTabela     = "SigCdPro"
7288:                 loc_oLookup.cCampoChave = "CPros"
7289:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7290:                 loc_oLookup.Show()
7291:                 IF loc_oLookup.this_lSelecionou
7292:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7293:                 ELSE
7294:                     loc_cCodigo = ""
7295:                 ENDIF
7296:             ENDIF
7297:             IF USED("cursor_4c_ValMtz")
7298:                 USE IN cursor_4c_ValMtz
7299:             ENDIF
7300:             IF USED("cursor_4c_Matrizes") AND !EOF("cursor_4c_Matrizes")
7301:                 SELECT cursor_4c_Matrizes
7302:                 REPLACE CMats WITH PADR(loc_cCodigo, 14) IN cursor_4c_Matrizes
7303:                 loc_oGrd.Column1.Text1.Value = loc_cCodigo
7304:                 loc_oGrd.Refresh()
7305:             ENDIF
7306:         CATCH TO loc_oErro
7307:             MsgErro(loc_oErro.Message, "Erro")
7308:         ENDTRY
7309:         RETURN loc_lResultado
7310:     ENDPROC
7311: 
7312:     *--------------------------------------------------------------------------
7313:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
7314:     * par_oContainer: container a processar (Page1, Page2, etc.)
7315:     *--------------------------------------------------------------------------
7316:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
7317:         LOCAL loc_nI, loc_oObjeto, loc_nP
7318: 
7319:         FOR loc_nI = 1 TO par_oContainer.ControlCount
7320:             loc_oObjeto = par_oContainer.Controls(loc_nI)
7321: 
7322:             IF VARTYPE(loc_oObjeto) = "O"
7323:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
7324:                     *-- Nao forcar visivel containers ocultos intencionais
7325:                     IF NOT INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")
7326:                         loc_oObjeto.Visible = .T.
7327:                     ENDIF
7328:                 ENDIF
7329: 
7330:                 *-- Itera Pages de PageFrame
7331:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
7332:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
7333:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
7334:                     ENDFOR
7335:                 ENDIF
7336: 
7337:                 *-- Itera containers com ControlCount
7338:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
7339:                     THIS.TornarControlesVisiveis(loc_oObjeto)
7340:                 ENDIF
7341:             ENDIF
7342:         ENDFOR
7343:     ENDPROC
7344: 
7345:     *--------------------------------------------------------------------------
7346:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
7347:     *--------------------------------------------------------------------------
7348:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
7349:         THIS.pgf_4c_Paginas.Visible   = .T.
7350:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
7351: 
7352:         IF par_nPagina = 1
7353:             THIS.AjustarBotoesPorModo()
7354:             THIS.CarregarLista()
7355:         ENDIF
7356:     ENDPROC
7357: 
7358:     *--------------------------------------------------------------------------
7359:     * CarregarLista - Busca registros do SigPrFtp com JOIN SigCdPro
7360:     *--------------------------------------------------------------------------
7361:     PROCEDURE CarregarLista()
7362:         LOCAL loc_lResultado, loc_cSQL, loc_cWhere
7363:         loc_lResultado = .F.
7364: 
7365:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
7366:             RETURN loc_lResultado
7367:         ENDIF
7368: 
7369:         TRY
7370:             loc_cWhere = THIS.MontarFiltro()
7371: 
7372:             loc_cSQL = "SELECT t.pkchaves, t.cpros, " + ;
7373:                 "ISNULL(p.dpros,'') AS dpros, " + ;
7374:                 "t.cgrus, t.cods, " + ;
7375:                 "ISNULL(p.reffs,'') AS reffs, " + ;
7376:                 "ISNULL(p.usuincs,'') AS usuincs, " + ;
7377:                 "ISNULL(p.situas,0) AS situas " + ;
7378:                 "FROM sigprftp t " + ;
7379:                 "LEFT JOIN SigCdPro p ON p.cpros = t.cpros "
7380: 
7381:             IF !EMPTY(loc_cWhere)
7382:                 loc_cSQL = loc_cSQL + "WHERE " + loc_cWhere + " "
7383:             ENDIF
7384: 
7385:             loc_cSQL = loc_cSQL + "ORDER BY t.cpros"
7386: 
7387:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp") > 0
7388:                 LOCAL loc_oGrd
7389:                 loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
7390: 
7391:                 IF !USED("cursor_4c_Dados")
7392:                     SET NULL ON
7393:                     CREATE CURSOR cursor_4c_Dados (pkchaves C(20), cpros C(14), dpros C(40), cgrus C(3), cods C(2), reffs C(20), usuincs C(10), situas N(1,0))
7394:                     SET NULL OFF
7395:                 ELSE
7396:                     ZAP IN cursor_4c_Dados
7397:                 ENDIF
7398:                 IF !EOF("cursor_4c_DadosTemp")
7399:                     SELECT cursor_4c_DadosTemp
7400:                     APPEND FROM DBF("cursor_4c_DadosTemp")
7401:                 ENDIF

*-- Linhas 7501 a 7608:
7501:     * FormatarGridLista - Formata visual do grid (FontName/Size)
7502:     * RecordSource + ControlSource ja definidos em CarregarLista
7503:     *--------------------------------------------------------------------------
7504:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
7505:         WITH par_oGrid
7506:             IF .ColumnCount > 0
7507:                 .FontName = "Arial"
7508:                 .FontSize = 8
7509:             ENDIF
7510:         ENDWITH
7511:     ENDPROC
7512: 
7513:     *--------------------------------------------------------------------------
7514:     * AtualizarContagemProdutos - Atualiza label de contagem
7515:     *--------------------------------------------------------------------------
7516:     PROTECTED PROCEDURE AtualizarContagemProdutos()
7517:         LOCAL loc_nTotal
7518:         loc_nTotal = 0
7519: 
7520:         TRY
7521:             IF USED("cursor_4c_Dados")
7522:                 loc_nTotal = RECCOUNT("cursor_4c_Dados")
7523:             ENDIF
7524:             THIS.pgf_4c_Paginas.Page1.lbl_4c_Produtos.Caption = ;
7525:                 "Produtos Selecionados : " + TRANSFORM(loc_nTotal)
7526:         CATCH TO loc_oErro
7527:             MsgErro(loc_oErro.Message, "Erro ao atualizar contagem")
7528:         ENDTRY
7529:     ENDPROC
7530: 
7531:     *--------------------------------------------------------------------------
7532:     * FormParaBO - Transfere dados do formulario para o BO
7533:     * Fase 5: cpros/cgrus/cods mapeados para SigPrFtp
7534:     * Campos SigCdPro (DPro2s, Cbar, Lin, Col, Ifor, Refs) serao
7535:     * persistidos em fase futura (Phase 7) via SQL direto em SigCdPro
7536:     *--------------------------------------------------------------------------
7537:     PROTECTED PROCEDURE FormParaBO()
7538:         LOCAL loc_oPg
7539:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7540: 
7541:         THIS.this_oBusinessObject.this_cCpros = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
7542:         THIS.this_oBusinessObject.this_cCgrus = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
7543:         THIS.this_oBusinessObject.this_cCods  = ALLTRIM(loc_oPg.txt_4c_Cods.Value)
7544:         *-- coefs/valors: sem controle visual em pgDados -> mantidos como 0 no BO
7545:         *-- pkchaves: gerado em BtnSalvarClick, nao vem do form
7546:     ENDPROC
7547: 
7548:     *--------------------------------------------------------------------------
7549:     * BOParaForm - Transfere dados do BO para o formulario
7550:     * Fase 5: preenche SigPrFtp e carrega descritivos de SigCdPro
7551:     *--------------------------------------------------------------------------
7552:     PROTECTED PROCEDURE BOParaForm()
7553:         LOCAL loc_oPg
7554:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7555: 
7556:         loc_oPg.txt_4c_Cpros.Value = THIS.this_oBusinessObject.this_cCpros
7557:         loc_oPg.txt_4c_Cgrus.Value = THIS.this_oBusinessObject.this_cCgrus
7558:         loc_oPg.txt_4c_Cods.Value  = THIS.this_oBusinessObject.this_cCods
7559: 
7560:         *-- Carregar todos os descritivos do SigCdPro vinculado
7561:         THIS.CarregarDadosSigCdPro(THIS.this_oBusinessObject.this_cCpros)
7562:     ENDPROC
7563: 
7564:     *--------------------------------------------------------------------------
7565:     * CarregarDadosSigCdPro - Busca e preenche campos de exibicao do SigCdPro
7566:     * par_cCpros: codigo do produto
7567:     *--------------------------------------------------------------------------
7568:     PROTECTED PROCEDURE CarregarDadosSigCdPro(par_cCpros)
7569:         LOCAL loc_cSQL, loc_oPg
7570:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7571: 
7572:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
7573:             RETURN
7574:         ENDIF
7575: 
7576:         *-- Limpar campos de exibicao (Fase 5)
7577:         loc_oPg.txt_4c_Dpros.Value        = ""
7578:         loc_oPg.txt_4c_DPro2s.Value       = ""
7579:         loc_oPg.txt_4c_Cbar.Value         = ""
7580:         loc_oPg.txt_4c_DgruDisplay.Value  = ""
7581:         loc_oPg.txt_4c_DcodsDisplay.Value = ""
7582:         loc_oPg.txt_4c_Lin.Value          = ""
7583:         loc_oPg.txt_4c_DLinDisplay.Value  = ""
7584:         loc_oPg.txt_4c_Col.Value          = ""
7585:         loc_oPg.txt_4c_DColDisplay.Value  = ""
7586:         loc_oPg.txt_4c_Ifor.Value         = ""
7587:         loc_oPg.txt_4c_DforDisplay.Value  = ""
7588:         loc_oPg.txt_4c_Refs.Value         = ""
7589:         *-- Limpar campos de exibicao (Fase 6)
7590:         loc_oPg.txt_4c_Cor.Value          = ""
7591:         loc_oPg.txt_4c_Tam.Value          = ""
7592:         loc_oPg.txt_4c_CodFinP.Value      = ""
7593:         loc_oPg.txt_4c_DesFinP.Value      = ""
7594:         loc_oPg.txt_4c_PesoB.Value        = 0.0
7595:         loc_oPg.txt_4c_CodAcb.Value       = ""
7596:         loc_oPg.txt_4c_DacbDisplay.Value  = ""
7597:         loc_oPg.txt_4c_Pmedio.Value       = 0.0
7598:         loc_oPg.txt_4c_Class.Value        = ""
7599:         loc_oPg.txt_4c_DClassDisplay.Value = ""
7600:         loc_oPg.txt_4c_Local.Value        = ""
7601:         loc_oPg.txt_4c_Ctotal.Value       = 0.0
7602:         loc_oPg.txt_4c_Mctotal.Value      = ""
7603:         loc_oPg.txt_4c_Cuni.Value         = ""
7604:         loc_oPg.txt_4c_DuniDisplay.Value  = ""
7605:         loc_oPg.txt_4c_Cunip.Value        = ""
7606:         loc_oPg.txt_4c_DunipDisplay.Value = ""
7607:         loc_oPg.txt_4c_Pvenda.Value       = 0.0
7608:         loc_oPg.txt_4c_Mpvenda.Value      = ""

*-- Linhas 7821 a 8241:
7821:     *--------------------------------------------------------------------------
7822:     * AtualizarDescricaoProduto - Compatibilidade: delega para CarregarDadosSigCdPro
7823:     *--------------------------------------------------------------------------
7824:     PROTECTED PROCEDURE AtualizarDescricaoProduto(par_cCpros)
7825:         THIS.CarregarDadosSigCdPro(par_cCpros)
7826:     ENDPROC
7827: 
7828:     *--------------------------------------------------------------------------
7829:     * CarregarDescGrupo - Carrega descricao do grupo (SigCdGrp)
7830:     *--------------------------------------------------------------------------
7831:     PROTECTED PROCEDURE CarregarDescGrupo(par_cCgrus)
7832:         LOCAL loc_cSQL, loc_oPg
7833:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7834: 
7835:         IF EMPTY(par_cCgrus)
7836:             loc_oPg.txt_4c_DgruDisplay.Value = ""
7837:             RETURN
7838:         ENDIF
7839: 
7840:         TRY
7841:             loc_cSQL = "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(par_cCgrus)
7842:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescGru") > 0
7843:                 IF !EOF("cursor_4c_DescGru")
7844:                     SELECT cursor_4c_DescGru
7845:                     loc_oPg.txt_4c_DgruDisplay.Value = ALLTRIM(dgrus)
7846:                 ELSE
7847:                     loc_oPg.txt_4c_DgruDisplay.Value = ""
7848:                 ENDIF
7849:                 IF USED("cursor_4c_DescGru")
7850:                     USE IN cursor_4c_DescGru
7851:                 ENDIF
7852:             ENDIF
7853:         CATCH TO loc_oErro
7854:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
7855:         ENDTRY
7856:     ENDPROC
7857: 
7858:     *--------------------------------------------------------------------------
7859:     * CarregarDescCods - Carrega descricao do subgrupo (via SigCdGrp ou tabela propria)
7860:     *--------------------------------------------------------------------------
7861:     PROTECTED PROCEDURE CarregarDescCods(par_cCods)
7862:         LOCAL loc_oPg, loc_cSQL
7863:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7864: 
7865:         IF EMPTY(par_cCods)
7866:             loc_oPg.txt_4c_DcodsDisplay.Value = ""
7867:             RETURN
7868:         ENDIF
7869: 
7870:         TRY
7871:             loc_cSQL = "SELECT dgrus AS descSubGrupo FROM SigCdGrp WHERE cgrus = " + EscaparSQL(par_cCods)
7872:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCods") > 0
7873:                 IF !EOF("cursor_4c_DescCods")
7874:                     SELECT cursor_4c_DescCods
7875:                     loc_oPg.txt_4c_DcodsDisplay.Value = ALLTRIM(descSubGrupo)
7876:                 ELSE
7877:                     loc_oPg.txt_4c_DcodsDisplay.Value = ""
7878:                 ENDIF
7879:                 IF USED("cursor_4c_DescCods")
7880:                     USE IN cursor_4c_DescCods
7881:                 ENDIF
7882:             ELSE
7883:                 loc_oPg.txt_4c_DcodsDisplay.Value = ""
7884:             ENDIF
7885:         CATCH TO loc_oErro
7886:             MsgErro(loc_oErro.Message, "Erro ao buscar subgrupo")
7887:         ENDTRY
7888:     ENDPROC
7889: 
7890:     *--------------------------------------------------------------------------
7891:     * CarregarDescLin - Carrega descricao da linha (SigCdLin, PK=linhas, desc=descs)
7892:     *--------------------------------------------------------------------------
7893:     PROTECTED PROCEDURE CarregarDescLin(par_cLinhas)
7894:         LOCAL loc_cSQL, loc_oPg
7895:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7896: 
7897:         IF EMPTY(par_cLinhas)
7898:             loc_oPg.txt_4c_DLinDisplay.Value = ""
7899:             RETURN
7900:         ENDIF
7901: 
7902:         TRY
7903:             loc_cSQL = "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(par_cLinhas)
7904:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescLin") > 0
7905:                 IF !EOF("cursor_4c_DescLin")
7906:                     SELECT cursor_4c_DescLin
7907:                     loc_oPg.txt_4c_DLinDisplay.Value = ALLTRIM(descs)
7908:                 ELSE
7909:                     loc_oPg.txt_4c_DLinDisplay.Value = ""
7910:                 ENDIF
7911:                 IF USED("cursor_4c_DescLin")
7912:                     USE IN cursor_4c_DescLin
7913:                 ENDIF
7914:             ENDIF
7915:         CATCH TO loc_oErro
7916:             MsgErro(loc_oErro.Message, "Erro ao buscar linha")
7917:         ENDTRY
7918:     ENDPROC
7919: 
7920:     *--------------------------------------------------------------------------
7921:     * CarregarDescCol - Exibe colecoes (campo texto direto em SigCdPro)
7922:     * Nota: nao existe tabela SigCdCol no banco; colecoes e campo texto livre
7923:     *--------------------------------------------------------------------------
7924:     PROTECTED PROCEDURE CarregarDescCol(par_cColecoes)
7925:         LOCAL loc_oPg
7926:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7927:         *-- Colecoes nao tem tabela de descricao - exibir o proprio valor
7928:         loc_oPg.txt_4c_DColDisplay.Value = par_cColecoes
7929:     ENDPROC
7930: 
7931:     *--------------------------------------------------------------------------
7932:     * CarregarDescIfor - Carrega nome do fornecedor
7933:     *--------------------------------------------------------------------------
7934:     PROTECTED PROCEDURE CarregarDescIfor(par_cIfors)
7935:         LOCAL loc_cSQL, loc_oPg
7936:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7937: 
7938:         IF EMPTY(par_cIfors)
7939:             loc_oPg.txt_4c_DforDisplay.Value = ""
7940:             RETURN
7941:         ENDIF
7942: 
7943:         TRY
7944:             *-- Fornecedor buscado via SigCdCli (ou tabela de fornecedores)
7945:             loc_cSQL = "SELECT Rclis AS dfors FROM SigCdCli WHERE Iclis = " + EscaparSQL(par_cIfors)
7946:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescIfor") > 0
7947:                 IF !EOF("cursor_4c_DescIfor")
7948:                     SELECT cursor_4c_DescIfor
7949:                     loc_oPg.txt_4c_DforDisplay.Value = ALLTRIM(dfors)
7950:                 ELSE
7951:                     loc_oPg.txt_4c_DforDisplay.Value = ""
7952:                 ENDIF
7953:                 IF USED("cursor_4c_DescIfor")
7954:                     USE IN cursor_4c_DescIfor
7955:                 ENDIF
7956:             ENDIF
7957:         CATCH TO loc_oErro
7958:             MsgErro(loc_oErro.Message, "Erro ao buscar fornecedor")
7959:         ENDTRY
7960:     ENDPROC
7961: 
7962:     *--------------------------------------------------------------------------
7963:     * CarregarDescCor - Carrega descricao da cor (SigCdCor, PK=cods, desc=descs)
7964:     *--------------------------------------------------------------------------
7965:     PROTECTED PROCEDURE CarregarDescCor(par_cCodCor)
7966:         LOCAL loc_cSQL, loc_oPg
7967:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7968:         IF EMPTY(par_cCodCor)
7969:             RETURN
7970:         ENDIF
7971:         TRY
7972:             loc_cSQL = "SELECT descs FROM SigCdCor WHERE cods = " + EscaparSQL(par_cCodCor)
7973:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCor") > 0
7974:                 IF !EOF("cursor_4c_DescCor")
7975:                     SELECT cursor_4c_DescCor
7976:                     loc_oPg.txt_4c_Cor.ToolTipText = ALLTRIM(descs)
7977:                 ENDIF
7978:                 IF USED("cursor_4c_DescCor")
7979:                     USE IN cursor_4c_DescCor
7980:                 ENDIF
7981:             ENDIF
7982:         CATCH TO loc_oErro
7983:             MsgErro(loc_oErro.Message, "Erro ao buscar cor")
7984:         ENDTRY
7985:     ENDPROC
7986: 
7987:     *--------------------------------------------------------------------------
7988:     * CarregarDescTam - Carrega descricao do tamanho (SigCdTam, PK=cods, desc=descs)
7989:     *--------------------------------------------------------------------------
7990:     PROTECTED PROCEDURE CarregarDescTam(par_cCodTam)
7991:         LOCAL loc_cSQL, loc_oPg
7992:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7993:         IF EMPTY(par_cCodTam)
7994:             RETURN
7995:         ENDIF
7996:         TRY
7997:             loc_cSQL = "SELECT descs FROM SigCdTam WHERE cods = " + EscaparSQL(par_cCodTam)
7998:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescTam") > 0
7999:                 IF !EOF("cursor_4c_DescTam")
8000:                     SELECT cursor_4c_DescTam
8001:                     loc_oPg.txt_4c_Tam.ToolTipText = ALLTRIM(descs)
8002:                 ENDIF
8003:                 IF USED("cursor_4c_DescTam")
8004:                     USE IN cursor_4c_DescTam
8005:                 ENDIF
8006:             ENDIF
8007:         CATCH TO loc_oErro
8008:             MsgErro(loc_oErro.Message, "Erro ao buscar tamanho")
8009:         ENDTRY
8010:     ENDPROC
8011: 
8012:     *--------------------------------------------------------------------------
8013:     * CarregarDescFinP - Carrega descricao da ficha (SigCdFip, PK=cods, desc=descs)
8014:     *--------------------------------------------------------------------------
8015:     PROTECTED PROCEDURE CarregarDescFinP(par_cCodFinP)
8016:         LOCAL loc_cSQL, loc_oPg
8017:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8018:         IF EMPTY(par_cCodFinP)
8019:             loc_oPg.txt_4c_DesFinP.Value = ""
8020:             RETURN
8021:         ENDIF
8022:         TRY
8023:             loc_cSQL = "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(par_cCodFinP)
8024:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFinP") > 0
8025:                 IF !EOF("cursor_4c_DescFinP")
8026:                     SELECT cursor_4c_DescFinP
8027:                     loc_oPg.txt_4c_DesFinP.Value = ALLTRIM(descs)
8028:                 ELSE
8029:                     loc_oPg.txt_4c_DesFinP.Value = ""
8030:                 ENDIF
8031:                 IF USED("cursor_4c_DescFinP")
8032:                     USE IN cursor_4c_DescFinP
8033:                 ENDIF
8034:             ENDIF
8035:         CATCH TO loc_oErro
8036:             MsgErro(loc_oErro.Message, "Erro ao buscar ficha")
8037:         ENDTRY
8038:     ENDPROC
8039: 
8040:     *--------------------------------------------------------------------------
8041:     * CarregarDescAcb - Carrega descricao do acabamento (SigCdAca, PK=cods, desc=descrs)
8042:     *--------------------------------------------------------------------------
8043:     PROTECTED PROCEDURE CarregarDescAcb(par_cCodAcb)
8044:         LOCAL loc_cSQL, loc_oPg
8045:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8046:         IF EMPTY(par_cCodAcb)
8047:             loc_oPg.txt_4c_DacbDisplay.Value = ""
8048:             RETURN
8049:         ENDIF
8050:         TRY
8051:             loc_cSQL = "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(par_cCodAcb)
8052:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescAcb") > 0
8053:                 IF !EOF("cursor_4c_DescAcb")
8054:                     SELECT cursor_4c_DescAcb
8055:                     loc_oPg.txt_4c_DacbDisplay.Value = ALLTRIM(descrs)
8056:                 ELSE
8057:                     loc_oPg.txt_4c_DacbDisplay.Value = ""
8058:                 ENDIF
8059:                 IF USED("cursor_4c_DescAcb")
8060:                     USE IN cursor_4c_DescAcb
8061:                 ENDIF
8062:             ENDIF
8063:         CATCH TO loc_oErro
8064:             MsgErro(loc_oErro.Message, "Erro ao buscar acabamento")
8065:         ENDTRY
8066:     ENDPROC
8067: 
8068:     *--------------------------------------------------------------------------
8069:     * CarregarDescClass - Carrega descricao da classificacao (SIGCDCLS, PK=cods, desc=descs)
8070:     *--------------------------------------------------------------------------
8071:     PROTECTED PROCEDURE CarregarDescClass(par_cCclass)
8072:         LOCAL loc_cSQL, loc_oPg
8073:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8074:         IF EMPTY(par_cCclass)
8075:             loc_oPg.txt_4c_DClassDisplay.Value = ""
8076:             RETURN
8077:         ENDIF
8078:         TRY
8079:             loc_cSQL = "SELECT descs FROM SIGCDCLS WHERE cods = " + EscaparSQL(par_cCclass)
8080:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescClass") > 0
8081:                 IF !EOF("cursor_4c_DescClass")
8082:                     SELECT cursor_4c_DescClass
8083:                     loc_oPg.txt_4c_DClassDisplay.Value = ALLTRIM(descs)
8084:                 ELSE
8085:                     loc_oPg.txt_4c_DClassDisplay.Value = ""
8086:                 ENDIF
8087:                 IF USED("cursor_4c_DescClass")
8088:                     USE IN cursor_4c_DescClass
8089:                 ENDIF
8090:             ENDIF
8091:         CATCH TO loc_oErro
8092:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o")
8093:         ENDTRY
8094:     ENDPROC
8095: 
8096:     *--------------------------------------------------------------------------
8097:     * CarregarDescLocal - Carrega descricao do local (SigPrLcl, PK=codigos, desc=descricaos)
8098:     *--------------------------------------------------------------------------
8099:     PROTECTED PROCEDURE CarregarDescLocal(par_cLocals)
8100:         LOCAL loc_cSQL, loc_oPg
8101:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8102:         IF EMPTY(par_cLocals)
8103:             RETURN
8104:         ENDIF
8105:         TRY
8106:             loc_cSQL = "SELECT descricaos FROM SigPrLcl WHERE codigos = " + EscaparSQL(par_cLocals)
8107:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescLocal") > 0
8108:                 IF !EOF("cursor_4c_DescLocal")
8109:                     SELECT cursor_4c_DescLocal
8110:                     loc_oPg.txt_4c_Local.ToolTipText = ALLTRIM(descricaos)
8111:                 ENDIF
8112:                 IF USED("cursor_4c_DescLocal")
8113:                     USE IN cursor_4c_DescLocal
8114:                 ENDIF
8115:             ENDIF
8116:         CATCH TO loc_oErro
8117:             MsgErro(loc_oErro.Message, "Erro ao buscar local")
8118:         ENDTRY
8119:     ENDPROC
8120: 
8121:     *--------------------------------------------------------------------------
8122:     * CarregarDescUni - Carrega descricao da unidade (SigCdUni, PK=cunis, desc=dunis)
8123:     * par_cTipo: "uni" = unidade principal, "unip" = unidade de pedido
8124:     *--------------------------------------------------------------------------
8125:     PROTECTED PROCEDURE CarregarDescUni(par_cCunis, par_cTipo)
8126:         LOCAL loc_cSQL, loc_oPg
8127:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8128:         IF EMPTY(par_cCunis)
8129:             IF par_cTipo = "uni"
8130:                 loc_oPg.txt_4c_DuniDisplay.Value  = ""
8131:             ELSE
8132:                 loc_oPg.txt_4c_DunipDisplay.Value = ""
8133:             ENDIF
8134:             RETURN
8135:         ENDIF
8136:         TRY
8137:             loc_cSQL = "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(par_cCunis)
8138:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescUni") > 0
8139:                 IF !EOF("cursor_4c_DescUni")
8140:                     SELECT cursor_4c_DescUni
8141:                     IF par_cTipo = "uni"
8142:                         loc_oPg.txt_4c_DuniDisplay.Value  = ALLTRIM(dunis)
8143:                     ELSE
8144:                         loc_oPg.txt_4c_DunipDisplay.Value = ALLTRIM(dunis)
8145:                     ENDIF
8146:                 ELSE
8147:                     IF par_cTipo = "uni"
8148:                         loc_oPg.txt_4c_DuniDisplay.Value  = ""
8149:                     ELSE
8150:                         loc_oPg.txt_4c_DunipDisplay.Value = ""
8151:                     ENDIF
8152:                 ENDIF
8153:                 IF USED("cursor_4c_DescUni")
8154:                     USE IN cursor_4c_DescUni
8155:                 ENDIF
8156:             ENDIF
8157:         CATCH TO loc_oErro
8158:             MsgErro(loc_oErro.Message, "Erro ao buscar unidade")
8159:         ENDTRY
8160:     ENDPROC
8161: 
8162:     *--------------------------------------------------------------------------
8163:     * CarregarDescMoe - Carrega descricao da moeda (SigCdMoe, PK=cmoes, desc=dmoes)
8164:     * par_cTipo: "total" | "pvenda" | "fvenda"
8165:     *--------------------------------------------------------------------------
8166:     PROTECTED PROCEDURE CarregarDescMoe(par_cCmoes, par_cTipo)
8167:         LOCAL loc_cSQL, loc_oPg, loc_cDesc
8168:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8169:         loc_cDesc = ""
8170:         IF EMPTY(par_cCmoes)
8171:             RETURN
8172:         ENDIF
8173:         TRY
8174:             loc_cSQL = "SELECT dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(par_cCmoes)
8175:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescMoe") > 0
8176:                 IF !EOF("cursor_4c_DescMoe")
8177:                     SELECT cursor_4c_DescMoe
8178:                     loc_cDesc = ALLTRIM(dmoes)
8179:                 ENDIF
8180:                 IF USED("cursor_4c_DescMoe")
8181:                     USE IN cursor_4c_DescMoe
8182:                 ENDIF
8183:             ENDIF
8184:         CATCH TO loc_oErro
8185:             MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
8186:         ENDTRY
8187:         DO CASE
8188:         CASE par_cTipo = "total"
8189:             loc_oPg.txt_4c_Mctotal.ToolTipText = loc_cDesc
8190:         CASE par_cTipo = "pvenda"
8191:             loc_oPg.txt_4c_Mpvenda.ToolTipText = loc_cDesc
8192:         CASE par_cTipo = "fvenda"
8193:             loc_oPg.txt_4c_Mfvenda.ToolTipText = loc_cDesc
8194:         ENDCASE
8195:     ENDPROC
8196: 
8197:     *--------------------------------------------------------------------------
8198:     * CarregarDescFiscais - Carrega descricoes e historico CMV da Fase 13
8199:     * par_cCpros: codigo produto; demais: codigos para lookup de descricoes
8200:     *--------------------------------------------------------------------------
8201:     PROTECTED PROCEDURE CarregarDescFiscais(par_cCpros, par_cGruccus, par_cContaccus, ;
8202:                                              par_cClfiscals, par_cOrigmercs, par_cSittricms, ;
8203:                                              par_cMetals, par_cTeors)
8204:         LOCAL loc_oPg3, loc_cSQL, loc_cDesc
8205:         loc_oPg3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
8206: 
8207:         TRY
8208:             *-- Grupo CC (SigCdGcr)
8209:             IF !EMPTY(par_cGruccus)
8210:                 loc_cSQL = "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(par_cGruccus)
8211:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
8212:                     loc_oPg3.txt_4c_Dgruccus.Value = ALLTRIM(cursor_4c_DescFisc.descrs)
8213:                 ENDIF
8214:                 IF USED("cursor_4c_DescFisc")
8215:                     USE IN cursor_4c_DescFisc
8216:                 ENDIF
8217:             ENDIF
8218: 
8219:             *-- Conta CC (SigCdCli)
8220:             IF !EMPTY(par_cContaccus)
8221:                 loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE IClis = " + EscaparSQL(par_cContaccus)
8222:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
8223:                     loc_oPg3.txt_4c_Dcontaccus.Value = ALLTRIM(cursor_4c_DescFisc.Rclis)
8224:                 ENDIF
8225:                 IF USED("cursor_4c_DescFisc")
8226:                     USE IN cursor_4c_DescFisc
8227:                 ENDIF
8228:             ENDIF
8229: 
8230:             *-- Classificacao Fiscal (SigCdClf)
8231:             IF !EMPTY(par_cClfiscals)
8232:                 loc_cSQL = "SELECT Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(par_cClfiscals)
8233:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
8234:                     loc_oPg3.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_DescFisc.Descricaos)
8235:                 ENDIF
8236:                 IF USED("cursor_4c_DescFisc")
8237:                     USE IN cursor_4c_DescFisc
8238:                 ENDIF
8239:             ENDIF
8240: 
8241:             *-- Origem da Mercadoria (SigCdOrg)

*-- Linhas 8320 a 8363:
8320:     *--------------------------------------------------------------------------
8321:     * HabilitarCampos - Habilita/desabilita campos editaveis conforme modo
8322:     *--------------------------------------------------------------------------
8323:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
8324:         LOCAL loc_oPg, loc_lReadOnly, loc_cBgEdit, loc_cBgRO
8325:         loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8326:         loc_lReadOnly = !par_lHabilitar
8327:         loc_cBgEdit  = RGB(255, 255, 255)
8328:         loc_cBgRO    = RGB(224, 235, 235)
8329: 
8330:         TRY
8331:             *-- Fase 5: Campos editaveis basicos
8332:             loc_oPg.txt_4c_Cpros.ReadOnly  = loc_lReadOnly
8333:             loc_oPg.txt_4c_Cpros.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8334: 
8335:             loc_oPg.txt_4c_DPro2s.ReadOnly  = loc_lReadOnly
8336:             loc_oPg.txt_4c_DPro2s.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8337: 
8338:             loc_oPg.txt_4c_Cbar.ReadOnly  = loc_lReadOnly
8339:             loc_oPg.txt_4c_Cbar.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8340: 
8341:             loc_oPg.txt_4c_Cgrus.ReadOnly  = loc_lReadOnly
8342:             loc_oPg.txt_4c_Cgrus.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8343: 
8344:             loc_oPg.txt_4c_Cods.ReadOnly  = loc_lReadOnly
8345:             loc_oPg.txt_4c_Cods.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8346: 
8347:             loc_oPg.txt_4c_Lin.ReadOnly  = loc_lReadOnly
8348:             loc_oPg.txt_4c_Lin.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8349: 
8350:             loc_oPg.txt_4c_Col.ReadOnly  = loc_lReadOnly
8351:             loc_oPg.txt_4c_Col.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8352: 
8353:             loc_oPg.txt_4c_Ifor.ReadOnly  = loc_lReadOnly
8354:             loc_oPg.txt_4c_Ifor.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8355: 
8356:             loc_oPg.txt_4c_Refs.ReadOnly  = loc_lReadOnly
8357:             loc_oPg.txt_4c_Refs.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8358: 
8359:             *-- Fase 6: Novos campos editaveis
8360:             loc_oPg.txt_4c_Cor.ReadOnly  = loc_lReadOnly
8361:             loc_oPg.txt_4c_Cor.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8362: 
8363:             loc_oPg.txt_4c_Tam.ReadOnly  = loc_lReadOnly

*-- Linhas 8482 a 8525:
8482:     *--------------------------------------------------------------------------
8483:     * LimparCampos - Limpa todos os campos da aba pgDados
8484:     *--------------------------------------------------------------------------
8485:     PROTECTED PROCEDURE LimparCampos()
8486:         LOCAL loc_oPg
8487:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8488: 
8489:         TRY
8490:             *-- Linha 1: Produto
8491:             loc_oPg.txt_4c_Cpros.Value        = ""
8492:             loc_oPg.txt_4c_Dpros.Value        = ""
8493:             *-- Linha 2: Descritivo 2 + Barra
8494:             loc_oPg.txt_4c_DPro2s.Value       = ""
8495:             loc_oPg.txt_4c_Cbar.Value         = ""
8496:             *-- Linha 3: Grupo
8497:             loc_oPg.txt_4c_Cgrus.Value        = ""
8498:             loc_oPg.txt_4c_DgruDisplay.Value  = ""
8499:             *-- Linha 4: Subgrupo
8500:             loc_oPg.txt_4c_Cods.Value         = ""
8501:             loc_oPg.txt_4c_DcodsDisplay.Value = ""
8502:             *-- Linha 5: Linha
8503:             loc_oPg.txt_4c_Lin.Value          = ""
8504:             loc_oPg.txt_4c_DLinDisplay.Value  = ""
8505:             *-- Linha 6: Colecao/Venda
8506:             loc_oPg.txt_4c_Col.Value          = ""
8507:             loc_oPg.txt_4c_DColDisplay.Value  = ""
8508:             *-- Linha 7: Fornecedor
8509:             loc_oPg.txt_4c_Ifor.Value         = ""
8510:             loc_oPg.txt_4c_DforDisplay.Value  = ""
8511:             *-- Linha 8: Ref. Fornecedor + Cor + Tamanho
8512:             loc_oPg.txt_4c_Refs.Value         = ""
8513:             loc_oPg.txt_4c_Cor.Value          = ""
8514:             loc_oPg.txt_4c_Tam.Value          = ""
8515:             *-- Linha 9: Ficha + Peso Base
8516:             loc_oPg.txt_4c_CodFinP.Value      = ""
8517:             loc_oPg.txt_4c_DesFinP.Value      = ""
8518:             loc_oPg.txt_4c_PesoB.Value        = 0.0
8519:             *-- Linha 10: Acabamento + Preco Medio
8520:             loc_oPg.txt_4c_CodAcb.Value       = ""
8521:             loc_oPg.txt_4c_DacbDisplay.Value  = ""
8522:             loc_oPg.txt_4c_Pmedio.Value       = 0.0
8523:             *-- Linha 11: Classificacao + Local
8524:             loc_oPg.txt_4c_Class.Value         = ""
8525:             loc_oPg.txt_4c_DClassDisplay.Value = ""

*-- Linhas 8591 a 11385:
8591:     *--------------------------------------------------------------------------
8592:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
8593:     *--------------------------------------------------------------------------
8594:     PROTECTED PROCEDURE AjustarBotoesPorModo()
8595:         LOCAL loc_oCnt, loc_lTemRegistro
8596:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
8597:         loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
8598: 
8599:         TRY
8600:             loc_oCnt.cmd_4c_Incluir.Enabled    = .T.
8601:             loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
8602:             loc_oCnt.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
8603:             loc_oCnt.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
8604:             loc_oCnt.cmd_4c_Procurar.Enabled   = .T.
8605:         CATCH TO loc_oErro
8606:             MsgErro(loc_oErro.Message, "Erro ao ajustar bot" + CHR(245) + "es")
8607:         ENDTRY
8608:     ENDPROC
8609: 
8610:     *==========================================================================
8611:     * HANDLERS DE BOTOES CRUD
8612:     *==========================================================================
8613: 
8614:     *--------------------------------------------------------------------------
8615:     * BtnIncluirClick - Acao do botao Incluir
8616:     *--------------------------------------------------------------------------
8617:     PROCEDURE BtnIncluirClick()
8618:         THIS.this_oBusinessObject.NovoRegistro()
8619:         THIS.LimparCampos()
8620:         THIS.this_cModoAtual = "INCLUIR"
8621:         THIS.HabilitarCampos(.T.)
8622:         THIS.AlternarPagina(2)
8623:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.txt_4c_Cpros.SetFocus()
8624:     ENDPROC
8625: 
8626:     *--------------------------------------------------------------------------
8627:     * BtnVisualizarClick - Acao do botao Visualizar
8628:     *--------------------------------------------------------------------------
8629:     PROCEDURE BtnVisualizarClick()
8630:         LOCAL loc_cChave
8631: 
8632:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
8633:             MsgAviso("Nenhum registro selecionado.")
8634:             RETURN
8635:         ENDIF
8636: 
8637:         loc_cChave = ALLTRIM(cursor_4c_Dados.pkchaves)
8638: 
8639:         TRY
8640:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
8641:                 THIS.BOParaForm()
8642:                 THIS.this_cModoAtual = "VISUALIZAR"
8643:                 THIS.HabilitarCampos(.F.)
8644:                 THIS.AlternarPagina(2)
8645:             ENDIF
8646:         CATCH TO loc_oErro
8647:             MsgErro(loc_oErro.Message, "Erro ao visualizar registro")
8648:         ENDTRY
8649:     ENDPROC
8650: 
8651:     *--------------------------------------------------------------------------
8652:     * BtnAlterarClick - Acao do botao Alterar
8653:     *--------------------------------------------------------------------------
8654:     PROCEDURE BtnAlterarClick()
8655:         LOCAL loc_cChave
8656: 
8657:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
8658:             MsgAviso("Nenhum registro selecionado.")
8659:             RETURN
8660:         ENDIF
8661: 
8662:         loc_cChave = ALLTRIM(cursor_4c_Dados.pkchaves)
8663: 
8664:         TRY
8665:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
8666:                 THIS.this_oBusinessObject.EditarRegistro()
8667:                 THIS.BOParaForm()
8668:                 THIS.this_cModoAtual = "ALTERAR"
8669:                 THIS.HabilitarCampos(.T.)
8670:                 THIS.AlternarPagina(2)
8671:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.txt_4c_Cpros.SetFocus()
8672:             ENDIF
8673:         CATCH TO loc_oErro
8674:             MsgErro(loc_oErro.Message, "Erro ao alterar registro")
8675:         ENDTRY
8676:     ENDPROC
8677: 
8678:     *--------------------------------------------------------------------------
8679:     * BtnExcluirClick - Acao do botao Excluir
8680:     *--------------------------------------------------------------------------
8681:     PROCEDURE BtnExcluirClick()
8682:         LOCAL loc_cChave
8683: 
8684:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
8685:             MsgAviso("Nenhum registro selecionado.")
8686:             RETURN
8687:         ENDIF
8688: 
8689:         loc_cChave = ALLTRIM(cursor_4c_Dados.pkchaves)
8690: 
8691:         TRY
8692:             IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
8693:                 "Excluir Produto")
8694:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
8695:                     IF THIS.this_oBusinessObject.Excluir()
8696:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Exclu" + CHR(237) + "do")
8697:                         THIS.CarregarLista()
8698:                         THIS.AjustarBotoesPorModo()
8699:                     ELSE
8700:                         MsgErro("Erro ao excluir registro.", "Erro")
8701:                     ENDIF
8702:                 ENDIF
8703:             ENDIF
8704:         CATCH TO loc_oErro
8705:             MsgErro(loc_oErro.Message, "Erro ao excluir registro")
8706:         ENDTRY
8707:     ENDPROC
8708: 
8709:     *--------------------------------------------------------------------------
8710:     * BtnProcurarClick - Acao do botao Procurar (busca e seleciona produto na lista)
8711:     *--------------------------------------------------------------------------
8712:     PROCEDURE BtnProcurarClick()
8713:         LOCAL loc_oBusca, loc_cCpros
8714: 
8715:         TRY
8716:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Busca de Produto")
8717:             loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
8718:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
8719:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
8720:             loc_oBusca.Show()
8721: 
8722:             IF loc_oBusca.this_lSelecionou
8723:                 IF USED("cursor_4c_Busca")
8724:                     SELECT cursor_4c_Busca
8725:                     loc_cCpros = ALLTRIM(cpros)
8726:                     USE IN cursor_4c_Busca
8727:                 ENDIF
8728: 
8729:                 *-- Posiciona grid na linha do produto selecionado
8730:                 IF !EMPTY(loc_cCpros) AND USED("cursor_4c_Dados")
8731:                     SELECT cursor_4c_Dados
8732:                     LOCATE FOR ALLTRIM(cpros) = loc_cCpros
8733:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
8734:                 ENDIF
8735:             ENDIF
8736: 
8737:             IF VARTYPE(loc_oBusca) = "O"
8738:                 loc_oBusca.Release()
8739:                 loc_oBusca = .NULL.
8740:             ENDIF
8741:         CATCH TO loc_oErro
8742:             MsgErro(loc_oErro.Message, "Erro ao procurar produto")
8743:         ENDTRY
8744:     ENDPROC
8745: 
8746:     *--------------------------------------------------------------------------
8747:     * BtnSalvarClick - Acao do botao Salvar
8748:     *--------------------------------------------------------------------------
8749:     PROCEDURE BtnSalvarClick()
8750:         LOCAL loc_oPg
8751: 
8752:         *-- Validar campos obrigatorios
8753:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8754: 
8755:         IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Cpros.Value))
8756:             MsgAviso("Campo Produto " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
8757:             loc_oPg.txt_4c_Cpros.SetFocus()
8758:             RETURN
8759:         ENDIF
8760: 
8761:         IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Cgrus.Value))
8762:             MsgAviso("Campo Grupo " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
8763:             loc_oPg.txt_4c_Cgrus.SetFocus()
8764:             RETURN
8765:         ENDIF
8766: 
8767:         TRY
8768:             THIS.FormParaBO()
8769: 
8770:             IF THIS.this_cModoAtual = "INCLUIR"
8771:                 *-- Gerar pkchaves: char(20), unica
8772:                 THIS.this_oBusinessObject.this_cPkchaves = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)
8773:             ENDIF
8774: 
8775:             IF THIS.this_oBusinessObject.Salvar()
8776:                 THIS.AtualizarSigCdPro()
8777:                 MsgInfo("Registro salvo com sucesso.", "Salvo")
8778:                 THIS.AlternarPagina(1)
8779:             ELSE
8780:                 MsgErro("Erro ao salvar registro.", "Erro")
8781:             ENDIF
8782: 
8783:         CATCH TO loc_oErro
8784:             MsgErro(loc_oErro.Message, "Erro ao salvar")
8785:         ENDTRY
8786:     ENDPROC
8787: 
8788:     *--------------------------------------------------------------------------
8789:     * BtnCancelarClick - Acao do botao Cancelar
8790:     *--------------------------------------------------------------------------
8791:     PROCEDURE BtnCancelarClick()
8792:         THIS.this_oBusinessObject.CancelarEdicao()
8793:         THIS.AlternarPagina(1)
8794:     ENDPROC
8795: 
8796:     *--------------------------------------------------------------------------
8797:     * BtnSairClick - Acao do botao Sair
8798:     *--------------------------------------------------------------------------
8799:     PROCEDURE BtnSairClick()
8800:         THIS.Release()
8801:     ENDPROC
8802: 
8803:     *==========================================================================
8804:     * HANDLERS DE FILTROS
8805:     *==========================================================================
8806: 
8807:     *--------------------------------------------------------------------------
8808:     * FiltroSituacaoChange - Disparado quando muda opcao de situacao no filtro
8809:     *--------------------------------------------------------------------------
8810:     PROCEDURE FiltroSituacaoChange()
8811:         IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
8812:             THIS.CarregarLista()
8813:         ENDIF
8814:     ENDPROC
8815: 
8816:     *==========================================================================
8817:     * HANDLERS DE KEYPRESS (ENTER/TAB/F4 disparam lookup)
8818:     *==========================================================================
8819: 
8820:     *--------------------------------------------------------------------------
8821:     * TxtFilCgruKeyPress - KeyPress no filtro de grupo (ENTER/TAB carrega lista)
8822:     *--------------------------------------------------------------------------
8823:     PROCEDURE TxtFilCgruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8824:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8825:             IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
8826:                 THIS.CarregarLista()
8827:             ENDIF
8828:         ENDIF
8829:     ENDPROC
8830: 
8831:     *--------------------------------------------------------------------------
8832:     * TxtCprosKeyPress - KeyPress no campo Cpros (ENTER/F4 abre lookup SigCdPro)
8833:     *--------------------------------------------------------------------------
8834:     PROCEDURE TxtCprosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8835:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8836:             *-- Validar produto ao sair
8837:             THIS.ValidarCpros()
8838:         ENDIF
8839:         IF par_nKeyCode = 115
8840:             *-- F4 = 115 -> abrir lookup
8841:             THIS.AbrirLookupProduto()
8842:         ENDIF
8843:     ENDPROC
8844: 
8845:     *--------------------------------------------------------------------------
8846:     * TxtCgrusKeyPress - KeyPress no campo Cgrus (ENTER/F4 abre lookup de grupo)
8847:     *--------------------------------------------------------------------------
8848:     PROCEDURE TxtCgrusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8849:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8850:             THIS.ValidarCgrus()
8851:         ENDIF
8852:         IF par_nKeyCode = 115
8853:             THIS.AbrirLookupGrupo()
8854:         ENDIF
8855:     ENDPROC
8856: 
8857:     *--------------------------------------------------------------------------
8858:     * TxtLinKeyPress - KeyPress no campo Lin (ENTER/F4 abre lookup SigCdLin)
8859:     *--------------------------------------------------------------------------
8860:     PROCEDURE TxtLinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8861:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8862:             THIS.ValidarLin()
8863:         ENDIF
8864:         IF par_nKeyCode = 115
8865:             THIS.AbrirLookupLin()
8866:         ENDIF
8867:     ENDPROC
8868: 
8869:     *--------------------------------------------------------------------------
8870:     * TxtColKeyPress - KeyPress no campo Col (ENTER/F4 abre lookup SigCdCol)
8871:     *--------------------------------------------------------------------------
8872:     PROCEDURE TxtColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8873:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8874:             THIS.ValidarCol()
8875:         ENDIF
8876:         IF par_nKeyCode = 115
8877:             THIS.AbrirLookupCol()
8878:         ENDIF
8879:     ENDPROC
8880: 
8881:     *--------------------------------------------------------------------------
8882:     * TxtIforKeyPress - KeyPress no campo Ifor (ENTER/F4 abre lookup fornecedor)
8883:     *--------------------------------------------------------------------------
8884:     PROCEDURE TxtIforKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8885:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8886:             THIS.ValidarIfor()
8887:         ENDIF
8888:         IF par_nKeyCode = 115
8889:             THIS.AbrirLookupIfor()
8890:         ENDIF
8891:     ENDPROC
8892: 
8893:     *==========================================================================
8894:     * VALIDACOES
8895:     *==========================================================================
8896: 
8897:     *--------------------------------------------------------------------------
8898:     * ValidarCpros - Valida campo cpros e carrega todos os dados do SigCdPro
8899:     *--------------------------------------------------------------------------
8900:     PROTECTED PROCEDURE ValidarCpros()
8901:         LOCAL loc_cCpros, loc_cSQL, loc_oPg
8902:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8903:         loc_cCpros = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
8904: 
8905:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8906:             RETURN
8907:         ENDIF
8908: 
8909:         IF EMPTY(loc_cCpros)
8910:             THIS.CarregarDadosSigCdPro("")
8911:             RETURN
8912:         ENDIF
8913: 
8914:         TRY
8915:             *-- Verificar se produto existe antes de carregar todos os dados
8916:             loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
8917: 
8918:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValPro") > 0
8919:                 SELECT cursor_4c_ValPro
8920:                 IF nExiste > 0
8921:                     IF USED("cursor_4c_ValPro")
8922:                         USE IN cursor_4c_ValPro
8923:                     ENDIF
8924:                     THIS.CarregarDadosSigCdPro(loc_cCpros)
8925:                 ELSE
8926:                     IF USED("cursor_4c_ValPro")
8927:                         USE IN cursor_4c_ValPro
8928:                     ENDIF
8929:                     THIS.CarregarDadosSigCdPro("")
8930:                     MsgAviso("Produto " + loc_cCpros + " n" + CHR(227) + "o encontrado.", "Produto Inv" + CHR(225) + "lido")
8931:                 ENDIF
8932:             ENDIF
8933:         CATCH TO loc_oErro
8934:             MsgErro(loc_oErro.Message, "Erro ao validar produto")
8935:         ENDTRY
8936:     ENDPROC
8937: 
8938:     *--------------------------------------------------------------------------
8939:     * ValidarCgrus - Valida campo cgrus e carrega descricao do grupo
8940:     *--------------------------------------------------------------------------
8941:     PROTECTED PROCEDURE ValidarCgrus()
8942:         LOCAL loc_cCgrus, loc_oPg
8943:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8944:         loc_cCgrus = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
8945: 
8946:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8947:             RETURN
8948:         ENDIF
8949: 
8950:         THIS.CarregarDescGrupo(loc_cCgrus)
8951: 
8952:         IF !EMPTY(loc_cCgrus) AND EMPTY(loc_oPg.txt_4c_DgruDisplay.Value)
8953:             MsgAviso("Grupo " + loc_cCgrus + " n" + CHR(227) + "o encontrado.", "Grupo Inv" + CHR(225) + "lido")
8954:         ENDIF
8955:     ENDPROC
8956: 
8957:     *--------------------------------------------------------------------------
8958:     * ValidarLin - Valida campo lin e carrega descricao da linha (SigCdLin)
8959:     *--------------------------------------------------------------------------
8960:     PROTECTED PROCEDURE ValidarLin()
8961:         LOCAL loc_cClins, loc_oPg
8962:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8963:         loc_cClins = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
8964: 
8965:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8966:             RETURN
8967:         ENDIF
8968: 
8969:         THIS.CarregarDescLin(loc_cClins)
8970: 
8971:         IF !EMPTY(loc_cClins) AND EMPTY(loc_oPg.txt_4c_DLinDisplay.Value)
8972:             MsgAviso("Linha " + loc_cClins + " n" + CHR(227) + "o encontrada.", "Linha Inv" + CHR(225) + "lida")
8973:         ENDIF
8974:     ENDPROC
8975: 
8976:     *--------------------------------------------------------------------------
8977:     * ValidarCol - Valida campo col e carrega descricao do grupo de venda (SigCdCol)
8978:     *--------------------------------------------------------------------------
8979:     PROTECTED PROCEDURE ValidarCol()
8980:         LOCAL loc_cCcols, loc_oPg
8981:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8982:         loc_cCcols = ALLTRIM(loc_oPg.txt_4c_Col.Value)
8983: 
8984:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8985:             RETURN
8986:         ENDIF
8987: 
8988:         THIS.CarregarDescCol(loc_cCcols)
8989: 
8990:         IF !EMPTY(loc_cCcols) AND EMPTY(loc_oPg.txt_4c_DColDisplay.Value)
8991:             MsgAviso("Grupo de venda " + loc_cCcols + " n" + CHR(227) + "o encontrado.", "Inv" + CHR(225) + "lido")
8992:         ENDIF
8993:     ENDPROC
8994: 
8995:     *--------------------------------------------------------------------------
8996:     * ValidarIfor - Valida campo ifor e carrega nome do fornecedor
8997:     *--------------------------------------------------------------------------
8998:     PROTECTED PROCEDURE ValidarIfor()
8999:         LOCAL loc_cIfors, loc_oPg
9000:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9001:         loc_cIfors = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)
9002: 
9003:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9004:             RETURN
9005:         ENDIF
9006: 
9007:         THIS.CarregarDescIfor(loc_cIfors)
9008: 
9009:         IF !EMPTY(loc_cIfors) AND EMPTY(loc_oPg.txt_4c_DforDisplay.Value)
9010:             MsgAviso("Fornecedor " + loc_cIfors + " n" + CHR(227) + "o encontrado.", "Inv" + CHR(225) + "lido")
9011:         ENDIF
9012:     ENDPROC
9013: 
9014:     *==========================================================================
9015:     * LOOKUPS (FormBuscaAuxiliar)
9016:     *==========================================================================
9017: 
9018:     *--------------------------------------------------------------------------
9019:     * AbrirLookupProduto - Abre busca de produto (SigCdPro)
9020:     *--------------------------------------------------------------------------
9021:     PROCEDURE AbrirLookupProduto()
9022:         LOCAL loc_oBusca, loc_oPg
9023:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9024: 
9025:         TRY
9026:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Busca de Produto")
9027:             loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
9028:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
9029:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
9030:             loc_oBusca.Show()
9031: 
9032:             IF loc_oBusca.this_lSelecionou
9033:                 IF USED("cursor_4c_Busca")
9034:                     SELECT cursor_4c_Busca
9035:                     loc_oPg.txt_4c_Cpros.Value = ALLTRIM(cpros)
9036:                     loc_oPg.txt_4c_Dpros.Value = ALLTRIM(dpros)
9037:                     USE IN cursor_4c_Busca
9038:                 ENDIF
9039:             ENDIF
9040: 
9041:             loc_oBusca.Release()
9042:             loc_oBusca = .NULL.
9043:         CATCH TO loc_oErro
9044:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de produto")
9045:         ENDTRY
9046:     ENDPROC
9047: 
9048:     *--------------------------------------------------------------------------
9049:     * AbrirLookupGrupo - Abre busca de grupo (SigCdGrp)
9050:     *--------------------------------------------------------------------------
9051:     PROCEDURE AbrirLookupGrupo()
9052:         LOCAL loc_oBusca, loc_oPg
9053:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9054: 
9055:         TRY
9056:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", "cursor_4c_Busca", "cgrus", "", "Busca de Grupo")
9057:             loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
9058:             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
9059:             loc_oBusca.Show()
9060: 
9061:             IF loc_oBusca.this_lSelecionou
9062:                 IF USED("cursor_4c_Busca")
9063:                     SELECT cursor_4c_Busca
9064:                     loc_oPg.txt_4c_Cgrus.Value       = ALLTRIM(cgrus)
9065:                     loc_oPg.txt_4c_DgruDisplay.Value = ALLTRIM(dgrus)
9066:                     USE IN cursor_4c_Busca
9067:                 ENDIF
9068:             ENDIF
9069: 
9070:             loc_oBusca.Release()
9071:             loc_oBusca = .NULL.
9072:         CATCH TO loc_oErro
9073:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo")
9074:         ENDTRY
9075:     ENDPROC
9076: 
9077:     *--------------------------------------------------------------------------
9078:     * AbrirLookupLin - Abre busca de linha (SigCdLin)
9079:     *--------------------------------------------------------------------------
9080:     PROCEDURE AbrirLookupLin()
9081:         LOCAL loc_oBusca, loc_oPg
9082:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9083: 
9084:         TRY
9085:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLin", "cursor_4c_Busca", "clins", "", "Busca de Linha")
9086:             loc_oBusca.mAddColuna("clins", "", "C" + CHR(243) + "digo")
9087:             loc_oBusca.mAddColuna("dlins", "", "Descri" + CHR(231) + CHR(227) + "o")
9088:             loc_oBusca.Show()
9089: 
9090:             IF loc_oBusca.this_lSelecionou
9091:                 IF USED("cursor_4c_Busca")
9092:                     SELECT cursor_4c_Busca
9093:                     loc_oPg.txt_4c_Lin.Value          = ALLTRIM(clins)
9094:                     loc_oPg.txt_4c_DLinDisplay.Value  = ALLTRIM(dlins)
9095:                     USE IN cursor_4c_Busca
9096:                 ENDIF
9097:             ENDIF
9098: 
9099:             loc_oBusca.Release()
9100:             loc_oBusca = .NULL.
9101:         CATCH TO loc_oErro
9102:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de linha")
9103:         ENDTRY
9104:     ENDPROC
9105: 
9106:     *--------------------------------------------------------------------------
9107:     * AbrirLookupCol - Abre busca de grupo de venda (SigCdCol)
9108:     *--------------------------------------------------------------------------
9109:     PROCEDURE AbrirLookupCol()
9110:         LOCAL loc_oBusca, loc_oPg
9111:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9112: 
9113:         TRY
9114:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", "cursor_4c_Busca", "ccols", "", "Busca de Grupo de Venda")
9115:             loc_oBusca.mAddColuna("ccols", "", "C" + CHR(243) + "digo")
9116:             loc_oBusca.mAddColuna("dcols", "", "Descri" + CHR(231) + CHR(227) + "o")
9117:             loc_oBusca.Show()
9118: 
9119:             IF loc_oBusca.this_lSelecionou
9120:                 IF USED("cursor_4c_Busca")
9121:                     SELECT cursor_4c_Busca
9122:                     loc_oPg.txt_4c_Col.Value          = ALLTRIM(ccols)
9123:                     loc_oPg.txt_4c_DColDisplay.Value  = ALLTRIM(dcols)
9124:                     USE IN cursor_4c_Busca
9125:                 ENDIF
9126:             ENDIF
9127: 
9128:             loc_oBusca.Release()
9129:             loc_oBusca = .NULL.
9130:         CATCH TO loc_oErro
9131:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo de venda")
9132:         ENDTRY
9133:     ENDPROC
9134: 
9135:     *--------------------------------------------------------------------------
9136:     * AbrirLookupIfor - Abre busca de fornecedor (SigCdCli)
9137:     *--------------------------------------------------------------------------
9138:     PROCEDURE AbrirLookupIfor()
9139:         LOCAL loc_oBusca, loc_oPg
9140:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9141: 
9142:         TRY
9143:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_Busca", "Iclis", "", "Busca de Fornecedor")
9144:             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
9145:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
9146:             loc_oBusca.Show()
9147: 
9148:             IF loc_oBusca.this_lSelecionou
9149:                 IF USED("cursor_4c_Busca")
9150:                     SELECT cursor_4c_Busca
9151:                     loc_oPg.txt_4c_Ifor.Value         = ALLTRIM(Iclis)
9152:                     loc_oPg.txt_4c_DforDisplay.Value  = ALLTRIM(Rclis)
9153:                     USE IN cursor_4c_Busca
9154:                 ENDIF
9155:             ENDIF
9156: 
9157:             loc_oBusca.Release()
9158:             loc_oBusca = .NULL.
9159:         CATCH TO loc_oErro
9160:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de fornecedor")
9161:         ENDTRY
9162:     ENDPROC
9163: 
9164:     *==========================================================================
9165:     * HANDLERS DE KEYPRESS - FASE 6 (novos campos com lookup)
9166:     *==========================================================================
9167: 
9168:     *--------------------------------------------------------------------------
9169:     * TxtCorKeyPress - KeyPress no campo Cor (ENTER/F4 abre lookup SigCdCor)
9170:     *--------------------------------------------------------------------------
9171:     PROCEDURE TxtCorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9172:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9173:             THIS.ValidarCor()
9174:         ENDIF
9175:         IF par_nKeyCode = 115
9176:             THIS.AbrirLookupCor()
9177:         ENDIF
9178:     ENDPROC
9179: 
9180:     *--------------------------------------------------------------------------
9181:     * TxtTamKeyPress - KeyPress no campo Tamanho (ENTER/F4 abre lookup SigCdTam)
9182:     *--------------------------------------------------------------------------
9183:     PROCEDURE TxtTamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9184:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9185:             THIS.ValidarTam()
9186:         ENDIF
9187:         IF par_nKeyCode = 115
9188:             THIS.AbrirLookupTam()
9189:         ENDIF
9190:     ENDPROC
9191: 
9192:     *--------------------------------------------------------------------------
9193:     * TxtCodFinPKeyPress - KeyPress no campo Ficha (ENTER/F4 abre lookup SigCdFip)
9194:     *--------------------------------------------------------------------------
9195:     PROCEDURE TxtCodFinPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9196:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9197:             THIS.ValidarCodFinP()
9198:         ENDIF
9199:         IF par_nKeyCode = 115
9200:             THIS.AbrirLookupFinP()
9201:         ENDIF
9202:     ENDPROC
9203: 
9204:     *--------------------------------------------------------------------------
9205:     * TxtCodAcbKeyPress - KeyPress no campo Acabamento (ENTER/F4 abre lookup SigCdAca)
9206:     *--------------------------------------------------------------------------
9207:     PROCEDURE TxtCodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9208:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9209:             THIS.ValidarCodAcb()
9210:         ENDIF
9211:         IF par_nKeyCode = 115
9212:             THIS.AbrirLookupAcb()
9213:         ENDIF
9214:     ENDPROC
9215: 
9216:     *--------------------------------------------------------------------------
9217:     * TxtClassKeyPress - KeyPress no campo Classe (ENTER/F4 abre lookup SIGCDCLS)
9218:     *--------------------------------------------------------------------------
9219:     PROCEDURE TxtClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9220:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9221:             THIS.ValidarClass()
9222:         ENDIF
9223:         IF par_nKeyCode = 115
9224:             THIS.AbrirLookupClass()
9225:         ENDIF
9226:     ENDPROC
9227: 
9228:     *--------------------------------------------------------------------------
9229:     * TxtLocalKeyPress - KeyPress no campo Local (ENTER/F4 abre lookup SigPrLcl)
9230:     *--------------------------------------------------------------------------
9231:     PROCEDURE TxtLocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9232:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9233:             THIS.ValidarLocal()
9234:         ENDIF
9235:         IF par_nKeyCode = 115
9236:             THIS.AbrirLookupLocal()
9237:         ENDIF
9238:     ENDPROC
9239: 
9240:     *--------------------------------------------------------------------------
9241:     * TxtCuniKeyPress - KeyPress no campo Unidade (ENTER/F4 abre lookup SigCdUni)
9242:     *--------------------------------------------------------------------------
9243:     PROCEDURE TxtCuniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9244:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9245:             THIS.ValidarCuni()
9246:         ENDIF
9247:         IF par_nKeyCode = 115
9248:             THIS.AbrirLookupUni()
9249:         ENDIF
9250:     ENDPROC
9251: 
9252:     *--------------------------------------------------------------------------
9253:     * TxtCunipKeyPress - KeyPress no campo Uni.Pedido (ENTER/F4 abre lookup SigCdUni)
9254:     *--------------------------------------------------------------------------
9255:     PROCEDURE TxtCunipKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9256:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9257:             THIS.ValidarCunip()
9258:         ENDIF
9259:         IF par_nKeyCode = 115
9260:             THIS.AbrirLookupUniP()
9261:         ENDIF
9262:     ENDPROC
9263: 
9264:     *--------------------------------------------------------------------------
9265:     * TxtMctotalKeyPress - KeyPress no campo Moeda Custo (ENTER/F4 abre lookup SigCdMoe)
9266:     *--------------------------------------------------------------------------
9267:     PROCEDURE TxtMctotalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9268:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9269:             THIS.ValidarMoe("total")
9270:         ENDIF
9271:         IF par_nKeyCode = 115
9272:             THIS.AbrirLookupMctotal()
9273:         ENDIF
9274:     ENDPROC
9275: 
9276:     *--------------------------------------------------------------------------
9277:     * TxtMpvendaKeyPress - KeyPress no campo Moeda P.Venda (ENTER/F4 abre lookup SigCdMoe)
9278:     *--------------------------------------------------------------------------
9279:     PROCEDURE TxtMpvendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9280:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9281:             THIS.ValidarMoe("pvenda")
9282:         ENDIF
9283:         IF par_nKeyCode = 115
9284:             THIS.AbrirLookupMpvenda()
9285:         ENDIF
9286:     ENDPROC
9287: 
9288:     *--------------------------------------------------------------------------
9289:     * TxtMfvendaKeyPress - KeyPress no campo Moeda F.Venda (ENTER/F4 abre lookup SigCdMoe)
9290:     *--------------------------------------------------------------------------
9291:     PROCEDURE TxtMfvendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9292:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9293:             THIS.ValidarMoe("fvenda")
9294:         ENDIF
9295:         IF par_nKeyCode = 115
9296:             THIS.AbrirLookupMfvenda()
9297:         ENDIF
9298:     ENDPROC
9299: 
9300:     *==========================================================================
9301:     * HANDLERS - FASE 9 - pgComposicao
9302:     *==========================================================================
9303: 
9304:     *--------------------------------------------------------------------------
9305:     * GrdCompoAfterRowColChange - AfterRowColChange do grid de composicao
9306:     * Refresha campos de descricao e observacao da OF quando muda a linha
9307:     *--------------------------------------------------------------------------
9308:     PROCEDURE GrdCompoAfterRowColChange(par_nColIndex)
9309:         LOCAL loc_oPg
9310:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9311:         IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
9312:             loc_oPg.txt_4c_DescComp.Value = ALLTRIM(cursor_4c_Compo.dcompos)
9313:             loc_oPg.txt_4c_ObsOFs.Value   = ALLTRIM(cursor_4c_Compo.obscompos)
9314:         ELSE
9315:             loc_oPg.txt_4c_DescComp.Value = ""
9316:             loc_oPg.txt_4c_ObsOFs.Value   = ""
9317:         ENDIF
9318:     ENDPROC
9319: 
9320:     *--------------------------------------------------------------------------
9321:     * GrdSubCpAfterRowColChange - AfterRowColChange do grid de sub-composicao
9322:     *--------------------------------------------------------------------------
9323:     PROCEDURE GrdSubCpAfterRowColChange(par_nColIndex)
9324:         LOCAL loc_oPg
9325:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9326:         IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
9327:             loc_oPg.txt_4c_DescSubCp.Value = ALLTRIM(cursor_4c_SubCp.dcompos)
9328:             loc_oPg.txt_4c_MatSubs.Value   = ALLTRIM(cursor_4c_SubCp.matsubs)
9329:         ELSE
9330:             loc_oPg.txt_4c_DescSubCp.Value = ""
9331:             loc_oPg.txt_4c_MatSubs.Value   = ""
9332:         ENDIF
9333:     ENDPROC
9334: 
9335:     *--------------------------------------------------------------------------
9336:     * ChkLiberaCustoClick - habilitar/desabilitar campos de custo
9337:     *--------------------------------------------------------------------------
9338:     PROCEDURE ChkLiberaCustoClick()
9339:         LOCAL loc_oPg, loc_lLiberado
9340:         loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9341:         loc_lLiberado = (loc_oPg.chk_4c_LiberaCusto.Value = 1)
9342:         loc_oPg.txt_4c_Pcus.ReadOnly      = !loc_lLiberado
9343:         loc_oPg.txt_4c_Fcusto.ReadOnly    = !loc_lLiberado
9344:         loc_oPg.txt_4c_Moec.ReadOnly      = !loc_lLiberado
9345:         loc_oPg.txt_4c_Moepc.ReadOnly     = !loc_lLiberado
9346:         loc_oPg.txt_4c_CotaCalcP.ReadOnly = !loc_lLiberado
9347:         IF loc_lLiberado
9348:             loc_oPg.txt_4c_Pcus.BackColor   = RGB(255, 255, 255)
9349:             loc_oPg.txt_4c_Fcusto.BackColor  = RGB(255, 255, 255)
9350:             loc_oPg.txt_4c_CotaCalcP.BackColor = RGB(255, 255, 255)
9351:         ELSE
9352:             loc_oPg.txt_4c_Pcus.BackColor   = RGB(224, 235, 235)
9353:             loc_oPg.txt_4c_Fcusto.BackColor  = RGB(224, 235, 235)
9354:             loc_oPg.txt_4c_CotaCalcP.BackColor = RGB(224, 235, 235)
9355:         ENDIF
9356:     ENDPROC
9357: 
9358:     *--------------------------------------------------------------------------
9359:     * ChkLiberaVendaClick - habilitar/desabilitar campos de venda
9360:     *--------------------------------------------------------------------------
9361:     PROCEDURE ChkLiberaVendaClick()
9362:         LOCAL loc_oPg, loc_lLiberado
9363:         loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9364:         loc_lLiberado = (loc_oPg.chk_4c_LiberaVenda.Value = 1)
9365:         loc_oPg.txt_4c_FAtuals.ReadOnly = !loc_lLiberado
9366:         loc_oPg.txt_4c_Fideals.ReadOnly = !loc_lLiberado
9367:         IF loc_lLiberado
9368:             loc_oPg.txt_4c_FAtuals.BackColor = RGB(255, 255, 255)
9369:             loc_oPg.txt_4c_Fideals.BackColor = RGB(255, 255, 255)
9370:         ELSE
9371:             loc_oPg.txt_4c_FAtuals.BackColor = RGB(224, 235, 235)
9372:             loc_oPg.txt_4c_Fideals.BackColor = RGB(224, 235, 235)
9373:         ENDIF
9374:     ENDPROC
9375: 
9376:     *--------------------------------------------------------------------------
9377:     * TxtPcusValid - Valid no campo Preco de Custo -> recalcula precos
9378:     *--------------------------------------------------------------------------
9379:     PROCEDURE TxtPcusValid()
9380:         THIS.CalcPrecoComposicao()
9381:     ENDPROC
9382: 
9383:     *--------------------------------------------------------------------------
9384:     * TxtFcustoValid - Valid no campo Fator de Custo -> recalcula precos
9385:     *--------------------------------------------------------------------------
9386:     PROCEDURE TxtFcustoValid()
9387:         THIS.CalcPrecoComposicao()
9388:     ENDPROC
9389: 
9390:     *--------------------------------------------------------------------------
9391:     * TxtMargemValid - Valid na Margem/MKP -> recalcula precos
9392:     *--------------------------------------------------------------------------
9393:     PROCEDURE TxtMargemValid()
9394:         THIS.CalcPrecoComposicao()
9395:     ENDPROC
9396: 
9397:     *--------------------------------------------------------------------------
9398:     * TxtMarkupAValid - Valid no MarkupA -> recalcula precos
9399:     *--------------------------------------------------------------------------
9400:     PROCEDURE TxtMarkupAValid()
9401:         THIS.CalcPrecoComposicao()
9402:     ENDPROC
9403: 
9404:     *--------------------------------------------------------------------------
9405:     * TxtCotaCalcPValid - Valid na Cotacao -> recalcula precos
9406:     *--------------------------------------------------------------------------
9407:     PROCEDURE TxtCotaCalcPValid()
9408:         THIS.CalcPrecoComposicao()
9409:         LOCAL loc_oPg
9410:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9411:         loc_oPg.Refresh()
9412:     ENDPROC
9413: 
9414:     *--------------------------------------------------------------------------
9415:     * TxtMoecKeyPress - KeyPress no campo Moeda Custo (ENTER/F4 abre lookup SigCdMoe)
9416:     *--------------------------------------------------------------------------
9417:     PROCEDURE TxtMoecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9418:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9419:             THIS.ValidarMoeCompo("moec")
9420:         ENDIF
9421:         IF par_nKeyCode = 115
9422:             THIS.AbrirLookupMoeCompo("moec")
9423:         ENDIF
9424:     ENDPROC
9425: 
9426:     *--------------------------------------------------------------------------
9427:     * TxtMoepcKeyPress - KeyPress no campo Moeda P.Custo (ENTER/F4 abre lookup SigCdMoe)
9428:     *--------------------------------------------------------------------------
9429:     PROCEDURE TxtMoepcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9430:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9431:             THIS.ValidarMoeCompo("moepc")
9432:         ENDIF
9433:         IF par_nKeyCode = 115
9434:             THIS.AbrirLookupMoeCompo("moepc")
9435:         ENDIF
9436:     ENDPROC
9437: 
9438:     *--------------------------------------------------------------------------
9439:     * TxtMoedaKeyPress - KeyPress no campo Moeda Venda (ENTER/F4 abre lookup SigCdMoe)
9440:     *--------------------------------------------------------------------------
9441:     PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9442:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9443:             THIS.ValidarMoeCompo("moeda")
9444:         ENDIF
9445:         IF par_nKeyCode = 115
9446:             THIS.AbrirLookupMoeCompo("moeda")
9447:         ENDIF
9448:     ENDPROC
9449: 
9450:     *--------------------------------------------------------------------------
9451:     * TxtMoepvKeyPress - KeyPress no campo Moeda P.Venda (ENTER/F4 abre lookup SigCdMoe)
9452:     *--------------------------------------------------------------------------
9453:     PROCEDURE TxtMoepvKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9454:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9455:             THIS.ValidarMoeCompo("moepv")
9456:         ENDIF
9457:         IF par_nKeyCode = 115
9458:             THIS.AbrirLookupMoeCompo("moepv")
9459:         ENDIF
9460:     ENDPROC
9461: 
9462:     *--------------------------------------------------------------------------
9463:     * ValidarMoeCompo - Valida campo de moeda na pagina composicao
9464:     * par_cTipo: "moec"|"moepc"|"moeda"|"moepv"
9465:     *--------------------------------------------------------------------------
9466:     PROTECTED PROCEDURE ValidarMoeCompo(par_cTipo)
9467:         LOCAL loc_oPg, loc_oTxt, loc_cCodMoe, loc_cSQL, loc_lOk
9468:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9469:         DO CASE
9470:         CASE par_cTipo = "moec"
9471:             loc_oTxt = loc_oPg.txt_4c_Moec
9472:         CASE par_cTipo = "moepc"
9473:             loc_oTxt = loc_oPg.txt_4c_Moepc
9474:         CASE par_cTipo = "moeda"
9475:             loc_oTxt = loc_oPg.txt_4c_Moeda
9476:         CASE par_cTipo = "moepv"
9477:             loc_oTxt = loc_oPg.txt_4c_Moepv
9478:         OTHERWISE
9479:             RETURN
9480:         ENDCASE
9481:         loc_cCodMoe = ALLTRIM(loc_oTxt.Value)
9482:         IF EMPTY(loc_cCodMoe)
9483:             RETURN
9484:         ENDIF
9485:         loc_lOk = .F.
9486:         TRY
9487:             loc_cSQL = "SELECT cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCodMoe)
9488:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeCompo") > 0
9489:                 loc_lOk = .T.
9490:             ENDIF
9491:         CATCH TO loc_oErro
9492:             MsgErro(loc_oErro.Message, "Erro ao validar moeda")
9493:         ENDTRY
9494:         IF loc_lOk
9495:             IF EOF("cursor_4c_BuscaMoeCompo")
9496:                 MsgAviso("Moeda " + loc_cCodMoe + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9497:                 loc_oTxt.Value = ""
9498:             ENDIF
9499:             IF USED("cursor_4c_BuscaMoeCompo")
9500:                 USE IN cursor_4c_BuscaMoeCompo
9501:             ENDIF
9502:         ENDIF
9503:     ENDPROC
9504: 
9505:     *--------------------------------------------------------------------------
9506:     * AbrirLookupMoeCompo - Abre lookup de moeda na pagina composicao
9507:     *--------------------------------------------------------------------------
9508:     PROTECTED PROCEDURE AbrirLookupMoeCompo(par_cTipo)
9509:         LOCAL loc_oBusca, loc_oPg, loc_oTxt
9510:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9511:         DO CASE
9512:         CASE par_cTipo = "moec"
9513:             loc_oTxt = loc_oPg.txt_4c_Moec
9514:         CASE par_cTipo = "moepc"
9515:             loc_oTxt = loc_oPg.txt_4c_Moepc
9516:         CASE par_cTipo = "moeda"
9517:             loc_oTxt = loc_oPg.txt_4c_Moeda
9518:         CASE par_cTipo = "moepv"
9519:             loc_oTxt = loc_oPg.txt_4c_Moepv
9520:         OTHERWISE
9521:             RETURN
9522:         ENDCASE
9523:         TRY
9524:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
9525:             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMoeCompo"
9526:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
9527:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
9528:             loc_oBusca.cTabela    = "SigCdMoe"
9529:             loc_oBusca.cCampoChave = "cmoes"
9530:             loc_oBusca.cFiltroIni = ALLTRIM(loc_oTxt.Value)
9531:             loc_oBusca.Show()
9532:             IF loc_oBusca.this_lSelecionou
9533:                 loc_oTxt.Value = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
9534:             ENDIF
9535:             IF USED("cursor_4c_BuscaMoeCompo")
9536:                 USE IN cursor_4c_BuscaMoeCompo
9537:             ENDIF
9538:             loc_oBusca.Release()
9539:         CATCH TO loc_oErro
9540:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de moeda")
9541:         ENDTRY
9542:     ENDPROC
9543: 
9544:     *--------------------------------------------------------------------------
9545:     * CalcPrecoComposicao - Recalcula precos baseado nos valores de custo/margem
9546:     * Equivalente ao CalcPreco/CalcPreMoe do legado (stub - logica completa no BO)
9547:     *--------------------------------------------------------------------------
9548:     PROTECTED PROCEDURE CalcPrecoComposicao()
9549:         LOCAL loc_oPg, loc_nPcus, loc_nMargem, loc_nPven
9550:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9551:         loc_nPcus  = loc_oPg.txt_4c_Pcus.Value
9552:         loc_nMargem = loc_oPg.txt_4c_Margem.Value
9553:         *-- Calculo simplificado: Preco Venda = Custo * (1 + Margem/100)
9554:         *-- O calculo completo com fatores/moedas sera feito via BO
9555:         IF loc_nMargem > 0 AND loc_nPcus > 0
9556:             loc_nPven = loc_nPcus * (1 + loc_nMargem / 100)
9557:             loc_oPg.txt_4c_Pvens.Value = loc_nPven
9558:         ENDIF
9559:     ENDPROC
9560: 
9561:     *--------------------------------------------------------------------------
9562:     * CmdCalcValsClick - Botao Calcular Valores (cmdCalcVals)
9563:     * Aciona recalculo completo de precos (equivalente ao CalcPreco do legado)
9564:     *--------------------------------------------------------------------------
9565:     PROCEDURE CmdCalcValsClick()
9566:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9567:             RETURN
9568:         ENDIF
9569:         THIS.CalcPrecoComposicao()
9570:     ENDPROC
9571: 
9572:     *--------------------------------------------------------------------------
9573:     * CmdPesoMClick - Botao calcular peso medio (abre form sigcdpes)
9574:     *--------------------------------------------------------------------------
9575:     PROCEDURE CmdPesoMClick()
9576:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o de c" + CHR(225) + "lculo de peso n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Peso M" + CHR(233) + "dio")
9577:     ENDPROC
9578: 
9579:     *--------------------------------------------------------------------------
9580:     * CmdgCompoClick - Click no CommandGroup de composicao (5 botoes)
9581:     * .Value=1 Inserir | 2 Excluir | 3 Atualizar Custo | 4 Atualizar Preco | 5 Atualizar Pesos
9582:     *--------------------------------------------------------------------------
9583:     PROCEDURE CmdgCompoClick()
9584:         LOCAL loc_oPg, loc_nBtn, loc_oGrd
9585:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9586:         loc_nBtn = loc_oPg.obj_4c_CmdgCompo.Value
9587:         loc_oGrd = loc_oPg.grd_4c_Compo
9588: 
9589:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9590:             RETURN
9591:         ENDIF
9592: 
9593:         DO CASE
9594:         CASE loc_nBtn = 1
9595:             *-- Inserir item de composicao
9596:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9597:                 MsgAviso("Selecione o modo Incluir ou Alterar para inserir itens.", "Aten" + CHR(231) + CHR(227) + "o")
9598:                 RETURN
9599:             ENDIF
9600:             IF USED("cursor_4c_Compo")
9601:                 SELECT cursor_4c_Compo
9602:                 APPEND BLANK
9603:                 loc_oGrd.Refresh()
9604:             ENDIF
9605: 
9606:         CASE loc_nBtn = 2
9607:             *-- Excluir item de composicao
9608:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9609:                 RETURN
9610:             ENDIF
9611:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
9612:                 IF MsgConfirma("Excluir o item selecionado?", "Confirmar")
9613:                     SELECT cursor_4c_Compo
9614:                     DELETE
9615:                     IF !EOF("cursor_4c_Compo")
9616:                         SKIP
9617:                         SKIP -1
9618:                     ENDIF
9619:                     loc_oGrd.Refresh()
9620:                 ENDIF
9621:             ENDIF
9622: 
9623:         CASE loc_nBtn = 3
9624:             *-- Atualizar custo
9625:             THIS.CalcPrecoComposicao()
9626: 
9627:         CASE loc_nBtn = 4
9628:             *-- Atualizar preco
9629:             THIS.CalcPrecoComposicao()
9630: 
9631:         CASE loc_nBtn = 5
9632:             *-- Atualizar pesos
9633:             THIS.CmdPesoMClick()
9634: 
9635:         ENDCASE
9636:     ENDPROC
9637: 
9638:     *--------------------------------------------------------------------------
9639:     * CmdgSubCpClick - Click no CommandGroup de sub-composicao (2 botoes)
9640:     * .Value=1 Inserir | 2 Excluir
9641:     *--------------------------------------------------------------------------
9642:     PROCEDURE CmdgSubCpClick()
9643:         LOCAL loc_oPg, loc_nBtn, loc_oGrd
9644:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9645:         loc_nBtn = loc_oPg.obj_4c_CmdgSubCp.Value
9646:         loc_oGrd = loc_oPg.grd_4c_SubCp
9647: 
9648:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9649:             RETURN
9650:         ENDIF
9651: 
9652:         DO CASE
9653:         CASE loc_nBtn = 1
9654:             *-- Inserir item de sub-composicao
9655:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9656:                 MsgAviso("Selecione o modo Incluir ou Alterar para inserir itens.", "Aten" + CHR(231) + CHR(227) + "o")
9657:                 RETURN
9658:             ENDIF
9659:             IF USED("cursor_4c_SubCp")
9660:                 SELECT cursor_4c_SubCp
9661:                 APPEND BLANK
9662:                 loc_oGrd.Refresh()
9663:             ENDIF
9664: 
9665:         CASE loc_nBtn = 2
9666:             *-- Excluir item de sub-composicao
9667:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9668:                 RETURN
9669:             ENDIF
9670:             IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
9671:                 IF MsgConfirma("Excluir o sub-item selecionado?", "Confirmar")
9672:                     SELECT cursor_4c_SubCp
9673:                     DELETE
9674:                     IF !EOF("cursor_4c_SubCp")
9675:                         SKIP
9676:                         SKIP -1
9677:                     ENDIF
9678:                     loc_oGrd.Refresh()
9679:                 ENDIF
9680:             ENDIF
9681: 
9682:         ENDCASE
9683:     ENDPROC
9684: 
9685:     *--------------------------------------------------------------------------
9686:     * GrdCustoCompoAfterRowColChange - AfterRowColChange do grid Custo
9687:     * Atualiza txt_4c_Desc (descricao item) e txt_4c_DGruCompos (desc grupo)
9688:     *--------------------------------------------------------------------------
9689:     PROCEDURE GrdCustoCompoAfterRowColChange(par_nColIndex)
9690:         LOCAL loc_oPg, loc_cGrupo, loc_nRet, loc_oErro
9691:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9692: 
9693:         IF USED("cursor_4c_CustoCompo") AND !EOF("cursor_4c_CustoCompo")
9694:             loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_CustoCompo.dcompos)
9695:             loc_cGrupo = ALLTRIM(cursor_4c_CustoCompo.CGrus)
9696:             IF !EMPTY(loc_cGrupo)
9697:                 TRY
9698:                     loc_nRet = SQLEXEC(gnConnHandle, ;
9699:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cGrupo), ;
9700:                         "cursor_4c_GruCustoDesc")
9701:                     IF loc_nRet > 0 AND USED("cursor_4c_GruCustoDesc") AND !EOF("cursor_4c_GruCustoDesc")
9702:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_GruCustoDesc.DGrus)
9703:                     ELSE
9704:                         loc_oPg.txt_4c_DGruCompos.Value = ""
9705:                     ENDIF
9706:                     IF USED("cursor_4c_GruCustoDesc")
9707:                         USE IN cursor_4c_GruCustoDesc
9708:                     ENDIF
9709:                 CATCH TO loc_oErro
9710:                     MsgErro(loc_oErro.Message, "Erro ao buscar grupo da composi" + CHR(231) + CHR(227) + "o")
9711:                 ENDTRY
9712:             ELSE
9713:                 loc_oPg.txt_4c_DGruCompos.Value = ""
9714:             ENDIF
9715:         ELSE
9716:             loc_oPg.txt_4c_Desc.Value       = ""
9717:             loc_oPg.txt_4c_DGruCompos.Value = ""
9718:         ENDIF
9719:     ENDPROC
9720: 
9721:     *--------------------------------------------------------------------------
9722:     * CmdgCustoClick - Click no CommandGroup de composicao Custo (2 botoes)
9723:     * .Value=1 Inserir | .Value=2 Excluir
9724:     *--------------------------------------------------------------------------
9725:     PROCEDURE CmdgCustoClick()
9726:         LOCAL loc_oPg, loc_nBtn, loc_oGrd
9727:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9728:         loc_nBtn = loc_oPg.obj_4c_CmdgCusto.Value
9729:         loc_oGrd = loc_oPg.grd_4c_CustoCompo
9730: 
9731:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9732:             RETURN
9733:         ENDIF
9734: 
9735:         DO CASE
9736:         CASE loc_nBtn = 1
9737:             *-- Inserir item de composicao custo
9738:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9739:                 MsgAviso("Selecione o modo Incluir ou Alterar para inserir itens.", "Aten" + CHR(231) + CHR(227) + "o")
9740:                 RETURN
9741:             ENDIF
9742:             IF USED("cursor_4c_CustoCompo")
9743:                 SELECT cursor_4c_CustoCompo
9744:                 APPEND BLANK
9745:                 loc_oGrd.Refresh()
9746:             ENDIF
9747: 
9748:         CASE loc_nBtn = 2
9749:             *-- Excluir item de composicao custo
9750:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9751:                 RETURN
9752:             ENDIF
9753:             IF USED("cursor_4c_CustoCompo") AND !EOF("cursor_4c_CustoCompo")
9754:                 IF MsgConfirma("Excluir o item selecionado?", "Confirmar")
9755:                     SELECT cursor_4c_CustoCompo
9756:                     DELETE
9757:                     IF !EOF("cursor_4c_CustoCompo")
9758:                         SKIP
9759:                         SKIP -1
9760:                     ENDIF
9761:                     loc_oGrd.Refresh()
9762:                 ENDIF
9763:             ENDIF
9764: 
9765:         ENDCASE
9766:     ENDPROC
9767: 
9768:     *--------------------------------------------------------------------------
9769:     * CboTiposCustoInteractiveChange - InteractiveChange do cmbTipos na aba Custo
9770:     * Filtra/recarrega grid de composicao pelo tipo selecionado
9771:     *--------------------------------------------------------------------------
9772:     PROCEDURE CboTiposCustoInteractiveChange()
9773:         LOCAL loc_oPg
9774:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9775: 
9776:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9777:             RETURN
9778:         ENDIF
9779: 
9780:         IF USED("cursor_4c_CustoCompo")
9781:             GO TOP IN cursor_4c_CustoCompo
9782:         ENDIF
9783:         loc_oPg.grd_4c_CustoCompo.Refresh()
9784:     ENDPROC
9785: 
9786:     *==========================================================================
9787:     * VALIDACOES - FASE 6
9788:     *==========================================================================
9789: 
9790:     *--------------------------------------------------------------------------
9791:     * ValidarCor - Valida e carrega tooltip da cor (SigCdCor)
9792:     *--------------------------------------------------------------------------
9793:     PROTECTED PROCEDURE ValidarCor()
9794:         LOCAL loc_cCodCor, loc_oPg
9795:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9796:         loc_cCodCor = ALLTRIM(loc_oPg.txt_4c_Cor.Value)
9797:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9798:             RETURN
9799:         ENDIF
9800:         THIS.CarregarDescCor(loc_cCodCor)
9801:     ENDPROC
9802: 
9803:     *--------------------------------------------------------------------------
9804:     * ValidarTam - Valida e carrega tooltip do tamanho (SigCdTam)
9805:     *--------------------------------------------------------------------------
9806:     PROTECTED PROCEDURE ValidarTam()
9807:         LOCAL loc_cCodTam, loc_oPg
9808:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9809:         loc_cCodTam = ALLTRIM(loc_oPg.txt_4c_Tam.Value)
9810:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9811:             RETURN
9812:         ENDIF
9813:         THIS.CarregarDescTam(loc_cCodTam)
9814:     ENDPROC
9815: 
9816:     *--------------------------------------------------------------------------
9817:     * ValidarCodFinP - Valida campo ficha e carrega descricao (SigCdFip)
9818:     *--------------------------------------------------------------------------
9819:     PROTECTED PROCEDURE ValidarCodFinP()
9820:         LOCAL loc_cCodFinP, loc_oPg
9821:         loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9822:         loc_cCodFinP = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
9823:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9824:             RETURN
9825:         ENDIF
9826:         THIS.CarregarDescFinP(loc_cCodFinP)
9827:         IF !EMPTY(loc_cCodFinP) AND EMPTY(loc_oPg.txt_4c_DesFinP.Value)
9828:             MsgAviso("Ficha " + loc_cCodFinP + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9829:         ENDIF
9830:     ENDPROC
9831: 
9832:     *--------------------------------------------------------------------------
9833:     * ValidarCodAcb - Valida campo acabamento e carrega descricao (SigCdAca)
9834:     *--------------------------------------------------------------------------
9835:     PROTECTED PROCEDURE ValidarCodAcb()
9836:         LOCAL loc_cCodAcb, loc_oPg
9837:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9838:         loc_cCodAcb = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
9839:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9840:             RETURN
9841:         ENDIF
9842:         THIS.CarregarDescAcb(loc_cCodAcb)
9843:         IF !EMPTY(loc_cCodAcb) AND EMPTY(loc_oPg.txt_4c_DacbDisplay.Value)
9844:             MsgAviso("Acabamento " + loc_cCodAcb + " n" + CHR(227) + "o encontrado.", "Inv" + CHR(225) + "lido")
9845:         ENDIF
9846:     ENDPROC
9847: 
9848:     *--------------------------------------------------------------------------
9849:     * ValidarClass - Valida campo classificacao e carrega descricao (SIGCDCLS)
9850:     *--------------------------------------------------------------------------
9851:     PROTECTED PROCEDURE ValidarClass()
9852:         LOCAL loc_cCclass, loc_oPg
9853:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9854:         loc_cCclass = ALLTRIM(loc_oPg.txt_4c_Class.Value)
9855:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9856:             RETURN
9857:         ENDIF
9858:         THIS.CarregarDescClass(loc_cCclass)
9859:         IF !EMPTY(loc_cCclass) AND EMPTY(loc_oPg.txt_4c_DClassDisplay.Value)
9860:             MsgAviso("Classifica" + CHR(231) + CHR(227) + "o " + loc_cCclass + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9861:         ENDIF
9862:     ENDPROC
9863: 
9864:     *--------------------------------------------------------------------------
9865:     * ValidarLocal - Valida campo local (SigPrLcl)
9866:     *--------------------------------------------------------------------------
9867:     PROTECTED PROCEDURE ValidarLocal()
9868:         LOCAL loc_cLocals, loc_oPg
9869:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9870:         loc_cLocals = ALLTRIM(loc_oPg.txt_4c_Local.Value)
9871:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9872:             RETURN
9873:         ENDIF
9874:         THIS.CarregarDescLocal(loc_cLocals)
9875:     ENDPROC
9876: 
9877:     *--------------------------------------------------------------------------
9878:     * ValidarCuni - Valida campo unidade e carrega descricao (SigCdUni)
9879:     *--------------------------------------------------------------------------
9880:     PROTECTED PROCEDURE ValidarCuni()
9881:         LOCAL loc_cCunis, loc_oPg
9882:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9883:         loc_cCunis  = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
9884:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9885:             RETURN
9886:         ENDIF
9887:         THIS.CarregarDescUni(loc_cCunis, "uni")
9888:         IF !EMPTY(loc_cCunis) AND EMPTY(loc_oPg.txt_4c_DuniDisplay.Value)
9889:             MsgAviso("Unidade " + loc_cCunis + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9890:         ENDIF
9891:     ENDPROC
9892: 
9893:     *--------------------------------------------------------------------------
9894:     * ValidarCunip - Valida campo unidade de pedido (SigCdUni)
9895:     *--------------------------------------------------------------------------
9896:     PROTECTED PROCEDURE ValidarCunip()
9897:         LOCAL loc_cCunips, loc_oPg
9898:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9899:         loc_cCunips = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
9900:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9901:             RETURN
9902:         ENDIF
9903:         THIS.CarregarDescUni(loc_cCunips, "unip")
9904:         IF !EMPTY(loc_cCunips) AND EMPTY(loc_oPg.txt_4c_DunipDisplay.Value)
9905:             MsgAviso("Unidade " + loc_cCunips + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9906:         ENDIF
9907:     ENDPROC
9908: 
9909:     *--------------------------------------------------------------------------
9910:     * ValidarMoe - Valida campo moeda (SigCdMoe)
9911:     * par_cTipo: "total" | "pvenda" | "fvenda"
9912:     *--------------------------------------------------------------------------
9913:     PROTECTED PROCEDURE ValidarMoe(par_cTipo)
9914:         LOCAL loc_cCmoes, loc_oPg
9915:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9916:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9917:             RETURN
9918:         ENDIF
9919:         DO CASE
9920:         CASE par_cTipo = "total"
9921:             loc_cCmoes = ALLTRIM(loc_oPg.txt_4c_Mctotal.Value)
9922:         CASE par_cTipo = "pvenda"
9923:             loc_cCmoes = ALLTRIM(loc_oPg.txt_4c_Mpvenda.Value)
9924:         OTHERWISE
9925:             loc_cCmoes = ALLTRIM(loc_oPg.txt_4c_Mfvenda.Value)
9926:         ENDCASE
9927:         THIS.CarregarDescMoe(loc_cCmoes, par_cTipo)
9928:     ENDPROC
9929: 
9930:     *==========================================================================
9931:     * LOOKUPS - FASE 6
9932:     *==========================================================================
9933: 
9934:     *--------------------------------------------------------------------------
9935:     * AbrirLookupCor - Abre busca de cor (SigCdCor)
9936:     *--------------------------------------------------------------------------
9937:     PROCEDURE AbrirLookupCor()
9938:         LOCAL loc_oBusca, loc_oPg
9939:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9940:         TRY
9941:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9942:                 "SigCdCor", "cursor_4c_BuscaCor", "cods", ;
9943:                 ALLTRIM(loc_oPg.txt_4c_Cor.Value), "Busca de Cor")
9944:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9945:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9946:             loc_oBusca.Show()
9947:             IF loc_oBusca.this_lSelecionou
9948:                 IF USED("cursor_4c_BuscaCor")
9949:                     SELECT cursor_4c_BuscaCor
9950:                     loc_oPg.txt_4c_Cor.Value = ALLTRIM(cods)
9951:                     USE IN cursor_4c_BuscaCor
9952:                 ENDIF
9953:             ENDIF
9954:             loc_oBusca.Release()
9955:             loc_oBusca = .NULL.
9956:         CATCH TO loc_oErro
9957:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de cor")
9958:         ENDTRY
9959:     ENDPROC
9960: 
9961:     *--------------------------------------------------------------------------
9962:     * AbrirLookupTam - Abre busca de tamanho (SigCdTam)
9963:     *--------------------------------------------------------------------------
9964:     PROCEDURE AbrirLookupTam()
9965:         LOCAL loc_oBusca, loc_oPg
9966:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9967:         TRY
9968:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9969:                 "SigCdTam", "cursor_4c_BuscaTam", "cods", ;
9970:                 ALLTRIM(loc_oPg.txt_4c_Tam.Value), "Busca de Tamanho")
9971:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9972:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9973:             loc_oBusca.Show()
9974:             IF loc_oBusca.this_lSelecionou
9975:                 IF USED("cursor_4c_BuscaTam")
9976:                     SELECT cursor_4c_BuscaTam
9977:                     loc_oPg.txt_4c_Tam.Value = ALLTRIM(cods)
9978:                     USE IN cursor_4c_BuscaTam
9979:                 ENDIF
9980:             ENDIF
9981:             loc_oBusca.Release()
9982:             loc_oBusca = .NULL.
9983:         CATCH TO loc_oErro
9984:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de tamanho")
9985:         ENDTRY
9986:     ENDPROC
9987: 
9988:     *--------------------------------------------------------------------------
9989:     * AbrirLookupFinP - Abre busca de ficha de produto (SigCdFip)
9990:     *--------------------------------------------------------------------------
9991:     PROCEDURE AbrirLookupFinP()
9992:         LOCAL loc_oBusca, loc_oPg
9993:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9994:         TRY
9995:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9996:                 "SigCdFip", "cursor_4c_BuscaFinP", "cods", ;
9997:                 ALLTRIM(loc_oPg.txt_4c_CodFinP.Value), "Busca de Ficha")
9998:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9999:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10000:             loc_oBusca.Show()
10001:             IF loc_oBusca.this_lSelecionou
10002:                 IF USED("cursor_4c_BuscaFinP")
10003:                     SELECT cursor_4c_BuscaFinP
10004:                     loc_oPg.txt_4c_CodFinP.Value  = ALLTRIM(cods)
10005:                     loc_oPg.txt_4c_DesFinP.Value  = ALLTRIM(descs)
10006:                     USE IN cursor_4c_BuscaFinP
10007:                 ENDIF
10008:             ENDIF
10009:             loc_oBusca.Release()
10010:             loc_oBusca = .NULL.
10011:         CATCH TO loc_oErro
10012:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de ficha")
10013:         ENDTRY
10014:     ENDPROC
10015: 
10016:     *--------------------------------------------------------------------------
10017:     * AbrirLookupAcb - Abre busca de acabamento (SigCdAca)
10018:     *--------------------------------------------------------------------------
10019:     PROCEDURE AbrirLookupAcb()
10020:         LOCAL loc_oBusca, loc_oPg
10021:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10022:         TRY
10023:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10024:                 "SigCdAca", "cursor_4c_BuscaAcb", "cods", ;
10025:                 ALLTRIM(loc_oPg.txt_4c_CodAcb.Value), "Busca de Acabamento")
10026:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
10027:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
10028:             loc_oBusca.Show()
10029:             IF loc_oBusca.this_lSelecionou
10030:                 IF USED("cursor_4c_BuscaAcb")
10031:                     SELECT cursor_4c_BuscaAcb
10032:                     loc_oPg.txt_4c_CodAcb.Value       = ALLTRIM(cods)
10033:                     loc_oPg.txt_4c_DacbDisplay.Value  = ALLTRIM(descrs)
10034:                     USE IN cursor_4c_BuscaAcb
10035:                 ENDIF
10036:             ENDIF
10037:             loc_oBusca.Release()
10038:             loc_oBusca = .NULL.
10039:         CATCH TO loc_oErro
10040:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de acabamento")
10041:         ENDTRY
10042:     ENDPROC
10043: 
10044:     *--------------------------------------------------------------------------
10045:     * AbrirLookupClass - Abre busca de classificacao (SIGCDCLS)
10046:     *--------------------------------------------------------------------------
10047:     PROCEDURE AbrirLookupClass()
10048:         LOCAL loc_oBusca, loc_oPg
10049:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10050:         TRY
10051:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10052:                 "SIGCDCLS", "cursor_4c_BuscaClass", "cods", ;
10053:                 ALLTRIM(loc_oPg.txt_4c_Class.Value), ;
10054:                 "Busca de Classifica" + CHR(231) + CHR(227) + "o")
10055:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
10056:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10057:             loc_oBusca.Show()
10058:             IF loc_oBusca.this_lSelecionou
10059:                 IF USED("cursor_4c_BuscaClass")
10060:                     SELECT cursor_4c_BuscaClass
10061:                     loc_oPg.txt_4c_Class.Value         = ALLTRIM(cods)
10062:                     loc_oPg.txt_4c_DClassDisplay.Value = ALLTRIM(descs)
10063:                     USE IN cursor_4c_BuscaClass
10064:                 ENDIF
10065:             ENDIF
10066:             loc_oBusca.Release()
10067:             loc_oBusca = .NULL.
10068:         CATCH TO loc_oErro
10069:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o")
10070:         ENDTRY
10071:     ENDPROC
10072: 
10073:     *--------------------------------------------------------------------------
10074:     * AbrirLookupLocal - Abre busca de local (SigPrLcl)
10075:     *--------------------------------------------------------------------------
10076:     PROCEDURE AbrirLookupLocal()
10077:         LOCAL loc_oBusca, loc_oPg
10078:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10079:         TRY
10080:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10081:                 "SigPrLcl", "cursor_4c_BuscaLocal", "codigos", ;
10082:                 ALLTRIM(loc_oPg.txt_4c_Local.Value), "Busca de Local")
10083:             loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
10084:             loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10085:             loc_oBusca.Show()
10086:             IF loc_oBusca.this_lSelecionou
10087:                 IF USED("cursor_4c_BuscaLocal")
10088:                     SELECT cursor_4c_BuscaLocal
10089:                     loc_oPg.txt_4c_Local.Value = ALLTRIM(codigos)
10090:                     USE IN cursor_4c_BuscaLocal
10091:                 ENDIF
10092:             ENDIF
10093:             loc_oBusca.Release()
10094:             loc_oBusca = .NULL.
10095:         CATCH TO loc_oErro
10096:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de local")
10097:         ENDTRY
10098:     ENDPROC
10099: 
10100:     *--------------------------------------------------------------------------
10101:     * AbrirLookupUni - Abre busca de unidade (SigCdUni) para campo Cuni
10102:     *--------------------------------------------------------------------------
10103:     PROCEDURE AbrirLookupUni()
10104:         LOCAL loc_oBusca, loc_oPg
10105:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10106:         TRY
10107:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10108:                 "SigCdUni", "cursor_4c_BuscaUni", "cunis", ;
10109:                 ALLTRIM(loc_oPg.txt_4c_Cuni.Value), "Busca de Unidade")
10110:             loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
10111:             loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
10112:             loc_oBusca.Show()
10113:             IF loc_oBusca.this_lSelecionou
10114:                 IF USED("cursor_4c_BuscaUni")
10115:                     SELECT cursor_4c_BuscaUni
10116:                     loc_oPg.txt_4c_Cuni.Value          = ALLTRIM(cunis)
10117:                     loc_oPg.txt_4c_DuniDisplay.Value   = ALLTRIM(dunis)
10118:                     USE IN cursor_4c_BuscaUni
10119:                 ENDIF
10120:             ENDIF
10121:             loc_oBusca.Release()
10122:             loc_oBusca = .NULL.
10123:         CATCH TO loc_oErro
10124:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de unidade")
10125:         ENDTRY
10126:     ENDPROC
10127: 
10128:     *--------------------------------------------------------------------------
10129:     * AbrirLookupUniP - Abre busca de unidade de pedido (SigCdUni) para campo Cunip
10130:     *--------------------------------------------------------------------------
10131:     PROCEDURE AbrirLookupUniP()
10132:         LOCAL loc_oBusca, loc_oPg
10133:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10134:         TRY
10135:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10136:                 "SigCdUni", "cursor_4c_BuscaUniP", "cunis", ;
10137:                 ALLTRIM(loc_oPg.txt_4c_Cunip.Value), "Busca de Uni.Pedido")
10138:             loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
10139:             loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
10140:             loc_oBusca.Show()
10141:             IF loc_oBusca.this_lSelecionou
10142:                 IF USED("cursor_4c_BuscaUniP")
10143:                     SELECT cursor_4c_BuscaUniP
10144:                     loc_oPg.txt_4c_Cunip.Value          = ALLTRIM(cunis)
10145:                     loc_oPg.txt_4c_DunipDisplay.Value   = ALLTRIM(dunis)
10146:                     USE IN cursor_4c_BuscaUniP
10147:                 ENDIF
10148:             ENDIF
10149:             loc_oBusca.Release()
10150:             loc_oBusca = .NULL.
10151:         CATCH TO loc_oErro
10152:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de unidade de pedido")
10153:         ENDTRY
10154:     ENDPROC
10155: 
10156:     *--------------------------------------------------------------------------
10157:     * AbrirLookupMctotal - Abre busca de moeda custo (SigCdMoe)
10158:     *--------------------------------------------------------------------------
10159:     PROCEDURE AbrirLookupMctotal()
10160:         LOCAL loc_oBusca, loc_oPg
10161:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10162:         TRY
10163:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10164:                 "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
10165:                 ALLTRIM(loc_oPg.txt_4c_Mctotal.Value), "Busca de Moeda (Custo)")
10166:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
10167:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10168:             loc_oBusca.Show()
10169:             IF loc_oBusca.this_lSelecionou
10170:                 IF USED("cursor_4c_BuscaMoe")
10171:                     SELECT cursor_4c_BuscaMoe
10172:                     loc_oPg.txt_4c_Mctotal.Value = ALLTRIM(cmoes)
10173:                     THIS.CarregarDescMoe(ALLTRIM(cmoes), "total")
10174:                     USE IN cursor_4c_BuscaMoe
10175:                 ENDIF
10176:             ENDIF
10177:             loc_oBusca.Release()
10178:             loc_oBusca = .NULL.
10179:         CATCH TO loc_oErro
10180:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
10181:         ENDTRY
10182:     ENDPROC
10183: 
10184:     *--------------------------------------------------------------------------
10185:     * AbrirLookupMpvenda - Abre busca de moeda P.Venda (SigCdMoe)
10186:     *--------------------------------------------------------------------------
10187:     PROCEDURE AbrirLookupMpvenda()
10188:         LOCAL loc_oBusca, loc_oPg
10189:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10190:         TRY
10191:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10192:                 "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
10193:                 ALLTRIM(loc_oPg.txt_4c_Mpvenda.Value), "Busca de Moeda (P.Venda)")
10194:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
10195:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10196:             loc_oBusca.Show()
10197:             IF loc_oBusca.this_lSelecionou
10198:                 IF USED("cursor_4c_BuscaMoe")
10199:                     SELECT cursor_4c_BuscaMoe
10200:                     loc_oPg.txt_4c_Mpvenda.Value = ALLTRIM(cmoes)
10201:                     THIS.CarregarDescMoe(ALLTRIM(cmoes), "pvenda")
10202:                     USE IN cursor_4c_BuscaMoe
10203:                 ENDIF
10204:             ENDIF
10205:             loc_oBusca.Release()
10206:             loc_oBusca = .NULL.
10207:         CATCH TO loc_oErro
10208:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
10209:         ENDTRY
10210:     ENDPROC
10211: 
10212:     *--------------------------------------------------------------------------
10213:     * AbrirLookupMfvenda - Abre busca de moeda F.Venda (SigCdMoe)
10214:     *--------------------------------------------------------------------------
10215:     PROCEDURE AbrirLookupMfvenda()
10216:         LOCAL loc_oBusca, loc_oPg
10217:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10218:         TRY
10219:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10220:                 "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
10221:                 ALLTRIM(loc_oPg.txt_4c_Mfvenda.Value), "Busca de Moeda (F.Venda)")
10222:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
10223:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10224:             loc_oBusca.Show()
10225:             IF loc_oBusca.this_lSelecionou
10226:                 IF USED("cursor_4c_BuscaMoe")
10227:                     SELECT cursor_4c_BuscaMoe
10228:                     loc_oPg.txt_4c_Mfvenda.Value = ALLTRIM(cmoes)
10229:                     THIS.CarregarDescMoe(ALLTRIM(cmoes), "fvenda")
10230:                     USE IN cursor_4c_BuscaMoe
10231:                 ENDIF
10232:             ENDIF
10233:             loc_oBusca.Release()
10234:             loc_oBusca = .NULL.
10235:         CATCH TO loc_oErro
10236:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
10237:         ENDTRY
10238:     ENDPROC
10239: 
10240:     *==========================================================================
10241:     * HANDLERS - FASE 13: pgDadosFiscais
10242:     *==========================================================================
10243: 
10244:     *--------------------------------------------------------------------------
10245:     * TxtGruccusKeyPress - KeyPress em txt_4c_Gruccus (F4/F5 abre lookup SigCdGcr)
10246:     *--------------------------------------------------------------------------
10247:     PROCEDURE TxtGruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10248:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10249:             THIS.ValidarGruccus()
10250:         ENDIF
10251:         IF par_nKeyCode = 115
10252:             THIS.AbrirLookupGruccus()
10253:         ENDIF
10254:     ENDPROC
10255: 
10256:     *--------------------------------------------------------------------------
10257:     * ValidarGruccus - LostFocus/Enter em txt_4c_Gruccus
10258:     * Lookup: SigCdGcr (Codigos / Descrs)
10259:     *--------------------------------------------------------------------------
10260:     PROCEDURE ValidarGruccus()
10261:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10262:         loc_lResultado = .T.
10263:         TRY
10264:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10265:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Gruccus.Value, ""))
10266:             IF EMPTY(loc_cCodigo)
10267:                 loc_oPage.txt_4c_Dgruccus.Value    = ""
10268:                 loc_oPage.txt_4c_Contaccus.Value   = ""
10269:                 loc_oPage.txt_4c_Dcontaccus.Value  = ""
10270:                 loc_lResultado = loc_lResultado
10271:             ENDIF
10272:             loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10273:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGruccus") <= 0 OR EOF("cursor_4c_ValGruccus")
10274:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10275:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValGruccus"
10276:                 loc_oLookup.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10277:                 loc_oLookup.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10278:                 loc_oLookup.cTabela     = "SigCdGcr"
10279:                 loc_oLookup.cCampoChave = "Codigos"
10280:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10281:                 loc_oLookup.Show()
10282:                 IF loc_oLookup.this_lSelecionou
10283:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10284:                 ELSE
10285:                     loc_cCodigo = ""
10286:                 ENDIF
10287:             ELSE
10288:                 SELECT cursor_4c_ValGruccus
10289:                 loc_oPage.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10290:             ENDIF
10291:             IF USED("cursor_4c_ValGruccus")
10292:                 USE IN cursor_4c_ValGruccus
10293:             ENDIF
10294:             IF !EMPTY(loc_cCodigo)
10295:                 loc_oPage.txt_4c_Gruccus.Value = loc_cCodigo
10296:                 loc_oPage.txt_4c_Gruccus.Refresh()
10297:                 *-- Recarregar descricao se veio do lookup
10298:                 loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10299:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGruccus2") > 0 AND !EOF("cursor_4c_ValGruccus2")
10300:                     SELECT cursor_4c_ValGruccus2
10301:                     loc_oPage.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10302:                 ENDIF
10303:                 IF USED("cursor_4c_ValGruccus2")
10304:                     USE IN cursor_4c_ValGruccus2
10305:                 ENDIF
10306:             ELSE
10307:                 loc_oPage.txt_4c_Gruccus.Value    = ""
10308:                 loc_oPage.txt_4c_Dgruccus.Value   = ""
10309:                 loc_oPage.txt_4c_Contaccus.Value  = ""
10310:                 loc_oPage.txt_4c_Dcontaccus.Value = ""
10311:             ENDIF
10312:             loc_oPage.txt_4c_Dgruccus.Refresh()
10313:             loc_oPage.grd_4c_Dados.Refresh()
10314:             loc_oPage.Refresh()
10315:         CATCH TO loc_oErro
10316:             MsgErro(loc_oErro.Message, "Erro")
10317:         ENDTRY
10318:         RETURN loc_lResultado
10319:     ENDPROC
10320: 
10321:     *--------------------------------------------------------------------------
10322:     * AbrirLookupGruccus - Abre busca de grupo C.C. (SigCdGcr)
10323:     *--------------------------------------------------------------------------
10324:     PROCEDURE AbrirLookupGruccus()
10325:         LOCAL loc_oBusca, loc_oPg
10326:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10327:         TRY
10328:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10329:                 "SigCdGcr", "cursor_4c_BuscaGruccus", "Codigos", ;
10330:                 ALLTRIM(loc_oPg.txt_4c_Gruccus.Value), "Busca de Grupo C.C.")
10331:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10332:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10333:             loc_oBusca.Show()
10334:             IF loc_oBusca.this_lSelecionou
10335:                 IF USED("cursor_4c_BuscaGruccus")
10336:                     SELECT cursor_4c_BuscaGruccus
10337:                     loc_oPg.txt_4c_Gruccus.Value  = ALLTRIM(Codigos)
10338:                     loc_oPg.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10339:                     USE IN cursor_4c_BuscaGruccus
10340:                 ENDIF
10341:             ENDIF
10342:             loc_oBusca.Release()
10343:             loc_oBusca = .NULL.
10344:         CATCH TO loc_oErro
10345:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo C.C.")
10346:         ENDTRY
10347:     ENDPROC
10348: 
10349:     *--------------------------------------------------------------------------
10350:     * TxtDgruccusKeyPress - KeyPress em txt_4c_Dgruccus (F4 abre lookup por descricao)
10351:     *--------------------------------------------------------------------------
10352:     PROCEDURE TxtDgruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10353:         IF par_nKeyCode = 115
10354:             THIS.AbrirLookupDgruccus()
10355:         ENDIF
10356:     ENDPROC
10357: 
10358:     *--------------------------------------------------------------------------
10359:     * AbrirLookupDgruccus - Busca reversa por descricao em SigCdGcr
10360:     *--------------------------------------------------------------------------
10361:     PROCEDURE AbrirLookupDgruccus()
10362:         LOCAL loc_oBusca, loc_oPg
10363:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10364:         TRY
10365:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10366:                 "SigCdGcr", "cursor_4c_BuscaGruccus", "Descrs", ;
10367:                 ALLTRIM(loc_oPg.txt_4c_Dgruccus.Value), "Busca de Grupo C.C.")
10368:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10369:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10370:             loc_oBusca.Show()
10371:             IF loc_oBusca.this_lSelecionou
10372:                 IF USED("cursor_4c_BuscaGruccus")
10373:                     SELECT cursor_4c_BuscaGruccus
10374:                     loc_oPg.txt_4c_Gruccus.Value  = ALLTRIM(Codigos)
10375:                     loc_oPg.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10376:                     USE IN cursor_4c_BuscaGruccus
10377:                 ENDIF
10378:             ENDIF
10379:             loc_oBusca.Release()
10380:             loc_oBusca = .NULL.
10381:         CATCH TO loc_oErro
10382:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo C.C.")
10383:         ENDTRY
10384:     ENDPROC
10385: 
10386:     *--------------------------------------------------------------------------
10387:     * TxtContaccusKeyPress - KeyPress em txt_4c_Contaccus (F4 abre lookup SigCdCli)
10388:     *--------------------------------------------------------------------------
10389:     PROCEDURE TxtContaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10390:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10391:             THIS.ValidarContaccus()
10392:         ENDIF
10393:         IF par_nKeyCode = 115
10394:             THIS.AbrirLookupContaccus()
10395:         ENDIF
10396:     ENDPROC
10397: 
10398:     *--------------------------------------------------------------------------
10399:     * ValidarContaccus - LostFocus/Enter em txt_4c_Contaccus
10400:     * Lookup: SigCdCli filtrado por Grupos = gruccus (IClis / Rclis)
10401:     *--------------------------------------------------------------------------
10402:     PROCEDURE ValidarContaccus()
10403:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_cGrupo, loc_lcSQL
10404:         loc_lResultado = .T.
10405:         TRY
10406:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10407:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Contaccus.Value, ""))
10408:             loc_cGrupo  = ALLTRIM(NVL(loc_oPage.txt_4c_Gruccus.Value, ""))
10409:             IF EMPTY(loc_cCodigo)
10410:                 loc_oPage.txt_4c_Dcontaccus.Value = ""
10411:                 loc_lResultado = loc_lResultado
10412:             ENDIF
10413:             loc_lcSQL = "SELECT IClis, Rclis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cCodigo)
10414:             IF !EMPTY(loc_cGrupo)
10415:                 loc_lcSQL = loc_lcSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
10416:             ENDIF
10417:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValContaccus") <= 0 OR EOF("cursor_4c_ValContaccus")
10418:                 IF USED("cursor_4c_ValContaccus")
10419:                     USE IN cursor_4c_ValContaccus
10420:                 ENDIF
10421:                 THIS.AbrirLookupContaccus()
10422:                 loc_lResultado = loc_lResultado
10423:             ENDIF
10424:             SELECT cursor_4c_ValContaccus
10425:             loc_oPage.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
10426:             loc_oPage.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
10427:             loc_oPage.txt_4c_Contaccus.Refresh()
10428:             loc_oPage.txt_4c_Dcontaccus.Refresh()
10429:             IF USED("cursor_4c_ValContaccus")
10430:                 USE IN cursor_4c_ValContaccus
10431:             ENDIF
10432:         CATCH TO loc_oErro
10433:             MsgErro(loc_oErro.Message, "Erro")
10434:         ENDTRY
10435:         RETURN loc_lResultado
10436:     ENDPROC
10437: 
10438:     *--------------------------------------------------------------------------
10439:     * AbrirLookupContaccus - Abre busca de conta C.C. (SigCdCli filtrado por grupo)
10440:     *--------------------------------------------------------------------------
10441:     PROCEDURE AbrirLookupContaccus()
10442:         LOCAL loc_oBusca, loc_oPg, loc_cGrupo, loc_cTabela
10443:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10444:         loc_cGrupo = ALLTRIM(NVL(loc_oPg.txt_4c_Gruccus.Value, ""))
10445:         TRY
10446:             loc_cTabela = "SigCdCli"
10447:             IF !EMPTY(loc_cGrupo)
10448:                 loc_cTabela = "SigCdCli WHERE Grupos = " + EscaparSQL(loc_cGrupo)
10449:                 loc_cTabela = "(SELECT IClis, Rclis FROM SigCdCli WHERE Grupos = " + EscaparSQL(loc_cGrupo) + ") AS t"
10450:             ENDIF
10451:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10452:                 "SigCdCli", "cursor_4c_BuscaContaccus", "IClis", ;
10453:                 ALLTRIM(loc_oPg.txt_4c_Contaccus.Value), "Busca de Conta C.C.")
10454:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10455:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10456:             loc_oBusca.Show()
10457:             IF loc_oBusca.this_lSelecionou
10458:                 IF USED("cursor_4c_BuscaContaccus")
10459:                     SELECT cursor_4c_BuscaContaccus
10460:                     loc_oPg.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
10461:                     loc_oPg.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
10462:                     USE IN cursor_4c_BuscaContaccus
10463:                 ENDIF
10464:             ENDIF
10465:             loc_oBusca.Release()
10466:             loc_oBusca = .NULL.
10467:         CATCH TO loc_oErro
10468:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de conta C.C.")
10469:         ENDTRY
10470:     ENDPROC
10471: 
10472:     *--------------------------------------------------------------------------
10473:     * TxtDcontaccusKeyPress - KeyPress em txt_4c_Dcontaccus (F4 abre lookup por nome)
10474:     *--------------------------------------------------------------------------
10475:     PROCEDURE TxtDcontaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10476:         IF par_nKeyCode = 115
10477:             THIS.AbrirLookupDcontaccus()
10478:         ENDIF
10479:     ENDPROC
10480: 
10481:     *--------------------------------------------------------------------------
10482:     * AbrirLookupDcontaccus - Busca reversa por nome em SigCdCli
10483:     *--------------------------------------------------------------------------
10484:     PROCEDURE AbrirLookupDcontaccus()
10485:         LOCAL loc_oBusca, loc_oPg
10486:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10487:         TRY
10488:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10489:                 "SigCdCli", "cursor_4c_BuscaContaccus", "Rclis", ;
10490:                 ALLTRIM(loc_oPg.txt_4c_Dcontaccus.Value), "Busca de Conta C.C.")
10491:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10492:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10493:             loc_oBusca.Show()
10494:             IF loc_oBusca.this_lSelecionou
10495:                 IF USED("cursor_4c_BuscaContaccus")
10496:                     SELECT cursor_4c_BuscaContaccus
10497:                     loc_oPg.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
10498:                     loc_oPg.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
10499:                     USE IN cursor_4c_BuscaContaccus
10500:                 ENDIF
10501:             ENDIF
10502:             loc_oBusca.Release()
10503:             loc_oBusca = .NULL.
10504:         CATCH TO loc_oErro
10505:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de conta C.C.")
10506:         ENDTRY
10507:     ENDPROC
10508: 
10509:     *--------------------------------------------------------------------------
10510:     * TxtClfiscalKeyPress - KeyPress em txt_4c_Clfiscal (F4 abre lookup SigCdClf)
10511:     *--------------------------------------------------------------------------
10512:     PROCEDURE TxtClfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10513:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10514:             THIS.ValidarClfiscal()
10515:         ENDIF
10516:         IF par_nKeyCode = 115
10517:             THIS.AbrirLookupClfiscal()
10518:         ENDIF
10519:     ENDPROC
10520: 
10521:     *--------------------------------------------------------------------------
10522:     * ValidarClfiscal - LostFocus/Enter em txt_4c_Clfiscal
10523:     * Lookup: SigCdClf (Codigos / Descricaos)
10524:     *--------------------------------------------------------------------------
10525:     PROCEDURE ValidarClfiscal()
10526:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10527:         loc_lResultado = .T.
10528:         TRY
10529:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10530:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Clfiscal.Value, ""))
10531:             IF EMPTY(loc_cCodigo)
10532:                 loc_oPage.txt_4c_Dclfiscal.Value = ""
10533:                 loc_lResultado = loc_lResultado
10534:             ENDIF
10535:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10536:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValClf") <= 0 OR EOF("cursor_4c_ValClf")
10537:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10538:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValClf"
10539:                 loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10540:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10541:                 loc_oLookup.cTabela     = "SigCdClf"
10542:                 loc_oLookup.cCampoChave = "Codigos"
10543:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10544:                 loc_oLookup.Show()
10545:                 IF loc_oLookup.this_lSelecionou
10546:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10547:                 ELSE
10548:                     loc_cCodigo = ""
10549:                 ENDIF
10550:             ELSE
10551:                 SELECT cursor_4c_ValClf
10552:                 loc_oPage.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10553:             ENDIF
10554:             IF USED("cursor_4c_ValClf")
10555:                 USE IN cursor_4c_ValClf
10556:             ENDIF
10557:             loc_oPage.txt_4c_Clfiscal.Value = loc_cCodigo
10558:             IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dclfiscal.Value)
10559:                 *-- Recarregar descricao apos lookup
10560:                 loc_lcSQL = "SELECT Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10561:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValClf2") > 0 AND !EOF("cursor_4c_ValClf2")
10562:                     SELECT cursor_4c_ValClf2
10563:                     loc_oPage.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10564:                 ENDIF
10565:                 IF USED("cursor_4c_ValClf2")
10566:                     USE IN cursor_4c_ValClf2
10567:                 ENDIF
10568:             ENDIF
10569:             loc_oPage.txt_4c_Clfiscal.Refresh()
10570:             loc_oPage.txt_4c_Dclfiscal.Refresh()
10571:             loc_oPage.grd_4c_Dados.Refresh()
10572:             loc_oPage.Refresh()
10573:         CATCH TO loc_oErro
10574:             MsgErro(loc_oErro.Message, "Erro")
10575:         ENDTRY
10576:         RETURN loc_lResultado
10577:     ENDPROC
10578: 
10579:     *--------------------------------------------------------------------------
10580:     * AbrirLookupClfiscal - Abre busca de classificacao fiscal (SigCdClf)
10581:     *--------------------------------------------------------------------------
10582:     PROCEDURE AbrirLookupClfiscal()
10583:         LOCAL loc_oBusca, loc_oPg
10584:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10585:         TRY
10586:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10587:                 "SigCdClf", "cursor_4c_BuscaClf", "Codigos", ;
10588:                 ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value), "Busca de Classifica" + CHR(231) + CHR(227) + "o Fiscal")
10589:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10590:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10591:             loc_oBusca.Show()
10592:             IF loc_oBusca.this_lSelecionou
10593:                 IF USED("cursor_4c_BuscaClf")
10594:                     SELECT cursor_4c_BuscaClf
10595:                     loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(Codigos)
10596:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10597:                     USE IN cursor_4c_BuscaClf
10598:                 ENDIF
10599:             ENDIF
10600:             loc_oBusca.Release()
10601:             loc_oBusca = .NULL.
10602:         CATCH TO loc_oErro
10603:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o fiscal")
10604:         ENDTRY
10605:     ENDPROC
10606: 
10607:     *--------------------------------------------------------------------------
10608:     * TxtDclfiscalKeyPress - KeyPress em txt_4c_Dclfiscal (F4 busca reversa)
10609:     *--------------------------------------------------------------------------
10610:     PROCEDURE TxtDclfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10611:         IF par_nKeyCode = 115
10612:             THIS.AbrirLookupDclfiscal()
10613:         ENDIF
10614:     ENDPROC
10615: 
10616:     *--------------------------------------------------------------------------
10617:     * AbrirLookupDclfiscal - Busca reversa por descricao em SigCdClf
10618:     *--------------------------------------------------------------------------
10619:     PROCEDURE AbrirLookupDclfiscal()
10620:         LOCAL loc_oBusca, loc_oPg
10621:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10622:         TRY
10623:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10624:                 "SigCdClf", "cursor_4c_BuscaClf", "Descricaos", ;
10625:                 ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value), "Busca de Classifica" + CHR(231) + CHR(227) + "o Fiscal")
10626:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10627:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10628:             loc_oBusca.Show()
10629:             IF loc_oBusca.this_lSelecionou
10630:                 IF USED("cursor_4c_BuscaClf")
10631:                     SELECT cursor_4c_BuscaClf
10632:                     loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(Codigos)
10633:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10634:                     USE IN cursor_4c_BuscaClf
10635:                 ENDIF
10636:             ENDIF
10637:             loc_oBusca.Release()
10638:             loc_oBusca = .NULL.
10639:         CATCH TO loc_oErro
10640:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o fiscal")
10641:         ENDTRY
10642:     ENDPROC
10643: 
10644:     *--------------------------------------------------------------------------
10645:     * TxtOrigmercKeyPress - KeyPress em txt_4c_Origmerc (F4 abre lookup SigCdOrg)
10646:     *--------------------------------------------------------------------------
10647:     PROCEDURE TxtOrigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10648:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10649:             THIS.ValidarOrigmerc()
10650:         ENDIF
10651:         IF par_nKeyCode = 115
10652:             THIS.AbrirLookupOrigmerc()
10653:         ENDIF
10654:     ENDPROC
10655: 
10656:     *--------------------------------------------------------------------------
10657:     * ValidarOrigmerc - LostFocus/Enter em txt_4c_Origmerc
10658:     * Lookup: SigCdOrg (Codigos / Descricaos)
10659:     *--------------------------------------------------------------------------
10660:     PROCEDURE ValidarOrigmerc()
10661:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10662:         loc_lResultado = .T.
10663:         TRY
10664:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10665:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Origmerc.Value, ""))
10666:             IF EMPTY(loc_cCodigo)
10667:                 loc_oPage.txt_4c_Dorigmerc.Value = ""
10668:                 loc_lResultado = loc_lResultado
10669:             ENDIF
10670:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdOrg WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10671:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOrg") <= 0 OR EOF("cursor_4c_ValOrg")
10672:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10673:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValOrg"
10674:                 loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10675:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10676:                 loc_oLookup.cTabela     = "SigCdOrg"
10677:                 loc_oLookup.cCampoChave = "Codigos"
10678:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10679:                 loc_oLookup.Show()
10680:                 IF loc_oLookup.this_lSelecionou
10681:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10682:                 ELSE
10683:                     loc_cCodigo = ""
10684:                 ENDIF
10685:             ELSE
10686:                 SELECT cursor_4c_ValOrg
10687:                 loc_oPage.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10688:             ENDIF
10689:             IF USED("cursor_4c_ValOrg")
10690:                 USE IN cursor_4c_ValOrg
10691:             ENDIF
10692:             loc_oPage.txt_4c_Origmerc.Value = loc_cCodigo
10693:             IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dorigmerc.Value)
10694:                 loc_lcSQL = "SELECT Descricaos FROM SigCdOrg WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10695:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOrg2") > 0 AND !EOF("cursor_4c_ValOrg2")
10696:                     SELECT cursor_4c_ValOrg2
10697:                     loc_oPage.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10698:                 ENDIF
10699:                 IF USED("cursor_4c_ValOrg2")
10700:                     USE IN cursor_4c_ValOrg2
10701:                 ENDIF
10702:             ENDIF
10703:             loc_oPage.txt_4c_Origmerc.Refresh()
10704:             loc_oPage.txt_4c_Dorigmerc.Refresh()
10705:             loc_oPage.grd_4c_Dados.Refresh()
10706:             loc_oPage.Refresh()
10707:         CATCH TO loc_oErro
10708:             MsgErro(loc_oErro.Message, "Erro")
10709:         ENDTRY
10710:         RETURN loc_lResultado
10711:     ENDPROC
10712: 
10713:     *--------------------------------------------------------------------------
10714:     * AbrirLookupOrigmerc - Abre busca de origem da mercadoria (SigCdOrg)
10715:     *--------------------------------------------------------------------------
10716:     PROCEDURE AbrirLookupOrigmerc()
10717:         LOCAL loc_oBusca, loc_oPg
10718:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10719:         TRY
10720:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10721:                 "SigCdOrg", "cursor_4c_BuscaOrg", "Codigos", ;
10722:                 ALLTRIM(loc_oPg.txt_4c_Origmerc.Value), "Busca de Origem da Mercadoria")
10723:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10724:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10725:             loc_oBusca.Show()
10726:             IF loc_oBusca.this_lSelecionou
10727:                 IF USED("cursor_4c_BuscaOrg")
10728:                     SELECT cursor_4c_BuscaOrg
10729:                     loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(Codigos)
10730:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10731:                     USE IN cursor_4c_BuscaOrg
10732:                 ENDIF
10733:             ENDIF
10734:             loc_oBusca.Release()
10735:             loc_oBusca = .NULL.
10736:         CATCH TO loc_oErro
10737:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de origem da mercadoria")
10738:         ENDTRY
10739:     ENDPROC
10740: 
10741:     *--------------------------------------------------------------------------
10742:     * TxtDorigmercKeyPress - KeyPress em txt_4c_Dorigmerc (F4 busca reversa)
10743:     *--------------------------------------------------------------------------
10744:     PROCEDURE TxtDorigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10745:         IF par_nKeyCode = 115
10746:             THIS.AbrirLookupDorigmerc()
10747:         ENDIF
10748:     ENDPROC
10749: 
10750:     *--------------------------------------------------------------------------
10751:     * AbrirLookupDorigmerc - Busca reversa por descricao em SigCdOrg
10752:     *--------------------------------------------------------------------------
10753:     PROCEDURE AbrirLookupDorigmerc()
10754:         LOCAL loc_oBusca, loc_oPg
10755:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10756:         TRY
10757:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10758:                 "SigCdOrg", "cursor_4c_BuscaOrg", "Descricaos", ;
10759:                 ALLTRIM(loc_oPg.txt_4c_Dorigmerc.Value), "Busca de Origem da Mercadoria")
10760:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10761:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10762:             loc_oBusca.Show()
10763:             IF loc_oBusca.this_lSelecionou
10764:                 IF USED("cursor_4c_BuscaOrg")
10765:                     SELECT cursor_4c_BuscaOrg
10766:                     loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(Codigos)
10767:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10768:                     USE IN cursor_4c_BuscaOrg
10769:                 ENDIF
10770:             ENDIF
10771:             loc_oBusca.Release()
10772:             loc_oBusca = .NULL.
10773:         CATCH TO loc_oErro
10774:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de origem da mercadoria")
10775:         ENDTRY
10776:     ENDPROC
10777: 
10778:     *--------------------------------------------------------------------------
10779:     * TxtSittricmKeyPress - KeyPress em txt_4c_Sittricm (F4 abre lookup SigCdIcm)
10780:     *--------------------------------------------------------------------------
10781:     PROCEDURE TxtSittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10782:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10783:             THIS.ValidarSittricm()
10784:         ENDIF
10785:         IF par_nKeyCode = 115
10786:             THIS.AbrirLookupSittricm()
10787:         ENDIF
10788:     ENDPROC
10789: 
10790:     *--------------------------------------------------------------------------
10791:     * ValidarSittricm - LostFocus/Enter em txt_4c_Sittricm
10792:     * Lookup: SigCdIcm (Codigos / Descricaos)
10793:     *--------------------------------------------------------------------------
10794:     PROCEDURE ValidarSittricm()
10795:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10796:         loc_lResultado = .T.
10797:         TRY
10798:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10799:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Sittricm.Value, ""))
10800:             IF EMPTY(loc_cCodigo)
10801:                 loc_oPage.txt_4c_Dsittricm.Value = ""
10802:                 loc_lResultado = loc_lResultado
10803:             ENDIF
10804:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10805:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValIcm") <= 0 OR EOF("cursor_4c_ValIcm")
10806:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10807:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValIcm"
10808:                 loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10809:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10810:                 loc_oLookup.cTabela     = "SigCdIcm"
10811:                 loc_oLookup.cCampoChave = "Codigos"
10812:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10813:                 loc_oLookup.Show()
10814:                 IF loc_oLookup.this_lSelecionou
10815:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10816:                 ELSE
10817:                     loc_cCodigo = ""
10818:                 ENDIF
10819:             ELSE
10820:                 SELECT cursor_4c_ValIcm
10821:                 loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10822:             ENDIF
10823:             IF USED("cursor_4c_ValIcm")
10824:                 USE IN cursor_4c_ValIcm
10825:             ENDIF
10826:             loc_oPage.txt_4c_Sittricm.Value = loc_cCodigo
10827:             IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dsittricm.Value)
10828:                 loc_lcSQL = "SELECT Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10829:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValIcm2") > 0 AND !EOF("cursor_4c_ValIcm2")
10830:                     SELECT cursor_4c_ValIcm2
10831:                     loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10832:                 ENDIF
10833:                 IF USED("cursor_4c_ValIcm2")
10834:                     USE IN cursor_4c_ValIcm2
10835:                 ENDIF
10836:             ENDIF
10837:             loc_oPage.txt_4c_Sittricm.Refresh()
10838:             loc_oPage.txt_4c_Dsittricm.Refresh()
10839:             loc_oPage.grd_4c_Dados.Refresh()
10840:             loc_oPage.Refresh()
10841:         CATCH TO loc_oErro
10842:             MsgErro(loc_oErro.Message, "Erro")
10843:         ENDTRY
10844:         RETURN loc_lResultado
10845:     ENDPROC
10846: 
10847:     *--------------------------------------------------------------------------
10848:     * AbrirLookupSittricm - Abre busca situacao tributaria ICMS (SigCdIcm)
10849:     *--------------------------------------------------------------------------
10850:     PROCEDURE AbrirLookupSittricm()
10851:         LOCAL loc_oBusca, loc_oPg
10852:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10853:         TRY
10854:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10855:                 "SigCdIcm", "cursor_4c_BuscaIcm", "Codigos", ;
10856:                 ALLTRIM(loc_oPg.txt_4c_Sittricm.Value), "Busca de Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
10857:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10858:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10859:             loc_oBusca.Show()
10860:             IF loc_oBusca.this_lSelecionou
10861:                 IF USED("cursor_4c_BuscaIcm")
10862:                     SELECT cursor_4c_BuscaIcm
10863:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10864:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10865:                     USE IN cursor_4c_BuscaIcm
10866:                 ENDIF
10867:             ENDIF
10868:             loc_oBusca.Release()
10869:             loc_oBusca = .NULL.
10870:         CATCH TO loc_oErro
10871:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
10872:         ENDTRY
10873:     ENDPROC
10874: 
10875:     *--------------------------------------------------------------------------
10876:     * TxtDsittricmKeyPress - KeyPress em txt_4c_Dsittricm (F4 busca reversa)
10877:     *--------------------------------------------------------------------------
10878:     PROCEDURE TxtDsittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10879:         IF par_nKeyCode = 115
10880:             THIS.AbrirLookupDsittricm()
10881:         ENDIF
10882:     ENDPROC
10883: 
10884:     *--------------------------------------------------------------------------
10885:     * AbrirLookupDsittricm - Busca reversa por descricao em SigCdIcm
10886:     *--------------------------------------------------------------------------
10887:     PROCEDURE AbrirLookupDsittricm()
10888:         LOCAL loc_oBusca, loc_oPg
10889:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10890:         TRY
10891:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10892:                 "SigCdIcm", "cursor_4c_BuscaIcm", "Descricaos", ;
10893:                 ALLTRIM(loc_oPg.txt_4c_Dsittricm.Value), "Busca de Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
10894:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10895:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10896:             loc_oBusca.Show()
10897:             IF loc_oBusca.this_lSelecionou
10898:                 IF USED("cursor_4c_BuscaIcm")
10899:                     SELECT cursor_4c_BuscaIcm
10900:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10901:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10902:                     USE IN cursor_4c_BuscaIcm
10903:                 ENDIF
10904:             ENDIF
10905:             loc_oBusca.Release()
10906:             loc_oBusca = .NULL.
10907:         CATCH TO loc_oErro
10908:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
10909:         ENDTRY
10910:     ENDPROC
10911: 
10912:     *--------------------------------------------------------------------------
10913:     * TxtCodServsKeyPress - KeyPress em txt_4c_CodServs (F4 abre lookup SigCdIcm)
10914:     *--------------------------------------------------------------------------
10915:     PROCEDURE TxtCodServsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10916:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10917:             THIS.ValidarCodServs()
10918:         ENDIF
10919:         IF par_nKeyCode = 115
10920:             THIS.AbrirLookupCodServs()
10921:         ENDIF
10922:     ENDPROC
10923: 
10924:     *--------------------------------------------------------------------------
10925:     * ValidarCodServs - LostFocus/Enter em txt_4c_CodServs
10926:     * Lookup: SigCdIcm (Codigos) -> preenche txt_4c_Sittricm
10927:     *--------------------------------------------------------------------------
10928:     PROCEDURE ValidarCodServs()
10929:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10930:         loc_lResultado = .T.
10931:         TRY
10932:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10933:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_CodServs.Value, ""))
10934:             IF EMPTY(loc_cCodigo)
10935:                 loc_lResultado = loc_lResultado
10936:             ENDIF
10937:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10938:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCodServs") <= 0 OR EOF("cursor_4c_ValCodServs")
10939:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10940:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValServs"
10941:                 loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10942:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10943:                 loc_oLookup.cTabela     = "SigCdIcm"
10944:                 loc_oLookup.cCampoChave = "Codigos"
10945:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10946:                 loc_oLookup.Show()
10947:                 IF loc_oLookup.this_lSelecionou
10948:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10949:                 ELSE
10950:                     loc_cCodigo = ""
10951:                 ENDIF
10952:             ELSE
10953:                 *-- Get_CodServs preenche txt_4c_Sittricm (conforme original)
10954:                 SELECT cursor_4c_ValCodServs
10955:                 loc_oPage.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10956:                 loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10957:                 loc_oPage.txt_4c_Sittricm.Refresh()
10958:                 loc_oPage.txt_4c_Dsittricm.Refresh()
10959:             ENDIF
10960:             IF USED("cursor_4c_ValCodServs")
10961:                 USE IN cursor_4c_ValCodServs
10962:             ENDIF
10963:             loc_oPage.txt_4c_CodServs.Value = loc_cCodigo
10964:             loc_oPage.txt_4c_CodServs.Refresh()
10965:             loc_oPage.grd_4c_Dados.Refresh()
10966:             loc_oPage.Refresh()
10967:         CATCH TO loc_oErro
10968:             MsgErro(loc_oErro.Message, "Erro")
10969:         ENDTRY
10970:         RETURN loc_lResultado
10971:     ENDPROC
10972: 
10973:     *--------------------------------------------------------------------------
10974:     * AbrirLookupCodServs - Abre busca codigo servicos ICMS (SigCdIcm)
10975:     *--------------------------------------------------------------------------
10976:     PROCEDURE AbrirLookupCodServs()
10977:         LOCAL loc_oBusca, loc_oPg
10978:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10979:         TRY
10980:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10981:                 "SigCdIcm", "cursor_4c_BuscaIcm", "Codigos", ;
10982:                 ALLTRIM(loc_oPg.txt_4c_CodServs.Value), "Busca de C" + CHR(243) + "digo de Servi" + CHR(231) + "os")
10983:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10984:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10985:             loc_oBusca.Show()
10986:             IF loc_oBusca.this_lSelecionou
10987:                 IF USED("cursor_4c_BuscaIcm")
10988:                     SELECT cursor_4c_BuscaIcm
10989:                     loc_oPg.txt_4c_CodServs.Value  = ALLTRIM(Codigos)
10990:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10991:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10992:                     USE IN cursor_4c_BuscaIcm
10993:                 ENDIF
10994:             ENDIF
10995:             loc_oBusca.Release()
10996:             loc_oBusca = .NULL.
10997:         CATCH TO loc_oErro
10998:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de c" + CHR(243) + "digo de servi" + CHR(231) + "os")
10999:         ENDTRY
11000:     ENDPROC
11001: 
11002:     *--------------------------------------------------------------------------
11003:     * TxtTpTribKeyPress - KeyPress em txt_4c_TpTrib (F4 abre lookup SigPrTri)
11004:     *--------------------------------------------------------------------------
11005:     PROCEDURE TxtTpTribKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11006:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
11007:             THIS.ValidarTpTrib()
11008:         ENDIF
11009:         IF par_nKeyCode = 115
11010:             THIS.AbrirLookupTpTrib()
11011:         ENDIF
11012:     ENDPROC
11013: 
11014:     *--------------------------------------------------------------------------
11015:     * ValidarTpTrib - LostFocus/Enter em txt_4c_TpTrib
11016:     * Lookup: SigPrTri (Tipos / Descs)
11017:     *--------------------------------------------------------------------------
11018:     PROCEDURE ValidarTpTrib()
11019:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
11020:         loc_lResultado = .T.
11021:         TRY
11022:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11023:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_TpTrib.Value, ""))
11024:             IF EMPTY(loc_cCodigo)
11025:                 loc_lResultado = loc_lResultado
11026:             ENDIF
11027:             loc_lcSQL = "SELECT Tipos FROM SigPrTri WHERE Tipos = " + EscaparSQL(loc_cCodigo)
11028:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTrib") <= 0 OR EOF("cursor_4c_ValTrib")
11029:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
11030:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValTrib"
11031:                 loc_oLookup.mAddColuna("Tipos", "", "Tipo")
11032:                 loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11033:                 loc_oLookup.cTabela     = "SigPrTri"
11034:                 loc_oLookup.cCampoChave = "Tipos"
11035:                 loc_oLookup.cFiltroIni  = loc_cCodigo
11036:                 loc_oLookup.Show()
11037:                 IF loc_oLookup.this_lSelecionou
11038:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
11039:                 ELSE
11040:                     loc_cCodigo = ""
11041:                 ENDIF
11042:             ENDIF
11043:             IF USED("cursor_4c_ValTrib")
11044:                 USE IN cursor_4c_ValTrib
11045:             ENDIF
11046:             loc_oPage.txt_4c_TpTrib.Value = loc_cCodigo
11047:             loc_oPage.txt_4c_TpTrib.Refresh()
11048:             loc_oPage.grd_4c_Dados.Refresh()
11049:             loc_oPage.Refresh()
11050:         CATCH TO loc_oErro
11051:             MsgErro(loc_oErro.Message, "Erro")
11052:         ENDTRY
11053:         RETURN loc_lResultado
11054:     ENDPROC
11055: 
11056:     *--------------------------------------------------------------------------
11057:     * AbrirLookupTpTrib - Abre busca de tipo de tributacao (SigPrTri)
11058:     *--------------------------------------------------------------------------
11059:     PROCEDURE AbrirLookupTpTrib()
11060:         LOCAL loc_oBusca, loc_oPg
11061:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11062:         TRY
11063:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11064:                 "SigPrTri", "cursor_4c_BuscaTrib", "Tipos", ;
11065:                 ALLTRIM(loc_oPg.txt_4c_TpTrib.Value), "Busca de Tipo de Tributa" + CHR(231) + CHR(227) + "o")
11066:             loc_oBusca.mAddColuna("Tipos", "", "Tipo")
11067:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11068:             loc_oBusca.Show()
11069:             IF loc_oBusca.this_lSelecionou
11070:                 IF USED("cursor_4c_BuscaTrib")
11071:                     SELECT cursor_4c_BuscaTrib
11072:                     loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(Tipos)
11073:                     USE IN cursor_4c_BuscaTrib
11074:                 ENDIF
11075:             ENDIF
11076:             loc_oBusca.Release()
11077:             loc_oBusca = .NULL.
11078:         CATCH TO loc_oErro
11079:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de tipo de tributa" + CHR(231) + CHR(227) + "o")
11080:         ENDTRY
11081:     ENDPROC
11082: 
11083:     *--------------------------------------------------------------------------
11084:     * ValidarIat - LostFocus em txt_4c_Iat
11085:     * Valida: deve ser 'A' (Arredondamento) ou 'T' (Truncamento) ou vazio
11086:     *--------------------------------------------------------------------------
11087:     PROCEDURE ValidarIat()
11088:         LOCAL loc_oPage, loc_cValor
11089:         TRY
11090:             loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11091:             loc_cValor = UPPER(ALLTRIM(NVL(loc_oPage.txt_4c_Iat.Value, "")))
11092:             IF EMPTY(loc_cValor)
11093:                 RETURN
11094:             ENDIF
11095:             IF !INLIST(loc_cValor, "A", "T")
11096:                 MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
11097:                     "Digite [A] Indicador de Arredondamento ou [T] Indicador de Truncamento!")
11098:                 loc_oPage.txt_4c_Iat.Value = ""
11099:                 loc_oPage.txt_4c_Iat.Refresh()
11100:             ELSE
11101:                 loc_oPage.txt_4c_Iat.Value = loc_cValor
11102:             ENDIF
11103:         CATCH TO loc_oErro
11104:             MsgErro(loc_oErro.Message, "Erro")
11105:         ENDTRY
11106:     ENDPROC
11107: 
11108:     *--------------------------------------------------------------------------
11109:     * ValidarAliqIPI - LostFocus em txt_4c_AliqIPI
11110:     * Verifica se aliquota informada eh identica a da classificacao fiscal
11111:     *--------------------------------------------------------------------------
11112:     PROCEDURE ValidarAliqIPI()
11113:         LOCAL loc_oPage, loc_nAliq, loc_nAliqClf, loc_lcSQL
11114:         TRY
11115:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11116:             loc_nAliq   = loc_oPage.txt_4c_AliqIPI.Value
11117:             IF EMPTY(ALLTRIM(NVL(loc_oPage.txt_4c_Clfiscal.Value, ""))) OR loc_nAliq = 0
11118:                 RETURN
11119:             ENDIF
11120:             loc_lcSQL = "SELECT aIpis FROM SigCdClf WHERE Codigos = " + EscaparSQL(ALLTRIM(loc_oPage.txt_4c_Clfiscal.Value))
11121:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAliqIPI") > 0 AND !EOF("cursor_4c_ValAliqIPI")
11122:                 SELECT cursor_4c_ValAliqIPI
11123:                 loc_nAliqClf = aIpis
11124:                 IF loc_nAliq = loc_nAliqClf
11125:                     MsgAviso("Al" + CHR(237) + "quota de IPI informada no produto id" + CHR(234) + "ntica " + ;
11126:                         CHR(224) + " classifica" + CHR(231) + CHR(227) + "o fiscal, " + ;
11127:                         "deixe zero e ser" + CHR(225) + " utilizada a classifica" + CHR(231) + CHR(227) + "o fiscal!")
11128:                 ENDIF
11129:             ENDIF
11130:             IF USED("cursor_4c_ValAliqIPI")
11131:                 USE IN cursor_4c_ValAliqIPI
11132:             ENDIF
11133:             loc_oPage.grd_4c_Dados.Refresh()
11134:             loc_oPage.Refresh()
11135:         CATCH TO loc_oErro
11136:             MsgErro(loc_oErro.Message, "Erro")
11137:         ENDTRY
11138:     ENDPROC
11139: 
11140:     *--------------------------------------------------------------------------
11141:     * TxtMvalorKeyPress - KeyPress em txt_4c_Mvalor (F4 abre lookup SigCdMoe)
11142:     *--------------------------------------------------------------------------
11143:     PROCEDURE TxtMvalorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11144:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
11145:             THIS.ValidarMvalor()
11146:         ENDIF
11147:         IF par_nKeyCode = 115
11148:             THIS.AbrirLookupMvalor()
11149:         ENDIF
11150:     ENDPROC
11151: 
11152:     *--------------------------------------------------------------------------
11153:     * ValidarMvalor - LostFocus/Enter em txt_4c_Mvalor
11154:     * Lookup: SigCdMoe (CMoes / DMoes)
11155:     *--------------------------------------------------------------------------
11156:     PROCEDURE ValidarMvalor()
11157:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
11158:         loc_lResultado = .T.
11159:         TRY
11160:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11161:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Mvalor.Value, ""))
11162:             IF EMPTY(loc_cCodigo)
11163:                 loc_lResultado = loc_lResultado
11164:             ENDIF
11165:             loc_lcSQL = "SELECT cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCodigo)
11166:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValMvalor") <= 0 OR EOF("cursor_4c_ValMvalor")
11167:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
11168:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValMoe"
11169:                 loc_oLookup.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
11170:                 loc_oLookup.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11171:                 loc_oLookup.cTabela     = "SigCdMoe"
11172:                 loc_oLookup.cCampoChave = "cmoes"
11173:                 loc_oLookup.cFiltroIni  = loc_cCodigo
11174:                 loc_oLookup.Show()
11175:                 IF loc_oLookup.this_lSelecionou
11176:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
11177:                 ELSE
11178:                     loc_cCodigo = ""
11179:                 ENDIF
11180:             ENDIF
11181:             IF USED("cursor_4c_ValMvalor")
11182:                 USE IN cursor_4c_ValMvalor
11183:             ENDIF
11184:             loc_oPage.txt_4c_Mvalor.Value = loc_cCodigo
11185:             loc_oPage.txt_4c_Mvalor.Refresh()
11186:             loc_oPage.grd_4c_Dados.Refresh()
11187:             loc_oPage.Refresh()
11188:         CATCH TO loc_oErro
11189:             MsgErro(loc_oErro.Message, "Erro")
11190:         ENDTRY
11191:         RETURN loc_lResultado
11192:     ENDPROC
11193: 
11194:     *--------------------------------------------------------------------------
11195:     * AbrirLookupMvalor - Abre busca de moeda do valor estimado (SigCdMoe)
11196:     *--------------------------------------------------------------------------
11197:     PROCEDURE AbrirLookupMvalor()
11198:         LOCAL loc_oBusca, loc_oPg
11199:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11200:         TRY
11201:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11202:                 "SigCdMoe", "cursor_4c_BuscaMvalor", "cmoes", ;
11203:                 ALLTRIM(loc_oPg.txt_4c_Mvalor.Value), "Busca de Moeda")
11204:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
11205:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11206:             loc_oBusca.Show()
11207:             IF loc_oBusca.this_lSelecionou
11208:                 IF USED("cursor_4c_BuscaMvalor")
11209:                     SELECT cursor_4c_BuscaMvalor
11210:                     loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(cmoes)
11211:                     USE IN cursor_4c_BuscaMvalor
11212:                 ENDIF
11213:             ENDIF
11214:             loc_oBusca.Release()
11215:             loc_oBusca = .NULL.
11216:         CATCH TO loc_oErro
11217:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
11218:         ENDTRY
11219:     ENDPROC
11220: 
11221:     *--------------------------------------------------------------------------
11222:     * TxtMetalKeyPress - KeyPress em txt_4c_Metal (F4 abre lookup metal)
11223:     *--------------------------------------------------------------------------
11224:     PROCEDURE TxtMetalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11225:         IF par_nKeyCode = 115
11226:             THIS.AbrirLookupMetal()
11227:         ENDIF
11228:     ENDPROC
11229: 
11230:     *--------------------------------------------------------------------------
11231:     * AbrirLookupMetal - Abre busca de metal (TmpMTal - cursor pre-carregado)
11232:     * Nota: TmpMTal deve ser carregado pelo form durante init com dados da tabela de metais
11233:     *--------------------------------------------------------------------------
11234:     PROCEDURE AbrirLookupMetal()
11235:         LOCAL loc_oBusca, loc_oPg
11236:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11237:         TRY
11238:             IF USED("TmpMTal")
11239:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11240:                     "TmpMTal", "cursor_4c_BuscaMetal", "Codigos", ;
11241:                     ALLTRIM(loc_oPg.txt_4c_Metal.Value), "Busca de Metal")
11242:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
11243:                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11244:                 loc_oBusca.Show()
11245:                 IF loc_oBusca.this_lSelecionou
11246:                     IF USED("cursor_4c_BuscaMetal")
11247:                         SELECT cursor_4c_BuscaMetal
11248:                         loc_oPg.txt_4c_Metal.Value   = ALLTRIM(Codigos)
11249:                         loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(Descs)
11250:                         USE IN cursor_4c_BuscaMetal
11251:                     ENDIF
11252:                 ENDIF
11253:                 loc_oBusca.Release()
11254:                 loc_oBusca = .NULL.
11255:             ENDIF
11256:         CATCH TO loc_oErro
11257:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de metal")
11258:         ENDTRY
11259:     ENDPROC
11260: 
11261:     *--------------------------------------------------------------------------
11262:     * TxtTeorKeyPress - KeyPress em txt_4c_Teor (F4 abre lookup teor)
11263:     *--------------------------------------------------------------------------
11264:     PROCEDURE TxtTeorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11265:         IF par_nKeyCode = 115
11266:             THIS.AbrirLookupTeor()
11267:         ENDIF
11268:     ENDPROC
11269: 
11270:     *--------------------------------------------------------------------------
11271:     * AbrirLookupTeor - Abre busca de teor (TmpTeor - cursor pre-carregado)
11272:     * Nota: TmpTeor deve ser carregado pelo form durante init com dados da tabela de teores
11273:     *--------------------------------------------------------------------------
11274:     PROCEDURE AbrirLookupTeor()
11275:         LOCAL loc_oBusca, loc_oPg
11276:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11277:         TRY
11278:             IF USED("TmpTeor")
11279:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11280:                     "TmpTeor", "cursor_4c_BuscaTeor", "Codigos", ;
11281:                     ALLTRIM(loc_oPg.txt_4c_Teor.Value), "Busca de Teor")
11282:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
11283:                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11284:                 loc_oBusca.Show()
11285:                 IF loc_oBusca.this_lSelecionou
11286:                     IF USED("cursor_4c_BuscaTeor")
11287:                         SELECT cursor_4c_BuscaTeor
11288:                         loc_oPg.txt_4c_Teor.Value   = ALLTRIM(Codigos)
11289:                         loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(Descs)
11290:                         USE IN cursor_4c_BuscaTeor
11291:                     ENDIF
11292:                 ENDIF
11293:                 loc_oBusca.Release()
11294:                 loc_oBusca = .NULL.
11295:             ENDIF
11296:         CATCH TO loc_oErro
11297:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de teor")
11298:         ENDTRY
11299:     ENDPROC
11300: 
11301:     *--------------------------------------------------------------------------
11302:     * CmdBtnDescFisClick - Click em cmd_4c_BtnDescFis
11303:     * Gera descricao fiscal a partir da composicao do produto (campo DescFis em SigCdPro)
11304:     *--------------------------------------------------------------------------
11305:     PROCEDURE CmdBtnDescFisClick()
11306:         LOCAL loc_oPage, loc_cCpros, loc_lcSQL, loc_cDescFis
11307:         TRY
11308:             loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11309:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11310:             IF EMPTY(loc_cCpros)
11311:                 MsgAviso("Salve o produto antes de gerar a descri" + CHR(231) + CHR(227) + "o fiscal.")
11312:                 RETURN
11313:             ENDIF
11314:             *-- Gerar descricao fiscal baseada na composicao do produto (simplificado)
11315:             loc_lcSQL = "SELECT TOP 1 dpros + ' ' + ISNULL(dpro2s,'') AS descFis " + ;
11316:                 "FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
11317:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_DescFis") > 0 AND !EOF("cursor_4c_DescFis")
11318:                 SELECT cursor_4c_DescFis
11319:                 loc_cDescFis = ALLTRIM(descFis)
11320:                 IF !EMPTY(loc_cDescFis)
11321:                     loc_oPage.obj_4c_Mgetdescfi.Value = loc_cDescFis
11322:                     loc_oPage.obj_4c_Mgetdescfi.Refresh()
11323:                     *-- Persistir no banco
11324:                     loc_lcSQL = "UPDATE SigCdPro SET DescFis = " + EscaparSQL(loc_cDescFis) + ;
11325:                         " WHERE cpros = " + EscaparSQL(loc_cCpros)
11326:                     SQLEXEC(gnConnHandle, loc_lcSQL)
11327:                 ELSE
11328:                     MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + CHR(231) + CHR(227) + "o fiscal!")
11329:                 ENDIF
11330:             ELSE
11331:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + CHR(231) + CHR(227) + "o fiscal!")
11332:             ENDIF
11333:             IF USED("cursor_4c_DescFis")
11334:                 USE IN cursor_4c_DescFis
11335:             ENDIF
11336:         CATCH TO loc_oErro
11337:             MsgErro(loc_oErro.Message, "Erro ao gerar descri" + CHR(231) + CHR(227) + "o fiscal")
11338:         ENDTRY
11339:     ENDPROC
11340: 
11341:     *--------------------------------------------------------------------------
11342:     * AtualizarSigCdPro - Salva campos editaveis de SigCdPro apos salvar SigPrFtp
11343:     * Chamado por BtnSalvarClick() apos this_oBusinessObject.Salvar() com sucesso
11344:     *--------------------------------------------------------------------------
11345:     PROTECTED PROCEDURE AtualizarSigCdPro()
11346:         LOCAL loc_oPg, loc_cCpros, loc_cSQL, loc_lFabrProprs, loc_lConsig, loc_lEncoms
11347:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
11348:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11349: 
11350:         IF EMPTY(loc_cCpros)
11351:             RETURN
11352:         ENDIF
11353: 
11354:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11355:             RETURN
11356:         ENDIF
11357: 
11358:         *-- Converter CheckBox.Value (logico) para 0/1
11359:         loc_lFabrProprs = IIF(loc_oPg.chk_4c_FabrProprs.Value, 1, 0)
11360:         loc_lConsig     = IIF(loc_oPg.chk_4c_Consig.Value,     1, 0)
11361:         loc_lEncoms     = IIF(loc_oPg.chk_4c_Encoms.Value,     1, 0)
11362: 
11363:         *-- Coletar campos fiscais (Page3)
11364:         LOCAL loc_oPg3U, loc_cIpiVal
11365:         loc_oPg3U = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11366:         loc_cIpiVal = LEFT(UPPER(ALLTRIM(loc_oPg3U.cbo_4c_CmbIpi.Value)), 1)
11367: 
11368:         TRY
11369:             loc_cSQL = "UPDATE SigCdPro SET " + ;
11370:                 "dpro2s = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_DPro2s.Value))      + ", " + ;
11371:                 "cbars = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cbar.Value))        + ", " + ;
11372:                 "cgrus = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cgrus.Value))       + ", " + ;
11373:                 "linhas = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Lin.Value))         + ", " + ;
11374:                 "colecoes = "   + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Col.Value))         + ", " + ;
11375:                 "ifors = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Ifor.Value))        + ", " + ;
11376:                 "reffs = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Refs.Value))        + ", " + ;
11377:                 "codcors = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cor.Value))         + ", " + ;
11378:                 "codtams = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Tam.Value))         + ", " + ;
11379:                 "codfinp = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CodFinP.Value))     + ", " + ;
11380:                 "pesobs = "     + FormatarNumeroSQL(loc_oPg.txt_4c_PesoB.Value)         + ", " + ;
11381:                 "codacbs = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CodAcb.Value))      + ", " + ;
11382:                 "cclass = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Class.Value))       + ", " + ;
11383:                 "locals = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Local.Value))       + ", " + ;
11384:                 "cunis = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cuni.Value))        + ", " + ;
11385:                 "cunips = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cunip.Value))       + ", " + ;

*-- Linhas 11425 a 11468:
11425:     *--------------------------------------------------------------------------
11426:     * Destroy - Liberacao de recursos
11427:     *--------------------------------------------------------------------------
11428:     PROCEDURE Destroy()
11429:         LOCAL loc_aCursors(42), loc_nI
11430:         *-- Lista de todos os cursors possiveis deste form
11431:         loc_aCursors(1)  = "cursor_4c_Dados"
11432:         loc_aCursors(2)  = "cursor_4c_Busca"
11433:         loc_aCursors(3)  = "cursor_4c_ProdDados"
11434:         loc_aCursors(4)  = "cursor_4c_DescGru"
11435:         loc_aCursors(5)  = "cursor_4c_DescLin"
11436:         loc_aCursors(6)  = "cursor_4c_DescCol"
11437:         loc_aCursors(7)  = "cursor_4c_DescIfor"
11438:         loc_aCursors(8)  = "cursor_4c_ValPro"
11439:         loc_aCursors(9)  = "cursor_4c_ValGru"
11440:         loc_aCursors(10) = "cursor_4c_Registro"
11441:         *-- Fase 6: cursors adicionais
11442:         loc_aCursors(11) = "cursor_4c_DescCor"
11443:         loc_aCursors(12) = "cursor_4c_DescTam"
11444:         loc_aCursors(13) = "cursor_4c_DescFinP"
11445:         loc_aCursors(14) = "cursor_4c_DescAcb"
11446:         loc_aCursors(15) = "cursor_4c_DescClass"
11447:         loc_aCursors(16) = "cursor_4c_DescLocal"
11448:         loc_aCursors(17) = "cursor_4c_DescUni"
11449:         loc_aCursors(18) = "cursor_4c_DescMoe"
11450:         loc_aCursors(19) = "cursor_4c_BuscaCor"
11451:         loc_aCursors(20) = "cursor_4c_BuscaTam"
11452:         loc_aCursors(21) = "cursor_4c_BuscaFinP"
11453:         loc_aCursors(22) = "cursor_4c_BuscaAcb"
11454:         loc_aCursors(23) = "cursor_4c_BuscaClass"
11455:         loc_aCursors(24) = "cursor_4c_BuscaLocal"
11456:         loc_aCursors(25) = "cursor_4c_BuscaUni"
11457:         loc_aCursors(26) = "cursor_4c_BuscaUniP"
11458:         loc_aCursors(27) = "cursor_4c_BuscaMoe"
11459:         loc_aCursors(28) = "cursor_4c_BuscaGrupo"
11460:         loc_aCursors(29) = "cursor_4c_ValGru"
11461:         loc_aCursors(30) = "cursor_4c_DescGru"
11462:         *-- Fase 9: cursors de composicao
11463:         loc_aCursors(31) = "cursor_4c_Compo"
11464:         loc_aCursors(32) = "cursor_4c_SubCp"
11465:         loc_aCursors(33) = "cursor_4c_TotGrupo"
11466:         loc_aCursors(34) = "cursor_4c_BuscaMoeCompo"
11467:         loc_aCursors(35) = "cursor_4c_BuscaAuxMoe"
11468:         *-- Fase 10: cursors de custo


### BO (C:\4c\projeto\app\classes\ProdutoBO.prg):
*==============================================================================
* ProdutoBO.prg - Business Object para Produtos
* Tabela: SigPrFtp
*==============================================================================
DEFINE CLASS ProdutoBO AS BusinessBase

  *-- Propriedades da tabela SigPrFtp
  this_cCgrus    = ""   && char(3)   - Grupo
  this_cCods     = ""   && char(2)   - Codigo
  this_nCoefs    = 0    && numeric(6,4) - Coeficiente
  this_cCpros    = ""   && char(14)  - Codigo do Produto
  this_cPkchaves = ""   && char(20)  - Chave Primaria
  this_nValors   = 0    && numeric(10,2) - Valor

  *===========================================================================
  FUNCTION Init()
  *===========================================================================
    THIS.this_cTabela     = "SigPrFtp"
    THIS.this_cCampoChave = "cpros"

    RETURN DODEFAULT()
  ENDFUNC

  *===========================================================================
  FUNCTION ObterChavePrimaria()
  *===========================================================================
    RETURN THIS.this_cCpros
  ENDFUNC

  *===========================================================================
  FUNCTION CarregarDoCursor(par_cAliasCursor)
  *===========================================================================
    LOCAL loc_lResultado
    loc_lResultado = .F.

    TRY
      SELECT (par_cAliasCursor)
      THIS.this_cCgrus    = ALLTRIM(cgrus)
      THIS.this_cCods     = ALLTRIM(cods)
      THIS.this_nCoefs    = coefs
      THIS.this_cCpros    = ALLTRIM(cpros)
      THIS.this_cPkchaves = ALLTRIM(pkchaves)
      THIS.this_nValors   = valors
      loc_lResultado = .T.
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao carregar cursor")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  FUNCTION Buscar(par_cFiltro)
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      IF EMPTY(par_cFiltro)
        loc_cSQL = "SELECT * FROM SigPrFtp ORDER BY cpros"
      ELSE
        loc_cSQL = "SELECT * FROM SigPrFtp WHERE " + par_cFiltro + " ORDER BY cpros"
      ENDIF

      IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") > 0
        loc_lResultado = .T.
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao buscar produtos")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  FUNCTION CarregarPorCodigo(par_cCodigo)
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      loc_cSQL = "SELECT * FROM SigPrFtp WHERE cpros = " + EscaparSQL(par_cCodigo)

      IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Registro") > 0
        IF !EOF("cursor_4c_Registro")
          loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Registro")
        ENDIF
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao carregar produto")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  PROTECTED PROCEDURE Inserir()
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      loc_cSQL = "INSERT INTO SigPrFtp (cgrus, cods, coefs, cpros, pkchaves, valors) VALUES (" + ;
        EscaparSQL(THIS.this_cCgrus)    + ", " + ;
        EscaparSQL(THIS.this_cCods)     + ", " + ;
        FormatarNumeroSQL(THIS.this_nCoefs)   + ", " + ;
        EscaparSQL(THIS.this_cCpros)    + ", " + ;
        EscaparSQL(THIS.this_cPkchaves) + ", " + ;
        FormatarNumeroSQL(THIS.this_nValors)  + ")"

      IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
        loc_lResultado = .T.
        THIS.RegistrarAuditoria("I")
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao inserir produto")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  PROTECTED PROCEDURE Atualizar()
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      loc_cSQL = "UPDATE SigPrFtp SET " + ;
        "cgrus = "   + EscaparSQL(THIS.this_cCgrus)          + ", " + ;
        "cods = "    + EscaparSQL(THIS.this_cCods)           + ", " + ;
        "coefs = "   + FormatarNumeroSQL(THIS.this_nCoefs)   + ", " + ;
        "cpros = "   + EscaparSQL(THIS.this_cCpros)          + ", " + ;
        "valors = "  + FormatarNumeroSQL(THIS.this_nValors)  + ;
        " WHERE cpros = " + EscaparSQL(THIS.this_cCpros)

      IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
        loc_lResultado = .T.
        THIS.RegistrarAuditoria("A")
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao atualizar produto")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  PROTECTED FUNCTION ExecutarExclusao()
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      THIS.RegistrarAuditoria("E")

      loc_cSQL = "DELETE FROM SigPrFtp WHERE cpros = " + EscaparSQL(THIS.this_cCpros)

      IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
        loc_lResultado = .T.
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao excluir produto")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

ENDDEFINE

