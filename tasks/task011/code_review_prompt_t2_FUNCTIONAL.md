# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (138)
- [CARGA-DADOS] Metodo ValidarAcabamento faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarConquilha faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarCor faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarTam faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarGruccus faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarClfiscal faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarOrigmerc faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarSittricm faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarCodServs faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarTpTrib faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarAliqIPI faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarMvalor faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [METODO-INEXISTENTE] Metodo 'THIS.MontarFiltro()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Compo' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_CustoCompo' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [CURSOR-ORDEM] CREATE CURSOR 'cursor_4c_Cmv' aparece em mais de um local com ORDEM DE CAMPOS DIFERENTE. Primeira ocorrencia: []. Segunda ocorrencia: [DATAS,VALCUSS,MOEDAS]. A ordem DEVE ser IDENTICA em TODOS os CREATE CURSOR do mesmo nome.
- [CURSOR-ORDEM] CREATE CURSOR 'cursor_4c_Cmv' aparece em mais de um local com ORDEM DE CAMPOS DIFERENTE. Primeira ocorrencia: []. Segunda ocorrencia: [DATAS,VALCUSS,MOEDAS]. A ordem DEVE ser IDENTICA em TODOS os CREATE CURSOR do mesmo nome.
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (11470 linhas total):

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
1890:         SET NULL OFF
1891:         CREATE CURSOR cursor_4c_Compo ( ;
1892:             mats      C(14), dcompos C(40), unicompos C(3),  ;
1893:             pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
1894:             moeds     C(3),  obscompos C(10), etiqs C(1),    ;
1895:             qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
1896:             ordems    N(2,0), tipos C(20))
1897: 
1898:         *-- cursor_4c_SubCp - sub-composicao (sigsubcp)
1899:         IF USED("cursor_4c_SubCp")
1900:             USE IN cursor_4c_SubCp
1901:         ENDIF
1902:         SET NULL ON
1903:         CREATE CURSOR cursor_4c_SubCp ( ;
1904:             mats      C(14), dcompos C(40), unicompos C(3),  ;
1905:             pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
1906:             moeds     C(3),  obscompos C(10), etiqs C(1),    ;
1907:             qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
1908:             ordems    N(2,0), matsubs C(14), codtams C(4))
1909:         SET NULL OFF
1910: 
1911:         *-- cursor_4c_TotGrupo - totais por grupo (calculado)
1912:         IF USED("cursor_4c_TotGrupo")
1913:             USE IN cursor_4c_TotGrupo
1914:         ENDIF
1915:         SET NULL ON
1916:         CREATE CURSOR cursor_4c_TotGrupo ( ;
1917:             Grupo     C(3), ValGrupo N(11,3), Moeda C(3))

*-- Linhas 2019 a 2055:
2019:         WITH loc_oGrd.Column14
2020:             .Width = 108
2021:         ENDWITH
2022: 
2023:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
2024:         loc_oGrd.RecordSource = "cursor_4c_Compo"
2025: 
2026:         *-- ControlSource APOS RecordSource (obrigatorio)
2027:         loc_oGrd.Column1.ControlSource  = "cursor_4c_Compo.mats"
2028:         loc_oGrd.Column2.ControlSource  = "cursor_4c_Compo.dcompos"
2029:         loc_oGrd.Column3.ControlSource  = "cursor_4c_Compo.unicompos"
2030:         loc_oGrd.Column4.ControlSource  = "cursor_4c_Compo.pcompos"
2031:         loc_oGrd.Column5.ControlSource  = "cursor_4c_Compo.qtds"
2032:         loc_oGrd.Column6.ControlSource  = "cursor_4c_Compo.totas"
2033:         loc_oGrd.Column7.ControlSource  = "cursor_4c_Compo.moeds"
2034:         loc_oGrd.Column8.ControlSource  = "cursor_4c_Compo.obscompos"
2035:         loc_oGrd.Column9.ControlSource  = "cursor_4c_Compo.etiqs"
2036:         loc_oGrd.Column10.ControlSource = "cursor_4c_Compo.qtscons"
2037:         loc_oGrd.Column11.ControlSource = "cursor_4c_Compo.qtdcvs"
2038:         loc_oGrd.Column12.ControlSource = "cursor_4c_Compo.cunips"
2039:         loc_oGrd.Column13.ControlSource = "cursor_4c_Compo.ordems"
2040:         loc_oGrd.Column14.ControlSource = "cursor_4c_Compo.tipos"
2041: 
2042:         *-- Cabecalhos APOS RecordSource
2043:         loc_oGrd.Column1.Header1.Caption  = "Material"
2044:         loc_oGrd.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
2045:         loc_oGrd.Column3.Header1.Caption  = "Un"
2046:         loc_oGrd.Column4.Header1.Caption  = "Valor"
2047:         loc_oGrd.Column5.Header1.Caption  = "Qtde."
2048:         loc_oGrd.Column6.Header1.Caption  = "Total"
2049:         loc_oGrd.Column7.Header1.Caption  = "Moe"
2050:         loc_oGrd.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
2051:         loc_oGrd.Column9.Header1.Caption  = "E"
2052:         loc_oGrd.Column10.Header1.Caption = "Consumo"
2053:         loc_oGrd.Column11.Header1.Caption = "Qtde."
2054:         loc_oGrd.Column12.Header1.Caption = "Un"
2055:         loc_oGrd.Column13.Header1.Caption = "Ord"

*-- Linhas 2071 a 2115:
2071:         loc_oGrd.Column13.Width = 24
2072:         loc_oGrd.Column14.Width = 108
2073: 
2074:         *-- BINDEVENT grd_4c_Compo
2075:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")
2076: 
2077:         *-- ===================================================================
2078:         *-- GRID grd_4c_SubCp - Sub-composicao (grdsubcp: top=348, left=6, w=943, h=83)
2079:         *-- 15 colunas de sigsubcp
2080:         *-- ===================================================================
2081:         loc_oPg.AddObject("grd_4c_SubCp", "Grid")
2082:         loc_oGrd2 = loc_oPg.grd_4c_SubCp
2083:         WITH loc_oGrd2
2084:             .Top         = 348
2085:             .Left        = 6
2086:             .Width       = 943
2087:             .Height      = 83
2088:             .FontName    = "Tahoma"
2089:             .FontSize    = 8
2090:             .RecordMark  = .F.
2091:             .DeleteMark  = .F.
2092:             .GridLines   = 3
2093:             .ReadOnly    = .F.
2094:             .RowHeight   = 16
2095:             .ScrollBars  = 2
2096:             .Themes      = .F.
2097:             .ColumnCount = 15
2098:             .Visible     = .T.
2099:         ENDWITH
2100: 
2101:         *-- Colunas grd_4c_SubCp
2102:         WITH loc_oGrd2.Column1
2103:             .Width = 108
2104:             .Movable = .F.
2105:             .Resizable = .F.
2106:         ENDWITH
2107:         WITH loc_oGrd2.Column2
2108:             .Width = 149
2109:             .Movable = .F.
2110:             .Resizable = .F.
2111:         ENDWITH
2112:         WITH loc_oGrd2.Column3
2113:             .Width = 24
2114:             .Movable = .F.
2115:             .Resizable = .F.

*-- Linhas 2222 a 2266:
2222:         loc_oGrd2.Column14.Width = 108
2223:         loc_oGrd2.Column15.Width = 38
2224: 
2225:         *-- BINDEVENT grd_4c_SubCp
2226:         BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdSubCpAfterRowColChange")
2227: 
2228:         *-- ===================================================================
2229:         *-- GRID grd_4c_TotGrupo - Totais por grupo (GradeGRUPO: top=34, left=582, w=229, h=107)
2230:         *-- 3 colunas, ReadOnly
2231:         *-- ===================================================================
2232:         loc_oPg.AddObject("grd_4c_TotGrupo", "Grid")
2233:         loc_oGrd3 = loc_oPg.grd_4c_TotGrupo
2234:         WITH loc_oGrd3
2235:             .Top         = 34
2236:             .Left        = 582
2237:             .Width       = 229
2238:             .Height      = 107
2239:             .FontName    = "Courier New"
2240:             .FontSize    = 8
2241:             .RecordMark  = .F.
2242:             .DeleteMark  = .F.
2243:             .GridLines   = 3
2244:             .ReadOnly    = .T.
2245:             .RowHeight   = 17
2246:             .Themes      = .F.
2247:             .ColumnCount = 3
2248:             .Visible     = .T.
2249:         ENDWITH
2250: 
2251:         WITH loc_oGrd3.Column1
2252:             .Width     = 35
2253:             .Movable   = .F.
2254:             .Resizable = .F.
2255:             .ReadOnly  = .T.
2256:         ENDWITH
2257:         WITH loc_oGrd3.Column2
2258:             .Width     = 134
2259:             .Movable   = .F.
2260:             .Resizable = .F.
2261:             .ReadOnly  = .T.
2262:             .InputMask = "999,999,999.999"
2263:         ENDWITH
2264:         WITH loc_oGrd3.Column3
2265:             .Width     = 37
2266:             .Movable   = .F.

*-- Linhas 2684 a 2742:
2684:             .Themes   = .F.
2685:             .Visible  = .T.
2686:         ENDWITH
2687:         BINDEVENT(loc_oPg.chk_4c_LiberaCusto, "Click", THIS, "ChkLiberaCustoClick")
2688: 
2689:         *-- chkLiberaVenda: liberar venda (top=459, left=323, w=39, h=38)
2690:         loc_oPg.AddObject("chk_4c_LiberaVenda", "CheckBox")
2691:         WITH loc_oPg.chk_4c_LiberaVenda
2692:             .Caption  = ""
2693:             .Top      = 459
2694:             .Left     = 323
2695:             .Width    = 39
2696:             .Height   = 38
2697:             .FontName = "Tahoma"
2698:             .FontSize = 8
2699:             .Themes   = .F.
2700:             .Visible  = .T.
2701:         ENDWITH
2702:         BINDEVENT(loc_oPg.chk_4c_LiberaVenda, "Click", THIS, "ChkLiberaVendaClick")
2703: 
2704:         *-- chkPlanCus: planejamento custo (top=556, left=36, w=25, h=25)
2705:         loc_oPg.AddObject("chk_4c_PlanCus", "CheckBox")
2706:         WITH loc_oPg.chk_4c_PlanCus
2707:             .Caption  = ""
2708:             .Top      = 556
2709:             .Left     = 36
2710:             .Width    = 25
2711:             .Height   = 25
2712:             .FontName = "Tahoma"
2713:             .FontSize = 8
2714:             .Themes   = .F.
2715:             .Visible  = .T.
2716:         ENDWITH
2717: 
2718:         *-- chkPlanVen: planejamento venda (top=556, left=387, w=25, h=25)
2719:         loc_oPg.AddObject("chk_4c_PlanVen", "CheckBox")
2720:         WITH loc_oPg.chk_4c_PlanVen
2721:             .Caption  = ""
2722:             .Top      = 556
2723:             .Left     = 387
2724:             .Width    = 25
2725:             .Height   = 25
2726:             .FontName = "Tahoma"
2727:             .FontSize = 8
2728:             .Themes   = .F.
2729:             .Visible  = .T.
2730:         ENDWITH
2731: 
2732:         *-- Chk_Pvenda: usar preco de venda (top=595, left=387, w=25, h=25)
2733:         loc_oPg.AddObject("chk_4c_Pvenda", "CheckBox")
2734:         WITH loc_oPg.chk_4c_Pvenda
2735:             .Caption  = ""
2736:             .Top      = 595
2737:             .Left     = 387
2738:             .Width    = 25
2739:             .Height   = 25
2740:             .FontName = "Tahoma"
2741:             .FontSize = 8
2742:             .Themes   = .F.

*-- Linhas 2775 a 2880:
2775:             .Themes   = .F.
2776:             .Visible  = .T.
2777:         ENDWITH
2778:         BINDEVENT(loc_oPg.txt_4c_Moec, "KeyPress", THIS, "TxtMoecKeyPress")
2779: 
2780:         *-- getPcus: preco de custo moeda1 (top=517, left=9, w=115, h=23)
2781:         loc_oPg.AddObject("txt_4c_Pcus", "TextBox")
2782:         WITH loc_oPg.txt_4c_Pcus
2783:             .Value     = 0
2784:             .Top       = 517
2785:             .Left      = 9
2786:             .Width     = 115
2787:             .Height    = 23
2788:             .FontName  = "Tahoma"
2789:             .FontSize  = 8
2790:             .InputMask = "99999,999.99999"
2791:             .Themes    = .F.
2792:             .Visible   = .T.
2793:         ENDWITH
2794:         BINDEVENT(loc_oPg.txt_4c_Pcus, "LostFocus", THIS, "TxtPcusValid")
2795: 
2796:         *-- lblCuVda: "Fator de Custo (Moeda 2)" (top=502, left=161, w=126, h=15)
2797:         loc_oPg.AddObject("lbl_4c_LblCuVda", "Label")
2798:         WITH loc_oPg.lbl_4c_LblCuVda
2799:             .Caption   = "Fator de Custo (Moeda 2)"
2800:             .Top       = 502
2801:             .Left      = 161
2802:             .Width     = 126
2803:             .Height    = 15
2804:             .BackStyle = 0
2805:             .ForeColor = RGB(90, 90, 90)
2806:             .FontName  = "Tahoma"
2807:             .FontSize  = 8
2808:             .Visible   = .T.
2809:         ENDWITH
2810: 
2811:         *-- getMoepc: moeda preco custo moeda2 (top=517, left=279, w=31, h=23)
2812:         loc_oPg.AddObject("txt_4c_Moepc", "TextBox")
2813:         WITH loc_oPg.txt_4c_Moepc
2814:             .Value    = ""
2815:             .Top      = 517
2816:             .Left     = 279
2817:             .Width    = 31
2818:             .Height   = 23
2819:             .FontName = "Tahoma"
2820:             .FontSize = 8
2821:             .Themes   = .F.
2822:             .Visible  = .T.
2823:         ENDWITH
2824:         BINDEVENT(loc_oPg.txt_4c_Moepc, "KeyPress", THIS, "TxtMoepcKeyPress")
2825: 
2826:         *-- getFcusto: fator de custo moeda2 (top=517, left=161, w=115, h=23)
2827:         loc_oPg.AddObject("txt_4c_Fcusto", "TextBox")
2828:         WITH loc_oPg.txt_4c_Fcusto
2829:             .Value     = 0
2830:             .Top       = 517
2831:             .Left      = 161
2832:             .Width     = 115
2833:             .Height    = 23
2834:             .FontName  = "Tahoma"
2835:             .FontSize  = 8
2836:             .InputMask = "99999,999.99999"
2837:             .Themes    = .F.
2838:             .Visible   = .T.
2839:         ENDWITH
2840:         BINDEVENT(loc_oPg.txt_4c_Fcusto, "LostFocus", THIS, "TxtFcustoValid")
2841: 
2842:         *-- Say8: "Total " (top=542, left=161, w=29, h=15)
2843:         loc_oPg.AddObject("lbl_4c_Say8", "Label")
2844:         WITH loc_oPg.lbl_4c_Say8
2845:             .Caption   = "Total "
2846:             .Top       = 542
2847:             .Left      = 161
2848:             .Width     = 29
2849:             .Height    = 15
2850:             .BackStyle = 0
2851:             .ForeColor = RGB(90, 90, 90)
2852:             .FontName  = "Tahoma"
2853:             .FontSize  = 8
2854:             .Visible   = .T.
2855:         ENDWITH
2856: 
2857:         *-- getMoecusf: moeda custo fator (top=557, left=279, w=31, h=23)
2858:         loc_oPg.AddObject("txt_4c_Moecusf", "TextBox")
2859:         WITH loc_oPg.txt_4c_Moecusf
2860:             .Value    = ""
2861:             .Top      = 557
2862:             .Left     = 279
2863:             .Width    = 31
2864:             .Height   = 23
2865:             .FontName = "Tahoma"
2866:             .FontSize = 8
2867:             .ReadOnly = .T.
2868:             .BackColor = RGB(224, 235, 235)
2869:             .Themes   = .F.
2870:             .Visible  = .T.
2871:         ENDWITH
2872: 
2873:         *-- getCustof: custo total fatorado (top=557, left=161, w=115, h=23)
2874:         loc_oPg.AddObject("txt_4c_Custof", "TextBox")
2875:         WITH loc_oPg.txt_4c_Custof
2876:             .Value     = 0
2877:             .Top       = 557
2878:             .Left      = 161
2879:             .Width     = 115
2880:             .Height    = 23

*-- Linhas 2932 a 3006:
2932:             .BackColor     = RGB(255, 255, 255)
2933:             .Visible       = .T.
2934:         ENDWITH
2935:         BINDEVENT(loc_oPg.cmd_4c_PesoM, "Click", THIS, "CmdPesoMClick")
2936: 
2937:         *-- Say7: "Cotacao" (top=581, left=161, w=42, h=15)
2938:         loc_oPg.AddObject("lbl_4c_Say7", "Label")
2939:         WITH loc_oPg.lbl_4c_Say7
2940:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
2941:             .Top       = 581
2942:             .Left      = 161
2943:             .Width     = 42
2944:             .Height    = 15
2945:             .BackStyle = 0
2946:             .ForeColor = RGB(90, 90, 90)
2947:             .FontName  = "Tahoma"
2948:             .FontSize  = 8
2949:             .Visible   = .T.
2950:         ENDWITH
2951: 
2952:         *-- GetCotaCalcP: cotacao calculada (top=596, left=161, w=115, h=23)
2953:         loc_oPg.AddObject("txt_4c_CotaCalcP", "TextBox")
2954:         WITH loc_oPg.txt_4c_CotaCalcP
2955:             .Value     = 0
2956:             .Top       = 596
2957:             .Left      = 161
2958:             .Width     = 115
2959:             .Height    = 23
2960:             .FontName  = "Tahoma"
2961:             .FontSize  = 8
2962:             .InputMask = "99999.999999"
2963:             .Themes    = .F.
2964:             .Visible   = .T.
2965:         ENDWITH
2966:         BINDEVENT(loc_oPg.txt_4c_CotaCalcP, "LostFocus", THIS, "TxtCotaCalcPValid")
2967: 
2968:         *-- ===================================================================
2969:         *-- SECAO CUSTO - MKP e Fator (lado custo)
2970:         *-- ===================================================================
2971: 
2972:         *-- Say22: "MKP" (top=542, left=9, w=22, h=15)
2973:         loc_oPg.AddObject("lbl_4c_Say22", "Label")
2974:         WITH loc_oPg.lbl_4c_Say22
2975:             .Caption   = "MKP"
2976:             .Top       = 542
2977:             .Left      = 9
2978:             .Width     = 22
2979:             .Height    = 15
2980:             .BackStyle = 0
2981:             .ForeColor = RGB(90, 90, 90)
2982:             .FontName  = "Tahoma"
2983:             .FontSize  = 8
2984:             .Visible   = .T.
2985:         ENDWITH
2986: 
2987:         *-- Get_cmkpc: MKP custo (top=557, left=9, w=24, h=23)
2988:         loc_oPg.AddObject("txt_4c_Cftiocs", "TextBox")
2989:         WITH loc_oPg.txt_4c_Cftiocs
2990:             .Value    = ""
2991:             .Top      = 557
2992:             .Left     = 9
2993:             .Width    = 24
2994:             .Height   = 23
2995:             .FontName = "Tahoma"
2996:             .FontSize = 8
2997:             .ReadOnly = .T.
2998:             .BackColor = RGB(224, 235, 235)
2999:             .Themes   = .F.
3000:             .Visible  = .T.
3001:         ENDWITH
3002: 
3003:         *-- lblValAdics: "Valor Adicional" (top=542, left=64, w=71, h=15)
3004:         loc_oPg.AddObject("lbl_4c_LblValAdics", "Label")
3005:         WITH loc_oPg.lbl_4c_LblValAdics
3006:             .Caption   = "Valor Adicional"

*-- Linhas 3065 a 3124:
3065:             .Themes    = .F.
3066:             .Visible   = .T.
3067:         ENDWITH
3068:         BINDEVENT(loc_oPg.txt_4c_Margem, "LostFocus", THIS, "TxtMargemValid")
3069: 
3070:         *-- getMarkupA: markup aplicado (top=596, left=323, w=62, h=23)
3071:         loc_oPg.AddObject("txt_4c_MarkupA", "TextBox")
3072:         WITH loc_oPg.txt_4c_MarkupA
3073:             .Value     = 0
3074:             .Top       = 596
3075:             .Left      = 323
3076:             .Width     = 62
3077:             .Height    = 23
3078:             .FontName  = "Tahoma"
3079:             .FontSize  = 8
3080:             .InputMask = "9999.999"
3081:             .Themes    = .F.
3082:             .Visible   = .T.
3083:         ENDWITH
3084:         BINDEVENT(loc_oPg.txt_4c_MarkupA, "LostFocus", THIS, "TxtMarkupAValid")
3085: 
3086:         *-- lblMkpApl: "MKP Aplic." (top=581, left=324, w=51, h=15)
3087:         loc_oPg.AddObject("lbl_4c_LblMkpApl", "Label")
3088:         WITH loc_oPg.lbl_4c_LblMkpApl
3089:             .Caption   = "MKP Aplic."
3090:             .Top       = 581
3091:             .Left      = 324
3092:             .Width     = 51
3093:             .Height    = 15
3094:             .BackStyle = 0
3095:             .ForeColor = RGB(90, 90, 90)
3096:             .FontName  = "Tahoma"
3097:             .FontSize  = 8
3098:             .Visible   = .T.
3099:         ENDWITH
3100: 
3101:         *-- Say14: "MKP" (top=542, left=360, w=22, h=15) - FT/IO custo
3102:         loc_oPg.AddObject("lbl_4c_Say14", "Label")
3103:         WITH loc_oPg.lbl_4c_Say14
3104:             .Caption   = "MKP"
3105:             .Top       = 542
3106:             .Left      = 360
3107:             .Width     = 22
3108:             .Height    = 15
3109:             .BackStyle = 0
3110:             .ForeColor = RGB(90, 90, 90)
3111:             .FontName  = "Tahoma"
3112:             .FontSize  = 8
3113:             .Visible   = .T.
3114:         ENDWITH
3115: 
3116:         *-- Getftio: fator tipo IO custo (top=557, left=360, w=24, h=23)
3117:         loc_oPg.AddObject("txt_4c_Cftios", "TextBox")
3118:         WITH loc_oPg.txt_4c_Cftios
3119:             .Value    = ""
3120:             .Top      = 557
3121:             .Left     = 360
3122:             .Width    = 24
3123:             .Height   = 23
3124:             .FontName = "Tahoma"

*-- Linhas 3195 a 3238:
3195:             .Themes   = .F.
3196:             .Visible  = .T.
3197:         ENDWITH
3198:         BINDEVENT(loc_oPg.txt_4c_Moeda, "KeyPress", THIS, "TxtMoedaKeyPress")
3199: 
3200:         *-- getPvideal: preco de venda ideal (top=517, left=416, w=110, h=23)
3201:         loc_oPg.AddObject("txt_4c_Pvideal", "TextBox")
3202:         WITH loc_oPg.txt_4c_Pvideal
3203:             .Value     = 0
3204:             .Top       = 517
3205:             .Left      = 416
3206:             .Width     = 110
3207:             .Height    = 23
3208:             .FontName  = "Tahoma"
3209:             .FontSize  = 8
3210:             .InputMask = "99999,999.99999"
3211:             .Themes    = .F.
3212:             .Visible   = .T.
3213:         ENDWITH
3214: 
3215:         *-- lblFIdeals: "Fator Ideal" (top=503, left=563, w=55, h=15)
3216:         loc_oPg.AddObject("lbl_4c_LblFIdeals", "Label")
3217:         WITH loc_oPg.lbl_4c_LblFIdeals
3218:             .Caption   = "Fator Ideal"
3219:             .Top       = 503
3220:             .Left      = 563
3221:             .Width     = 55
3222:             .Height    = 15
3223:             .BackStyle = 0
3224:             .ForeColor = RGB(90, 90, 90)
3225:             .FontName  = "Tahoma"
3226:             .FontSize  = 8
3227:             .Visible   = .T.
3228:         ENDWITH
3229: 
3230:         *-- getFIdeals: fator ideal (top=517, left=563, w=110, h=23)
3231:         loc_oPg.AddObject("txt_4c_Fideals", "TextBox")
3232:         WITH loc_oPg.txt_4c_Fideals
3233:             .Value     = 0
3234:             .Top       = 517
3235:             .Left      = 563
3236:             .Width     = 110
3237:             .Height    = 23
3238:             .FontName  = "Tahoma"

*-- Linhas 3350 a 3393:
3350:             .Themes   = .F.
3351:             .Visible  = .T.
3352:         ENDWITH
3353:         BINDEVENT(loc_oPg.txt_4c_Moepv, "KeyPress", THIS, "TxtMoepvKeyPress")
3354: 
3355:         *-- getPven: preco de venda (top=596, left=416, w=110, h=23)
3356:         loc_oPg.AddObject("txt_4c_Pvens", "TextBox")
3357:         WITH loc_oPg.txt_4c_Pvens
3358:             .Value     = 0
3359:             .Top       = 596
3360:             .Left      = 416
3361:             .Width     = 110
3362:             .Height    = 23
3363:             .FontName  = "Tahoma"
3364:             .FontSize  = 8
3365:             .InputMask = "99999,999.99999"
3366:             .Themes    = .F.
3367:             .Visible   = .T.
3368:         ENDWITH
3369: 
3370:         *-- lblFAtuals: "Fator Atual" (top=581, left=563, w=56, h=15)
3371:         loc_oPg.AddObject("lbl_4c_LblFAtuals", "Label")
3372:         WITH loc_oPg.lbl_4c_LblFAtuals
3373:             .Caption   = "Fator Atual"
3374:             .Top       = 581
3375:             .Left      = 563
3376:             .Width     = 56
3377:             .Height    = 15
3378:             .BackStyle = 0
3379:             .ForeColor = RGB(90, 90, 90)
3380:             .FontName  = "Tahoma"
3381:             .FontSize  = 8
3382:             .Visible   = .T.
3383:         ENDWITH
3384: 
3385:         *-- getMoev: moeda venda atual (top=596, left=529, w=31, h=23)
3386:         loc_oPg.AddObject("txt_4c_Moevs", "TextBox")
3387:         WITH loc_oPg.txt_4c_Moevs
3388:             .Value    = ""
3389:             .Top      = 596
3390:             .Left     = 529
3391:             .Width    = 31
3392:             .Height   = 23
3393:             .FontName = "Tahoma"

*-- Linhas 3466 a 3509:
3466:             .BackColor     = RGB(255, 255, 255)
3467:             .Visible       = .T.
3468:         ENDWITH
3469:         BINDEVENT(loc_oPg.cmd_4c_CalcVals, "Click", THIS, "CmdCalcValsClick")
3470: 
3471:         *-- ===================================================================
3472:         *-- COMMANDGROUP cmdgCompo - 5 botoes (top=145, left=947, w=50, h=210)
3473:         *-- ===================================================================
3474:         loc_oPg.AddObject("obj_4c_CmdgCompo", "CommandGroup")
3475:         WITH loc_oPg.obj_4c_CmdgCompo
3476:             .ButtonCount   = 5
3477:             .BorderStyle   = 0
3478:             .Top           = 145
3479:             .Left          = 947
3480:             .Width         = 50
3481:             .Height        = 210
3482:             .BackColor     = RGB(162, 214, 242)
3483:             .Themes        = .F.
3484:             .Visible       = .T.
3485:         ENDWITH
3486:         WITH loc_oPg.obj_4c_CmdgCompo
3487:             .Buttons(1).Top          = 5
3488:             .Buttons(1).Left         = 5
3489:             .Buttons(1).Height       = 40
3490:             .Buttons(1).Width        = 40
3491:             .Buttons(1).Caption      = ""
3492:             .Buttons(1).Picture      = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
3493:             .Buttons(1).ToolTipText  = "Inserir Item"
3494:             .Buttons(1).SpecialEffect = 0
3495:             .Buttons(1).BackColor    = RGB(255, 255, 255)
3496:             .Buttons(1).ForeColor    = RGB(0, 0, 0)
3497:             .Buttons(1).Themes       = .F.
3498:             .Buttons(2).Top          = 45
3499:             .Buttons(2).Left         = 5
3500:             .Buttons(2).Height       = 40
3501:             .Buttons(2).Width        = 40
3502:             .Buttons(2).Caption      = ""
3503:             .Buttons(2).Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3504:             .Buttons(2).ToolTipText  = "Excluir Item"
3505:             .Buttons(2).SpecialEffect = 0
3506:             .Buttons(2).BackColor    = RGB(255, 255, 255)
3507:             .Buttons(2).ForeColor    = RGB(0, 0, 0)
3508:             .Buttons(2).Themes       = .F.
3509:             .Buttons(3).Top          = 85

*-- Linhas 3536 a 3630:
3536:             .Buttons(5).BackColor    = RGB(255, 255, 255)
3537:             .Buttons(5).Themes       = .F.
3538:         ENDWITH
3539:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo, "Click", THIS, "CmdgCompoClick")
3540: 
3541:         *-- ===================================================================
3542:         *-- COMMANDGROUP cmdgSubCp - 2 botoes (top=345, left=947, w=50, h=90)
3543:         *-- ===================================================================
3544:         loc_oPg.AddObject("obj_4c_CmdgSubCp", "CommandGroup")
3545:         WITH loc_oPg.obj_4c_CmdgSubCp
3546:             .ButtonCount   = 2
3547:             .BorderStyle   = 0
3548:             .Top           = 345
3549:             .Left          = 947
3550:             .Width         = 50
3551:             .Height        = 90
3552:             .BackColor     = RGB(162, 214, 242)
3553:             .Themes        = .F.
3554:             .Visible       = .T.
3555:         ENDWITH
3556:         WITH loc_oPg.obj_4c_CmdgSubCp
3557:             .Buttons(1).Top          = 5
3558:             .Buttons(1).Left         = 5
3559:             .Buttons(1).Height       = 40
3560:             .Buttons(1).Width        = 40
3561:             .Buttons(1).Caption      = ""
3562:             .Buttons(1).Picture      = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
3563:             .Buttons(1).ToolTipText  = "Inserir Item"
3564:             .Buttons(1).SpecialEffect = 0
3565:             .Buttons(1).BackColor    = RGB(255, 255, 255)
3566:             .Buttons(1).ForeColor    = RGB(0, 0, 0)
3567:             .Buttons(1).Themes       = .F.
3568:             .Buttons(2).Top          = 45
3569:             .Buttons(2).Left         = 5
3570:             .Buttons(2).Height       = 40
3571:             .Buttons(2).Width        = 40
3572:             .Buttons(2).Caption      = ""
3573:             .Buttons(2).Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3574:             .Buttons(2).ToolTipText  = "Excluir Item"
3575:             .Buttons(2).SpecialEffect = 0
3576:             .Buttons(2).BackColor    = RGB(255, 255, 255)
3577:             .Buttons(2).ForeColor    = RGB(0, 0, 0)
3578:             .Buttons(2).Themes       = .F.
3579:         ENDWITH
3580:         BINDEVENT(loc_oPg.obj_4c_CmdgSubCp, "Click", THIS, "CmdgSubCpClick")
3581: 
3582:     ENDPROC
3583: 
3584:     *--------------------------------------------------------------------------
3585:     * ConfigurarPgpgDadosFiscais - Aba "Dados Fiscais" do PageFrame interno (pgDadosFiscais)
3586:     * Fase 13: Sub-pagina Dados Fiscais - 54 controles do original
3587:     * Posicoes: valores do layout.json (pgf_4c_Dados.Tabs=.F. -> sem +29)
3588:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
3589:     *--------------------------------------------------------------------------
3590:     PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais(par_oPage)
3591:         LOCAL loc_oPg, loc_oGrd
3592:         loc_oPg = par_oPage
3593: 
3594:         *-- ===================================================================
3595:         *-- CURSOR PLACEHOLDER (criar ANTES do grid)
3596:         *-- ===================================================================
3597: 
3598:         *-- cursor_4c_Cmv - historico valor do grama produzido (grdCmv)
3599:         IF USED("cursor_4c_Cmv")
3600:             USE IN cursor_4c_Cmv
3601:         ENDIF
3602:         SET NULL ON
3603:         CREATE CURSOR cursor_4c_Cmv ( ;
3604:             datas    C(7), ;
3605:             valcuss  N(10,2), ;
3606:             moedas   C(3))
3607:         SET NULL OFF
3608: 
3609:         *-- ===================================================================
3610:         *-- LABELS
3611:         *-- ===================================================================
3612: 
3613:         *-- Say16: Grupo C.C.
3614:         loc_oPg.AddObject("lbl_4c_Say16", "Label")
3615:         WITH loc_oPg.lbl_4c_Say16
3616:             .Caption  = "Grupo C.C. :"
3617:             .Top      = 165
3618:             .Left     = 138
3619:             .Width    = 63
3620:             .Height   = 15
3621:             .FontName = "Tahoma"
3622:             .FontSize = 8
3623:             .AutoSize = .F.
3624:             .Visible  = .T.
3625:         ENDWITH
3626: 
3627:         *-- Say17: Conta C.C.
3628:         loc_oPg.AddObject("lbl_4c_Say17", "Label")
3629:         WITH loc_oPg.lbl_4c_Say17
3630:             .Caption  = "Conta C.C. :"

*-- Linhas 3900 a 4201:
3900:             .InputMask = "!!!!!!!!!!"
3901:             .Visible   = .T.
3902:         ENDWITH
3903:         BINDEVENT(loc_oPg.txt_4c_Gruccus, "KeyPress", THIS, "TxtGruccusKeyPress")
3904:         BINDEVENT(loc_oPg.txt_4c_Gruccus, "DblClick", THIS, "AbrirLookupGruccus")
3905: 
3906:         *-- get_dgruccus (txt_4c_Dgruccus): Grupo C.C. descricao - T:161, L:288, W:318, H:23
3907:         loc_oPg.AddObject("txt_4c_Dgruccus", "TextBox")
3908:         WITH loc_oPg.txt_4c_Dgruccus
3909:             .Value    = ""
3910:             .Top      = 161
3911:             .Left     = 288
3912:             .Width    = 318
3913:             .Height   = 23
3914:             .FontName = "Tahoma"
3915:             .FontSize = 8
3916:             .Visible  = .T.
3917:         ENDWITH
3918:         BINDEVENT(loc_oPg.txt_4c_Dgruccus, "KeyPress", THIS, "TxtDgruccusKeyPress")
3919:         BINDEVENT(loc_oPg.txt_4c_Dgruccus, "DblClick", THIS, "AbrirLookupDgruccus")
3920: 
3921:         *-- get_contaccus (txt_4c_Contaccus): Conta C.C. codigo - T:186, L:206, W:80, H:23
3922:         loc_oPg.AddObject("txt_4c_Contaccus", "TextBox")
3923:         WITH loc_oPg.txt_4c_Contaccus
3924:             .Value     = ""
3925:             .Top       = 186
3926:             .Left      = 206
3927:             .Width     = 80
3928:             .Height    = 23
3929:             .FontName  = "Tahoma"
3930:             .FontSize  = 8
3931:             .InputMask = "!!!!!!!!!!"
3932:             .Visible   = .T.
3933:         ENDWITH
3934:         BINDEVENT(loc_oPg.txt_4c_Contaccus, "KeyPress", THIS, "TxtContaccusKeyPress")
3935:         BINDEVENT(loc_oPg.txt_4c_Contaccus, "DblClick", THIS, "AbrirLookupContaccus")
3936: 
3937:         *-- get_dcontaccus (txt_4c_Dcontaccus): Conta C.C. descricao - T:186, L:288, W:318, H:23
3938:         loc_oPg.AddObject("txt_4c_Dcontaccus", "TextBox")
3939:         WITH loc_oPg.txt_4c_Dcontaccus
3940:             .Value    = ""
3941:             .Top      = 186
3942:             .Left     = 288
3943:             .Width    = 318
3944:             .Height   = 23
3945:             .FontName = "Tahoma"
3946:             .FontSize = 8
3947:             .Visible  = .T.
3948:         ENDWITH
3949:         BINDEVENT(loc_oPg.txt_4c_Dcontaccus, "KeyPress", THIS, "TxtDcontaccusKeyPress")
3950:         BINDEVENT(loc_oPg.txt_4c_Dcontaccus, "DblClick", THIS, "AbrirLookupDcontaccus")
3951: 
3952:         *-- ===================================================================
3953:         *-- TEXTBOXES - Classificacao Fiscal (NCM)
3954:         *-- ===================================================================
3955: 
3956:         *-- getClfiscal (txt_4c_Clfiscal): NCM codigo - T:211, L:206, W:94, H:23
3957:         loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
3958:         WITH loc_oPg.txt_4c_Clfiscal
3959:             .Value     = ""
3960:             .Top       = 211
3961:             .Left      = 206
3962:             .Width     = 94
3963:             .Height    = 23
3964:             .FontName  = "Tahoma"
3965:             .FontSize  = 8
3966:             .InputMask = "9999.99.99"
3967:             .Visible   = .T.
3968:         ENDWITH
3969:         BINDEVENT(loc_oPg.txt_4c_Clfiscal, "KeyPress", THIS, "TxtClfiscalKeyPress")
3970:         BINDEVENT(loc_oPg.txt_4c_Clfiscal, "DblClick", THIS, "AbrirLookupClfiscal")
3971: 
3972:         *-- getDclfiscal (txt_4c_Dclfiscal): NCM descricao - T:211, L:303, W:303, H:23
3973:         loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
3974:         WITH loc_oPg.txt_4c_Dclfiscal
3975:             .Value    = ""
3976:             .Top      = 211
3977:             .Left     = 303
3978:             .Width    = 303
3979:             .Height   = 23
3980:             .FontName = "Tahoma"
3981:             .FontSize = 8
3982:             .Visible  = .T.
3983:         ENDWITH
3984:         BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "KeyPress", THIS, "TxtDclfiscalKeyPress")
3985:         BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "DblClick", THIS, "AbrirLookupDclfiscal")
3986: 
3987:         *-- ===================================================================
3988:         *-- TEXTBOXES - Origem da Mercadoria
3989:         *-- ===================================================================
3990: 
3991:         *-- getOrigmerc (txt_4c_Origmerc): Origem codigo - T:236, L:206, W:17, H:23
3992:         loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
3993:         WITH loc_oPg.txt_4c_Origmerc
3994:             .Value     = ""
3995:             .Top       = 236
3996:             .Left      = 206
3997:             .Width     = 17
3998:             .Height    = 23
3999:             .FontName  = "Tahoma"
4000:             .FontSize  = 8
4001:             .MaxLength = 1
4002:             .Visible   = .T.
4003:         ENDWITH
4004:         BINDEVENT(loc_oPg.txt_4c_Origmerc, "KeyPress", THIS, "TxtOrigmercKeyPress")
4005:         BINDEVENT(loc_oPg.txt_4c_Origmerc, "DblClick", THIS, "AbrirLookupOrigmerc")
4006: 
4007:         *-- getDorigmerc (txt_4c_Dorigmerc): Origem descricao - T:236, L:226, W:380, H:23
4008:         loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")
4009:         WITH loc_oPg.txt_4c_Dorigmerc
4010:             .Value    = ""
4011:             .Top      = 236
4012:             .Left     = 226
4013:             .Width    = 380
4014:             .Height   = 23
4015:             .FontName = "Tahoma"
4016:             .FontSize = 8
4017:             .Visible  = .T.
4018:         ENDWITH
4019:         BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "KeyPress", THIS, "TxtDorigmercKeyPress")
4020:         BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "DblClick", THIS, "AbrirLookupDorigmerc")
4021: 
4022:         *-- ===================================================================
4023:         *-- TEXTBOXES - Situacao Tributaria ICMS
4024:         *-- ===================================================================
4025: 
4026:         *-- getSittricm (txt_4c_Sittricm): ICMS codigo - T:261, L:206, W:31, H:23
4027:         loc_oPg.AddObject("txt_4c_Sittricm", "TextBox")
4028:         WITH loc_oPg.txt_4c_Sittricm
4029:             .Value     = ""
4030:             .Top       = 261
4031:             .Left      = 206
4032:             .Width     = 31
4033:             .Height    = 23
4034:             .FontName  = "Tahoma"
4035:             .FontSize  = 8
4036:             .InputMask = "!!!"
4037:             .Visible   = .T.
4038:         ENDWITH
4039:         BINDEVENT(loc_oPg.txt_4c_Sittricm, "KeyPress", THIS, "TxtSittricmKeyPress")
4040:         BINDEVENT(loc_oPg.txt_4c_Sittricm, "DblClick", THIS, "AbrirLookupSittricm")
4041: 
4042:         *-- getDsittricm (txt_4c_Dsittricm): ICMS descricao - T:261, L:240, W:366, H:23
4043:         loc_oPg.AddObject("txt_4c_Dsittricm", "TextBox")
4044:         WITH loc_oPg.txt_4c_Dsittricm
4045:             .Value    = ""
4046:             .Top      = 261
4047:             .Left     = 240
4048:             .Width    = 366
4049:             .Height   = 23
4050:             .FontName = "Tahoma"
4051:             .FontSize = 8
4052:             .Visible  = .T.
4053:         ENDWITH
4054:         BINDEVENT(loc_oPg.txt_4c_Dsittricm, "KeyPress", THIS, "TxtDsittricmKeyPress")
4055:         BINDEVENT(loc_oPg.txt_4c_Dsittricm, "DblClick", THIS, "AbrirLookupDsittricm")
4056: 
4057:         *-- ===================================================================
4058:         *-- TEXTBOXES - Linha de Servicos ICMS, Aliquotas, Tipo, IAT
4059:         *-- ===================================================================
4060: 
4061:         *-- Get_CodServs (txt_4c_CodServs): Codigo de Servicos - T:286, L:206, W:38, H:23
4062:         loc_oPg.AddObject("txt_4c_CodServs", "TextBox")
4063:         WITH loc_oPg.txt_4c_CodServs
4064:             .Value     = ""
4065:             .Top       = 286
4066:             .Left      = 206
4067:             .Width     = 38
4068:             .Height    = 23
4069:             .FontName  = "Tahoma"
4070:             .FontSize  = 8
4071:             .InputMask = "!!!"
4072:             .Visible   = .T.
4073:         ENDWITH
4074:         BINDEVENT(loc_oPg.txt_4c_CodServs, "KeyPress", THIS, "TxtCodServsKeyPress")
4075:         BINDEVENT(loc_oPg.txt_4c_CodServs, "DblClick", THIS, "AbrirLookupCodServs")
4076: 
4077:         *-- getIcms (txt_4c_Icms): Aliquota ICMS - T:286, L:342, W:45, H:23
4078:         loc_oPg.AddObject("txt_4c_Icms", "TextBox")
4079:         WITH loc_oPg.txt_4c_Icms
4080:             .Value     = 0
4081:             .Top       = 286
4082:             .Left      = 342
4083:             .Width     = 45
4084:             .Height    = 23
4085:             .FontName  = "Tahoma"
4086:             .FontSize  = 8
4087:             .InputMask = "999.99"
4088:             .Visible   = .T.
4089:         ENDWITH
4090: 
4091:         *-- Get_TpTrib (txt_4c_TpTrib): Tipo de Tributacao - T:286, L:513, W:38, H:23
4092:         loc_oPg.AddObject("txt_4c_TpTrib", "TextBox")
4093:         WITH loc_oPg.txt_4c_TpTrib
4094:             .Value     = ""
4095:             .Top       = 286
4096:             .Left      = 513
4097:             .Width     = 38
4098:             .Height    = 23
4099:             .FontName  = "Tahoma"
4100:             .FontSize  = 8
4101:             .InputMask = "!!!!"
4102:             .Visible   = .T.
4103:         ENDWITH
4104:         BINDEVENT(loc_oPg.txt_4c_TpTrib, "KeyPress", THIS, "TxtTpTribKeyPress")
4105:         BINDEVENT(loc_oPg.txt_4c_TpTrib, "DblClick", THIS, "AbrirLookupTpTrib")
4106: 
4107:         *-- getiat (txt_4c_Iat): IAT Arredondamento/Truncamento - T:286, L:589, W:17, H:23
4108:         loc_oPg.AddObject("txt_4c_Iat", "TextBox")
4109:         WITH loc_oPg.txt_4c_Iat
4110:             .Value     = ""
4111:             .Top       = 286
4112:             .Left      = 589
4113:             .Width     = 17
4114:             .Height    = 23
4115:             .FontName  = "Tahoma"
4116:             .FontSize  = 8
4117:             .MaxLength = 1
4118:             .InputMask = "!"
4119:             .Visible   = .T.
4120:         ENDWITH
4121:         BINDEVENT(loc_oPg.txt_4c_Iat, "LostFocus", THIS, "ValidarIat")
4122: 
4123:         *-- ===================================================================
4124:         *-- COMBOBOX - Situacao Tributaria IPI
4125:         *-- ===================================================================
4126: 
4127:         *-- cmbIpi (cbo_4c_CmbIpi): Sit. Trib. IPI - T:311, L:206, W:108, H:25
4128:         loc_oPg.AddObject("cbo_4c_CmbIpi", "ComboBox")
4129:         WITH loc_oPg.cbo_4c_CmbIpi
4130:             .Top      = 311
4131:             .Left     = 206
4132:             .Width    = 108
4133:             .Height   = 25
4134:             .FontName = "Tahoma"
4135:             .FontSize = 8
4136:             .Style    = 2
4137:             .Visible  = .T.
4138:         ENDWITH
4139:         loc_oPg.cbo_4c_CmbIpi.AddItem("")
4140:         loc_oPg.cbo_4c_CmbIpi.AddItem("Tributado")
4141:         loc_oPg.cbo_4c_CmbIpi.AddItem("Isento")
4142:         loc_oPg.cbo_4c_CmbIpi.AddItem("Outros")
4143: 
4144:         *-- ===================================================================
4145:         *-- TEXTBOXES - Aliquota IPI e Excecao TIPI
4146:         *-- ===================================================================
4147: 
4148:         *-- Get_AliqIPI (txt_4c_AliqIPI): Aliquota de IPI - T:311, L:425, W:45, H:25
4149:         loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
4150:         WITH loc_oPg.txt_4c_AliqIPI
4151:             .Value     = 0
4152:             .Top       = 311
4153:             .Left      = 425
4154:             .Width     = 45
4155:             .Height    = 25
4156:             .FontName  = "Tahoma"
4157:             .FontSize  = 8
4158:             .InputMask = "999.99"
4159:             .Visible   = .T.
4160:         ENDWITH
4161:         BINDEVENT(loc_oPg.txt_4c_AliqIPI, "LostFocus", THIS, "ValidarAliqIPI")
4162: 
4163:         *-- getextipi (txt_4c_Extipi): Excecao da TIPI - T:311, L:601, W:35, H:25
4164:         loc_oPg.AddObject("txt_4c_Extipi", "TextBox")
4165:         WITH loc_oPg.txt_4c_Extipi
4166:             .Value     = ""
4167:             .Top       = 311
4168:             .Left      = 601
4169:             .Width     = 35
4170:             .Height    = 25
4171:             .FontName  = "Tahoma"
4172:             .FontSize  = 8
4173:             .InputMask = "!!!!!"
4174:             .Visible   = .T.
4175:         ENDWITH
4176: 
4177:         *-- ===================================================================
4178:         *-- EDITBOX - Descricao Fiscal (memo)
4179:         *-- ===================================================================
4180: 
4181:         *-- mgetdescfi (obj_4c_Mgetdescfi): T:338, L:206, W:509, H:89
4182:         loc_oPg.AddObject("obj_4c_Mgetdescfi", "EditBox")
4183:         WITH loc_oPg.obj_4c_Mgetdescfi
4184:             .Value      = ""
4185:             .Top        = 338
4186:             .Left       = 206
4187:             .Width      = 509
4188:             .Height     = 89
4189:             .FontName   = "Tahoma"
4190:             .FontSize   = 8
4191:             .ScrollBars = 2
4192:             .Visible    = .T.
4193:         ENDWITH
4194: 
4195:         *-- ===================================================================
4196:         *-- COMMANDBUTTON - Gerar Descricao Fiscal
4197:         *-- ===================================================================
4198: 
4199:         *-- btnDescFis (cmd_4c_BtnDescFis): T:359, L:162, W:26, H:26
4200:         loc_oPg.AddObject("cmd_4c_BtnDescFis", "CommandButton")
4201:         WITH loc_oPg.cmd_4c_BtnDescFis

*-- Linhas 4209 a 4282:
4209:             .Themes   = .F.
4210:             .Visible  = .T.
4211:         ENDWITH
4212:         BINDEVENT(loc_oPg.cmd_4c_BtnDescFis, "Click", THIS, "CmdBtnDescFisClick")
4213: 
4214:         *-- ===================================================================
4215:         *-- GRID - Historico Valor do Grama Produzido (grdCmv)
4216:         *-- T:338, L:754, W:223, H:141, 3 colunas: Periodo / Valor Custo GR / Moe
4217:         *-- ===================================================================
4218: 
4219:         loc_oPg.AddObject("grd_4c_Dados", "Grid")
4220:         loc_oGrd = loc_oPg.grd_4c_Dados
4221:         WITH loc_oGrd
4222:             .Top         = 338
4223:             .Left        = 754
4224:             .Width       = 223
4225:             .Height      = 141
4226:             .FontName    = "Tahoma"
4227:             .FontSize    = 8
4228:             .RecordMark  = .F.
4229:             .DeleteMark  = .F.
4230:             .GridLines   = 3
4231:             .ReadOnly    = .T.
4232:             .RowHeight   = 16
4233:             .ScrollBars  = 2
4234:             .Themes      = .F.
4235:             .ColumnCount = 3
4236:             .Visible     = .T.
4237:         ENDWITH
4238: 
4239:         *-- Cabecalhos ANTES do RecordSource
4240:         loc_oGrd.Column1.Header1.Caption = "Per" + CHR(237) + "odo"
4241:         loc_oGrd.Column2.Header1.Caption = "Valor Custo GR"
4242:         loc_oGrd.Column3.Header1.Caption = "Moe"
4243: 
4244:         *-- Larguras das colunas
4245:         WITH loc_oGrd.Column1
4246:             .Width     = 60
4247:             .Movable   = .F.
4248:             .Resizable = .F.
4249:         ENDWITH
4250:         WITH loc_oGrd.Column2
4251:             .Width     = 120
4252:             .Movable   = .F.
4253:             .Resizable = .F.
4254:         ENDWITH
4255:         WITH loc_oGrd.Column3
4256:             .Width     = 40
4257:             .Movable   = .F.
4258:             .Resizable = .F.
4259:         ENDWITH
4260: 
4261:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
4262:         loc_oGrd.RecordSource = "cursor_4c_Cmv"
4263: 
4264:         *-- ControlSource APOS RecordSource (obrigatorio)
4265:         loc_oGrd.Column1.ControlSource = "cursor_4c_Cmv.datas"
4266:         loc_oGrd.Column2.ControlSource = "cursor_4c_Cmv.valcuss"
4267:         loc_oGrd.Column3.ControlSource = "cursor_4c_Cmv.moedas"
4268: 
4269:         *-- Reaplica larguras apos RecordSource (RecordSource pode resetar)
4270:         loc_oGrd.Column1.Width = 60
4271:         loc_oGrd.Column2.Width = 120
4272:         loc_oGrd.Column3.Width = 40
4273: 
4274:         *-- ===================================================================
4275:         *-- TEXTBOXES - Descricao ECF, Metal/Teor, Valor Estimado, IPPT/CST
4276:         *-- ===================================================================
4277: 
4278:         *-- getDescEcfs (txt_4c_DescEcfs): T:429, L:206, W:213, H:23
4279:         loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
4280:         WITH loc_oPg.txt_4c_DescEcfs
4281:             .Value    = ""
4282:             .Top      = 429

*-- Linhas 4301 a 4491:
4301:             .InputMask = "!!!!!!!!!!"
4302:             .Visible   = .T.
4303:         ENDWITH
4304:         BINDEVENT(loc_oPg.txt_4c_Metal, "KeyPress", THIS, "TxtMetalKeyPress")
4305:         BINDEVENT(loc_oPg.txt_4c_Metal, "DblClick", THIS, "AbrirLookupMetal")
4306: 
4307:         *-- Get_DesMetal (txt_4c_DesMetal): Metal descricao - T:429, L:564, W:150, H:23 (READ-ONLY)
4308:         loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
4309:         WITH loc_oPg.txt_4c_DesMetal
4310:             .Value    = ""
4311:             .Top      = 429
4312:             .Left     = 564
4313:             .Width    = 150
4314:             .Height   = 23
4315:             .FontName = "Tahoma"
4316:             .FontSize = 8
4317:             .ReadOnly = .T.
4318:             .Visible  = .T.
4319:         ENDWITH
4320: 
4321:         *-- getValor (txt_4c_Valor): Valor Estimado - T:454, L:206, W:108, H:23
4322:         loc_oPg.AddObject("txt_4c_Valor", "TextBox")
4323:         WITH loc_oPg.txt_4c_Valor
4324:             .Value     = 0
4325:             .Top       = 454
4326:             .Left      = 206
4327:             .Width     = 108
4328:             .Height    = 23
4329:             .FontName  = "Tahoma"
4330:             .FontSize  = 8
4331:             .InputMask = "9,999,999.9999"
4332:             .Visible   = .T.
4333:         ENDWITH
4334: 
4335:         *-- GetMvalor (txt_4c_Mvalor): Moeda do Valor Estimado - T:454, L:317, W:31, H:23
4336:         loc_oPg.AddObject("txt_4c_Mvalor", "TextBox")
4337:         WITH loc_oPg.txt_4c_Mvalor
4338:             .Value     = ""
4339:             .Top       = 454
4340:             .Left      = 317
4341:             .Width     = 31
4342:             .Height    = 23
4343:             .FontName  = "Tahoma"
4344:             .FontSize  = 8
4345:             .InputMask = "!!!"
4346:             .Visible   = .T.
4347:         ENDWITH
4348:         BINDEVENT(loc_oPg.txt_4c_Mvalor, "KeyPress", THIS, "TxtMvalorKeyPress")
4349:         BINDEVENT(loc_oPg.txt_4c_Mvalor, "DblClick", THIS, "AbrirLookupMvalor")
4350: 
4351:         *-- Get_teor (txt_4c_Teor): Teor codigo - T:454, L:537, W:24, H:23
4352:         loc_oPg.AddObject("txt_4c_Teor", "TextBox")
4353:         WITH loc_oPg.txt_4c_Teor
4354:             .Value     = ""
4355:             .Top       = 454
4356:             .Left      = 537
4357:             .Width     = 24
4358:             .Height    = 23
4359:             .FontName  = "Tahoma"
4360:             .FontSize  = 8
4361:             .InputMask = "!!!!!!!!!!"
4362:             .Visible   = .T.
4363:         ENDWITH
4364:         BINDEVENT(loc_oPg.txt_4c_Teor, "KeyPress", THIS, "TxtTeorKeyPress")
4365:         BINDEVENT(loc_oPg.txt_4c_Teor, "DblClick", THIS, "AbrirLookupTeor")
4366: 
4367:         *-- Get_DesTeor (txt_4c_DesTeor): Teor descricao - T:454, L:564, W:150, H:23 (READ-ONLY)
4368:         loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
4369:         WITH loc_oPg.txt_4c_DesTeor
4370:             .Value    = ""
4371:             .Top      = 454
4372:             .Left     = 564
4373:             .Width    = 150
4374:             .Height   = 23
4375:             .FontName = "Tahoma"
4376:             .FontSize = 8
4377:             .ReadOnly = .T.
4378:             .Visible  = .T.
4379:         ENDWITH
4380: 
4381:         *-- getIPPTCST (txt_4c_IPPTCST): IPPT/CST - T:479, L:206, W:108, H:23 (READ-ONLY)
4382:         loc_oPg.AddObject("txt_4c_IPPTCST", "TextBox")
4383:         WITH loc_oPg.txt_4c_IPPTCST
4384:             .Value    = ""
4385:             .Top      = 479
4386:             .Left     = 206
4387:             .Width    = 108
4388:             .Height   = 23
4389:             .FontName = "Tahoma"
4390:             .FontSize = 8
4391:             .ReadOnly = .T.
4392:             .Visible  = .T.
4393:         ENDWITH
4394: 
4395:     ENDPROC
4396: 
4397:     *--------------------------------------------------------------------------
4398:     * ConfigurarPgpgCusto - Aba "Custo" do PageFrame interno (pgCusto)
4399:     * Fase 10: Sub-pagina Custo - grdCompo 12 colunas, cmbTipos, cmdgCusto,
4400:     *          GradeGRUPO2 (totais por grupo), labels e shape
4401:     * Posicoes: valores do layout.json (pgf_4c_Dados.Tabs=.F. -> sem +29)
4402:     *--------------------------------------------------------------------------
4403:     PROTECTED PROCEDURE ConfigurarPgpgCusto(par_oPage)
4404:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
4405: 
4406:         loc_oPg = par_oPage
4407: 
4408:         *-- ===================================================================
4409:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
4410:         *-- ===================================================================
4411: 
4412:         *-- cursor_4c_CustoCompo - composicao custo (SIGPRCPO filtrado por tipo)
4413:         IF USED("cursor_4c_CustoCompo")
4414:             USE IN cursor_4c_CustoCompo
4415:         ENDIF
4416:         SET NULL OFF
4417:         CREATE CURSOR cursor_4c_CustoCompo ( ;
4418:             mats      C(14), dcompos C(40), unicompos C(3),  ;
4419:             pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
4420:             moeds     C(3), obscompos C(10), etiqs C(1),     ;
4421:             qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
4422:             CGrus     C(3), tipos C(20))
4423: 
4424:         *-- cursor_4c_TotGrupoCusto - totais por grupo custo (calculado)
4425:         IF USED("cursor_4c_TotGrupoCusto")
4426:             USE IN cursor_4c_TotGrupoCusto
4427:         ENDIF
4428:         SET NULL ON
4429:         CREATE CURSOR cursor_4c_TotGrupoCusto ( ;
4430:             Grupo     C(3), ValGrupo N(11,3), Moeda C(3))
4431:         SET NULL OFF
4432: 
4433:         *-- ===================================================================
4434:         *-- COMBO cbo_4c_CmbTipos (cmbTipos: top=154, left=143, w=187, h=23)
4435:         *-- ===================================================================
4436:         loc_oPg.AddObject("cbo_4c_CmbTipos", "ComboBox")
4437:         WITH loc_oPg.cbo_4c_CmbTipos
4438:             .Top           = 154
4439:             .Left          = 143
4440:             .Width         = 187
4441:             .Height        = 23
4442:             .FontName      = "Tahoma"
4443:             .FontSize      = 8
4444:             .RowSourceType = 1
4445:             .RowSource     = ""
4446:             .Style         = 2
4447:             .SpecialEffect = 1
4448:             .Themes        = .F.
4449:             .Visible       = .T.
4450:         ENDWITH
4451:         BINDEVENT(loc_oPg.cbo_4c_CmbTipos, "InteractiveChange", THIS, "CboTiposCustoInteractiveChange")
4452: 
4453:         *-- LABEL lbl_4c_Label1 (Say1 "Tipo :": top=159, left=112, w=29, h=15)
4454:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
4455:         WITH loc_oPg.lbl_4c_Label1
4456:             .Caption   = "Tipo :"
4457:             .Top       = 159
4458:             .Left      = 112
4459:             .Width     = 29
4460:             .Height    = 15
4461:             .BackStyle = 0
4462:             .ForeColor = RGB(90, 90, 90)
4463:             .FontName  = "Tahoma"
4464:             .FontSize  = 8
4465:             .Visible   = .T.
4466:         ENDWITH
4467: 
4468:         *-- ===================================================================
4469:         *-- GRID grd_4c_CustoCompo (grdCompo: top=178, left=34, w=813, h=230)
4470:         *-- 12 colunas de SIGPRCPO
4471:         *-- ===================================================================
4472:         loc_oPg.AddObject("grd_4c_CustoCompo", "Grid")
4473:         loc_oGrd = loc_oPg.grd_4c_CustoCompo
4474:         WITH loc_oGrd
4475:             .Top         = 178
4476:             .Left        = 34
4477:             .Width       = 813
4478:             .Height      = 230
4479:             .FontName    = "Tahoma"
4480:             .FontSize    = 8
4481:             .RecordMark  = .F.
4482:             .DeleteMark  = .F.
4483:             .GridLines   = 3
4484:             .ReadOnly    = .F.
4485:             .RowHeight   = 16
4486:             .ScrollBars  = 2
4487:             .Themes      = .F.
4488:             .ColumnCount = 12
4489:             .Visible     = .T.
4490:         ENDWITH
4491: 

*-- Linhas 4561 a 4595:
4561:             .Resizable = .F.
4562:             .ReadOnly  = .T.
4563:         ENDWITH
4564: 
4565:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
4566:         loc_oGrd.RecordSource = "cursor_4c_CustoCompo"
4567: 
4568:         *-- ControlSource APOS RecordSource (obrigatorio)
4569:         loc_oGrd.Column1.ControlSource  = "cursor_4c_CustoCompo.mats"
4570:         loc_oGrd.Column2.ControlSource  = "cursor_4c_CustoCompo.dcompos"
4571:         loc_oGrd.Column3.ControlSource  = "cursor_4c_CustoCompo.unicompos"
4572:         loc_oGrd.Column4.ControlSource  = "cursor_4c_CustoCompo.pcompos"
4573:         loc_oGrd.Column5.ControlSource  = "cursor_4c_CustoCompo.qtds"
4574:         loc_oGrd.Column6.ControlSource  = "cursor_4c_CustoCompo.totas"
4575:         loc_oGrd.Column7.ControlSource  = "cursor_4c_CustoCompo.moeds"
4576:         loc_oGrd.Column8.ControlSource  = "cursor_4c_CustoCompo.obscompos"
4577:         loc_oGrd.Column9.ControlSource  = "cursor_4c_CustoCompo.etiqs"
4578:         loc_oGrd.Column10.ControlSource = "cursor_4c_CustoCompo.qtscons"
4579:         loc_oGrd.Column11.ControlSource = "cursor_4c_CustoCompo.qtdcvs"
4580:         loc_oGrd.Column12.ControlSource = "cursor_4c_CustoCompo.cunips"
4581: 
4582:         *-- Cabecalhos APOS RecordSource
4583:         loc_oGrd.Column1.Header1.Caption  = "Item"
4584:         loc_oGrd.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
4585:         loc_oGrd.Column3.Header1.Caption  = "Un"
4586:         loc_oGrd.Column4.Header1.Caption  = "Valor"
4587:         loc_oGrd.Column5.Header1.Caption  = "Qtd"
4588:         loc_oGrd.Column6.Header1.Caption  = "Total"
4589:         loc_oGrd.Column7.Header1.Caption  = "Moe"
4590:         loc_oGrd.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
4591:         loc_oGrd.Column9.Header1.Caption  = "Etiq"
4592:         loc_oGrd.Column10.Header1.Caption = "Consumo"
4593:         loc_oGrd.Column11.Header1.Caption = "Qtd"
4594:         loc_oGrd.Column12.Header1.Caption = "Un"
4595: 

*-- Linhas 4607 a 4693:
4607:         loc_oGrd.Column11.Width = 59
4608:         loc_oGrd.Column12.Width = 24
4609: 
4610:         *-- BINDEVENT grd_4c_CustoCompo
4611:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdCustoCompoAfterRowColChange")
4612: 
4613:         *-- ===================================================================
4614:         *-- COMMANDGROUP obj_4c_CmdgCusto (cmdgCompo: top=240, left=851, w=50, h=90)
4615:         *-- 2 botoes: Inserir, Excluir
4616:         *-- ===================================================================
4617:         loc_oPg.AddObject("obj_4c_CmdgCusto", "CommandGroup")
4618:         WITH loc_oPg.obj_4c_CmdgCusto
4619:             .ButtonCount   = 2
4620:             .BorderStyle   = 0
4621:             .Top           = 240
4622:             .Left          = 851
4623:             .Width         = 50
4624:             .Height        = 90
4625:             .BackColor     = RGB(162, 214, 242)
4626:             .Themes        = .F.
4627:             .Visible       = .T.
4628:         ENDWITH
4629:         WITH loc_oPg.obj_4c_CmdgCusto
4630:             .Buttons(1).Top           = 5
4631:             .Buttons(1).Left          = 5
4632:             .Buttons(1).Height        = 40
4633:             .Buttons(1).Width         = 40
4634:             .Buttons(1).Caption       = ""
4635:             .Buttons(1).Picture       = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
4636:             .Buttons(1).ToolTipText   = "Inserir Item"
4637:             .Buttons(1).SpecialEffect = 0
4638:             .Buttons(1).BackColor     = RGB(255, 255, 255)
4639:             .Buttons(1).ForeColor     = RGB(0, 0, 0)
4640:             .Buttons(1).Themes        = .F.
4641:             .Buttons(2).Top           = 45
4642:             .Buttons(2).Left          = 5
4643:             .Buttons(2).Height        = 40
4644:             .Buttons(2).Width         = 40
4645:             .Buttons(2).Caption       = ""
4646:             .Buttons(2).Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
4647:             .Buttons(2).ToolTipText   = "Excluir Item"
4648:             .Buttons(2).SpecialEffect = 0
4649:             .Buttons(2).BackColor     = RGB(255, 255, 255)
4650:             .Buttons(2).ForeColor     = RGB(0, 0, 0)
4651:             .Buttons(2).Themes        = .F.
4652:         ENDWITH
4653:         BINDEVENT(loc_oPg.obj_4c_CmdgCusto, "Click", THIS, "CmdgCustoClick")
4654: 
4655:         *-- ===================================================================
4656:         *-- LABEL + TEXTBOX para descricao e grupo do item selecionado
4657:         *-- ===================================================================
4658: 
4659:         *-- LABEL lbl_4c_Label16 (Say16 "Descricao :": top=415, left=52, w=55, h=15)
4660:         loc_oPg.AddObject("lbl_4c_Label16", "Label")
4661:         WITH loc_oPg.lbl_4c_Label16
4662:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
4663:             .Top       = 415
4664:             .Left      = 52
4665:             .Width     = 55
4666:             .Height    = 15
4667:             .BackStyle = 0
4668:             .ForeColor = RGB(90, 90, 90)
4669:             .FontName  = "Tahoma"
4670:             .FontSize  = 8
4671:             .Visible   = .T.
4672:         ENDWITH
4673: 
4674:         *-- TEXTBOX txt_4c_Desc (Get_Desc: top=412, left=116, w=304, h=21, ReadOnly)
4675:         loc_oPg.AddObject("txt_4c_Desc", "TextBox")
4676:         WITH loc_oPg.txt_4c_Desc
4677:             .Value     = ""
4678:             .Top       = 412
4679:             .Left      = 116
4680:             .Width     = 304
4681:             .Height    = 21
4682:             .FontName  = "Tahoma"
4683:             .FontSize  = 8
4684:             .ReadOnly  = .T.
4685:             .BackColor = RGB(224, 235, 235)
4686:             .Themes    = .F.
4687:             .Visible   = .T.
4688:         ENDWITH
4689: 
4690:         *-- LABEL lbl_4c_Label2 (Say2 "Grupo :": top=415, left=479, w=38, h=15)
4691:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
4692:         WITH loc_oPg.lbl_4c_Label2
4693:             .Caption   = "Grupo :"

*-- Linhas 4813 a 4856:
4813:     * Ordem visual: Mats | Dcompos | Qtds | UniCompos | Grupos | Dscgrp | Ordems | QtsCons | Cats
4814:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
4815:     *--------------------------------------------------------------------------
4816:     PROTECTED PROCEDURE ConfigurarPgPgDadosConsP(par_oPage)
4817:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
4818: 
4819:         loc_oPg = par_oPage
4820: 
4821:         *-- ===================================================================
4822:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
4823:         *-- Campos na ORDEM VISUAL das colunas (sem ColumnOrder)
4824:         *-- ===================================================================
4825: 
4826:         *-- cursor_4c_GrdCons - consumo de produto (baseado em crSigPrCpo)
4827:         *-- Ordem: Mats(cod), Dcompos(desc), Qtds(qtde RO), UniCompos(uni RO),
4828:         *--        Grupos(fase), Dscgrp(desc fase), Ordems(ord RO), QtsCons(consumo), Cats(cat)
4829:         IF USED("cursor_4c_GrdCons")
4830:             USE IN cursor_4c_GrdCons
4831:         ENDIF
4832:         SET NULL ON
4833:         CREATE CURSOR cursor_4c_GrdCons ( ;
4834:             Mats      C(14), ;
4835:             Dcompos   C(40), ;
4836:             Qtds      N(12,4), ;
4837:             UniCompos C(3), ;
4838:             Grupos    C(3), ;
4839:             Dscgrp    C(40), ;
4840:             Ordems    N(3,0), ;
4841:             QtsCons   N(12,4), ;
4842:             Cats      C(3))
4843:         SET NULL OFF
4844: 
4845:         *-- cursor_4c_GrDTEMP - tempo por agrupamento (baseado em crSigProTp)
4846:         IF USED("cursor_4c_GrDTEMP")
4847:             USE IN cursor_4c_GrDTEMP
4848:         ENDIF
4849:         SET NULL ON
4850:         CREATE CURSOR cursor_4c_GrDTEMP ( ;
4851:             agrupas   C(3), ;
4852:             pertemps  N(12,3))
4853:         SET NULL OFF
4854: 
4855:         *-- ===================================================================
4856:         *-- GRID grd_4c_GrdCons

*-- Linhas 4973 a 5017:
4973:         loc_oGrd.Column8.Width = 60
4974:         loc_oGrd.Column9.Width = 52
4975: 
4976:         *-- BINDEVENT grd_4c_GrdCons
4977:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdConsAfterRowColChange")
4978: 
4979:         *-- ===================================================================
4980:         *-- GRID grd_4c_GrDTEMP (grDTEMP: top=519, left=821, w=172, h=107, 2 cols)
4981:         *-- ===================================================================
4982:         loc_oPg.AddObject("grd_4c_GrDTEMP", "Grid")
4983:         loc_oGrd2 = loc_oPg.grd_4c_GrDTEMP
4984:         WITH loc_oGrd2
4985:             .Top         = 519
4986:             .Left        = 821
4987:             .Width       = 172
4988:             .Height      = 107
4989:             .FontName    = "Tahoma"
4990:             .FontSize    = 8
4991:             .RecordMark  = .T.
4992:             .DeleteMark  = .F.
4993:             .GridLines   = 3
4994:             .ReadOnly    = .T.
4995:             .RowHeight   = 17
4996:             .ScrollBars  = 2
4997:             .Themes      = .F.
4998:             .ColumnCount = 2
4999:             .Visible     = .T.
5000:         ENDWITH
5001: 
5002:         *-- Col1: Agrupamento/agrupas (80px, ReadOnly)
5003:         WITH loc_oGrd2.Column1
5004:             .Width     = 80
5005:             .Movable   = .F.
5006:             .Resizable = .F.
5007:             .ReadOnly  = .T.
5008:         ENDWITH
5009:         *-- Col2: Tempo %/pertemps (60px, ReadOnly)
5010:         WITH loc_oGrd2.Column2
5011:             .Width      = 60
5012:             .Movable    = .F.
5013:             .Resizable  = .F.
5014:             .ReadOnly   = .T.
5015:             .InputMask  = "999,999,999.999"
5016:         ENDWITH
5017: 

*-- Linhas 5118 a 5161:
5118:     * ImgFigJpg (foto do processo), ImgBorracha (foto da matriz)
5119:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
5120:     *--------------------------------------------------------------------------
5121:     PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP(par_oPage)
5122:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
5123: 
5124:         loc_oPg = par_oPage
5125: 
5126:         *-- ===================================================================
5127:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
5128:         *-- Campos na ORDEM VISUAL das colunas (sem ColumnOrder)
5129:         *-- ===================================================================
5130: 
5131:         *-- cursor_4c_Fase - fases de processo (baseado em crSigCdPrf)
5132:         *-- Ordem visual: Ordems | Grupos | Descrs | UniPrdts | TpMats
5133:         IF USED("cursor_4c_Fase")
5134:             USE IN cursor_4c_Fase
5135:         ENDIF
5136:         SET NULL ON
5137:         CREATE CURSOR cursor_4c_Fase ( ;
5138:             Ordems    N(3,0), ;
5139:             Grupos    C(10), ;
5140:             Descrs    C(40), ;
5141:             UniPrdts  C(10), ;
5142:             TpMats    C(3), ;
5143:             FigProcs  M, ;
5144:             FkChaves  C(30), ;
5145:             GrpOrdem  C(12))
5146:         SET NULL OFF
5147: 
5148:         *-- cursor_4c_Matrizes - matrizes do produto (baseado em crSigPrMtz)
5149:         *-- Ordem visual: CMats | Locals | QMatz
5150:         IF USED("cursor_4c_Matrizes")
5151:             USE IN cursor_4c_Matrizes
5152:         ENDIF
5153:         SET NULL ON
5154:         CREATE CURSOR cursor_4c_Matrizes ( ;
5155:             CMats     C(14), ;
5156:             Locals    C(20), ;
5157:             QMatz     N(5,2), ;
5158:             CPros     C(14), ;
5159:             cIdChaves C(30), ;
5160:             DPros     C(40))
5161:         SET NULL OFF

*-- Linhas 5246 a 5375:
5246:         loc_oGrd.Column4.Width = 100
5247:         loc_oGrd.Column5.Width = 45
5248: 
5249:         *-- BINDEVENT grd_4c_FasePro
5250:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdFaseAfterRowColChange")
5251:         BINDEVENT(loc_oGrd.Column2.Text1, "Valid", THIS, "FaseGrdCol2Valid")
5252:         BINDEVENT(loc_oGrd.Column4.Text1, "Valid", THIS, "FaseGrdCol4Valid")
5253:         BINDEVENT(loc_oGrd.Column5.Text1, "Valid", THIS, "FaseGrdCol5Valid")
5254: 
5255:         *-- ===================================================================
5256:         *-- COMMANDBUTTON cmd_4c_Incluir (inserir: top=152, left=950, 30x30)
5257:         *-- ===================================================================
5258:         loc_oPg.AddObject("cmd_4c_InsFase", "CommandButton")
5259:         WITH loc_oPg.cmd_4c_InsFase
5260:             .Top             = 152
5261:             .Left            = 950
5262:             .Width           = 30
5263:             .Height          = 30
5264:             .Caption         = ""
5265:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
5266:             .PicturePosition = 13
5267:             .ToolTipText     = "Inserir Fase"
5268:             .FontName        = "Tahoma"
5269:             .FontSize        = 8
5270:             .Themes          = .F.
5271:             .SpecialEffect   = 0
5272:             .BackColor       = RGB(255, 255, 255)
5273:             .Visible         = .T.
5274:         ENDWITH
5275:         BINDEVENT(loc_oPg.cmd_4c_InsFase, "Click", THIS, "FaseInserirClick")
5276: 
5277:         *-- COMMANDBUTTON cmd_4c_ExcFase (excluir: top=192, left=950, 30x30)
5278:         loc_oPg.AddObject("cmd_4c_ExcFase", "CommandButton")
5279:         WITH loc_oPg.cmd_4c_ExcFase
5280:             .Top             = 192
5281:             .Left            = 950
5282:             .Width           = 30
5283:             .Height          = 30
5284:             .Caption         = ""
5285:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
5286:             .PicturePosition = 13
5287:             .ToolTipText     = "Excluir Fase"
5288:             .FontName        = "Tahoma"
5289:             .FontSize        = 8
5290:             .Themes          = .F.
5291:             .SpecialEffect   = 0
5292:             .BackColor       = RGB(255, 255, 255)
5293:             .Visible         = .T.
5294:         ENDWITH
5295:         BINDEVENT(loc_oPg.cmd_4c_ExcFase, "Click", THIS, "FaseExcluirClick")
5296: 
5297:         *-- COMMANDBUTTON cmd_4c_AltFase (Alternativa: top=232, left=950, 30x30)
5298:         loc_oPg.AddObject("cmd_4c_AltFase", "CommandButton")
5299:         WITH loc_oPg.cmd_4c_AltFase
5300:             .Top             = 232
5301:             .Left            = 950
5302:             .Width           = 30
5303:             .Height          = 30
5304:             .Caption         = ""
5305:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
5306:             .PicturePosition = 13
5307:             .ToolTipText     = "Fase Alternativa"
5308:             .FontName        = "Tahoma"
5309:             .FontSize        = 8
5310:             .Themes          = .F.
5311:             .SpecialEffect   = 0
5312:             .BackColor       = RGB(255, 255, 255)
5313:             .Visible         = .T.
5314:         ENDWITH
5315:         BINDEVENT(loc_oPg.cmd_4c_AltFase, "Click", THIS, "FaseAlternativaClick")
5316: 
5317:         *-- COMMANDBUTTON cmd_4c_CmdFicha (CmdFicha: top=152, left=482, 30x30)
5318:         loc_oPg.AddObject("cmd_4c_CmdFicha", "CommandButton")
5319:         WITH loc_oPg.cmd_4c_CmdFicha
5320:             .Top             = 152
5321:             .Left            = 482
5322:             .Width           = 30
5323:             .Height          = 30
5324:             .Caption         = ""
5325:             .Picture         = gc_4c_CaminhoIcones + "relatorio_visualizar_26.jpg"
5326:             .PicturePosition = 13
5327:             .ToolTipText     = "Ficha T" + CHR(233) + "cnica"
5328:             .FontName        = "Tahoma"
5329:             .FontSize        = 8
5330:             .Themes          = .F.
5331:             .SpecialEffect   = 0
5332:             .BackColor       = RGB(255, 255, 255)
5333:             .Visible         = .T.
5334:         ENDWITH
5335:         BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaClick")
5336: 
5337:         *-- ===================================================================
5338:         *-- LABEL + TEXTBOX: Say13/getQmin "Qtd. Min. Producao :" (top=156/152, left=33/137)
5339:         *-- ===================================================================
5340:         loc_oPg.AddObject("lbl_4c_Label13", "Label")
5341:         WITH loc_oPg.lbl_4c_Label13
5342:             .Caption   = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
5343:             .Top       = 156
5344:             .Left      = 33
5345:             .Width     = 102
5346:             .Height    = 15
5347:             .BackStyle = 0
5348:             .ForeColor = RGB(90, 90, 90)
5349:             .FontName  = "Tahoma"
5350:             .FontSize  = 8
5351:             .Visible   = .T.
5352:         ENDWITH
5353: 
5354:         loc_oPg.AddObject("txt_4c_Qmin", "TextBox")
5355:         WITH loc_oPg.txt_4c_Qmin
5356:             .Top           = 152
5357:             .Left          = 137
5358:             .Width         = 80
5359:             .Height        = 23
5360:             .FontName      = "Tahoma"
5361:             .FontSize      = 8
5362:             .SpecialEffect = 1
5363:             .Themes        = .F.
5364:             .ReadOnly      = .F.
5365:             .Alignment     = 3
5366:             .InputMask     = "99999.999"
5367:             .Value         = 0
5368:             .Visible       = .T.
5369:         ENDWITH
5370: 
5371:         *-- ===================================================================
5372:         *-- LABEL + TEXTBOX: Say5/getCodGarras "Garra :" (top=181/177, left=99/137)
5373:         *-- getCodGarras.When = .F. -> ReadOnly
5374:         *-- ===================================================================
5375:         loc_oPg.AddObject("lbl_4c_Label5", "Label")

*-- Linhas 5432 a 5475:
5432:             .Value         = ""
5433:             .Visible       = .T.
5434:         ENDWITH
5435:         BINDEVENT(loc_oPg.txt_4c_Conquilha, "LostFocus", THIS, "ValidarConquilha")
5436: 
5437:         *-- ===================================================================
5438:         *-- LABEL + TEXTBOX: Say9/getPesoBris "Peso Brilhante :" (top=231/227, left=58/137)
5439:         *-- ===================================================================
5440:         loc_oPg.AddObject("lbl_4c_Label9", "Label")
5441:         WITH loc_oPg.lbl_4c_Label9
5442:             .Caption   = "Peso Brilhante :"
5443:             .Top       = 231
5444:             .Left      = 58
5445:             .Width     = 77
5446:             .Height    = 15
5447:             .BackStyle = 0
5448:             .ForeColor = RGB(90, 90, 90)
5449:             .FontName  = "Tahoma"
5450:             .FontSize  = 8
5451:             .Visible   = .T.
5452:         ENDWITH
5453: 
5454:         loc_oPg.AddObject("txt_4c_PesoBris", "TextBox")
5455:         WITH loc_oPg.txt_4c_PesoBris
5456:             .Top           = 227
5457:             .Left          = 137
5458:             .Width         = 80
5459:             .Height        = 23
5460:             .FontName      = "Tahoma"
5461:             .FontSize      = 8
5462:             .SpecialEffect = 1
5463:             .Themes        = .F.
5464:             .ReadOnly      = .F.
5465:             .Alignment     = 3
5466:             .InputMask     = "999.9999"
5467:             .Value         = 0
5468:             .Visible       = .T.
5469:         ENDWITH
5470: 
5471:         *-- ===================================================================
5472:         *-- LABEL + TEXTBOX: Say10/getPesoMetal "Peso Metal :" (top=256/252, left=74/137)
5473:         *-- ===================================================================
5474:         loc_oPg.AddObject("lbl_4c_Label10", "Label")
5475:         WITH loc_oPg.lbl_4c_Label10

*-- Linhas 5567 a 5610:
5567:             .Value         = ""
5568:             .Visible       = .T.
5569:         ENDWITH
5570:         BINDEVENT(loc_oPg.txt_4c_Cor, "LostFocus", THIS, "ValidarCor")
5571: 
5572:         *-- ===================================================================
5573:         *-- CHECKBOX: opc_CravCera "Cravacao em Cera" (top=306, left=180)
5574:         *-- ===================================================================
5575:         loc_oPg.AddObject("chk_4c_CravCera", "CheckBox")
5576:         WITH loc_oPg.chk_4c_CravCera
5577:             .Caption       = "Crava" + CHR(231) + CHR(227) + "o em Cera"
5578:             .Top           = 306
5579:             .Left          = 180
5580:             .Width         = 110
5581:             .Height        = 15
5582:             .FontName      = "Tahoma"
5583:             .FontSize      = 8
5584:             .BackStyle     = 0
5585:             .Alignment     = 0
5586:             .AutoSize      = .T.
5587:             .SpecialEffect = 1
5588:             .ForeColor     = RGB(90, 90, 90)
5589:             .Themes        = .F.
5590:             .Value         = .F.
5591:             .Visible       = .T.
5592:         ENDWITH
5593: 
5594:         *-- ===================================================================
5595:         *-- LABEL + TEXTBOX: Say2/getTam "Tamanho Padrao :" (top=331/327, left=45/137)
5596:         *-- ===================================================================
5597:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
5598:         WITH loc_oPg.lbl_4c_Label2
5599:             .Caption   = "Tamanho Padr" + CHR(227) + "o :"
5600:             .Top       = 331
5601:             .Left      = 45
5602:             .Width     = 90
5603:             .Height    = 15
5604:             .BackStyle = 0
5605:             .ForeColor = RGB(90, 90, 90)
5606:             .FontName  = "Tahoma"
5607:             .FontSize  = 8
5608:             .Visible   = .T.
5609:         ENDWITH
5610: 

*-- Linhas 5622 a 5665:
5622:             .Value         = ""
5623:             .Visible       = .T.
5624:         ENDWITH
5625:         BINDEVENT(loc_oPg.txt_4c_Tam, "LostFocus", THIS, "ValidarTam")
5626: 
5627:         *-- ===================================================================
5628:         *-- CHECKBOX: fwoption1 "Peso Variavel" (top=331, left=180)
5629:         *-- ===================================================================
5630:         loc_oPg.AddObject("chk_4c_PesoVar", "CheckBox")
5631:         WITH loc_oPg.chk_4c_PesoVar
5632:             .Caption       = "Peso Vari" + CHR(225) + "vel"
5633:             .Top           = 331
5634:             .Left          = 180
5635:             .Width         = 90
5636:             .Height        = 15
5637:             .FontName      = "Tahoma"
5638:             .FontSize      = 8
5639:             .BackStyle     = 0
5640:             .Alignment     = 0
5641:             .AutoSize      = .T.
5642:             .SpecialEffect = 1
5643:             .ForeColor     = RGB(90, 90, 90)
5644:             .Themes        = .F.
5645:             .Value         = .F.
5646:             .Visible       = .T.
5647:         ENDWITH
5648: 
5649:         *-- ===================================================================
5650:         *-- LABEL + TEXTBOX: lblAcabamento/get_codacb/get_Dacb (top=356/352, left=16/137/177)
5651:         *-- get_Dacb.When = .F. -> ReadOnly (preenchido pelo lookup de codacb)
5652:         *-- ===================================================================
5653:         loc_oPg.AddObject("lbl_4c_LblAcabamento", "Label")
5654:         WITH loc_oPg.lbl_4c_LblAcabamento
5655:             .Caption   = "Acabamento :"
5656:             .Top       = 356
5657:             .Left      = 16
5658:             .Width     = 119
5659:             .Height    = 15
5660:             .BackStyle = 0
5661:             .ForeColor = RGB(90, 90, 90)
5662:             .FontName  = "Tahoma"
5663:             .FontSize  = 8
5664:             .Visible   = .T.
5665:         ENDWITH

*-- Linhas 5678 a 5821:
5678:             .Value         = ""
5679:             .Visible       = .T.
5680:         ENDWITH
5681:         BINDEVENT(loc_oPg.txt_4c_CodAcb, "LostFocus", THIS, "ValidarAcabamento")
5682: 
5683:         loc_oPg.AddObject("txt_4c_Dacb", "TextBox")
5684:         WITH loc_oPg.txt_4c_Dacb
5685:             .Top           = 352
5686:             .Left          = 177
5687:             .Width         = 207
5688:             .Height        = 23
5689:             .FontName      = "Tahoma"
5690:             .FontSize      = 8
5691:             .SpecialEffect = 1
5692:             .Themes        = .F.
5693:             .ReadOnly      = .T.
5694:             .Value         = ""
5695:             .Visible       = .T.
5696:         ENDWITH
5697: 
5698:         *-- ===================================================================
5699:         *-- SHAPE shp_4c_ShpFig (shpFig: top=152, left=231, w=244, h=148)
5700:         *-- IMAGE img_4c_ImgFigJpg (ImgFigJpg: top=153, left=232, w=241, h=146)
5701:         *-- ===================================================================
5702:         loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
5703:         WITH loc_oPg.shp_4c_ShpFig
5704:             .Top         = 152
5705:             .Left        = 231
5706:             .Width       = 244
5707:             .Height      = 148
5708:             .BackColor   = RGB(240, 240, 240)
5709:             .BorderColor = RGB(128, 128, 128)
5710:             .BorderWidth = 1
5711:             .Visible     = .T.
5712:         ENDWITH
5713: 
5714:         loc_oPg.AddObject("img_4c_ImgFigJpg", "Image")
5715:         WITH loc_oPg.img_4c_ImgFigJpg
5716:             .Top     = 153
5717:             .Left    = 232
5718:             .Width   = 241
5719:             .Height  = 146
5720:             .Stretch = 2
5721:             .Visible = .F.
5722:         ENDWITH
5723:         BINDEVENT(loc_oPg.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")
5724: 
5725:         *-- ===================================================================
5726:         *-- COMMANDGROUP obj_4c_CmdgFigura (cmdgFigura: top=192, left=482, 40x40, 1 botao)
5727:         *-- Selecionar foto do processo
5728:         *-- ===================================================================
5729:         loc_oPg.AddObject("obj_4c_CmdgFigura", "CommandGroup")
5730:         WITH loc_oPg.obj_4c_CmdgFigura
5731:             .ButtonCount = 1
5732:             .BorderStyle = 0
5733:             .Top         = 192
5734:             .Left        = 482
5735:             .Width       = 40
5736:             .Height      = 40
5737:             .Themes      = .F.
5738:             .Visible     = .T.
5739:         ENDWITH
5740:         WITH loc_oPg.obj_4c_CmdgFigura
5741:             .Buttons(1).Top           = 0
5742:             .Buttons(1).Left          = 0
5743:             .Buttons(1).Height        = 40
5744:             .Buttons(1).Width         = 40
5745:             .Buttons(1).Caption       = ""
5746:             .Buttons(1).Picture       = gc_4c_CaminhoIcones + "geral_foto_26.jpg"
5747:             .Buttons(1).ToolTipText   = "Selecionar Foto"
5748:             .Buttons(1).SpecialEffect = 0
5749:             .Buttons(1).BackColor     = RGB(255, 255, 255)
5750:             .Buttons(1).Themes        = .F.
5751:         ENDWITH
5752:         BINDEVENT(loc_oPg.obj_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")
5753: 
5754:         *-- ===================================================================
5755:         *-- COMMANDGROUP obj_4c_CmdgFigCam (cmdgFigCam: top=232, left=482, 40x40, 1 botao)
5756:         *-- Capturar da camera
5757:         *-- ===================================================================
5758:         loc_oPg.AddObject("obj_4c_CmdgFigCam", "CommandGroup")
5759:         WITH loc_oPg.obj_4c_CmdgFigCam
5760:             .ButtonCount = 1
5761:             .BorderStyle = 0
5762:             .Top         = 232
5763:             .Left        = 482
5764:             .Width       = 40
5765:             .Height      = 40
5766:             .Themes      = .F.
5767:             .Visible     = .T.
5768:         ENDWITH
5769:         WITH loc_oPg.obj_4c_CmdgFigCam
5770:             .Buttons(1).Top           = 0
5771:             .Buttons(1).Left          = 0
5772:             .Buttons(1).Height        = 40
5773:             .Buttons(1).Width         = 40
5774:             .Buttons(1).Caption       = ""
5775:             .Buttons(1).Picture       = gc_4c_CaminhoIcones + "geral_camera_26.jpg"
5776:             .Buttons(1).ToolTipText   = "Capturar da C" + CHR(226) + "mera"
5777:             .Buttons(1).SpecialEffect = 0
5778:             .Buttons(1).BackColor     = RGB(255, 255, 255)
5779:             .Buttons(1).Themes        = .F.
5780:         ENDWITH
5781:         BINDEVENT(loc_oPg.obj_4c_CmdgFigCam, "Click", THIS, "CmdgFigCamClick")
5782: 
5783:         *-- ===================================================================
5784:         *-- LABEL lbl_4c_Label1 "Descricao :" (Say1: top=474, left=527, w=67, h=17)
5785:         *-- TEXTBOX txt_4c_Desc (Get_Desc: top=471, left=595, w=395, h=23)
5786:         *-- EDITBOX obj_4c_GetObs (Get_Obs: top=497, left=527, w=463, h=122)
5787:         *-- ===================================================================
5788:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
5789:         WITH loc_oPg.lbl_4c_Label1
5790:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
5791:             .Top       = 474
5792:             .Left      = 527
5793:             .Width     = 67
5794:             .Height    = 17
5795:             .BackStyle = 0
5796:             .ForeColor = RGB(90, 90, 90)
5797:             .FontName  = "Tahoma"
5798:             .FontSize  = 8
5799:             .Visible   = .T.
5800:         ENDWITH
5801: 
5802:         loc_oPg.AddObject("txt_4c_Desc", "TextBox")
5803:         WITH loc_oPg.txt_4c_Desc
5804:             .Top           = 471
5805:             .Left          = 595
5806:             .Width         = 395
5807:             .Height        = 23
5808:             .FontName      = "Tahoma"
5809:             .FontSize      = 8
5810:             .SpecialEffect = 1
5811:             .Themes        = .F.
5812:             .ReadOnly      = .F.
5813:             .Value         = ""
5814:             .Visible       = .T.
5815:         ENDWITH
5816: 
5817:         loc_oPg.AddObject("obj_4c_GetObs", "EditBox")
5818:         WITH loc_oPg.obj_4c_GetObs
5819:             .Top           = 497
5820:             .Left          = 527
5821:             .Width         = 463

*-- Linhas 5893 a 6018:
5893:         loc_oGrd2.Column2.Width = 116
5894:         loc_oGrd2.Column3.Width = 50
5895: 
5896:         *-- BINDEVENT grd_4c_Matrizes
5897:         BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
5898:         BINDEVENT(loc_oGrd2.Column1.Text1, "Valid", THIS, "MatrizGrdCol1Valid")
5899: 
5900:         *-- ===================================================================
5901:         *-- COMMANDBUTTON cmd_4c_BtnInsereMtx (btnInsereMtx: top=380, left=258, 30x30)
5902:         *-- ===================================================================
5903:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
5904:         WITH loc_oPg.cmd_4c_BtnInsereMtx
5905:             .Top             = 380
5906:             .Left            = 258
5907:             .Width           = 30
5908:             .Height          = 30
5909:             .Caption         = ""
5910:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
5911:             .PicturePosition = 13
5912:             .ToolTipText     = "Inserir Matriz"
5913:             .FontName        = "Tahoma"
5914:             .FontSize        = 8
5915:             .Themes          = .F.
5916:             .SpecialEffect   = 0
5917:             .BackColor       = RGB(255, 255, 255)
5918:             .Visible         = .T.
5919:         ENDWITH
5920:         BINDEVENT(loc_oPg.cmd_4c_BtnInsereMtx, "Click", THIS, "BtnInsereMtxClick")
5921: 
5922:         *-- COMMANDBUTTON cmd_4c_BtnExcluiMtz (btnExcluiMtz: top=420, left=258, 30x30)
5923:         loc_oPg.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
5924:         WITH loc_oPg.cmd_4c_BtnExcluiMtz
5925:             .Top             = 420
5926:             .Left            = 258
5927:             .Width           = 30
5928:             .Height          = 30
5929:             .Caption         = ""
5930:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
5931:             .PicturePosition = 13
5932:             .ToolTipText     = "Excluir Matriz"
5933:             .FontName        = "Tahoma"
5934:             .FontSize        = 8
5935:             .Themes          = .F.
5936:             .SpecialEffect   = 0
5937:             .BackColor       = RGB(255, 255, 255)
5938:             .Visible         = .T.
5939:         ENDWITH
5940:         BINDEVENT(loc_oPg.cmd_4c_BtnExcluiMtz, "Click", THIS, "BtnExcluiMtzClick")
5941: 
5942:         *-- ===================================================================
5943:         *-- SHAPE shp_4c_ShpBorracha (shpBorracha: top=464, left=258, w=236, h=156)
5944:         *-- IMAGE img_4c_ImgBorracha (ImgBorracha: top=465, left=260, w=232, h=154)
5945:         *-- ===================================================================
5946:         loc_oPg.AddObject("shp_4c_ShpBorracha", "Shape")
5947:         WITH loc_oPg.shp_4c_ShpBorracha
5948:             .Top         = 464
5949:             .Left        = 258
5950:             .Width       = 236
5951:             .Height      = 156
5952:             .BackColor   = RGB(240, 240, 240)
5953:             .BorderColor = RGB(128, 128, 128)
5954:             .BorderWidth = 1
5955:             .Visible     = .T.
5956:         ENDWITH
5957: 
5958:         loc_oPg.AddObject("img_4c_ImgBorracha", "Image")
5959:         WITH loc_oPg.img_4c_ImgBorracha
5960:             .Top     = 465
5961:             .Left    = 260
5962:             .Width   = 232
5963:             .Height  = 154
5964:             .Stretch = 2
5965:             .Visible = .F.
5966:         ENDWITH
5967: 
5968:     ENDPROC
5969: 
5970:     *--------------------------------------------------------------------------
5971:     * ConfigurarPgpgDesigner - Aba "Designer" (Page7 do pgf_4c_Dados)
5972:     * Controles: grd_4c_Designer (4 cols tarefas), obj_4c_GetObsTarefas,
5973:     *            cmd_4c_BtnIniTarefa, cmd_4c_BtnFimTarefa,
5974:     *            grd_4c_Arquivos (1 col), cmd_4c_BtnInsArqs/OpnArqs/ExcArqs,
5975:     *            shp_4c_Shape1, img_4c_ImgArqJpg
5976:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
5977:     *--------------------------------------------------------------------------
5978:     PROTECTED PROCEDURE ConfigurarPgpgDesigner(par_oPage)
5979:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
5980: 
5981:         loc_oPg = par_oPage
5982: 
5983:         *-- ===================================================================
5984:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
5985:         *-- Campos na ORDEM VISUAL das colunas (sem ColumnOrder)
5986:         *-- ===================================================================
5987: 
5988:         *-- cursor_4c_Tarefas - tarefas do designer (baseado em crSigPrTar)
5989:         *-- Ordem visual: DtInis | DtFims | Usuars | Tarefas
5990:         IF USED("cursor_4c_Tarefas")
5991:             USE IN cursor_4c_Tarefas
5992:         ENDIF
5993:         SET NULL ON
5994:         CREATE CURSOR cursor_4c_Tarefas ( ;
5995:             DtInis      T, ;
5996:             DtFims      T, ;
5997:             Usuars      C(10), ;
5998:             Tarefas     C(10), ;
5999:             ObsTarefas  M, ;
6000:             CPros       C(14), ;
6001:             pkChaves    C(30))
6002:         SET NULL OFF
6003: 
6004:         *-- cursor_4c_Arquivos - arquivos do designer (baseado em crSigPrArq)
6005:         IF USED("cursor_4c_Arquivos")
6006:             USE IN cursor_4c_Arquivos
6007:         ENDIF
6008:         SET NULL ON
6009:         CREATE CURSOR cursor_4c_Arquivos ( ;
6010:             Arquivos    C(254), ;
6011:             CPros       C(14), ;
6012:             pkChaves    C(30))
6013:         SET NULL OFF
6014: 
6015:         *-- ===================================================================
6016:         *-- GRID grd_4c_Designer (grdDesigner: top=160, left=10, w=495, h=238, 4 cols)
6017:         *-- crSigPrTar: DtInis T | DtFims T | Usuars C(10) | Tarefas C(10)
6018:         *-- ===================================================================

*-- Linhas 6086 a 6131:
6086:         loc_oGrd.Column3.Width = 100
6087:         loc_oGrd.Column4.Width = 155
6088: 
6089:         *-- BINDEVENT grd_4c_Designer
6090:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")
6091:         BINDEVENT(loc_oGrd.Column4.Text1, "Valid", THIS, "DesignerCol4Valid")
6092: 
6093:         *-- ===================================================================
6094:         *-- LABEL lbl_4c_Say31 ("Observacao da Tarefa": top=144, left=583)
6095:         *-- ===================================================================
6096:         loc_oPg.AddObject("lbl_4c_Say31", "Label")
6097:         WITH loc_oPg.lbl_4c_Say31
6098:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
6099:             .Top       = 144
6100:             .Left      = 583
6101:             .Width     = 120
6102:             .Height    = 15
6103:             .BackStyle = 0
6104:             .ForeColor = RGB(90, 90, 90)
6105:             .FontName  = "Tahoma"
6106:             .FontSize  = 8
6107:             .Visible   = .T.
6108:         ENDWITH
6109: 
6110:         *-- ===================================================================
6111:         *-- EDITBOX obj_4c_GetObsTarefas (getObsTarefas: top=160, left=584, w=407, h=238)
6112:         *-- When: InList(pcEscolha, INSERIR, ALTERAR) -> editavel so em modo edicao
6113:         *-- ===================================================================
6114:         loc_oPg.AddObject("obj_4c_GetObsTarefas", "EditBox")
6115:         WITH loc_oPg.obj_4c_GetObsTarefas
6116:             .Value         = ""
6117:             .Top           = 160
6118:             .Left          = 584
6119:             .Width         = 407
6120:             .Height        = 238
6121:             .FontName      = "Tahoma"
6122:             .FontSize      = 8
6123:             .ScrollBars    = 2
6124:             .ReadOnly      = .F.
6125:             .Themes        = .F.
6126:             .ControlSource = "cursor_4c_Tarefas.ObsTarefas"
6127:             .Visible       = .T.
6128:         ENDWITH
6129: 
6130:         *-- ===================================================================
6131:         *-- COMMANDBUTTON cmd_4c_BtnIniTarefa (btnIniTarefa: top=161, left=509, w=42, h=42)

*-- Linhas 6149 a 7394:
6149:             .BackColor       = RGB(255, 255, 255)
6150:             .Visible         = .T.
6151:         ENDWITH
6152:         BINDEVENT(loc_oPg.cmd_4c_BtnIniTarefa, "Click", THIS, "BtnIniTarefaClick")
6153: 
6154:         *-- ===================================================================
6155:         *-- COMMANDBUTTON cmd_4c_BtnFimTarefa (btnFimTarefa: top=203, left=509, w=42, h=42)
6156:         *-- When: InList(pcEscolha, INSERIR, ALTERAR)
6157:         *-- Click: Valida pertencimento + registra DtFims
6158:         *-- ===================================================================
6159:         loc_oPg.AddObject("cmd_4c_BtnFimTarefa", "CommandButton")
6160:         WITH loc_oPg.cmd_4c_BtnFimTarefa
6161:             .Top             = 203
6162:             .Left            = 509
6163:             .Width           = 42
6164:             .Height          = 42
6165:             .Caption         = ""
6166:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
6167:             .PicturePosition = 13
6168:             .ToolTipText     = "Finalizar Tarefa"
6169:             .FontName        = "Tahoma"
6170:             .FontSize        = 8
6171:             .Themes          = .F.
6172:             .SpecialEffect   = 0
6173:             .BackColor       = RGB(255, 255, 255)
6174:             .Visible         = .T.
6175:         ENDWITH
6176:         BINDEVENT(loc_oPg.cmd_4c_BtnFimTarefa, "Click", THIS, "BtnFimTarefaClick")
6177: 
6178:         *-- ===================================================================
6179:         *-- GRID grd_4c_Arquivos (grdArquivos: top=415, left=10, w=495, h=202, 1 col)
6180:         *-- crSigPrArq: Arquivos C(254)
6181:         *-- ===================================================================
6182:         loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
6183:         loc_oGrd2 = loc_oPg.grd_4c_Arquivos
6184:         WITH loc_oGrd2
6185:             .Top         = 415
6186:             .Left        = 10
6187:             .Width       = 495
6188:             .Height      = 202
6189:             .FontName    = "Tahoma"
6190:             .FontSize    = 8
6191:             .RecordMark  = .F.
6192:             .DeleteMark  = .F.
6193:             .GridLines   = 3
6194:             .ReadOnly    = .F.
6195:             .RowHeight   = 17
6196:             .ScrollBars  = 2
6197:             .Themes      = .F.
6198:             .ColumnCount = 1
6199:             .Visible     = .T.
6200:         ENDWITH
6201: 
6202:         *-- Col1: Arquivos (495px, editavel)
6203:         WITH loc_oGrd2.Column1
6204:             .Width     = 495
6205:             .Movable   = .F.
6206:             .Resizable = .F.
6207:             .Sparse    = .F.
6208:         ENDWITH
6209: 
6210:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
6211:         loc_oGrd2.RecordSource = "cursor_4c_Arquivos"
6212: 
6213:         *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
6214:         loc_oGrd2.Column1.ControlSource = "cursor_4c_Arquivos.Arquivos"
6215: 
6216:         *-- Cabecalho APOS RecordSource
6217:         loc_oGrd2.Column1.Header1.Caption = "Arquivos Para Designer"
6218: 
6219:         *-- Largura re-aplicada APOS RecordSource
6220:         loc_oGrd2.Column1.Width = 495
6221: 
6222:         *-- BINDEVENT grd_4c_Arquivos
6223:         BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")
6224: 
6225:         *-- ===================================================================
6226:         *-- COMMANDBUTTON cmd_4c_BtnInsArqs (btnInsArqs: top=416, left=509, w=42, h=42)
6227:         *-- When: InList(pcEscolha, INSERIR, ALTERAR)
6228:         *-- Click: GetFile -> Insert Into cursor_4c_Arquivos
6229:         *-- ===================================================================
6230:         loc_oPg.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
6231:         WITH loc_oPg.cmd_4c_BtnInsArqs
6232:             .Top             = 416
6233:             .Left            = 509
6234:             .Width           = 42
6235:             .Height          = 42
6236:             .Caption         = ""
6237:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
6238:             .PicturePosition = 13
6239:             .ToolTipText     = "Inserir Arquivo"
6240:             .FontName        = "Tahoma"
6241:             .FontSize        = 8
6242:             .Themes          = .F.
6243:             .SpecialEffect   = 0
6244:             .BackColor       = RGB(255, 255, 255)
6245:             .Visible         = .T.
6246:         ENDWITH
6247:         BINDEVENT(loc_oPg.cmd_4c_BtnInsArqs, "Click", THIS, "BtnInsArqsClick")
6248: 
6249:         *-- ===================================================================
6250:         *-- COMMANDBUTTON cmd_4c_BtnExcArqs (btnExcArqs: top=458, left=509, w=42, h=42)
6251:         *-- When: InList(pcEscolha, INSERIR, ALTERAR)
6252:         *-- Click: Delete from cursor_4c_Arquivos
6253:         *-- ===================================================================
6254:         loc_oPg.AddObject("cmd_4c_BtnExcArqs", "CommandButton")
6255:         WITH loc_oPg.cmd_4c_BtnExcArqs
6256:             .Top             = 458
6257:             .Left            = 509
6258:             .Width           = 42
6259:             .Height          = 42
6260:             .Caption         = ""
6261:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
6262:             .PicturePosition = 13
6263:             .ToolTipText     = "Excluir Arquivo"
6264:             .FontName        = "Tahoma"
6265:             .FontSize        = 8
6266:             .Themes          = .F.
6267:             .SpecialEffect   = 0
6268:             .BackColor       = RGB(255, 255, 255)
6269:             .Visible         = .T.
6270:         ENDWITH
6271:         BINDEVENT(loc_oPg.cmd_4c_BtnExcArqs, "Click", THIS, "BtnExcArqsClick")
6272: 
6273:         *-- ===================================================================
6274:         *-- COMMANDBUTTON cmd_4c_BtnOpnArqs (btnOpnArqs: top=500, left=509, w=42, h=42)
6275:         *-- When: sempre habilitado (.T.)
6276:         *-- Click: Shell.Application.Open(arquivo)
6277:         *-- ===================================================================
6278:         loc_oPg.AddObject("cmd_4c_BtnOpnArqs", "CommandButton")
6279:         WITH loc_oPg.cmd_4c_BtnOpnArqs
6280:             .Top             = 500
6281:             .Left            = 509
6282:             .Width           = 42
6283:             .Height          = 42
6284:             .Caption         = ""
6285:             .Picture         = gc_4c_CaminhoIcones + "relatorio_visualizar_26.jpg"
6286:             .PicturePosition = 13
6287:             .ToolTipText     = "Abrir Arquivo"
6288:             .FontName        = "Tahoma"
6289:             .FontSize        = 8
6290:             .Themes          = .F.
6291:             .SpecialEffect   = 0
6292:             .BackColor       = RGB(255, 255, 255)
6293:             .Visible         = .T.
6294:         ENDWITH
6295:         BINDEVENT(loc_oPg.cmd_4c_BtnOpnArqs, "Click", THIS, "BtnOpnArqsClick")
6296: 
6297:         *-- ===================================================================
6298:         *-- SHAPE shp_4c_Shape1 (Shape1: top=415, left=584, w=407, h=202)
6299:         *-- Borda visual ao redor da area de preview de imagem
6300:         *-- ===================================================================
6301:         loc_oPg.AddObject("shp_4c_Shape1", "Shape")
6302:         WITH loc_oPg.shp_4c_Shape1
6303:             .Top         = 415
6304:             .Left        = 584
6305:             .Width       = 407
6306:             .Height      = 202
6307:             .BorderColor = RGB(128, 128, 128)
6308:             .BorderWidth = 1
6309:             .BackStyle   = 0
6310:             .Visible     = .T.
6311:         ENDWITH
6312: 
6313:         *-- ===================================================================
6314:         *-- IMAGE img_4c_ImgArqJpg (imgArqJpg: top=417, left=586, w=403, h=198)
6315:         *-- Visible=.F. por padrao; exibida ao selecionar arquivo JPG/ICO/BMP/JPEG
6316:         *-- Click: Do Form SigOpZom (zoom do arquivo)
6317:         *-- ===================================================================
6318:         loc_oPg.AddObject("img_4c_ImgArqJpg", "Image")
6319:         WITH loc_oPg.img_4c_ImgArqJpg
6320:             .Top     = 417
6321:             .Left    = 586
6322:             .Width   = 403
6323:             .Height  = 198
6324:             .Stretch = 2
6325:             .Visible = .F.
6326:         ENDWITH
6327:         BINDEVENT(loc_oPg.img_4c_ImgArqJpg, "Click", THIS, "ImgArqJpgClick")
6328: 
6329:     ENDPROC
6330: 
6331:     *--------------------------------------------------------------------------
6332:     * GrdDesignerAfterRowColChange - Handler AfterRowColChange do grd_4c_Designer
6333:     * Atualiza exibicao da observacao da tarefa selecionada
6334:     *--------------------------------------------------------------------------
6335:     PROCEDURE GrdDesignerAfterRowColChange(par_nColIndex)
6336:         LOCAL loc_oPg
6337:         TRY
6338:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
6339:             IF PEMSTATUS(loc_oPg, "obj_4c_GetObsTarefas", 5)
6340:                 loc_oPg.obj_4c_GetObsTarefas.Refresh()
6341:             ENDIF
6342:         CATCH TO loc_oErro
6343:             MsgErro(loc_oErro.Message, "Erro")
6344:         ENDTRY
6345:     ENDPROC
6346: 
6347:     *--------------------------------------------------------------------------
6348:     * DesignerCol4Valid - Valid do Column4 (Tarefa) do grd_4c_Designer
6349:     * Lookup: SigCdCad (CodCads, DesCads) - catalogo de tarefas designer
6350:     *--------------------------------------------------------------------------
6351:     PROCEDURE DesignerCol4Valid(par_nColIndex)
6352:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
6353:         loc_lResultado = .T.
6354:         TRY
6355:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer
6356:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column4.Text1.Value, ""))
6357:             IF EMPTY(loc_cCodigo)
6358:                 loc_lResultado = loc_lResultado
6359:             ENDIF
6360:             loc_lcSQL = "SELECT CodCads, DesCads FROM SigCdCad WHERE CodCads = " + EscaparSQL(loc_cCodigo)
6361:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTarefas") <= 0 OR EOF("cursor_4c_ValTarefas")
6362:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6363:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValCad"
6364:                 loc_oLookup.mAddColuna("CodCads", "", "C" + CHR(243) + "digo")
6365:                 loc_oLookup.mAddColuna("DesCads", "", "Descri" + CHR(231) + CHR(227) + "o")
6366:                 loc_oLookup.cTabela     = "SigCdCad"
6367:                 loc_oLookup.cCampoChave = "CodCads"
6368:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6369:                 loc_oLookup.Show()
6370:                 IF loc_oLookup.this_lSelecionou
6371:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6372:                 ELSE
6373:                     loc_cCodigo = ""
6374:                 ENDIF
6375:             ENDIF
6376:             IF USED("cursor_4c_ValTarefas")
6377:                 USE IN cursor_4c_ValTarefas
6378:             ENDIF
6379:             IF USED("cursor_4c_Tarefas") AND !EOF("cursor_4c_Tarefas")
6380:                 SELECT cursor_4c_Tarefas
6381:                 REPLACE Tarefas WITH PADR(loc_cCodigo, 10) IN cursor_4c_Tarefas
6382:                 loc_oGrd.Column4.Text1.Value = loc_cCodigo
6383:             ENDIF
6384:         CATCH TO loc_oErro
6385:             MsgErro(loc_oErro.Message, "Erro")
6386:         ENDTRY
6387:         RETURN loc_lResultado
6388:     ENDPROC
6389: 
6390:     *--------------------------------------------------------------------------
6391:     * GrdArquivosAfterRowColChange - Handler AfterRowColChange do grd_4c_Arquivos
6392:     * Exibe preview de imagem se arquivo for JPG/ICO/BMP/JPEG
6393:     *--------------------------------------------------------------------------
6394:     PROCEDURE GrdArquivosAfterRowColChange(par_nColIndex)
6395:         LOCAL loc_lcArq, loc_oPg, loc_nPonto
6396:         TRY
6397:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
6398:             CLEAR RESOURCES
6399:             loc_oPg.img_4c_ImgArqJpg.Picture = ""
6400:             loc_oPg.img_4c_ImgArqJpg.Visible = .F.
6401:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
6402:                 RETURN
6403:             ENDIF
6404:             loc_lcArq  = ALLTRIM(cursor_4c_Arquivos.Arquivos)
6405:             loc_nPonto = AT(".", loc_lcArq)
6406:             IF !EMPTY(loc_lcArq) AND loc_nPonto > 0 AND ;
6407:                 INLIST(ALLTRIM(UPPER(SUBSTR(loc_lcArq, loc_nPonto, 5))), ".JPG", ".ICO", ".BMP", ".JPEG")
6408:                 loc_oPg.img_4c_ImgArqJpg.Picture = loc_lcArq
6409:                 loc_oPg.img_4c_ImgArqJpg.Visible = .T.
6410:             ENDIF
6411:         CATCH TO loc_oErro
6412:             MsgErro(loc_oErro.Message, "Erro")
6413:         ENDTRY
6414:     ENDPROC
6415: 
6416:     *--------------------------------------------------------------------------
6417:     * BtnIniTarefaClick - Inicia nova tarefa no grd_4c_Designer
6418:     * Valida: sem tarefa aberta para o usuario + sem tarefa sem codigo
6419:     *--------------------------------------------------------------------------
6420:     PROCEDURE BtnIniTarefaClick()
6421:         LOCAL loc_lResultado, loc_oGrd, loc_tDataHora
6422:         loc_lResultado = .F.
6423:         TRY
6424:             IF !USED("cursor_4c_Tarefas")
6425:                 loc_lResultado = loc_lResultado
6426:             ENDIF
6427:             loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer
6428: 
6429:             *-- Validar: nao pode ter tarefa aberta (DtFims vazia) para este usuario
6430:             SELECT cursor_4c_Tarefas
6431:             GO TOP IN cursor_4c_Tarefas
6432:             LOCATE FOR ALLTRIM(Usuars) = ALLTRIM(gc_4c_UsuarioLogado) AND EMPTY(DtFims)
6433:             IF !EOF("cursor_4c_Tarefas")
6434:                 MsgAviso("Existe Uma Tarefa N" + CHR(227) + "o Encerrada Para Esse Usu" + CHR(225) + "rio!!!")
6435:                 loc_oGrd.Column4.SetFocus()
6436:                 loc_lResultado = loc_lResultado
6437:             ENDIF
6438: 
6439:             *-- Validar: nao pode ter tarefa com codigo vazio para este usuario
6440:             SELECT cursor_4c_Tarefas
6441:             GO TOP IN cursor_4c_Tarefas
6442:             LOCATE FOR ALLTRIM(Usuars) = ALLTRIM(gc_4c_UsuarioLogado) AND EMPTY(Tarefas)
6443:             IF !EOF("cursor_4c_Tarefas")
6444:                 MsgAviso("Existe Uma Tarefa Ainda N" + CHR(227) + "o Informada!!!")
6445:                 loc_oGrd.Column4.SetFocus()
6446:                 loc_lResultado = loc_lResultado
6447:             ENDIF
6448: 
6449:             *-- Inserir nova linha com DtInis = agora, DtFims = vazio ({})
6450:             loc_tDataHora = DATETIME()
6451:             INSERT INTO cursor_4c_Tarefas (DtInis, DtFims, Usuars, Tarefas, CPros, pkChaves) ;
6452:                 VALUES (loc_tDataHora, {}, ;
6453:                         PADR(gc_4c_UsuarioLogado, 10), PADR("", 10), ;
6454:                         PADR(THIS.this_oBusinessObject.this_cCpros, 14), "")
6455: 
6456:             SELECT cursor_4c_Tarefas
6457:             GO BOTTOM IN cursor_4c_Tarefas
6458:             loc_oGrd.Refresh()
6459:             loc_oGrd.Column4.SetFocus()
6460:             loc_lResultado = .T.
6461:         CATCH TO loc_oErro
6462:             MsgErro(loc_oErro.Message, "Erro")
6463:         ENDTRY
6464:         RETURN loc_lResultado
6465:     ENDPROC
6466: 
6467:     *--------------------------------------------------------------------------
6468:     * BtnFimTarefaClick - Finaliza tarefa corrente no grd_4c_Designer
6469:     * Valida: tarefa pertence ao usuario + nao esta ja finalizada
6470:     *--------------------------------------------------------------------------
6471:     PROCEDURE BtnFimTarefaClick()
6472:         LOCAL loc_lResultado, loc_oGrd, loc_tDataHora
6473:         loc_lResultado = .F.
6474:         TRY
6475:             IF !USED("cursor_4c_Tarefas") OR EOF("cursor_4c_Tarefas") OR BOF("cursor_4c_Tarefas")
6476:                 loc_lResultado = loc_lResultado
6477:             ENDIF
6478:             loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer
6479: 
6480:             *-- Validar: tarefa deve pertencer ao usuario logado
6481:             IF ALLTRIM(cursor_4c_Tarefas.Usuars) <> ALLTRIM(gc_4c_UsuarioLogado)
6482:                 MsgAviso("Essa Tarefa N" + CHR(227) + "o Pertence a Esse Usu" + CHR(225) + "rio!!!")
6483:                 loc_oGrd.Column4.SetFocus()
6484:                 loc_lResultado = loc_lResultado
6485:             ENDIF
6486: 
6487:             *-- Validar: tarefa nao pode estar ja finalizada
6488:             IF !EMPTY(cursor_4c_Tarefas.DtFims)
6489:                 MsgAviso("Essa Tarefa J" + CHR(225) + " Se Encontra Finalizada!!!")
6490:                 loc_oGrd.Column4.SetFocus()
6491:                 loc_lResultado = loc_lResultado
6492:             ENDIF
6493: 
6494:             *-- Registrar data/hora de finalizacao
6495:             loc_tDataHora = DATETIME()
6496:             SELECT cursor_4c_Tarefas
6497:             REPLACE DtFims WITH loc_tDataHora IN cursor_4c_Tarefas
6498: 
6499:             loc_oGrd.Refresh()
6500:             loc_lResultado = .T.
6501:         CATCH TO loc_oErro
6502:             MsgErro(loc_oErro.Message, "Erro")
6503:         ENDTRY
6504:         RETURN loc_lResultado
6505:     ENDPROC
6506: 
6507:     *--------------------------------------------------------------------------
6508:     * BtnInsArqsClick - Insere arquivo no grd_4c_Arquivos via dialog GetFile
6509:     *--------------------------------------------------------------------------
6510:     PROCEDURE BtnInsArqsClick()
6511:         LOCAL loc_lResultado, loc_lcArq, loc_oGrd
6512:         loc_lResultado = .F.
6513:         TRY
6514:             loc_oGrd  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos
6515:             loc_lcArq = GETFILE("", "Selecione o Arquivo", "Selecione o Arquivo", 0, ;
6516:                 "Sele" + CHR(231) + CHR(227) + "o de Arquivos")
6517:             IF !EMPTY(loc_lcArq)
6518:                 INSERT INTO cursor_4c_Arquivos (CPros, pkChaves, Arquivos) ;
6519:                     VALUES (PADR(THIS.this_oBusinessObject.this_cCpros, 14), "", UPPER(loc_lcArq))
6520:                 loc_oGrd.Refresh()
6521:             ENDIF
6522:             loc_lResultado = .T.
6523:         CATCH TO loc_oErro
6524:             MsgErro(loc_oErro.Message, "Erro")
6525:         ENDTRY
6526:         RETURN loc_lResultado
6527:     ENDPROC
6528: 
6529:     *--------------------------------------------------------------------------
6530:     * BtnOpnArqsClick - Abre arquivo selecionado no grd_4c_Arquivos com Shell
6531:     *--------------------------------------------------------------------------
6532:     PROCEDURE BtnOpnArqsClick()
6533:         LOCAL loc_lResultado, loc_lcArq, loc_oApp
6534:         loc_lResultado = .F.
6535:         TRY
6536:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
6537:                 loc_lResultado = loc_lResultado
6538:             ENDIF
6539:             loc_lcArq = ALLTRIM(cursor_4c_Arquivos.Arquivos)
6540:             IF !EMPTY(loc_lcArq) AND FILE(loc_lcArq)
6541:                 loc_oApp = CREATEOBJECT("Shell.Application")
6542:                 loc_oApp.Open(loc_lcArq)
6543:                 loc_lResultado = .T.
6544:             ELSE
6545:                 MsgAviso("Arquivo N" + CHR(227) + "o Encontrado!!!")
6546:             ENDIF
6547:         CATCH TO loc_oErro
6548:             MsgErro(loc_oErro.Message, "Erro")
6549:         ENDTRY
6550:         RETURN loc_lResultado
6551:     ENDPROC
6552: 
6553:     *--------------------------------------------------------------------------
6554:     * BtnExcArqsClick - Exclui arquivo selecionado do grd_4c_Arquivos
6555:     *--------------------------------------------------------------------------
6556:     PROCEDURE BtnExcArqsClick()
6557:         LOCAL loc_lResultado, loc_oGrd
6558:         loc_lResultado = .F.
6559:         TRY
6560:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos") OR BOF("cursor_4c_Arquivos")
6561:                 loc_lResultado = loc_lResultado
6562:             ENDIF
6563:             loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos
6564:             IF !EMPTY(cursor_4c_Arquivos.Arquivos)
6565:                 SELECT cursor_4c_Arquivos
6566:                 DELETE IN cursor_4c_Arquivos
6567:                 IF !EOF("cursor_4c_Arquivos")
6568:                     SKIP IN cursor_4c_Arquivos
6569:                 ENDIF
6570:                 IF EOF("cursor_4c_Arquivos")
6571:                     GO BOTTOM IN cursor_4c_Arquivos
6572:                 ENDIF
6573:                 PACK IN cursor_4c_Arquivos
6574:             ENDIF
6575:             loc_oGrd.Refresh()
6576:             loc_lResultado = .T.
6577:         CATCH TO loc_oErro
6578:             MsgErro(loc_oErro.Message, "Erro")
6579:         ENDTRY
6580:         RETURN loc_lResultado
6581:     ENDPROC
6582: 
6583:     *--------------------------------------------------------------------------
6584:     * ImgArqJpgClick - Abre visualizador de imagem em tela cheia (SigOpZom)
6585:     *--------------------------------------------------------------------------
6586:     PROCEDURE ImgArqJpgClick()
6587:         LOCAL loc_lResultado, loc_lcArq, loc_nPonto
6588:         loc_lResultado = .F.
6589:         TRY
6590:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
6591:                 loc_lResultado = loc_lResultado
6592:             ENDIF
6593:             loc_lcArq  = ALLTRIM(cursor_4c_Arquivos.Arquivos)
6594:             loc_nPonto = AT(".", loc_lcArq)
6595:             IF !EMPTY(loc_lcArq) AND FILE(loc_lcArq) AND loc_nPonto > 0 AND ;
6596:                 INLIST(ALLTRIM(UPPER(SUBSTR(loc_lcArq, loc_nPonto, 5))), ".JPG", ".ICO", ".BMP", ".JPEG")
6597:                 DO FORM SigOpZom WITH loc_lcArq, "Arquivo : " + loc_lcArq
6598:             ENDIF
6599:             loc_lResultado = .T.
6600:         CATCH TO loc_oErro
6601:             MsgErro(loc_oErro.Message, "Erro")
6602:         ENDTRY
6603:         RETURN loc_lResultado
6604:     ENDPROC
6605: 
6606:     *--------------------------------------------------------------------------
6607:     * GrdConsAfterRowColChange - Handler AfterRowColChange do grd_4c_GrdCons
6608:     *--------------------------------------------------------------------------
6609:     PROCEDURE GrdConsAfterRowColChange(par_nColIndex)
6610:         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
6611:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
6612:         ENDIF
6613:     ENDPROC
6614: 
6615:     *--------------------------------------------------------------------------
6616:     * GrdFaseAfterRowColChange - Handler AfterRowColChange do grd_4c_FasePro
6617:     * Carrega imagem FigProcs do campo memo na img_4c_ImgFigJpg
6618:     *--------------------------------------------------------------------------
6619:     PROCEDURE GrdFaseAfterRowColChange(par_nColIndex)
6620:         LOCAL loc_oPage, loc_lcArquivo
6621:         TRY
6622:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6623:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6624:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6625:                 CLEAR RESOURCES
6626:                 loc_oPage.img_4c_ImgFigJpg.Picture = ""
6627:                 loc_oPage.img_4c_ImgFigJpg.Visible = .F.
6628:                 IF !EMPTY(cursor_4c_Fase.FigProcs) AND !ISNULL(cursor_4c_Fase.FigProcs)
6629:                     IF STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo) > 0
6630:                         loc_oPage.img_4c_ImgFigJpg.Visible = .T.
6631:                         loc_oPage.img_4c_ImgFigJpg.Picture = loc_lcArquivo
6632:                     ENDIF
6633:                 ENDIF
6634:             ENDIF
6635:         CATCH TO loc_oErro
6636:             MsgErro(loc_oErro.Message, "Erro")
6637:         ENDTRY
6638:     ENDPROC
6639: 
6640:     *--------------------------------------------------------------------------
6641:     * GrdMatrizesAfterRowColChange - Handler AfterRowColChange do grd_4c_Matrizes
6642:     * Carrega imagem do produto matriz na img_4c_ImgBorracha via SQL
6643:     *--------------------------------------------------------------------------
6644:     PROCEDURE GrdMatrizesAfterRowColChange(par_nColIndex)
6645:         LOCAL loc_oPage, loc_lcArquivo, loc_lcSQL
6646:         TRY
6647:             IF USED("cursor_4c_Matrizes") AND !EOF("cursor_4c_Matrizes")
6648:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6649:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6650:                 CLEAR RESOURCES
6651:                 loc_oPage.img_4c_ImgBorracha.Picture = ""
6652:                 loc_oPage.img_4c_ImgBorracha.Visible = .F.
6653:                 IF !EMPTY(cursor_4c_Matrizes.CMats)
6654:                     loc_lcSQL = "SELECT FigProcs FROM SigCdPro WHERE CPros = '" + ;
6655:                         EscaparSQL(ALLTRIM(cursor_4c_Matrizes.CMats))
6656:                     IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_BorrachaImg") > 0
6657:                         IF !EOF("cursor_4c_BorrachaImg")
6658:                             IF !EMPTY(cursor_4c_BorrachaImg.FigProcs) AND !ISNULL(cursor_4c_BorrachaImg.FigProcs)
6659:                                 IF STRTOFILE(cursor_4c_BorrachaImg.FigProcs, loc_lcArquivo) > 0
6660:                                     loc_oPage.img_4c_ImgBorracha.Visible = .T.
6661:                                     loc_oPage.img_4c_ImgBorracha.Picture = loc_lcArquivo
6662:                                 ENDIF
6663:                             ENDIF
6664:                         ENDIF
6665:                         IF USED("cursor_4c_BorrachaImg")
6666:                             USE IN cursor_4c_BorrachaImg
6667:                         ENDIF
6668:                     ENDIF
6669:                 ENDIF
6670:                 loc_oPage.grd_4c_Matrizes.Refresh()
6671:             ENDIF
6672:         CATCH TO loc_oErro
6673:             MsgErro(loc_oErro.Message, "Erro")
6674:         ENDTRY
6675:     ENDPROC
6676: 
6677:     *--------------------------------------------------------------------------
6678:     * ImgFigJpgClick - Click na imagem -> amplia em zoom (SigOpZom)
6679:     *--------------------------------------------------------------------------
6680:     PROCEDURE ImgFigJpgClick()
6681:         LOCAL loc_lcArquivo
6682:         TRY
6683:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6684:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6685:                 IF !EMPTY(cursor_4c_Fase.FigProcs) AND !ISNULL(cursor_4c_Fase.FigProcs)
6686:                     STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo)
6687:                     IF FILE(loc_lcArquivo)
6688:                         DO FORM SigOpZom WITH loc_lcArquivo, .F.
6689:                     ENDIF
6690:                 ENDIF
6691:             ENDIF
6692:         CATCH TO loc_oErro
6693:             MsgErro(loc_oErro.Message, "Erro")
6694:         ENDTRY
6695:     ENDPROC
6696: 
6697:     *--------------------------------------------------------------------------
6698:     * CmdgFiguraClick - Seleciona foto do processo via GetPict
6699:     *--------------------------------------------------------------------------
6700:     PROCEDURE CmdgFiguraClick()
6701:         LOCAL loc_lcFigura, loc_lcArquivo, loc_oPage
6702:         TRY
6703:             IF !USED("cursor_4c_Fase") OR EOF("cursor_4c_Fase")
6704:                 RETURN
6705:             ENDIF
6706:             IF THIS.this_cModoAtual = "VISUALIZAR"
6707:                 RETURN
6708:             ENDIF
6709:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6710:             loc_oPage.grd_4c_FasePro.SetFocus()
6711:             loc_lcFigura = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Nome do Arquivo:", "Selecionar")
6712:             IF !EMPTY(loc_lcFigura)
6713:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6714:                 CLEAR RESOURCES
6715:                 SELECT cursor_4c_Fase
6716:                 REPLACE FigProcs WITH FILETOSTR(loc_lcFigura) IN cursor_4c_Fase
6717:                 IF STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo) > 0
6718:                     loc_oPage.img_4c_ImgFigJpg.Visible = .T.
6719:                     loc_oPage.img_4c_ImgFigJpg.Picture = loc_lcArquivo
6720:                 ENDIF
6721:             ENDIF
6722:         CATCH TO loc_oErro
6723:             MsgErro(loc_oErro.Message, "Erro")
6724:         ENDTRY
6725:     ENDPROC
6726: 
6727:     *--------------------------------------------------------------------------
6728:     * CmdgFigCamClick - Captura foto via camera (reutiliza logica de GetPict)
6729:     *--------------------------------------------------------------------------
6730:     PROCEDURE CmdgFigCamClick()
6731:         THIS.CmdgFiguraClick()
6732:     ENDPROC
6733: 
6734:     *--------------------------------------------------------------------------
6735:     * FaseInserirClick - Insere nova linha no grd_4c_FasePro
6736:     *--------------------------------------------------------------------------
6737:     PROCEDURE FaseInserirClick()
6738:         LOCAL loc_lResultado, loc_nOrdem, loc_oPage
6739:         loc_lResultado = .F.
6740:         TRY
6741:             IF !USED("cursor_4c_Fase")
6742:                 loc_lResultado = loc_lResultado
6743:             ENDIF
6744:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6745:             SELECT cursor_4c_Fase
6746:             IF !EOF("cursor_4c_Fase")
6747:                 IF EMPTY(cursor_4c_Fase.Grupos)
6748:                     loc_oPage.grd_4c_FasePro.SetFocus()
6749:                     loc_lResultado = loc_lResultado
6750:                 ENDIF
6751:                 loc_nOrdem = cursor_4c_Fase.Ordems
6752:             ELSE
6753:                 loc_nOrdem = 0
6754:             ENDIF
6755:             *-- Incrementa ordens dos registros apos o atual
6756:             SELECT cursor_4c_Fase
6757:             SCAN FOR Ordems > loc_nOrdem
6758:                 REPLACE Ordems WITH cursor_4c_Fase.Ordems + 1 IN cursor_4c_Fase
6759:             ENDSCAN
6760:             *-- Insere nova linha com ordem logo apos o atual
6761:             INSERT INTO cursor_4c_Fase (Ordems, Grupos, Descrs, UniPrdts, TpMats, FkChaves) ;
6762:                 VALUES (loc_nOrdem + 1, "", "", "", "", "")
6763:             GO TOP IN cursor_4c_Fase
6764:             LOCATE FOR Ordems = loc_nOrdem + 1 AND EMPTY(Grupos)
6765:             loc_oPage.grd_4c_FasePro.Refresh()
6766:             loc_oPage.grd_4c_FasePro.SetFocus()
6767:             loc_lResultado = .T.
6768:         CATCH TO loc_oErro
6769:             MsgErro(loc_oErro.Message, "Erro")
6770:         ENDTRY
6771:         RETURN loc_lResultado
6772:     ENDPROC
6773: 
6774:     *--------------------------------------------------------------------------
6775:     * FaseExcluirClick - Exclui linha atual do grd_4c_FasePro
6776:     *--------------------------------------------------------------------------
6777:     PROCEDURE FaseExcluirClick()
6778:         LOCAL loc_lResultado, loc_oPage
6779:         loc_lResultado = .F.
6780:         TRY
6781:             IF !USED("cursor_4c_Fase") OR EOF("cursor_4c_Fase") OR BOF("cursor_4c_Fase")
6782:                 loc_lResultado = loc_lResultado
6783:             ENDIF
6784:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6785:             SELECT cursor_4c_Fase
6786:             DELETE IN cursor_4c_Fase
6787:             IF !EOF("cursor_4c_Fase")
6788:                 SKIP IN cursor_4c_Fase
6789:             ENDIF
6790:             IF EOF("cursor_4c_Fase")
6791:                 GO BOTTOM IN cursor_4c_Fase
6792:             ENDIF
6793:             PACK IN cursor_4c_Fase
6794:             loc_oPage.grd_4c_FasePro.Refresh()
6795:             loc_oPage.grd_4c_FasePro.SetFocus()
6796:             loc_oPage.grd_4c_FasePro.Column2.SetFocus()
6797:             loc_lResultado = .T.
6798:         CATCH TO loc_oErro
6799:             MsgErro(loc_oErro.Message, "Erro")
6800:         ENDTRY
6801:         RETURN loc_lResultado
6802:     ENDPROC
6803: 
6804:     *--------------------------------------------------------------------------
6805:     * FaseAlternativaClick - Insere fase alternativa (mesma ordem do atual)
6806:     *--------------------------------------------------------------------------
6807:     PROCEDURE FaseAlternativaClick()
6808:         LOCAL loc_lResultado, loc_nOrdem, loc_oPage
6809:         loc_lResultado = .F.
6810:         TRY
6811:             IF !USED("cursor_4c_Fase")
6812:                 loc_lResultado = loc_lResultado
6813:             ENDIF
6814:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6815:             SELECT cursor_4c_Fase
6816:             IF EOF("cursor_4c_Fase") OR BOF("cursor_4c_Fase")
6817:                 loc_oPage.grd_4c_FasePro.SetFocus()
6818:                 loc_lResultado = loc_lResultado
6819:             ENDIF
6820:             loc_nOrdem = cursor_4c_Fase.Ordems
6821:             *-- Insere linha alternativa com mesma ordem (alternativa ao atual)
6822:             INSERT INTO cursor_4c_Fase (Ordems, Grupos, Descrs, UniPrdts, TpMats, FkChaves) ;
6823:                 VALUES (loc_nOrdem, "", "", "", "", "")
6824:             GO TOP IN cursor_4c_Fase
6825:             LOCATE FOR Ordems = loc_nOrdem AND EMPTY(Grupos)
6826:             loc_oPage.grd_4c_FasePro.Refresh()
6827:             loc_oPage.grd_4c_FasePro.SetFocus()
6828:             loc_lResultado = .T.
6829:         CATCH TO loc_oErro
6830:             MsgErro(loc_oErro.Message, "Erro")
6831:         ENDTRY
6832:         RETURN loc_lResultado
6833:     ENDPROC
6834: 
6835:     *--------------------------------------------------------------------------
6836:     * CmdFichaClick - Abre Ficha Tecnica do produto
6837:     *--------------------------------------------------------------------------
6838:     PROCEDURE CmdFichaClick()
6839:         LOCAL loc_lResultado
6840:         loc_lResultado = .F.
6841:         TRY
6842:             MsgAviso("Ficha T" + CHR(233) + "cnica n" + CHR(227) + "o dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", ;
6843:                 "Ficha T" + CHR(233) + "cnica")
6844:         CATCH TO loc_oErro
6845:             MsgErro(loc_oErro.Message, "Erro")
6846:         ENDTRY
6847:         RETURN loc_lResultado
6848:     ENDPROC
6849: 
6850:     *--------------------------------------------------------------------------
6851:     * FaseGrdCol2Valid - Valid do Column2 (Fase/Grupos) do grd_4c_FasePro
6852:     * Lookup: SigCdGcr (Codigos / Descrs)
6853:     *--------------------------------------------------------------------------
6854:     PROCEDURE FaseGrdCol2Valid(par_nColIndex)
6855:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_cDescr, loc_lcSQL
6856:         loc_lResultado = .T.
6857:         TRY
6858:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
6859:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column2.Text1.Value, ""))
6860:             IF EMPTY(loc_cCodigo)
6861:                 loc_lResultado = loc_lResultado
6862:             ENDIF
6863:             loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
6864:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGcr") <= 0 OR EOF("cursor_4c_ValGcr")
6865:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6866:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValGcr"
6867:                 loc_oLookup.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
6868:                 loc_oLookup.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
6869:                 loc_oLookup.cTabela     = "SigCdGcr"
6870:                 loc_oLookup.cCampoChave = "Codigos"
6871:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6872:                 loc_oLookup.Show()
6873:                 IF loc_oLookup.this_lSelecionou
6874:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6875:                     loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
6876:                     IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGcr") > 0 AND !EOF("cursor_4c_ValGcr")
6877:                         loc_cDescr = ALLTRIM(NVL(cursor_4c_ValGcr.Descrs, ""))
6878:                     ELSE
6879:                         loc_cDescr = ""
6880:                     ENDIF
6881:                 ELSE
6882:                     loc_cCodigo = ""
6883:                     loc_cDescr  = ""
6884:                 ENDIF
6885:                 IF USED("cursor_4c_ValGcr")
6886:                     USE IN cursor_4c_ValGcr
6887:                 ENDIF
6888:             ELSE
6889:                 loc_cDescr = ALLTRIM(NVL(cursor_4c_ValGcr.Descrs, ""))
6890:                 IF USED("cursor_4c_ValGcr")
6891:                     USE IN cursor_4c_ValGcr
6892:                 ENDIF
6893:             ENDIF
6894:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6895:                 SELECT cursor_4c_Fase
6896:                 REPLACE Grupos WITH PADR(loc_cCodigo, 10) IN cursor_4c_Fase
6897:                 REPLACE Descrs WITH PADR(loc_cDescr,  40) IN cursor_4c_Fase
6898:                 loc_oGrd.Column2.Text1.Value = loc_cCodigo
6899:                 loc_oGrd.Column3.Text1.Value = loc_cDescr
6900:             ENDIF
6901:         CATCH TO loc_oErro
6902:             MsgErro(loc_oErro.Message, "Erro")
6903:         ENDTRY
6904:         RETURN loc_lResultado
6905:     ENDPROC
6906: 
6907:     *--------------------------------------------------------------------------
6908:     * FaseGrdCol4Valid - Valid do Column4 (Uni. Produtiva/UniPrdts) do grd_4c_FasePro
6909:     * Lookup: SigCdUpd (UniPrdts) filtrado pelo Grupo atual
6910:     *--------------------------------------------------------------------------
6911:     PROCEDURE FaseGrdCol4Valid(par_nColIndex)
6912:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_cGrupo, loc_lcSQL
6913:         loc_lResultado = .T.
6914:         TRY
6915:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
6916:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column4.Text1.Value, ""))
6917:             IF EMPTY(loc_cCodigo)
6918:                 loc_lResultado = loc_lResultado
6919:             ENDIF
6920:             loc_cGrupo = ""
6921:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6922:                 loc_cGrupo = ALLTRIM(cursor_4c_Fase.Grupos)
6923:             ENDIF
6924:             IF !EMPTY(loc_cGrupo)
6925:                 loc_lcSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupo)
6926:             ELSE
6927:                 loc_lcSQL = "SELECT UniPrdts FROM SigCdUpd"
6928:             ENDIF
6929:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValUpd") <= 0
6930:                 IF USED("cursor_4c_ValUpd")
6931:                     USE IN cursor_4c_ValUpd
6932:                 ENDIF
6933:                 loc_lResultado = loc_lResultado
6934:             ENDIF
6935:             SELECT cursor_4c_ValUpd
6936:             LOCATE FOR ALLTRIM(UniPrdts) = loc_cCodigo
6937:             IF EOF("cursor_4c_ValUpd")
6938:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6939:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValUpd"
6940:                 loc_oLookup.mAddColuna("UniPrdts", "", "Uni. Produtiva")
6941:                 loc_oLookup.cTabela     = "SigCdUpd"
6942:                 loc_oLookup.cCampoChave = "UniPrdts"
6943:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6944:                 loc_oLookup.Show()
6945:                 IF loc_oLookup.this_lSelecionou
6946:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6947:                 ELSE
6948:                     loc_cCodigo = ""
6949:                 ENDIF
6950:             ENDIF
6951:             IF USED("cursor_4c_ValUpd")
6952:                 USE IN cursor_4c_ValUpd
6953:             ENDIF
6954:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6955:                 SELECT cursor_4c_Fase
6956:                 REPLACE UniPrdts WITH PADR(loc_cCodigo, 10) IN cursor_4c_Fase
6957:                 loc_oGrd.Column4.Text1.Value = loc_cCodigo
6958:             ENDIF
6959:         CATCH TO loc_oErro
6960:             MsgErro(loc_oErro.Message, "Erro")
6961:         ENDTRY
6962:         RETURN loc_lResultado
6963:     ENDPROC
6964: 
6965:     *--------------------------------------------------------------------------
6966:     * FaseGrdCol5Valid - Valid do Column5 (Material/TpMats) do grd_4c_FasePro
6967:     * Lookup: SigOpOpt (Cods / Descs)
6968:     *--------------------------------------------------------------------------
6969:     PROCEDURE FaseGrdCol5Valid(par_nColIndex)
6970:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
6971:         loc_lResultado = .T.
6972:         TRY
6973:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
6974:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column5.Text1.Value, ""))
6975:             IF EMPTY(loc_cCodigo)
6976:                 loc_lResultado = loc_lResultado
6977:             ENDIF
6978:             loc_lcSQL = "SELECT Cods, Descs FROM SigOpOpt WHERE Cods = " + EscaparSQL(loc_cCodigo)
6979:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOpt") <= 0 OR EOF("cursor_4c_ValOpt")
6980:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6981:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValOpt"
6982:                 loc_oLookup.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
6983:                 loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
6984:                 loc_oLookup.cTabela     = "SigOpOpt"
6985:                 loc_oLookup.cCampoChave = "Cods"
6986:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6987:                 loc_oLookup.Show()
6988:                 IF loc_oLookup.this_lSelecionou
6989:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6990:                 ELSE
6991:                     loc_cCodigo = ""
6992:                 ENDIF
6993:             ENDIF
6994:             IF USED("cursor_4c_ValOpt")
6995:                 USE IN cursor_4c_ValOpt
6996:             ENDIF
6997:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6998:                 SELECT cursor_4c_Fase
6999:                 REPLACE TpMats WITH PADR(loc_cCodigo, 3) IN cursor_4c_Fase
7000:                 loc_oGrd.Column5.Text1.Value = loc_cCodigo
7001:             ENDIF
7002:             loc_oGrd.Refresh()
7003:         CATCH TO loc_oErro
7004:             MsgErro(loc_oErro.Message, "Erro")
7005:         ENDTRY
7006:         RETURN loc_lResultado
7007:     ENDPROC
7008: 
7009:     *--------------------------------------------------------------------------
7010:     * ValidarAcabamento - LostFocus do txt_4c_CodAcb
7011:     * Lookup: SigCdAca (Cods / Descrs) -> preenche txt_4c_Dacb
7012:     *--------------------------------------------------------------------------
7013:     PROCEDURE ValidarAcabamento()
7014:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_cDescr, loc_lcSQL
7015:         loc_lResultado = .T.
7016:         TRY
7017:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7018:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_CodAcb.Value, ""))
7019:             IF loc_cCodigo == THIS.this_cUltimoAcabamentoValidado
7020:                 loc_lResultado = loc_lResultado
7021:             ENDIF
7022:             IF EMPTY(loc_cCodigo)
7023:                 loc_oPage.txt_4c_Dacb.Value = ""
7024:                 loc_lResultado = loc_lResultado
7025:             ENDIF
7026:             loc_lcSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Cods = " + EscaparSQL(loc_cCodigo)
7027:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAca") <= 0 OR EOF("cursor_4c_ValAca")
7028:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7029:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValAca"
7030:                 loc_oLookup.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
7031:                 loc_oLookup.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7032:                 loc_oLookup.cTabela     = "SigCdAca"
7033:                 loc_oLookup.cCampoChave = "Cods"
7034:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7035:                 loc_oLookup.Show()
7036:                 IF loc_oLookup.this_lSelecionou
7037:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7038:                     loc_lcSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Cods = " + EscaparSQL(loc_cCodigo)
7039:                     IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAca") > 0 AND !EOF("cursor_4c_ValAca")
7040:                         loc_cDescr = ALLTRIM(NVL(cursor_4c_ValAca.Descrs, ""))
7041:                     ELSE
7042:                         loc_cDescr = ""
7043:                     ENDIF
7044:                 ELSE
7045:                     loc_cCodigo = ""
7046:                     loc_cDescr  = ""
7047:                 ENDIF
7048:             ELSE
7049:                 loc_cDescr = ALLTRIM(NVL(cursor_4c_ValAca.Descrs, ""))
7050:             ENDIF
7051:             IF USED("cursor_4c_ValAca")
7052:                 USE IN cursor_4c_ValAca
7053:             ENDIF
7054:             loc_oPage.txt_4c_CodAcb.Value = loc_cCodigo
7055:             loc_oPage.txt_4c_Dacb.Value   = loc_cDescr
7056:             THIS.this_cUltimoAcabamentoValidado = loc_cCodigo
7057:         CATCH TO loc_oErro
7058:             MsgErro(loc_oErro.Message, "Erro")
7059:         ENDTRY
7060:         RETURN loc_lResultado
7061:     ENDPROC
7062: 
7063:     *--------------------------------------------------------------------------
7064:     * ValidarConquilha - LostFocus do txt_4c_Conquilha
7065:     * Lookup: SigCdCnq (conquilhas)
7066:     *--------------------------------------------------------------------------
7067:     PROCEDURE ValidarConquilha()
7068:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cValor, loc_lcSQL
7069:         LOCAL loc_cValorAtual
7070:         loc_lResultado = .T.
7071:         loc_cValorAtual = ""
7072:         TRY
7073:             loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7074:             loc_cValor = ALLTRIM(NVL(loc_oPage.txt_4c_Conquilha.Value, ""))
7075:             loc_cValorAtual = loc_cValor
7076:             IF loc_cValorAtual == THIS.this_cUltimoConquilhaValidado
7077:                 loc_lResultado = loc_lResultado
7078:             ENDIF
7079:             IF EMPTY(loc_cValor)
7080:                 loc_lResultado = loc_lResultado
7081:             ENDIF
7082:             loc_lcSQL = "SELECT conquilhas FROM SigCdCnq GROUP BY conquilhas"
7083:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCnq") > 0
7084:                 SELECT cursor_4c_ValCnq
7085:                 LOCATE FOR ALLTRIM(conquilhas) = loc_cValor
7086:                 IF EOF("cursor_4c_ValCnq")
7087:                     loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7088:                     loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaConq"
7089:                     loc_oLookup.mAddColuna("conquilhas", "", "Conquilhas")
7090:                     loc_oLookup.cTabela     = "SigCdCnq"
7091:                     loc_oLookup.cCampoChave = "conquilhas"
7092:                     loc_oLookup.cFiltroIni  = loc_cValor
7093:                     loc_oLookup.Show()
7094:                     IF loc_oLookup.this_lSelecionou
7095:                         loc_cValor = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7096:                     ELSE
7097:                         loc_cValor = ""
7098:                     ENDIF
7099:                 ENDIF
7100:                 IF USED("cursor_4c_ValCnq")
7101:                     USE IN cursor_4c_ValCnq
7102:                 ENDIF
7103:             ENDIF
7104:             loc_oPage.txt_4c_Conquilha.Value = loc_cValor
7105:             THIS.this_cUltimoConquilhaValidado = loc_cValor
7106:         CATCH TO loc_oErro
7107:             MsgErro(loc_oErro.Message, "Erro")
7108:         ENDTRY
7109:         RETURN loc_lResultado
7110:     ENDPROC
7111: 
7112:     *--------------------------------------------------------------------------
7113:     * ValidarCor - LostFocus do txt_4c_Cor
7114:     * Lookup: SigCdCor (Cods / Descs)
7115:     *--------------------------------------------------------------------------
7116:     PROCEDURE ValidarCor()
7117:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
7118:         loc_lResultado = .T.
7119:         TRY
7120:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7121:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Cor.Value, ""))
7122:             IF loc_cCodigo == THIS.this_cUltimoCorValidado
7123:                 loc_lResultado = loc_lResultado
7124:             ENDIF
7125:             IF EMPTY(loc_cCodigo)
7126:                 loc_lResultado = loc_lResultado
7127:             ENDIF
7128:             loc_lcSQL = "SELECT Cods FROM SigCdCor WHERE Cods = " + EscaparSQL(loc_cCodigo)
7129:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCor") <= 0 OR EOF("cursor_4c_ValCor")
7130:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7131:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValCor"
7132:                 loc_oLookup.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
7133:                 loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7134:                 loc_oLookup.cTabela     = "SigCdCor"
7135:                 loc_oLookup.cCampoChave = "Cods"
7136:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7137:                 loc_oLookup.Show()
7138:                 IF loc_oLookup.this_lSelecionou
7139:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7140:                 ELSE
7141:                     loc_cCodigo = ""
7142:                 ENDIF
7143:             ENDIF
7144:             IF USED("cursor_4c_ValCor")
7145:                 USE IN cursor_4c_ValCor
7146:             ENDIF
7147:             loc_oPage.txt_4c_Cor.Value = loc_cCodigo
7148:             loc_oPage.txt_4c_Cor.Refresh()
7149:             THIS.this_cUltimoCorValidado = loc_cCodigo
7150:         CATCH TO loc_oErro
7151:             MsgErro(loc_oErro.Message, "Erro")
7152:         ENDTRY
7153:         RETURN loc_lResultado
7154:     ENDPROC
7155: 
7156:     *--------------------------------------------------------------------------
7157:     * ValidarTam - LostFocus do txt_4c_Tam
7158:     * Lookup: SigCdTam (Cods / Descs)
7159:     *--------------------------------------------------------------------------
7160:     PROCEDURE ValidarTam()
7161:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
7162:         loc_lResultado = .T.
7163:         TRY
7164:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7165:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Tam.Value, ""))
7166:             IF loc_cCodigo == THIS.this_cUltimoTamValidado
7167:                 loc_lResultado = loc_lResultado
7168:             ENDIF
7169:             IF EMPTY(loc_cCodigo)
7170:                 loc_lResultado = loc_lResultado
7171:             ENDIF
7172:             loc_lcSQL = "SELECT Cods FROM SigCdTam WHERE Cods = " + EscaparSQL(loc_cCodigo)
7173:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTam") <= 0 OR EOF("cursor_4c_ValTam")
7174:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7175:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValTam"
7176:                 loc_oLookup.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
7177:                 loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7178:                 loc_oLookup.cTabela     = "SigCdTam"
7179:                 loc_oLookup.cCampoChave = "Cods"
7180:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7181:                 loc_oLookup.Show()
7182:                 IF loc_oLookup.this_lSelecionou
7183:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7184:                 ELSE
7185:                     loc_cCodigo = ""
7186:                 ENDIF
7187:             ENDIF
7188:             IF USED("cursor_4c_ValTam")
7189:                 USE IN cursor_4c_ValTam
7190:             ENDIF
7191:             loc_oPage.txt_4c_Tam.Value = loc_cCodigo
7192:             loc_oPage.txt_4c_Tam.Refresh()
7193:             THIS.this_cUltimoTamValidado = loc_cCodigo
7194:         CATCH TO loc_oErro
7195:             MsgErro(loc_oErro.Message, "Erro")
7196:         ENDTRY
7197:         RETURN loc_lResultado
7198:     ENDPROC
7199: 
7200:     *--------------------------------------------------------------------------
7201:     * BtnInsereMtxClick - Insere nova linha no grd_4c_Matrizes
7202:     *--------------------------------------------------------------------------
7203:     PROCEDURE BtnInsereMtxClick()
7204:         LOCAL loc_lResultado, loc_oPage
7205:         loc_lResultado = .F.
7206:         TRY
7207:             IF !USED("cursor_4c_Matrizes")
7208:                 loc_lResultado = loc_lResultado
7209:             ENDIF
7210:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7211:             SELECT cursor_4c_Matrizes
7212:             *-- Localiza linha vazia (placeholder); se nao houver, insere uma nova
7213:             GO TOP IN cursor_4c_Matrizes
7214:             LOCATE FOR EMPTY(cursor_4c_Matrizes.CMats)
7215:             IF EOF("cursor_4c_Matrizes")
7216:                 INSERT INTO cursor_4c_Matrizes (CMats, Locals, QMatz, CPros, cIdChaves, DPros) ;
7217:                     VALUES ("", "", 0, "", "", "")
7218:             ENDIF
7219:             loc_oPage.grd_4c_Matrizes.Refresh()
7220:             loc_oPage.grd_4c_Matrizes.SetFocus()
7221:             loc_oPage.grd_4c_Matrizes.Column1.SetFocus()
7222:             loc_lResultado = .T.
7223:         CATCH TO loc_oErro
7224:             MsgErro(loc_oErro.Message, "Erro")
7225:         ENDTRY
7226:         RETURN loc_lResultado
7227:     ENDPROC
7228: 
7229:     *--------------------------------------------------------------------------
7230:     * BtnExcluiMtzClick - Exclui linha atual do grd_4c_Matrizes
7231:     * Garante sempre ao menos uma linha vazia no cursor
7232:     *--------------------------------------------------------------------------
7233:     PROCEDURE BtnExcluiMtzClick()
7234:         LOCAL loc_lResultado, loc_oPage
7235:         loc_lResultado = .F.
7236:         TRY
7237:             IF !USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes")
7238:                 loc_lResultado = loc_lResultado
7239:             ENDIF
7240:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7241:             SELECT cursor_4c_Matrizes
7242:             DELETE IN cursor_4c_Matrizes
7243:             PACK IN cursor_4c_Matrizes
7244:             *-- Garante sempre ao menos uma linha vazia
7245:             GO TOP IN cursor_4c_Matrizes
7246:             LOCATE FOR EMPTY(cursor_4c_Matrizes.CMats)
7247:             IF EOF("cursor_4c_Matrizes")
7248:                 INSERT INTO cursor_4c_Matrizes (CMats, Locals, QMatz, CPros, cIdChaves, DPros) ;
7249:                     VALUES ("", "", 0, "", "", "")
7250:             ENDIF
7251:             loc_oPage.grd_4c_Matrizes.Refresh()
7252:             loc_oPage.grd_4c_Matrizes.SetFocus()
7253:             loc_oPage.grd_4c_Matrizes.Column1.SetFocus()
7254:             loc_lResultado = .T.
7255:         CATCH TO loc_oErro
7256:             MsgErro(loc_oErro.Message, "Erro")
7257:         ENDTRY
7258:         RETURN loc_lResultado
7259:     ENDPROC
7260: 
7261:     *--------------------------------------------------------------------------
7262:     * MatrizGrdCol1Valid - Valid do Column1 (Matriz/CMats) do grd_4c_Matrizes
7263:     * Lookup: SigCdPro (CPros / DPros) - produto usado como matriz
7264:     *--------------------------------------------------------------------------
7265:     PROCEDURE MatrizGrdCol1Valid(par_nColIndex)
7266:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
7267:         loc_lResultado = .T.
7268:         TRY
7269:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_Matrizes
7270:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column1.Text1.Value, ""))
7271:             IF EMPTY(loc_cCodigo)
7272:                 loc_lResultado = loc_lResultado
7273:             ENDIF
7274:             loc_lcSQL = "SELECT CPros, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCodigo)
7275:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValMtz") <= 0 OR EOF("cursor_4c_ValMtz")
7276:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7277:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValMtz"
7278:                 loc_oLookup.mAddColuna("CPros", "", "Matriz")
7279:                 loc_oLookup.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
7280:                 loc_oLookup.cTabela     = "SigCdPro"
7281:                 loc_oLookup.cCampoChave = "CPros"
7282:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7283:                 loc_oLookup.Show()
7284:                 IF loc_oLookup.this_lSelecionou
7285:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7286:                 ELSE
7287:                     loc_cCodigo = ""
7288:                 ENDIF
7289:             ENDIF
7290:             IF USED("cursor_4c_ValMtz")
7291:                 USE IN cursor_4c_ValMtz
7292:             ENDIF
7293:             IF USED("cursor_4c_Matrizes") AND !EOF("cursor_4c_Matrizes")
7294:                 SELECT cursor_4c_Matrizes
7295:                 REPLACE CMats WITH PADR(loc_cCodigo, 14) IN cursor_4c_Matrizes
7296:                 loc_oGrd.Column1.Text1.Value = loc_cCodigo
7297:                 loc_oGrd.Refresh()
7298:             ENDIF
7299:         CATCH TO loc_oErro
7300:             MsgErro(loc_oErro.Message, "Erro")
7301:         ENDTRY
7302:         RETURN loc_lResultado
7303:     ENDPROC
7304: 
7305:     *--------------------------------------------------------------------------
7306:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
7307:     * par_oContainer: container a processar (Page1, Page2, etc.)
7308:     *--------------------------------------------------------------------------
7309:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
7310:         LOCAL loc_nI, loc_oObjeto, loc_nP
7311: 
7312:         FOR loc_nI = 1 TO par_oContainer.ControlCount
7313:             loc_oObjeto = par_oContainer.Controls(loc_nI)
7314: 
7315:             IF VARTYPE(loc_oObjeto) = "O"
7316:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
7317:                     *-- Nao forcar visivel containers ocultos intencionais
7318:                     IF NOT INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")
7319:                         loc_oObjeto.Visible = .T.
7320:                     ENDIF
7321:                 ENDIF
7322: 
7323:                 *-- Itera Pages de PageFrame
7324:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
7325:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
7326:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
7327:                     ENDFOR
7328:                 ENDIF
7329: 
7330:                 *-- Itera containers com ControlCount
7331:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
7332:                     THIS.TornarControlesVisiveis(loc_oObjeto)
7333:                 ENDIF
7334:             ENDIF
7335:         ENDFOR
7336:     ENDPROC
7337: 
7338:     *--------------------------------------------------------------------------
7339:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
7340:     *--------------------------------------------------------------------------
7341:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
7342:         THIS.pgf_4c_Paginas.Visible   = .T.
7343:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
7344: 
7345:         IF par_nPagina = 1
7346:             THIS.AjustarBotoesPorModo()
7347:             THIS.CarregarLista()
7348:         ENDIF
7349:     ENDPROC
7350: 
7351:     *--------------------------------------------------------------------------
7352:     * CarregarLista - Busca registros do SigPrFtp com JOIN SigCdPro
7353:     *--------------------------------------------------------------------------
7354:     PROCEDURE CarregarLista()
7355:         LOCAL loc_lResultado, loc_cSQL, loc_cWhere
7356:         loc_lResultado = .F.
7357: 
7358:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
7359:             RETURN loc_lResultado
7360:         ENDIF
7361: 
7362:         TRY
7363:             loc_cWhere = THIS.MontarFiltro()
7364: 
7365:             loc_cSQL = "SELECT t.pkchaves, t.cpros, " + ;
7366:                 "ISNULL(p.dpros,'') AS dpros, " + ;
7367:                 "t.cgrus, t.cods, " + ;
7368:                 "ISNULL(p.reffs,'') AS reffs, " + ;
7369:                 "ISNULL(p.usuincs,'') AS usuincs, " + ;
7370:                 "ISNULL(p.situas,0) AS situas " + ;
7371:                 "FROM sigprftp t " + ;
7372:                 "LEFT JOIN SigCdPro p ON p.cpros = t.cpros "
7373: 
7374:             IF !EMPTY(loc_cWhere)
7375:                 loc_cSQL = loc_cSQL + "WHERE " + loc_cWhere + " "
7376:             ENDIF
7377: 
7378:             loc_cSQL = loc_cSQL + "ORDER BY t.cpros"
7379: 
7380:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp") > 0
7381:                 LOCAL loc_oGrd
7382:                 loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
7383: 
7384:                 IF !USED("cursor_4c_Dados")
7385:                     SET NULL ON
7386:                     CREATE CURSOR cursor_4c_Dados (pkchaves C(20), cpros C(14), dpros C(40), cgrus C(3), cods C(2), reffs C(20), usuincs C(10), situas N(1,0))
7387:                     SET NULL OFF
7388:                 ELSE
7389:                     ZAP IN cursor_4c_Dados
7390:                 ENDIF
7391:                 IF !EOF("cursor_4c_DadosTemp")
7392:                     SELECT cursor_4c_DadosTemp
7393:                     APPEND FROM DBF("cursor_4c_DadosTemp")
7394:                 ENDIF

*-- Linhas 7494 a 7601:
7494:     * FormatarGridLista - Formata visual do grid (FontName/Size)
7495:     * RecordSource + ControlSource ja definidos em CarregarLista
7496:     *--------------------------------------------------------------------------
7497:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
7498:         WITH par_oGrid
7499:             IF .ColumnCount > 0
7500:                 .FontName = "Arial"
7501:                 .FontSize = 8
7502:             ENDIF
7503:         ENDWITH
7504:     ENDPROC
7505: 
7506:     *--------------------------------------------------------------------------
7507:     * AtualizarContagemProdutos - Atualiza label de contagem
7508:     *--------------------------------------------------------------------------
7509:     PROTECTED PROCEDURE AtualizarContagemProdutos()
7510:         LOCAL loc_nTotal
7511:         loc_nTotal = 0
7512: 
7513:         TRY
7514:             IF USED("cursor_4c_Dados")
7515:                 loc_nTotal = RECCOUNT("cursor_4c_Dados")
7516:             ENDIF
7517:             THIS.pgf_4c_Paginas.Page1.lbl_4c_Produtos.Caption = ;
7518:                 "Produtos Selecionados : " + TRANSFORM(loc_nTotal)
7519:         CATCH TO loc_oErro
7520:             MsgErro(loc_oErro.Message, "Erro ao atualizar contagem")
7521:         ENDTRY
7522:     ENDPROC
7523: 
7524:     *--------------------------------------------------------------------------
7525:     * FormParaBO - Transfere dados do formulario para o BO
7526:     * Fase 5: cpros/cgrus/cods mapeados para SigPrFtp
7527:     * Campos SigCdPro (DPro2s, Cbar, Lin, Col, Ifor, Refs) serao
7528:     * persistidos em fase futura (Phase 7) via SQL direto em SigCdPro
7529:     *--------------------------------------------------------------------------
7530:     PROTECTED PROCEDURE FormParaBO()
7531:         LOCAL loc_oPg
7532:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7533: 
7534:         THIS.this_oBusinessObject.this_cCpros = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
7535:         THIS.this_oBusinessObject.this_cCgrus = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
7536:         THIS.this_oBusinessObject.this_cCods  = ALLTRIM(loc_oPg.txt_4c_Cods.Value)
7537:         *-- coefs/valors: sem controle visual em pgDados -> mantidos como 0 no BO
7538:         *-- pkchaves: gerado em BtnSalvarClick, nao vem do form
7539:     ENDPROC
7540: 
7541:     *--------------------------------------------------------------------------
7542:     * BOParaForm - Transfere dados do BO para o formulario
7543:     * Fase 5: preenche SigPrFtp e carrega descritivos de SigCdPro
7544:     *--------------------------------------------------------------------------
7545:     PROTECTED PROCEDURE BOParaForm()
7546:         LOCAL loc_oPg
7547:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7548: 
7549:         loc_oPg.txt_4c_Cpros.Value = THIS.this_oBusinessObject.this_cCpros
7550:         loc_oPg.txt_4c_Cgrus.Value = THIS.this_oBusinessObject.this_cCgrus
7551:         loc_oPg.txt_4c_Cods.Value  = THIS.this_oBusinessObject.this_cCods
7552: 
7553:         *-- Carregar todos os descritivos do SigCdPro vinculado
7554:         THIS.CarregarDadosSigCdPro(THIS.this_oBusinessObject.this_cCpros)
7555:     ENDPROC
7556: 
7557:     *--------------------------------------------------------------------------
7558:     * CarregarDadosSigCdPro - Busca e preenche campos de exibicao do SigCdPro
7559:     * par_cCpros: codigo do produto
7560:     *--------------------------------------------------------------------------
7561:     PROTECTED PROCEDURE CarregarDadosSigCdPro(par_cCpros)
7562:         LOCAL loc_cSQL, loc_oPg
7563:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7564: 
7565:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
7566:             RETURN
7567:         ENDIF
7568: 
7569:         *-- Limpar campos de exibicao (Fase 5)
7570:         loc_oPg.txt_4c_Dpros.Value        = ""
7571:         loc_oPg.txt_4c_DPro2s.Value       = ""
7572:         loc_oPg.txt_4c_Cbar.Value         = ""
7573:         loc_oPg.txt_4c_DgruDisplay.Value  = ""
7574:         loc_oPg.txt_4c_DcodsDisplay.Value = ""
7575:         loc_oPg.txt_4c_Lin.Value          = ""
7576:         loc_oPg.txt_4c_DLinDisplay.Value  = ""
7577:         loc_oPg.txt_4c_Col.Value          = ""
7578:         loc_oPg.txt_4c_DColDisplay.Value  = ""
7579:         loc_oPg.txt_4c_Ifor.Value         = ""
7580:         loc_oPg.txt_4c_DforDisplay.Value  = ""
7581:         loc_oPg.txt_4c_Refs.Value         = ""
7582:         *-- Limpar campos de exibicao (Fase 6)
7583:         loc_oPg.txt_4c_Cor.Value          = ""
7584:         loc_oPg.txt_4c_Tam.Value          = ""
7585:         loc_oPg.txt_4c_CodFinP.Value      = ""
7586:         loc_oPg.txt_4c_DesFinP.Value      = ""
7587:         loc_oPg.txt_4c_PesoB.Value        = 0.0
7588:         loc_oPg.txt_4c_CodAcb.Value       = ""
7589:         loc_oPg.txt_4c_DacbDisplay.Value  = ""
7590:         loc_oPg.txt_4c_Pmedio.Value       = 0.0
7591:         loc_oPg.txt_4c_Class.Value        = ""
7592:         loc_oPg.txt_4c_DClassDisplay.Value = ""
7593:         loc_oPg.txt_4c_Local.Value        = ""
7594:         loc_oPg.txt_4c_Ctotal.Value       = 0.0
7595:         loc_oPg.txt_4c_Mctotal.Value      = ""
7596:         loc_oPg.txt_4c_Cuni.Value         = ""
7597:         loc_oPg.txt_4c_DuniDisplay.Value  = ""
7598:         loc_oPg.txt_4c_Cunip.Value        = ""
7599:         loc_oPg.txt_4c_DunipDisplay.Value = ""
7600:         loc_oPg.txt_4c_Pvenda.Value       = 0.0
7601:         loc_oPg.txt_4c_Mpvenda.Value      = ""

*-- Linhas 7644 a 7668:
7644:         loc_oPg3Clear.txt_4c_Mvalor.Value     = ""
7645:         loc_oPg3Clear.txt_4c_Teor.Value       = ""
7646:         loc_oPg3Clear.txt_4c_DesTeor.Value    = ""
7647:         loc_oPg3Clear.txt_4c_IPPTCST.Value    = ""
7648:         *-- Limpar grid sigcdcmv
7649:         IF USED("cursor_4c_Cmv")
7650:             USE IN cursor_4c_Cmv
7651:         ENDIF
7652:         SET NULL ON
7653:         CREATE CURSOR cursor_4c_Cmv (datas C(7), valcuss N(10,2), moedas C(3))
7654:         SET NULL OFF
7655:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.grd_4c_Dados.Refresh()
7656: 
7657:         IF EMPTY(par_cCpros)
7658:             RETURN
7659:         ENDIF
7660: 
7661:         TRY
7662:             *-- Fase 5+6: colunas corretas de SigCdPro (linhas=linha, colecoes=col.venda)
7663:             loc_cSQL = "SELECT p.dpros, ISNULL(p.dpro2s,'') AS dpro2s, " + ;
7664:                 "ISNULL(p.cbars,'') AS cbars, " + ;
7665:                 "ISNULL(p.cgrus,'') AS cgrus, " + ;
7666:                 "ISNULL(p.linhas,'') AS linhas, " + ;
7667:                 "ISNULL(p.colecoes,'') AS colecoes, " + ;
7668:                 "ISNULL(p.ifors,'') AS ifors, ISNULL(p.reffs,'') AS reffs, " + ;

*-- Linhas 7814 a 8234:
7814:     *--------------------------------------------------------------------------
7815:     * AtualizarDescricaoProduto - Compatibilidade: delega para CarregarDadosSigCdPro
7816:     *--------------------------------------------------------------------------
7817:     PROTECTED PROCEDURE AtualizarDescricaoProduto(par_cCpros)
7818:         THIS.CarregarDadosSigCdPro(par_cCpros)
7819:     ENDPROC
7820: 
7821:     *--------------------------------------------------------------------------
7822:     * CarregarDescGrupo - Carrega descricao do grupo (SigCdGrp)
7823:     *--------------------------------------------------------------------------
7824:     PROTECTED PROCEDURE CarregarDescGrupo(par_cCgrus)
7825:         LOCAL loc_cSQL, loc_oPg
7826:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7827: 
7828:         IF EMPTY(par_cCgrus)
7829:             loc_oPg.txt_4c_DgruDisplay.Value = ""
7830:             RETURN
7831:         ENDIF
7832: 
7833:         TRY
7834:             loc_cSQL = "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(par_cCgrus)
7835:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescGru") > 0
7836:                 IF !EOF("cursor_4c_DescGru")
7837:                     SELECT cursor_4c_DescGru
7838:                     loc_oPg.txt_4c_DgruDisplay.Value = ALLTRIM(dgrus)
7839:                 ELSE
7840:                     loc_oPg.txt_4c_DgruDisplay.Value = ""
7841:                 ENDIF
7842:                 IF USED("cursor_4c_DescGru")
7843:                     USE IN cursor_4c_DescGru
7844:                 ENDIF
7845:             ENDIF
7846:         CATCH TO loc_oErro
7847:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
7848:         ENDTRY
7849:     ENDPROC
7850: 
7851:     *--------------------------------------------------------------------------
7852:     * CarregarDescCods - Carrega descricao do subgrupo (via SigCdGrp ou tabela propria)
7853:     *--------------------------------------------------------------------------
7854:     PROTECTED PROCEDURE CarregarDescCods(par_cCods)
7855:         LOCAL loc_oPg, loc_cSQL
7856:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7857: 
7858:         IF EMPTY(par_cCods)
7859:             loc_oPg.txt_4c_DcodsDisplay.Value = ""
7860:             RETURN
7861:         ENDIF
7862: 
7863:         TRY
7864:             loc_cSQL = "SELECT dgrus AS descSubGrupo FROM SigCdGrp WHERE cgrus = " + EscaparSQL(par_cCods)
7865:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCods") > 0
7866:                 IF !EOF("cursor_4c_DescCods")
7867:                     SELECT cursor_4c_DescCods
7868:                     loc_oPg.txt_4c_DcodsDisplay.Value = ALLTRIM(descSubGrupo)
7869:                 ELSE
7870:                     loc_oPg.txt_4c_DcodsDisplay.Value = ""
7871:                 ENDIF
7872:                 IF USED("cursor_4c_DescCods")
7873:                     USE IN cursor_4c_DescCods
7874:                 ENDIF
7875:             ELSE
7876:                 loc_oPg.txt_4c_DcodsDisplay.Value = ""
7877:             ENDIF
7878:         CATCH TO loc_oErro
7879:             MsgErro(loc_oErro.Message, "Erro ao buscar subgrupo")
7880:         ENDTRY
7881:     ENDPROC
7882: 
7883:     *--------------------------------------------------------------------------
7884:     * CarregarDescLin - Carrega descricao da linha (SigCdLin, PK=linhas, desc=descs)
7885:     *--------------------------------------------------------------------------
7886:     PROTECTED PROCEDURE CarregarDescLin(par_cLinhas)
7887:         LOCAL loc_cSQL, loc_oPg
7888:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7889: 
7890:         IF EMPTY(par_cLinhas)
7891:             loc_oPg.txt_4c_DLinDisplay.Value = ""
7892:             RETURN
7893:         ENDIF
7894: 
7895:         TRY
7896:             loc_cSQL = "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(par_cLinhas)
7897:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescLin") > 0
7898:                 IF !EOF("cursor_4c_DescLin")
7899:                     SELECT cursor_4c_DescLin
7900:                     loc_oPg.txt_4c_DLinDisplay.Value = ALLTRIM(descs)
7901:                 ELSE
7902:                     loc_oPg.txt_4c_DLinDisplay.Value = ""
7903:                 ENDIF
7904:                 IF USED("cursor_4c_DescLin")
7905:                     USE IN cursor_4c_DescLin
7906:                 ENDIF
7907:             ENDIF
7908:         CATCH TO loc_oErro
7909:             MsgErro(loc_oErro.Message, "Erro ao buscar linha")
7910:         ENDTRY
7911:     ENDPROC
7912: 
7913:     *--------------------------------------------------------------------------
7914:     * CarregarDescCol - Exibe colecoes (campo texto direto em SigCdPro)
7915:     * Nota: nao existe tabela SigCdCol no banco; colecoes e campo texto livre
7916:     *--------------------------------------------------------------------------
7917:     PROTECTED PROCEDURE CarregarDescCol(par_cColecoes)
7918:         LOCAL loc_oPg
7919:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7920:         *-- Colecoes nao tem tabela de descricao - exibir o proprio valor
7921:         loc_oPg.txt_4c_DColDisplay.Value = par_cColecoes
7922:     ENDPROC
7923: 
7924:     *--------------------------------------------------------------------------
7925:     * CarregarDescIfor - Carrega nome do fornecedor
7926:     *--------------------------------------------------------------------------
7927:     PROTECTED PROCEDURE CarregarDescIfor(par_cIfors)
7928:         LOCAL loc_cSQL, loc_oPg
7929:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7930: 
7931:         IF EMPTY(par_cIfors)
7932:             loc_oPg.txt_4c_DforDisplay.Value = ""
7933:             RETURN
7934:         ENDIF
7935: 
7936:         TRY
7937:             *-- Fornecedor buscado via SigCdCli (ou tabela de fornecedores)
7938:             loc_cSQL = "SELECT Rclis AS dfors FROM SigCdCli WHERE Iclis = " + EscaparSQL(par_cIfors)
7939:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescIfor") > 0
7940:                 IF !EOF("cursor_4c_DescIfor")
7941:                     SELECT cursor_4c_DescIfor
7942:                     loc_oPg.txt_4c_DforDisplay.Value = ALLTRIM(dfors)
7943:                 ELSE
7944:                     loc_oPg.txt_4c_DforDisplay.Value = ""
7945:                 ENDIF
7946:                 IF USED("cursor_4c_DescIfor")
7947:                     USE IN cursor_4c_DescIfor
7948:                 ENDIF
7949:             ENDIF
7950:         CATCH TO loc_oErro
7951:             MsgErro(loc_oErro.Message, "Erro ao buscar fornecedor")
7952:         ENDTRY
7953:     ENDPROC
7954: 
7955:     *--------------------------------------------------------------------------
7956:     * CarregarDescCor - Carrega descricao da cor (SigCdCor, PK=cods, desc=descs)
7957:     *--------------------------------------------------------------------------
7958:     PROTECTED PROCEDURE CarregarDescCor(par_cCodCor)
7959:         LOCAL loc_cSQL, loc_oPg
7960:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7961:         IF EMPTY(par_cCodCor)
7962:             RETURN
7963:         ENDIF
7964:         TRY
7965:             loc_cSQL = "SELECT descs FROM SigCdCor WHERE cods = " + EscaparSQL(par_cCodCor)
7966:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCor") > 0
7967:                 IF !EOF("cursor_4c_DescCor")
7968:                     SELECT cursor_4c_DescCor
7969:                     loc_oPg.txt_4c_Cor.ToolTipText = ALLTRIM(descs)
7970:                 ENDIF
7971:                 IF USED("cursor_4c_DescCor")
7972:                     USE IN cursor_4c_DescCor
7973:                 ENDIF
7974:             ENDIF
7975:         CATCH TO loc_oErro
7976:             MsgErro(loc_oErro.Message, "Erro ao buscar cor")
7977:         ENDTRY
7978:     ENDPROC
7979: 
7980:     *--------------------------------------------------------------------------
7981:     * CarregarDescTam - Carrega descricao do tamanho (SigCdTam, PK=cods, desc=descs)
7982:     *--------------------------------------------------------------------------
7983:     PROTECTED PROCEDURE CarregarDescTam(par_cCodTam)
7984:         LOCAL loc_cSQL, loc_oPg
7985:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7986:         IF EMPTY(par_cCodTam)
7987:             RETURN
7988:         ENDIF
7989:         TRY
7990:             loc_cSQL = "SELECT descs FROM SigCdTam WHERE cods = " + EscaparSQL(par_cCodTam)
7991:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescTam") > 0
7992:                 IF !EOF("cursor_4c_DescTam")
7993:                     SELECT cursor_4c_DescTam
7994:                     loc_oPg.txt_4c_Tam.ToolTipText = ALLTRIM(descs)
7995:                 ENDIF
7996:                 IF USED("cursor_4c_DescTam")
7997:                     USE IN cursor_4c_DescTam
7998:                 ENDIF
7999:             ENDIF
8000:         CATCH TO loc_oErro
8001:             MsgErro(loc_oErro.Message, "Erro ao buscar tamanho")
8002:         ENDTRY
8003:     ENDPROC
8004: 
8005:     *--------------------------------------------------------------------------
8006:     * CarregarDescFinP - Carrega descricao da ficha (SigCdFip, PK=cods, desc=descs)
8007:     *--------------------------------------------------------------------------
8008:     PROTECTED PROCEDURE CarregarDescFinP(par_cCodFinP)
8009:         LOCAL loc_cSQL, loc_oPg
8010:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8011:         IF EMPTY(par_cCodFinP)
8012:             loc_oPg.txt_4c_DesFinP.Value = ""
8013:             RETURN
8014:         ENDIF
8015:         TRY
8016:             loc_cSQL = "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(par_cCodFinP)
8017:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFinP") > 0
8018:                 IF !EOF("cursor_4c_DescFinP")
8019:                     SELECT cursor_4c_DescFinP
8020:                     loc_oPg.txt_4c_DesFinP.Value = ALLTRIM(descs)
8021:                 ELSE
8022:                     loc_oPg.txt_4c_DesFinP.Value = ""
8023:                 ENDIF
8024:                 IF USED("cursor_4c_DescFinP")
8025:                     USE IN cursor_4c_DescFinP
8026:                 ENDIF
8027:             ENDIF
8028:         CATCH TO loc_oErro
8029:             MsgErro(loc_oErro.Message, "Erro ao buscar ficha")
8030:         ENDTRY
8031:     ENDPROC
8032: 
8033:     *--------------------------------------------------------------------------
8034:     * CarregarDescAcb - Carrega descricao do acabamento (SigCdAca, PK=cods, desc=descrs)
8035:     *--------------------------------------------------------------------------
8036:     PROTECTED PROCEDURE CarregarDescAcb(par_cCodAcb)
8037:         LOCAL loc_cSQL, loc_oPg
8038:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8039:         IF EMPTY(par_cCodAcb)
8040:             loc_oPg.txt_4c_DacbDisplay.Value = ""
8041:             RETURN
8042:         ENDIF
8043:         TRY
8044:             loc_cSQL = "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(par_cCodAcb)
8045:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescAcb") > 0
8046:                 IF !EOF("cursor_4c_DescAcb")
8047:                     SELECT cursor_4c_DescAcb
8048:                     loc_oPg.txt_4c_DacbDisplay.Value = ALLTRIM(descrs)
8049:                 ELSE
8050:                     loc_oPg.txt_4c_DacbDisplay.Value = ""
8051:                 ENDIF
8052:                 IF USED("cursor_4c_DescAcb")
8053:                     USE IN cursor_4c_DescAcb
8054:                 ENDIF
8055:             ENDIF
8056:         CATCH TO loc_oErro
8057:             MsgErro(loc_oErro.Message, "Erro ao buscar acabamento")
8058:         ENDTRY
8059:     ENDPROC
8060: 
8061:     *--------------------------------------------------------------------------
8062:     * CarregarDescClass - Carrega descricao da classificacao (SIGCDCLS, PK=cods, desc=descs)
8063:     *--------------------------------------------------------------------------
8064:     PROTECTED PROCEDURE CarregarDescClass(par_cCclass)
8065:         LOCAL loc_cSQL, loc_oPg
8066:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8067:         IF EMPTY(par_cCclass)
8068:             loc_oPg.txt_4c_DClassDisplay.Value = ""
8069:             RETURN
8070:         ENDIF
8071:         TRY
8072:             loc_cSQL = "SELECT descs FROM SIGCDCLS WHERE cods = " + EscaparSQL(par_cCclass)
8073:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescClass") > 0
8074:                 IF !EOF("cursor_4c_DescClass")
8075:                     SELECT cursor_4c_DescClass
8076:                     loc_oPg.txt_4c_DClassDisplay.Value = ALLTRIM(descs)
8077:                 ELSE
8078:                     loc_oPg.txt_4c_DClassDisplay.Value = ""
8079:                 ENDIF
8080:                 IF USED("cursor_4c_DescClass")
8081:                     USE IN cursor_4c_DescClass
8082:                 ENDIF
8083:             ENDIF
8084:         CATCH TO loc_oErro
8085:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o")
8086:         ENDTRY
8087:     ENDPROC
8088: 
8089:     *--------------------------------------------------------------------------
8090:     * CarregarDescLocal - Carrega descricao do local (SigPrLcl, PK=codigos, desc=descricaos)
8091:     *--------------------------------------------------------------------------
8092:     PROTECTED PROCEDURE CarregarDescLocal(par_cLocals)
8093:         LOCAL loc_cSQL, loc_oPg
8094:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8095:         IF EMPTY(par_cLocals)
8096:             RETURN
8097:         ENDIF
8098:         TRY
8099:             loc_cSQL = "SELECT descricaos FROM SigPrLcl WHERE codigos = " + EscaparSQL(par_cLocals)
8100:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescLocal") > 0
8101:                 IF !EOF("cursor_4c_DescLocal")
8102:                     SELECT cursor_4c_DescLocal
8103:                     loc_oPg.txt_4c_Local.ToolTipText = ALLTRIM(descricaos)
8104:                 ENDIF
8105:                 IF USED("cursor_4c_DescLocal")
8106:                     USE IN cursor_4c_DescLocal
8107:                 ENDIF
8108:             ENDIF
8109:         CATCH TO loc_oErro
8110:             MsgErro(loc_oErro.Message, "Erro ao buscar local")
8111:         ENDTRY
8112:     ENDPROC
8113: 
8114:     *--------------------------------------------------------------------------
8115:     * CarregarDescUni - Carrega descricao da unidade (SigCdUni, PK=cunis, desc=dunis)
8116:     * par_cTipo: "uni" = unidade principal, "unip" = unidade de pedido
8117:     *--------------------------------------------------------------------------
8118:     PROTECTED PROCEDURE CarregarDescUni(par_cCunis, par_cTipo)
8119:         LOCAL loc_cSQL, loc_oPg
8120:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8121:         IF EMPTY(par_cCunis)
8122:             IF par_cTipo = "uni"
8123:                 loc_oPg.txt_4c_DuniDisplay.Value  = ""
8124:             ELSE
8125:                 loc_oPg.txt_4c_DunipDisplay.Value = ""
8126:             ENDIF
8127:             RETURN
8128:         ENDIF
8129:         TRY
8130:             loc_cSQL = "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(par_cCunis)
8131:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescUni") > 0
8132:                 IF !EOF("cursor_4c_DescUni")
8133:                     SELECT cursor_4c_DescUni
8134:                     IF par_cTipo = "uni"
8135:                         loc_oPg.txt_4c_DuniDisplay.Value  = ALLTRIM(dunis)
8136:                     ELSE
8137:                         loc_oPg.txt_4c_DunipDisplay.Value = ALLTRIM(dunis)
8138:                     ENDIF
8139:                 ELSE
8140:                     IF par_cTipo = "uni"
8141:                         loc_oPg.txt_4c_DuniDisplay.Value  = ""
8142:                     ELSE
8143:                         loc_oPg.txt_4c_DunipDisplay.Value = ""
8144:                     ENDIF
8145:                 ENDIF
8146:                 IF USED("cursor_4c_DescUni")
8147:                     USE IN cursor_4c_DescUni
8148:                 ENDIF
8149:             ENDIF
8150:         CATCH TO loc_oErro
8151:             MsgErro(loc_oErro.Message, "Erro ao buscar unidade")
8152:         ENDTRY
8153:     ENDPROC
8154: 
8155:     *--------------------------------------------------------------------------
8156:     * CarregarDescMoe - Carrega descricao da moeda (SigCdMoe, PK=cmoes, desc=dmoes)
8157:     * par_cTipo: "total" | "pvenda" | "fvenda"
8158:     *--------------------------------------------------------------------------
8159:     PROTECTED PROCEDURE CarregarDescMoe(par_cCmoes, par_cTipo)
8160:         LOCAL loc_cSQL, loc_oPg, loc_cDesc
8161:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8162:         loc_cDesc = ""
8163:         IF EMPTY(par_cCmoes)
8164:             RETURN
8165:         ENDIF
8166:         TRY
8167:             loc_cSQL = "SELECT dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(par_cCmoes)
8168:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescMoe") > 0
8169:                 IF !EOF("cursor_4c_DescMoe")
8170:                     SELECT cursor_4c_DescMoe
8171:                     loc_cDesc = ALLTRIM(dmoes)
8172:                 ENDIF
8173:                 IF USED("cursor_4c_DescMoe")
8174:                     USE IN cursor_4c_DescMoe
8175:                 ENDIF
8176:             ENDIF
8177:         CATCH TO loc_oErro
8178:             MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
8179:         ENDTRY
8180:         DO CASE
8181:         CASE par_cTipo = "total"
8182:             loc_oPg.txt_4c_Mctotal.ToolTipText = loc_cDesc
8183:         CASE par_cTipo = "pvenda"
8184:             loc_oPg.txt_4c_Mpvenda.ToolTipText = loc_cDesc
8185:         CASE par_cTipo = "fvenda"
8186:             loc_oPg.txt_4c_Mfvenda.ToolTipText = loc_cDesc
8187:         ENDCASE
8188:     ENDPROC
8189: 
8190:     *--------------------------------------------------------------------------
8191:     * CarregarDescFiscais - Carrega descricoes e historico CMV da Fase 13
8192:     * par_cCpros: codigo produto; demais: codigos para lookup de descricoes
8193:     *--------------------------------------------------------------------------
8194:     PROTECTED PROCEDURE CarregarDescFiscais(par_cCpros, par_cGruccus, par_cContaccus, ;
8195:                                              par_cClfiscals, par_cOrigmercs, par_cSittricms, ;
8196:                                              par_cMetals, par_cTeors)
8197:         LOCAL loc_oPg3, loc_cSQL, loc_cDesc
8198:         loc_oPg3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
8199: 
8200:         TRY
8201:             *-- Grupo CC (SigCdGcr)
8202:             IF !EMPTY(par_cGruccus)
8203:                 loc_cSQL = "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(par_cGruccus)
8204:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
8205:                     loc_oPg3.txt_4c_Dgruccus.Value = ALLTRIM(cursor_4c_DescFisc.descrs)
8206:                 ENDIF
8207:                 IF USED("cursor_4c_DescFisc")
8208:                     USE IN cursor_4c_DescFisc
8209:                 ENDIF
8210:             ENDIF
8211: 
8212:             *-- Conta CC (SigCdCli)
8213:             IF !EMPTY(par_cContaccus)
8214:                 loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE IClis = " + EscaparSQL(par_cContaccus)
8215:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
8216:                     loc_oPg3.txt_4c_Dcontaccus.Value = ALLTRIM(cursor_4c_DescFisc.Rclis)
8217:                 ENDIF
8218:                 IF USED("cursor_4c_DescFisc")
8219:                     USE IN cursor_4c_DescFisc
8220:                 ENDIF
8221:             ENDIF
8222: 
8223:             *-- Classificacao Fiscal (SigCdClf)
8224:             IF !EMPTY(par_cClfiscals)
8225:                 loc_cSQL = "SELECT Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(par_cClfiscals)
8226:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
8227:                     loc_oPg3.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_DescFisc.Descricaos)
8228:                 ENDIF
8229:                 IF USED("cursor_4c_DescFisc")
8230:                     USE IN cursor_4c_DescFisc
8231:                 ENDIF
8232:             ENDIF
8233: 
8234:             *-- Origem da Mercadoria (SigCdOrg)

*-- Linhas 8273 a 8356:
8273: 
8274:             *-- Carregar historico CMV (sigcdcmv)
8275:             IF !EMPTY(par_cCpros)
8276:                 loc_cSQL = "SELECT datas, valcuss, moedas FROM sigcdcmv " + ;
8277:                            "WHERE cpros = " + EscaparSQL(par_cCpros) + " ORDER BY datas DESC"
8278:                 IF USED("cursor_4c_Cmv")
8279:                     USE IN cursor_4c_Cmv
8280:                 ENDIF
8281:                 SET NULL ON
8282:                 CREATE CURSOR cursor_4c_Cmv (datas C(7), valcuss N(10,2), moedas C(3))
8283:                 SET NULL OFF
8284:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmvTemp") > 0
8285:                     IF !EOF("cursor_4c_CmvTemp")
8286:                         SELECT cursor_4c_CmvTemp
8287:                         GO TOP
8288:                         SCAN
8289:                             LOCAL loc_cDatas, loc_nValcuss, loc_cMoedas
8290:                             loc_cDatas   = ALLTRIM(cursor_4c_CmvTemp.datas)
8291:                             loc_nValcuss = cursor_4c_CmvTemp.valcuss
8292:                             loc_cMoedas  = ALLTRIM(cursor_4c_CmvTemp.moedas)
8293:                             INSERT INTO cursor_4c_Cmv (datas, valcuss, moedas) ;
8294:                                 VALUES (loc_cDatas, loc_nValcuss, loc_cMoedas)
8295:                         ENDSCAN
8296:                     ENDIF
8297:                     IF USED("cursor_4c_CmvTemp")
8298:                         USE IN cursor_4c_CmvTemp
8299:                     ENDIF
8300:                 ENDIF
8301:                 SELECT cursor_4c_Cmv
8302:                 IF RECCOUNT() > 0
8303:                     GO TOP
8304:                 ENDIF
8305:                 loc_oPg3.grd_4c_Dados.Refresh()
8306:             ENDIF
8307: 
8308:         CATCH TO loc_oErro
8309:             MsgErro(loc_oErro.Message, "Erro ao carregar dados fiscais")
8310:         ENDTRY
8311:     ENDPROC
8312: 
8313:     *--------------------------------------------------------------------------
8314:     * HabilitarCampos - Habilita/desabilita campos editaveis conforme modo
8315:     *--------------------------------------------------------------------------
8316:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
8317:         LOCAL loc_oPg, loc_lReadOnly, loc_cBgEdit, loc_cBgRO
8318:         loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8319:         loc_lReadOnly = !par_lHabilitar
8320:         loc_cBgEdit  = RGB(255, 255, 255)
8321:         loc_cBgRO    = RGB(224, 235, 235)
8322: 
8323:         TRY
8324:             *-- Fase 5: Campos editaveis basicos
8325:             loc_oPg.txt_4c_Cpros.ReadOnly  = loc_lReadOnly
8326:             loc_oPg.txt_4c_Cpros.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8327: 
8328:             loc_oPg.txt_4c_DPro2s.ReadOnly  = loc_lReadOnly
8329:             loc_oPg.txt_4c_DPro2s.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8330: 
8331:             loc_oPg.txt_4c_Cbar.ReadOnly  = loc_lReadOnly
8332:             loc_oPg.txt_4c_Cbar.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8333: 
8334:             loc_oPg.txt_4c_Cgrus.ReadOnly  = loc_lReadOnly
8335:             loc_oPg.txt_4c_Cgrus.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8336: 
8337:             loc_oPg.txt_4c_Cods.ReadOnly  = loc_lReadOnly
8338:             loc_oPg.txt_4c_Cods.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8339: 
8340:             loc_oPg.txt_4c_Lin.ReadOnly  = loc_lReadOnly
8341:             loc_oPg.txt_4c_Lin.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8342: 
8343:             loc_oPg.txt_4c_Col.ReadOnly  = loc_lReadOnly
8344:             loc_oPg.txt_4c_Col.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8345: 
8346:             loc_oPg.txt_4c_Ifor.ReadOnly  = loc_lReadOnly
8347:             loc_oPg.txt_4c_Ifor.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8348: 
8349:             loc_oPg.txt_4c_Refs.ReadOnly  = loc_lReadOnly
8350:             loc_oPg.txt_4c_Refs.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8351: 
8352:             *-- Fase 6: Novos campos editaveis
8353:             loc_oPg.txt_4c_Cor.ReadOnly  = loc_lReadOnly
8354:             loc_oPg.txt_4c_Cor.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8355: 
8356:             loc_oPg.txt_4c_Tam.ReadOnly  = loc_lReadOnly

*-- Linhas 8475 a 8518:
8475:     *--------------------------------------------------------------------------
8476:     * LimparCampos - Limpa todos os campos da aba pgDados
8477:     *--------------------------------------------------------------------------
8478:     PROTECTED PROCEDURE LimparCampos()
8479:         LOCAL loc_oPg
8480:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8481: 
8482:         TRY
8483:             *-- Linha 1: Produto
8484:             loc_oPg.txt_4c_Cpros.Value        = ""
8485:             loc_oPg.txt_4c_Dpros.Value        = ""
8486:             *-- Linha 2: Descritivo 2 + Barra
8487:             loc_oPg.txt_4c_DPro2s.Value       = ""
8488:             loc_oPg.txt_4c_Cbar.Value         = ""
8489:             *-- Linha 3: Grupo
8490:             loc_oPg.txt_4c_Cgrus.Value        = ""
8491:             loc_oPg.txt_4c_DgruDisplay.Value  = ""
8492:             *-- Linha 4: Subgrupo
8493:             loc_oPg.txt_4c_Cods.Value         = ""
8494:             loc_oPg.txt_4c_DcodsDisplay.Value = ""
8495:             *-- Linha 5: Linha
8496:             loc_oPg.txt_4c_Lin.Value          = ""
8497:             loc_oPg.txt_4c_DLinDisplay.Value  = ""
8498:             *-- Linha 6: Colecao/Venda
8499:             loc_oPg.txt_4c_Col.Value          = ""
8500:             loc_oPg.txt_4c_DColDisplay.Value  = ""
8501:             *-- Linha 7: Fornecedor
8502:             loc_oPg.txt_4c_Ifor.Value         = ""
8503:             loc_oPg.txt_4c_DforDisplay.Value  = ""
8504:             *-- Linha 8: Ref. Fornecedor + Cor + Tamanho
8505:             loc_oPg.txt_4c_Refs.Value         = ""
8506:             loc_oPg.txt_4c_Cor.Value          = ""
8507:             loc_oPg.txt_4c_Tam.Value          = ""
8508:             *-- Linha 9: Ficha + Peso Base
8509:             loc_oPg.txt_4c_CodFinP.Value      = ""
8510:             loc_oPg.txt_4c_DesFinP.Value      = ""
8511:             loc_oPg.txt_4c_PesoB.Value        = 0.0
8512:             *-- Linha 10: Acabamento + Preco Medio
8513:             loc_oPg.txt_4c_CodAcb.Value       = ""
8514:             loc_oPg.txt_4c_DacbDisplay.Value  = ""
8515:             loc_oPg.txt_4c_Pmedio.Value       = 0.0
8516:             *-- Linha 11: Classificacao + Local
8517:             loc_oPg.txt_4c_Class.Value         = ""
8518:             loc_oPg.txt_4c_DClassDisplay.Value = ""

*-- Linhas 8584 a 11362:
8584:     *--------------------------------------------------------------------------
8585:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
8586:     *--------------------------------------------------------------------------
8587:     PROTECTED PROCEDURE AjustarBotoesPorModo()
8588:         LOCAL loc_oCnt, loc_lTemRegistro
8589:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
8590:         loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
8591: 
8592:         TRY
8593:             loc_oCnt.cmd_4c_Incluir.Enabled    = .T.
8594:             loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
8595:             loc_oCnt.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
8596:             loc_oCnt.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
8597:             loc_oCnt.cmd_4c_Procurar.Enabled   = .T.
8598:         CATCH TO loc_oErro
8599:             MsgErro(loc_oErro.Message, "Erro ao ajustar bot" + CHR(245) + "es")
8600:         ENDTRY
8601:     ENDPROC
8602: 
8603:     *==========================================================================
8604:     * HANDLERS DE BOTOES CRUD
8605:     *==========================================================================
8606: 
8607:     *--------------------------------------------------------------------------
8608:     * BtnIncluirClick - Acao do botao Incluir
8609:     *--------------------------------------------------------------------------
8610:     PROCEDURE BtnIncluirClick()
8611:         THIS.this_oBusinessObject.NovoRegistro()
8612:         THIS.LimparCampos()
8613:         THIS.this_cModoAtual = "INCLUIR"
8614:         THIS.HabilitarCampos(.T.)
8615:         THIS.AlternarPagina(2)
8616:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.txt_4c_Cpros.SetFocus()
8617:     ENDPROC
8618: 
8619:     *--------------------------------------------------------------------------
8620:     * BtnVisualizarClick - Acao do botao Visualizar
8621:     *--------------------------------------------------------------------------
8622:     PROCEDURE BtnVisualizarClick()
8623:         LOCAL loc_cChave
8624: 
8625:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
8626:             MsgAviso("Nenhum registro selecionado.")
8627:             RETURN
8628:         ENDIF
8629: 
8630:         loc_cChave = ALLTRIM(cursor_4c_Dados.pkchaves)
8631: 
8632:         TRY
8633:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
8634:                 THIS.BOParaForm()
8635:                 THIS.this_cModoAtual = "VISUALIZAR"
8636:                 THIS.HabilitarCampos(.F.)
8637:                 THIS.AlternarPagina(2)
8638:             ENDIF
8639:         CATCH TO loc_oErro
8640:             MsgErro(loc_oErro.Message, "Erro ao visualizar registro")
8641:         ENDTRY
8642:     ENDPROC
8643: 
8644:     *--------------------------------------------------------------------------
8645:     * BtnAlterarClick - Acao do botao Alterar
8646:     *--------------------------------------------------------------------------
8647:     PROCEDURE BtnAlterarClick()
8648:         LOCAL loc_cChave
8649: 
8650:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
8651:             MsgAviso("Nenhum registro selecionado.")
8652:             RETURN
8653:         ENDIF
8654: 
8655:         loc_cChave = ALLTRIM(cursor_4c_Dados.pkchaves)
8656: 
8657:         TRY
8658:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
8659:                 THIS.this_oBusinessObject.EditarRegistro()
8660:                 THIS.BOParaForm()
8661:                 THIS.this_cModoAtual = "ALTERAR"
8662:                 THIS.HabilitarCampos(.T.)
8663:                 THIS.AlternarPagina(2)
8664:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.txt_4c_Cpros.SetFocus()
8665:             ENDIF
8666:         CATCH TO loc_oErro
8667:             MsgErro(loc_oErro.Message, "Erro ao alterar registro")
8668:         ENDTRY
8669:     ENDPROC
8670: 
8671:     *--------------------------------------------------------------------------
8672:     * BtnExcluirClick - Acao do botao Excluir
8673:     *--------------------------------------------------------------------------
8674:     PROCEDURE BtnExcluirClick()
8675:         LOCAL loc_cChave
8676: 
8677:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
8678:             MsgAviso("Nenhum registro selecionado.")
8679:             RETURN
8680:         ENDIF
8681: 
8682:         loc_cChave = ALLTRIM(cursor_4c_Dados.pkchaves)
8683: 
8684:         TRY
8685:             IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
8686:                 "Excluir Produto")
8687:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
8688:                     IF THIS.this_oBusinessObject.Excluir()
8689:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Exclu" + CHR(237) + "do")
8690:                         THIS.CarregarLista()
8691:                         THIS.AjustarBotoesPorModo()
8692:                     ELSE
8693:                         MsgErro("Erro ao excluir registro.", "Erro")
8694:                     ENDIF
8695:                 ENDIF
8696:             ENDIF
8697:         CATCH TO loc_oErro
8698:             MsgErro(loc_oErro.Message, "Erro ao excluir registro")
8699:         ENDTRY
8700:     ENDPROC
8701: 
8702:     *--------------------------------------------------------------------------
8703:     * BtnProcurarClick - Acao do botao Procurar (busca e seleciona produto na lista)
8704:     *--------------------------------------------------------------------------
8705:     PROCEDURE BtnProcurarClick()
8706:         LOCAL loc_oBusca, loc_cCpros
8707: 
8708:         TRY
8709:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Busca de Produto")
8710:             loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
8711:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
8712:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
8713:             loc_oBusca.Show()
8714: 
8715:             IF loc_oBusca.this_lSelecionou
8716:                 IF USED("cursor_4c_Busca")
8717:                     SELECT cursor_4c_Busca
8718:                     loc_cCpros = ALLTRIM(cpros)
8719:                     USE IN cursor_4c_Busca
8720:                 ENDIF
8721: 
8722:                 *-- Posiciona grid na linha do produto selecionado
8723:                 IF !EMPTY(loc_cCpros) AND USED("cursor_4c_Dados")
8724:                     SELECT cursor_4c_Dados
8725:                     LOCATE FOR ALLTRIM(cpros) = loc_cCpros
8726:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
8727:                 ENDIF
8728:             ENDIF
8729: 
8730:             IF VARTYPE(loc_oBusca) = "O"
8731:                 loc_oBusca.Release()
8732:                 loc_oBusca = .NULL.
8733:             ENDIF
8734:         CATCH TO loc_oErro
8735:             MsgErro(loc_oErro.Message, "Erro ao procurar produto")
8736:         ENDTRY
8737:     ENDPROC
8738: 
8739:     *--------------------------------------------------------------------------
8740:     * BtnSalvarClick - Acao do botao Salvar
8741:     *--------------------------------------------------------------------------
8742:     PROCEDURE BtnSalvarClick()
8743:         LOCAL loc_oPg
8744: 
8745:         *-- Validar campos obrigatorios
8746:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8747: 
8748:         IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Cpros.Value))
8749:             MsgAviso("Campo Produto " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
8750:             loc_oPg.txt_4c_Cpros.SetFocus()
8751:             RETURN
8752:         ENDIF
8753: 
8754:         IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Cgrus.Value))
8755:             MsgAviso("Campo Grupo " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
8756:             loc_oPg.txt_4c_Cgrus.SetFocus()
8757:             RETURN
8758:         ENDIF
8759: 
8760:         TRY
8761:             THIS.FormParaBO()
8762: 
8763:             IF THIS.this_cModoAtual = "INCLUIR"
8764:                 *-- Gerar pkchaves: char(20), unica
8765:                 THIS.this_oBusinessObject.this_cPkchaves = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)
8766:             ENDIF
8767: 
8768:             IF THIS.this_oBusinessObject.Salvar()
8769:                 THIS.AtualizarSigCdPro()
8770:                 MsgInfo("Registro salvo com sucesso.", "Salvo")
8771:                 THIS.AlternarPagina(1)
8772:             ELSE
8773:                 MsgErro("Erro ao salvar registro.", "Erro")
8774:             ENDIF
8775: 
8776:         CATCH TO loc_oErro
8777:             MsgErro(loc_oErro.Message, "Erro ao salvar")
8778:         ENDTRY
8779:     ENDPROC
8780: 
8781:     *--------------------------------------------------------------------------
8782:     * BtnCancelarClick - Acao do botao Cancelar
8783:     *--------------------------------------------------------------------------
8784:     PROCEDURE BtnCancelarClick()
8785:         THIS.this_oBusinessObject.CancelarEdicao()
8786:         THIS.AlternarPagina(1)
8787:     ENDPROC
8788: 
8789:     *--------------------------------------------------------------------------
8790:     * BtnSairClick - Acao do botao Sair
8791:     *--------------------------------------------------------------------------
8792:     PROCEDURE BtnSairClick()
8793:         THIS.Release()
8794:     ENDPROC
8795: 
8796:     *==========================================================================
8797:     * HANDLERS DE FILTROS
8798:     *==========================================================================
8799: 
8800:     *--------------------------------------------------------------------------
8801:     * FiltroSituacaoChange - Disparado quando muda opcao de situacao no filtro
8802:     *--------------------------------------------------------------------------
8803:     PROCEDURE FiltroSituacaoChange()
8804:         IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
8805:             THIS.CarregarLista()
8806:         ENDIF
8807:     ENDPROC
8808: 
8809:     *==========================================================================
8810:     * HANDLERS DE KEYPRESS (ENTER/TAB/F4 disparam lookup)
8811:     *==========================================================================
8812: 
8813:     *--------------------------------------------------------------------------
8814:     * TxtFilCgruKeyPress - KeyPress no filtro de grupo (ENTER/TAB carrega lista)
8815:     *--------------------------------------------------------------------------
8816:     PROCEDURE TxtFilCgruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8817:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8818:             IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
8819:                 THIS.CarregarLista()
8820:             ENDIF
8821:         ENDIF
8822:     ENDPROC
8823: 
8824:     *--------------------------------------------------------------------------
8825:     * TxtCprosKeyPress - KeyPress no campo Cpros (ENTER/F4 abre lookup SigCdPro)
8826:     *--------------------------------------------------------------------------
8827:     PROCEDURE TxtCprosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8828:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8829:             *-- Validar produto ao sair
8830:             THIS.ValidarCpros()
8831:         ENDIF
8832:         IF par_nKeyCode = 115
8833:             *-- F4 = 115 -> abrir lookup
8834:             THIS.AbrirLookupProduto()
8835:         ENDIF
8836:     ENDPROC
8837: 
8838:     *--------------------------------------------------------------------------
8839:     * TxtCgrusKeyPress - KeyPress no campo Cgrus (ENTER/F4 abre lookup de grupo)
8840:     *--------------------------------------------------------------------------
8841:     PROCEDURE TxtCgrusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8842:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8843:             THIS.ValidarCgrus()
8844:         ENDIF
8845:         IF par_nKeyCode = 115
8846:             THIS.AbrirLookupGrupo()
8847:         ENDIF
8848:     ENDPROC
8849: 
8850:     *--------------------------------------------------------------------------
8851:     * TxtLinKeyPress - KeyPress no campo Lin (ENTER/F4 abre lookup SigCdLin)
8852:     *--------------------------------------------------------------------------
8853:     PROCEDURE TxtLinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8854:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8855:             THIS.ValidarLin()
8856:         ENDIF
8857:         IF par_nKeyCode = 115
8858:             THIS.AbrirLookupLin()
8859:         ENDIF
8860:     ENDPROC
8861: 
8862:     *--------------------------------------------------------------------------
8863:     * TxtColKeyPress - KeyPress no campo Col (ENTER/F4 abre lookup SigCdCol)
8864:     *--------------------------------------------------------------------------
8865:     PROCEDURE TxtColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8866:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8867:             THIS.ValidarCol()
8868:         ENDIF
8869:         IF par_nKeyCode = 115
8870:             THIS.AbrirLookupCol()
8871:         ENDIF
8872:     ENDPROC
8873: 
8874:     *--------------------------------------------------------------------------
8875:     * TxtIforKeyPress - KeyPress no campo Ifor (ENTER/F4 abre lookup fornecedor)
8876:     *--------------------------------------------------------------------------
8877:     PROCEDURE TxtIforKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8878:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8879:             THIS.ValidarIfor()
8880:         ENDIF
8881:         IF par_nKeyCode = 115
8882:             THIS.AbrirLookupIfor()
8883:         ENDIF
8884:     ENDPROC
8885: 
8886:     *==========================================================================
8887:     * VALIDACOES
8888:     *==========================================================================
8889: 
8890:     *--------------------------------------------------------------------------
8891:     * ValidarCpros - Valida campo cpros e carrega todos os dados do SigCdPro
8892:     *--------------------------------------------------------------------------
8893:     PROTECTED PROCEDURE ValidarCpros()
8894:         LOCAL loc_cCpros, loc_cSQL, loc_oPg
8895:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8896:         loc_cCpros = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
8897: 
8898:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8899:             RETURN
8900:         ENDIF
8901: 
8902:         IF EMPTY(loc_cCpros)
8903:             THIS.CarregarDadosSigCdPro("")
8904:             RETURN
8905:         ENDIF
8906: 
8907:         TRY
8908:             *-- Verificar se produto existe antes de carregar todos os dados
8909:             loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
8910: 
8911:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValPro") > 0
8912:                 SELECT cursor_4c_ValPro
8913:                 IF nExiste > 0
8914:                     IF USED("cursor_4c_ValPro")
8915:                         USE IN cursor_4c_ValPro
8916:                     ENDIF
8917:                     THIS.CarregarDadosSigCdPro(loc_cCpros)
8918:                 ELSE
8919:                     IF USED("cursor_4c_ValPro")
8920:                         USE IN cursor_4c_ValPro
8921:                     ENDIF
8922:                     THIS.CarregarDadosSigCdPro("")
8923:                     MsgAviso("Produto " + loc_cCpros + " n" + CHR(227) + "o encontrado.", "Produto Inv" + CHR(225) + "lido")
8924:                 ENDIF
8925:             ENDIF
8926:         CATCH TO loc_oErro
8927:             MsgErro(loc_oErro.Message, "Erro ao validar produto")
8928:         ENDTRY
8929:     ENDPROC
8930: 
8931:     *--------------------------------------------------------------------------
8932:     * ValidarCgrus - Valida campo cgrus e carrega descricao do grupo
8933:     *--------------------------------------------------------------------------
8934:     PROTECTED PROCEDURE ValidarCgrus()
8935:         LOCAL loc_cCgrus, loc_oPg
8936:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8937:         loc_cCgrus = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
8938: 
8939:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8940:             RETURN
8941:         ENDIF
8942: 
8943:         THIS.CarregarDescGrupo(loc_cCgrus)
8944: 
8945:         IF !EMPTY(loc_cCgrus) AND EMPTY(loc_oPg.txt_4c_DgruDisplay.Value)
8946:             MsgAviso("Grupo " + loc_cCgrus + " n" + CHR(227) + "o encontrado.", "Grupo Inv" + CHR(225) + "lido")
8947:         ENDIF
8948:     ENDPROC
8949: 
8950:     *--------------------------------------------------------------------------
8951:     * ValidarLin - Valida campo lin e carrega descricao da linha (SigCdLin)
8952:     *--------------------------------------------------------------------------
8953:     PROTECTED PROCEDURE ValidarLin()
8954:         LOCAL loc_cClins, loc_oPg
8955:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8956:         loc_cClins = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
8957: 
8958:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8959:             RETURN
8960:         ENDIF
8961: 
8962:         THIS.CarregarDescLin(loc_cClins)
8963: 
8964:         IF !EMPTY(loc_cClins) AND EMPTY(loc_oPg.txt_4c_DLinDisplay.Value)
8965:             MsgAviso("Linha " + loc_cClins + " n" + CHR(227) + "o encontrada.", "Linha Inv" + CHR(225) + "lida")
8966:         ENDIF
8967:     ENDPROC
8968: 
8969:     *--------------------------------------------------------------------------
8970:     * ValidarCol - Valida campo col e carrega descricao do grupo de venda (SigCdCol)
8971:     *--------------------------------------------------------------------------
8972:     PROTECTED PROCEDURE ValidarCol()
8973:         LOCAL loc_cCcols, loc_oPg
8974:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8975:         loc_cCcols = ALLTRIM(loc_oPg.txt_4c_Col.Value)
8976: 
8977:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8978:             RETURN
8979:         ENDIF
8980: 
8981:         THIS.CarregarDescCol(loc_cCcols)
8982: 
8983:         IF !EMPTY(loc_cCcols) AND EMPTY(loc_oPg.txt_4c_DColDisplay.Value)
8984:             MsgAviso("Grupo de venda " + loc_cCcols + " n" + CHR(227) + "o encontrado.", "Inv" + CHR(225) + "lido")
8985:         ENDIF
8986:     ENDPROC
8987: 
8988:     *--------------------------------------------------------------------------
8989:     * ValidarIfor - Valida campo ifor e carrega nome do fornecedor
8990:     *--------------------------------------------------------------------------
8991:     PROTECTED PROCEDURE ValidarIfor()
8992:         LOCAL loc_cIfors, loc_oPg
8993:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8994:         loc_cIfors = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)
8995: 
8996:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8997:             RETURN
8998:         ENDIF
8999: 
9000:         THIS.CarregarDescIfor(loc_cIfors)
9001: 
9002:         IF !EMPTY(loc_cIfors) AND EMPTY(loc_oPg.txt_4c_DforDisplay.Value)
9003:             MsgAviso("Fornecedor " + loc_cIfors + " n" + CHR(227) + "o encontrado.", "Inv" + CHR(225) + "lido")
9004:         ENDIF
9005:     ENDPROC
9006: 
9007:     *==========================================================================
9008:     * LOOKUPS (FormBuscaAuxiliar)
9009:     *==========================================================================
9010: 
9011:     *--------------------------------------------------------------------------
9012:     * AbrirLookupProduto - Abre busca de produto (SigCdPro)
9013:     *--------------------------------------------------------------------------
9014:     PROCEDURE AbrirLookupProduto()
9015:         LOCAL loc_oBusca, loc_oPg
9016:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9017: 
9018:         TRY
9019:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Busca de Produto")
9020:             loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
9021:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
9022:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
9023:             loc_oBusca.Show()
9024: 
9025:             IF loc_oBusca.this_lSelecionou
9026:                 IF USED("cursor_4c_Busca")
9027:                     SELECT cursor_4c_Busca
9028:                     loc_oPg.txt_4c_Cpros.Value = ALLTRIM(cpros)
9029:                     loc_oPg.txt_4c_Dpros.Value = ALLTRIM(dpros)
9030:                     USE IN cursor_4c_Busca
9031:                 ENDIF
9032:             ENDIF
9033: 
9034:             loc_oBusca.Release()
9035:             loc_oBusca = .NULL.
9036:         CATCH TO loc_oErro
9037:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de produto")
9038:         ENDTRY
9039:     ENDPROC
9040: 
9041:     *--------------------------------------------------------------------------
9042:     * AbrirLookupGrupo - Abre busca de grupo (SigCdGrp)
9043:     *--------------------------------------------------------------------------
9044:     PROCEDURE AbrirLookupGrupo()
9045:         LOCAL loc_oBusca, loc_oPg
9046:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9047: 
9048:         TRY
9049:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", "cursor_4c_Busca", "cgrus", "", "Busca de Grupo")
9050:             loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
9051:             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
9052:             loc_oBusca.Show()
9053: 
9054:             IF loc_oBusca.this_lSelecionou
9055:                 IF USED("cursor_4c_Busca")
9056:                     SELECT cursor_4c_Busca
9057:                     loc_oPg.txt_4c_Cgrus.Value       = ALLTRIM(cgrus)
9058:                     loc_oPg.txt_4c_DgruDisplay.Value = ALLTRIM(dgrus)
9059:                     USE IN cursor_4c_Busca
9060:                 ENDIF
9061:             ENDIF
9062: 
9063:             loc_oBusca.Release()
9064:             loc_oBusca = .NULL.
9065:         CATCH TO loc_oErro
9066:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo")
9067:         ENDTRY
9068:     ENDPROC
9069: 
9070:     *--------------------------------------------------------------------------
9071:     * AbrirLookupLin - Abre busca de linha (SigCdLin)
9072:     *--------------------------------------------------------------------------
9073:     PROCEDURE AbrirLookupLin()
9074:         LOCAL loc_oBusca, loc_oPg
9075:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9076: 
9077:         TRY
9078:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLin", "cursor_4c_Busca", "clins", "", "Busca de Linha")
9079:             loc_oBusca.mAddColuna("clins", "", "C" + CHR(243) + "digo")
9080:             loc_oBusca.mAddColuna("dlins", "", "Descri" + CHR(231) + CHR(227) + "o")
9081:             loc_oBusca.Show()
9082: 
9083:             IF loc_oBusca.this_lSelecionou
9084:                 IF USED("cursor_4c_Busca")
9085:                     SELECT cursor_4c_Busca
9086:                     loc_oPg.txt_4c_Lin.Value          = ALLTRIM(clins)
9087:                     loc_oPg.txt_4c_DLinDisplay.Value  = ALLTRIM(dlins)
9088:                     USE IN cursor_4c_Busca
9089:                 ENDIF
9090:             ENDIF
9091: 
9092:             loc_oBusca.Release()
9093:             loc_oBusca = .NULL.
9094:         CATCH TO loc_oErro
9095:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de linha")
9096:         ENDTRY
9097:     ENDPROC
9098: 
9099:     *--------------------------------------------------------------------------
9100:     * AbrirLookupCol - Abre busca de grupo de venda (SigCdCol)
9101:     *--------------------------------------------------------------------------
9102:     PROCEDURE AbrirLookupCol()
9103:         LOCAL loc_oBusca, loc_oPg
9104:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9105: 
9106:         TRY
9107:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", "cursor_4c_Busca", "ccols", "", "Busca de Grupo de Venda")
9108:             loc_oBusca.mAddColuna("ccols", "", "C" + CHR(243) + "digo")
9109:             loc_oBusca.mAddColuna("dcols", "", "Descri" + CHR(231) + CHR(227) + "o")
9110:             loc_oBusca.Show()
9111: 
9112:             IF loc_oBusca.this_lSelecionou
9113:                 IF USED("cursor_4c_Busca")
9114:                     SELECT cursor_4c_Busca
9115:                     loc_oPg.txt_4c_Col.Value          = ALLTRIM(ccols)
9116:                     loc_oPg.txt_4c_DColDisplay.Value  = ALLTRIM(dcols)
9117:                     USE IN cursor_4c_Busca
9118:                 ENDIF
9119:             ENDIF
9120: 
9121:             loc_oBusca.Release()
9122:             loc_oBusca = .NULL.
9123:         CATCH TO loc_oErro
9124:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo de venda")
9125:         ENDTRY
9126:     ENDPROC
9127: 
9128:     *--------------------------------------------------------------------------
9129:     * AbrirLookupIfor - Abre busca de fornecedor (SigCdCli)
9130:     *--------------------------------------------------------------------------
9131:     PROCEDURE AbrirLookupIfor()
9132:         LOCAL loc_oBusca, loc_oPg
9133:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9134: 
9135:         TRY
9136:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_Busca", "Iclis", "", "Busca de Fornecedor")
9137:             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
9138:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
9139:             loc_oBusca.Show()
9140: 
9141:             IF loc_oBusca.this_lSelecionou
9142:                 IF USED("cursor_4c_Busca")
9143:                     SELECT cursor_4c_Busca
9144:                     loc_oPg.txt_4c_Ifor.Value         = ALLTRIM(Iclis)
9145:                     loc_oPg.txt_4c_DforDisplay.Value  = ALLTRIM(Rclis)
9146:                     USE IN cursor_4c_Busca
9147:                 ENDIF
9148:             ENDIF
9149: 
9150:             loc_oBusca.Release()
9151:             loc_oBusca = .NULL.
9152:         CATCH TO loc_oErro
9153:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de fornecedor")
9154:         ENDTRY
9155:     ENDPROC
9156: 
9157:     *==========================================================================
9158:     * HANDLERS DE KEYPRESS - FASE 6 (novos campos com lookup)
9159:     *==========================================================================
9160: 
9161:     *--------------------------------------------------------------------------
9162:     * TxtCorKeyPress - KeyPress no campo Cor (ENTER/F4 abre lookup SigCdCor)
9163:     *--------------------------------------------------------------------------
9164:     PROCEDURE TxtCorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9165:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9166:             THIS.ValidarCor()
9167:         ENDIF
9168:         IF par_nKeyCode = 115
9169:             THIS.AbrirLookupCor()
9170:         ENDIF
9171:     ENDPROC
9172: 
9173:     *--------------------------------------------------------------------------
9174:     * TxtTamKeyPress - KeyPress no campo Tamanho (ENTER/F4 abre lookup SigCdTam)
9175:     *--------------------------------------------------------------------------
9176:     PROCEDURE TxtTamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9177:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9178:             THIS.ValidarTam()
9179:         ENDIF
9180:         IF par_nKeyCode = 115
9181:             THIS.AbrirLookupTam()
9182:         ENDIF
9183:     ENDPROC
9184: 
9185:     *--------------------------------------------------------------------------
9186:     * TxtCodFinPKeyPress - KeyPress no campo Ficha (ENTER/F4 abre lookup SigCdFip)
9187:     *--------------------------------------------------------------------------
9188:     PROCEDURE TxtCodFinPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9189:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9190:             THIS.ValidarCodFinP()
9191:         ENDIF
9192:         IF par_nKeyCode = 115
9193:             THIS.AbrirLookupFinP()
9194:         ENDIF
9195:     ENDPROC
9196: 
9197:     *--------------------------------------------------------------------------
9198:     * TxtCodAcbKeyPress - KeyPress no campo Acabamento (ENTER/F4 abre lookup SigCdAca)
9199:     *--------------------------------------------------------------------------
9200:     PROCEDURE TxtCodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9201:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9202:             THIS.ValidarCodAcb()
9203:         ENDIF
9204:         IF par_nKeyCode = 115
9205:             THIS.AbrirLookupAcb()
9206:         ENDIF
9207:     ENDPROC
9208: 
9209:     *--------------------------------------------------------------------------
9210:     * TxtClassKeyPress - KeyPress no campo Classe (ENTER/F4 abre lookup SIGCDCLS)
9211:     *--------------------------------------------------------------------------
9212:     PROCEDURE TxtClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9213:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9214:             THIS.ValidarClass()
9215:         ENDIF
9216:         IF par_nKeyCode = 115
9217:             THIS.AbrirLookupClass()
9218:         ENDIF
9219:     ENDPROC
9220: 
9221:     *--------------------------------------------------------------------------
9222:     * TxtLocalKeyPress - KeyPress no campo Local (ENTER/F4 abre lookup SigPrLcl)
9223:     *--------------------------------------------------------------------------
9224:     PROCEDURE TxtLocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9225:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9226:             THIS.ValidarLocal()
9227:         ENDIF
9228:         IF par_nKeyCode = 115
9229:             THIS.AbrirLookupLocal()
9230:         ENDIF
9231:     ENDPROC
9232: 
9233:     *--------------------------------------------------------------------------
9234:     * TxtCuniKeyPress - KeyPress no campo Unidade (ENTER/F4 abre lookup SigCdUni)
9235:     *--------------------------------------------------------------------------
9236:     PROCEDURE TxtCuniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9237:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9238:             THIS.ValidarCuni()
9239:         ENDIF
9240:         IF par_nKeyCode = 115
9241:             THIS.AbrirLookupUni()
9242:         ENDIF
9243:     ENDPROC
9244: 
9245:     *--------------------------------------------------------------------------
9246:     * TxtCunipKeyPress - KeyPress no campo Uni.Pedido (ENTER/F4 abre lookup SigCdUni)
9247:     *--------------------------------------------------------------------------
9248:     PROCEDURE TxtCunipKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9249:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9250:             THIS.ValidarCunip()
9251:         ENDIF
9252:         IF par_nKeyCode = 115
9253:             THIS.AbrirLookupUniP()
9254:         ENDIF
9255:     ENDPROC
9256: 
9257:     *--------------------------------------------------------------------------
9258:     * TxtMctotalKeyPress - KeyPress no campo Moeda Custo (ENTER/F4 abre lookup SigCdMoe)
9259:     *--------------------------------------------------------------------------
9260:     PROCEDURE TxtMctotalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9261:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9262:             THIS.ValidarMoe("total")
9263:         ENDIF
9264:         IF par_nKeyCode = 115
9265:             THIS.AbrirLookupMctotal()
9266:         ENDIF
9267:     ENDPROC
9268: 
9269:     *--------------------------------------------------------------------------
9270:     * TxtMpvendaKeyPress - KeyPress no campo Moeda P.Venda (ENTER/F4 abre lookup SigCdMoe)
9271:     *--------------------------------------------------------------------------
9272:     PROCEDURE TxtMpvendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9273:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9274:             THIS.ValidarMoe("pvenda")
9275:         ENDIF
9276:         IF par_nKeyCode = 115
9277:             THIS.AbrirLookupMpvenda()
9278:         ENDIF
9279:     ENDPROC
9280: 
9281:     *--------------------------------------------------------------------------
9282:     * TxtMfvendaKeyPress - KeyPress no campo Moeda F.Venda (ENTER/F4 abre lookup SigCdMoe)
9283:     *--------------------------------------------------------------------------
9284:     PROCEDURE TxtMfvendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9285:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9286:             THIS.ValidarMoe("fvenda")
9287:         ENDIF
9288:         IF par_nKeyCode = 115
9289:             THIS.AbrirLookupMfvenda()
9290:         ENDIF
9291:     ENDPROC
9292: 
9293:     *==========================================================================
9294:     * HANDLERS - FASE 9 - pgComposicao
9295:     *==========================================================================
9296: 
9297:     *--------------------------------------------------------------------------
9298:     * GrdCompoAfterRowColChange - AfterRowColChange do grid de composicao
9299:     * Refresha campos de descricao e observacao da OF quando muda a linha
9300:     *--------------------------------------------------------------------------
9301:     PROCEDURE GrdCompoAfterRowColChange(par_nColIndex)
9302:         LOCAL loc_oPg
9303:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9304:         IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
9305:             loc_oPg.txt_4c_DescComp.Value = ALLTRIM(cursor_4c_Compo.dcompos)
9306:             loc_oPg.txt_4c_ObsOFs.Value   = ALLTRIM(cursor_4c_Compo.obscompos)
9307:         ELSE
9308:             loc_oPg.txt_4c_DescComp.Value = ""
9309:             loc_oPg.txt_4c_ObsOFs.Value   = ""
9310:         ENDIF
9311:     ENDPROC
9312: 
9313:     *--------------------------------------------------------------------------
9314:     * GrdSubCpAfterRowColChange - AfterRowColChange do grid de sub-composicao
9315:     *--------------------------------------------------------------------------
9316:     PROCEDURE GrdSubCpAfterRowColChange(par_nColIndex)
9317:         LOCAL loc_oPg
9318:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9319:         IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
9320:             loc_oPg.txt_4c_DescSubCp.Value = ALLTRIM(cursor_4c_SubCp.dcompos)
9321:             loc_oPg.txt_4c_MatSubs.Value   = ALLTRIM(cursor_4c_SubCp.matsubs)
9322:         ELSE
9323:             loc_oPg.txt_4c_DescSubCp.Value = ""
9324:             loc_oPg.txt_4c_MatSubs.Value   = ""
9325:         ENDIF
9326:     ENDPROC
9327: 
9328:     *--------------------------------------------------------------------------
9329:     * ChkLiberaCustoClick - habilitar/desabilitar campos de custo
9330:     *--------------------------------------------------------------------------
9331:     PROCEDURE ChkLiberaCustoClick()
9332:         LOCAL loc_oPg, loc_lLiberado
9333:         loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9334:         loc_lLiberado = (loc_oPg.chk_4c_LiberaCusto.Value = 1)
9335:         loc_oPg.txt_4c_Pcus.ReadOnly      = !loc_lLiberado
9336:         loc_oPg.txt_4c_Fcusto.ReadOnly    = !loc_lLiberado
9337:         loc_oPg.txt_4c_Moec.ReadOnly      = !loc_lLiberado
9338:         loc_oPg.txt_4c_Moepc.ReadOnly     = !loc_lLiberado
9339:         loc_oPg.txt_4c_CotaCalcP.ReadOnly = !loc_lLiberado
9340:         IF loc_lLiberado
9341:             loc_oPg.txt_4c_Pcus.BackColor   = RGB(255, 255, 255)
9342:             loc_oPg.txt_4c_Fcusto.BackColor  = RGB(255, 255, 255)
9343:             loc_oPg.txt_4c_CotaCalcP.BackColor = RGB(255, 255, 255)
9344:         ELSE
9345:             loc_oPg.txt_4c_Pcus.BackColor   = RGB(224, 235, 235)
9346:             loc_oPg.txt_4c_Fcusto.BackColor  = RGB(224, 235, 235)
9347:             loc_oPg.txt_4c_CotaCalcP.BackColor = RGB(224, 235, 235)
9348:         ENDIF
9349:     ENDPROC
9350: 
9351:     *--------------------------------------------------------------------------
9352:     * ChkLiberaVendaClick - habilitar/desabilitar campos de venda
9353:     *--------------------------------------------------------------------------
9354:     PROCEDURE ChkLiberaVendaClick()
9355:         LOCAL loc_oPg, loc_lLiberado
9356:         loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9357:         loc_lLiberado = (loc_oPg.chk_4c_LiberaVenda.Value = 1)
9358:         loc_oPg.txt_4c_FAtuals.ReadOnly = !loc_lLiberado
9359:         loc_oPg.txt_4c_Fideals.ReadOnly = !loc_lLiberado
9360:         IF loc_lLiberado
9361:             loc_oPg.txt_4c_FAtuals.BackColor = RGB(255, 255, 255)
9362:             loc_oPg.txt_4c_Fideals.BackColor = RGB(255, 255, 255)
9363:         ELSE
9364:             loc_oPg.txt_4c_FAtuals.BackColor = RGB(224, 235, 235)
9365:             loc_oPg.txt_4c_Fideals.BackColor = RGB(224, 235, 235)
9366:         ENDIF
9367:     ENDPROC
9368: 
9369:     *--------------------------------------------------------------------------
9370:     * TxtPcusValid - Valid no campo Preco de Custo -> recalcula precos
9371:     *--------------------------------------------------------------------------
9372:     PROCEDURE TxtPcusValid()
9373:         THIS.CalcPrecoComposicao()
9374:     ENDPROC
9375: 
9376:     *--------------------------------------------------------------------------
9377:     * TxtFcustoValid - Valid no campo Fator de Custo -> recalcula precos
9378:     *--------------------------------------------------------------------------
9379:     PROCEDURE TxtFcustoValid()
9380:         THIS.CalcPrecoComposicao()
9381:     ENDPROC
9382: 
9383:     *--------------------------------------------------------------------------
9384:     * TxtMargemValid - Valid na Margem/MKP -> recalcula precos
9385:     *--------------------------------------------------------------------------
9386:     PROCEDURE TxtMargemValid()
9387:         THIS.CalcPrecoComposicao()
9388:     ENDPROC
9389: 
9390:     *--------------------------------------------------------------------------
9391:     * TxtMarkupAValid - Valid no MarkupA -> recalcula precos
9392:     *--------------------------------------------------------------------------
9393:     PROCEDURE TxtMarkupAValid()
9394:         THIS.CalcPrecoComposicao()
9395:     ENDPROC
9396: 
9397:     *--------------------------------------------------------------------------
9398:     * TxtCotaCalcPValid - Valid na Cotacao -> recalcula precos
9399:     *--------------------------------------------------------------------------
9400:     PROCEDURE TxtCotaCalcPValid()
9401:         THIS.CalcPrecoComposicao()
9402:         LOCAL loc_oPg
9403:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9404:         loc_oPg.Refresh()
9405:     ENDPROC
9406: 
9407:     *--------------------------------------------------------------------------
9408:     * TxtMoecKeyPress - KeyPress no campo Moeda Custo (ENTER/F4 abre lookup SigCdMoe)
9409:     *--------------------------------------------------------------------------
9410:     PROCEDURE TxtMoecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9411:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9412:             THIS.ValidarMoeCompo("moec")
9413:         ENDIF
9414:         IF par_nKeyCode = 115
9415:             THIS.AbrirLookupMoeCompo("moec")
9416:         ENDIF
9417:     ENDPROC
9418: 
9419:     *--------------------------------------------------------------------------
9420:     * TxtMoepcKeyPress - KeyPress no campo Moeda P.Custo (ENTER/F4 abre lookup SigCdMoe)
9421:     *--------------------------------------------------------------------------
9422:     PROCEDURE TxtMoepcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9423:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9424:             THIS.ValidarMoeCompo("moepc")
9425:         ENDIF
9426:         IF par_nKeyCode = 115
9427:             THIS.AbrirLookupMoeCompo("moepc")
9428:         ENDIF
9429:     ENDPROC
9430: 
9431:     *--------------------------------------------------------------------------
9432:     * TxtMoedaKeyPress - KeyPress no campo Moeda Venda (ENTER/F4 abre lookup SigCdMoe)
9433:     *--------------------------------------------------------------------------
9434:     PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9435:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9436:             THIS.ValidarMoeCompo("moeda")
9437:         ENDIF
9438:         IF par_nKeyCode = 115
9439:             THIS.AbrirLookupMoeCompo("moeda")
9440:         ENDIF
9441:     ENDPROC
9442: 
9443:     *--------------------------------------------------------------------------
9444:     * TxtMoepvKeyPress - KeyPress no campo Moeda P.Venda (ENTER/F4 abre lookup SigCdMoe)
9445:     *--------------------------------------------------------------------------
9446:     PROCEDURE TxtMoepvKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9447:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9448:             THIS.ValidarMoeCompo("moepv")
9449:         ENDIF
9450:         IF par_nKeyCode = 115
9451:             THIS.AbrirLookupMoeCompo("moepv")
9452:         ENDIF
9453:     ENDPROC
9454: 
9455:     *--------------------------------------------------------------------------
9456:     * ValidarMoeCompo - Valida campo de moeda na pagina composicao
9457:     * par_cTipo: "moec"|"moepc"|"moeda"|"moepv"
9458:     *--------------------------------------------------------------------------
9459:     PROTECTED PROCEDURE ValidarMoeCompo(par_cTipo)
9460:         LOCAL loc_oPg, loc_oTxt, loc_cCodMoe, loc_cSQL, loc_lOk
9461:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9462:         DO CASE
9463:         CASE par_cTipo = "moec"
9464:             loc_oTxt = loc_oPg.txt_4c_Moec
9465:         CASE par_cTipo = "moepc"
9466:             loc_oTxt = loc_oPg.txt_4c_Moepc
9467:         CASE par_cTipo = "moeda"
9468:             loc_oTxt = loc_oPg.txt_4c_Moeda
9469:         CASE par_cTipo = "moepv"
9470:             loc_oTxt = loc_oPg.txt_4c_Moepv
9471:         OTHERWISE
9472:             RETURN
9473:         ENDCASE
9474:         loc_cCodMoe = ALLTRIM(loc_oTxt.Value)
9475:         IF EMPTY(loc_cCodMoe)
9476:             RETURN
9477:         ENDIF
9478:         loc_lOk = .F.
9479:         TRY
9480:             loc_cSQL = "SELECT cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCodMoe)
9481:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeCompo") > 0
9482:                 loc_lOk = .T.
9483:             ENDIF
9484:         CATCH TO loc_oErro
9485:             MsgErro(loc_oErro.Message, "Erro ao validar moeda")
9486:         ENDTRY
9487:         IF loc_lOk
9488:             IF EOF("cursor_4c_BuscaMoeCompo")
9489:                 MsgAviso("Moeda " + loc_cCodMoe + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9490:                 loc_oTxt.Value = ""
9491:             ENDIF
9492:             IF USED("cursor_4c_BuscaMoeCompo")
9493:                 USE IN cursor_4c_BuscaMoeCompo
9494:             ENDIF
9495:         ENDIF
9496:     ENDPROC
9497: 
9498:     *--------------------------------------------------------------------------
9499:     * AbrirLookupMoeCompo - Abre lookup de moeda na pagina composicao
9500:     *--------------------------------------------------------------------------
9501:     PROTECTED PROCEDURE AbrirLookupMoeCompo(par_cTipo)
9502:         LOCAL loc_oBusca, loc_oPg, loc_oTxt
9503:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9504:         DO CASE
9505:         CASE par_cTipo = "moec"
9506:             loc_oTxt = loc_oPg.txt_4c_Moec
9507:         CASE par_cTipo = "moepc"
9508:             loc_oTxt = loc_oPg.txt_4c_Moepc
9509:         CASE par_cTipo = "moeda"
9510:             loc_oTxt = loc_oPg.txt_4c_Moeda
9511:         CASE par_cTipo = "moepv"
9512:             loc_oTxt = loc_oPg.txt_4c_Moepv
9513:         OTHERWISE
9514:             RETURN
9515:         ENDCASE
9516:         TRY
9517:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
9518:             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMoeCompo"
9519:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
9520:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
9521:             loc_oBusca.cTabela    = "SigCdMoe"
9522:             loc_oBusca.cCampoChave = "cmoes"
9523:             loc_oBusca.cFiltroIni = ALLTRIM(loc_oTxt.Value)
9524:             loc_oBusca.Show()
9525:             IF loc_oBusca.this_lSelecionou
9526:                 loc_oTxt.Value = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
9527:             ENDIF
9528:             IF USED("cursor_4c_BuscaMoeCompo")
9529:                 USE IN cursor_4c_BuscaMoeCompo
9530:             ENDIF
9531:             loc_oBusca.Release()
9532:         CATCH TO loc_oErro
9533:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de moeda")
9534:         ENDTRY
9535:     ENDPROC
9536: 
9537:     *--------------------------------------------------------------------------
9538:     * CalcPrecoComposicao - Recalcula precos baseado nos valores de custo/margem
9539:     * Equivalente ao CalcPreco/CalcPreMoe do legado (stub - logica completa no BO)
9540:     *--------------------------------------------------------------------------
9541:     PROTECTED PROCEDURE CalcPrecoComposicao()
9542:         LOCAL loc_oPg, loc_nPcus, loc_nMargem, loc_nPven
9543:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9544:         loc_nPcus  = loc_oPg.txt_4c_Pcus.Value
9545:         loc_nMargem = loc_oPg.txt_4c_Margem.Value
9546:         *-- Calculo simplificado: Preco Venda = Custo * (1 + Margem/100)
9547:         *-- O calculo completo com fatores/moedas sera feito via BO
9548:         IF loc_nMargem > 0 AND loc_nPcus > 0
9549:             loc_nPven = loc_nPcus * (1 + loc_nMargem / 100)
9550:             loc_oPg.txt_4c_Pvens.Value = loc_nPven
9551:         ENDIF
9552:     ENDPROC
9553: 
9554:     *--------------------------------------------------------------------------
9555:     * CmdCalcValsClick - Botao Calcular Valores (cmdCalcVals)
9556:     * Aciona recalculo completo de precos (equivalente ao CalcPreco do legado)
9557:     *--------------------------------------------------------------------------
9558:     PROCEDURE CmdCalcValsClick()
9559:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9560:             RETURN
9561:         ENDIF
9562:         THIS.CalcPrecoComposicao()
9563:     ENDPROC
9564: 
9565:     *--------------------------------------------------------------------------
9566:     * CmdPesoMClick - Botao calcular peso medio (abre form sigcdpes)
9567:     *--------------------------------------------------------------------------
9568:     PROCEDURE CmdPesoMClick()
9569:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o de c" + CHR(225) + "lculo de peso n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Peso M" + CHR(233) + "dio")
9570:     ENDPROC
9571: 
9572:     *--------------------------------------------------------------------------
9573:     * CmdgCompoClick - Click no CommandGroup de composicao (5 botoes)
9574:     * .Value=1 Inserir | 2 Excluir | 3 Atualizar Custo | 4 Atualizar Preco | 5 Atualizar Pesos
9575:     *--------------------------------------------------------------------------
9576:     PROCEDURE CmdgCompoClick()
9577:         LOCAL loc_oPg, loc_nBtn, loc_oGrd
9578:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9579:         loc_nBtn = loc_oPg.obj_4c_CmdgCompo.Value
9580:         loc_oGrd = loc_oPg.grd_4c_Compo
9581: 
9582:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9583:             RETURN
9584:         ENDIF
9585: 
9586:         DO CASE
9587:         CASE loc_nBtn = 1
9588:             *-- Inserir item de composicao
9589:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9590:                 MsgAviso("Selecione o modo Incluir ou Alterar para inserir itens.", "Aten" + CHR(231) + CHR(227) + "o")
9591:                 RETURN
9592:             ENDIF
9593:             IF USED("cursor_4c_Compo")
9594:                 SELECT cursor_4c_Compo
9595:                 APPEND BLANK
9596:                 loc_oGrd.Refresh()
9597:             ENDIF
9598: 
9599:         CASE loc_nBtn = 2
9600:             *-- Excluir item de composicao
9601:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9602:                 RETURN
9603:             ENDIF
9604:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
9605:                 IF MsgConfirma("Excluir o item selecionado?", "Confirmar")
9606:                     SELECT cursor_4c_Compo
9607:                     DELETE
9608:                     IF !EOF("cursor_4c_Compo")
9609:                         SKIP
9610:                         SKIP -1
9611:                     ENDIF
9612:                     loc_oGrd.Refresh()
9613:                 ENDIF
9614:             ENDIF
9615: 
9616:         CASE loc_nBtn = 3
9617:             *-- Atualizar custo
9618:             THIS.CalcPrecoComposicao()
9619: 
9620:         CASE loc_nBtn = 4
9621:             *-- Atualizar preco
9622:             THIS.CalcPrecoComposicao()
9623: 
9624:         CASE loc_nBtn = 5
9625:             *-- Atualizar pesos
9626:             THIS.CmdPesoMClick()
9627: 
9628:         ENDCASE
9629:     ENDPROC
9630: 
9631:     *--------------------------------------------------------------------------
9632:     * CmdgSubCpClick - Click no CommandGroup de sub-composicao (2 botoes)
9633:     * .Value=1 Inserir | 2 Excluir
9634:     *--------------------------------------------------------------------------
9635:     PROCEDURE CmdgSubCpClick()
9636:         LOCAL loc_oPg, loc_nBtn, loc_oGrd
9637:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9638:         loc_nBtn = loc_oPg.obj_4c_CmdgSubCp.Value
9639:         loc_oGrd = loc_oPg.grd_4c_SubCp
9640: 
9641:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9642:             RETURN
9643:         ENDIF
9644: 
9645:         DO CASE
9646:         CASE loc_nBtn = 1
9647:             *-- Inserir item de sub-composicao
9648:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9649:                 MsgAviso("Selecione o modo Incluir ou Alterar para inserir itens.", "Aten" + CHR(231) + CHR(227) + "o")
9650:                 RETURN
9651:             ENDIF
9652:             IF USED("cursor_4c_SubCp")
9653:                 SELECT cursor_4c_SubCp
9654:                 APPEND BLANK
9655:                 loc_oGrd.Refresh()
9656:             ENDIF
9657: 
9658:         CASE loc_nBtn = 2
9659:             *-- Excluir item de sub-composicao
9660:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9661:                 RETURN
9662:             ENDIF
9663:             IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
9664:                 IF MsgConfirma("Excluir o sub-item selecionado?", "Confirmar")
9665:                     SELECT cursor_4c_SubCp
9666:                     DELETE
9667:                     IF !EOF("cursor_4c_SubCp")
9668:                         SKIP
9669:                         SKIP -1
9670:                     ENDIF
9671:                     loc_oGrd.Refresh()
9672:                 ENDIF
9673:             ENDIF
9674: 
9675:         ENDCASE
9676:     ENDPROC
9677: 
9678:     *--------------------------------------------------------------------------
9679:     * GrdCustoCompoAfterRowColChange - AfterRowColChange do grid Custo
9680:     * Atualiza txt_4c_Desc (descricao item) e txt_4c_DGruCompos (desc grupo)
9681:     *--------------------------------------------------------------------------
9682:     PROCEDURE GrdCustoCompoAfterRowColChange(par_nColIndex)
9683:         LOCAL loc_oPg, loc_cGrupo, loc_nRet, loc_oErro
9684:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9685: 
9686:         IF USED("cursor_4c_CustoCompo") AND !EOF("cursor_4c_CustoCompo")
9687:             loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_CustoCompo.dcompos)
9688:             loc_cGrupo = ALLTRIM(cursor_4c_CustoCompo.CGrus)
9689:             IF !EMPTY(loc_cGrupo)
9690:                 TRY
9691:                     loc_nRet = SQLEXEC(gnConnHandle, ;
9692:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cGrupo), ;
9693:                         "cursor_4c_GruCustoDesc")
9694:                     IF loc_nRet > 0 AND USED("cursor_4c_GruCustoDesc") AND !EOF("cursor_4c_GruCustoDesc")
9695:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_GruCustoDesc.DGrus)
9696:                     ELSE
9697:                         loc_oPg.txt_4c_DGruCompos.Value = ""
9698:                     ENDIF
9699:                     IF USED("cursor_4c_GruCustoDesc")
9700:                         USE IN cursor_4c_GruCustoDesc
9701:                     ENDIF
9702:                 CATCH TO loc_oErro
9703:                     MsgErro(loc_oErro.Message, "Erro ao buscar grupo da composi" + CHR(231) + CHR(227) + "o")
9704:                 ENDTRY
9705:             ELSE
9706:                 loc_oPg.txt_4c_DGruCompos.Value = ""
9707:             ENDIF
9708:         ELSE
9709:             loc_oPg.txt_4c_Desc.Value       = ""
9710:             loc_oPg.txt_4c_DGruCompos.Value = ""
9711:         ENDIF
9712:     ENDPROC
9713: 
9714:     *--------------------------------------------------------------------------
9715:     * CmdgCustoClick - Click no CommandGroup de composicao Custo (2 botoes)
9716:     * .Value=1 Inserir | .Value=2 Excluir
9717:     *--------------------------------------------------------------------------
9718:     PROCEDURE CmdgCustoClick()
9719:         LOCAL loc_oPg, loc_nBtn, loc_oGrd
9720:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9721:         loc_nBtn = loc_oPg.obj_4c_CmdgCusto.Value
9722:         loc_oGrd = loc_oPg.grd_4c_CustoCompo
9723: 
9724:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9725:             RETURN
9726:         ENDIF
9727: 
9728:         DO CASE
9729:         CASE loc_nBtn = 1
9730:             *-- Inserir item de composicao custo
9731:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9732:                 MsgAviso("Selecione o modo Incluir ou Alterar para inserir itens.", "Aten" + CHR(231) + CHR(227) + "o")
9733:                 RETURN
9734:             ENDIF
9735:             IF USED("cursor_4c_CustoCompo")
9736:                 SELECT cursor_4c_CustoCompo
9737:                 APPEND BLANK
9738:                 loc_oGrd.Refresh()
9739:             ENDIF
9740: 
9741:         CASE loc_nBtn = 2
9742:             *-- Excluir item de composicao custo
9743:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9744:                 RETURN
9745:             ENDIF
9746:             IF USED("cursor_4c_CustoCompo") AND !EOF("cursor_4c_CustoCompo")
9747:                 IF MsgConfirma("Excluir o item selecionado?", "Confirmar")
9748:                     SELECT cursor_4c_CustoCompo
9749:                     DELETE
9750:                     IF !EOF("cursor_4c_CustoCompo")
9751:                         SKIP
9752:                         SKIP -1
9753:                     ENDIF
9754:                     loc_oGrd.Refresh()
9755:                 ENDIF
9756:             ENDIF
9757: 
9758:         ENDCASE
9759:     ENDPROC
9760: 
9761:     *--------------------------------------------------------------------------
9762:     * CboTiposCustoInteractiveChange - InteractiveChange do cmbTipos na aba Custo
9763:     * Filtra/recarrega grid de composicao pelo tipo selecionado
9764:     *--------------------------------------------------------------------------
9765:     PROCEDURE CboTiposCustoInteractiveChange()
9766:         LOCAL loc_oPg
9767:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9768: 
9769:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9770:             RETURN
9771:         ENDIF
9772: 
9773:         IF USED("cursor_4c_CustoCompo")
9774:             GO TOP IN cursor_4c_CustoCompo
9775:         ENDIF
9776:         loc_oPg.grd_4c_CustoCompo.Refresh()
9777:     ENDPROC
9778: 
9779:     *==========================================================================
9780:     * VALIDACOES - FASE 6
9781:     *==========================================================================
9782: 
9783:     *--------------------------------------------------------------------------
9784:     * ValidarCor - Valida e carrega tooltip da cor (SigCdCor)
9785:     *--------------------------------------------------------------------------
9786:     PROTECTED PROCEDURE ValidarCor()
9787:         LOCAL loc_cCodCor, loc_oPg
9788:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9789:         loc_cCodCor = ALLTRIM(loc_oPg.txt_4c_Cor.Value)
9790:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9791:             RETURN
9792:         ENDIF
9793:         THIS.CarregarDescCor(loc_cCodCor)
9794:     ENDPROC
9795: 
9796:     *--------------------------------------------------------------------------
9797:     * ValidarTam - Valida e carrega tooltip do tamanho (SigCdTam)
9798:     *--------------------------------------------------------------------------
9799:     PROTECTED PROCEDURE ValidarTam()
9800:         LOCAL loc_cCodTam, loc_oPg
9801:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9802:         loc_cCodTam = ALLTRIM(loc_oPg.txt_4c_Tam.Value)
9803:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9804:             RETURN
9805:         ENDIF
9806:         THIS.CarregarDescTam(loc_cCodTam)
9807:     ENDPROC
9808: 
9809:     *--------------------------------------------------------------------------
9810:     * ValidarCodFinP - Valida campo ficha e carrega descricao (SigCdFip)
9811:     *--------------------------------------------------------------------------
9812:     PROTECTED PROCEDURE ValidarCodFinP()
9813:         LOCAL loc_cCodFinP, loc_oPg
9814:         loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9815:         loc_cCodFinP = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
9816:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9817:             RETURN
9818:         ENDIF
9819:         THIS.CarregarDescFinP(loc_cCodFinP)
9820:         IF !EMPTY(loc_cCodFinP) AND EMPTY(loc_oPg.txt_4c_DesFinP.Value)
9821:             MsgAviso("Ficha " + loc_cCodFinP + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9822:         ENDIF
9823:     ENDPROC
9824: 
9825:     *--------------------------------------------------------------------------
9826:     * ValidarCodAcb - Valida campo acabamento e carrega descricao (SigCdAca)
9827:     *--------------------------------------------------------------------------
9828:     PROTECTED PROCEDURE ValidarCodAcb()
9829:         LOCAL loc_cCodAcb, loc_oPg
9830:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9831:         loc_cCodAcb = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
9832:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9833:             RETURN
9834:         ENDIF
9835:         THIS.CarregarDescAcb(loc_cCodAcb)
9836:         IF !EMPTY(loc_cCodAcb) AND EMPTY(loc_oPg.txt_4c_DacbDisplay.Value)
9837:             MsgAviso("Acabamento " + loc_cCodAcb + " n" + CHR(227) + "o encontrado.", "Inv" + CHR(225) + "lido")
9838:         ENDIF
9839:     ENDPROC
9840: 
9841:     *--------------------------------------------------------------------------
9842:     * ValidarClass - Valida campo classificacao e carrega descricao (SIGCDCLS)
9843:     *--------------------------------------------------------------------------
9844:     PROTECTED PROCEDURE ValidarClass()
9845:         LOCAL loc_cCclass, loc_oPg
9846:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9847:         loc_cCclass = ALLTRIM(loc_oPg.txt_4c_Class.Value)
9848:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9849:             RETURN
9850:         ENDIF
9851:         THIS.CarregarDescClass(loc_cCclass)
9852:         IF !EMPTY(loc_cCclass) AND EMPTY(loc_oPg.txt_4c_DClassDisplay.Value)
9853:             MsgAviso("Classifica" + CHR(231) + CHR(227) + "o " + loc_cCclass + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9854:         ENDIF
9855:     ENDPROC
9856: 
9857:     *--------------------------------------------------------------------------
9858:     * ValidarLocal - Valida campo local (SigPrLcl)
9859:     *--------------------------------------------------------------------------
9860:     PROTECTED PROCEDURE ValidarLocal()
9861:         LOCAL loc_cLocals, loc_oPg
9862:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9863:         loc_cLocals = ALLTRIM(loc_oPg.txt_4c_Local.Value)
9864:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9865:             RETURN
9866:         ENDIF
9867:         THIS.CarregarDescLocal(loc_cLocals)
9868:     ENDPROC
9869: 
9870:     *--------------------------------------------------------------------------
9871:     * ValidarCuni - Valida campo unidade e carrega descricao (SigCdUni)
9872:     *--------------------------------------------------------------------------
9873:     PROTECTED PROCEDURE ValidarCuni()
9874:         LOCAL loc_cCunis, loc_oPg
9875:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9876:         loc_cCunis  = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
9877:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9878:             RETURN
9879:         ENDIF
9880:         THIS.CarregarDescUni(loc_cCunis, "uni")
9881:         IF !EMPTY(loc_cCunis) AND EMPTY(loc_oPg.txt_4c_DuniDisplay.Value)
9882:             MsgAviso("Unidade " + loc_cCunis + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9883:         ENDIF
9884:     ENDPROC
9885: 
9886:     *--------------------------------------------------------------------------
9887:     * ValidarCunip - Valida campo unidade de pedido (SigCdUni)
9888:     *--------------------------------------------------------------------------
9889:     PROTECTED PROCEDURE ValidarCunip()
9890:         LOCAL loc_cCunips, loc_oPg
9891:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9892:         loc_cCunips = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
9893:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9894:             RETURN
9895:         ENDIF
9896:         THIS.CarregarDescUni(loc_cCunips, "unip")
9897:         IF !EMPTY(loc_cCunips) AND EMPTY(loc_oPg.txt_4c_DunipDisplay.Value)
9898:             MsgAviso("Unidade " + loc_cCunips + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9899:         ENDIF
9900:     ENDPROC
9901: 
9902:     *--------------------------------------------------------------------------
9903:     * ValidarMoe - Valida campo moeda (SigCdMoe)
9904:     * par_cTipo: "total" | "pvenda" | "fvenda"
9905:     *--------------------------------------------------------------------------
9906:     PROTECTED PROCEDURE ValidarMoe(par_cTipo)
9907:         LOCAL loc_cCmoes, loc_oPg
9908:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9909:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9910:             RETURN
9911:         ENDIF
9912:         DO CASE
9913:         CASE par_cTipo = "total"
9914:             loc_cCmoes = ALLTRIM(loc_oPg.txt_4c_Mctotal.Value)
9915:         CASE par_cTipo = "pvenda"
9916:             loc_cCmoes = ALLTRIM(loc_oPg.txt_4c_Mpvenda.Value)
9917:         OTHERWISE
9918:             loc_cCmoes = ALLTRIM(loc_oPg.txt_4c_Mfvenda.Value)
9919:         ENDCASE
9920:         THIS.CarregarDescMoe(loc_cCmoes, par_cTipo)
9921:     ENDPROC
9922: 
9923:     *==========================================================================
9924:     * LOOKUPS - FASE 6
9925:     *==========================================================================
9926: 
9927:     *--------------------------------------------------------------------------
9928:     * AbrirLookupCor - Abre busca de cor (SigCdCor)
9929:     *--------------------------------------------------------------------------
9930:     PROCEDURE AbrirLookupCor()
9931:         LOCAL loc_oBusca, loc_oPg
9932:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9933:         TRY
9934:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9935:                 "SigCdCor", "cursor_4c_BuscaCor", "cods", ;
9936:                 ALLTRIM(loc_oPg.txt_4c_Cor.Value), "Busca de Cor")
9937:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9938:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9939:             loc_oBusca.Show()
9940:             IF loc_oBusca.this_lSelecionou
9941:                 IF USED("cursor_4c_BuscaCor")
9942:                     SELECT cursor_4c_BuscaCor
9943:                     loc_oPg.txt_4c_Cor.Value = ALLTRIM(cods)
9944:                     USE IN cursor_4c_BuscaCor
9945:                 ENDIF
9946:             ENDIF
9947:             loc_oBusca.Release()
9948:             loc_oBusca = .NULL.
9949:         CATCH TO loc_oErro
9950:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de cor")
9951:         ENDTRY
9952:     ENDPROC
9953: 
9954:     *--------------------------------------------------------------------------
9955:     * AbrirLookupTam - Abre busca de tamanho (SigCdTam)
9956:     *--------------------------------------------------------------------------
9957:     PROCEDURE AbrirLookupTam()
9958:         LOCAL loc_oBusca, loc_oPg
9959:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9960:         TRY
9961:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9962:                 "SigCdTam", "cursor_4c_BuscaTam", "cods", ;
9963:                 ALLTRIM(loc_oPg.txt_4c_Tam.Value), "Busca de Tamanho")
9964:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9965:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9966:             loc_oBusca.Show()
9967:             IF loc_oBusca.this_lSelecionou
9968:                 IF USED("cursor_4c_BuscaTam")
9969:                     SELECT cursor_4c_BuscaTam
9970:                     loc_oPg.txt_4c_Tam.Value = ALLTRIM(cods)
9971:                     USE IN cursor_4c_BuscaTam
9972:                 ENDIF
9973:             ENDIF
9974:             loc_oBusca.Release()
9975:             loc_oBusca = .NULL.
9976:         CATCH TO loc_oErro
9977:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de tamanho")
9978:         ENDTRY
9979:     ENDPROC
9980: 
9981:     *--------------------------------------------------------------------------
9982:     * AbrirLookupFinP - Abre busca de ficha de produto (SigCdFip)
9983:     *--------------------------------------------------------------------------
9984:     PROCEDURE AbrirLookupFinP()
9985:         LOCAL loc_oBusca, loc_oPg
9986:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9987:         TRY
9988:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9989:                 "SigCdFip", "cursor_4c_BuscaFinP", "cods", ;
9990:                 ALLTRIM(loc_oPg.txt_4c_CodFinP.Value), "Busca de Ficha")
9991:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9992:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9993:             loc_oBusca.Show()
9994:             IF loc_oBusca.this_lSelecionou
9995:                 IF USED("cursor_4c_BuscaFinP")
9996:                     SELECT cursor_4c_BuscaFinP
9997:                     loc_oPg.txt_4c_CodFinP.Value  = ALLTRIM(cods)
9998:                     loc_oPg.txt_4c_DesFinP.Value  = ALLTRIM(descs)
9999:                     USE IN cursor_4c_BuscaFinP
10000:                 ENDIF
10001:             ENDIF
10002:             loc_oBusca.Release()
10003:             loc_oBusca = .NULL.
10004:         CATCH TO loc_oErro
10005:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de ficha")
10006:         ENDTRY
10007:     ENDPROC
10008: 
10009:     *--------------------------------------------------------------------------
10010:     * AbrirLookupAcb - Abre busca de acabamento (SigCdAca)
10011:     *--------------------------------------------------------------------------
10012:     PROCEDURE AbrirLookupAcb()
10013:         LOCAL loc_oBusca, loc_oPg
10014:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10015:         TRY
10016:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10017:                 "SigCdAca", "cursor_4c_BuscaAcb", "cods", ;
10018:                 ALLTRIM(loc_oPg.txt_4c_CodAcb.Value), "Busca de Acabamento")
10019:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
10020:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
10021:             loc_oBusca.Show()
10022:             IF loc_oBusca.this_lSelecionou
10023:                 IF USED("cursor_4c_BuscaAcb")
10024:                     SELECT cursor_4c_BuscaAcb
10025:                     loc_oPg.txt_4c_CodAcb.Value       = ALLTRIM(cods)
10026:                     loc_oPg.txt_4c_DacbDisplay.Value  = ALLTRIM(descrs)
10027:                     USE IN cursor_4c_BuscaAcb
10028:                 ENDIF
10029:             ENDIF
10030:             loc_oBusca.Release()
10031:             loc_oBusca = .NULL.
10032:         CATCH TO loc_oErro
10033:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de acabamento")
10034:         ENDTRY
10035:     ENDPROC
10036: 
10037:     *--------------------------------------------------------------------------
10038:     * AbrirLookupClass - Abre busca de classificacao (SIGCDCLS)
10039:     *--------------------------------------------------------------------------
10040:     PROCEDURE AbrirLookupClass()
10041:         LOCAL loc_oBusca, loc_oPg
10042:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10043:         TRY
10044:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10045:                 "SIGCDCLS", "cursor_4c_BuscaClass", "cods", ;
10046:                 ALLTRIM(loc_oPg.txt_4c_Class.Value), ;
10047:                 "Busca de Classifica" + CHR(231) + CHR(227) + "o")
10048:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
10049:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10050:             loc_oBusca.Show()
10051:             IF loc_oBusca.this_lSelecionou
10052:                 IF USED("cursor_4c_BuscaClass")
10053:                     SELECT cursor_4c_BuscaClass
10054:                     loc_oPg.txt_4c_Class.Value         = ALLTRIM(cods)
10055:                     loc_oPg.txt_4c_DClassDisplay.Value = ALLTRIM(descs)
10056:                     USE IN cursor_4c_BuscaClass
10057:                 ENDIF
10058:             ENDIF
10059:             loc_oBusca.Release()
10060:             loc_oBusca = .NULL.
10061:         CATCH TO loc_oErro
10062:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o")
10063:         ENDTRY
10064:     ENDPROC
10065: 
10066:     *--------------------------------------------------------------------------
10067:     * AbrirLookupLocal - Abre busca de local (SigPrLcl)
10068:     *--------------------------------------------------------------------------
10069:     PROCEDURE AbrirLookupLocal()
10070:         LOCAL loc_oBusca, loc_oPg
10071:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10072:         TRY
10073:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10074:                 "SigPrLcl", "cursor_4c_BuscaLocal", "codigos", ;
10075:                 ALLTRIM(loc_oPg.txt_4c_Local.Value), "Busca de Local")
10076:             loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
10077:             loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10078:             loc_oBusca.Show()
10079:             IF loc_oBusca.this_lSelecionou
10080:                 IF USED("cursor_4c_BuscaLocal")
10081:                     SELECT cursor_4c_BuscaLocal
10082:                     loc_oPg.txt_4c_Local.Value = ALLTRIM(codigos)
10083:                     USE IN cursor_4c_BuscaLocal
10084:                 ENDIF
10085:             ENDIF
10086:             loc_oBusca.Release()
10087:             loc_oBusca = .NULL.
10088:         CATCH TO loc_oErro
10089:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de local")
10090:         ENDTRY
10091:     ENDPROC
10092: 
10093:     *--------------------------------------------------------------------------
10094:     * AbrirLookupUni - Abre busca de unidade (SigCdUni) para campo Cuni
10095:     *--------------------------------------------------------------------------
10096:     PROCEDURE AbrirLookupUni()
10097:         LOCAL loc_oBusca, loc_oPg
10098:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10099:         TRY
10100:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10101:                 "SigCdUni", "cursor_4c_BuscaUni", "cunis", ;
10102:                 ALLTRIM(loc_oPg.txt_4c_Cuni.Value), "Busca de Unidade")
10103:             loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
10104:             loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
10105:             loc_oBusca.Show()
10106:             IF loc_oBusca.this_lSelecionou
10107:                 IF USED("cursor_4c_BuscaUni")
10108:                     SELECT cursor_4c_BuscaUni
10109:                     loc_oPg.txt_4c_Cuni.Value          = ALLTRIM(cunis)
10110:                     loc_oPg.txt_4c_DuniDisplay.Value   = ALLTRIM(dunis)
10111:                     USE IN cursor_4c_BuscaUni
10112:                 ENDIF
10113:             ENDIF
10114:             loc_oBusca.Release()
10115:             loc_oBusca = .NULL.
10116:         CATCH TO loc_oErro
10117:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de unidade")
10118:         ENDTRY
10119:     ENDPROC
10120: 
10121:     *--------------------------------------------------------------------------
10122:     * AbrirLookupUniP - Abre busca de unidade de pedido (SigCdUni) para campo Cunip
10123:     *--------------------------------------------------------------------------
10124:     PROCEDURE AbrirLookupUniP()
10125:         LOCAL loc_oBusca, loc_oPg
10126:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10127:         TRY
10128:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10129:                 "SigCdUni", "cursor_4c_BuscaUniP", "cunis", ;
10130:                 ALLTRIM(loc_oPg.txt_4c_Cunip.Value), "Busca de Uni.Pedido")
10131:             loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
10132:             loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
10133:             loc_oBusca.Show()
10134:             IF loc_oBusca.this_lSelecionou
10135:                 IF USED("cursor_4c_BuscaUniP")
10136:                     SELECT cursor_4c_BuscaUniP
10137:                     loc_oPg.txt_4c_Cunip.Value          = ALLTRIM(cunis)
10138:                     loc_oPg.txt_4c_DunipDisplay.Value   = ALLTRIM(dunis)
10139:                     USE IN cursor_4c_BuscaUniP
10140:                 ENDIF
10141:             ENDIF
10142:             loc_oBusca.Release()
10143:             loc_oBusca = .NULL.
10144:         CATCH TO loc_oErro
10145:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de unidade de pedido")
10146:         ENDTRY
10147:     ENDPROC
10148: 
10149:     *--------------------------------------------------------------------------
10150:     * AbrirLookupMctotal - Abre busca de moeda custo (SigCdMoe)
10151:     *--------------------------------------------------------------------------
10152:     PROCEDURE AbrirLookupMctotal()
10153:         LOCAL loc_oBusca, loc_oPg
10154:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10155:         TRY
10156:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10157:                 "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
10158:                 ALLTRIM(loc_oPg.txt_4c_Mctotal.Value), "Busca de Moeda (Custo)")
10159:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
10160:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10161:             loc_oBusca.Show()
10162:             IF loc_oBusca.this_lSelecionou
10163:                 IF USED("cursor_4c_BuscaMoe")
10164:                     SELECT cursor_4c_BuscaMoe
10165:                     loc_oPg.txt_4c_Mctotal.Value = ALLTRIM(cmoes)
10166:                     THIS.CarregarDescMoe(ALLTRIM(cmoes), "total")
10167:                     USE IN cursor_4c_BuscaMoe
10168:                 ENDIF
10169:             ENDIF
10170:             loc_oBusca.Release()
10171:             loc_oBusca = .NULL.
10172:         CATCH TO loc_oErro
10173:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
10174:         ENDTRY
10175:     ENDPROC
10176: 
10177:     *--------------------------------------------------------------------------
10178:     * AbrirLookupMpvenda - Abre busca de moeda P.Venda (SigCdMoe)
10179:     *--------------------------------------------------------------------------
10180:     PROCEDURE AbrirLookupMpvenda()
10181:         LOCAL loc_oBusca, loc_oPg
10182:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10183:         TRY
10184:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10185:                 "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
10186:                 ALLTRIM(loc_oPg.txt_4c_Mpvenda.Value), "Busca de Moeda (P.Venda)")
10187:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
10188:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10189:             loc_oBusca.Show()
10190:             IF loc_oBusca.this_lSelecionou
10191:                 IF USED("cursor_4c_BuscaMoe")
10192:                     SELECT cursor_4c_BuscaMoe
10193:                     loc_oPg.txt_4c_Mpvenda.Value = ALLTRIM(cmoes)
10194:                     THIS.CarregarDescMoe(ALLTRIM(cmoes), "pvenda")
10195:                     USE IN cursor_4c_BuscaMoe
10196:                 ENDIF
10197:             ENDIF
10198:             loc_oBusca.Release()
10199:             loc_oBusca = .NULL.
10200:         CATCH TO loc_oErro
10201:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
10202:         ENDTRY
10203:     ENDPROC
10204: 
10205:     *--------------------------------------------------------------------------
10206:     * AbrirLookupMfvenda - Abre busca de moeda F.Venda (SigCdMoe)
10207:     *--------------------------------------------------------------------------
10208:     PROCEDURE AbrirLookupMfvenda()
10209:         LOCAL loc_oBusca, loc_oPg
10210:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10211:         TRY
10212:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10213:                 "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
10214:                 ALLTRIM(loc_oPg.txt_4c_Mfvenda.Value), "Busca de Moeda (F.Venda)")
10215:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
10216:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10217:             loc_oBusca.Show()
10218:             IF loc_oBusca.this_lSelecionou
10219:                 IF USED("cursor_4c_BuscaMoe")
10220:                     SELECT cursor_4c_BuscaMoe
10221:                     loc_oPg.txt_4c_Mfvenda.Value = ALLTRIM(cmoes)
10222:                     THIS.CarregarDescMoe(ALLTRIM(cmoes), "fvenda")
10223:                     USE IN cursor_4c_BuscaMoe
10224:                 ENDIF
10225:             ENDIF
10226:             loc_oBusca.Release()
10227:             loc_oBusca = .NULL.
10228:         CATCH TO loc_oErro
10229:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
10230:         ENDTRY
10231:     ENDPROC
10232: 
10233:     *==========================================================================
10234:     * HANDLERS - FASE 13: pgDadosFiscais
10235:     *==========================================================================
10236: 
10237:     *--------------------------------------------------------------------------
10238:     * TxtGruccusKeyPress - KeyPress em txt_4c_Gruccus (F4/F5 abre lookup SigCdGcr)
10239:     *--------------------------------------------------------------------------
10240:     PROCEDURE TxtGruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10241:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10242:             THIS.ValidarGruccus()
10243:         ENDIF
10244:         IF par_nKeyCode = 115
10245:             THIS.AbrirLookupGruccus()
10246:         ENDIF
10247:     ENDPROC
10248: 
10249:     *--------------------------------------------------------------------------
10250:     * ValidarGruccus - LostFocus/Enter em txt_4c_Gruccus
10251:     * Lookup: SigCdGcr (Codigos / Descrs)
10252:     *--------------------------------------------------------------------------
10253:     PROCEDURE ValidarGruccus()
10254:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10255:         loc_lResultado = .T.
10256:         TRY
10257:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10258:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Gruccus.Value, ""))
10259:             IF EMPTY(loc_cCodigo)
10260:                 loc_oPage.txt_4c_Dgruccus.Value    = ""
10261:                 loc_oPage.txt_4c_Contaccus.Value   = ""
10262:                 loc_oPage.txt_4c_Dcontaccus.Value  = ""
10263:                 loc_lResultado = loc_lResultado
10264:             ENDIF
10265:             loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10266:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGruccus") <= 0 OR EOF("cursor_4c_ValGruccus")
10267:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10268:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValGruccus"
10269:                 loc_oLookup.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10270:                 loc_oLookup.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10271:                 loc_oLookup.cTabela     = "SigCdGcr"
10272:                 loc_oLookup.cCampoChave = "Codigos"
10273:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10274:                 loc_oLookup.Show()
10275:                 IF loc_oLookup.this_lSelecionou
10276:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10277:                 ELSE
10278:                     loc_cCodigo = ""
10279:                 ENDIF
10280:             ELSE
10281:                 SELECT cursor_4c_ValGruccus
10282:                 loc_oPage.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10283:             ENDIF
10284:             IF USED("cursor_4c_ValGruccus")
10285:                 USE IN cursor_4c_ValGruccus
10286:             ENDIF
10287:             IF !EMPTY(loc_cCodigo)
10288:                 loc_oPage.txt_4c_Gruccus.Value = loc_cCodigo
10289:                 loc_oPage.txt_4c_Gruccus.Refresh()
10290:                 *-- Recarregar descricao se veio do lookup
10291:                 loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10292:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGruccus2") > 0 AND !EOF("cursor_4c_ValGruccus2")
10293:                     SELECT cursor_4c_ValGruccus2
10294:                     loc_oPage.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10295:                 ENDIF
10296:                 IF USED("cursor_4c_ValGruccus2")
10297:                     USE IN cursor_4c_ValGruccus2
10298:                 ENDIF
10299:             ELSE
10300:                 loc_oPage.txt_4c_Gruccus.Value    = ""
10301:                 loc_oPage.txt_4c_Dgruccus.Value   = ""
10302:                 loc_oPage.txt_4c_Contaccus.Value  = ""
10303:                 loc_oPage.txt_4c_Dcontaccus.Value = ""
10304:             ENDIF
10305:             loc_oPage.txt_4c_Dgruccus.Refresh()
10306:         CATCH TO loc_oErro
10307:             MsgErro(loc_oErro.Message, "Erro")
10308:         ENDTRY
10309:         RETURN loc_lResultado
10310:     ENDPROC
10311: 
10312:     *--------------------------------------------------------------------------
10313:     * AbrirLookupGruccus - Abre busca de grupo C.C. (SigCdGcr)
10314:     *--------------------------------------------------------------------------
10315:     PROCEDURE AbrirLookupGruccus()
10316:         LOCAL loc_oBusca, loc_oPg
10317:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10318:         TRY
10319:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10320:                 "SigCdGcr", "cursor_4c_BuscaGruccus", "Codigos", ;
10321:                 ALLTRIM(loc_oPg.txt_4c_Gruccus.Value), "Busca de Grupo C.C.")
10322:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10323:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10324:             loc_oBusca.Show()
10325:             IF loc_oBusca.this_lSelecionou
10326:                 IF USED("cursor_4c_BuscaGruccus")
10327:                     SELECT cursor_4c_BuscaGruccus
10328:                     loc_oPg.txt_4c_Gruccus.Value  = ALLTRIM(Codigos)
10329:                     loc_oPg.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10330:                     USE IN cursor_4c_BuscaGruccus
10331:                 ENDIF
10332:             ENDIF
10333:             loc_oBusca.Release()
10334:             loc_oBusca = .NULL.
10335:         CATCH TO loc_oErro
10336:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo C.C.")
10337:         ENDTRY
10338:     ENDPROC
10339: 
10340:     *--------------------------------------------------------------------------
10341:     * TxtDgruccusKeyPress - KeyPress em txt_4c_Dgruccus (F4 abre lookup por descricao)
10342:     *--------------------------------------------------------------------------
10343:     PROCEDURE TxtDgruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10344:         IF par_nKeyCode = 115
10345:             THIS.AbrirLookupDgruccus()
10346:         ENDIF
10347:     ENDPROC
10348: 
10349:     *--------------------------------------------------------------------------
10350:     * AbrirLookupDgruccus - Busca reversa por descricao em SigCdGcr
10351:     *--------------------------------------------------------------------------
10352:     PROCEDURE AbrirLookupDgruccus()
10353:         LOCAL loc_oBusca, loc_oPg
10354:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10355:         TRY
10356:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10357:                 "SigCdGcr", "cursor_4c_BuscaGruccus", "Descrs", ;
10358:                 ALLTRIM(loc_oPg.txt_4c_Dgruccus.Value), "Busca de Grupo C.C.")
10359:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10360:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10361:             loc_oBusca.Show()
10362:             IF loc_oBusca.this_lSelecionou
10363:                 IF USED("cursor_4c_BuscaGruccus")
10364:                     SELECT cursor_4c_BuscaGruccus
10365:                     loc_oPg.txt_4c_Gruccus.Value  = ALLTRIM(Codigos)
10366:                     loc_oPg.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10367:                     USE IN cursor_4c_BuscaGruccus
10368:                 ENDIF
10369:             ENDIF
10370:             loc_oBusca.Release()
10371:             loc_oBusca = .NULL.
10372:         CATCH TO loc_oErro
10373:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo C.C.")
10374:         ENDTRY
10375:     ENDPROC
10376: 
10377:     *--------------------------------------------------------------------------
10378:     * TxtContaccusKeyPress - KeyPress em txt_4c_Contaccus (F4 abre lookup SigCdCli)
10379:     *--------------------------------------------------------------------------
10380:     PROCEDURE TxtContaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10381:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10382:             THIS.ValidarContaccus()
10383:         ENDIF
10384:         IF par_nKeyCode = 115
10385:             THIS.AbrirLookupContaccus()
10386:         ENDIF
10387:     ENDPROC
10388: 
10389:     *--------------------------------------------------------------------------
10390:     * ValidarContaccus - LostFocus/Enter em txt_4c_Contaccus
10391:     * Lookup: SigCdCli filtrado por Grupos = gruccus (IClis / Rclis)
10392:     *--------------------------------------------------------------------------
10393:     PROCEDURE ValidarContaccus()
10394:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_cGrupo, loc_lcSQL
10395:         loc_lResultado = .T.
10396:         TRY
10397:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10398:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Contaccus.Value, ""))
10399:             loc_cGrupo  = ALLTRIM(NVL(loc_oPage.txt_4c_Gruccus.Value, ""))
10400:             IF EMPTY(loc_cCodigo)
10401:                 loc_oPage.txt_4c_Dcontaccus.Value = ""
10402:                 loc_lResultado = loc_lResultado
10403:             ENDIF
10404:             loc_lcSQL = "SELECT IClis, Rclis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cCodigo)
10405:             IF !EMPTY(loc_cGrupo)
10406:                 loc_lcSQL = loc_lcSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
10407:             ENDIF
10408:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValContaccus") <= 0 OR EOF("cursor_4c_ValContaccus")
10409:                 IF USED("cursor_4c_ValContaccus")
10410:                     USE IN cursor_4c_ValContaccus
10411:                 ENDIF
10412:                 THIS.AbrirLookupContaccus()
10413:                 loc_lResultado = loc_lResultado
10414:             ENDIF
10415:             SELECT cursor_4c_ValContaccus
10416:             loc_oPage.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
10417:             loc_oPage.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
10418:             loc_oPage.txt_4c_Contaccus.Refresh()
10419:             loc_oPage.txt_4c_Dcontaccus.Refresh()
10420:             IF USED("cursor_4c_ValContaccus")
10421:                 USE IN cursor_4c_ValContaccus
10422:             ENDIF
10423:         CATCH TO loc_oErro
10424:             MsgErro(loc_oErro.Message, "Erro")
10425:         ENDTRY
10426:         RETURN loc_lResultado
10427:     ENDPROC
10428: 
10429:     *--------------------------------------------------------------------------
10430:     * AbrirLookupContaccus - Abre busca de conta C.C. (SigCdCli filtrado por grupo)
10431:     *--------------------------------------------------------------------------
10432:     PROCEDURE AbrirLookupContaccus()
10433:         LOCAL loc_oBusca, loc_oPg, loc_cGrupo, loc_cTabela
10434:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10435:         loc_cGrupo = ALLTRIM(NVL(loc_oPg.txt_4c_Gruccus.Value, ""))
10436:         TRY
10437:             loc_cTabela = "SigCdCli"
10438:             IF !EMPTY(loc_cGrupo)
10439:                 loc_cTabela = "SigCdCli WHERE Grupos = " + EscaparSQL(loc_cGrupo)
10440:                 loc_cTabela = "(SELECT IClis, Rclis FROM SigCdCli WHERE Grupos = " + EscaparSQL(loc_cGrupo) + ") AS t"
10441:             ENDIF
10442:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10443:                 "SigCdCli", "cursor_4c_BuscaContaccus", "IClis", ;
10444:                 ALLTRIM(loc_oPg.txt_4c_Contaccus.Value), "Busca de Conta C.C.")
10445:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10446:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10447:             loc_oBusca.Show()
10448:             IF loc_oBusca.this_lSelecionou
10449:                 IF USED("cursor_4c_BuscaContaccus")
10450:                     SELECT cursor_4c_BuscaContaccus
10451:                     loc_oPg.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
10452:                     loc_oPg.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
10453:                     USE IN cursor_4c_BuscaContaccus
10454:                 ENDIF
10455:             ENDIF
10456:             loc_oBusca.Release()
10457:             loc_oBusca = .NULL.
10458:         CATCH TO loc_oErro
10459:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de conta C.C.")
10460:         ENDTRY
10461:     ENDPROC
10462: 
10463:     *--------------------------------------------------------------------------
10464:     * TxtDcontaccusKeyPress - KeyPress em txt_4c_Dcontaccus (F4 abre lookup por nome)
10465:     *--------------------------------------------------------------------------
10466:     PROCEDURE TxtDcontaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10467:         IF par_nKeyCode = 115
10468:             THIS.AbrirLookupDcontaccus()
10469:         ENDIF
10470:     ENDPROC
10471: 
10472:     *--------------------------------------------------------------------------
10473:     * AbrirLookupDcontaccus - Busca reversa por nome em SigCdCli
10474:     *--------------------------------------------------------------------------
10475:     PROCEDURE AbrirLookupDcontaccus()
10476:         LOCAL loc_oBusca, loc_oPg
10477:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10478:         TRY
10479:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10480:                 "SigCdCli", "cursor_4c_BuscaContaccus", "Rclis", ;
10481:                 ALLTRIM(loc_oPg.txt_4c_Dcontaccus.Value), "Busca de Conta C.C.")
10482:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10483:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10484:             loc_oBusca.Show()
10485:             IF loc_oBusca.this_lSelecionou
10486:                 IF USED("cursor_4c_BuscaContaccus")
10487:                     SELECT cursor_4c_BuscaContaccus
10488:                     loc_oPg.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
10489:                     loc_oPg.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
10490:                     USE IN cursor_4c_BuscaContaccus
10491:                 ENDIF
10492:             ENDIF
10493:             loc_oBusca.Release()
10494:             loc_oBusca = .NULL.
10495:         CATCH TO loc_oErro
10496:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de conta C.C.")
10497:         ENDTRY
10498:     ENDPROC
10499: 
10500:     *--------------------------------------------------------------------------
10501:     * TxtClfiscalKeyPress - KeyPress em txt_4c_Clfiscal (F4 abre lookup SigCdClf)
10502:     *--------------------------------------------------------------------------
10503:     PROCEDURE TxtClfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10504:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10505:             THIS.ValidarClfiscal()
10506:         ENDIF
10507:         IF par_nKeyCode = 115
10508:             THIS.AbrirLookupClfiscal()
10509:         ENDIF
10510:     ENDPROC
10511: 
10512:     *--------------------------------------------------------------------------
10513:     * ValidarClfiscal - LostFocus/Enter em txt_4c_Clfiscal
10514:     * Lookup: SigCdClf (Codigos / Descricaos)
10515:     *--------------------------------------------------------------------------
10516:     PROCEDURE ValidarClfiscal()
10517:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10518:         loc_lResultado = .T.
10519:         TRY
10520:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10521:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Clfiscal.Value, ""))
10522:             IF EMPTY(loc_cCodigo)
10523:                 loc_oPage.txt_4c_Dclfiscal.Value = ""
10524:                 loc_lResultado = loc_lResultado
10525:             ENDIF
10526:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10527:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValClf") <= 0 OR EOF("cursor_4c_ValClf")
10528:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10529:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValClf"
10530:                 loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10531:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10532:                 loc_oLookup.cTabela     = "SigCdClf"
10533:                 loc_oLookup.cCampoChave = "Codigos"
10534:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10535:                 loc_oLookup.Show()
10536:                 IF loc_oLookup.this_lSelecionou
10537:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10538:                 ELSE
10539:                     loc_cCodigo = ""
10540:                 ENDIF
10541:             ELSE
10542:                 SELECT cursor_4c_ValClf
10543:                 loc_oPage.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10544:             ENDIF
10545:             IF USED("cursor_4c_ValClf")
10546:                 USE IN cursor_4c_ValClf
10547:             ENDIF
10548:             loc_oPage.txt_4c_Clfiscal.Value = loc_cCodigo
10549:             IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dclfiscal.Value)
10550:                 *-- Recarregar descricao apos lookup
10551:                 loc_lcSQL = "SELECT Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10552:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValClf2") > 0 AND !EOF("cursor_4c_ValClf2")
10553:                     SELECT cursor_4c_ValClf2
10554:                     loc_oPage.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10555:                 ENDIF
10556:                 IF USED("cursor_4c_ValClf2")
10557:                     USE IN cursor_4c_ValClf2
10558:                 ENDIF
10559:             ENDIF
10560:             loc_oPage.txt_4c_Clfiscal.Refresh()
10561:             loc_oPage.txt_4c_Dclfiscal.Refresh()
10562:         CATCH TO loc_oErro
10563:             MsgErro(loc_oErro.Message, "Erro")
10564:         ENDTRY
10565:         RETURN loc_lResultado
10566:     ENDPROC
10567: 
10568:     *--------------------------------------------------------------------------
10569:     * AbrirLookupClfiscal - Abre busca de classificacao fiscal (SigCdClf)
10570:     *--------------------------------------------------------------------------
10571:     PROCEDURE AbrirLookupClfiscal()
10572:         LOCAL loc_oBusca, loc_oPg
10573:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10574:         TRY
10575:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10576:                 "SigCdClf", "cursor_4c_BuscaClf", "Codigos", ;
10577:                 ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value), "Busca de Classifica" + CHR(231) + CHR(227) + "o Fiscal")
10578:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10579:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10580:             loc_oBusca.Show()
10581:             IF loc_oBusca.this_lSelecionou
10582:                 IF USED("cursor_4c_BuscaClf")
10583:                     SELECT cursor_4c_BuscaClf
10584:                     loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(Codigos)
10585:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10586:                     USE IN cursor_4c_BuscaClf
10587:                 ENDIF
10588:             ENDIF
10589:             loc_oBusca.Release()
10590:             loc_oBusca = .NULL.
10591:         CATCH TO loc_oErro
10592:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o fiscal")
10593:         ENDTRY
10594:     ENDPROC
10595: 
10596:     *--------------------------------------------------------------------------
10597:     * TxtDclfiscalKeyPress - KeyPress em txt_4c_Dclfiscal (F4 busca reversa)
10598:     *--------------------------------------------------------------------------
10599:     PROCEDURE TxtDclfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10600:         IF par_nKeyCode = 115
10601:             THIS.AbrirLookupDclfiscal()
10602:         ENDIF
10603:     ENDPROC
10604: 
10605:     *--------------------------------------------------------------------------
10606:     * AbrirLookupDclfiscal - Busca reversa por descricao em SigCdClf
10607:     *--------------------------------------------------------------------------
10608:     PROCEDURE AbrirLookupDclfiscal()
10609:         LOCAL loc_oBusca, loc_oPg
10610:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10611:         TRY
10612:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10613:                 "SigCdClf", "cursor_4c_BuscaClf", "Descricaos", ;
10614:                 ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value), "Busca de Classifica" + CHR(231) + CHR(227) + "o Fiscal")
10615:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10616:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10617:             loc_oBusca.Show()
10618:             IF loc_oBusca.this_lSelecionou
10619:                 IF USED("cursor_4c_BuscaClf")
10620:                     SELECT cursor_4c_BuscaClf
10621:                     loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(Codigos)
10622:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10623:                     USE IN cursor_4c_BuscaClf
10624:                 ENDIF
10625:             ENDIF
10626:             loc_oBusca.Release()
10627:             loc_oBusca = .NULL.
10628:         CATCH TO loc_oErro
10629:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o fiscal")
10630:         ENDTRY
10631:     ENDPROC
10632: 
10633:     *--------------------------------------------------------------------------
10634:     * TxtOrigmercKeyPress - KeyPress em txt_4c_Origmerc (F4 abre lookup SigCdOrg)
10635:     *--------------------------------------------------------------------------
10636:     PROCEDURE TxtOrigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10637:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10638:             THIS.ValidarOrigmerc()
10639:         ENDIF
10640:         IF par_nKeyCode = 115
10641:             THIS.AbrirLookupOrigmerc()
10642:         ENDIF
10643:     ENDPROC
10644: 
10645:     *--------------------------------------------------------------------------
10646:     * ValidarOrigmerc - LostFocus/Enter em txt_4c_Origmerc
10647:     * Lookup: SigCdOrg (Codigos / Descricaos)
10648:     *--------------------------------------------------------------------------
10649:     PROCEDURE ValidarOrigmerc()
10650:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10651:         loc_lResultado = .T.
10652:         TRY
10653:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10654:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Origmerc.Value, ""))
10655:             IF EMPTY(loc_cCodigo)
10656:                 loc_oPage.txt_4c_Dorigmerc.Value = ""
10657:                 loc_lResultado = loc_lResultado
10658:             ENDIF
10659:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdOrg WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10660:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOrg") <= 0 OR EOF("cursor_4c_ValOrg")
10661:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10662:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValOrg"
10663:                 loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10664:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10665:                 loc_oLookup.cTabela     = "SigCdOrg"
10666:                 loc_oLookup.cCampoChave = "Codigos"
10667:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10668:                 loc_oLookup.Show()
10669:                 IF loc_oLookup.this_lSelecionou
10670:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10671:                 ELSE
10672:                     loc_cCodigo = ""
10673:                 ENDIF
10674:             ELSE
10675:                 SELECT cursor_4c_ValOrg
10676:                 loc_oPage.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10677:             ENDIF
10678:             IF USED("cursor_4c_ValOrg")
10679:                 USE IN cursor_4c_ValOrg
10680:             ENDIF
10681:             loc_oPage.txt_4c_Origmerc.Value = loc_cCodigo
10682:             IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dorigmerc.Value)
10683:                 loc_lcSQL = "SELECT Descricaos FROM SigCdOrg WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10684:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOrg2") > 0 AND !EOF("cursor_4c_ValOrg2")
10685:                     SELECT cursor_4c_ValOrg2
10686:                     loc_oPage.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10687:                 ENDIF
10688:                 IF USED("cursor_4c_ValOrg2")
10689:                     USE IN cursor_4c_ValOrg2
10690:                 ENDIF
10691:             ENDIF
10692:             loc_oPage.txt_4c_Origmerc.Refresh()
10693:             loc_oPage.txt_4c_Dorigmerc.Refresh()
10694:         CATCH TO loc_oErro
10695:             MsgErro(loc_oErro.Message, "Erro")
10696:         ENDTRY
10697:         RETURN loc_lResultado
10698:     ENDPROC
10699: 
10700:     *--------------------------------------------------------------------------
10701:     * AbrirLookupOrigmerc - Abre busca de origem da mercadoria (SigCdOrg)
10702:     *--------------------------------------------------------------------------
10703:     PROCEDURE AbrirLookupOrigmerc()
10704:         LOCAL loc_oBusca, loc_oPg
10705:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10706:         TRY
10707:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10708:                 "SigCdOrg", "cursor_4c_BuscaOrg", "Codigos", ;
10709:                 ALLTRIM(loc_oPg.txt_4c_Origmerc.Value), "Busca de Origem da Mercadoria")
10710:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10711:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10712:             loc_oBusca.Show()
10713:             IF loc_oBusca.this_lSelecionou
10714:                 IF USED("cursor_4c_BuscaOrg")
10715:                     SELECT cursor_4c_BuscaOrg
10716:                     loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(Codigos)
10717:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10718:                     USE IN cursor_4c_BuscaOrg
10719:                 ENDIF
10720:             ENDIF
10721:             loc_oBusca.Release()
10722:             loc_oBusca = .NULL.
10723:         CATCH TO loc_oErro
10724:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de origem da mercadoria")
10725:         ENDTRY
10726:     ENDPROC
10727: 
10728:     *--------------------------------------------------------------------------
10729:     * TxtDorigmercKeyPress - KeyPress em txt_4c_Dorigmerc (F4 busca reversa)
10730:     *--------------------------------------------------------------------------
10731:     PROCEDURE TxtDorigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10732:         IF par_nKeyCode = 115
10733:             THIS.AbrirLookupDorigmerc()
10734:         ENDIF
10735:     ENDPROC
10736: 
10737:     *--------------------------------------------------------------------------
10738:     * AbrirLookupDorigmerc - Busca reversa por descricao em SigCdOrg
10739:     *--------------------------------------------------------------------------
10740:     PROCEDURE AbrirLookupDorigmerc()
10741:         LOCAL loc_oBusca, loc_oPg
10742:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10743:         TRY
10744:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10745:                 "SigCdOrg", "cursor_4c_BuscaOrg", "Descricaos", ;
10746:                 ALLTRIM(loc_oPg.txt_4c_Dorigmerc.Value), "Busca de Origem da Mercadoria")
10747:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10748:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10749:             loc_oBusca.Show()
10750:             IF loc_oBusca.this_lSelecionou
10751:                 IF USED("cursor_4c_BuscaOrg")
10752:                     SELECT cursor_4c_BuscaOrg
10753:                     loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(Codigos)
10754:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10755:                     USE IN cursor_4c_BuscaOrg
10756:                 ENDIF
10757:             ENDIF
10758:             loc_oBusca.Release()
10759:             loc_oBusca = .NULL.
10760:         CATCH TO loc_oErro
10761:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de origem da mercadoria")
10762:         ENDTRY
10763:     ENDPROC
10764: 
10765:     *--------------------------------------------------------------------------
10766:     * TxtSittricmKeyPress - KeyPress em txt_4c_Sittricm (F4 abre lookup SigCdIcm)
10767:     *--------------------------------------------------------------------------
10768:     PROCEDURE TxtSittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10769:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10770:             THIS.ValidarSittricm()
10771:         ENDIF
10772:         IF par_nKeyCode = 115
10773:             THIS.AbrirLookupSittricm()
10774:         ENDIF
10775:     ENDPROC
10776: 
10777:     *--------------------------------------------------------------------------
10778:     * ValidarSittricm - LostFocus/Enter em txt_4c_Sittricm
10779:     * Lookup: SigCdIcm (Codigos / Descricaos)
10780:     *--------------------------------------------------------------------------
10781:     PROCEDURE ValidarSittricm()
10782:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10783:         loc_lResultado = .T.
10784:         TRY
10785:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10786:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Sittricm.Value, ""))
10787:             IF EMPTY(loc_cCodigo)
10788:                 loc_oPage.txt_4c_Dsittricm.Value = ""
10789:                 loc_lResultado = loc_lResultado
10790:             ENDIF
10791:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10792:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValIcm") <= 0 OR EOF("cursor_4c_ValIcm")
10793:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10794:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValIcm"
10795:                 loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10796:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10797:                 loc_oLookup.cTabela     = "SigCdIcm"
10798:                 loc_oLookup.cCampoChave = "Codigos"
10799:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10800:                 loc_oLookup.Show()
10801:                 IF loc_oLookup.this_lSelecionou
10802:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10803:                 ELSE
10804:                     loc_cCodigo = ""
10805:                 ENDIF
10806:             ELSE
10807:                 SELECT cursor_4c_ValIcm
10808:                 loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10809:             ENDIF
10810:             IF USED("cursor_4c_ValIcm")
10811:                 USE IN cursor_4c_ValIcm
10812:             ENDIF
10813:             loc_oPage.txt_4c_Sittricm.Value = loc_cCodigo
10814:             IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dsittricm.Value)
10815:                 loc_lcSQL = "SELECT Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10816:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValIcm2") > 0 AND !EOF("cursor_4c_ValIcm2")
10817:                     SELECT cursor_4c_ValIcm2
10818:                     loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10819:                 ENDIF
10820:                 IF USED("cursor_4c_ValIcm2")
10821:                     USE IN cursor_4c_ValIcm2
10822:                 ENDIF
10823:             ENDIF
10824:             loc_oPage.txt_4c_Sittricm.Refresh()
10825:             loc_oPage.txt_4c_Dsittricm.Refresh()
10826:         CATCH TO loc_oErro
10827:             MsgErro(loc_oErro.Message, "Erro")
10828:         ENDTRY
10829:         RETURN loc_lResultado
10830:     ENDPROC
10831: 
10832:     *--------------------------------------------------------------------------
10833:     * AbrirLookupSittricm - Abre busca situacao tributaria ICMS (SigCdIcm)
10834:     *--------------------------------------------------------------------------
10835:     PROCEDURE AbrirLookupSittricm()
10836:         LOCAL loc_oBusca, loc_oPg
10837:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10838:         TRY
10839:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10840:                 "SigCdIcm", "cursor_4c_BuscaIcm", "Codigos", ;
10841:                 ALLTRIM(loc_oPg.txt_4c_Sittricm.Value), "Busca de Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
10842:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10843:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10844:             loc_oBusca.Show()
10845:             IF loc_oBusca.this_lSelecionou
10846:                 IF USED("cursor_4c_BuscaIcm")
10847:                     SELECT cursor_4c_BuscaIcm
10848:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10849:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10850:                     USE IN cursor_4c_BuscaIcm
10851:                 ENDIF
10852:             ENDIF
10853:             loc_oBusca.Release()
10854:             loc_oBusca = .NULL.
10855:         CATCH TO loc_oErro
10856:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
10857:         ENDTRY
10858:     ENDPROC
10859: 
10860:     *--------------------------------------------------------------------------
10861:     * TxtDsittricmKeyPress - KeyPress em txt_4c_Dsittricm (F4 busca reversa)
10862:     *--------------------------------------------------------------------------
10863:     PROCEDURE TxtDsittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10864:         IF par_nKeyCode = 115
10865:             THIS.AbrirLookupDsittricm()
10866:         ENDIF
10867:     ENDPROC
10868: 
10869:     *--------------------------------------------------------------------------
10870:     * AbrirLookupDsittricm - Busca reversa por descricao em SigCdIcm
10871:     *--------------------------------------------------------------------------
10872:     PROCEDURE AbrirLookupDsittricm()
10873:         LOCAL loc_oBusca, loc_oPg
10874:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10875:         TRY
10876:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10877:                 "SigCdIcm", "cursor_4c_BuscaIcm", "Descricaos", ;
10878:                 ALLTRIM(loc_oPg.txt_4c_Dsittricm.Value), "Busca de Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
10879:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10880:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10881:             loc_oBusca.Show()
10882:             IF loc_oBusca.this_lSelecionou
10883:                 IF USED("cursor_4c_BuscaIcm")
10884:                     SELECT cursor_4c_BuscaIcm
10885:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10886:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10887:                     USE IN cursor_4c_BuscaIcm
10888:                 ENDIF
10889:             ENDIF
10890:             loc_oBusca.Release()
10891:             loc_oBusca = .NULL.
10892:         CATCH TO loc_oErro
10893:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
10894:         ENDTRY
10895:     ENDPROC
10896: 
10897:     *--------------------------------------------------------------------------
10898:     * TxtCodServsKeyPress - KeyPress em txt_4c_CodServs (F4 abre lookup SigCdIcm)
10899:     *--------------------------------------------------------------------------
10900:     PROCEDURE TxtCodServsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10901:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10902:             THIS.ValidarCodServs()
10903:         ENDIF
10904:         IF par_nKeyCode = 115
10905:             THIS.AbrirLookupCodServs()
10906:         ENDIF
10907:     ENDPROC
10908: 
10909:     *--------------------------------------------------------------------------
10910:     * ValidarCodServs - LostFocus/Enter em txt_4c_CodServs
10911:     * Lookup: SigCdIcm (Codigos) -> preenche txt_4c_Sittricm
10912:     *--------------------------------------------------------------------------
10913:     PROCEDURE ValidarCodServs()
10914:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10915:         loc_lResultado = .T.
10916:         TRY
10917:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10918:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_CodServs.Value, ""))
10919:             IF EMPTY(loc_cCodigo)
10920:                 loc_lResultado = loc_lResultado
10921:             ENDIF
10922:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10923:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCodServs") <= 0 OR EOF("cursor_4c_ValCodServs")
10924:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10925:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValServs"
10926:                 loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10927:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10928:                 loc_oLookup.cTabela     = "SigCdIcm"
10929:                 loc_oLookup.cCampoChave = "Codigos"
10930:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10931:                 loc_oLookup.Show()
10932:                 IF loc_oLookup.this_lSelecionou
10933:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10934:                 ELSE
10935:                     loc_cCodigo = ""
10936:                 ENDIF
10937:             ELSE
10938:                 *-- Get_CodServs preenche txt_4c_Sittricm (conforme original)
10939:                 SELECT cursor_4c_ValCodServs
10940:                 loc_oPage.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10941:                 loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10942:                 loc_oPage.txt_4c_Sittricm.Refresh()
10943:                 loc_oPage.txt_4c_Dsittricm.Refresh()
10944:             ENDIF
10945:             IF USED("cursor_4c_ValCodServs")
10946:                 USE IN cursor_4c_ValCodServs
10947:             ENDIF
10948:             loc_oPage.txt_4c_CodServs.Value = loc_cCodigo
10949:             loc_oPage.txt_4c_CodServs.Refresh()
10950:         CATCH TO loc_oErro
10951:             MsgErro(loc_oErro.Message, "Erro")
10952:         ENDTRY
10953:         RETURN loc_lResultado
10954:     ENDPROC
10955: 
10956:     *--------------------------------------------------------------------------
10957:     * AbrirLookupCodServs - Abre busca codigo servicos ICMS (SigCdIcm)
10958:     *--------------------------------------------------------------------------
10959:     PROCEDURE AbrirLookupCodServs()
10960:         LOCAL loc_oBusca, loc_oPg
10961:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10962:         TRY
10963:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10964:                 "SigCdIcm", "cursor_4c_BuscaIcm", "Codigos", ;
10965:                 ALLTRIM(loc_oPg.txt_4c_CodServs.Value), "Busca de C" + CHR(243) + "digo de Servi" + CHR(231) + "os")
10966:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10967:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10968:             loc_oBusca.Show()
10969:             IF loc_oBusca.this_lSelecionou
10970:                 IF USED("cursor_4c_BuscaIcm")
10971:                     SELECT cursor_4c_BuscaIcm
10972:                     loc_oPg.txt_4c_CodServs.Value  = ALLTRIM(Codigos)
10973:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10974:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10975:                     USE IN cursor_4c_BuscaIcm
10976:                 ENDIF
10977:             ENDIF
10978:             loc_oBusca.Release()
10979:             loc_oBusca = .NULL.
10980:         CATCH TO loc_oErro
10981:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de c" + CHR(243) + "digo de servi" + CHR(231) + "os")
10982:         ENDTRY
10983:     ENDPROC
10984: 
10985:     *--------------------------------------------------------------------------
10986:     * TxtTpTribKeyPress - KeyPress em txt_4c_TpTrib (F4 abre lookup SigPrTri)
10987:     *--------------------------------------------------------------------------
10988:     PROCEDURE TxtTpTribKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10989:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10990:             THIS.ValidarTpTrib()
10991:         ENDIF
10992:         IF par_nKeyCode = 115
10993:             THIS.AbrirLookupTpTrib()
10994:         ENDIF
10995:     ENDPROC
10996: 
10997:     *--------------------------------------------------------------------------
10998:     * ValidarTpTrib - LostFocus/Enter em txt_4c_TpTrib
10999:     * Lookup: SigPrTri (Tipos / Descs)
11000:     *--------------------------------------------------------------------------
11001:     PROCEDURE ValidarTpTrib()
11002:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
11003:         loc_lResultado = .T.
11004:         TRY
11005:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11006:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_TpTrib.Value, ""))
11007:             IF EMPTY(loc_cCodigo)
11008:                 loc_lResultado = loc_lResultado
11009:             ENDIF
11010:             loc_lcSQL = "SELECT Tipos FROM SigPrTri WHERE Tipos = " + EscaparSQL(loc_cCodigo)
11011:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTrib") <= 0 OR EOF("cursor_4c_ValTrib")
11012:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
11013:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValTrib"
11014:                 loc_oLookup.mAddColuna("Tipos", "", "Tipo")
11015:                 loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11016:                 loc_oLookup.cTabela     = "SigPrTri"
11017:                 loc_oLookup.cCampoChave = "Tipos"
11018:                 loc_oLookup.cFiltroIni  = loc_cCodigo
11019:                 loc_oLookup.Show()
11020:                 IF loc_oLookup.this_lSelecionou
11021:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
11022:                 ELSE
11023:                     loc_cCodigo = ""
11024:                 ENDIF
11025:             ENDIF
11026:             IF USED("cursor_4c_ValTrib")
11027:                 USE IN cursor_4c_ValTrib
11028:             ENDIF
11029:             loc_oPage.txt_4c_TpTrib.Value = loc_cCodigo
11030:             loc_oPage.txt_4c_TpTrib.Refresh()
11031:         CATCH TO loc_oErro
11032:             MsgErro(loc_oErro.Message, "Erro")
11033:         ENDTRY
11034:         RETURN loc_lResultado
11035:     ENDPROC
11036: 
11037:     *--------------------------------------------------------------------------
11038:     * AbrirLookupTpTrib - Abre busca de tipo de tributacao (SigPrTri)
11039:     *--------------------------------------------------------------------------
11040:     PROCEDURE AbrirLookupTpTrib()
11041:         LOCAL loc_oBusca, loc_oPg
11042:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11043:         TRY
11044:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11045:                 "SigPrTri", "cursor_4c_BuscaTrib", "Tipos", ;
11046:                 ALLTRIM(loc_oPg.txt_4c_TpTrib.Value), "Busca de Tipo de Tributa" + CHR(231) + CHR(227) + "o")
11047:             loc_oBusca.mAddColuna("Tipos", "", "Tipo")
11048:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11049:             loc_oBusca.Show()
11050:             IF loc_oBusca.this_lSelecionou
11051:                 IF USED("cursor_4c_BuscaTrib")
11052:                     SELECT cursor_4c_BuscaTrib
11053:                     loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(Tipos)
11054:                     USE IN cursor_4c_BuscaTrib
11055:                 ENDIF
11056:             ENDIF
11057:             loc_oBusca.Release()
11058:             loc_oBusca = .NULL.
11059:         CATCH TO loc_oErro
11060:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de tipo de tributa" + CHR(231) + CHR(227) + "o")
11061:         ENDTRY
11062:     ENDPROC
11063: 
11064:     *--------------------------------------------------------------------------
11065:     * ValidarIat - LostFocus em txt_4c_Iat
11066:     * Valida: deve ser 'A' (Arredondamento) ou 'T' (Truncamento) ou vazio
11067:     *--------------------------------------------------------------------------
11068:     PROCEDURE ValidarIat()
11069:         LOCAL loc_oPage, loc_cValor
11070:         TRY
11071:             loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11072:             loc_cValor = UPPER(ALLTRIM(NVL(loc_oPage.txt_4c_Iat.Value, "")))
11073:             IF EMPTY(loc_cValor)
11074:                 RETURN
11075:             ENDIF
11076:             IF !INLIST(loc_cValor, "A", "T")
11077:                 MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
11078:                     "Digite [A] Indicador de Arredondamento ou [T] Indicador de Truncamento!")
11079:                 loc_oPage.txt_4c_Iat.Value = ""
11080:                 loc_oPage.txt_4c_Iat.Refresh()
11081:             ELSE
11082:                 loc_oPage.txt_4c_Iat.Value = loc_cValor
11083:             ENDIF
11084:         CATCH TO loc_oErro
11085:             MsgErro(loc_oErro.Message, "Erro")
11086:         ENDTRY
11087:     ENDPROC
11088: 
11089:     *--------------------------------------------------------------------------
11090:     * ValidarAliqIPI - LostFocus em txt_4c_AliqIPI
11091:     * Verifica se aliquota informada eh identica a da classificacao fiscal
11092:     *--------------------------------------------------------------------------
11093:     PROCEDURE ValidarAliqIPI()
11094:         LOCAL loc_oPage, loc_nAliq, loc_nAliqClf, loc_lcSQL
11095:         TRY
11096:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11097:             loc_nAliq   = loc_oPage.txt_4c_AliqIPI.Value
11098:             IF EMPTY(ALLTRIM(NVL(loc_oPage.txt_4c_Clfiscal.Value, ""))) OR loc_nAliq = 0
11099:                 RETURN
11100:             ENDIF
11101:             loc_lcSQL = "SELECT aIpis FROM SigCdClf WHERE Codigos = " + EscaparSQL(ALLTRIM(loc_oPage.txt_4c_Clfiscal.Value))
11102:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAliqIPI") > 0 AND !EOF("cursor_4c_ValAliqIPI")
11103:                 SELECT cursor_4c_ValAliqIPI
11104:                 loc_nAliqClf = aIpis
11105:                 IF loc_nAliq = loc_nAliqClf
11106:                     MsgAviso("Al" + CHR(237) + "quota de IPI informada no produto id" + CHR(234) + "ntica " + ;
11107:                         CHR(224) + " classifica" + CHR(231) + CHR(227) + "o fiscal, " + ;
11108:                         "deixe zero e ser" + CHR(225) + " utilizada a classifica" + CHR(231) + CHR(227) + "o fiscal!")
11109:                 ENDIF
11110:             ENDIF
11111:             IF USED("cursor_4c_ValAliqIPI")
11112:                 USE IN cursor_4c_ValAliqIPI
11113:             ENDIF
11114:         CATCH TO loc_oErro
11115:             MsgErro(loc_oErro.Message, "Erro")
11116:         ENDTRY
11117:     ENDPROC
11118: 
11119:     *--------------------------------------------------------------------------
11120:     * TxtMvalorKeyPress - KeyPress em txt_4c_Mvalor (F4 abre lookup SigCdMoe)
11121:     *--------------------------------------------------------------------------
11122:     PROCEDURE TxtMvalorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11123:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
11124:             THIS.ValidarMvalor()
11125:         ENDIF
11126:         IF par_nKeyCode = 115
11127:             THIS.AbrirLookupMvalor()
11128:         ENDIF
11129:     ENDPROC
11130: 
11131:     *--------------------------------------------------------------------------
11132:     * ValidarMvalor - LostFocus/Enter em txt_4c_Mvalor
11133:     * Lookup: SigCdMoe (CMoes / DMoes)
11134:     *--------------------------------------------------------------------------
11135:     PROCEDURE ValidarMvalor()
11136:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
11137:         loc_lResultado = .T.
11138:         TRY
11139:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11140:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Mvalor.Value, ""))
11141:             IF EMPTY(loc_cCodigo)
11142:                 loc_lResultado = loc_lResultado
11143:             ENDIF
11144:             loc_lcSQL = "SELECT cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCodigo)
11145:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValMvalor") <= 0 OR EOF("cursor_4c_ValMvalor")
11146:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
11147:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValMoe"
11148:                 loc_oLookup.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
11149:                 loc_oLookup.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11150:                 loc_oLookup.cTabela     = "SigCdMoe"
11151:                 loc_oLookup.cCampoChave = "cmoes"
11152:                 loc_oLookup.cFiltroIni  = loc_cCodigo
11153:                 loc_oLookup.Show()
11154:                 IF loc_oLookup.this_lSelecionou
11155:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
11156:                 ELSE
11157:                     loc_cCodigo = ""
11158:                 ENDIF
11159:             ENDIF
11160:             IF USED("cursor_4c_ValMvalor")
11161:                 USE IN cursor_4c_ValMvalor
11162:             ENDIF
11163:             loc_oPage.txt_4c_Mvalor.Value = loc_cCodigo
11164:             loc_oPage.txt_4c_Mvalor.Refresh()
11165:         CATCH TO loc_oErro
11166:             MsgErro(loc_oErro.Message, "Erro")
11167:         ENDTRY
11168:         RETURN loc_lResultado
11169:     ENDPROC
11170: 
11171:     *--------------------------------------------------------------------------
11172:     * AbrirLookupMvalor - Abre busca de moeda do valor estimado (SigCdMoe)
11173:     *--------------------------------------------------------------------------
11174:     PROCEDURE AbrirLookupMvalor()
11175:         LOCAL loc_oBusca, loc_oPg
11176:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11177:         TRY
11178:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11179:                 "SigCdMoe", "cursor_4c_BuscaMvalor", "cmoes", ;
11180:                 ALLTRIM(loc_oPg.txt_4c_Mvalor.Value), "Busca de Moeda")
11181:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
11182:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11183:             loc_oBusca.Show()
11184:             IF loc_oBusca.this_lSelecionou
11185:                 IF USED("cursor_4c_BuscaMvalor")
11186:                     SELECT cursor_4c_BuscaMvalor
11187:                     loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(cmoes)
11188:                     USE IN cursor_4c_BuscaMvalor
11189:                 ENDIF
11190:             ENDIF
11191:             loc_oBusca.Release()
11192:             loc_oBusca = .NULL.
11193:         CATCH TO loc_oErro
11194:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
11195:         ENDTRY
11196:     ENDPROC
11197: 
11198:     *--------------------------------------------------------------------------
11199:     * TxtMetalKeyPress - KeyPress em txt_4c_Metal (F4 abre lookup metal)
11200:     *--------------------------------------------------------------------------
11201:     PROCEDURE TxtMetalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11202:         IF par_nKeyCode = 115
11203:             THIS.AbrirLookupMetal()
11204:         ENDIF
11205:     ENDPROC
11206: 
11207:     *--------------------------------------------------------------------------
11208:     * AbrirLookupMetal - Abre busca de metal (TmpMTal - cursor pre-carregado)
11209:     * Nota: TmpMTal deve ser carregado pelo form durante init com dados da tabela de metais
11210:     *--------------------------------------------------------------------------
11211:     PROCEDURE AbrirLookupMetal()
11212:         LOCAL loc_oBusca, loc_oPg
11213:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11214:         TRY
11215:             IF USED("TmpMTal")
11216:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11217:                     "TmpMTal", "cursor_4c_BuscaMetal", "Codigos", ;
11218:                     ALLTRIM(loc_oPg.txt_4c_Metal.Value), "Busca de Metal")
11219:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
11220:                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11221:                 loc_oBusca.Show()
11222:                 IF loc_oBusca.this_lSelecionou
11223:                     IF USED("cursor_4c_BuscaMetal")
11224:                         SELECT cursor_4c_BuscaMetal
11225:                         loc_oPg.txt_4c_Metal.Value   = ALLTRIM(Codigos)
11226:                         loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(Descs)
11227:                         USE IN cursor_4c_BuscaMetal
11228:                     ENDIF
11229:                 ENDIF
11230:                 loc_oBusca.Release()
11231:                 loc_oBusca = .NULL.
11232:             ENDIF
11233:         CATCH TO loc_oErro
11234:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de metal")
11235:         ENDTRY
11236:     ENDPROC
11237: 
11238:     *--------------------------------------------------------------------------
11239:     * TxtTeorKeyPress - KeyPress em txt_4c_Teor (F4 abre lookup teor)
11240:     *--------------------------------------------------------------------------
11241:     PROCEDURE TxtTeorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11242:         IF par_nKeyCode = 115
11243:             THIS.AbrirLookupTeor()
11244:         ENDIF
11245:     ENDPROC
11246: 
11247:     *--------------------------------------------------------------------------
11248:     * AbrirLookupTeor - Abre busca de teor (TmpTeor - cursor pre-carregado)
11249:     * Nota: TmpTeor deve ser carregado pelo form durante init com dados da tabela de teores
11250:     *--------------------------------------------------------------------------
11251:     PROCEDURE AbrirLookupTeor()
11252:         LOCAL loc_oBusca, loc_oPg
11253:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11254:         TRY
11255:             IF USED("TmpTeor")
11256:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11257:                     "TmpTeor", "cursor_4c_BuscaTeor", "Codigos", ;
11258:                     ALLTRIM(loc_oPg.txt_4c_Teor.Value), "Busca de Teor")
11259:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
11260:                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11261:                 loc_oBusca.Show()
11262:                 IF loc_oBusca.this_lSelecionou
11263:                     IF USED("cursor_4c_BuscaTeor")
11264:                         SELECT cursor_4c_BuscaTeor
11265:                         loc_oPg.txt_4c_Teor.Value   = ALLTRIM(Codigos)
11266:                         loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(Descs)
11267:                         USE IN cursor_4c_BuscaTeor
11268:                     ENDIF
11269:                 ENDIF
11270:                 loc_oBusca.Release()
11271:                 loc_oBusca = .NULL.
11272:             ENDIF
11273:         CATCH TO loc_oErro
11274:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de teor")
11275:         ENDTRY
11276:     ENDPROC
11277: 
11278:     *--------------------------------------------------------------------------
11279:     * CmdBtnDescFisClick - Click em cmd_4c_BtnDescFis
11280:     * Gera descricao fiscal a partir da composicao do produto (campo DescFis em SigCdPro)
11281:     *--------------------------------------------------------------------------
11282:     PROCEDURE CmdBtnDescFisClick()
11283:         LOCAL loc_oPage, loc_cCpros, loc_lcSQL, loc_cDescFis
11284:         TRY
11285:             loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11286:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11287:             IF EMPTY(loc_cCpros)
11288:                 MsgAviso("Salve o produto antes de gerar a descri" + CHR(231) + CHR(227) + "o fiscal.")
11289:                 RETURN
11290:             ENDIF
11291:             *-- Gerar descricao fiscal baseada na composicao do produto (simplificado)
11292:             loc_lcSQL = "SELECT TOP 1 dpros + ' ' + ISNULL(dpro2s,'') AS descFis " + ;
11293:                 "FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
11294:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_DescFis") > 0 AND !EOF("cursor_4c_DescFis")
11295:                 SELECT cursor_4c_DescFis
11296:                 loc_cDescFis = ALLTRIM(descFis)
11297:                 IF !EMPTY(loc_cDescFis)
11298:                     loc_oPage.obj_4c_Mgetdescfi.Value = loc_cDescFis
11299:                     loc_oPage.obj_4c_Mgetdescfi.Refresh()
11300:                     *-- Persistir no banco
11301:                     loc_lcSQL = "UPDATE SigCdPro SET DescFis = " + EscaparSQL(loc_cDescFis) + ;
11302:                         " WHERE cpros = " + EscaparSQL(loc_cCpros)
11303:                     SQLEXEC(gnConnHandle, loc_lcSQL)
11304:                 ELSE
11305:                     MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + CHR(231) + CHR(227) + "o fiscal!")
11306:                 ENDIF
11307:             ELSE
11308:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + CHR(231) + CHR(227) + "o fiscal!")
11309:             ENDIF
11310:             IF USED("cursor_4c_DescFis")
11311:                 USE IN cursor_4c_DescFis
11312:             ENDIF
11313:         CATCH TO loc_oErro
11314:             MsgErro(loc_oErro.Message, "Erro ao gerar descri" + CHR(231) + CHR(227) + "o fiscal")
11315:         ENDTRY
11316:     ENDPROC
11317: 
11318:     *--------------------------------------------------------------------------
11319:     * AtualizarSigCdPro - Salva campos editaveis de SigCdPro apos salvar SigPrFtp
11320:     * Chamado por BtnSalvarClick() apos this_oBusinessObject.Salvar() com sucesso
11321:     *--------------------------------------------------------------------------
11322:     PROTECTED PROCEDURE AtualizarSigCdPro()
11323:         LOCAL loc_oPg, loc_cCpros, loc_cSQL, loc_lFabrProprs, loc_lConsig, loc_lEncoms
11324:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
11325:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11326: 
11327:         IF EMPTY(loc_cCpros)
11328:             RETURN
11329:         ENDIF
11330: 
11331:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11332:             RETURN
11333:         ENDIF
11334: 
11335:         *-- Converter CheckBox.Value (logico) para 0/1
11336:         loc_lFabrProprs = IIF(loc_oPg.chk_4c_FabrProprs.Value, 1, 0)
11337:         loc_lConsig     = IIF(loc_oPg.chk_4c_Consig.Value,     1, 0)
11338:         loc_lEncoms     = IIF(loc_oPg.chk_4c_Encoms.Value,     1, 0)
11339: 
11340:         *-- Coletar campos fiscais (Page3)
11341:         LOCAL loc_oPg3U, loc_cIpiVal
11342:         loc_oPg3U = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11343:         loc_cIpiVal = LEFT(UPPER(ALLTRIM(loc_oPg3U.cbo_4c_CmbIpi.Value)), 1)
11344: 
11345:         TRY
11346:             loc_cSQL = "UPDATE SigCdPro SET " + ;
11347:                 "dpro2s = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_DPro2s.Value))      + ", " + ;
11348:                 "cbars = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cbar.Value))        + ", " + ;
11349:                 "cgrus = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cgrus.Value))       + ", " + ;
11350:                 "linhas = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Lin.Value))         + ", " + ;
11351:                 "colecoes = "   + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Col.Value))         + ", " + ;
11352:                 "ifors = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Ifor.Value))        + ", " + ;
11353:                 "reffs = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Refs.Value))        + ", " + ;
11354:                 "codcors = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cor.Value))         + ", " + ;
11355:                 "codtams = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Tam.Value))         + ", " + ;
11356:                 "codfinp = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CodFinP.Value))     + ", " + ;
11357:                 "pesobs = "     + FormatarNumeroSQL(loc_oPg.txt_4c_PesoB.Value)         + ", " + ;
11358:                 "codacbs = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CodAcb.Value))      + ", " + ;
11359:                 "cclass = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Class.Value))       + ", " + ;
11360:                 "locals = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Local.Value))       + ", " + ;
11361:                 "cunis = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cuni.Value))        + ", " + ;
11362:                 "cunips = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cunip.Value))       + ", " + ;

*-- Linhas 11402 a 11467:
11402:     *--------------------------------------------------------------------------
11403:     * Destroy - Liberacao de recursos
11404:     *--------------------------------------------------------------------------
11405:     PROCEDURE Destroy()
11406:         LOCAL loc_aCursors(42), loc_nI
11407:         *-- Lista de todos os cursors possiveis deste form
11408:         loc_aCursors(1)  = "cursor_4c_Dados"
11409:         loc_aCursors(2)  = "cursor_4c_Busca"
11410:         loc_aCursors(3)  = "cursor_4c_ProdDados"
11411:         loc_aCursors(4)  = "cursor_4c_DescGru"
11412:         loc_aCursors(5)  = "cursor_4c_DescLin"
11413:         loc_aCursors(6)  = "cursor_4c_DescCol"
11414:         loc_aCursors(7)  = "cursor_4c_DescIfor"
11415:         loc_aCursors(8)  = "cursor_4c_ValPro"
11416:         loc_aCursors(9)  = "cursor_4c_ValGru"
11417:         loc_aCursors(10) = "cursor_4c_Registro"
11418:         *-- Fase 6: cursors adicionais
11419:         loc_aCursors(11) = "cursor_4c_DescCor"
11420:         loc_aCursors(12) = "cursor_4c_DescTam"
11421:         loc_aCursors(13) = "cursor_4c_DescFinP"
11422:         loc_aCursors(14) = "cursor_4c_DescAcb"
11423:         loc_aCursors(15) = "cursor_4c_DescClass"
11424:         loc_aCursors(16) = "cursor_4c_DescLocal"
11425:         loc_aCursors(17) = "cursor_4c_DescUni"
11426:         loc_aCursors(18) = "cursor_4c_DescMoe"
11427:         loc_aCursors(19) = "cursor_4c_BuscaCor"
11428:         loc_aCursors(20) = "cursor_4c_BuscaTam"
11429:         loc_aCursors(21) = "cursor_4c_BuscaFinP"
11430:         loc_aCursors(22) = "cursor_4c_BuscaAcb"
11431:         loc_aCursors(23) = "cursor_4c_BuscaClass"
11432:         loc_aCursors(24) = "cursor_4c_BuscaLocal"
11433:         loc_aCursors(25) = "cursor_4c_BuscaUni"
11434:         loc_aCursors(26) = "cursor_4c_BuscaUniP"
11435:         loc_aCursors(27) = "cursor_4c_BuscaMoe"
11436:         loc_aCursors(28) = "cursor_4c_BuscaGrupo"
11437:         loc_aCursors(29) = "cursor_4c_ValGru"
11438:         loc_aCursors(30) = "cursor_4c_DescGru"
11439:         *-- Fase 9: cursors de composicao
11440:         loc_aCursors(31) = "cursor_4c_Compo"
11441:         loc_aCursors(32) = "cursor_4c_SubCp"
11442:         loc_aCursors(33) = "cursor_4c_TotGrupo"
11443:         loc_aCursors(34) = "cursor_4c_BuscaMoeCompo"
11444:         loc_aCursors(35) = "cursor_4c_BuscaAuxMoe"
11445:         *-- Fase 10: cursors de custo
11446:         loc_aCursors(36) = "cursor_4c_CustoCompo"
11447:         loc_aCursors(37) = "cursor_4c_TotGrupoCusto"
11448:         *-- Fase 12: cursors de fases de processo e matrizes
11449:         loc_aCursors(38) = "cursor_4c_Fase"
11450:         loc_aCursors(39) = "cursor_4c_Matrizes"
11451:         *-- Fase 13: cursor dados fiscais
11452:         loc_aCursors(40) = "cursor_4c_Cmv"
11453:         *-- Fase 14: cursors designer
11454:         loc_aCursors(41) = "cursor_4c_Tarefas"
11455:         loc_aCursors(42) = "cursor_4c_Arquivos"
11456: 
11457:         FOR loc_nI = 1 TO 42
11458:             IF USED(loc_aCursors(loc_nI))
11459:                 USE IN (loc_aCursors(loc_nI))
11460:             ENDIF
11461:         ENDFOR
11462: 
11463:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
11464:             THIS.this_oBusinessObject = .NULL.
11465:         ENDIF
11466: 
11467:         DODEFAULT()


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

