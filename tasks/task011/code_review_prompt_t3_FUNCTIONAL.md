# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (136)
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (11484 linhas total):

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
3604:         CREATE CURSOR cursor_4c_Cmv ( ;
3605:             datas    C(7), ;
3606:             valcuss  N(10,2), ;
3607:             moedas   C(3))
3608:         SET NULL OFF
3609: 
3610:         *-- ===================================================================
3611:         *-- LABELS
3612:         *-- ===================================================================
3613: 
3614:         *-- Say16: Grupo C.C.
3615:         loc_oPg.AddObject("lbl_4c_Say16", "Label")
3616:         WITH loc_oPg.lbl_4c_Say16
3617:             .Caption  = "Grupo C.C. :"
3618:             .Top      = 165
3619:             .Left     = 138
3620:             .Width    = 63
3621:             .Height   = 15
3622:             .FontName = "Tahoma"
3623:             .FontSize = 8
3624:             .AutoSize = .F.
3625:             .Visible  = .T.
3626:         ENDWITH
3627: 
3628:         *-- Say17: Conta C.C.
3629:         loc_oPg.AddObject("lbl_4c_Say17", "Label")
3630:         WITH loc_oPg.lbl_4c_Say17
3631:             .Caption  = "Conta C.C. :"

*-- Linhas 3901 a 4202:
3901:             .InputMask = "!!!!!!!!!!"
3902:             .Visible   = .T.
3903:         ENDWITH
3904:         BINDEVENT(loc_oPg.txt_4c_Gruccus, "KeyPress", THIS, "TxtGruccusKeyPress")
3905:         BINDEVENT(loc_oPg.txt_4c_Gruccus, "DblClick", THIS, "AbrirLookupGruccus")
3906: 
3907:         *-- get_dgruccus (txt_4c_Dgruccus): Grupo C.C. descricao - T:161, L:288, W:318, H:23
3908:         loc_oPg.AddObject("txt_4c_Dgruccus", "TextBox")
3909:         WITH loc_oPg.txt_4c_Dgruccus
3910:             .Value    = ""
3911:             .Top      = 161
3912:             .Left     = 288
3913:             .Width    = 318
3914:             .Height   = 23
3915:             .FontName = "Tahoma"
3916:             .FontSize = 8
3917:             .Visible  = .T.
3918:         ENDWITH
3919:         BINDEVENT(loc_oPg.txt_4c_Dgruccus, "KeyPress", THIS, "TxtDgruccusKeyPress")
3920:         BINDEVENT(loc_oPg.txt_4c_Dgruccus, "DblClick", THIS, "AbrirLookupDgruccus")
3921: 
3922:         *-- get_contaccus (txt_4c_Contaccus): Conta C.C. codigo - T:186, L:206, W:80, H:23
3923:         loc_oPg.AddObject("txt_4c_Contaccus", "TextBox")
3924:         WITH loc_oPg.txt_4c_Contaccus
3925:             .Value     = ""
3926:             .Top       = 186
3927:             .Left      = 206
3928:             .Width     = 80
3929:             .Height    = 23
3930:             .FontName  = "Tahoma"
3931:             .FontSize  = 8
3932:             .InputMask = "!!!!!!!!!!"
3933:             .Visible   = .T.
3934:         ENDWITH
3935:         BINDEVENT(loc_oPg.txt_4c_Contaccus, "KeyPress", THIS, "TxtContaccusKeyPress")
3936:         BINDEVENT(loc_oPg.txt_4c_Contaccus, "DblClick", THIS, "AbrirLookupContaccus")
3937: 
3938:         *-- get_dcontaccus (txt_4c_Dcontaccus): Conta C.C. descricao - T:186, L:288, W:318, H:23
3939:         loc_oPg.AddObject("txt_4c_Dcontaccus", "TextBox")
3940:         WITH loc_oPg.txt_4c_Dcontaccus
3941:             .Value    = ""
3942:             .Top      = 186
3943:             .Left     = 288
3944:             .Width    = 318
3945:             .Height   = 23
3946:             .FontName = "Tahoma"
3947:             .FontSize = 8
3948:             .Visible  = .T.
3949:         ENDWITH
3950:         BINDEVENT(loc_oPg.txt_4c_Dcontaccus, "KeyPress", THIS, "TxtDcontaccusKeyPress")
3951:         BINDEVENT(loc_oPg.txt_4c_Dcontaccus, "DblClick", THIS, "AbrirLookupDcontaccus")
3952: 
3953:         *-- ===================================================================
3954:         *-- TEXTBOXES - Classificacao Fiscal (NCM)
3955:         *-- ===================================================================
3956: 
3957:         *-- getClfiscal (txt_4c_Clfiscal): NCM codigo - T:211, L:206, W:94, H:23
3958:         loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
3959:         WITH loc_oPg.txt_4c_Clfiscal
3960:             .Value     = ""
3961:             .Top       = 211
3962:             .Left      = 206
3963:             .Width     = 94
3964:             .Height    = 23
3965:             .FontName  = "Tahoma"
3966:             .FontSize  = 8
3967:             .InputMask = "9999.99.99"
3968:             .Visible   = .T.
3969:         ENDWITH
3970:         BINDEVENT(loc_oPg.txt_4c_Clfiscal, "KeyPress", THIS, "TxtClfiscalKeyPress")
3971:         BINDEVENT(loc_oPg.txt_4c_Clfiscal, "DblClick", THIS, "AbrirLookupClfiscal")
3972: 
3973:         *-- getDclfiscal (txt_4c_Dclfiscal): NCM descricao - T:211, L:303, W:303, H:23
3974:         loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
3975:         WITH loc_oPg.txt_4c_Dclfiscal
3976:             .Value    = ""
3977:             .Top      = 211
3978:             .Left     = 303
3979:             .Width    = 303
3980:             .Height   = 23
3981:             .FontName = "Tahoma"
3982:             .FontSize = 8
3983:             .Visible  = .T.
3984:         ENDWITH
3985:         BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "KeyPress", THIS, "TxtDclfiscalKeyPress")
3986:         BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "DblClick", THIS, "AbrirLookupDclfiscal")
3987: 
3988:         *-- ===================================================================
3989:         *-- TEXTBOXES - Origem da Mercadoria
3990:         *-- ===================================================================
3991: 
3992:         *-- getOrigmerc (txt_4c_Origmerc): Origem codigo - T:236, L:206, W:17, H:23
3993:         loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
3994:         WITH loc_oPg.txt_4c_Origmerc
3995:             .Value     = ""
3996:             .Top       = 236
3997:             .Left      = 206
3998:             .Width     = 17
3999:             .Height    = 23
4000:             .FontName  = "Tahoma"
4001:             .FontSize  = 8
4002:             .MaxLength = 1
4003:             .Visible   = .T.
4004:         ENDWITH
4005:         BINDEVENT(loc_oPg.txt_4c_Origmerc, "KeyPress", THIS, "TxtOrigmercKeyPress")
4006:         BINDEVENT(loc_oPg.txt_4c_Origmerc, "DblClick", THIS, "AbrirLookupOrigmerc")
4007: 
4008:         *-- getDorigmerc (txt_4c_Dorigmerc): Origem descricao - T:236, L:226, W:380, H:23
4009:         loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")
4010:         WITH loc_oPg.txt_4c_Dorigmerc
4011:             .Value    = ""
4012:             .Top      = 236
4013:             .Left     = 226
4014:             .Width    = 380
4015:             .Height   = 23
4016:             .FontName = "Tahoma"
4017:             .FontSize = 8
4018:             .Visible  = .T.
4019:         ENDWITH
4020:         BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "KeyPress", THIS, "TxtDorigmercKeyPress")
4021:         BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "DblClick", THIS, "AbrirLookupDorigmerc")
4022: 
4023:         *-- ===================================================================
4024:         *-- TEXTBOXES - Situacao Tributaria ICMS
4025:         *-- ===================================================================
4026: 
4027:         *-- getSittricm (txt_4c_Sittricm): ICMS codigo - T:261, L:206, W:31, H:23
4028:         loc_oPg.AddObject("txt_4c_Sittricm", "TextBox")
4029:         WITH loc_oPg.txt_4c_Sittricm
4030:             .Value     = ""
4031:             .Top       = 261
4032:             .Left      = 206
4033:             .Width     = 31
4034:             .Height    = 23
4035:             .FontName  = "Tahoma"
4036:             .FontSize  = 8
4037:             .InputMask = "!!!"
4038:             .Visible   = .T.
4039:         ENDWITH
4040:         BINDEVENT(loc_oPg.txt_4c_Sittricm, "KeyPress", THIS, "TxtSittricmKeyPress")
4041:         BINDEVENT(loc_oPg.txt_4c_Sittricm, "DblClick", THIS, "AbrirLookupSittricm")
4042: 
4043:         *-- getDsittricm (txt_4c_Dsittricm): ICMS descricao - T:261, L:240, W:366, H:23
4044:         loc_oPg.AddObject("txt_4c_Dsittricm", "TextBox")
4045:         WITH loc_oPg.txt_4c_Dsittricm
4046:             .Value    = ""
4047:             .Top      = 261
4048:             .Left     = 240
4049:             .Width    = 366
4050:             .Height   = 23
4051:             .FontName = "Tahoma"
4052:             .FontSize = 8
4053:             .Visible  = .T.
4054:         ENDWITH
4055:         BINDEVENT(loc_oPg.txt_4c_Dsittricm, "KeyPress", THIS, "TxtDsittricmKeyPress")
4056:         BINDEVENT(loc_oPg.txt_4c_Dsittricm, "DblClick", THIS, "AbrirLookupDsittricm")
4057: 
4058:         *-- ===================================================================
4059:         *-- TEXTBOXES - Linha de Servicos ICMS, Aliquotas, Tipo, IAT
4060:         *-- ===================================================================
4061: 
4062:         *-- Get_CodServs (txt_4c_CodServs): Codigo de Servicos - T:286, L:206, W:38, H:23
4063:         loc_oPg.AddObject("txt_4c_CodServs", "TextBox")
4064:         WITH loc_oPg.txt_4c_CodServs
4065:             .Value     = ""
4066:             .Top       = 286
4067:             .Left      = 206
4068:             .Width     = 38
4069:             .Height    = 23
4070:             .FontName  = "Tahoma"
4071:             .FontSize  = 8
4072:             .InputMask = "!!!"
4073:             .Visible   = .T.
4074:         ENDWITH
4075:         BINDEVENT(loc_oPg.txt_4c_CodServs, "KeyPress", THIS, "TxtCodServsKeyPress")
4076:         BINDEVENT(loc_oPg.txt_4c_CodServs, "DblClick", THIS, "AbrirLookupCodServs")
4077: 
4078:         *-- getIcms (txt_4c_Icms): Aliquota ICMS - T:286, L:342, W:45, H:23
4079:         loc_oPg.AddObject("txt_4c_Icms", "TextBox")
4080:         WITH loc_oPg.txt_4c_Icms
4081:             .Value     = 0
4082:             .Top       = 286
4083:             .Left      = 342
4084:             .Width     = 45
4085:             .Height    = 23
4086:             .FontName  = "Tahoma"
4087:             .FontSize  = 8
4088:             .InputMask = "999.99"
4089:             .Visible   = .T.
4090:         ENDWITH
4091: 
4092:         *-- Get_TpTrib (txt_4c_TpTrib): Tipo de Tributacao - T:286, L:513, W:38, H:23
4093:         loc_oPg.AddObject("txt_4c_TpTrib", "TextBox")
4094:         WITH loc_oPg.txt_4c_TpTrib
4095:             .Value     = ""
4096:             .Top       = 286
4097:             .Left      = 513
4098:             .Width     = 38
4099:             .Height    = 23
4100:             .FontName  = "Tahoma"
4101:             .FontSize  = 8
4102:             .InputMask = "!!!!"
4103:             .Visible   = .T.
4104:         ENDWITH
4105:         BINDEVENT(loc_oPg.txt_4c_TpTrib, "KeyPress", THIS, "TxtTpTribKeyPress")
4106:         BINDEVENT(loc_oPg.txt_4c_TpTrib, "DblClick", THIS, "AbrirLookupTpTrib")
4107: 
4108:         *-- getiat (txt_4c_Iat): IAT Arredondamento/Truncamento - T:286, L:589, W:17, H:23
4109:         loc_oPg.AddObject("txt_4c_Iat", "TextBox")
4110:         WITH loc_oPg.txt_4c_Iat
4111:             .Value     = ""
4112:             .Top       = 286
4113:             .Left      = 589
4114:             .Width     = 17
4115:             .Height    = 23
4116:             .FontName  = "Tahoma"
4117:             .FontSize  = 8
4118:             .MaxLength = 1
4119:             .InputMask = "!"
4120:             .Visible   = .T.
4121:         ENDWITH
4122:         BINDEVENT(loc_oPg.txt_4c_Iat, "LostFocus", THIS, "ValidarIat")
4123: 
4124:         *-- ===================================================================
4125:         *-- COMBOBOX - Situacao Tributaria IPI
4126:         *-- ===================================================================
4127: 
4128:         *-- cmbIpi (cbo_4c_CmbIpi): Sit. Trib. IPI - T:311, L:206, W:108, H:25
4129:         loc_oPg.AddObject("cbo_4c_CmbIpi", "ComboBox")
4130:         WITH loc_oPg.cbo_4c_CmbIpi
4131:             .Top      = 311
4132:             .Left     = 206
4133:             .Width    = 108
4134:             .Height   = 25
4135:             .FontName = "Tahoma"
4136:             .FontSize = 8
4137:             .Style    = 2
4138:             .Visible  = .T.
4139:         ENDWITH
4140:         loc_oPg.cbo_4c_CmbIpi.AddItem("")
4141:         loc_oPg.cbo_4c_CmbIpi.AddItem("Tributado")
4142:         loc_oPg.cbo_4c_CmbIpi.AddItem("Isento")
4143:         loc_oPg.cbo_4c_CmbIpi.AddItem("Outros")
4144: 
4145:         *-- ===================================================================
4146:         *-- TEXTBOXES - Aliquota IPI e Excecao TIPI
4147:         *-- ===================================================================
4148: 
4149:         *-- Get_AliqIPI (txt_4c_AliqIPI): Aliquota de IPI - T:311, L:425, W:45, H:25
4150:         loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
4151:         WITH loc_oPg.txt_4c_AliqIPI
4152:             .Value     = 0
4153:             .Top       = 311
4154:             .Left      = 425
4155:             .Width     = 45
4156:             .Height    = 25
4157:             .FontName  = "Tahoma"
4158:             .FontSize  = 8
4159:             .InputMask = "999.99"
4160:             .Visible   = .T.
4161:         ENDWITH
4162:         BINDEVENT(loc_oPg.txt_4c_AliqIPI, "LostFocus", THIS, "ValidarAliqIPI")
4163: 
4164:         *-- getextipi (txt_4c_Extipi): Excecao da TIPI - T:311, L:601, W:35, H:25
4165:         loc_oPg.AddObject("txt_4c_Extipi", "TextBox")
4166:         WITH loc_oPg.txt_4c_Extipi
4167:             .Value     = ""
4168:             .Top       = 311
4169:             .Left      = 601
4170:             .Width     = 35
4171:             .Height    = 25
4172:             .FontName  = "Tahoma"
4173:             .FontSize  = 8
4174:             .InputMask = "!!!!!"
4175:             .Visible   = .T.
4176:         ENDWITH
4177: 
4178:         *-- ===================================================================
4179:         *-- EDITBOX - Descricao Fiscal (memo)
4180:         *-- ===================================================================
4181: 
4182:         *-- mgetdescfi (obj_4c_Mgetdescfi): T:338, L:206, W:509, H:89
4183:         loc_oPg.AddObject("obj_4c_Mgetdescfi", "EditBox")
4184:         WITH loc_oPg.obj_4c_Mgetdescfi
4185:             .Value      = ""
4186:             .Top        = 338
4187:             .Left       = 206
4188:             .Width      = 509
4189:             .Height     = 89
4190:             .FontName   = "Tahoma"
4191:             .FontSize   = 8
4192:             .ScrollBars = 2
4193:             .Visible    = .T.
4194:         ENDWITH
4195: 
4196:         *-- ===================================================================
4197:         *-- COMMANDBUTTON - Gerar Descricao Fiscal
4198:         *-- ===================================================================
4199: 
4200:         *-- btnDescFis (cmd_4c_BtnDescFis): T:359, L:162, W:26, H:26
4201:         loc_oPg.AddObject("cmd_4c_BtnDescFis", "CommandButton")
4202:         WITH loc_oPg.cmd_4c_BtnDescFis

*-- Linhas 4210 a 4283:
4210:             .Themes   = .F.
4211:             .Visible  = .T.
4212:         ENDWITH
4213:         BINDEVENT(loc_oPg.cmd_4c_BtnDescFis, "Click", THIS, "CmdBtnDescFisClick")
4214: 
4215:         *-- ===================================================================
4216:         *-- GRID - Historico Valor do Grama Produzido (grdCmv)
4217:         *-- T:338, L:754, W:223, H:141, 3 colunas: Periodo / Valor Custo GR / Moe
4218:         *-- ===================================================================
4219: 
4220:         loc_oPg.AddObject("grd_4c_Dados", "Grid")
4221:         loc_oGrd = loc_oPg.grd_4c_Dados
4222:         WITH loc_oGrd
4223:             .Top         = 338
4224:             .Left        = 754
4225:             .Width       = 223
4226:             .Height      = 141
4227:             .FontName    = "Tahoma"
4228:             .FontSize    = 8
4229:             .RecordMark  = .F.
4230:             .DeleteMark  = .F.
4231:             .GridLines   = 3
4232:             .ReadOnly    = .T.
4233:             .RowHeight   = 16
4234:             .ScrollBars  = 2
4235:             .Themes      = .F.
4236:             .ColumnCount = 3
4237:             .Visible     = .T.
4238:         ENDWITH
4239: 
4240:         *-- Cabecalhos ANTES do RecordSource
4241:         loc_oGrd.Column1.Header1.Caption = "Per" + CHR(237) + "odo"
4242:         loc_oGrd.Column2.Header1.Caption = "Valor Custo GR"
4243:         loc_oGrd.Column3.Header1.Caption = "Moe"
4244: 
4245:         *-- Larguras das colunas
4246:         WITH loc_oGrd.Column1
4247:             .Width     = 60
4248:             .Movable   = .F.
4249:             .Resizable = .F.
4250:         ENDWITH
4251:         WITH loc_oGrd.Column2
4252:             .Width     = 120
4253:             .Movable   = .F.
4254:             .Resizable = .F.
4255:         ENDWITH
4256:         WITH loc_oGrd.Column3
4257:             .Width     = 40
4258:             .Movable   = .F.
4259:             .Resizable = .F.
4260:         ENDWITH
4261: 
4262:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
4263:         loc_oGrd.RecordSource = "cursor_4c_Cmv"
4264: 
4265:         *-- ControlSource APOS RecordSource (obrigatorio)
4266:         loc_oGrd.Column1.ControlSource = "cursor_4c_Cmv.datas"
4267:         loc_oGrd.Column2.ControlSource = "cursor_4c_Cmv.valcuss"
4268:         loc_oGrd.Column3.ControlSource = "cursor_4c_Cmv.moedas"
4269: 
4270:         *-- Reaplica larguras apos RecordSource (RecordSource pode resetar)
4271:         loc_oGrd.Column1.Width = 60
4272:         loc_oGrd.Column2.Width = 120
4273:         loc_oGrd.Column3.Width = 40
4274: 
4275:         *-- ===================================================================
4276:         *-- TEXTBOXES - Descricao ECF, Metal/Teor, Valor Estimado, IPPT/CST
4277:         *-- ===================================================================
4278: 
4279:         *-- getDescEcfs (txt_4c_DescEcfs): T:429, L:206, W:213, H:23
4280:         loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
4281:         WITH loc_oPg.txt_4c_DescEcfs
4282:             .Value    = ""
4283:             .Top      = 429

*-- Linhas 4302 a 4444:
4302:             .InputMask = "!!!!!!!!!!"
4303:             .Visible   = .T.
4304:         ENDWITH
4305:         BINDEVENT(loc_oPg.txt_4c_Metal, "KeyPress", THIS, "TxtMetalKeyPress")
4306:         BINDEVENT(loc_oPg.txt_4c_Metal, "DblClick", THIS, "AbrirLookupMetal")
4307: 
4308:         *-- Get_DesMetal (txt_4c_DesMetal): Metal descricao - T:429, L:564, W:150, H:23 (READ-ONLY)
4309:         loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
4310:         WITH loc_oPg.txt_4c_DesMetal
4311:             .Value    = ""
4312:             .Top      = 429
4313:             .Left     = 564
4314:             .Width    = 150
4315:             .Height   = 23
4316:             .FontName = "Tahoma"
4317:             .FontSize = 8
4318:             .ReadOnly = .T.
4319:             .Visible  = .T.
4320:         ENDWITH
4321: 
4322:         *-- getValor (txt_4c_Valor): Valor Estimado - T:454, L:206, W:108, H:23
4323:         loc_oPg.AddObject("txt_4c_Valor", "TextBox")
4324:         WITH loc_oPg.txt_4c_Valor
4325:             .Value     = 0
4326:             .Top       = 454
4327:             .Left      = 206
4328:             .Width     = 108
4329:             .Height    = 23
4330:             .FontName  = "Tahoma"
4331:             .FontSize  = 8
4332:             .InputMask = "9,999,999.9999"
4333:             .Visible   = .T.
4334:         ENDWITH
4335: 
4336:         *-- GetMvalor (txt_4c_Mvalor): Moeda do Valor Estimado - T:454, L:317, W:31, H:23
4337:         loc_oPg.AddObject("txt_4c_Mvalor", "TextBox")
4338:         WITH loc_oPg.txt_4c_Mvalor
4339:             .Value     = ""
4340:             .Top       = 454
4341:             .Left      = 317
4342:             .Width     = 31
4343:             .Height    = 23
4344:             .FontName  = "Tahoma"
4345:             .FontSize  = 8
4346:             .InputMask = "!!!"
4347:             .Visible   = .T.
4348:         ENDWITH
4349:         BINDEVENT(loc_oPg.txt_4c_Mvalor, "KeyPress", THIS, "TxtMvalorKeyPress")
4350:         BINDEVENT(loc_oPg.txt_4c_Mvalor, "DblClick", THIS, "AbrirLookupMvalor")
4351: 
4352:         *-- Get_teor (txt_4c_Teor): Teor codigo - T:454, L:537, W:24, H:23
4353:         loc_oPg.AddObject("txt_4c_Teor", "TextBox")
4354:         WITH loc_oPg.txt_4c_Teor
4355:             .Value     = ""
4356:             .Top       = 454
4357:             .Left      = 537
4358:             .Width     = 24
4359:             .Height    = 23
4360:             .FontName  = "Tahoma"
4361:             .FontSize  = 8
4362:             .InputMask = "!!!!!!!!!!"
4363:             .Visible   = .T.
4364:         ENDWITH
4365:         BINDEVENT(loc_oPg.txt_4c_Teor, "KeyPress", THIS, "TxtTeorKeyPress")
4366:         BINDEVENT(loc_oPg.txt_4c_Teor, "DblClick", THIS, "AbrirLookupTeor")
4367: 
4368:         *-- Get_DesTeor (txt_4c_DesTeor): Teor descricao - T:454, L:564, W:150, H:23 (READ-ONLY)
4369:         loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
4370:         WITH loc_oPg.txt_4c_DesTeor
4371:             .Value    = ""
4372:             .Top      = 454
4373:             .Left     = 564
4374:             .Width    = 150
4375:             .Height   = 23
4376:             .FontName = "Tahoma"
4377:             .FontSize = 8
4378:             .ReadOnly = .T.
4379:             .Visible  = .T.
4380:         ENDWITH
4381: 
4382:         *-- getIPPTCST (txt_4c_IPPTCST): IPPT/CST - T:479, L:206, W:108, H:23 (READ-ONLY)
4383:         loc_oPg.AddObject("txt_4c_IPPTCST", "TextBox")
4384:         WITH loc_oPg.txt_4c_IPPTCST
4385:             .Value    = ""
4386:             .Top      = 479
4387:             .Left     = 206
4388:             .Width    = 108
4389:             .Height   = 23
4390:             .FontName = "Tahoma"
4391:             .FontSize = 8
4392:             .ReadOnly = .T.
4393:             .Visible  = .T.
4394:         ENDWITH
4395: 
4396:     ENDPROC
4397: 
4398:     *--------------------------------------------------------------------------
4399:     * ConfigurarPgpgCusto - Aba "Custo" do PageFrame interno (pgCusto)
4400:     * Fase 10: Sub-pagina Custo - grdCompo 12 colunas, cmbTipos, cmdgCusto,
4401:     *          GradeGRUPO2 (totais por grupo), labels e shape
4402:     * Posicoes: valores do layout.json (pgf_4c_Dados.Tabs=.F. -> sem +29)
4403:     *--------------------------------------------------------------------------
4404:     PROTECTED PROCEDURE ConfigurarPgpgCusto(par_oPage)
4405:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
4406: 
4407:         loc_oPg = par_oPage
4408: 
4409:         *-- ===================================================================
4410:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
4411:         *-- ===================================================================
4412: 
4413:         *-- cursor_4c_CustoCompo - composicao custo (SIGPRCPO filtrado por tipo)
4414:         IF USED("cursor_4c_CustoCompo")
4415:             USE IN cursor_4c_CustoCompo
4416:         ENDIF
4417:         SET NULL ON
4418:         CREATE CURSOR cursor_4c_CustoCompo ( ;
4419:             mats      C(14), dcompos C(40), unicompos C(3),  ;
4420:             pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
4421:             moeds     C(3), obscompos C(10), etiqs C(1),     ;
4422:             qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
4423:             CGrus     C(3), tipos C(20))
4424:         SET NULL OFF
4425: 
4426:         *-- cursor_4c_TotGrupoCusto - totais por grupo custo (calculado)
4427:         IF USED("cursor_4c_TotGrupoCusto")
4428:             USE IN cursor_4c_TotGrupoCusto
4429:         ENDIF
4430:         SET NULL ON
4431:         CREATE CURSOR cursor_4c_TotGrupoCusto ( ;
4432:             Grupo     C(3), ValGrupo N(11,3), Moeda C(3))
4433:         SET NULL OFF
4434: 
4435:         *-- ===================================================================
4436:         *-- COMBO cbo_4c_CmbTipos (cmbTipos: top=154, left=143, w=187, h=23)
4437:         *-- ===================================================================
4438:         loc_oPg.AddObject("cbo_4c_CmbTipos", "ComboBox")
4439:         WITH loc_oPg.cbo_4c_CmbTipos
4440:             .Top           = 154
4441:             .Left          = 143
4442:             .Width         = 187
4443:             .Height        = 23
4444:             .FontName      = "Tahoma"

*-- Linhas 4450 a 4493:
4450:             .Themes        = .F.
4451:             .Visible       = .T.
4452:         ENDWITH
4453:         BINDEVENT(loc_oPg.cbo_4c_CmbTipos, "InteractiveChange", THIS, "CboTiposCustoInteractiveChange")
4454: 
4455:         *-- LABEL lbl_4c_Label1 (Say1 "Tipo :": top=159, left=112, w=29, h=15)
4456:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
4457:         WITH loc_oPg.lbl_4c_Label1
4458:             .Caption   = "Tipo :"
4459:             .Top       = 159
4460:             .Left      = 112
4461:             .Width     = 29
4462:             .Height    = 15
4463:             .BackStyle = 0
4464:             .ForeColor = RGB(90, 90, 90)
4465:             .FontName  = "Tahoma"
4466:             .FontSize  = 8
4467:             .Visible   = .T.
4468:         ENDWITH
4469: 
4470:         *-- ===================================================================
4471:         *-- GRID grd_4c_CustoCompo (grdCompo: top=178, left=34, w=813, h=230)
4472:         *-- 12 colunas de SIGPRCPO
4473:         *-- ===================================================================
4474:         loc_oPg.AddObject("grd_4c_CustoCompo", "Grid")
4475:         loc_oGrd = loc_oPg.grd_4c_CustoCompo
4476:         WITH loc_oGrd
4477:             .Top         = 178
4478:             .Left        = 34
4479:             .Width       = 813
4480:             .Height      = 230
4481:             .FontName    = "Tahoma"
4482:             .FontSize    = 8
4483:             .RecordMark  = .F.
4484:             .DeleteMark  = .F.
4485:             .GridLines   = 3
4486:             .ReadOnly    = .F.
4487:             .RowHeight   = 16
4488:             .ScrollBars  = 2
4489:             .Themes      = .F.
4490:             .ColumnCount = 12
4491:             .Visible     = .T.
4492:         ENDWITH
4493: 

*-- Linhas 4609 a 4695:
4609:         loc_oGrd.Column11.Width = 59
4610:         loc_oGrd.Column12.Width = 24
4611: 
4612:         *-- BINDEVENT grd_4c_CustoCompo
4613:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdCustoCompoAfterRowColChange")
4614: 
4615:         *-- ===================================================================
4616:         *-- COMMANDGROUP obj_4c_CmdgCusto (cmdgCompo: top=240, left=851, w=50, h=90)
4617:         *-- 2 botoes: Inserir, Excluir
4618:         *-- ===================================================================
4619:         loc_oPg.AddObject("obj_4c_CmdgCusto", "CommandGroup")
4620:         WITH loc_oPg.obj_4c_CmdgCusto
4621:             .ButtonCount   = 2
4622:             .BorderStyle   = 0
4623:             .Top           = 240
4624:             .Left          = 851
4625:             .Width         = 50
4626:             .Height        = 90
4627:             .BackColor     = RGB(162, 214, 242)
4628:             .Themes        = .F.
4629:             .Visible       = .T.
4630:         ENDWITH
4631:         WITH loc_oPg.obj_4c_CmdgCusto
4632:             .Buttons(1).Top           = 5
4633:             .Buttons(1).Left          = 5
4634:             .Buttons(1).Height        = 40
4635:             .Buttons(1).Width         = 40
4636:             .Buttons(1).Caption       = ""
4637:             .Buttons(1).Picture       = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
4638:             .Buttons(1).ToolTipText   = "Inserir Item"
4639:             .Buttons(1).SpecialEffect = 0
4640:             .Buttons(1).BackColor     = RGB(255, 255, 255)
4641:             .Buttons(1).ForeColor     = RGB(0, 0, 0)
4642:             .Buttons(1).Themes        = .F.
4643:             .Buttons(2).Top           = 45
4644:             .Buttons(2).Left          = 5
4645:             .Buttons(2).Height        = 40
4646:             .Buttons(2).Width         = 40
4647:             .Buttons(2).Caption       = ""
4648:             .Buttons(2).Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
4649:             .Buttons(2).ToolTipText   = "Excluir Item"
4650:             .Buttons(2).SpecialEffect = 0
4651:             .Buttons(2).BackColor     = RGB(255, 255, 255)
4652:             .Buttons(2).ForeColor     = RGB(0, 0, 0)
4653:             .Buttons(2).Themes        = .F.
4654:         ENDWITH
4655:         BINDEVENT(loc_oPg.obj_4c_CmdgCusto, "Click", THIS, "CmdgCustoClick")
4656: 
4657:         *-- ===================================================================
4658:         *-- LABEL + TEXTBOX para descricao e grupo do item selecionado
4659:         *-- ===================================================================
4660: 
4661:         *-- LABEL lbl_4c_Label16 (Say16 "Descricao :": top=415, left=52, w=55, h=15)
4662:         loc_oPg.AddObject("lbl_4c_Label16", "Label")
4663:         WITH loc_oPg.lbl_4c_Label16
4664:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
4665:             .Top       = 415
4666:             .Left      = 52
4667:             .Width     = 55
4668:             .Height    = 15
4669:             .BackStyle = 0
4670:             .ForeColor = RGB(90, 90, 90)
4671:             .FontName  = "Tahoma"
4672:             .FontSize  = 8
4673:             .Visible   = .T.
4674:         ENDWITH
4675: 
4676:         *-- TEXTBOX txt_4c_Desc (Get_Desc: top=412, left=116, w=304, h=21, ReadOnly)
4677:         loc_oPg.AddObject("txt_4c_Desc", "TextBox")
4678:         WITH loc_oPg.txt_4c_Desc
4679:             .Value     = ""
4680:             .Top       = 412
4681:             .Left      = 116
4682:             .Width     = 304
4683:             .Height    = 21
4684:             .FontName  = "Tahoma"
4685:             .FontSize  = 8
4686:             .ReadOnly  = .T.
4687:             .BackColor = RGB(224, 235, 235)
4688:             .Themes    = .F.
4689:             .Visible   = .T.
4690:         ENDWITH
4691: 
4692:         *-- LABEL lbl_4c_Label2 (Say2 "Grupo :": top=415, left=479, w=38, h=15)
4693:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
4694:         WITH loc_oPg.lbl_4c_Label2
4695:             .Caption   = "Grupo :"

*-- Linhas 4815 a 4858:
4815:     * Ordem visual: Mats | Dcompos | Qtds | UniCompos | Grupos | Dscgrp | Ordems | QtsCons | Cats
4816:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
4817:     *--------------------------------------------------------------------------
4818:     PROTECTED PROCEDURE ConfigurarPgPgDadosConsP(par_oPage)
4819:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
4820: 
4821:         loc_oPg = par_oPage
4822: 
4823:         *-- ===================================================================
4824:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
4825:         *-- Campos na ORDEM VISUAL das colunas (sem ColumnOrder)
4826:         *-- ===================================================================
4827: 
4828:         *-- cursor_4c_GrdCons - consumo de produto (baseado em crSigPrCpo)
4829:         *-- Ordem: Mats(cod), Dcompos(desc), Qtds(qtde RO), UniCompos(uni RO),
4830:         *--        Grupos(fase), Dscgrp(desc fase), Ordems(ord RO), QtsCons(consumo), Cats(cat)
4831:         IF USED("cursor_4c_GrdCons")
4832:             USE IN cursor_4c_GrdCons
4833:         ENDIF
4834:         SET NULL ON
4835:         CREATE CURSOR cursor_4c_GrdCons ( ;
4836:             Mats      C(14), ;
4837:             Dcompos   C(40), ;
4838:             Qtds      N(12,4), ;
4839:             UniCompos C(3), ;
4840:             Grupos    C(3), ;
4841:             Dscgrp    C(40), ;
4842:             Ordems    N(3,0), ;
4843:             QtsCons   N(12,4), ;
4844:             Cats      C(3))
4845:         SET NULL OFF
4846: 
4847:         *-- cursor_4c_GrDTEMP - tempo por agrupamento (baseado em crSigProTp)
4848:         IF USED("cursor_4c_GrDTEMP")
4849:             USE IN cursor_4c_GrDTEMP
4850:         ENDIF
4851:         SET NULL ON
4852:         CREATE CURSOR cursor_4c_GrDTEMP ( ;
4853:             agrupas   C(3), ;
4854:             pertemps  N(12,3))
4855:         SET NULL OFF
4856: 
4857:         *-- ===================================================================
4858:         *-- GRID grd_4c_GrdCons

*-- Linhas 4975 a 5019:
4975:         loc_oGrd.Column8.Width = 60
4976:         loc_oGrd.Column9.Width = 52
4977: 
4978:         *-- BINDEVENT grd_4c_GrdCons
4979:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdConsAfterRowColChange")
4980: 
4981:         *-- ===================================================================
4982:         *-- GRID grd_4c_GrDTEMP (grDTEMP: top=519, left=821, w=172, h=107, 2 cols)
4983:         *-- ===================================================================
4984:         loc_oPg.AddObject("grd_4c_GrDTEMP", "Grid")
4985:         loc_oGrd2 = loc_oPg.grd_4c_GrDTEMP
4986:         WITH loc_oGrd2
4987:             .Top         = 519
4988:             .Left        = 821
4989:             .Width       = 172
4990:             .Height      = 107
4991:             .FontName    = "Tahoma"
4992:             .FontSize    = 8
4993:             .RecordMark  = .T.
4994:             .DeleteMark  = .F.
4995:             .GridLines   = 3
4996:             .ReadOnly    = .T.
4997:             .RowHeight   = 17
4998:             .ScrollBars  = 2
4999:             .Themes      = .F.
5000:             .ColumnCount = 2
5001:             .Visible     = .T.
5002:         ENDWITH
5003: 
5004:         *-- Col1: Agrupamento/agrupas (80px, ReadOnly)
5005:         WITH loc_oGrd2.Column1
5006:             .Width     = 80
5007:             .Movable   = .F.
5008:             .Resizable = .F.
5009:             .ReadOnly  = .T.
5010:         ENDWITH
5011:         *-- Col2: Tempo %/pertemps (60px, ReadOnly)
5012:         WITH loc_oGrd2.Column2
5013:             .Width      = 60
5014:             .Movable    = .F.
5015:             .Resizable  = .F.
5016:             .ReadOnly   = .T.
5017:             .InputMask  = "999,999,999.999"
5018:         ENDWITH
5019: 

*-- Linhas 5120 a 5163:
5120:     * ImgFigJpg (foto do processo), ImgBorracha (foto da matriz)
5121:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
5122:     *--------------------------------------------------------------------------
5123:     PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP(par_oPage)
5124:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
5125: 
5126:         loc_oPg = par_oPage
5127: 
5128:         *-- ===================================================================
5129:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
5130:         *-- Campos na ORDEM VISUAL das colunas (sem ColumnOrder)
5131:         *-- ===================================================================
5132: 
5133:         *-- cursor_4c_Fase - fases de processo (baseado em crSigCdPrf)
5134:         *-- Ordem visual: Ordems | Grupos | Descrs | UniPrdts | TpMats
5135:         IF USED("cursor_4c_Fase")
5136:             USE IN cursor_4c_Fase
5137:         ENDIF
5138:         SET NULL ON
5139:         CREATE CURSOR cursor_4c_Fase ( ;
5140:             Ordems    N(3,0), ;
5141:             Grupos    C(10), ;
5142:             Descrs    C(40), ;
5143:             UniPrdts  C(10), ;
5144:             TpMats    C(3), ;
5145:             FigProcs  M, ;
5146:             FkChaves  C(30), ;
5147:             GrpOrdem  C(12))
5148:         SET NULL OFF
5149: 
5150:         *-- cursor_4c_Matrizes - matrizes do produto (baseado em crSigPrMtz)
5151:         *-- Ordem visual: CMats | Locals | QMatz
5152:         IF USED("cursor_4c_Matrizes")
5153:             USE IN cursor_4c_Matrizes
5154:         ENDIF
5155:         SET NULL ON
5156:         CREATE CURSOR cursor_4c_Matrizes ( ;
5157:             CMats     C(14), ;
5158:             Locals    C(20), ;
5159:             QMatz     N(5,2), ;
5160:             CPros     C(14), ;
5161:             cIdChaves C(30), ;
5162:             DPros     C(40))
5163:         SET NULL OFF

*-- Linhas 5248 a 5377:
5248:         loc_oGrd.Column4.Width = 100
5249:         loc_oGrd.Column5.Width = 45
5250: 
5251:         *-- BINDEVENT grd_4c_FasePro
5252:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdFaseAfterRowColChange")
5253:         BINDEVENT(loc_oGrd.Column2.Text1, "Valid", THIS, "FaseGrdCol2Valid")
5254:         BINDEVENT(loc_oGrd.Column4.Text1, "Valid", THIS, "FaseGrdCol4Valid")
5255:         BINDEVENT(loc_oGrd.Column5.Text1, "Valid", THIS, "FaseGrdCol5Valid")
5256: 
5257:         *-- ===================================================================
5258:         *-- COMMANDBUTTON cmd_4c_Incluir (inserir: top=152, left=950, 30x30)
5259:         *-- ===================================================================
5260:         loc_oPg.AddObject("cmd_4c_InsFase", "CommandButton")
5261:         WITH loc_oPg.cmd_4c_InsFase
5262:             .Top             = 152
5263:             .Left            = 950
5264:             .Width           = 30
5265:             .Height          = 30
5266:             .Caption         = ""
5267:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
5268:             .PicturePosition = 13
5269:             .ToolTipText     = "Inserir Fase"
5270:             .FontName        = "Tahoma"
5271:             .FontSize        = 8
5272:             .Themes          = .F.
5273:             .SpecialEffect   = 0
5274:             .BackColor       = RGB(255, 255, 255)
5275:             .Visible         = .T.
5276:         ENDWITH
5277:         BINDEVENT(loc_oPg.cmd_4c_InsFase, "Click", THIS, "FaseInserirClick")
5278: 
5279:         *-- COMMANDBUTTON cmd_4c_ExcFase (excluir: top=192, left=950, 30x30)
5280:         loc_oPg.AddObject("cmd_4c_ExcFase", "CommandButton")
5281:         WITH loc_oPg.cmd_4c_ExcFase
5282:             .Top             = 192
5283:             .Left            = 950
5284:             .Width           = 30
5285:             .Height          = 30
5286:             .Caption         = ""
5287:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
5288:             .PicturePosition = 13
5289:             .ToolTipText     = "Excluir Fase"
5290:             .FontName        = "Tahoma"
5291:             .FontSize        = 8
5292:             .Themes          = .F.
5293:             .SpecialEffect   = 0
5294:             .BackColor       = RGB(255, 255, 255)
5295:             .Visible         = .T.
5296:         ENDWITH
5297:         BINDEVENT(loc_oPg.cmd_4c_ExcFase, "Click", THIS, "FaseExcluirClick")
5298: 
5299:         *-- COMMANDBUTTON cmd_4c_AltFase (Alternativa: top=232, left=950, 30x30)
5300:         loc_oPg.AddObject("cmd_4c_AltFase", "CommandButton")
5301:         WITH loc_oPg.cmd_4c_AltFase
5302:             .Top             = 232
5303:             .Left            = 950
5304:             .Width           = 30
5305:             .Height          = 30
5306:             .Caption         = ""
5307:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
5308:             .PicturePosition = 13
5309:             .ToolTipText     = "Fase Alternativa"
5310:             .FontName        = "Tahoma"
5311:             .FontSize        = 8
5312:             .Themes          = .F.
5313:             .SpecialEffect   = 0
5314:             .BackColor       = RGB(255, 255, 255)
5315:             .Visible         = .T.
5316:         ENDWITH
5317:         BINDEVENT(loc_oPg.cmd_4c_AltFase, "Click", THIS, "FaseAlternativaClick")
5318: 
5319:         *-- COMMANDBUTTON cmd_4c_CmdFicha (CmdFicha: top=152, left=482, 30x30)
5320:         loc_oPg.AddObject("cmd_4c_CmdFicha", "CommandButton")
5321:         WITH loc_oPg.cmd_4c_CmdFicha
5322:             .Top             = 152
5323:             .Left            = 482
5324:             .Width           = 30
5325:             .Height          = 30
5326:             .Caption         = ""
5327:             .Picture         = gc_4c_CaminhoIcones + "relatorio_visualizar_26.jpg"
5328:             .PicturePosition = 13
5329:             .ToolTipText     = "Ficha T" + CHR(233) + "cnica"
5330:             .FontName        = "Tahoma"
5331:             .FontSize        = 8
5332:             .Themes          = .F.
5333:             .SpecialEffect   = 0
5334:             .BackColor       = RGB(255, 255, 255)
5335:             .Visible         = .T.
5336:         ENDWITH
5337:         BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaClick")
5338: 
5339:         *-- ===================================================================
5340:         *-- LABEL + TEXTBOX: Say13/getQmin "Qtd. Min. Producao :" (top=156/152, left=33/137)
5341:         *-- ===================================================================
5342:         loc_oPg.AddObject("lbl_4c_Label13", "Label")
5343:         WITH loc_oPg.lbl_4c_Label13
5344:             .Caption   = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
5345:             .Top       = 156
5346:             .Left      = 33
5347:             .Width     = 102
5348:             .Height    = 15
5349:             .BackStyle = 0
5350:             .ForeColor = RGB(90, 90, 90)
5351:             .FontName  = "Tahoma"
5352:             .FontSize  = 8
5353:             .Visible   = .T.
5354:         ENDWITH
5355: 
5356:         loc_oPg.AddObject("txt_4c_Qmin", "TextBox")
5357:         WITH loc_oPg.txt_4c_Qmin
5358:             .Top           = 152
5359:             .Left          = 137
5360:             .Width         = 80
5361:             .Height        = 23
5362:             .FontName      = "Tahoma"
5363:             .FontSize      = 8
5364:             .SpecialEffect = 1
5365:             .Themes        = .F.
5366:             .ReadOnly      = .F.
5367:             .Alignment     = 3
5368:             .InputMask     = "99999.999"
5369:             .Value         = 0
5370:             .Visible       = .T.
5371:         ENDWITH
5372: 
5373:         *-- ===================================================================
5374:         *-- LABEL + TEXTBOX: Say5/getCodGarras "Garra :" (top=181/177, left=99/137)
5375:         *-- getCodGarras.When = .F. -> ReadOnly
5376:         *-- ===================================================================
5377:         loc_oPg.AddObject("lbl_4c_Label5", "Label")

*-- Linhas 5434 a 5477:
5434:             .Value         = ""
5435:             .Visible       = .T.
5436:         ENDWITH
5437:         BINDEVENT(loc_oPg.txt_4c_Conquilha, "LostFocus", THIS, "ValidarConquilha")
5438: 
5439:         *-- ===================================================================
5440:         *-- LABEL + TEXTBOX: Say9/getPesoBris "Peso Brilhante :" (top=231/227, left=58/137)
5441:         *-- ===================================================================
5442:         loc_oPg.AddObject("lbl_4c_Label9", "Label")
5443:         WITH loc_oPg.lbl_4c_Label9
5444:             .Caption   = "Peso Brilhante :"
5445:             .Top       = 231
5446:             .Left      = 58
5447:             .Width     = 77
5448:             .Height    = 15
5449:             .BackStyle = 0
5450:             .ForeColor = RGB(90, 90, 90)
5451:             .FontName  = "Tahoma"
5452:             .FontSize  = 8
5453:             .Visible   = .T.
5454:         ENDWITH
5455: 
5456:         loc_oPg.AddObject("txt_4c_PesoBris", "TextBox")
5457:         WITH loc_oPg.txt_4c_PesoBris
5458:             .Top           = 227
5459:             .Left          = 137
5460:             .Width         = 80
5461:             .Height        = 23
5462:             .FontName      = "Tahoma"
5463:             .FontSize      = 8
5464:             .SpecialEffect = 1
5465:             .Themes        = .F.
5466:             .ReadOnly      = .F.
5467:             .Alignment     = 3
5468:             .InputMask     = "999.9999"
5469:             .Value         = 0
5470:             .Visible       = .T.
5471:         ENDWITH
5472: 
5473:         *-- ===================================================================
5474:         *-- LABEL + TEXTBOX: Say10/getPesoMetal "Peso Metal :" (top=256/252, left=74/137)
5475:         *-- ===================================================================
5476:         loc_oPg.AddObject("lbl_4c_Label10", "Label")
5477:         WITH loc_oPg.lbl_4c_Label10

*-- Linhas 5569 a 5612:
5569:             .Value         = ""
5570:             .Visible       = .T.
5571:         ENDWITH
5572:         BINDEVENT(loc_oPg.txt_4c_Cor, "LostFocus", THIS, "ValidarCor")
5573: 
5574:         *-- ===================================================================
5575:         *-- CHECKBOX: opc_CravCera "Cravacao em Cera" (top=306, left=180)
5576:         *-- ===================================================================
5577:         loc_oPg.AddObject("chk_4c_CravCera", "CheckBox")
5578:         WITH loc_oPg.chk_4c_CravCera
5579:             .Caption       = "Crava" + CHR(231) + CHR(227) + "o em Cera"
5580:             .Top           = 306
5581:             .Left          = 180
5582:             .Width         = 110
5583:             .Height        = 15
5584:             .FontName      = "Tahoma"
5585:             .FontSize      = 8
5586:             .BackStyle     = 0
5587:             .Alignment     = 0
5588:             .AutoSize      = .T.
5589:             .SpecialEffect = 1
5590:             .ForeColor     = RGB(90, 90, 90)
5591:             .Themes        = .F.
5592:             .Value         = .F.
5593:             .Visible       = .T.
5594:         ENDWITH
5595: 
5596:         *-- ===================================================================
5597:         *-- LABEL + TEXTBOX: Say2/getTam "Tamanho Padrao :" (top=331/327, left=45/137)
5598:         *-- ===================================================================
5599:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
5600:         WITH loc_oPg.lbl_4c_Label2
5601:             .Caption   = "Tamanho Padr" + CHR(227) + "o :"
5602:             .Top       = 331
5603:             .Left      = 45
5604:             .Width     = 90
5605:             .Height    = 15
5606:             .BackStyle = 0
5607:             .ForeColor = RGB(90, 90, 90)
5608:             .FontName  = "Tahoma"
5609:             .FontSize  = 8
5610:             .Visible   = .T.
5611:         ENDWITH
5612: 

*-- Linhas 5624 a 5667:
5624:             .Value         = ""
5625:             .Visible       = .T.
5626:         ENDWITH
5627:         BINDEVENT(loc_oPg.txt_4c_Tam, "LostFocus", THIS, "ValidarTam")
5628: 
5629:         *-- ===================================================================
5630:         *-- CHECKBOX: fwoption1 "Peso Variavel" (top=331, left=180)
5631:         *-- ===================================================================
5632:         loc_oPg.AddObject("chk_4c_PesoVar", "CheckBox")
5633:         WITH loc_oPg.chk_4c_PesoVar
5634:             .Caption       = "Peso Vari" + CHR(225) + "vel"
5635:             .Top           = 331
5636:             .Left          = 180
5637:             .Width         = 90
5638:             .Height        = 15
5639:             .FontName      = "Tahoma"
5640:             .FontSize      = 8
5641:             .BackStyle     = 0
5642:             .Alignment     = 0
5643:             .AutoSize      = .T.
5644:             .SpecialEffect = 1
5645:             .ForeColor     = RGB(90, 90, 90)
5646:             .Themes        = .F.
5647:             .Value         = .F.
5648:             .Visible       = .T.
5649:         ENDWITH
5650: 
5651:         *-- ===================================================================
5652:         *-- LABEL + TEXTBOX: lblAcabamento/get_codacb/get_Dacb (top=356/352, left=16/137/177)
5653:         *-- get_Dacb.When = .F. -> ReadOnly (preenchido pelo lookup de codacb)
5654:         *-- ===================================================================
5655:         loc_oPg.AddObject("lbl_4c_LblAcabamento", "Label")
5656:         WITH loc_oPg.lbl_4c_LblAcabamento
5657:             .Caption   = "Acabamento :"
5658:             .Top       = 356
5659:             .Left      = 16
5660:             .Width     = 119
5661:             .Height    = 15
5662:             .BackStyle = 0
5663:             .ForeColor = RGB(90, 90, 90)
5664:             .FontName  = "Tahoma"
5665:             .FontSize  = 8
5666:             .Visible   = .T.
5667:         ENDWITH

*-- Linhas 5680 a 5823:
5680:             .Value         = ""
5681:             .Visible       = .T.
5682:         ENDWITH
5683:         BINDEVENT(loc_oPg.txt_4c_CodAcb, "LostFocus", THIS, "ValidarAcabamento")
5684: 
5685:         loc_oPg.AddObject("txt_4c_Dacb", "TextBox")
5686:         WITH loc_oPg.txt_4c_Dacb
5687:             .Top           = 352
5688:             .Left          = 177
5689:             .Width         = 207
5690:             .Height        = 23
5691:             .FontName      = "Tahoma"
5692:             .FontSize      = 8
5693:             .SpecialEffect = 1
5694:             .Themes        = .F.
5695:             .ReadOnly      = .T.
5696:             .Value         = ""
5697:             .Visible       = .T.
5698:         ENDWITH
5699: 
5700:         *-- ===================================================================
5701:         *-- SHAPE shp_4c_ShpFig (shpFig: top=152, left=231, w=244, h=148)
5702:         *-- IMAGE img_4c_ImgFigJpg (ImgFigJpg: top=153, left=232, w=241, h=146)
5703:         *-- ===================================================================
5704:         loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
5705:         WITH loc_oPg.shp_4c_ShpFig
5706:             .Top         = 152
5707:             .Left        = 231
5708:             .Width       = 244
5709:             .Height      = 148
5710:             .BackColor   = RGB(240, 240, 240)
5711:             .BorderColor = RGB(128, 128, 128)
5712:             .BorderWidth = 1
5713:             .Visible     = .T.
5714:         ENDWITH
5715: 
5716:         loc_oPg.AddObject("img_4c_ImgFigJpg", "Image")
5717:         WITH loc_oPg.img_4c_ImgFigJpg
5718:             .Top     = 153
5719:             .Left    = 232
5720:             .Width   = 241
5721:             .Height  = 146
5722:             .Stretch = 2
5723:             .Visible = .F.
5724:         ENDWITH
5725:         BINDEVENT(loc_oPg.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")
5726: 
5727:         *-- ===================================================================
5728:         *-- COMMANDGROUP obj_4c_CmdgFigura (cmdgFigura: top=192, left=482, 40x40, 1 botao)
5729:         *-- Selecionar foto do processo
5730:         *-- ===================================================================
5731:         loc_oPg.AddObject("obj_4c_CmdgFigura", "CommandGroup")
5732:         WITH loc_oPg.obj_4c_CmdgFigura
5733:             .ButtonCount = 1
5734:             .BorderStyle = 0
5735:             .Top         = 192
5736:             .Left        = 482
5737:             .Width       = 40
5738:             .Height      = 40
5739:             .Themes      = .F.
5740:             .Visible     = .T.
5741:         ENDWITH
5742:         WITH loc_oPg.obj_4c_CmdgFigura
5743:             .Buttons(1).Top           = 0
5744:             .Buttons(1).Left          = 0
5745:             .Buttons(1).Height        = 40
5746:             .Buttons(1).Width         = 40
5747:             .Buttons(1).Caption       = ""
5748:             .Buttons(1).Picture       = gc_4c_CaminhoIcones + "geral_foto_26.jpg"
5749:             .Buttons(1).ToolTipText   = "Selecionar Foto"
5750:             .Buttons(1).SpecialEffect = 0
5751:             .Buttons(1).BackColor     = RGB(255, 255, 255)
5752:             .Buttons(1).Themes        = .F.
5753:         ENDWITH
5754:         BINDEVENT(loc_oPg.obj_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")
5755: 
5756:         *-- ===================================================================
5757:         *-- COMMANDGROUP obj_4c_CmdgFigCam (cmdgFigCam: top=232, left=482, 40x40, 1 botao)
5758:         *-- Capturar da camera
5759:         *-- ===================================================================
5760:         loc_oPg.AddObject("obj_4c_CmdgFigCam", "CommandGroup")
5761:         WITH loc_oPg.obj_4c_CmdgFigCam
5762:             .ButtonCount = 1
5763:             .BorderStyle = 0
5764:             .Top         = 232
5765:             .Left        = 482
5766:             .Width       = 40
5767:             .Height      = 40
5768:             .Themes      = .F.
5769:             .Visible     = .T.
5770:         ENDWITH
5771:         WITH loc_oPg.obj_4c_CmdgFigCam
5772:             .Buttons(1).Top           = 0
5773:             .Buttons(1).Left          = 0
5774:             .Buttons(1).Height        = 40
5775:             .Buttons(1).Width         = 40
5776:             .Buttons(1).Caption       = ""
5777:             .Buttons(1).Picture       = gc_4c_CaminhoIcones + "geral_camera_26.jpg"
5778:             .Buttons(1).ToolTipText   = "Capturar da C" + CHR(226) + "mera"
5779:             .Buttons(1).SpecialEffect = 0
5780:             .Buttons(1).BackColor     = RGB(255, 255, 255)
5781:             .Buttons(1).Themes        = .F.
5782:         ENDWITH
5783:         BINDEVENT(loc_oPg.obj_4c_CmdgFigCam, "Click", THIS, "CmdgFigCamClick")
5784: 
5785:         *-- ===================================================================
5786:         *-- LABEL lbl_4c_Label1 "Descricao :" (Say1: top=474, left=527, w=67, h=17)
5787:         *-- TEXTBOX txt_4c_Desc (Get_Desc: top=471, left=595, w=395, h=23)
5788:         *-- EDITBOX obj_4c_GetObs (Get_Obs: top=497, left=527, w=463, h=122)
5789:         *-- ===================================================================
5790:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
5791:         WITH loc_oPg.lbl_4c_Label1
5792:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
5793:             .Top       = 474
5794:             .Left      = 527
5795:             .Width     = 67
5796:             .Height    = 17
5797:             .BackStyle = 0
5798:             .ForeColor = RGB(90, 90, 90)
5799:             .FontName  = "Tahoma"
5800:             .FontSize  = 8
5801:             .Visible   = .T.
5802:         ENDWITH
5803: 
5804:         loc_oPg.AddObject("txt_4c_Desc", "TextBox")
5805:         WITH loc_oPg.txt_4c_Desc
5806:             .Top           = 471
5807:             .Left          = 595
5808:             .Width         = 395
5809:             .Height        = 23
5810:             .FontName      = "Tahoma"
5811:             .FontSize      = 8
5812:             .SpecialEffect = 1
5813:             .Themes        = .F.
5814:             .ReadOnly      = .F.
5815:             .Value         = ""
5816:             .Visible       = .T.
5817:         ENDWITH
5818: 
5819:         loc_oPg.AddObject("obj_4c_GetObs", "EditBox")
5820:         WITH loc_oPg.obj_4c_GetObs
5821:             .Top           = 497
5822:             .Left          = 527
5823:             .Width         = 463

*-- Linhas 5895 a 6020:
5895:         loc_oGrd2.Column2.Width = 116
5896:         loc_oGrd2.Column3.Width = 50
5897: 
5898:         *-- BINDEVENT grd_4c_Matrizes
5899:         BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
5900:         BINDEVENT(loc_oGrd2.Column1.Text1, "Valid", THIS, "MatrizGrdCol1Valid")
5901: 
5902:         *-- ===================================================================
5903:         *-- COMMANDBUTTON cmd_4c_BtnInsereMtx (btnInsereMtx: top=380, left=258, 30x30)
5904:         *-- ===================================================================
5905:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
5906:         WITH loc_oPg.cmd_4c_BtnInsereMtx
5907:             .Top             = 380
5908:             .Left            = 258
5909:             .Width           = 30
5910:             .Height          = 30
5911:             .Caption         = ""
5912:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
5913:             .PicturePosition = 13
5914:             .ToolTipText     = "Inserir Matriz"
5915:             .FontName        = "Tahoma"
5916:             .FontSize        = 8
5917:             .Themes          = .F.
5918:             .SpecialEffect   = 0
5919:             .BackColor       = RGB(255, 255, 255)
5920:             .Visible         = .T.
5921:         ENDWITH
5922:         BINDEVENT(loc_oPg.cmd_4c_BtnInsereMtx, "Click", THIS, "BtnInsereMtxClick")
5923: 
5924:         *-- COMMANDBUTTON cmd_4c_BtnExcluiMtz (btnExcluiMtz: top=420, left=258, 30x30)
5925:         loc_oPg.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
5926:         WITH loc_oPg.cmd_4c_BtnExcluiMtz
5927:             .Top             = 420
5928:             .Left            = 258
5929:             .Width           = 30
5930:             .Height          = 30
5931:             .Caption         = ""
5932:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
5933:             .PicturePosition = 13
5934:             .ToolTipText     = "Excluir Matriz"
5935:             .FontName        = "Tahoma"
5936:             .FontSize        = 8
5937:             .Themes          = .F.
5938:             .SpecialEffect   = 0
5939:             .BackColor       = RGB(255, 255, 255)
5940:             .Visible         = .T.
5941:         ENDWITH
5942:         BINDEVENT(loc_oPg.cmd_4c_BtnExcluiMtz, "Click", THIS, "BtnExcluiMtzClick")
5943: 
5944:         *-- ===================================================================
5945:         *-- SHAPE shp_4c_ShpBorracha (shpBorracha: top=464, left=258, w=236, h=156)
5946:         *-- IMAGE img_4c_ImgBorracha (ImgBorracha: top=465, left=260, w=232, h=154)
5947:         *-- ===================================================================
5948:         loc_oPg.AddObject("shp_4c_ShpBorracha", "Shape")
5949:         WITH loc_oPg.shp_4c_ShpBorracha
5950:             .Top         = 464
5951:             .Left        = 258
5952:             .Width       = 236
5953:             .Height      = 156
5954:             .BackColor   = RGB(240, 240, 240)
5955:             .BorderColor = RGB(128, 128, 128)
5956:             .BorderWidth = 1
5957:             .Visible     = .T.
5958:         ENDWITH
5959: 
5960:         loc_oPg.AddObject("img_4c_ImgBorracha", "Image")
5961:         WITH loc_oPg.img_4c_ImgBorracha
5962:             .Top     = 465
5963:             .Left    = 260
5964:             .Width   = 232
5965:             .Height  = 154
5966:             .Stretch = 2
5967:             .Visible = .F.
5968:         ENDWITH
5969: 
5970:     ENDPROC
5971: 
5972:     *--------------------------------------------------------------------------
5973:     * ConfigurarPgpgDesigner - Aba "Designer" (Page7 do pgf_4c_Dados)
5974:     * Controles: grd_4c_Designer (4 cols tarefas), obj_4c_GetObsTarefas,
5975:     *            cmd_4c_BtnIniTarefa, cmd_4c_BtnFimTarefa,
5976:     *            grd_4c_Arquivos (1 col), cmd_4c_BtnInsArqs/OpnArqs/ExcArqs,
5977:     *            shp_4c_Shape1, img_4c_ImgArqJpg
5978:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
5979:     *--------------------------------------------------------------------------
5980:     PROTECTED PROCEDURE ConfigurarPgpgDesigner(par_oPage)
5981:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
5982: 
5983:         loc_oPg = par_oPage
5984: 
5985:         *-- ===================================================================
5986:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
5987:         *-- Campos na ORDEM VISUAL das colunas (sem ColumnOrder)
5988:         *-- ===================================================================
5989: 
5990:         *-- cursor_4c_Tarefas - tarefas do designer (baseado em crSigPrTar)
5991:         *-- Ordem visual: DtInis | DtFims | Usuars | Tarefas
5992:         IF USED("cursor_4c_Tarefas")
5993:             USE IN cursor_4c_Tarefas
5994:         ENDIF
5995:         SET NULL ON
5996:         CREATE CURSOR cursor_4c_Tarefas ( ;
5997:             DtInis      T, ;
5998:             DtFims      T, ;
5999:             Usuars      C(10), ;
6000:             Tarefas     C(10), ;
6001:             ObsTarefas  M, ;
6002:             CPros       C(14), ;
6003:             pkChaves    C(30))
6004:         SET NULL OFF
6005: 
6006:         *-- cursor_4c_Arquivos - arquivos do designer (baseado em crSigPrArq)
6007:         IF USED("cursor_4c_Arquivos")
6008:             USE IN cursor_4c_Arquivos
6009:         ENDIF
6010:         SET NULL ON
6011:         CREATE CURSOR cursor_4c_Arquivos ( ;
6012:             Arquivos    C(254), ;
6013:             CPros       C(14), ;
6014:             pkChaves    C(30))
6015:         SET NULL OFF
6016: 
6017:         *-- ===================================================================
6018:         *-- GRID grd_4c_Designer (grdDesigner: top=160, left=10, w=495, h=238, 4 cols)
6019:         *-- crSigPrTar: DtInis T | DtFims T | Usuars C(10) | Tarefas C(10)
6020:         *-- ===================================================================

*-- Linhas 6088 a 6133:
6088:         loc_oGrd.Column3.Width = 100
6089:         loc_oGrd.Column4.Width = 155
6090: 
6091:         *-- BINDEVENT grd_4c_Designer
6092:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")
6093:         BINDEVENT(loc_oGrd.Column4.Text1, "Valid", THIS, "DesignerCol4Valid")
6094: 
6095:         *-- ===================================================================
6096:         *-- LABEL lbl_4c_Say31 ("Observacao da Tarefa": top=144, left=583)
6097:         *-- ===================================================================
6098:         loc_oPg.AddObject("lbl_4c_Say31", "Label")
6099:         WITH loc_oPg.lbl_4c_Say31
6100:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
6101:             .Top       = 144
6102:             .Left      = 583
6103:             .Width     = 120
6104:             .Height    = 15
6105:             .BackStyle = 0
6106:             .ForeColor = RGB(90, 90, 90)
6107:             .FontName  = "Tahoma"
6108:             .FontSize  = 8
6109:             .Visible   = .T.
6110:         ENDWITH
6111: 
6112:         *-- ===================================================================
6113:         *-- EDITBOX obj_4c_GetObsTarefas (getObsTarefas: top=160, left=584, w=407, h=238)
6114:         *-- When: InList(pcEscolha, INSERIR, ALTERAR) -> editavel so em modo edicao
6115:         *-- ===================================================================
6116:         loc_oPg.AddObject("obj_4c_GetObsTarefas", "EditBox")
6117:         WITH loc_oPg.obj_4c_GetObsTarefas
6118:             .Value         = ""
6119:             .Top           = 160
6120:             .Left          = 584
6121:             .Width         = 407
6122:             .Height        = 238
6123:             .FontName      = "Tahoma"
6124:             .FontSize      = 8
6125:             .ScrollBars    = 2
6126:             .ReadOnly      = .F.
6127:             .Themes        = .F.
6128:             .ControlSource = "cursor_4c_Tarefas.ObsTarefas"
6129:             .Visible       = .T.
6130:         ENDWITH
6131: 
6132:         *-- ===================================================================
6133:         *-- COMMANDBUTTON cmd_4c_BtnIniTarefa (btnIniTarefa: top=161, left=509, w=42, h=42)

*-- Linhas 6151 a 7400:
6151:             .BackColor       = RGB(255, 255, 255)
6152:             .Visible         = .T.
6153:         ENDWITH
6154:         BINDEVENT(loc_oPg.cmd_4c_BtnIniTarefa, "Click", THIS, "BtnIniTarefaClick")
6155: 
6156:         *-- ===================================================================
6157:         *-- COMMANDBUTTON cmd_4c_BtnFimTarefa (btnFimTarefa: top=203, left=509, w=42, h=42)
6158:         *-- When: InList(pcEscolha, INSERIR, ALTERAR)
6159:         *-- Click: Valida pertencimento + registra DtFims
6160:         *-- ===================================================================
6161:         loc_oPg.AddObject("cmd_4c_BtnFimTarefa", "CommandButton")
6162:         WITH loc_oPg.cmd_4c_BtnFimTarefa
6163:             .Top             = 203
6164:             .Left            = 509
6165:             .Width           = 42
6166:             .Height          = 42
6167:             .Caption         = ""
6168:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
6169:             .PicturePosition = 13
6170:             .ToolTipText     = "Finalizar Tarefa"
6171:             .FontName        = "Tahoma"
6172:             .FontSize        = 8
6173:             .Themes          = .F.
6174:             .SpecialEffect   = 0
6175:             .BackColor       = RGB(255, 255, 255)
6176:             .Visible         = .T.
6177:         ENDWITH
6178:         BINDEVENT(loc_oPg.cmd_4c_BtnFimTarefa, "Click", THIS, "BtnFimTarefaClick")
6179: 
6180:         *-- ===================================================================
6181:         *-- GRID grd_4c_Arquivos (grdArquivos: top=415, left=10, w=495, h=202, 1 col)
6182:         *-- crSigPrArq: Arquivos C(254)
6183:         *-- ===================================================================
6184:         loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
6185:         loc_oGrd2 = loc_oPg.grd_4c_Arquivos
6186:         WITH loc_oGrd2
6187:             .Top         = 415
6188:             .Left        = 10
6189:             .Width       = 495
6190:             .Height      = 202
6191:             .FontName    = "Tahoma"
6192:             .FontSize    = 8
6193:             .RecordMark  = .F.
6194:             .DeleteMark  = .F.
6195:             .GridLines   = 3
6196:             .ReadOnly    = .F.
6197:             .RowHeight   = 17
6198:             .ScrollBars  = 2
6199:             .Themes      = .F.
6200:             .ColumnCount = 1
6201:             .Visible     = .T.
6202:         ENDWITH
6203: 
6204:         *-- Col1: Arquivos (495px, editavel)
6205:         WITH loc_oGrd2.Column1
6206:             .Width     = 495
6207:             .Movable   = .F.
6208:             .Resizable = .F.
6209:             .Sparse    = .F.
6210:         ENDWITH
6211: 
6212:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
6213:         loc_oGrd2.RecordSource = "cursor_4c_Arquivos"
6214: 
6215:         *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
6216:         loc_oGrd2.Column1.ControlSource = "cursor_4c_Arquivos.Arquivos"
6217: 
6218:         *-- Cabecalho APOS RecordSource
6219:         loc_oGrd2.Column1.Header1.Caption = "Arquivos Para Designer"
6220: 
6221:         *-- Largura re-aplicada APOS RecordSource
6222:         loc_oGrd2.Column1.Width = 495
6223: 
6224:         *-- BINDEVENT grd_4c_Arquivos
6225:         BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")
6226: 
6227:         *-- ===================================================================
6228:         *-- COMMANDBUTTON cmd_4c_BtnInsArqs (btnInsArqs: top=416, left=509, w=42, h=42)
6229:         *-- When: InList(pcEscolha, INSERIR, ALTERAR)
6230:         *-- Click: GetFile -> Insert Into cursor_4c_Arquivos
6231:         *-- ===================================================================
6232:         loc_oPg.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
6233:         WITH loc_oPg.cmd_4c_BtnInsArqs
6234:             .Top             = 416
6235:             .Left            = 509
6236:             .Width           = 42
6237:             .Height          = 42
6238:             .Caption         = ""
6239:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
6240:             .PicturePosition = 13
6241:             .ToolTipText     = "Inserir Arquivo"
6242:             .FontName        = "Tahoma"
6243:             .FontSize        = 8
6244:             .Themes          = .F.
6245:             .SpecialEffect   = 0
6246:             .BackColor       = RGB(255, 255, 255)
6247:             .Visible         = .T.
6248:         ENDWITH
6249:         BINDEVENT(loc_oPg.cmd_4c_BtnInsArqs, "Click", THIS, "BtnInsArqsClick")
6250: 
6251:         *-- ===================================================================
6252:         *-- COMMANDBUTTON cmd_4c_BtnExcArqs (btnExcArqs: top=458, left=509, w=42, h=42)
6253:         *-- When: InList(pcEscolha, INSERIR, ALTERAR)
6254:         *-- Click: Delete from cursor_4c_Arquivos
6255:         *-- ===================================================================
6256:         loc_oPg.AddObject("cmd_4c_BtnExcArqs", "CommandButton")
6257:         WITH loc_oPg.cmd_4c_BtnExcArqs
6258:             .Top             = 458
6259:             .Left            = 509
6260:             .Width           = 42
6261:             .Height          = 42
6262:             .Caption         = ""
6263:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
6264:             .PicturePosition = 13
6265:             .ToolTipText     = "Excluir Arquivo"
6266:             .FontName        = "Tahoma"
6267:             .FontSize        = 8
6268:             .Themes          = .F.
6269:             .SpecialEffect   = 0
6270:             .BackColor       = RGB(255, 255, 255)
6271:             .Visible         = .T.
6272:         ENDWITH
6273:         BINDEVENT(loc_oPg.cmd_4c_BtnExcArqs, "Click", THIS, "BtnExcArqsClick")
6274: 
6275:         *-- ===================================================================
6276:         *-- COMMANDBUTTON cmd_4c_BtnOpnArqs (btnOpnArqs: top=500, left=509, w=42, h=42)
6277:         *-- When: sempre habilitado (.T.)
6278:         *-- Click: Shell.Application.Open(arquivo)
6279:         *-- ===================================================================
6280:         loc_oPg.AddObject("cmd_4c_BtnOpnArqs", "CommandButton")
6281:         WITH loc_oPg.cmd_4c_BtnOpnArqs
6282:             .Top             = 500
6283:             .Left            = 509
6284:             .Width           = 42
6285:             .Height          = 42
6286:             .Caption         = ""
6287:             .Picture         = gc_4c_CaminhoIcones + "relatorio_visualizar_26.jpg"
6288:             .PicturePosition = 13
6289:             .ToolTipText     = "Abrir Arquivo"
6290:             .FontName        = "Tahoma"
6291:             .FontSize        = 8
6292:             .Themes          = .F.
6293:             .SpecialEffect   = 0
6294:             .BackColor       = RGB(255, 255, 255)
6295:             .Visible         = .T.
6296:         ENDWITH
6297:         BINDEVENT(loc_oPg.cmd_4c_BtnOpnArqs, "Click", THIS, "BtnOpnArqsClick")
6298: 
6299:         *-- ===================================================================
6300:         *-- SHAPE shp_4c_Shape1 (Shape1: top=415, left=584, w=407, h=202)
6301:         *-- Borda visual ao redor da area de preview de imagem
6302:         *-- ===================================================================
6303:         loc_oPg.AddObject("shp_4c_Shape1", "Shape")
6304:         WITH loc_oPg.shp_4c_Shape1
6305:             .Top         = 415
6306:             .Left        = 584
6307:             .Width       = 407
6308:             .Height      = 202
6309:             .BorderColor = RGB(128, 128, 128)
6310:             .BorderWidth = 1
6311:             .BackStyle   = 0
6312:             .Visible     = .T.
6313:         ENDWITH
6314: 
6315:         *-- ===================================================================
6316:         *-- IMAGE img_4c_ImgArqJpg (imgArqJpg: top=417, left=586, w=403, h=198)
6317:         *-- Visible=.F. por padrao; exibida ao selecionar arquivo JPG/ICO/BMP/JPEG
6318:         *-- Click: Do Form SigOpZom (zoom do arquivo)
6319:         *-- ===================================================================
6320:         loc_oPg.AddObject("img_4c_ImgArqJpg", "Image")
6321:         WITH loc_oPg.img_4c_ImgArqJpg
6322:             .Top     = 417
6323:             .Left    = 586
6324:             .Width   = 403
6325:             .Height  = 198
6326:             .Stretch = 2
6327:             .Visible = .F.
6328:         ENDWITH
6329:         BINDEVENT(loc_oPg.img_4c_ImgArqJpg, "Click", THIS, "ImgArqJpgClick")
6330: 
6331:     ENDPROC
6332: 
6333:     *--------------------------------------------------------------------------
6334:     * GrdDesignerAfterRowColChange - Handler AfterRowColChange do grd_4c_Designer
6335:     * Atualiza exibicao da observacao da tarefa selecionada
6336:     *--------------------------------------------------------------------------
6337:     PROCEDURE GrdDesignerAfterRowColChange(par_nColIndex)
6338:         LOCAL loc_oPg
6339:         TRY
6340:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
6341:             IF PEMSTATUS(loc_oPg, "obj_4c_GetObsTarefas", 5)
6342:                 loc_oPg.obj_4c_GetObsTarefas.Refresh()
6343:             ENDIF
6344:         CATCH TO loc_oErro
6345:             MsgErro(loc_oErro.Message, "Erro")
6346:         ENDTRY
6347:     ENDPROC
6348: 
6349:     *--------------------------------------------------------------------------
6350:     * DesignerCol4Valid - Valid do Column4 (Tarefa) do grd_4c_Designer
6351:     * Lookup: SigCdCad (CodCads, DesCads) - catalogo de tarefas designer
6352:     *--------------------------------------------------------------------------
6353:     PROCEDURE DesignerCol4Valid(par_nColIndex)
6354:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
6355:         loc_lResultado = .T.
6356:         TRY
6357:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer
6358:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column4.Text1.Value, ""))
6359:             IF EMPTY(loc_cCodigo)
6360:                 loc_lResultado = loc_lResultado
6361:             ENDIF
6362:             loc_lcSQL = "SELECT CodCads, DesCads FROM SigCdCad WHERE CodCads = " + EscaparSQL(loc_cCodigo)
6363:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTarefas") <= 0 OR EOF("cursor_4c_ValTarefas")
6364:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6365:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValCad"
6366:                 loc_oLookup.mAddColuna("CodCads", "", "C" + CHR(243) + "digo")
6367:                 loc_oLookup.mAddColuna("DesCads", "", "Descri" + CHR(231) + CHR(227) + "o")
6368:                 loc_oLookup.cTabela     = "SigCdCad"
6369:                 loc_oLookup.cCampoChave = "CodCads"
6370:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6371:                 loc_oLookup.Show()
6372:                 IF loc_oLookup.this_lSelecionou
6373:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6374:                 ELSE
6375:                     loc_cCodigo = ""
6376:                 ENDIF
6377:             ENDIF
6378:             IF USED("cursor_4c_ValTarefas")
6379:                 USE IN cursor_4c_ValTarefas
6380:             ENDIF
6381:             IF USED("cursor_4c_Tarefas") AND !EOF("cursor_4c_Tarefas")
6382:                 SELECT cursor_4c_Tarefas
6383:                 REPLACE Tarefas WITH PADR(loc_cCodigo, 10) IN cursor_4c_Tarefas
6384:                 loc_oGrd.Column4.Text1.Value = loc_cCodigo
6385:             ENDIF
6386:         CATCH TO loc_oErro
6387:             MsgErro(loc_oErro.Message, "Erro")
6388:         ENDTRY
6389:         RETURN loc_lResultado
6390:     ENDPROC
6391: 
6392:     *--------------------------------------------------------------------------
6393:     * GrdArquivosAfterRowColChange - Handler AfterRowColChange do grd_4c_Arquivos
6394:     * Exibe preview de imagem se arquivo for JPG/ICO/BMP/JPEG
6395:     *--------------------------------------------------------------------------
6396:     PROCEDURE GrdArquivosAfterRowColChange(par_nColIndex)
6397:         LOCAL loc_lcArq, loc_oPg, loc_nPonto
6398:         TRY
6399:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
6400:             CLEAR RESOURCES
6401:             loc_oPg.img_4c_ImgArqJpg.Picture = ""
6402:             loc_oPg.img_4c_ImgArqJpg.Visible = .F.
6403:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
6404:                 RETURN
6405:             ENDIF
6406:             loc_lcArq  = ALLTRIM(cursor_4c_Arquivos.Arquivos)
6407:             loc_nPonto = AT(".", loc_lcArq)
6408:             IF !EMPTY(loc_lcArq) AND loc_nPonto > 0 AND ;
6409:                 INLIST(ALLTRIM(UPPER(SUBSTR(loc_lcArq, loc_nPonto, 5))), ".JPG", ".ICO", ".BMP", ".JPEG")
6410:                 loc_oPg.img_4c_ImgArqJpg.Picture = loc_lcArq
6411:                 loc_oPg.img_4c_ImgArqJpg.Visible = .T.
6412:             ENDIF
6413:         CATCH TO loc_oErro
6414:             MsgErro(loc_oErro.Message, "Erro")
6415:         ENDTRY
6416:     ENDPROC
6417: 
6418:     *--------------------------------------------------------------------------
6419:     * BtnIniTarefaClick - Inicia nova tarefa no grd_4c_Designer
6420:     * Valida: sem tarefa aberta para o usuario + sem tarefa sem codigo
6421:     *--------------------------------------------------------------------------
6422:     PROCEDURE BtnIniTarefaClick()
6423:         LOCAL loc_lResultado, loc_oGrd, loc_tDataHora
6424:         loc_lResultado = .F.
6425:         TRY
6426:             IF !USED("cursor_4c_Tarefas")
6427:                 loc_lResultado = loc_lResultado
6428:             ENDIF
6429:             loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer
6430: 
6431:             *-- Validar: nao pode ter tarefa aberta (DtFims vazia) para este usuario
6432:             SELECT cursor_4c_Tarefas
6433:             GO TOP IN cursor_4c_Tarefas
6434:             LOCATE FOR ALLTRIM(Usuars) = ALLTRIM(gc_4c_UsuarioLogado) AND EMPTY(DtFims)
6435:             IF !EOF("cursor_4c_Tarefas")
6436:                 MsgAviso("Existe Uma Tarefa N" + CHR(227) + "o Encerrada Para Esse Usu" + CHR(225) + "rio!!!")
6437:                 loc_oGrd.Column4.SetFocus()
6438:                 loc_lResultado = loc_lResultado
6439:             ENDIF
6440: 
6441:             *-- Validar: nao pode ter tarefa com codigo vazio para este usuario
6442:             SELECT cursor_4c_Tarefas
6443:             GO TOP IN cursor_4c_Tarefas
6444:             LOCATE FOR ALLTRIM(Usuars) = ALLTRIM(gc_4c_UsuarioLogado) AND EMPTY(Tarefas)
6445:             IF !EOF("cursor_4c_Tarefas")
6446:                 MsgAviso("Existe Uma Tarefa Ainda N" + CHR(227) + "o Informada!!!")
6447:                 loc_oGrd.Column4.SetFocus()
6448:                 loc_lResultado = loc_lResultado
6449:             ENDIF
6450: 
6451:             *-- Inserir nova linha com DtInis = agora, DtFims = vazio ({})
6452:             loc_tDataHora = DATETIME()
6453:             INSERT INTO cursor_4c_Tarefas (DtInis, DtFims, Usuars, Tarefas, CPros, pkChaves) ;
6454:                 VALUES (loc_tDataHora, {}, ;
6455:                         PADR(gc_4c_UsuarioLogado, 10), PADR("", 10), ;
6456:                         PADR(THIS.this_oBusinessObject.this_cCpros, 14), "")
6457: 
6458:             SELECT cursor_4c_Tarefas
6459:             GO BOTTOM IN cursor_4c_Tarefas
6460:             loc_oGrd.Refresh()
6461:             loc_oGrd.Column4.SetFocus()
6462:             loc_lResultado = .T.
6463:         CATCH TO loc_oErro
6464:             MsgErro(loc_oErro.Message, "Erro")
6465:         ENDTRY
6466:         RETURN loc_lResultado
6467:     ENDPROC
6468: 
6469:     *--------------------------------------------------------------------------
6470:     * BtnFimTarefaClick - Finaliza tarefa corrente no grd_4c_Designer
6471:     * Valida: tarefa pertence ao usuario + nao esta ja finalizada
6472:     *--------------------------------------------------------------------------
6473:     PROCEDURE BtnFimTarefaClick()
6474:         LOCAL loc_lResultado, loc_oGrd, loc_tDataHora
6475:         loc_lResultado = .F.
6476:         TRY
6477:             IF !USED("cursor_4c_Tarefas") OR EOF("cursor_4c_Tarefas") OR BOF("cursor_4c_Tarefas")
6478:                 loc_lResultado = loc_lResultado
6479:             ENDIF
6480:             loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer
6481: 
6482:             *-- Validar: tarefa deve pertencer ao usuario logado
6483:             IF ALLTRIM(cursor_4c_Tarefas.Usuars) <> ALLTRIM(gc_4c_UsuarioLogado)
6484:                 MsgAviso("Essa Tarefa N" + CHR(227) + "o Pertence a Esse Usu" + CHR(225) + "rio!!!")
6485:                 loc_oGrd.Column4.SetFocus()
6486:                 loc_lResultado = loc_lResultado
6487:             ENDIF
6488: 
6489:             *-- Validar: tarefa nao pode estar ja finalizada
6490:             IF !EMPTY(cursor_4c_Tarefas.DtFims)
6491:                 MsgAviso("Essa Tarefa J" + CHR(225) + " Se Encontra Finalizada!!!")
6492:                 loc_oGrd.Column4.SetFocus()
6493:                 loc_lResultado = loc_lResultado
6494:             ENDIF
6495: 
6496:             *-- Registrar data/hora de finalizacao
6497:             loc_tDataHora = DATETIME()
6498:             SELECT cursor_4c_Tarefas
6499:             REPLACE DtFims WITH loc_tDataHora IN cursor_4c_Tarefas
6500: 
6501:             loc_oGrd.Refresh()
6502:             loc_lResultado = .T.
6503:         CATCH TO loc_oErro
6504:             MsgErro(loc_oErro.Message, "Erro")
6505:         ENDTRY
6506:         RETURN loc_lResultado
6507:     ENDPROC
6508: 
6509:     *--------------------------------------------------------------------------
6510:     * BtnInsArqsClick - Insere arquivo no grd_4c_Arquivos via dialog GetFile
6511:     *--------------------------------------------------------------------------
6512:     PROCEDURE BtnInsArqsClick()
6513:         LOCAL loc_lResultado, loc_lcArq, loc_oGrd
6514:         loc_lResultado = .F.
6515:         TRY
6516:             loc_oGrd  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos
6517:             loc_lcArq = GETFILE("", "Selecione o Arquivo", "Selecione o Arquivo", 0, ;
6518:                 "Sele" + CHR(231) + CHR(227) + "o de Arquivos")
6519:             IF !EMPTY(loc_lcArq)
6520:                 INSERT INTO cursor_4c_Arquivos (CPros, pkChaves, Arquivos) ;
6521:                     VALUES (PADR(THIS.this_oBusinessObject.this_cCpros, 14), "", UPPER(loc_lcArq))
6522:                 loc_oGrd.Refresh()
6523:             ENDIF
6524:             loc_lResultado = .T.
6525:         CATCH TO loc_oErro
6526:             MsgErro(loc_oErro.Message, "Erro")
6527:         ENDTRY
6528:         RETURN loc_lResultado
6529:     ENDPROC
6530: 
6531:     *--------------------------------------------------------------------------
6532:     * BtnOpnArqsClick - Abre arquivo selecionado no grd_4c_Arquivos com Shell
6533:     *--------------------------------------------------------------------------
6534:     PROCEDURE BtnOpnArqsClick()
6535:         LOCAL loc_lResultado, loc_lcArq, loc_oApp
6536:         loc_lResultado = .F.
6537:         TRY
6538:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
6539:                 loc_lResultado = loc_lResultado
6540:             ENDIF
6541:             loc_lcArq = ALLTRIM(cursor_4c_Arquivos.Arquivos)
6542:             IF !EMPTY(loc_lcArq) AND FILE(loc_lcArq)
6543:                 loc_oApp = CREATEOBJECT("Shell.Application")
6544:                 loc_oApp.Open(loc_lcArq)
6545:                 loc_lResultado = .T.
6546:             ELSE
6547:                 MsgAviso("Arquivo N" + CHR(227) + "o Encontrado!!!")
6548:             ENDIF
6549:         CATCH TO loc_oErro
6550:             MsgErro(loc_oErro.Message, "Erro")
6551:         ENDTRY
6552:         RETURN loc_lResultado
6553:     ENDPROC
6554: 
6555:     *--------------------------------------------------------------------------
6556:     * BtnExcArqsClick - Exclui arquivo selecionado do grd_4c_Arquivos
6557:     *--------------------------------------------------------------------------
6558:     PROCEDURE BtnExcArqsClick()
6559:         LOCAL loc_lResultado, loc_oGrd
6560:         loc_lResultado = .F.
6561:         TRY
6562:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos") OR BOF("cursor_4c_Arquivos")
6563:                 loc_lResultado = loc_lResultado
6564:             ENDIF
6565:             loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos
6566:             IF !EMPTY(cursor_4c_Arquivos.Arquivos)
6567:                 SELECT cursor_4c_Arquivos
6568:                 DELETE IN cursor_4c_Arquivos
6569:                 IF !EOF("cursor_4c_Arquivos")
6570:                     SKIP IN cursor_4c_Arquivos
6571:                 ENDIF
6572:                 IF EOF("cursor_4c_Arquivos")
6573:                     GO BOTTOM IN cursor_4c_Arquivos
6574:                 ENDIF
6575:                 PACK IN cursor_4c_Arquivos
6576:             ENDIF
6577:             loc_oGrd.Refresh()
6578:             loc_lResultado = .T.
6579:         CATCH TO loc_oErro
6580:             MsgErro(loc_oErro.Message, "Erro")
6581:         ENDTRY
6582:         RETURN loc_lResultado
6583:     ENDPROC
6584: 
6585:     *--------------------------------------------------------------------------
6586:     * ImgArqJpgClick - Abre visualizador de imagem em tela cheia (SigOpZom)
6587:     *--------------------------------------------------------------------------
6588:     PROCEDURE ImgArqJpgClick()
6589:         LOCAL loc_lResultado, loc_lcArq, loc_nPonto
6590:         loc_lResultado = .F.
6591:         TRY
6592:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
6593:                 loc_lResultado = loc_lResultado
6594:             ENDIF
6595:             loc_lcArq  = ALLTRIM(cursor_4c_Arquivos.Arquivos)
6596:             loc_nPonto = AT(".", loc_lcArq)
6597:             IF !EMPTY(loc_lcArq) AND FILE(loc_lcArq) AND loc_nPonto > 0 AND ;
6598:                 INLIST(ALLTRIM(UPPER(SUBSTR(loc_lcArq, loc_nPonto, 5))), ".JPG", ".ICO", ".BMP", ".JPEG")
6599:                 DO FORM SigOpZom WITH loc_lcArq, "Arquivo : " + loc_lcArq
6600:             ENDIF
6601:             loc_lResultado = .T.
6602:         CATCH TO loc_oErro
6603:             MsgErro(loc_oErro.Message, "Erro")
6604:         ENDTRY
6605:         RETURN loc_lResultado
6606:     ENDPROC
6607: 
6608:     *--------------------------------------------------------------------------
6609:     * GrdConsAfterRowColChange - Handler AfterRowColChange do grd_4c_GrdCons
6610:     *--------------------------------------------------------------------------
6611:     PROCEDURE GrdConsAfterRowColChange(par_nColIndex)
6612:         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
6613:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
6614:         ENDIF
6615:     ENDPROC
6616: 
6617:     *--------------------------------------------------------------------------
6618:     * GrdFaseAfterRowColChange - Handler AfterRowColChange do grd_4c_FasePro
6619:     * Carrega imagem FigProcs do campo memo na img_4c_ImgFigJpg
6620:     *--------------------------------------------------------------------------
6621:     PROCEDURE GrdFaseAfterRowColChange(par_nColIndex)
6622:         LOCAL loc_oPage, loc_lcArquivo
6623:         TRY
6624:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6625:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6626:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6627:                 CLEAR RESOURCES
6628:                 loc_oPage.img_4c_ImgFigJpg.Picture = ""
6629:                 loc_oPage.img_4c_ImgFigJpg.Visible = .F.
6630:                 IF !EMPTY(cursor_4c_Fase.FigProcs) AND !ISNULL(cursor_4c_Fase.FigProcs)
6631:                     IF STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo) > 0
6632:                         loc_oPage.img_4c_ImgFigJpg.Visible = .T.
6633:                         loc_oPage.img_4c_ImgFigJpg.Picture = loc_lcArquivo
6634:                     ENDIF
6635:                 ENDIF
6636:             ENDIF
6637:         CATCH TO loc_oErro
6638:             MsgErro(loc_oErro.Message, "Erro")
6639:         ENDTRY
6640:     ENDPROC
6641: 
6642:     *--------------------------------------------------------------------------
6643:     * GrdMatrizesAfterRowColChange - Handler AfterRowColChange do grd_4c_Matrizes
6644:     * Carrega imagem do produto matriz na img_4c_ImgBorracha via SQL
6645:     *--------------------------------------------------------------------------
6646:     PROCEDURE GrdMatrizesAfterRowColChange(par_nColIndex)
6647:         LOCAL loc_oPage, loc_lcArquivo, loc_lcSQL
6648:         TRY
6649:             IF USED("cursor_4c_Matrizes") AND !EOF("cursor_4c_Matrizes")
6650:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6651:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6652:                 CLEAR RESOURCES
6653:                 loc_oPage.img_4c_ImgBorracha.Picture = ""
6654:                 loc_oPage.img_4c_ImgBorracha.Visible = .F.
6655:                 IF !EMPTY(cursor_4c_Matrizes.CMats)
6656:                     loc_lcSQL = "SELECT FigProcs FROM SigCdPro WHERE CPros = '" + ;
6657:                         EscaparSQL(ALLTRIM(cursor_4c_Matrizes.CMats))
6658:                     IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_BorrachaImg") > 0
6659:                         IF !EOF("cursor_4c_BorrachaImg")
6660:                             IF !EMPTY(cursor_4c_BorrachaImg.FigProcs) AND !ISNULL(cursor_4c_BorrachaImg.FigProcs)
6661:                                 IF STRTOFILE(cursor_4c_BorrachaImg.FigProcs, loc_lcArquivo) > 0
6662:                                     loc_oPage.img_4c_ImgBorracha.Visible = .T.
6663:                                     loc_oPage.img_4c_ImgBorracha.Picture = loc_lcArquivo
6664:                                 ENDIF
6665:                             ENDIF
6666:                         ENDIF
6667:                         IF USED("cursor_4c_BorrachaImg")
6668:                             USE IN cursor_4c_BorrachaImg
6669:                         ENDIF
6670:                     ENDIF
6671:                 ENDIF
6672:                 loc_oPage.grd_4c_Matrizes.Refresh()
6673:             ENDIF
6674:         CATCH TO loc_oErro
6675:             MsgErro(loc_oErro.Message, "Erro")
6676:         ENDTRY
6677:     ENDPROC
6678: 
6679:     *--------------------------------------------------------------------------
6680:     * ImgFigJpgClick - Click na imagem -> amplia em zoom (SigOpZom)
6681:     *--------------------------------------------------------------------------
6682:     PROCEDURE ImgFigJpgClick()
6683:         LOCAL loc_lcArquivo
6684:         TRY
6685:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6686:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6687:                 IF !EMPTY(cursor_4c_Fase.FigProcs) AND !ISNULL(cursor_4c_Fase.FigProcs)
6688:                     STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo)
6689:                     IF FILE(loc_lcArquivo)
6690:                         DO FORM SigOpZom WITH loc_lcArquivo, .F.
6691:                     ENDIF
6692:                 ENDIF
6693:             ENDIF
6694:         CATCH TO loc_oErro
6695:             MsgErro(loc_oErro.Message, "Erro")
6696:         ENDTRY
6697:     ENDPROC
6698: 
6699:     *--------------------------------------------------------------------------
6700:     * CmdgFiguraClick - Seleciona foto do processo via GetPict
6701:     *--------------------------------------------------------------------------
6702:     PROCEDURE CmdgFiguraClick()
6703:         LOCAL loc_lcFigura, loc_lcArquivo, loc_oPage
6704:         TRY
6705:             IF !USED("cursor_4c_Fase") OR EOF("cursor_4c_Fase")
6706:                 RETURN
6707:             ENDIF
6708:             IF THIS.this_cModoAtual = "VISUALIZAR"
6709:                 RETURN
6710:             ENDIF
6711:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6712:             loc_oPage.grd_4c_FasePro.SetFocus()
6713:             loc_lcFigura = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Nome do Arquivo:", "Selecionar")
6714:             IF !EMPTY(loc_lcFigura)
6715:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6716:                 CLEAR RESOURCES
6717:                 SELECT cursor_4c_Fase
6718:                 REPLACE FigProcs WITH FILETOSTR(loc_lcFigura) IN cursor_4c_Fase
6719:                 IF STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo) > 0
6720:                     loc_oPage.img_4c_ImgFigJpg.Visible = .T.
6721:                     loc_oPage.img_4c_ImgFigJpg.Picture = loc_lcArquivo
6722:                 ENDIF
6723:             ENDIF
6724:         CATCH TO loc_oErro
6725:             MsgErro(loc_oErro.Message, "Erro")
6726:         ENDTRY
6727:     ENDPROC
6728: 
6729:     *--------------------------------------------------------------------------
6730:     * CmdgFigCamClick - Captura foto via camera (reutiliza logica de GetPict)
6731:     *--------------------------------------------------------------------------
6732:     PROCEDURE CmdgFigCamClick()
6733:         THIS.CmdgFiguraClick()
6734:     ENDPROC
6735: 
6736:     *--------------------------------------------------------------------------
6737:     * FaseInserirClick - Insere nova linha no grd_4c_FasePro
6738:     *--------------------------------------------------------------------------
6739:     PROCEDURE FaseInserirClick()
6740:         LOCAL loc_lResultado, loc_nOrdem, loc_oPage
6741:         loc_lResultado = .F.
6742:         TRY
6743:             IF !USED("cursor_4c_Fase")
6744:                 loc_lResultado = loc_lResultado
6745:             ENDIF
6746:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6747:             SELECT cursor_4c_Fase
6748:             IF !EOF("cursor_4c_Fase")
6749:                 IF EMPTY(cursor_4c_Fase.Grupos)
6750:                     loc_oPage.grd_4c_FasePro.SetFocus()
6751:                     loc_lResultado = loc_lResultado
6752:                 ENDIF
6753:                 loc_nOrdem = cursor_4c_Fase.Ordems
6754:             ELSE
6755:                 loc_nOrdem = 0
6756:             ENDIF
6757:             *-- Incrementa ordens dos registros apos o atual
6758:             SELECT cursor_4c_Fase
6759:             SCAN FOR Ordems > loc_nOrdem
6760:                 REPLACE Ordems WITH cursor_4c_Fase.Ordems + 1 IN cursor_4c_Fase
6761:             ENDSCAN
6762:             *-- Insere nova linha com ordem logo apos o atual
6763:             INSERT INTO cursor_4c_Fase (Ordems, Grupos, Descrs, UniPrdts, TpMats, FkChaves) ;
6764:                 VALUES (loc_nOrdem + 1, "", "", "", "", "")
6765:             GO TOP IN cursor_4c_Fase
6766:             LOCATE FOR Ordems = loc_nOrdem + 1 AND EMPTY(Grupos)
6767:             loc_oPage.grd_4c_FasePro.Refresh()
6768:             loc_oPage.grd_4c_FasePro.SetFocus()
6769:             loc_lResultado = .T.
6770:         CATCH TO loc_oErro
6771:             MsgErro(loc_oErro.Message, "Erro")
6772:         ENDTRY
6773:         RETURN loc_lResultado
6774:     ENDPROC
6775: 
6776:     *--------------------------------------------------------------------------
6777:     * FaseExcluirClick - Exclui linha atual do grd_4c_FasePro
6778:     *--------------------------------------------------------------------------
6779:     PROCEDURE FaseExcluirClick()
6780:         LOCAL loc_lResultado, loc_oPage
6781:         loc_lResultado = .F.
6782:         TRY
6783:             IF !USED("cursor_4c_Fase") OR EOF("cursor_4c_Fase") OR BOF("cursor_4c_Fase")
6784:                 loc_lResultado = loc_lResultado
6785:             ENDIF
6786:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6787:             SELECT cursor_4c_Fase
6788:             DELETE IN cursor_4c_Fase
6789:             IF !EOF("cursor_4c_Fase")
6790:                 SKIP IN cursor_4c_Fase
6791:             ENDIF
6792:             IF EOF("cursor_4c_Fase")
6793:                 GO BOTTOM IN cursor_4c_Fase
6794:             ENDIF
6795:             PACK IN cursor_4c_Fase
6796:             loc_oPage.grd_4c_FasePro.Refresh()
6797:             loc_oPage.grd_4c_FasePro.SetFocus()
6798:             loc_oPage.grd_4c_FasePro.Column2.SetFocus()
6799:             loc_lResultado = .T.
6800:         CATCH TO loc_oErro
6801:             MsgErro(loc_oErro.Message, "Erro")
6802:         ENDTRY
6803:         RETURN loc_lResultado
6804:     ENDPROC
6805: 
6806:     *--------------------------------------------------------------------------
6807:     * FaseAlternativaClick - Insere fase alternativa (mesma ordem do atual)
6808:     *--------------------------------------------------------------------------
6809:     PROCEDURE FaseAlternativaClick()
6810:         LOCAL loc_lResultado, loc_nOrdem, loc_oPage
6811:         loc_lResultado = .F.
6812:         TRY
6813:             IF !USED("cursor_4c_Fase")
6814:                 loc_lResultado = loc_lResultado
6815:             ENDIF
6816:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6817:             SELECT cursor_4c_Fase
6818:             IF EOF("cursor_4c_Fase") OR BOF("cursor_4c_Fase")
6819:                 loc_oPage.grd_4c_FasePro.SetFocus()
6820:                 loc_lResultado = loc_lResultado
6821:             ENDIF
6822:             loc_nOrdem = cursor_4c_Fase.Ordems
6823:             *-- Insere linha alternativa com mesma ordem (alternativa ao atual)
6824:             INSERT INTO cursor_4c_Fase (Ordems, Grupos, Descrs, UniPrdts, TpMats, FkChaves) ;
6825:                 VALUES (loc_nOrdem, "", "", "", "", "")
6826:             GO TOP IN cursor_4c_Fase
6827:             LOCATE FOR Ordems = loc_nOrdem AND EMPTY(Grupos)
6828:             loc_oPage.grd_4c_FasePro.Refresh()
6829:             loc_oPage.grd_4c_FasePro.SetFocus()
6830:             loc_lResultado = .T.
6831:         CATCH TO loc_oErro
6832:             MsgErro(loc_oErro.Message, "Erro")
6833:         ENDTRY
6834:         RETURN loc_lResultado
6835:     ENDPROC
6836: 
6837:     *--------------------------------------------------------------------------
6838:     * CmdFichaClick - Abre Ficha Tecnica do produto
6839:     *--------------------------------------------------------------------------
6840:     PROCEDURE CmdFichaClick()
6841:         LOCAL loc_lResultado
6842:         loc_lResultado = .F.
6843:         TRY
6844:             MsgAviso("Ficha T" + CHR(233) + "cnica n" + CHR(227) + "o dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", ;
6845:                 "Ficha T" + CHR(233) + "cnica")
6846:         CATCH TO loc_oErro
6847:             MsgErro(loc_oErro.Message, "Erro")
6848:         ENDTRY
6849:         RETURN loc_lResultado
6850:     ENDPROC
6851: 
6852:     *--------------------------------------------------------------------------
6853:     * FaseGrdCol2Valid - Valid do Column2 (Fase/Grupos) do grd_4c_FasePro
6854:     * Lookup: SigCdGcr (Codigos / Descrs)
6855:     *--------------------------------------------------------------------------
6856:     PROCEDURE FaseGrdCol2Valid(par_nColIndex)
6857:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_cDescr, loc_lcSQL
6858:         loc_lResultado = .T.
6859:         TRY
6860:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
6861:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column2.Text1.Value, ""))
6862:             IF EMPTY(loc_cCodigo)
6863:                 loc_lResultado = loc_lResultado
6864:             ENDIF
6865:             loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
6866:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGcr") <= 0 OR EOF("cursor_4c_ValGcr")
6867:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6868:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValGcr"
6869:                 loc_oLookup.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
6870:                 loc_oLookup.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
6871:                 loc_oLookup.cTabela     = "SigCdGcr"
6872:                 loc_oLookup.cCampoChave = "Codigos"
6873:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6874:                 loc_oLookup.Show()
6875:                 IF loc_oLookup.this_lSelecionou
6876:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6877:                     loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
6878:                     IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGcr") > 0 AND !EOF("cursor_4c_ValGcr")
6879:                         loc_cDescr = ALLTRIM(NVL(cursor_4c_ValGcr.Descrs, ""))
6880:                     ELSE
6881:                         loc_cDescr = ""
6882:                     ENDIF
6883:                 ELSE
6884:                     loc_cCodigo = ""
6885:                     loc_cDescr  = ""
6886:                 ENDIF
6887:                 IF USED("cursor_4c_ValGcr")
6888:                     USE IN cursor_4c_ValGcr
6889:                 ENDIF
6890:             ELSE
6891:                 loc_cDescr = ALLTRIM(NVL(cursor_4c_ValGcr.Descrs, ""))
6892:                 IF USED("cursor_4c_ValGcr")
6893:                     USE IN cursor_4c_ValGcr
6894:                 ENDIF
6895:             ENDIF
6896:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6897:                 SELECT cursor_4c_Fase
6898:                 REPLACE Grupos WITH PADR(loc_cCodigo, 10) IN cursor_4c_Fase
6899:                 REPLACE Descrs WITH PADR(loc_cDescr,  40) IN cursor_4c_Fase
6900:                 loc_oGrd.Column2.Text1.Value = loc_cCodigo
6901:                 loc_oGrd.Column3.Text1.Value = loc_cDescr
6902:             ENDIF
6903:         CATCH TO loc_oErro
6904:             MsgErro(loc_oErro.Message, "Erro")
6905:         ENDTRY
6906:         RETURN loc_lResultado
6907:     ENDPROC
6908: 
6909:     *--------------------------------------------------------------------------
6910:     * FaseGrdCol4Valid - Valid do Column4 (Uni. Produtiva/UniPrdts) do grd_4c_FasePro
6911:     * Lookup: SigCdUpd (UniPrdts) filtrado pelo Grupo atual
6912:     *--------------------------------------------------------------------------
6913:     PROCEDURE FaseGrdCol4Valid(par_nColIndex)
6914:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_cGrupo, loc_lcSQL
6915:         loc_lResultado = .T.
6916:         TRY
6917:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
6918:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column4.Text1.Value, ""))
6919:             IF EMPTY(loc_cCodigo)
6920:                 loc_lResultado = loc_lResultado
6921:             ENDIF
6922:             loc_cGrupo = ""
6923:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6924:                 loc_cGrupo = ALLTRIM(cursor_4c_Fase.Grupos)
6925:             ENDIF
6926:             IF !EMPTY(loc_cGrupo)
6927:                 loc_lcSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupo)
6928:             ELSE
6929:                 loc_lcSQL = "SELECT UniPrdts FROM SigCdUpd"
6930:             ENDIF
6931:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValUpd") <= 0
6932:                 IF USED("cursor_4c_ValUpd")
6933:                     USE IN cursor_4c_ValUpd
6934:                 ENDIF
6935:                 loc_lResultado = loc_lResultado
6936:             ENDIF
6937:             SELECT cursor_4c_ValUpd
6938:             LOCATE FOR ALLTRIM(UniPrdts) = loc_cCodigo
6939:             IF EOF("cursor_4c_ValUpd")
6940:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6941:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValUpd"
6942:                 loc_oLookup.mAddColuna("UniPrdts", "", "Uni. Produtiva")
6943:                 loc_oLookup.cTabela     = "SigCdUpd"
6944:                 loc_oLookup.cCampoChave = "UniPrdts"
6945:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6946:                 loc_oLookup.Show()
6947:                 IF loc_oLookup.this_lSelecionou
6948:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6949:                 ELSE
6950:                     loc_cCodigo = ""
6951:                 ENDIF
6952:             ENDIF
6953:             IF USED("cursor_4c_ValUpd")
6954:                 USE IN cursor_4c_ValUpd
6955:             ENDIF
6956:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6957:                 SELECT cursor_4c_Fase
6958:                 REPLACE UniPrdts WITH PADR(loc_cCodigo, 10) IN cursor_4c_Fase
6959:                 loc_oGrd.Column4.Text1.Value = loc_cCodigo
6960:             ENDIF
6961:         CATCH TO loc_oErro
6962:             MsgErro(loc_oErro.Message, "Erro")
6963:         ENDTRY
6964:         RETURN loc_lResultado
6965:     ENDPROC
6966: 
6967:     *--------------------------------------------------------------------------
6968:     * FaseGrdCol5Valid - Valid do Column5 (Material/TpMats) do grd_4c_FasePro
6969:     * Lookup: SigOpOpt (Cods / Descs)
6970:     *--------------------------------------------------------------------------
6971:     PROCEDURE FaseGrdCol5Valid(par_nColIndex)
6972:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
6973:         loc_lResultado = .T.
6974:         TRY
6975:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
6976:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column5.Text1.Value, ""))
6977:             IF EMPTY(loc_cCodigo)
6978:                 loc_lResultado = loc_lResultado
6979:             ENDIF
6980:             loc_lcSQL = "SELECT Cods, Descs FROM SigOpOpt WHERE Cods = " + EscaparSQL(loc_cCodigo)
6981:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOpt") <= 0 OR EOF("cursor_4c_ValOpt")
6982:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6983:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValOpt"
6984:                 loc_oLookup.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
6985:                 loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
6986:                 loc_oLookup.cTabela     = "SigOpOpt"
6987:                 loc_oLookup.cCampoChave = "Cods"
6988:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6989:                 loc_oLookup.Show()
6990:                 IF loc_oLookup.this_lSelecionou
6991:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6992:                 ELSE
6993:                     loc_cCodigo = ""
6994:                 ENDIF
6995:             ENDIF
6996:             IF USED("cursor_4c_ValOpt")
6997:                 USE IN cursor_4c_ValOpt
6998:             ENDIF
6999:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
7000:                 SELECT cursor_4c_Fase
7001:                 REPLACE TpMats WITH PADR(loc_cCodigo, 3) IN cursor_4c_Fase
7002:                 loc_oGrd.Column5.Text1.Value = loc_cCodigo
7003:             ENDIF
7004:             loc_oGrd.Refresh()
7005:         CATCH TO loc_oErro
7006:             MsgErro(loc_oErro.Message, "Erro")
7007:         ENDTRY
7008:         RETURN loc_lResultado
7009:     ENDPROC
7010: 
7011:     *--------------------------------------------------------------------------
7012:     * ValidarAcabamento - LostFocus do txt_4c_CodAcb
7013:     * Lookup: SigCdAca (Cods / Descrs) -> preenche txt_4c_Dacb
7014:     *--------------------------------------------------------------------------
7015:     PROCEDURE ValidarAcabamento()
7016:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_cDescr, loc_lcSQL
7017:         loc_lResultado = .T.
7018:         TRY
7019:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7020:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_CodAcb.Value, ""))
7021:             IF loc_cCodigo == THIS.this_cUltimoAcabamentoValidado
7022:                 loc_lResultado = loc_lResultado
7023:             ENDIF
7024:             IF EMPTY(loc_cCodigo)
7025:                 loc_oPage.txt_4c_Dacb.Value = ""
7026:                 loc_lResultado = loc_lResultado
7027:             ENDIF
7028:             loc_lcSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Cods = " + EscaparSQL(loc_cCodigo)
7029:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAca") <= 0 OR EOF("cursor_4c_ValAca")
7030:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7031:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValAca"
7032:                 loc_oLookup.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
7033:                 loc_oLookup.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7034:                 loc_oLookup.cTabela     = "SigCdAca"
7035:                 loc_oLookup.cCampoChave = "Cods"
7036:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7037:                 loc_oLookup.Show()
7038:                 IF loc_oLookup.this_lSelecionou
7039:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7040:                     loc_lcSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Cods = " + EscaparSQL(loc_cCodigo)
7041:                     IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAca") > 0 AND !EOF("cursor_4c_ValAca")
7042:                         loc_cDescr = ALLTRIM(NVL(cursor_4c_ValAca.Descrs, ""))
7043:                     ELSE
7044:                         loc_cDescr = ""
7045:                     ENDIF
7046:                 ELSE
7047:                     loc_cCodigo = ""
7048:                     loc_cDescr  = ""
7049:                 ENDIF
7050:             ELSE
7051:                 loc_cDescr = ALLTRIM(NVL(cursor_4c_ValAca.Descrs, ""))
7052:             ENDIF
7053:             IF USED("cursor_4c_ValAca")
7054:                 USE IN cursor_4c_ValAca
7055:             ENDIF
7056:             loc_oPage.txt_4c_CodAcb.Value = loc_cCodigo
7057:             loc_oPage.txt_4c_Dacb.Value   = loc_cDescr
7058:             THIS.this_cUltimoAcabamentoValidado = loc_cCodigo
7059:             loc_oPage.Refresh()
7060:         CATCH TO loc_oErro
7061:             MsgErro(loc_oErro.Message, "Erro")
7062:         ENDTRY
7063:         RETURN loc_lResultado
7064:     ENDPROC
7065: 
7066:     *--------------------------------------------------------------------------
7067:     * ValidarConquilha - LostFocus do txt_4c_Conquilha
7068:     * Lookup: SigCdCnq (conquilhas)
7069:     *--------------------------------------------------------------------------
7070:     PROCEDURE ValidarConquilha()
7071:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cValor, loc_lcSQL
7072:         LOCAL loc_cValorAtual
7073:         loc_lResultado = .T.
7074:         loc_cValorAtual = ""
7075:         TRY
7076:             loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7077:             loc_cValor = ALLTRIM(NVL(loc_oPage.txt_4c_Conquilha.Value, ""))
7078:             loc_cValorAtual = loc_cValor
7079:             IF loc_cValorAtual == THIS.this_cUltimoConquilhaValidado
7080:                 loc_lResultado = loc_lResultado
7081:             ENDIF
7082:             IF EMPTY(loc_cValor)
7083:                 loc_lResultado = loc_lResultado
7084:             ENDIF
7085:             loc_lcSQL = "SELECT conquilhas FROM SigCdCnq GROUP BY conquilhas"
7086:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCnq") > 0
7087:                 SELECT cursor_4c_ValCnq
7088:                 LOCATE FOR ALLTRIM(conquilhas) = loc_cValor
7089:                 IF EOF("cursor_4c_ValCnq")
7090:                     loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7091:                     loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaConq"
7092:                     loc_oLookup.mAddColuna("conquilhas", "", "Conquilhas")
7093:                     loc_oLookup.cTabela     = "SigCdCnq"
7094:                     loc_oLookup.cCampoChave = "conquilhas"
7095:                     loc_oLookup.cFiltroIni  = loc_cValor
7096:                     loc_oLookup.Show()
7097:                     IF loc_oLookup.this_lSelecionou
7098:                         loc_cValor = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7099:                     ELSE
7100:                         loc_cValor = ""
7101:                     ENDIF
7102:                 ENDIF
7103:                 IF USED("cursor_4c_ValCnq")
7104:                     USE IN cursor_4c_ValCnq
7105:                 ENDIF
7106:             ENDIF
7107:             loc_oPage.txt_4c_Conquilha.Value = loc_cValor
7108:             THIS.this_cUltimoConquilhaValidado = loc_cValor
7109:             loc_oPage.Refresh()
7110:         CATCH TO loc_oErro
7111:             MsgErro(loc_oErro.Message, "Erro")
7112:         ENDTRY
7113:         RETURN loc_lResultado
7114:     ENDPROC
7115: 
7116:     *--------------------------------------------------------------------------
7117:     * ValidarCor - LostFocus do txt_4c_Cor
7118:     * Lookup: SigCdCor (Cods / Descs)
7119:     *--------------------------------------------------------------------------
7120:     PROCEDURE ValidarCor()
7121:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
7122:         loc_lResultado = .T.
7123:         TRY
7124:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7125:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Cor.Value, ""))
7126:             IF loc_cCodigo == THIS.this_cUltimoCorValidado
7127:                 loc_lResultado = loc_lResultado
7128:             ENDIF
7129:             IF EMPTY(loc_cCodigo)
7130:                 loc_lResultado = loc_lResultado
7131:             ENDIF
7132:             loc_lcSQL = "SELECT Cods FROM SigCdCor WHERE Cods = " + EscaparSQL(loc_cCodigo)
7133:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCor") <= 0 OR EOF("cursor_4c_ValCor")
7134:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7135:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValCor"
7136:                 loc_oLookup.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
7137:                 loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7138:                 loc_oLookup.cTabela     = "SigCdCor"
7139:                 loc_oLookup.cCampoChave = "Cods"
7140:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7141:                 loc_oLookup.Show()
7142:                 IF loc_oLookup.this_lSelecionou
7143:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7144:                 ELSE
7145:                     loc_cCodigo = ""
7146:                 ENDIF
7147:             ENDIF
7148:             IF USED("cursor_4c_ValCor")
7149:                 USE IN cursor_4c_ValCor
7150:             ENDIF
7151:             loc_oPage.txt_4c_Cor.Value = loc_cCodigo
7152:             loc_oPage.txt_4c_Cor.Refresh()
7153:             THIS.this_cUltimoCorValidado = loc_cCodigo
7154:             loc_oPage.Refresh()
7155:         CATCH TO loc_oErro
7156:             MsgErro(loc_oErro.Message, "Erro")
7157:         ENDTRY
7158:         RETURN loc_lResultado
7159:     ENDPROC
7160: 
7161:     *--------------------------------------------------------------------------
7162:     * ValidarTam - LostFocus do txt_4c_Tam
7163:     * Lookup: SigCdTam (Cods / Descs)
7164:     *--------------------------------------------------------------------------
7165:     PROCEDURE ValidarTam()
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
7199:             loc_oPage.Refresh()
7200:         CATCH TO loc_oErro
7201:             MsgErro(loc_oErro.Message, "Erro")
7202:         ENDTRY
7203:         RETURN loc_lResultado
7204:     ENDPROC
7205: 
7206:     *--------------------------------------------------------------------------
7207:     * BtnInsereMtxClick - Insere nova linha no grd_4c_Matrizes
7208:     *--------------------------------------------------------------------------
7209:     PROCEDURE BtnInsereMtxClick()
7210:         LOCAL loc_lResultado, loc_oPage
7211:         loc_lResultado = .F.
7212:         TRY
7213:             IF !USED("cursor_4c_Matrizes")
7214:                 loc_lResultado = loc_lResultado
7215:             ENDIF
7216:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7217:             SELECT cursor_4c_Matrizes
7218:             *-- Localiza linha vazia (placeholder); se nao houver, insere uma nova
7219:             GO TOP IN cursor_4c_Matrizes
7220:             LOCATE FOR EMPTY(cursor_4c_Matrizes.CMats)
7221:             IF EOF("cursor_4c_Matrizes")
7222:                 INSERT INTO cursor_4c_Matrizes (CMats, Locals, QMatz, CPros, cIdChaves, DPros) ;
7223:                     VALUES ("", "", 0, "", "", "")
7224:             ENDIF
7225:             loc_oPage.grd_4c_Matrizes.Refresh()
7226:             loc_oPage.grd_4c_Matrizes.SetFocus()
7227:             loc_oPage.grd_4c_Matrizes.Column1.SetFocus()
7228:             loc_lResultado = .T.
7229:         CATCH TO loc_oErro
7230:             MsgErro(loc_oErro.Message, "Erro")
7231:         ENDTRY
7232:         RETURN loc_lResultado
7233:     ENDPROC
7234: 
7235:     *--------------------------------------------------------------------------
7236:     * BtnExcluiMtzClick - Exclui linha atual do grd_4c_Matrizes
7237:     * Garante sempre ao menos uma linha vazia no cursor
7238:     *--------------------------------------------------------------------------
7239:     PROCEDURE BtnExcluiMtzClick()
7240:         LOCAL loc_lResultado, loc_oPage
7241:         loc_lResultado = .F.
7242:         TRY
7243:             IF !USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes")
7244:                 loc_lResultado = loc_lResultado
7245:             ENDIF
7246:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7247:             SELECT cursor_4c_Matrizes
7248:             DELETE IN cursor_4c_Matrizes
7249:             PACK IN cursor_4c_Matrizes
7250:             *-- Garante sempre ao menos uma linha vazia
7251:             GO TOP IN cursor_4c_Matrizes
7252:             LOCATE FOR EMPTY(cursor_4c_Matrizes.CMats)
7253:             IF EOF("cursor_4c_Matrizes")
7254:                 INSERT INTO cursor_4c_Matrizes (CMats, Locals, QMatz, CPros, cIdChaves, DPros) ;
7255:                     VALUES ("", "", 0, "", "", "")
7256:             ENDIF
7257:             loc_oPage.grd_4c_Matrizes.Refresh()
7258:             loc_oPage.grd_4c_Matrizes.SetFocus()
7259:             loc_oPage.grd_4c_Matrizes.Column1.SetFocus()
7260:             loc_lResultado = .T.
7261:         CATCH TO loc_oErro
7262:             MsgErro(loc_oErro.Message, "Erro")
7263:         ENDTRY
7264:         RETURN loc_lResultado
7265:     ENDPROC
7266: 
7267:     *--------------------------------------------------------------------------
7268:     * MatrizGrdCol1Valid - Valid do Column1 (Matriz/CMats) do grd_4c_Matrizes
7269:     * Lookup: SigCdPro (CPros / DPros) - produto usado como matriz
7270:     *--------------------------------------------------------------------------
7271:     PROCEDURE MatrizGrdCol1Valid(par_nColIndex)
7272:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
7273:         loc_lResultado = .T.
7274:         TRY
7275:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_Matrizes
7276:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column1.Text1.Value, ""))
7277:             IF EMPTY(loc_cCodigo)
7278:                 loc_lResultado = loc_lResultado
7279:             ENDIF
7280:             loc_lcSQL = "SELECT CPros, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCodigo)
7281:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValMtz") <= 0 OR EOF("cursor_4c_ValMtz")
7282:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7283:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValMtz"
7284:                 loc_oLookup.mAddColuna("CPros", "", "Matriz")
7285:                 loc_oLookup.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
7286:                 loc_oLookup.cTabela     = "SigCdPro"
7287:                 loc_oLookup.cCampoChave = "CPros"
7288:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7289:                 loc_oLookup.Show()
7290:                 IF loc_oLookup.this_lSelecionou
7291:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7292:                 ELSE
7293:                     loc_cCodigo = ""
7294:                 ENDIF
7295:             ENDIF
7296:             IF USED("cursor_4c_ValMtz")
7297:                 USE IN cursor_4c_ValMtz
7298:             ENDIF
7299:             IF USED("cursor_4c_Matrizes") AND !EOF("cursor_4c_Matrizes")
7300:                 SELECT cursor_4c_Matrizes
7301:                 REPLACE CMats WITH PADR(loc_cCodigo, 14) IN cursor_4c_Matrizes
7302:                 loc_oGrd.Column1.Text1.Value = loc_cCodigo
7303:                 loc_oGrd.Refresh()
7304:             ENDIF
7305:         CATCH TO loc_oErro
7306:             MsgErro(loc_oErro.Message, "Erro")
7307:         ENDTRY
7308:         RETURN loc_lResultado
7309:     ENDPROC
7310: 
7311:     *--------------------------------------------------------------------------
7312:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
7313:     * par_oContainer: container a processar (Page1, Page2, etc.)
7314:     *--------------------------------------------------------------------------
7315:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
7316:         LOCAL loc_nI, loc_oObjeto, loc_nP
7317: 
7318:         FOR loc_nI = 1 TO par_oContainer.ControlCount
7319:             loc_oObjeto = par_oContainer.Controls(loc_nI)
7320: 
7321:             IF VARTYPE(loc_oObjeto) = "O"
7322:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
7323:                     *-- Nao forcar visivel containers ocultos intencionais
7324:                     IF NOT INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")
7325:                         loc_oObjeto.Visible = .T.
7326:                     ENDIF
7327:                 ENDIF
7328: 
7329:                 *-- Itera Pages de PageFrame
7330:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
7331:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
7332:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
7333:                     ENDFOR
7334:                 ENDIF
7335: 
7336:                 *-- Itera containers com ControlCount
7337:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
7338:                     THIS.TornarControlesVisiveis(loc_oObjeto)
7339:                 ENDIF
7340:             ENDIF
7341:         ENDFOR
7342:     ENDPROC
7343: 
7344:     *--------------------------------------------------------------------------
7345:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
7346:     *--------------------------------------------------------------------------
7347:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
7348:         THIS.pgf_4c_Paginas.Visible   = .T.
7349:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
7350: 
7351:         IF par_nPagina = 1
7352:             THIS.AjustarBotoesPorModo()
7353:             THIS.CarregarLista()
7354:         ENDIF
7355:     ENDPROC
7356: 
7357:     *--------------------------------------------------------------------------
7358:     * CarregarLista - Busca registros do SigPrFtp com JOIN SigCdPro
7359:     *--------------------------------------------------------------------------
7360:     PROCEDURE CarregarLista()
7361:         LOCAL loc_lResultado, loc_cSQL, loc_cWhere
7362:         loc_lResultado = .F.
7363: 
7364:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
7365:             RETURN loc_lResultado
7366:         ENDIF
7367: 
7368:         TRY
7369:             loc_cWhere = THIS.MontarFiltro()
7370: 
7371:             loc_cSQL = "SELECT t.pkchaves, t.cpros, " + ;
7372:                 "ISNULL(p.dpros,'') AS dpros, " + ;
7373:                 "t.cgrus, t.cods, " + ;
7374:                 "ISNULL(p.reffs,'') AS reffs, " + ;
7375:                 "ISNULL(p.usuincs,'') AS usuincs, " + ;
7376:                 "ISNULL(p.situas,0) AS situas " + ;
7377:                 "FROM sigprftp t " + ;
7378:                 "LEFT JOIN SigCdPro p ON p.cpros = t.cpros "
7379: 
7380:             IF !EMPTY(loc_cWhere)
7381:                 loc_cSQL = loc_cSQL + "WHERE " + loc_cWhere + " "
7382:             ENDIF
7383: 
7384:             loc_cSQL = loc_cSQL + "ORDER BY t.cpros"
7385: 
7386:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp") > 0
7387:                 LOCAL loc_oGrd
7388:                 loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
7389: 
7390:                 IF !USED("cursor_4c_Dados")
7391:                     SET NULL ON
7392:                     CREATE CURSOR cursor_4c_Dados (pkchaves C(20), cpros C(14), dpros C(40), cgrus C(3), cods C(2), reffs C(20), usuincs C(10), situas N(1,0))
7393:                     SET NULL OFF
7394:                 ELSE
7395:                     ZAP IN cursor_4c_Dados
7396:                 ENDIF
7397:                 IF !EOF("cursor_4c_DadosTemp")
7398:                     SELECT cursor_4c_DadosTemp
7399:                     APPEND FROM DBF("cursor_4c_DadosTemp")
7400:                 ENDIF

*-- Linhas 7500 a 7607:
7500:     * FormatarGridLista - Formata visual do grid (FontName/Size)
7501:     * RecordSource + ControlSource ja definidos em CarregarLista
7502:     *--------------------------------------------------------------------------
7503:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
7504:         WITH par_oGrid
7505:             IF .ColumnCount > 0
7506:                 .FontName = "Arial"
7507:                 .FontSize = 8
7508:             ENDIF
7509:         ENDWITH
7510:     ENDPROC
7511: 
7512:     *--------------------------------------------------------------------------
7513:     * AtualizarContagemProdutos - Atualiza label de contagem
7514:     *--------------------------------------------------------------------------
7515:     PROTECTED PROCEDURE AtualizarContagemProdutos()
7516:         LOCAL loc_nTotal
7517:         loc_nTotal = 0
7518: 
7519:         TRY
7520:             IF USED("cursor_4c_Dados")
7521:                 loc_nTotal = RECCOUNT("cursor_4c_Dados")
7522:             ENDIF
7523:             THIS.pgf_4c_Paginas.Page1.lbl_4c_Produtos.Caption = ;
7524:                 "Produtos Selecionados : " + TRANSFORM(loc_nTotal)
7525:         CATCH TO loc_oErro
7526:             MsgErro(loc_oErro.Message, "Erro ao atualizar contagem")
7527:         ENDTRY
7528:     ENDPROC
7529: 
7530:     *--------------------------------------------------------------------------
7531:     * FormParaBO - Transfere dados do formulario para o BO
7532:     * Fase 5: cpros/cgrus/cods mapeados para SigPrFtp
7533:     * Campos SigCdPro (DPro2s, Cbar, Lin, Col, Ifor, Refs) serao
7534:     * persistidos em fase futura (Phase 7) via SQL direto em SigCdPro
7535:     *--------------------------------------------------------------------------
7536:     PROTECTED PROCEDURE FormParaBO()
7537:         LOCAL loc_oPg
7538:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7539: 
7540:         THIS.this_oBusinessObject.this_cCpros = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
7541:         THIS.this_oBusinessObject.this_cCgrus = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
7542:         THIS.this_oBusinessObject.this_cCods  = ALLTRIM(loc_oPg.txt_4c_Cods.Value)
7543:         *-- coefs/valors: sem controle visual em pgDados -> mantidos como 0 no BO
7544:         *-- pkchaves: gerado em BtnSalvarClick, nao vem do form
7545:     ENDPROC
7546: 
7547:     *--------------------------------------------------------------------------
7548:     * BOParaForm - Transfere dados do BO para o formulario
7549:     * Fase 5: preenche SigPrFtp e carrega descritivos de SigCdPro
7550:     *--------------------------------------------------------------------------
7551:     PROTECTED PROCEDURE BOParaForm()
7552:         LOCAL loc_oPg
7553:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7554: 
7555:         loc_oPg.txt_4c_Cpros.Value = THIS.this_oBusinessObject.this_cCpros
7556:         loc_oPg.txt_4c_Cgrus.Value = THIS.this_oBusinessObject.this_cCgrus
7557:         loc_oPg.txt_4c_Cods.Value  = THIS.this_oBusinessObject.this_cCods
7558: 
7559:         *-- Carregar todos os descritivos do SigCdPro vinculado
7560:         THIS.CarregarDadosSigCdPro(THIS.this_oBusinessObject.this_cCpros)
7561:     ENDPROC
7562: 
7563:     *--------------------------------------------------------------------------
7564:     * CarregarDadosSigCdPro - Busca e preenche campos de exibicao do SigCdPro
7565:     * par_cCpros: codigo do produto
7566:     *--------------------------------------------------------------------------
7567:     PROTECTED PROCEDURE CarregarDadosSigCdPro(par_cCpros)
7568:         LOCAL loc_cSQL, loc_oPg
7569:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7570: 
7571:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
7572:             RETURN
7573:         ENDIF
7574: 
7575:         *-- Limpar campos de exibicao (Fase 5)
7576:         loc_oPg.txt_4c_Dpros.Value        = ""
7577:         loc_oPg.txt_4c_DPro2s.Value       = ""
7578:         loc_oPg.txt_4c_Cbar.Value         = ""
7579:         loc_oPg.txt_4c_DgruDisplay.Value  = ""
7580:         loc_oPg.txt_4c_DcodsDisplay.Value = ""
7581:         loc_oPg.txt_4c_Lin.Value          = ""
7582:         loc_oPg.txt_4c_DLinDisplay.Value  = ""
7583:         loc_oPg.txt_4c_Col.Value          = ""
7584:         loc_oPg.txt_4c_DColDisplay.Value  = ""
7585:         loc_oPg.txt_4c_Ifor.Value         = ""
7586:         loc_oPg.txt_4c_DforDisplay.Value  = ""
7587:         loc_oPg.txt_4c_Refs.Value         = ""
7588:         *-- Limpar campos de exibicao (Fase 6)
7589:         loc_oPg.txt_4c_Cor.Value          = ""
7590:         loc_oPg.txt_4c_Tam.Value          = ""
7591:         loc_oPg.txt_4c_CodFinP.Value      = ""
7592:         loc_oPg.txt_4c_DesFinP.Value      = ""
7593:         loc_oPg.txt_4c_PesoB.Value        = 0.0
7594:         loc_oPg.txt_4c_CodAcb.Value       = ""
7595:         loc_oPg.txt_4c_DacbDisplay.Value  = ""
7596:         loc_oPg.txt_4c_Pmedio.Value       = 0.0
7597:         loc_oPg.txt_4c_Class.Value        = ""
7598:         loc_oPg.txt_4c_DClassDisplay.Value = ""
7599:         loc_oPg.txt_4c_Local.Value        = ""
7600:         loc_oPg.txt_4c_Ctotal.Value       = 0.0
7601:         loc_oPg.txt_4c_Mctotal.Value      = ""
7602:         loc_oPg.txt_4c_Cuni.Value         = ""
7603:         loc_oPg.txt_4c_DuniDisplay.Value  = ""
7604:         loc_oPg.txt_4c_Cunip.Value        = ""
7605:         loc_oPg.txt_4c_DunipDisplay.Value = ""
7606:         loc_oPg.txt_4c_Pvenda.Value       = 0.0
7607:         loc_oPg.txt_4c_Mpvenda.Value      = ""

*-- Linhas 7650 a 7674:
7650:         loc_oPg3Clear.txt_4c_Mvalor.Value     = ""
7651:         loc_oPg3Clear.txt_4c_Teor.Value       = ""
7652:         loc_oPg3Clear.txt_4c_DesTeor.Value    = ""
7653:         loc_oPg3Clear.txt_4c_IPPTCST.Value    = ""
7654:         *-- Limpar grid sigcdcmv
7655:         IF USED("cursor_4c_Cmv")
7656:             USE IN cursor_4c_Cmv
7657:         ENDIF
7658:         SET NULL ON
7659:         CREATE CURSOR cursor_4c_Cmv (datas C(7), valcuss N(10,2), moedas C(3))
7660:         SET NULL OFF
7661:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.grd_4c_Dados.Refresh()
7662: 
7663:         IF EMPTY(par_cCpros)
7664:             RETURN
7665:         ENDIF
7666: 
7667:         TRY
7668:             *-- Fase 5+6: colunas corretas de SigCdPro (linhas=linha, colecoes=col.venda)
7669:             loc_cSQL = "SELECT p.dpros, ISNULL(p.dpro2s,'') AS dpro2s, " + ;
7670:                 "ISNULL(p.cbars,'') AS cbars, " + ;
7671:                 "ISNULL(p.cgrus,'') AS cgrus, " + ;
7672:                 "ISNULL(p.linhas,'') AS linhas, " + ;
7673:                 "ISNULL(p.colecoes,'') AS colecoes, " + ;
7674:                 "ISNULL(p.ifors,'') AS ifors, ISNULL(p.reffs,'') AS reffs, " + ;

*-- Linhas 7820 a 8240:
7820:     *--------------------------------------------------------------------------
7821:     * AtualizarDescricaoProduto - Compatibilidade: delega para CarregarDadosSigCdPro
7822:     *--------------------------------------------------------------------------
7823:     PROTECTED PROCEDURE AtualizarDescricaoProduto(par_cCpros)
7824:         THIS.CarregarDadosSigCdPro(par_cCpros)
7825:     ENDPROC
7826: 
7827:     *--------------------------------------------------------------------------
7828:     * CarregarDescGrupo - Carrega descricao do grupo (SigCdGrp)
7829:     *--------------------------------------------------------------------------
7830:     PROTECTED PROCEDURE CarregarDescGrupo(par_cCgrus)
7831:         LOCAL loc_cSQL, loc_oPg
7832:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7833: 
7834:         IF EMPTY(par_cCgrus)
7835:             loc_oPg.txt_4c_DgruDisplay.Value = ""
7836:             RETURN
7837:         ENDIF
7838: 
7839:         TRY
7840:             loc_cSQL = "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(par_cCgrus)
7841:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescGru") > 0
7842:                 IF !EOF("cursor_4c_DescGru")
7843:                     SELECT cursor_4c_DescGru
7844:                     loc_oPg.txt_4c_DgruDisplay.Value = ALLTRIM(dgrus)
7845:                 ELSE
7846:                     loc_oPg.txt_4c_DgruDisplay.Value = ""
7847:                 ENDIF
7848:                 IF USED("cursor_4c_DescGru")
7849:                     USE IN cursor_4c_DescGru
7850:                 ENDIF
7851:             ENDIF
7852:         CATCH TO loc_oErro
7853:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
7854:         ENDTRY
7855:     ENDPROC
7856: 
7857:     *--------------------------------------------------------------------------
7858:     * CarregarDescCods - Carrega descricao do subgrupo (via SigCdGrp ou tabela propria)
7859:     *--------------------------------------------------------------------------
7860:     PROTECTED PROCEDURE CarregarDescCods(par_cCods)
7861:         LOCAL loc_oPg, loc_cSQL
7862:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7863: 
7864:         IF EMPTY(par_cCods)
7865:             loc_oPg.txt_4c_DcodsDisplay.Value = ""
7866:             RETURN
7867:         ENDIF
7868: 
7869:         TRY
7870:             loc_cSQL = "SELECT dgrus AS descSubGrupo FROM SigCdGrp WHERE cgrus = " + EscaparSQL(par_cCods)
7871:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCods") > 0
7872:                 IF !EOF("cursor_4c_DescCods")
7873:                     SELECT cursor_4c_DescCods
7874:                     loc_oPg.txt_4c_DcodsDisplay.Value = ALLTRIM(descSubGrupo)
7875:                 ELSE
7876:                     loc_oPg.txt_4c_DcodsDisplay.Value = ""
7877:                 ENDIF
7878:                 IF USED("cursor_4c_DescCods")
7879:                     USE IN cursor_4c_DescCods
7880:                 ENDIF
7881:             ELSE
7882:                 loc_oPg.txt_4c_DcodsDisplay.Value = ""
7883:             ENDIF
7884:         CATCH TO loc_oErro
7885:             MsgErro(loc_oErro.Message, "Erro ao buscar subgrupo")
7886:         ENDTRY
7887:     ENDPROC
7888: 
7889:     *--------------------------------------------------------------------------
7890:     * CarregarDescLin - Carrega descricao da linha (SigCdLin, PK=linhas, desc=descs)
7891:     *--------------------------------------------------------------------------
7892:     PROTECTED PROCEDURE CarregarDescLin(par_cLinhas)
7893:         LOCAL loc_cSQL, loc_oPg
7894:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7895: 
7896:         IF EMPTY(par_cLinhas)
7897:             loc_oPg.txt_4c_DLinDisplay.Value = ""
7898:             RETURN
7899:         ENDIF
7900: 
7901:         TRY
7902:             loc_cSQL = "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(par_cLinhas)
7903:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescLin") > 0
7904:                 IF !EOF("cursor_4c_DescLin")
7905:                     SELECT cursor_4c_DescLin
7906:                     loc_oPg.txt_4c_DLinDisplay.Value = ALLTRIM(descs)
7907:                 ELSE
7908:                     loc_oPg.txt_4c_DLinDisplay.Value = ""
7909:                 ENDIF
7910:                 IF USED("cursor_4c_DescLin")
7911:                     USE IN cursor_4c_DescLin
7912:                 ENDIF
7913:             ENDIF
7914:         CATCH TO loc_oErro
7915:             MsgErro(loc_oErro.Message, "Erro ao buscar linha")
7916:         ENDTRY
7917:     ENDPROC
7918: 
7919:     *--------------------------------------------------------------------------
7920:     * CarregarDescCol - Exibe colecoes (campo texto direto em SigCdPro)
7921:     * Nota: nao existe tabela SigCdCol no banco; colecoes e campo texto livre
7922:     *--------------------------------------------------------------------------
7923:     PROTECTED PROCEDURE CarregarDescCol(par_cColecoes)
7924:         LOCAL loc_oPg
7925:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7926:         *-- Colecoes nao tem tabela de descricao - exibir o proprio valor
7927:         loc_oPg.txt_4c_DColDisplay.Value = par_cColecoes
7928:     ENDPROC
7929: 
7930:     *--------------------------------------------------------------------------
7931:     * CarregarDescIfor - Carrega nome do fornecedor
7932:     *--------------------------------------------------------------------------
7933:     PROTECTED PROCEDURE CarregarDescIfor(par_cIfors)
7934:         LOCAL loc_cSQL, loc_oPg
7935:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7936: 
7937:         IF EMPTY(par_cIfors)
7938:             loc_oPg.txt_4c_DforDisplay.Value = ""
7939:             RETURN
7940:         ENDIF
7941: 
7942:         TRY
7943:             *-- Fornecedor buscado via SigCdCli (ou tabela de fornecedores)
7944:             loc_cSQL = "SELECT Rclis AS dfors FROM SigCdCli WHERE Iclis = " + EscaparSQL(par_cIfors)
7945:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescIfor") > 0
7946:                 IF !EOF("cursor_4c_DescIfor")
7947:                     SELECT cursor_4c_DescIfor
7948:                     loc_oPg.txt_4c_DforDisplay.Value = ALLTRIM(dfors)
7949:                 ELSE
7950:                     loc_oPg.txt_4c_DforDisplay.Value = ""
7951:                 ENDIF
7952:                 IF USED("cursor_4c_DescIfor")
7953:                     USE IN cursor_4c_DescIfor
7954:                 ENDIF
7955:             ENDIF
7956:         CATCH TO loc_oErro
7957:             MsgErro(loc_oErro.Message, "Erro ao buscar fornecedor")
7958:         ENDTRY
7959:     ENDPROC
7960: 
7961:     *--------------------------------------------------------------------------
7962:     * CarregarDescCor - Carrega descricao da cor (SigCdCor, PK=cods, desc=descs)
7963:     *--------------------------------------------------------------------------
7964:     PROTECTED PROCEDURE CarregarDescCor(par_cCodCor)
7965:         LOCAL loc_cSQL, loc_oPg
7966:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7967:         IF EMPTY(par_cCodCor)
7968:             RETURN
7969:         ENDIF
7970:         TRY
7971:             loc_cSQL = "SELECT descs FROM SigCdCor WHERE cods = " + EscaparSQL(par_cCodCor)
7972:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCor") > 0
7973:                 IF !EOF("cursor_4c_DescCor")
7974:                     SELECT cursor_4c_DescCor
7975:                     loc_oPg.txt_4c_Cor.ToolTipText = ALLTRIM(descs)
7976:                 ENDIF
7977:                 IF USED("cursor_4c_DescCor")
7978:                     USE IN cursor_4c_DescCor
7979:                 ENDIF
7980:             ENDIF
7981:         CATCH TO loc_oErro
7982:             MsgErro(loc_oErro.Message, "Erro ao buscar cor")
7983:         ENDTRY
7984:     ENDPROC
7985: 
7986:     *--------------------------------------------------------------------------
7987:     * CarregarDescTam - Carrega descricao do tamanho (SigCdTam, PK=cods, desc=descs)
7988:     *--------------------------------------------------------------------------
7989:     PROTECTED PROCEDURE CarregarDescTam(par_cCodTam)
7990:         LOCAL loc_cSQL, loc_oPg
7991:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7992:         IF EMPTY(par_cCodTam)
7993:             RETURN
7994:         ENDIF
7995:         TRY
7996:             loc_cSQL = "SELECT descs FROM SigCdTam WHERE cods = " + EscaparSQL(par_cCodTam)
7997:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescTam") > 0
7998:                 IF !EOF("cursor_4c_DescTam")
7999:                     SELECT cursor_4c_DescTam
8000:                     loc_oPg.txt_4c_Tam.ToolTipText = ALLTRIM(descs)
8001:                 ENDIF
8002:                 IF USED("cursor_4c_DescTam")
8003:                     USE IN cursor_4c_DescTam
8004:                 ENDIF
8005:             ENDIF
8006:         CATCH TO loc_oErro
8007:             MsgErro(loc_oErro.Message, "Erro ao buscar tamanho")
8008:         ENDTRY
8009:     ENDPROC
8010: 
8011:     *--------------------------------------------------------------------------
8012:     * CarregarDescFinP - Carrega descricao da ficha (SigCdFip, PK=cods, desc=descs)
8013:     *--------------------------------------------------------------------------
8014:     PROTECTED PROCEDURE CarregarDescFinP(par_cCodFinP)
8015:         LOCAL loc_cSQL, loc_oPg
8016:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8017:         IF EMPTY(par_cCodFinP)
8018:             loc_oPg.txt_4c_DesFinP.Value = ""
8019:             RETURN
8020:         ENDIF
8021:         TRY
8022:             loc_cSQL = "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(par_cCodFinP)
8023:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFinP") > 0
8024:                 IF !EOF("cursor_4c_DescFinP")
8025:                     SELECT cursor_4c_DescFinP
8026:                     loc_oPg.txt_4c_DesFinP.Value = ALLTRIM(descs)
8027:                 ELSE
8028:                     loc_oPg.txt_4c_DesFinP.Value = ""
8029:                 ENDIF
8030:                 IF USED("cursor_4c_DescFinP")
8031:                     USE IN cursor_4c_DescFinP
8032:                 ENDIF
8033:             ENDIF
8034:         CATCH TO loc_oErro
8035:             MsgErro(loc_oErro.Message, "Erro ao buscar ficha")
8036:         ENDTRY
8037:     ENDPROC
8038: 
8039:     *--------------------------------------------------------------------------
8040:     * CarregarDescAcb - Carrega descricao do acabamento (SigCdAca, PK=cods, desc=descrs)
8041:     *--------------------------------------------------------------------------
8042:     PROTECTED PROCEDURE CarregarDescAcb(par_cCodAcb)
8043:         LOCAL loc_cSQL, loc_oPg
8044:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8045:         IF EMPTY(par_cCodAcb)
8046:             loc_oPg.txt_4c_DacbDisplay.Value = ""
8047:             RETURN
8048:         ENDIF
8049:         TRY
8050:             loc_cSQL = "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(par_cCodAcb)
8051:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescAcb") > 0
8052:                 IF !EOF("cursor_4c_DescAcb")
8053:                     SELECT cursor_4c_DescAcb
8054:                     loc_oPg.txt_4c_DacbDisplay.Value = ALLTRIM(descrs)
8055:                 ELSE
8056:                     loc_oPg.txt_4c_DacbDisplay.Value = ""
8057:                 ENDIF
8058:                 IF USED("cursor_4c_DescAcb")
8059:                     USE IN cursor_4c_DescAcb
8060:                 ENDIF
8061:             ENDIF
8062:         CATCH TO loc_oErro
8063:             MsgErro(loc_oErro.Message, "Erro ao buscar acabamento")
8064:         ENDTRY
8065:     ENDPROC
8066: 
8067:     *--------------------------------------------------------------------------
8068:     * CarregarDescClass - Carrega descricao da classificacao (SIGCDCLS, PK=cods, desc=descs)
8069:     *--------------------------------------------------------------------------
8070:     PROTECTED PROCEDURE CarregarDescClass(par_cCclass)
8071:         LOCAL loc_cSQL, loc_oPg
8072:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8073:         IF EMPTY(par_cCclass)
8074:             loc_oPg.txt_4c_DClassDisplay.Value = ""
8075:             RETURN
8076:         ENDIF
8077:         TRY
8078:             loc_cSQL = "SELECT descs FROM SIGCDCLS WHERE cods = " + EscaparSQL(par_cCclass)
8079:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescClass") > 0
8080:                 IF !EOF("cursor_4c_DescClass")
8081:                     SELECT cursor_4c_DescClass
8082:                     loc_oPg.txt_4c_DClassDisplay.Value = ALLTRIM(descs)
8083:                 ELSE
8084:                     loc_oPg.txt_4c_DClassDisplay.Value = ""
8085:                 ENDIF
8086:                 IF USED("cursor_4c_DescClass")
8087:                     USE IN cursor_4c_DescClass
8088:                 ENDIF
8089:             ENDIF
8090:         CATCH TO loc_oErro
8091:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o")
8092:         ENDTRY
8093:     ENDPROC
8094: 
8095:     *--------------------------------------------------------------------------
8096:     * CarregarDescLocal - Carrega descricao do local (SigPrLcl, PK=codigos, desc=descricaos)
8097:     *--------------------------------------------------------------------------
8098:     PROTECTED PROCEDURE CarregarDescLocal(par_cLocals)
8099:         LOCAL loc_cSQL, loc_oPg
8100:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8101:         IF EMPTY(par_cLocals)
8102:             RETURN
8103:         ENDIF
8104:         TRY
8105:             loc_cSQL = "SELECT descricaos FROM SigPrLcl WHERE codigos = " + EscaparSQL(par_cLocals)
8106:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescLocal") > 0
8107:                 IF !EOF("cursor_4c_DescLocal")
8108:                     SELECT cursor_4c_DescLocal
8109:                     loc_oPg.txt_4c_Local.ToolTipText = ALLTRIM(descricaos)
8110:                 ENDIF
8111:                 IF USED("cursor_4c_DescLocal")
8112:                     USE IN cursor_4c_DescLocal
8113:                 ENDIF
8114:             ENDIF
8115:         CATCH TO loc_oErro
8116:             MsgErro(loc_oErro.Message, "Erro ao buscar local")
8117:         ENDTRY
8118:     ENDPROC
8119: 
8120:     *--------------------------------------------------------------------------
8121:     * CarregarDescUni - Carrega descricao da unidade (SigCdUni, PK=cunis, desc=dunis)
8122:     * par_cTipo: "uni" = unidade principal, "unip" = unidade de pedido
8123:     *--------------------------------------------------------------------------
8124:     PROTECTED PROCEDURE CarregarDescUni(par_cCunis, par_cTipo)
8125:         LOCAL loc_cSQL, loc_oPg
8126:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8127:         IF EMPTY(par_cCunis)
8128:             IF par_cTipo = "uni"
8129:                 loc_oPg.txt_4c_DuniDisplay.Value  = ""
8130:             ELSE
8131:                 loc_oPg.txt_4c_DunipDisplay.Value = ""
8132:             ENDIF
8133:             RETURN
8134:         ENDIF
8135:         TRY
8136:             loc_cSQL = "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(par_cCunis)
8137:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescUni") > 0
8138:                 IF !EOF("cursor_4c_DescUni")
8139:                     SELECT cursor_4c_DescUni
8140:                     IF par_cTipo = "uni"
8141:                         loc_oPg.txt_4c_DuniDisplay.Value  = ALLTRIM(dunis)
8142:                     ELSE
8143:                         loc_oPg.txt_4c_DunipDisplay.Value = ALLTRIM(dunis)
8144:                     ENDIF
8145:                 ELSE
8146:                     IF par_cTipo = "uni"
8147:                         loc_oPg.txt_4c_DuniDisplay.Value  = ""
8148:                     ELSE
8149:                         loc_oPg.txt_4c_DunipDisplay.Value = ""
8150:                     ENDIF
8151:                 ENDIF
8152:                 IF USED("cursor_4c_DescUni")
8153:                     USE IN cursor_4c_DescUni
8154:                 ENDIF
8155:             ENDIF
8156:         CATCH TO loc_oErro
8157:             MsgErro(loc_oErro.Message, "Erro ao buscar unidade")
8158:         ENDTRY
8159:     ENDPROC
8160: 
8161:     *--------------------------------------------------------------------------
8162:     * CarregarDescMoe - Carrega descricao da moeda (SigCdMoe, PK=cmoes, desc=dmoes)
8163:     * par_cTipo: "total" | "pvenda" | "fvenda"
8164:     *--------------------------------------------------------------------------
8165:     PROTECTED PROCEDURE CarregarDescMoe(par_cCmoes, par_cTipo)
8166:         LOCAL loc_cSQL, loc_oPg, loc_cDesc
8167:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8168:         loc_cDesc = ""
8169:         IF EMPTY(par_cCmoes)
8170:             RETURN
8171:         ENDIF
8172:         TRY
8173:             loc_cSQL = "SELECT dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(par_cCmoes)
8174:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescMoe") > 0
8175:                 IF !EOF("cursor_4c_DescMoe")
8176:                     SELECT cursor_4c_DescMoe
8177:                     loc_cDesc = ALLTRIM(dmoes)
8178:                 ENDIF
8179:                 IF USED("cursor_4c_DescMoe")
8180:                     USE IN cursor_4c_DescMoe
8181:                 ENDIF
8182:             ENDIF
8183:         CATCH TO loc_oErro
8184:             MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
8185:         ENDTRY
8186:         DO CASE
8187:         CASE par_cTipo = "total"
8188:             loc_oPg.txt_4c_Mctotal.ToolTipText = loc_cDesc
8189:         CASE par_cTipo = "pvenda"
8190:             loc_oPg.txt_4c_Mpvenda.ToolTipText = loc_cDesc
8191:         CASE par_cTipo = "fvenda"
8192:             loc_oPg.txt_4c_Mfvenda.ToolTipText = loc_cDesc
8193:         ENDCASE
8194:     ENDPROC
8195: 
8196:     *--------------------------------------------------------------------------
8197:     * CarregarDescFiscais - Carrega descricoes e historico CMV da Fase 13
8198:     * par_cCpros: codigo produto; demais: codigos para lookup de descricoes
8199:     *--------------------------------------------------------------------------
8200:     PROTECTED PROCEDURE CarregarDescFiscais(par_cCpros, par_cGruccus, par_cContaccus, ;
8201:                                              par_cClfiscals, par_cOrigmercs, par_cSittricms, ;
8202:                                              par_cMetals, par_cTeors)
8203:         LOCAL loc_oPg3, loc_cSQL, loc_cDesc
8204:         loc_oPg3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
8205: 
8206:         TRY
8207:             *-- Grupo CC (SigCdGcr)
8208:             IF !EMPTY(par_cGruccus)
8209:                 loc_cSQL = "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(par_cGruccus)
8210:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
8211:                     loc_oPg3.txt_4c_Dgruccus.Value = ALLTRIM(cursor_4c_DescFisc.descrs)
8212:                 ENDIF
8213:                 IF USED("cursor_4c_DescFisc")
8214:                     USE IN cursor_4c_DescFisc
8215:                 ENDIF
8216:             ENDIF
8217: 
8218:             *-- Conta CC (SigCdCli)
8219:             IF !EMPTY(par_cContaccus)
8220:                 loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE IClis = " + EscaparSQL(par_cContaccus)
8221:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
8222:                     loc_oPg3.txt_4c_Dcontaccus.Value = ALLTRIM(cursor_4c_DescFisc.Rclis)
8223:                 ENDIF
8224:                 IF USED("cursor_4c_DescFisc")
8225:                     USE IN cursor_4c_DescFisc
8226:                 ENDIF
8227:             ENDIF
8228: 
8229:             *-- Classificacao Fiscal (SigCdClf)
8230:             IF !EMPTY(par_cClfiscals)
8231:                 loc_cSQL = "SELECT Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(par_cClfiscals)
8232:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
8233:                     loc_oPg3.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_DescFisc.Descricaos)
8234:                 ENDIF
8235:                 IF USED("cursor_4c_DescFisc")
8236:                     USE IN cursor_4c_DescFisc
8237:                 ENDIF
8238:             ENDIF
8239: 
8240:             *-- Origem da Mercadoria (SigCdOrg)

*-- Linhas 8279 a 8362:
8279: 
8280:             *-- Carregar historico CMV (sigcdcmv)
8281:             IF !EMPTY(par_cCpros)
8282:                 loc_cSQL = "SELECT datas, valcuss, moedas FROM sigcdcmv " + ;
8283:                            "WHERE cpros = " + EscaparSQL(par_cCpros) + " ORDER BY datas DESC"
8284:                 IF USED("cursor_4c_Cmv")
8285:                     USE IN cursor_4c_Cmv
8286:                 ENDIF
8287:                 SET NULL ON
8288:                 CREATE CURSOR cursor_4c_Cmv (datas C(7), valcuss N(10,2), moedas C(3))
8289:                 SET NULL OFF
8290:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmvTemp") > 0
8291:                     IF !EOF("cursor_4c_CmvTemp")
8292:                         SELECT cursor_4c_CmvTemp
8293:                         GO TOP
8294:                         SCAN
8295:                             LOCAL loc_cDatas, loc_nValcuss, loc_cMoedas
8296:                             loc_cDatas   = ALLTRIM(cursor_4c_CmvTemp.datas)
8297:                             loc_nValcuss = cursor_4c_CmvTemp.valcuss
8298:                             loc_cMoedas  = ALLTRIM(cursor_4c_CmvTemp.moedas)
8299:                             INSERT INTO cursor_4c_Cmv (datas, valcuss, moedas) ;
8300:                                 VALUES (loc_cDatas, loc_nValcuss, loc_cMoedas)
8301:                         ENDSCAN
8302:                     ENDIF
8303:                     IF USED("cursor_4c_CmvTemp")
8304:                         USE IN cursor_4c_CmvTemp
8305:                     ENDIF
8306:                 ENDIF
8307:                 SELECT cursor_4c_Cmv
8308:                 IF RECCOUNT() > 0
8309:                     GO TOP
8310:                 ENDIF
8311:                 loc_oPg3.grd_4c_Dados.Refresh()
8312:             ENDIF
8313: 
8314:         CATCH TO loc_oErro
8315:             MsgErro(loc_oErro.Message, "Erro ao carregar dados fiscais")
8316:         ENDTRY
8317:     ENDPROC
8318: 
8319:     *--------------------------------------------------------------------------
8320:     * HabilitarCampos - Habilita/desabilita campos editaveis conforme modo
8321:     *--------------------------------------------------------------------------
8322:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
8323:         LOCAL loc_oPg, loc_lReadOnly, loc_cBgEdit, loc_cBgRO
8324:         loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8325:         loc_lReadOnly = !par_lHabilitar
8326:         loc_cBgEdit  = RGB(255, 255, 255)
8327:         loc_cBgRO    = RGB(224, 235, 235)
8328: 
8329:         TRY
8330:             *-- Fase 5: Campos editaveis basicos
8331:             loc_oPg.txt_4c_Cpros.ReadOnly  = loc_lReadOnly
8332:             loc_oPg.txt_4c_Cpros.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8333: 
8334:             loc_oPg.txt_4c_DPro2s.ReadOnly  = loc_lReadOnly
8335:             loc_oPg.txt_4c_DPro2s.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8336: 
8337:             loc_oPg.txt_4c_Cbar.ReadOnly  = loc_lReadOnly
8338:             loc_oPg.txt_4c_Cbar.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8339: 
8340:             loc_oPg.txt_4c_Cgrus.ReadOnly  = loc_lReadOnly
8341:             loc_oPg.txt_4c_Cgrus.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8342: 
8343:             loc_oPg.txt_4c_Cods.ReadOnly  = loc_lReadOnly
8344:             loc_oPg.txt_4c_Cods.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8345: 
8346:             loc_oPg.txt_4c_Lin.ReadOnly  = loc_lReadOnly
8347:             loc_oPg.txt_4c_Lin.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8348: 
8349:             loc_oPg.txt_4c_Col.ReadOnly  = loc_lReadOnly
8350:             loc_oPg.txt_4c_Col.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8351: 
8352:             loc_oPg.txt_4c_Ifor.ReadOnly  = loc_lReadOnly
8353:             loc_oPg.txt_4c_Ifor.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8354: 
8355:             loc_oPg.txt_4c_Refs.ReadOnly  = loc_lReadOnly
8356:             loc_oPg.txt_4c_Refs.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8357: 
8358:             *-- Fase 6: Novos campos editaveis
8359:             loc_oPg.txt_4c_Cor.ReadOnly  = loc_lReadOnly
8360:             loc_oPg.txt_4c_Cor.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8361: 
8362:             loc_oPg.txt_4c_Tam.ReadOnly  = loc_lReadOnly

*-- Linhas 8481 a 8524:
8481:     *--------------------------------------------------------------------------
8482:     * LimparCampos - Limpa todos os campos da aba pgDados
8483:     *--------------------------------------------------------------------------
8484:     PROTECTED PROCEDURE LimparCampos()
8485:         LOCAL loc_oPg
8486:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8487: 
8488:         TRY
8489:             *-- Linha 1: Produto
8490:             loc_oPg.txt_4c_Cpros.Value        = ""
8491:             loc_oPg.txt_4c_Dpros.Value        = ""
8492:             *-- Linha 2: Descritivo 2 + Barra
8493:             loc_oPg.txt_4c_DPro2s.Value       = ""
8494:             loc_oPg.txt_4c_Cbar.Value         = ""
8495:             *-- Linha 3: Grupo
8496:             loc_oPg.txt_4c_Cgrus.Value        = ""
8497:             loc_oPg.txt_4c_DgruDisplay.Value  = ""
8498:             *-- Linha 4: Subgrupo
8499:             loc_oPg.txt_4c_Cods.Value         = ""
8500:             loc_oPg.txt_4c_DcodsDisplay.Value = ""
8501:             *-- Linha 5: Linha
8502:             loc_oPg.txt_4c_Lin.Value          = ""
8503:             loc_oPg.txt_4c_DLinDisplay.Value  = ""
8504:             *-- Linha 6: Colecao/Venda
8505:             loc_oPg.txt_4c_Col.Value          = ""
8506:             loc_oPg.txt_4c_DColDisplay.Value  = ""
8507:             *-- Linha 7: Fornecedor
8508:             loc_oPg.txt_4c_Ifor.Value         = ""
8509:             loc_oPg.txt_4c_DforDisplay.Value  = ""
8510:             *-- Linha 8: Ref. Fornecedor + Cor + Tamanho
8511:             loc_oPg.txt_4c_Refs.Value         = ""
8512:             loc_oPg.txt_4c_Cor.Value          = ""
8513:             loc_oPg.txt_4c_Tam.Value          = ""
8514:             *-- Linha 9: Ficha + Peso Base
8515:             loc_oPg.txt_4c_CodFinP.Value      = ""
8516:             loc_oPg.txt_4c_DesFinP.Value      = ""
8517:             loc_oPg.txt_4c_PesoB.Value        = 0.0
8518:             *-- Linha 10: Acabamento + Preco Medio
8519:             loc_oPg.txt_4c_CodAcb.Value       = ""
8520:             loc_oPg.txt_4c_DacbDisplay.Value  = ""
8521:             loc_oPg.txt_4c_Pmedio.Value       = 0.0
8522:             *-- Linha 11: Classificacao + Local
8523:             loc_oPg.txt_4c_Class.Value         = ""
8524:             loc_oPg.txt_4c_DClassDisplay.Value = ""

*-- Linhas 8590 a 11376:
8590:     *--------------------------------------------------------------------------
8591:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
8592:     *--------------------------------------------------------------------------
8593:     PROTECTED PROCEDURE AjustarBotoesPorModo()
8594:         LOCAL loc_oCnt, loc_lTemRegistro
8595:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
8596:         loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
8597: 
8598:         TRY
8599:             loc_oCnt.cmd_4c_Incluir.Enabled    = .T.
8600:             loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
8601:             loc_oCnt.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
8602:             loc_oCnt.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
8603:             loc_oCnt.cmd_4c_Procurar.Enabled   = .T.
8604:         CATCH TO loc_oErro
8605:             MsgErro(loc_oErro.Message, "Erro ao ajustar bot" + CHR(245) + "es")
8606:         ENDTRY
8607:     ENDPROC
8608: 
8609:     *==========================================================================
8610:     * HANDLERS DE BOTOES CRUD
8611:     *==========================================================================
8612: 
8613:     *--------------------------------------------------------------------------
8614:     * BtnIncluirClick - Acao do botao Incluir
8615:     *--------------------------------------------------------------------------
8616:     PROCEDURE BtnIncluirClick()
8617:         THIS.this_oBusinessObject.NovoRegistro()
8618:         THIS.LimparCampos()
8619:         THIS.this_cModoAtual = "INCLUIR"
8620:         THIS.HabilitarCampos(.T.)
8621:         THIS.AlternarPagina(2)
8622:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.txt_4c_Cpros.SetFocus()
8623:     ENDPROC
8624: 
8625:     *--------------------------------------------------------------------------
8626:     * BtnVisualizarClick - Acao do botao Visualizar
8627:     *--------------------------------------------------------------------------
8628:     PROCEDURE BtnVisualizarClick()
8629:         LOCAL loc_cChave
8630: 
8631:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
8632:             MsgAviso("Nenhum registro selecionado.")
8633:             RETURN
8634:         ENDIF
8635: 
8636:         loc_cChave = ALLTRIM(cursor_4c_Dados.pkchaves)
8637: 
8638:         TRY
8639:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
8640:                 THIS.BOParaForm()
8641:                 THIS.this_cModoAtual = "VISUALIZAR"
8642:                 THIS.HabilitarCampos(.F.)
8643:                 THIS.AlternarPagina(2)
8644:             ENDIF
8645:         CATCH TO loc_oErro
8646:             MsgErro(loc_oErro.Message, "Erro ao visualizar registro")
8647:         ENDTRY
8648:     ENDPROC
8649: 
8650:     *--------------------------------------------------------------------------
8651:     * BtnAlterarClick - Acao do botao Alterar
8652:     *--------------------------------------------------------------------------
8653:     PROCEDURE BtnAlterarClick()
8654:         LOCAL loc_cChave
8655: 
8656:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
8657:             MsgAviso("Nenhum registro selecionado.")
8658:             RETURN
8659:         ENDIF
8660: 
8661:         loc_cChave = ALLTRIM(cursor_4c_Dados.pkchaves)
8662: 
8663:         TRY
8664:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
8665:                 THIS.this_oBusinessObject.EditarRegistro()
8666:                 THIS.BOParaForm()
8667:                 THIS.this_cModoAtual = "ALTERAR"
8668:                 THIS.HabilitarCampos(.T.)
8669:                 THIS.AlternarPagina(2)
8670:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.txt_4c_Cpros.SetFocus()
8671:             ENDIF
8672:         CATCH TO loc_oErro
8673:             MsgErro(loc_oErro.Message, "Erro ao alterar registro")
8674:         ENDTRY
8675:     ENDPROC
8676: 
8677:     *--------------------------------------------------------------------------
8678:     * BtnExcluirClick - Acao do botao Excluir
8679:     *--------------------------------------------------------------------------
8680:     PROCEDURE BtnExcluirClick()
8681:         LOCAL loc_cChave
8682: 
8683:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
8684:             MsgAviso("Nenhum registro selecionado.")
8685:             RETURN
8686:         ENDIF
8687: 
8688:         loc_cChave = ALLTRIM(cursor_4c_Dados.pkchaves)
8689: 
8690:         TRY
8691:             IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
8692:                 "Excluir Produto")
8693:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
8694:                     IF THIS.this_oBusinessObject.Excluir()
8695:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Exclu" + CHR(237) + "do")
8696:                         THIS.CarregarLista()
8697:                         THIS.AjustarBotoesPorModo()
8698:                     ELSE
8699:                         MsgErro("Erro ao excluir registro.", "Erro")
8700:                     ENDIF
8701:                 ENDIF
8702:             ENDIF
8703:         CATCH TO loc_oErro
8704:             MsgErro(loc_oErro.Message, "Erro ao excluir registro")
8705:         ENDTRY
8706:     ENDPROC
8707: 
8708:     *--------------------------------------------------------------------------
8709:     * BtnProcurarClick - Acao do botao Procurar (busca e seleciona produto na lista)
8710:     *--------------------------------------------------------------------------
8711:     PROCEDURE BtnProcurarClick()
8712:         LOCAL loc_oBusca, loc_cCpros
8713: 
8714:         TRY
8715:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Busca de Produto")
8716:             loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
8717:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
8718:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
8719:             loc_oBusca.Show()
8720: 
8721:             IF loc_oBusca.this_lSelecionou
8722:                 IF USED("cursor_4c_Busca")
8723:                     SELECT cursor_4c_Busca
8724:                     loc_cCpros = ALLTRIM(cpros)
8725:                     USE IN cursor_4c_Busca
8726:                 ENDIF
8727: 
8728:                 *-- Posiciona grid na linha do produto selecionado
8729:                 IF !EMPTY(loc_cCpros) AND USED("cursor_4c_Dados")
8730:                     SELECT cursor_4c_Dados
8731:                     LOCATE FOR ALLTRIM(cpros) = loc_cCpros
8732:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
8733:                 ENDIF
8734:             ENDIF
8735: 
8736:             IF VARTYPE(loc_oBusca) = "O"
8737:                 loc_oBusca.Release()
8738:                 loc_oBusca = .NULL.
8739:             ENDIF
8740:         CATCH TO loc_oErro
8741:             MsgErro(loc_oErro.Message, "Erro ao procurar produto")
8742:         ENDTRY
8743:     ENDPROC
8744: 
8745:     *--------------------------------------------------------------------------
8746:     * BtnSalvarClick - Acao do botao Salvar
8747:     *--------------------------------------------------------------------------
8748:     PROCEDURE BtnSalvarClick()
8749:         LOCAL loc_oPg
8750: 
8751:         *-- Validar campos obrigatorios
8752:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8753: 
8754:         IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Cpros.Value))
8755:             MsgAviso("Campo Produto " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
8756:             loc_oPg.txt_4c_Cpros.SetFocus()
8757:             RETURN
8758:         ENDIF
8759: 
8760:         IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Cgrus.Value))
8761:             MsgAviso("Campo Grupo " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
8762:             loc_oPg.txt_4c_Cgrus.SetFocus()
8763:             RETURN
8764:         ENDIF
8765: 
8766:         TRY
8767:             THIS.FormParaBO()
8768: 
8769:             IF THIS.this_cModoAtual = "INCLUIR"
8770:                 *-- Gerar pkchaves: char(20), unica
8771:                 THIS.this_oBusinessObject.this_cPkchaves = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)
8772:             ENDIF
8773: 
8774:             IF THIS.this_oBusinessObject.Salvar()
8775:                 THIS.AtualizarSigCdPro()
8776:                 MsgInfo("Registro salvo com sucesso.", "Salvo")
8777:                 THIS.AlternarPagina(1)
8778:             ELSE
8779:                 MsgErro("Erro ao salvar registro.", "Erro")
8780:             ENDIF
8781: 
8782:         CATCH TO loc_oErro
8783:             MsgErro(loc_oErro.Message, "Erro ao salvar")
8784:         ENDTRY
8785:     ENDPROC
8786: 
8787:     *--------------------------------------------------------------------------
8788:     * BtnCancelarClick - Acao do botao Cancelar
8789:     *--------------------------------------------------------------------------
8790:     PROCEDURE BtnCancelarClick()
8791:         THIS.this_oBusinessObject.CancelarEdicao()
8792:         THIS.AlternarPagina(1)
8793:     ENDPROC
8794: 
8795:     *--------------------------------------------------------------------------
8796:     * BtnSairClick - Acao do botao Sair
8797:     *--------------------------------------------------------------------------
8798:     PROCEDURE BtnSairClick()
8799:         THIS.Release()
8800:     ENDPROC
8801: 
8802:     *==========================================================================
8803:     * HANDLERS DE FILTROS
8804:     *==========================================================================
8805: 
8806:     *--------------------------------------------------------------------------
8807:     * FiltroSituacaoChange - Disparado quando muda opcao de situacao no filtro
8808:     *--------------------------------------------------------------------------
8809:     PROCEDURE FiltroSituacaoChange()
8810:         IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
8811:             THIS.CarregarLista()
8812:         ENDIF
8813:     ENDPROC
8814: 
8815:     *==========================================================================
8816:     * HANDLERS DE KEYPRESS (ENTER/TAB/F4 disparam lookup)
8817:     *==========================================================================
8818: 
8819:     *--------------------------------------------------------------------------
8820:     * TxtFilCgruKeyPress - KeyPress no filtro de grupo (ENTER/TAB carrega lista)
8821:     *--------------------------------------------------------------------------
8822:     PROCEDURE TxtFilCgruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8823:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8824:             IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
8825:                 THIS.CarregarLista()
8826:             ENDIF
8827:         ENDIF
8828:     ENDPROC
8829: 
8830:     *--------------------------------------------------------------------------
8831:     * TxtCprosKeyPress - KeyPress no campo Cpros (ENTER/F4 abre lookup SigCdPro)
8832:     *--------------------------------------------------------------------------
8833:     PROCEDURE TxtCprosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8834:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8835:             *-- Validar produto ao sair
8836:             THIS.ValidarCpros()
8837:         ENDIF
8838:         IF par_nKeyCode = 115
8839:             *-- F4 = 115 -> abrir lookup
8840:             THIS.AbrirLookupProduto()
8841:         ENDIF
8842:     ENDPROC
8843: 
8844:     *--------------------------------------------------------------------------
8845:     * TxtCgrusKeyPress - KeyPress no campo Cgrus (ENTER/F4 abre lookup de grupo)
8846:     *--------------------------------------------------------------------------
8847:     PROCEDURE TxtCgrusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8848:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8849:             THIS.ValidarCgrus()
8850:         ENDIF
8851:         IF par_nKeyCode = 115
8852:             THIS.AbrirLookupGrupo()
8853:         ENDIF
8854:     ENDPROC
8855: 
8856:     *--------------------------------------------------------------------------
8857:     * TxtLinKeyPress - KeyPress no campo Lin (ENTER/F4 abre lookup SigCdLin)
8858:     *--------------------------------------------------------------------------
8859:     PROCEDURE TxtLinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8860:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8861:             THIS.ValidarLin()
8862:         ENDIF
8863:         IF par_nKeyCode = 115
8864:             THIS.AbrirLookupLin()
8865:         ENDIF
8866:     ENDPROC
8867: 
8868:     *--------------------------------------------------------------------------
8869:     * TxtColKeyPress - KeyPress no campo Col (ENTER/F4 abre lookup SigCdCol)
8870:     *--------------------------------------------------------------------------
8871:     PROCEDURE TxtColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8872:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8873:             THIS.ValidarCol()
8874:         ENDIF
8875:         IF par_nKeyCode = 115
8876:             THIS.AbrirLookupCol()
8877:         ENDIF
8878:     ENDPROC
8879: 
8880:     *--------------------------------------------------------------------------
8881:     * TxtIforKeyPress - KeyPress no campo Ifor (ENTER/F4 abre lookup fornecedor)
8882:     *--------------------------------------------------------------------------
8883:     PROCEDURE TxtIforKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8884:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8885:             THIS.ValidarIfor()
8886:         ENDIF
8887:         IF par_nKeyCode = 115
8888:             THIS.AbrirLookupIfor()
8889:         ENDIF
8890:     ENDPROC
8891: 
8892:     *==========================================================================
8893:     * VALIDACOES
8894:     *==========================================================================
8895: 
8896:     *--------------------------------------------------------------------------
8897:     * ValidarCpros - Valida campo cpros e carrega todos os dados do SigCdPro
8898:     *--------------------------------------------------------------------------
8899:     PROTECTED PROCEDURE ValidarCpros()
8900:         LOCAL loc_cCpros, loc_cSQL, loc_oPg
8901:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8902:         loc_cCpros = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
8903: 
8904:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8905:             RETURN
8906:         ENDIF
8907: 
8908:         IF EMPTY(loc_cCpros)
8909:             THIS.CarregarDadosSigCdPro("")
8910:             RETURN
8911:         ENDIF
8912: 
8913:         TRY
8914:             *-- Verificar se produto existe antes de carregar todos os dados
8915:             loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
8916: 
8917:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValPro") > 0
8918:                 SELECT cursor_4c_ValPro
8919:                 IF nExiste > 0
8920:                     IF USED("cursor_4c_ValPro")
8921:                         USE IN cursor_4c_ValPro
8922:                     ENDIF
8923:                     THIS.CarregarDadosSigCdPro(loc_cCpros)
8924:                 ELSE
8925:                     IF USED("cursor_4c_ValPro")
8926:                         USE IN cursor_4c_ValPro
8927:                     ENDIF
8928:                     THIS.CarregarDadosSigCdPro("")
8929:                     MsgAviso("Produto " + loc_cCpros + " n" + CHR(227) + "o encontrado.", "Produto Inv" + CHR(225) + "lido")
8930:                 ENDIF
8931:             ENDIF
8932:         CATCH TO loc_oErro
8933:             MsgErro(loc_oErro.Message, "Erro ao validar produto")
8934:         ENDTRY
8935:     ENDPROC
8936: 
8937:     *--------------------------------------------------------------------------
8938:     * ValidarCgrus - Valida campo cgrus e carrega descricao do grupo
8939:     *--------------------------------------------------------------------------
8940:     PROTECTED PROCEDURE ValidarCgrus()
8941:         LOCAL loc_cCgrus, loc_oPg
8942:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8943:         loc_cCgrus = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
8944: 
8945:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8946:             RETURN
8947:         ENDIF
8948: 
8949:         THIS.CarregarDescGrupo(loc_cCgrus)
8950: 
8951:         IF !EMPTY(loc_cCgrus) AND EMPTY(loc_oPg.txt_4c_DgruDisplay.Value)
8952:             MsgAviso("Grupo " + loc_cCgrus + " n" + CHR(227) + "o encontrado.", "Grupo Inv" + CHR(225) + "lido")
8953:         ENDIF
8954:     ENDPROC
8955: 
8956:     *--------------------------------------------------------------------------
8957:     * ValidarLin - Valida campo lin e carrega descricao da linha (SigCdLin)
8958:     *--------------------------------------------------------------------------
8959:     PROTECTED PROCEDURE ValidarLin()
8960:         LOCAL loc_cClins, loc_oPg
8961:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8962:         loc_cClins = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
8963: 
8964:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8965:             RETURN
8966:         ENDIF
8967: 
8968:         THIS.CarregarDescLin(loc_cClins)
8969: 
8970:         IF !EMPTY(loc_cClins) AND EMPTY(loc_oPg.txt_4c_DLinDisplay.Value)
8971:             MsgAviso("Linha " + loc_cClins + " n" + CHR(227) + "o encontrada.", "Linha Inv" + CHR(225) + "lida")
8972:         ENDIF
8973:     ENDPROC
8974: 
8975:     *--------------------------------------------------------------------------
8976:     * ValidarCol - Valida campo col e carrega descricao do grupo de venda (SigCdCol)
8977:     *--------------------------------------------------------------------------
8978:     PROTECTED PROCEDURE ValidarCol()
8979:         LOCAL loc_cCcols, loc_oPg
8980:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8981:         loc_cCcols = ALLTRIM(loc_oPg.txt_4c_Col.Value)
8982: 
8983:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8984:             RETURN
8985:         ENDIF
8986: 
8987:         THIS.CarregarDescCol(loc_cCcols)
8988: 
8989:         IF !EMPTY(loc_cCcols) AND EMPTY(loc_oPg.txt_4c_DColDisplay.Value)
8990:             MsgAviso("Grupo de venda " + loc_cCcols + " n" + CHR(227) + "o encontrado.", "Inv" + CHR(225) + "lido")
8991:         ENDIF
8992:     ENDPROC
8993: 
8994:     *--------------------------------------------------------------------------
8995:     * ValidarIfor - Valida campo ifor e carrega nome do fornecedor
8996:     *--------------------------------------------------------------------------
8997:     PROTECTED PROCEDURE ValidarIfor()
8998:         LOCAL loc_cIfors, loc_oPg
8999:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9000:         loc_cIfors = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)
9001: 
9002:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9003:             RETURN
9004:         ENDIF
9005: 
9006:         THIS.CarregarDescIfor(loc_cIfors)
9007: 
9008:         IF !EMPTY(loc_cIfors) AND EMPTY(loc_oPg.txt_4c_DforDisplay.Value)
9009:             MsgAviso("Fornecedor " + loc_cIfors + " n" + CHR(227) + "o encontrado.", "Inv" + CHR(225) + "lido")
9010:         ENDIF
9011:     ENDPROC
9012: 
9013:     *==========================================================================
9014:     * LOOKUPS (FormBuscaAuxiliar)
9015:     *==========================================================================
9016: 
9017:     *--------------------------------------------------------------------------
9018:     * AbrirLookupProduto - Abre busca de produto (SigCdPro)
9019:     *--------------------------------------------------------------------------
9020:     PROCEDURE AbrirLookupProduto()
9021:         LOCAL loc_oBusca, loc_oPg
9022:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9023: 
9024:         TRY
9025:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Busca de Produto")
9026:             loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
9027:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
9028:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
9029:             loc_oBusca.Show()
9030: 
9031:             IF loc_oBusca.this_lSelecionou
9032:                 IF USED("cursor_4c_Busca")
9033:                     SELECT cursor_4c_Busca
9034:                     loc_oPg.txt_4c_Cpros.Value = ALLTRIM(cpros)
9035:                     loc_oPg.txt_4c_Dpros.Value = ALLTRIM(dpros)
9036:                     USE IN cursor_4c_Busca
9037:                 ENDIF
9038:             ENDIF
9039: 
9040:             loc_oBusca.Release()
9041:             loc_oBusca = .NULL.
9042:         CATCH TO loc_oErro
9043:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de produto")
9044:         ENDTRY
9045:     ENDPROC
9046: 
9047:     *--------------------------------------------------------------------------
9048:     * AbrirLookupGrupo - Abre busca de grupo (SigCdGrp)
9049:     *--------------------------------------------------------------------------
9050:     PROCEDURE AbrirLookupGrupo()
9051:         LOCAL loc_oBusca, loc_oPg
9052:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9053: 
9054:         TRY
9055:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", "cursor_4c_Busca", "cgrus", "", "Busca de Grupo")
9056:             loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
9057:             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
9058:             loc_oBusca.Show()
9059: 
9060:             IF loc_oBusca.this_lSelecionou
9061:                 IF USED("cursor_4c_Busca")
9062:                     SELECT cursor_4c_Busca
9063:                     loc_oPg.txt_4c_Cgrus.Value       = ALLTRIM(cgrus)
9064:                     loc_oPg.txt_4c_DgruDisplay.Value = ALLTRIM(dgrus)
9065:                     USE IN cursor_4c_Busca
9066:                 ENDIF
9067:             ENDIF
9068: 
9069:             loc_oBusca.Release()
9070:             loc_oBusca = .NULL.
9071:         CATCH TO loc_oErro
9072:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo")
9073:         ENDTRY
9074:     ENDPROC
9075: 
9076:     *--------------------------------------------------------------------------
9077:     * AbrirLookupLin - Abre busca de linha (SigCdLin)
9078:     *--------------------------------------------------------------------------
9079:     PROCEDURE AbrirLookupLin()
9080:         LOCAL loc_oBusca, loc_oPg
9081:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9082: 
9083:         TRY
9084:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLin", "cursor_4c_Busca", "clins", "", "Busca de Linha")
9085:             loc_oBusca.mAddColuna("clins", "", "C" + CHR(243) + "digo")
9086:             loc_oBusca.mAddColuna("dlins", "", "Descri" + CHR(231) + CHR(227) + "o")
9087:             loc_oBusca.Show()
9088: 
9089:             IF loc_oBusca.this_lSelecionou
9090:                 IF USED("cursor_4c_Busca")
9091:                     SELECT cursor_4c_Busca
9092:                     loc_oPg.txt_4c_Lin.Value          = ALLTRIM(clins)
9093:                     loc_oPg.txt_4c_DLinDisplay.Value  = ALLTRIM(dlins)
9094:                     USE IN cursor_4c_Busca
9095:                 ENDIF
9096:             ENDIF
9097: 
9098:             loc_oBusca.Release()
9099:             loc_oBusca = .NULL.
9100:         CATCH TO loc_oErro
9101:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de linha")
9102:         ENDTRY
9103:     ENDPROC
9104: 
9105:     *--------------------------------------------------------------------------
9106:     * AbrirLookupCol - Abre busca de grupo de venda (SigCdCol)
9107:     *--------------------------------------------------------------------------
9108:     PROCEDURE AbrirLookupCol()
9109:         LOCAL loc_oBusca, loc_oPg
9110:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9111: 
9112:         TRY
9113:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", "cursor_4c_Busca", "ccols", "", "Busca de Grupo de Venda")
9114:             loc_oBusca.mAddColuna("ccols", "", "C" + CHR(243) + "digo")
9115:             loc_oBusca.mAddColuna("dcols", "", "Descri" + CHR(231) + CHR(227) + "o")
9116:             loc_oBusca.Show()
9117: 
9118:             IF loc_oBusca.this_lSelecionou
9119:                 IF USED("cursor_4c_Busca")
9120:                     SELECT cursor_4c_Busca
9121:                     loc_oPg.txt_4c_Col.Value          = ALLTRIM(ccols)
9122:                     loc_oPg.txt_4c_DColDisplay.Value  = ALLTRIM(dcols)
9123:                     USE IN cursor_4c_Busca
9124:                 ENDIF
9125:             ENDIF
9126: 
9127:             loc_oBusca.Release()
9128:             loc_oBusca = .NULL.
9129:         CATCH TO loc_oErro
9130:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo de venda")
9131:         ENDTRY
9132:     ENDPROC
9133: 
9134:     *--------------------------------------------------------------------------
9135:     * AbrirLookupIfor - Abre busca de fornecedor (SigCdCli)
9136:     *--------------------------------------------------------------------------
9137:     PROCEDURE AbrirLookupIfor()
9138:         LOCAL loc_oBusca, loc_oPg
9139:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9140: 
9141:         TRY
9142:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_Busca", "Iclis", "", "Busca de Fornecedor")
9143:             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
9144:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
9145:             loc_oBusca.Show()
9146: 
9147:             IF loc_oBusca.this_lSelecionou
9148:                 IF USED("cursor_4c_Busca")
9149:                     SELECT cursor_4c_Busca
9150:                     loc_oPg.txt_4c_Ifor.Value         = ALLTRIM(Iclis)
9151:                     loc_oPg.txt_4c_DforDisplay.Value  = ALLTRIM(Rclis)
9152:                     USE IN cursor_4c_Busca
9153:                 ENDIF
9154:             ENDIF
9155: 
9156:             loc_oBusca.Release()
9157:             loc_oBusca = .NULL.
9158:         CATCH TO loc_oErro
9159:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de fornecedor")
9160:         ENDTRY
9161:     ENDPROC
9162: 
9163:     *==========================================================================
9164:     * HANDLERS DE KEYPRESS - FASE 6 (novos campos com lookup)
9165:     *==========================================================================
9166: 
9167:     *--------------------------------------------------------------------------
9168:     * TxtCorKeyPress - KeyPress no campo Cor (ENTER/F4 abre lookup SigCdCor)
9169:     *--------------------------------------------------------------------------
9170:     PROCEDURE TxtCorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9171:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9172:             THIS.ValidarCor()
9173:         ENDIF
9174:         IF par_nKeyCode = 115
9175:             THIS.AbrirLookupCor()
9176:         ENDIF
9177:     ENDPROC
9178: 
9179:     *--------------------------------------------------------------------------
9180:     * TxtTamKeyPress - KeyPress no campo Tamanho (ENTER/F4 abre lookup SigCdTam)
9181:     *--------------------------------------------------------------------------
9182:     PROCEDURE TxtTamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9183:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9184:             THIS.ValidarTam()
9185:         ENDIF
9186:         IF par_nKeyCode = 115
9187:             THIS.AbrirLookupTam()
9188:         ENDIF
9189:     ENDPROC
9190: 
9191:     *--------------------------------------------------------------------------
9192:     * TxtCodFinPKeyPress - KeyPress no campo Ficha (ENTER/F4 abre lookup SigCdFip)
9193:     *--------------------------------------------------------------------------
9194:     PROCEDURE TxtCodFinPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9195:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9196:             THIS.ValidarCodFinP()
9197:         ENDIF
9198:         IF par_nKeyCode = 115
9199:             THIS.AbrirLookupFinP()
9200:         ENDIF
9201:     ENDPROC
9202: 
9203:     *--------------------------------------------------------------------------
9204:     * TxtCodAcbKeyPress - KeyPress no campo Acabamento (ENTER/F4 abre lookup SigCdAca)
9205:     *--------------------------------------------------------------------------
9206:     PROCEDURE TxtCodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9207:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9208:             THIS.ValidarCodAcb()
9209:         ENDIF
9210:         IF par_nKeyCode = 115
9211:             THIS.AbrirLookupAcb()
9212:         ENDIF
9213:     ENDPROC
9214: 
9215:     *--------------------------------------------------------------------------
9216:     * TxtClassKeyPress - KeyPress no campo Classe (ENTER/F4 abre lookup SIGCDCLS)
9217:     *--------------------------------------------------------------------------
9218:     PROCEDURE TxtClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9219:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9220:             THIS.ValidarClass()
9221:         ENDIF
9222:         IF par_nKeyCode = 115
9223:             THIS.AbrirLookupClass()
9224:         ENDIF
9225:     ENDPROC
9226: 
9227:     *--------------------------------------------------------------------------
9228:     * TxtLocalKeyPress - KeyPress no campo Local (ENTER/F4 abre lookup SigPrLcl)
9229:     *--------------------------------------------------------------------------
9230:     PROCEDURE TxtLocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9231:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9232:             THIS.ValidarLocal()
9233:         ENDIF
9234:         IF par_nKeyCode = 115
9235:             THIS.AbrirLookupLocal()
9236:         ENDIF
9237:     ENDPROC
9238: 
9239:     *--------------------------------------------------------------------------
9240:     * TxtCuniKeyPress - KeyPress no campo Unidade (ENTER/F4 abre lookup SigCdUni)
9241:     *--------------------------------------------------------------------------
9242:     PROCEDURE TxtCuniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9243:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9244:             THIS.ValidarCuni()
9245:         ENDIF
9246:         IF par_nKeyCode = 115
9247:             THIS.AbrirLookupUni()
9248:         ENDIF
9249:     ENDPROC
9250: 
9251:     *--------------------------------------------------------------------------
9252:     * TxtCunipKeyPress - KeyPress no campo Uni.Pedido (ENTER/F4 abre lookup SigCdUni)
9253:     *--------------------------------------------------------------------------
9254:     PROCEDURE TxtCunipKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9255:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9256:             THIS.ValidarCunip()
9257:         ENDIF
9258:         IF par_nKeyCode = 115
9259:             THIS.AbrirLookupUniP()
9260:         ENDIF
9261:     ENDPROC
9262: 
9263:     *--------------------------------------------------------------------------
9264:     * TxtMctotalKeyPress - KeyPress no campo Moeda Custo (ENTER/F4 abre lookup SigCdMoe)
9265:     *--------------------------------------------------------------------------
9266:     PROCEDURE TxtMctotalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9267:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9268:             THIS.ValidarMoe("total")
9269:         ENDIF
9270:         IF par_nKeyCode = 115
9271:             THIS.AbrirLookupMctotal()
9272:         ENDIF
9273:     ENDPROC
9274: 
9275:     *--------------------------------------------------------------------------
9276:     * TxtMpvendaKeyPress - KeyPress no campo Moeda P.Venda (ENTER/F4 abre lookup SigCdMoe)
9277:     *--------------------------------------------------------------------------
9278:     PROCEDURE TxtMpvendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9279:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9280:             THIS.ValidarMoe("pvenda")
9281:         ENDIF
9282:         IF par_nKeyCode = 115
9283:             THIS.AbrirLookupMpvenda()
9284:         ENDIF
9285:     ENDPROC
9286: 
9287:     *--------------------------------------------------------------------------
9288:     * TxtMfvendaKeyPress - KeyPress no campo Moeda F.Venda (ENTER/F4 abre lookup SigCdMoe)
9289:     *--------------------------------------------------------------------------
9290:     PROCEDURE TxtMfvendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9291:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9292:             THIS.ValidarMoe("fvenda")
9293:         ENDIF
9294:         IF par_nKeyCode = 115
9295:             THIS.AbrirLookupMfvenda()
9296:         ENDIF
9297:     ENDPROC
9298: 
9299:     *==========================================================================
9300:     * HANDLERS - FASE 9 - pgComposicao
9301:     *==========================================================================
9302: 
9303:     *--------------------------------------------------------------------------
9304:     * GrdCompoAfterRowColChange - AfterRowColChange do grid de composicao
9305:     * Refresha campos de descricao e observacao da OF quando muda a linha
9306:     *--------------------------------------------------------------------------
9307:     PROCEDURE GrdCompoAfterRowColChange(par_nColIndex)
9308:         LOCAL loc_oPg
9309:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9310:         IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
9311:             loc_oPg.txt_4c_DescComp.Value = ALLTRIM(cursor_4c_Compo.dcompos)
9312:             loc_oPg.txt_4c_ObsOFs.Value   = ALLTRIM(cursor_4c_Compo.obscompos)
9313:         ELSE
9314:             loc_oPg.txt_4c_DescComp.Value = ""
9315:             loc_oPg.txt_4c_ObsOFs.Value   = ""
9316:         ENDIF
9317:     ENDPROC
9318: 
9319:     *--------------------------------------------------------------------------
9320:     * GrdSubCpAfterRowColChange - AfterRowColChange do grid de sub-composicao
9321:     *--------------------------------------------------------------------------
9322:     PROCEDURE GrdSubCpAfterRowColChange(par_nColIndex)
9323:         LOCAL loc_oPg
9324:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9325:         IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
9326:             loc_oPg.txt_4c_DescSubCp.Value = ALLTRIM(cursor_4c_SubCp.dcompos)
9327:             loc_oPg.txt_4c_MatSubs.Value   = ALLTRIM(cursor_4c_SubCp.matsubs)
9328:         ELSE
9329:             loc_oPg.txt_4c_DescSubCp.Value = ""
9330:             loc_oPg.txt_4c_MatSubs.Value   = ""
9331:         ENDIF
9332:     ENDPROC
9333: 
9334:     *--------------------------------------------------------------------------
9335:     * ChkLiberaCustoClick - habilitar/desabilitar campos de custo
9336:     *--------------------------------------------------------------------------
9337:     PROCEDURE ChkLiberaCustoClick()
9338:         LOCAL loc_oPg, loc_lLiberado
9339:         loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9340:         loc_lLiberado = (loc_oPg.chk_4c_LiberaCusto.Value = 1)
9341:         loc_oPg.txt_4c_Pcus.ReadOnly      = !loc_lLiberado
9342:         loc_oPg.txt_4c_Fcusto.ReadOnly    = !loc_lLiberado
9343:         loc_oPg.txt_4c_Moec.ReadOnly      = !loc_lLiberado
9344:         loc_oPg.txt_4c_Moepc.ReadOnly     = !loc_lLiberado
9345:         loc_oPg.txt_4c_CotaCalcP.ReadOnly = !loc_lLiberado
9346:         IF loc_lLiberado
9347:             loc_oPg.txt_4c_Pcus.BackColor   = RGB(255, 255, 255)
9348:             loc_oPg.txt_4c_Fcusto.BackColor  = RGB(255, 255, 255)
9349:             loc_oPg.txt_4c_CotaCalcP.BackColor = RGB(255, 255, 255)
9350:         ELSE
9351:             loc_oPg.txt_4c_Pcus.BackColor   = RGB(224, 235, 235)
9352:             loc_oPg.txt_4c_Fcusto.BackColor  = RGB(224, 235, 235)
9353:             loc_oPg.txt_4c_CotaCalcP.BackColor = RGB(224, 235, 235)
9354:         ENDIF
9355:     ENDPROC
9356: 
9357:     *--------------------------------------------------------------------------
9358:     * ChkLiberaVendaClick - habilitar/desabilitar campos de venda
9359:     *--------------------------------------------------------------------------
9360:     PROCEDURE ChkLiberaVendaClick()
9361:         LOCAL loc_oPg, loc_lLiberado
9362:         loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9363:         loc_lLiberado = (loc_oPg.chk_4c_LiberaVenda.Value = 1)
9364:         loc_oPg.txt_4c_FAtuals.ReadOnly = !loc_lLiberado
9365:         loc_oPg.txt_4c_Fideals.ReadOnly = !loc_lLiberado
9366:         IF loc_lLiberado
9367:             loc_oPg.txt_4c_FAtuals.BackColor = RGB(255, 255, 255)
9368:             loc_oPg.txt_4c_Fideals.BackColor = RGB(255, 255, 255)
9369:         ELSE
9370:             loc_oPg.txt_4c_FAtuals.BackColor = RGB(224, 235, 235)
9371:             loc_oPg.txt_4c_Fideals.BackColor = RGB(224, 235, 235)
9372:         ENDIF
9373:     ENDPROC
9374: 
9375:     *--------------------------------------------------------------------------
9376:     * TxtPcusValid - Valid no campo Preco de Custo -> recalcula precos
9377:     *--------------------------------------------------------------------------
9378:     PROCEDURE TxtPcusValid()
9379:         THIS.CalcPrecoComposicao()
9380:     ENDPROC
9381: 
9382:     *--------------------------------------------------------------------------
9383:     * TxtFcustoValid - Valid no campo Fator de Custo -> recalcula precos
9384:     *--------------------------------------------------------------------------
9385:     PROCEDURE TxtFcustoValid()
9386:         THIS.CalcPrecoComposicao()
9387:     ENDPROC
9388: 
9389:     *--------------------------------------------------------------------------
9390:     * TxtMargemValid - Valid na Margem/MKP -> recalcula precos
9391:     *--------------------------------------------------------------------------
9392:     PROCEDURE TxtMargemValid()
9393:         THIS.CalcPrecoComposicao()
9394:     ENDPROC
9395: 
9396:     *--------------------------------------------------------------------------
9397:     * TxtMarkupAValid - Valid no MarkupA -> recalcula precos
9398:     *--------------------------------------------------------------------------
9399:     PROCEDURE TxtMarkupAValid()
9400:         THIS.CalcPrecoComposicao()
9401:     ENDPROC
9402: 
9403:     *--------------------------------------------------------------------------
9404:     * TxtCotaCalcPValid - Valid na Cotacao -> recalcula precos
9405:     *--------------------------------------------------------------------------
9406:     PROCEDURE TxtCotaCalcPValid()
9407:         THIS.CalcPrecoComposicao()
9408:         LOCAL loc_oPg
9409:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9410:         loc_oPg.Refresh()
9411:     ENDPROC
9412: 
9413:     *--------------------------------------------------------------------------
9414:     * TxtMoecKeyPress - KeyPress no campo Moeda Custo (ENTER/F4 abre lookup SigCdMoe)
9415:     *--------------------------------------------------------------------------
9416:     PROCEDURE TxtMoecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9417:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9418:             THIS.ValidarMoeCompo("moec")
9419:         ENDIF
9420:         IF par_nKeyCode = 115
9421:             THIS.AbrirLookupMoeCompo("moec")
9422:         ENDIF
9423:     ENDPROC
9424: 
9425:     *--------------------------------------------------------------------------
9426:     * TxtMoepcKeyPress - KeyPress no campo Moeda P.Custo (ENTER/F4 abre lookup SigCdMoe)
9427:     *--------------------------------------------------------------------------
9428:     PROCEDURE TxtMoepcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9429:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9430:             THIS.ValidarMoeCompo("moepc")
9431:         ENDIF
9432:         IF par_nKeyCode = 115
9433:             THIS.AbrirLookupMoeCompo("moepc")
9434:         ENDIF
9435:     ENDPROC
9436: 
9437:     *--------------------------------------------------------------------------
9438:     * TxtMoedaKeyPress - KeyPress no campo Moeda Venda (ENTER/F4 abre lookup SigCdMoe)
9439:     *--------------------------------------------------------------------------
9440:     PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9441:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9442:             THIS.ValidarMoeCompo("moeda")
9443:         ENDIF
9444:         IF par_nKeyCode = 115
9445:             THIS.AbrirLookupMoeCompo("moeda")
9446:         ENDIF
9447:     ENDPROC
9448: 
9449:     *--------------------------------------------------------------------------
9450:     * TxtMoepvKeyPress - KeyPress no campo Moeda P.Venda (ENTER/F4 abre lookup SigCdMoe)
9451:     *--------------------------------------------------------------------------
9452:     PROCEDURE TxtMoepvKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9453:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9454:             THIS.ValidarMoeCompo("moepv")
9455:         ENDIF
9456:         IF par_nKeyCode = 115
9457:             THIS.AbrirLookupMoeCompo("moepv")
9458:         ENDIF
9459:     ENDPROC
9460: 
9461:     *--------------------------------------------------------------------------
9462:     * ValidarMoeCompo - Valida campo de moeda na pagina composicao
9463:     * par_cTipo: "moec"|"moepc"|"moeda"|"moepv"
9464:     *--------------------------------------------------------------------------
9465:     PROTECTED PROCEDURE ValidarMoeCompo(par_cTipo)
9466:         LOCAL loc_oPg, loc_oTxt, loc_cCodMoe, loc_cSQL, loc_lOk
9467:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9468:         DO CASE
9469:         CASE par_cTipo = "moec"
9470:             loc_oTxt = loc_oPg.txt_4c_Moec
9471:         CASE par_cTipo = "moepc"
9472:             loc_oTxt = loc_oPg.txt_4c_Moepc
9473:         CASE par_cTipo = "moeda"
9474:             loc_oTxt = loc_oPg.txt_4c_Moeda
9475:         CASE par_cTipo = "moepv"
9476:             loc_oTxt = loc_oPg.txt_4c_Moepv
9477:         OTHERWISE
9478:             RETURN
9479:         ENDCASE
9480:         loc_cCodMoe = ALLTRIM(loc_oTxt.Value)
9481:         IF EMPTY(loc_cCodMoe)
9482:             RETURN
9483:         ENDIF
9484:         loc_lOk = .F.
9485:         TRY
9486:             loc_cSQL = "SELECT cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCodMoe)
9487:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeCompo") > 0
9488:                 loc_lOk = .T.
9489:             ENDIF
9490:         CATCH TO loc_oErro
9491:             MsgErro(loc_oErro.Message, "Erro ao validar moeda")
9492:         ENDTRY
9493:         IF loc_lOk
9494:             IF EOF("cursor_4c_BuscaMoeCompo")
9495:                 MsgAviso("Moeda " + loc_cCodMoe + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9496:                 loc_oTxt.Value = ""
9497:             ENDIF
9498:             IF USED("cursor_4c_BuscaMoeCompo")
9499:                 USE IN cursor_4c_BuscaMoeCompo
9500:             ENDIF
9501:         ENDIF
9502:     ENDPROC
9503: 
9504:     *--------------------------------------------------------------------------
9505:     * AbrirLookupMoeCompo - Abre lookup de moeda na pagina composicao
9506:     *--------------------------------------------------------------------------
9507:     PROTECTED PROCEDURE AbrirLookupMoeCompo(par_cTipo)
9508:         LOCAL loc_oBusca, loc_oPg, loc_oTxt
9509:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9510:         DO CASE
9511:         CASE par_cTipo = "moec"
9512:             loc_oTxt = loc_oPg.txt_4c_Moec
9513:         CASE par_cTipo = "moepc"
9514:             loc_oTxt = loc_oPg.txt_4c_Moepc
9515:         CASE par_cTipo = "moeda"
9516:             loc_oTxt = loc_oPg.txt_4c_Moeda
9517:         CASE par_cTipo = "moepv"
9518:             loc_oTxt = loc_oPg.txt_4c_Moepv
9519:         OTHERWISE
9520:             RETURN
9521:         ENDCASE
9522:         TRY
9523:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
9524:             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMoeCompo"
9525:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
9526:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
9527:             loc_oBusca.cTabela    = "SigCdMoe"
9528:             loc_oBusca.cCampoChave = "cmoes"
9529:             loc_oBusca.cFiltroIni = ALLTRIM(loc_oTxt.Value)
9530:             loc_oBusca.Show()
9531:             IF loc_oBusca.this_lSelecionou
9532:                 loc_oTxt.Value = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
9533:             ENDIF
9534:             IF USED("cursor_4c_BuscaMoeCompo")
9535:                 USE IN cursor_4c_BuscaMoeCompo
9536:             ENDIF
9537:             loc_oBusca.Release()
9538:         CATCH TO loc_oErro
9539:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de moeda")
9540:         ENDTRY
9541:     ENDPROC
9542: 
9543:     *--------------------------------------------------------------------------
9544:     * CalcPrecoComposicao - Recalcula precos baseado nos valores de custo/margem
9545:     * Equivalente ao CalcPreco/CalcPreMoe do legado (stub - logica completa no BO)
9546:     *--------------------------------------------------------------------------
9547:     PROTECTED PROCEDURE CalcPrecoComposicao()
9548:         LOCAL loc_oPg, loc_nPcus, loc_nMargem, loc_nPven
9549:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9550:         loc_nPcus  = loc_oPg.txt_4c_Pcus.Value
9551:         loc_nMargem = loc_oPg.txt_4c_Margem.Value
9552:         *-- Calculo simplificado: Preco Venda = Custo * (1 + Margem/100)
9553:         *-- O calculo completo com fatores/moedas sera feito via BO
9554:         IF loc_nMargem > 0 AND loc_nPcus > 0
9555:             loc_nPven = loc_nPcus * (1 + loc_nMargem / 100)
9556:             loc_oPg.txt_4c_Pvens.Value = loc_nPven
9557:         ENDIF
9558:     ENDPROC
9559: 
9560:     *--------------------------------------------------------------------------
9561:     * CmdCalcValsClick - Botao Calcular Valores (cmdCalcVals)
9562:     * Aciona recalculo completo de precos (equivalente ao CalcPreco do legado)
9563:     *--------------------------------------------------------------------------
9564:     PROCEDURE CmdCalcValsClick()
9565:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9566:             RETURN
9567:         ENDIF
9568:         THIS.CalcPrecoComposicao()
9569:     ENDPROC
9570: 
9571:     *--------------------------------------------------------------------------
9572:     * CmdPesoMClick - Botao calcular peso medio (abre form sigcdpes)
9573:     *--------------------------------------------------------------------------
9574:     PROCEDURE CmdPesoMClick()
9575:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o de c" + CHR(225) + "lculo de peso n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Peso M" + CHR(233) + "dio")
9576:     ENDPROC
9577: 
9578:     *--------------------------------------------------------------------------
9579:     * CmdgCompoClick - Click no CommandGroup de composicao (5 botoes)
9580:     * .Value=1 Inserir | 2 Excluir | 3 Atualizar Custo | 4 Atualizar Preco | 5 Atualizar Pesos
9581:     *--------------------------------------------------------------------------
9582:     PROCEDURE CmdgCompoClick()
9583:         LOCAL loc_oPg, loc_nBtn, loc_oGrd
9584:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9585:         loc_nBtn = loc_oPg.obj_4c_CmdgCompo.Value
9586:         loc_oGrd = loc_oPg.grd_4c_Compo
9587: 
9588:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9589:             RETURN
9590:         ENDIF
9591: 
9592:         DO CASE
9593:         CASE loc_nBtn = 1
9594:             *-- Inserir item de composicao
9595:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9596:                 MsgAviso("Selecione o modo Incluir ou Alterar para inserir itens.", "Aten" + CHR(231) + CHR(227) + "o")
9597:                 RETURN
9598:             ENDIF
9599:             IF USED("cursor_4c_Compo")
9600:                 SELECT cursor_4c_Compo
9601:                 APPEND BLANK
9602:                 loc_oGrd.Refresh()
9603:             ENDIF
9604: 
9605:         CASE loc_nBtn = 2
9606:             *-- Excluir item de composicao
9607:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9608:                 RETURN
9609:             ENDIF
9610:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
9611:                 IF MsgConfirma("Excluir o item selecionado?", "Confirmar")
9612:                     SELECT cursor_4c_Compo
9613:                     DELETE
9614:                     IF !EOF("cursor_4c_Compo")
9615:                         SKIP
9616:                         SKIP -1
9617:                     ENDIF
9618:                     loc_oGrd.Refresh()
9619:                 ENDIF
9620:             ENDIF
9621: 
9622:         CASE loc_nBtn = 3
9623:             *-- Atualizar custo
9624:             THIS.CalcPrecoComposicao()
9625: 
9626:         CASE loc_nBtn = 4
9627:             *-- Atualizar preco
9628:             THIS.CalcPrecoComposicao()
9629: 
9630:         CASE loc_nBtn = 5
9631:             *-- Atualizar pesos
9632:             THIS.CmdPesoMClick()
9633: 
9634:         ENDCASE
9635:     ENDPROC
9636: 
9637:     *--------------------------------------------------------------------------
9638:     * CmdgSubCpClick - Click no CommandGroup de sub-composicao (2 botoes)
9639:     * .Value=1 Inserir | 2 Excluir
9640:     *--------------------------------------------------------------------------
9641:     PROCEDURE CmdgSubCpClick()
9642:         LOCAL loc_oPg, loc_nBtn, loc_oGrd
9643:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9644:         loc_nBtn = loc_oPg.obj_4c_CmdgSubCp.Value
9645:         loc_oGrd = loc_oPg.grd_4c_SubCp
9646: 
9647:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9648:             RETURN
9649:         ENDIF
9650: 
9651:         DO CASE
9652:         CASE loc_nBtn = 1
9653:             *-- Inserir item de sub-composicao
9654:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9655:                 MsgAviso("Selecione o modo Incluir ou Alterar para inserir itens.", "Aten" + CHR(231) + CHR(227) + "o")
9656:                 RETURN
9657:             ENDIF
9658:             IF USED("cursor_4c_SubCp")
9659:                 SELECT cursor_4c_SubCp
9660:                 APPEND BLANK
9661:                 loc_oGrd.Refresh()
9662:             ENDIF
9663: 
9664:         CASE loc_nBtn = 2
9665:             *-- Excluir item de sub-composicao
9666:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9667:                 RETURN
9668:             ENDIF
9669:             IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
9670:                 IF MsgConfirma("Excluir o sub-item selecionado?", "Confirmar")
9671:                     SELECT cursor_4c_SubCp
9672:                     DELETE
9673:                     IF !EOF("cursor_4c_SubCp")
9674:                         SKIP
9675:                         SKIP -1
9676:                     ENDIF
9677:                     loc_oGrd.Refresh()
9678:                 ENDIF
9679:             ENDIF
9680: 
9681:         ENDCASE
9682:     ENDPROC
9683: 
9684:     *--------------------------------------------------------------------------
9685:     * GrdCustoCompoAfterRowColChange - AfterRowColChange do grid Custo
9686:     * Atualiza txt_4c_Desc (descricao item) e txt_4c_DGruCompos (desc grupo)
9687:     *--------------------------------------------------------------------------
9688:     PROCEDURE GrdCustoCompoAfterRowColChange(par_nColIndex)
9689:         LOCAL loc_oPg, loc_cGrupo, loc_nRet, loc_oErro
9690:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9691: 
9692:         IF USED("cursor_4c_CustoCompo") AND !EOF("cursor_4c_CustoCompo")
9693:             loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_CustoCompo.dcompos)
9694:             loc_cGrupo = ALLTRIM(cursor_4c_CustoCompo.CGrus)
9695:             IF !EMPTY(loc_cGrupo)
9696:                 TRY
9697:                     loc_nRet = SQLEXEC(gnConnHandle, ;
9698:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cGrupo), ;
9699:                         "cursor_4c_GruCustoDesc")
9700:                     IF loc_nRet > 0 AND USED("cursor_4c_GruCustoDesc") AND !EOF("cursor_4c_GruCustoDesc")
9701:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_GruCustoDesc.DGrus)
9702:                     ELSE
9703:                         loc_oPg.txt_4c_DGruCompos.Value = ""
9704:                     ENDIF
9705:                     IF USED("cursor_4c_GruCustoDesc")
9706:                         USE IN cursor_4c_GruCustoDesc
9707:                     ENDIF
9708:                 CATCH TO loc_oErro
9709:                     MsgErro(loc_oErro.Message, "Erro ao buscar grupo da composi" + CHR(231) + CHR(227) + "o")
9710:                 ENDTRY
9711:             ELSE
9712:                 loc_oPg.txt_4c_DGruCompos.Value = ""
9713:             ENDIF
9714:         ELSE
9715:             loc_oPg.txt_4c_Desc.Value       = ""
9716:             loc_oPg.txt_4c_DGruCompos.Value = ""
9717:         ENDIF
9718:     ENDPROC
9719: 
9720:     *--------------------------------------------------------------------------
9721:     * CmdgCustoClick - Click no CommandGroup de composicao Custo (2 botoes)
9722:     * .Value=1 Inserir | .Value=2 Excluir
9723:     *--------------------------------------------------------------------------
9724:     PROCEDURE CmdgCustoClick()
9725:         LOCAL loc_oPg, loc_nBtn, loc_oGrd
9726:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9727:         loc_nBtn = loc_oPg.obj_4c_CmdgCusto.Value
9728:         loc_oGrd = loc_oPg.grd_4c_CustoCompo
9729: 
9730:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9731:             RETURN
9732:         ENDIF
9733: 
9734:         DO CASE
9735:         CASE loc_nBtn = 1
9736:             *-- Inserir item de composicao custo
9737:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9738:                 MsgAviso("Selecione o modo Incluir ou Alterar para inserir itens.", "Aten" + CHR(231) + CHR(227) + "o")
9739:                 RETURN
9740:             ENDIF
9741:             IF USED("cursor_4c_CustoCompo")
9742:                 SELECT cursor_4c_CustoCompo
9743:                 APPEND BLANK
9744:                 loc_oGrd.Refresh()
9745:             ENDIF
9746: 
9747:         CASE loc_nBtn = 2
9748:             *-- Excluir item de composicao custo
9749:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9750:                 RETURN
9751:             ENDIF
9752:             IF USED("cursor_4c_CustoCompo") AND !EOF("cursor_4c_CustoCompo")
9753:                 IF MsgConfirma("Excluir o item selecionado?", "Confirmar")
9754:                     SELECT cursor_4c_CustoCompo
9755:                     DELETE
9756:                     IF !EOF("cursor_4c_CustoCompo")
9757:                         SKIP
9758:                         SKIP -1
9759:                     ENDIF
9760:                     loc_oGrd.Refresh()
9761:                 ENDIF
9762:             ENDIF
9763: 
9764:         ENDCASE
9765:     ENDPROC
9766: 
9767:     *--------------------------------------------------------------------------
9768:     * CboTiposCustoInteractiveChange - InteractiveChange do cmbTipos na aba Custo
9769:     * Filtra/recarrega grid de composicao pelo tipo selecionado
9770:     *--------------------------------------------------------------------------
9771:     PROCEDURE CboTiposCustoInteractiveChange()
9772:         LOCAL loc_oPg
9773:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9774: 
9775:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9776:             RETURN
9777:         ENDIF
9778: 
9779:         IF USED("cursor_4c_CustoCompo")
9780:             GO TOP IN cursor_4c_CustoCompo
9781:         ENDIF
9782:         loc_oPg.grd_4c_CustoCompo.Refresh()
9783:     ENDPROC
9784: 
9785:     *==========================================================================
9786:     * VALIDACOES - FASE 6
9787:     *==========================================================================
9788: 
9789:     *--------------------------------------------------------------------------
9790:     * ValidarCor - Valida e carrega tooltip da cor (SigCdCor)
9791:     *--------------------------------------------------------------------------
9792:     PROTECTED PROCEDURE ValidarCor()
9793:         LOCAL loc_cCodCor, loc_oPg
9794:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9795:         loc_cCodCor = ALLTRIM(loc_oPg.txt_4c_Cor.Value)
9796:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9797:             RETURN
9798:         ENDIF
9799:         THIS.CarregarDescCor(loc_cCodCor)
9800:     ENDPROC
9801: 
9802:     *--------------------------------------------------------------------------
9803:     * ValidarTam - Valida e carrega tooltip do tamanho (SigCdTam)
9804:     *--------------------------------------------------------------------------
9805:     PROTECTED PROCEDURE ValidarTam()
9806:         LOCAL loc_cCodTam, loc_oPg
9807:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9808:         loc_cCodTam = ALLTRIM(loc_oPg.txt_4c_Tam.Value)
9809:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9810:             RETURN
9811:         ENDIF
9812:         THIS.CarregarDescTam(loc_cCodTam)
9813:     ENDPROC
9814: 
9815:     *--------------------------------------------------------------------------
9816:     * ValidarCodFinP - Valida campo ficha e carrega descricao (SigCdFip)
9817:     *--------------------------------------------------------------------------
9818:     PROTECTED PROCEDURE ValidarCodFinP()
9819:         LOCAL loc_cCodFinP, loc_oPg
9820:         loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9821:         loc_cCodFinP = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
9822:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9823:             RETURN
9824:         ENDIF
9825:         THIS.CarregarDescFinP(loc_cCodFinP)
9826:         IF !EMPTY(loc_cCodFinP) AND EMPTY(loc_oPg.txt_4c_DesFinP.Value)
9827:             MsgAviso("Ficha " + loc_cCodFinP + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9828:         ENDIF
9829:     ENDPROC
9830: 
9831:     *--------------------------------------------------------------------------
9832:     * ValidarCodAcb - Valida campo acabamento e carrega descricao (SigCdAca)
9833:     *--------------------------------------------------------------------------
9834:     PROTECTED PROCEDURE ValidarCodAcb()
9835:         LOCAL loc_cCodAcb, loc_oPg
9836:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9837:         loc_cCodAcb = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
9838:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9839:             RETURN
9840:         ENDIF
9841:         THIS.CarregarDescAcb(loc_cCodAcb)
9842:         IF !EMPTY(loc_cCodAcb) AND EMPTY(loc_oPg.txt_4c_DacbDisplay.Value)
9843:             MsgAviso("Acabamento " + loc_cCodAcb + " n" + CHR(227) + "o encontrado.", "Inv" + CHR(225) + "lido")
9844:         ENDIF
9845:     ENDPROC
9846: 
9847:     *--------------------------------------------------------------------------
9848:     * ValidarClass - Valida campo classificacao e carrega descricao (SIGCDCLS)
9849:     *--------------------------------------------------------------------------
9850:     PROTECTED PROCEDURE ValidarClass()
9851:         LOCAL loc_cCclass, loc_oPg
9852:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9853:         loc_cCclass = ALLTRIM(loc_oPg.txt_4c_Class.Value)
9854:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9855:             RETURN
9856:         ENDIF
9857:         THIS.CarregarDescClass(loc_cCclass)
9858:         IF !EMPTY(loc_cCclass) AND EMPTY(loc_oPg.txt_4c_DClassDisplay.Value)
9859:             MsgAviso("Classifica" + CHR(231) + CHR(227) + "o " + loc_cCclass + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9860:         ENDIF
9861:     ENDPROC
9862: 
9863:     *--------------------------------------------------------------------------
9864:     * ValidarLocal - Valida campo local (SigPrLcl)
9865:     *--------------------------------------------------------------------------
9866:     PROTECTED PROCEDURE ValidarLocal()
9867:         LOCAL loc_cLocals, loc_oPg
9868:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9869:         loc_cLocals = ALLTRIM(loc_oPg.txt_4c_Local.Value)
9870:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9871:             RETURN
9872:         ENDIF
9873:         THIS.CarregarDescLocal(loc_cLocals)
9874:     ENDPROC
9875: 
9876:     *--------------------------------------------------------------------------
9877:     * ValidarCuni - Valida campo unidade e carrega descricao (SigCdUni)
9878:     *--------------------------------------------------------------------------
9879:     PROTECTED PROCEDURE ValidarCuni()
9880:         LOCAL loc_cCunis, loc_oPg
9881:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9882:         loc_cCunis  = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
9883:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9884:             RETURN
9885:         ENDIF
9886:         THIS.CarregarDescUni(loc_cCunis, "uni")
9887:         IF !EMPTY(loc_cCunis) AND EMPTY(loc_oPg.txt_4c_DuniDisplay.Value)
9888:             MsgAviso("Unidade " + loc_cCunis + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9889:         ENDIF
9890:     ENDPROC
9891: 
9892:     *--------------------------------------------------------------------------
9893:     * ValidarCunip - Valida campo unidade de pedido (SigCdUni)
9894:     *--------------------------------------------------------------------------
9895:     PROTECTED PROCEDURE ValidarCunip()
9896:         LOCAL loc_cCunips, loc_oPg
9897:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9898:         loc_cCunips = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
9899:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9900:             RETURN
9901:         ENDIF
9902:         THIS.CarregarDescUni(loc_cCunips, "unip")
9903:         IF !EMPTY(loc_cCunips) AND EMPTY(loc_oPg.txt_4c_DunipDisplay.Value)
9904:             MsgAviso("Unidade " + loc_cCunips + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9905:         ENDIF
9906:     ENDPROC
9907: 
9908:     *--------------------------------------------------------------------------
9909:     * ValidarMoe - Valida campo moeda (SigCdMoe)
9910:     * par_cTipo: "total" | "pvenda" | "fvenda"
9911:     *--------------------------------------------------------------------------
9912:     PROTECTED PROCEDURE ValidarMoe(par_cTipo)
9913:         LOCAL loc_cCmoes, loc_oPg
9914:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9915:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9916:             RETURN
9917:         ENDIF
9918:         DO CASE
9919:         CASE par_cTipo = "total"
9920:             loc_cCmoes = ALLTRIM(loc_oPg.txt_4c_Mctotal.Value)
9921:         CASE par_cTipo = "pvenda"
9922:             loc_cCmoes = ALLTRIM(loc_oPg.txt_4c_Mpvenda.Value)
9923:         OTHERWISE
9924:             loc_cCmoes = ALLTRIM(loc_oPg.txt_4c_Mfvenda.Value)
9925:         ENDCASE
9926:         THIS.CarregarDescMoe(loc_cCmoes, par_cTipo)
9927:     ENDPROC
9928: 
9929:     *==========================================================================
9930:     * LOOKUPS - FASE 6
9931:     *==========================================================================
9932: 
9933:     *--------------------------------------------------------------------------
9934:     * AbrirLookupCor - Abre busca de cor (SigCdCor)
9935:     *--------------------------------------------------------------------------
9936:     PROCEDURE AbrirLookupCor()
9937:         LOCAL loc_oBusca, loc_oPg
9938:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9939:         TRY
9940:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9941:                 "SigCdCor", "cursor_4c_BuscaCor", "cods", ;
9942:                 ALLTRIM(loc_oPg.txt_4c_Cor.Value), "Busca de Cor")
9943:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9944:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9945:             loc_oBusca.Show()
9946:             IF loc_oBusca.this_lSelecionou
9947:                 IF USED("cursor_4c_BuscaCor")
9948:                     SELECT cursor_4c_BuscaCor
9949:                     loc_oPg.txt_4c_Cor.Value = ALLTRIM(cods)
9950:                     USE IN cursor_4c_BuscaCor
9951:                 ENDIF
9952:             ENDIF
9953:             loc_oBusca.Release()
9954:             loc_oBusca = .NULL.
9955:         CATCH TO loc_oErro
9956:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de cor")
9957:         ENDTRY
9958:     ENDPROC
9959: 
9960:     *--------------------------------------------------------------------------
9961:     * AbrirLookupTam - Abre busca de tamanho (SigCdTam)
9962:     *--------------------------------------------------------------------------
9963:     PROCEDURE AbrirLookupTam()
9964:         LOCAL loc_oBusca, loc_oPg
9965:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9966:         TRY
9967:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9968:                 "SigCdTam", "cursor_4c_BuscaTam", "cods", ;
9969:                 ALLTRIM(loc_oPg.txt_4c_Tam.Value), "Busca de Tamanho")
9970:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9971:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9972:             loc_oBusca.Show()
9973:             IF loc_oBusca.this_lSelecionou
9974:                 IF USED("cursor_4c_BuscaTam")
9975:                     SELECT cursor_4c_BuscaTam
9976:                     loc_oPg.txt_4c_Tam.Value = ALLTRIM(cods)
9977:                     USE IN cursor_4c_BuscaTam
9978:                 ENDIF
9979:             ENDIF
9980:             loc_oBusca.Release()
9981:             loc_oBusca = .NULL.
9982:         CATCH TO loc_oErro
9983:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de tamanho")
9984:         ENDTRY
9985:     ENDPROC
9986: 
9987:     *--------------------------------------------------------------------------
9988:     * AbrirLookupFinP - Abre busca de ficha de produto (SigCdFip)
9989:     *--------------------------------------------------------------------------
9990:     PROCEDURE AbrirLookupFinP()
9991:         LOCAL loc_oBusca, loc_oPg
9992:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9993:         TRY
9994:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9995:                 "SigCdFip", "cursor_4c_BuscaFinP", "cods", ;
9996:                 ALLTRIM(loc_oPg.txt_4c_CodFinP.Value), "Busca de Ficha")
9997:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9998:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9999:             loc_oBusca.Show()
10000:             IF loc_oBusca.this_lSelecionou
10001:                 IF USED("cursor_4c_BuscaFinP")
10002:                     SELECT cursor_4c_BuscaFinP
10003:                     loc_oPg.txt_4c_CodFinP.Value  = ALLTRIM(cods)
10004:                     loc_oPg.txt_4c_DesFinP.Value  = ALLTRIM(descs)
10005:                     USE IN cursor_4c_BuscaFinP
10006:                 ENDIF
10007:             ENDIF
10008:             loc_oBusca.Release()
10009:             loc_oBusca = .NULL.
10010:         CATCH TO loc_oErro
10011:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de ficha")
10012:         ENDTRY
10013:     ENDPROC
10014: 
10015:     *--------------------------------------------------------------------------
10016:     * AbrirLookupAcb - Abre busca de acabamento (SigCdAca)
10017:     *--------------------------------------------------------------------------
10018:     PROCEDURE AbrirLookupAcb()
10019:         LOCAL loc_oBusca, loc_oPg
10020:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10021:         TRY
10022:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10023:                 "SigCdAca", "cursor_4c_BuscaAcb", "cods", ;
10024:                 ALLTRIM(loc_oPg.txt_4c_CodAcb.Value), "Busca de Acabamento")
10025:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
10026:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
10027:             loc_oBusca.Show()
10028:             IF loc_oBusca.this_lSelecionou
10029:                 IF USED("cursor_4c_BuscaAcb")
10030:                     SELECT cursor_4c_BuscaAcb
10031:                     loc_oPg.txt_4c_CodAcb.Value       = ALLTRIM(cods)
10032:                     loc_oPg.txt_4c_DacbDisplay.Value  = ALLTRIM(descrs)
10033:                     USE IN cursor_4c_BuscaAcb
10034:                 ENDIF
10035:             ENDIF
10036:             loc_oBusca.Release()
10037:             loc_oBusca = .NULL.
10038:         CATCH TO loc_oErro
10039:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de acabamento")
10040:         ENDTRY
10041:     ENDPROC
10042: 
10043:     *--------------------------------------------------------------------------
10044:     * AbrirLookupClass - Abre busca de classificacao (SIGCDCLS)
10045:     *--------------------------------------------------------------------------
10046:     PROCEDURE AbrirLookupClass()
10047:         LOCAL loc_oBusca, loc_oPg
10048:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10049:         TRY
10050:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10051:                 "SIGCDCLS", "cursor_4c_BuscaClass", "cods", ;
10052:                 ALLTRIM(loc_oPg.txt_4c_Class.Value), ;
10053:                 "Busca de Classifica" + CHR(231) + CHR(227) + "o")
10054:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
10055:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10056:             loc_oBusca.Show()
10057:             IF loc_oBusca.this_lSelecionou
10058:                 IF USED("cursor_4c_BuscaClass")
10059:                     SELECT cursor_4c_BuscaClass
10060:                     loc_oPg.txt_4c_Class.Value         = ALLTRIM(cods)
10061:                     loc_oPg.txt_4c_DClassDisplay.Value = ALLTRIM(descs)
10062:                     USE IN cursor_4c_BuscaClass
10063:                 ENDIF
10064:             ENDIF
10065:             loc_oBusca.Release()
10066:             loc_oBusca = .NULL.
10067:         CATCH TO loc_oErro
10068:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o")
10069:         ENDTRY
10070:     ENDPROC
10071: 
10072:     *--------------------------------------------------------------------------
10073:     * AbrirLookupLocal - Abre busca de local (SigPrLcl)
10074:     *--------------------------------------------------------------------------
10075:     PROCEDURE AbrirLookupLocal()
10076:         LOCAL loc_oBusca, loc_oPg
10077:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10078:         TRY
10079:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10080:                 "SigPrLcl", "cursor_4c_BuscaLocal", "codigos", ;
10081:                 ALLTRIM(loc_oPg.txt_4c_Local.Value), "Busca de Local")
10082:             loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
10083:             loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10084:             loc_oBusca.Show()
10085:             IF loc_oBusca.this_lSelecionou
10086:                 IF USED("cursor_4c_BuscaLocal")
10087:                     SELECT cursor_4c_BuscaLocal
10088:                     loc_oPg.txt_4c_Local.Value = ALLTRIM(codigos)
10089:                     USE IN cursor_4c_BuscaLocal
10090:                 ENDIF
10091:             ENDIF
10092:             loc_oBusca.Release()
10093:             loc_oBusca = .NULL.
10094:         CATCH TO loc_oErro
10095:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de local")
10096:         ENDTRY
10097:     ENDPROC
10098: 
10099:     *--------------------------------------------------------------------------
10100:     * AbrirLookupUni - Abre busca de unidade (SigCdUni) para campo Cuni
10101:     *--------------------------------------------------------------------------
10102:     PROCEDURE AbrirLookupUni()
10103:         LOCAL loc_oBusca, loc_oPg
10104:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10105:         TRY
10106:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10107:                 "SigCdUni", "cursor_4c_BuscaUni", "cunis", ;
10108:                 ALLTRIM(loc_oPg.txt_4c_Cuni.Value), "Busca de Unidade")
10109:             loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
10110:             loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
10111:             loc_oBusca.Show()
10112:             IF loc_oBusca.this_lSelecionou
10113:                 IF USED("cursor_4c_BuscaUni")
10114:                     SELECT cursor_4c_BuscaUni
10115:                     loc_oPg.txt_4c_Cuni.Value          = ALLTRIM(cunis)
10116:                     loc_oPg.txt_4c_DuniDisplay.Value   = ALLTRIM(dunis)
10117:                     USE IN cursor_4c_BuscaUni
10118:                 ENDIF
10119:             ENDIF
10120:             loc_oBusca.Release()
10121:             loc_oBusca = .NULL.
10122:         CATCH TO loc_oErro
10123:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de unidade")
10124:         ENDTRY
10125:     ENDPROC
10126: 
10127:     *--------------------------------------------------------------------------
10128:     * AbrirLookupUniP - Abre busca de unidade de pedido (SigCdUni) para campo Cunip
10129:     *--------------------------------------------------------------------------
10130:     PROCEDURE AbrirLookupUniP()
10131:         LOCAL loc_oBusca, loc_oPg
10132:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10133:         TRY
10134:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10135:                 "SigCdUni", "cursor_4c_BuscaUniP", "cunis", ;
10136:                 ALLTRIM(loc_oPg.txt_4c_Cunip.Value), "Busca de Uni.Pedido")
10137:             loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
10138:             loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
10139:             loc_oBusca.Show()
10140:             IF loc_oBusca.this_lSelecionou
10141:                 IF USED("cursor_4c_BuscaUniP")
10142:                     SELECT cursor_4c_BuscaUniP
10143:                     loc_oPg.txt_4c_Cunip.Value          = ALLTRIM(cunis)
10144:                     loc_oPg.txt_4c_DunipDisplay.Value   = ALLTRIM(dunis)
10145:                     USE IN cursor_4c_BuscaUniP
10146:                 ENDIF
10147:             ENDIF
10148:             loc_oBusca.Release()
10149:             loc_oBusca = .NULL.
10150:         CATCH TO loc_oErro
10151:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de unidade de pedido")
10152:         ENDTRY
10153:     ENDPROC
10154: 
10155:     *--------------------------------------------------------------------------
10156:     * AbrirLookupMctotal - Abre busca de moeda custo (SigCdMoe)
10157:     *--------------------------------------------------------------------------
10158:     PROCEDURE AbrirLookupMctotal()
10159:         LOCAL loc_oBusca, loc_oPg
10160:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10161:         TRY
10162:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10163:                 "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
10164:                 ALLTRIM(loc_oPg.txt_4c_Mctotal.Value), "Busca de Moeda (Custo)")
10165:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
10166:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10167:             loc_oBusca.Show()
10168:             IF loc_oBusca.this_lSelecionou
10169:                 IF USED("cursor_4c_BuscaMoe")
10170:                     SELECT cursor_4c_BuscaMoe
10171:                     loc_oPg.txt_4c_Mctotal.Value = ALLTRIM(cmoes)
10172:                     THIS.CarregarDescMoe(ALLTRIM(cmoes), "total")
10173:                     USE IN cursor_4c_BuscaMoe
10174:                 ENDIF
10175:             ENDIF
10176:             loc_oBusca.Release()
10177:             loc_oBusca = .NULL.
10178:         CATCH TO loc_oErro
10179:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
10180:         ENDTRY
10181:     ENDPROC
10182: 
10183:     *--------------------------------------------------------------------------
10184:     * AbrirLookupMpvenda - Abre busca de moeda P.Venda (SigCdMoe)
10185:     *--------------------------------------------------------------------------
10186:     PROCEDURE AbrirLookupMpvenda()
10187:         LOCAL loc_oBusca, loc_oPg
10188:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10189:         TRY
10190:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10191:                 "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
10192:                 ALLTRIM(loc_oPg.txt_4c_Mpvenda.Value), "Busca de Moeda (P.Venda)")
10193:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
10194:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10195:             loc_oBusca.Show()
10196:             IF loc_oBusca.this_lSelecionou
10197:                 IF USED("cursor_4c_BuscaMoe")
10198:                     SELECT cursor_4c_BuscaMoe
10199:                     loc_oPg.txt_4c_Mpvenda.Value = ALLTRIM(cmoes)
10200:                     THIS.CarregarDescMoe(ALLTRIM(cmoes), "pvenda")
10201:                     USE IN cursor_4c_BuscaMoe
10202:                 ENDIF
10203:             ENDIF
10204:             loc_oBusca.Release()
10205:             loc_oBusca = .NULL.
10206:         CATCH TO loc_oErro
10207:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
10208:         ENDTRY
10209:     ENDPROC
10210: 
10211:     *--------------------------------------------------------------------------
10212:     * AbrirLookupMfvenda - Abre busca de moeda F.Venda (SigCdMoe)
10213:     *--------------------------------------------------------------------------
10214:     PROCEDURE AbrirLookupMfvenda()
10215:         LOCAL loc_oBusca, loc_oPg
10216:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10217:         TRY
10218:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10219:                 "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
10220:                 ALLTRIM(loc_oPg.txt_4c_Mfvenda.Value), "Busca de Moeda (F.Venda)")
10221:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
10222:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10223:             loc_oBusca.Show()
10224:             IF loc_oBusca.this_lSelecionou
10225:                 IF USED("cursor_4c_BuscaMoe")
10226:                     SELECT cursor_4c_BuscaMoe
10227:                     loc_oPg.txt_4c_Mfvenda.Value = ALLTRIM(cmoes)
10228:                     THIS.CarregarDescMoe(ALLTRIM(cmoes), "fvenda")
10229:                     USE IN cursor_4c_BuscaMoe
10230:                 ENDIF
10231:             ENDIF
10232:             loc_oBusca.Release()
10233:             loc_oBusca = .NULL.
10234:         CATCH TO loc_oErro
10235:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
10236:         ENDTRY
10237:     ENDPROC
10238: 
10239:     *==========================================================================
10240:     * HANDLERS - FASE 13: pgDadosFiscais
10241:     *==========================================================================
10242: 
10243:     *--------------------------------------------------------------------------
10244:     * TxtGruccusKeyPress - KeyPress em txt_4c_Gruccus (F4/F5 abre lookup SigCdGcr)
10245:     *--------------------------------------------------------------------------
10246:     PROCEDURE TxtGruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10247:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10248:             THIS.ValidarGruccus()
10249:         ENDIF
10250:         IF par_nKeyCode = 115
10251:             THIS.AbrirLookupGruccus()
10252:         ENDIF
10253:     ENDPROC
10254: 
10255:     *--------------------------------------------------------------------------
10256:     * ValidarGruccus - LostFocus/Enter em txt_4c_Gruccus
10257:     * Lookup: SigCdGcr (Codigos / Descrs)
10258:     *--------------------------------------------------------------------------
10259:     PROCEDURE ValidarGruccus()
10260:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10261:         loc_lResultado = .T.
10262:         TRY
10263:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10264:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Gruccus.Value, ""))
10265:             IF EMPTY(loc_cCodigo)
10266:                 loc_oPage.txt_4c_Dgruccus.Value    = ""
10267:                 loc_oPage.txt_4c_Contaccus.Value   = ""
10268:                 loc_oPage.txt_4c_Dcontaccus.Value  = ""
10269:                 loc_lResultado = loc_lResultado
10270:             ENDIF
10271:             loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10272:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGruccus") <= 0 OR EOF("cursor_4c_ValGruccus")
10273:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10274:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValGruccus"
10275:                 loc_oLookup.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10276:                 loc_oLookup.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10277:                 loc_oLookup.cTabela     = "SigCdGcr"
10278:                 loc_oLookup.cCampoChave = "Codigos"
10279:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10280:                 loc_oLookup.Show()
10281:                 IF loc_oLookup.this_lSelecionou
10282:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10283:                 ELSE
10284:                     loc_cCodigo = ""
10285:                 ENDIF
10286:             ELSE
10287:                 SELECT cursor_4c_ValGruccus
10288:                 loc_oPage.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10289:             ENDIF
10290:             IF USED("cursor_4c_ValGruccus")
10291:                 USE IN cursor_4c_ValGruccus
10292:             ENDIF
10293:             IF !EMPTY(loc_cCodigo)
10294:                 loc_oPage.txt_4c_Gruccus.Value = loc_cCodigo
10295:                 loc_oPage.txt_4c_Gruccus.Refresh()
10296:                 *-- Recarregar descricao se veio do lookup
10297:                 loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10298:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGruccus2") > 0 AND !EOF("cursor_4c_ValGruccus2")
10299:                     SELECT cursor_4c_ValGruccus2
10300:                     loc_oPage.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10301:                 ENDIF
10302:                 IF USED("cursor_4c_ValGruccus2")
10303:                     USE IN cursor_4c_ValGruccus2
10304:                 ENDIF
10305:             ELSE
10306:                 loc_oPage.txt_4c_Gruccus.Value    = ""
10307:                 loc_oPage.txt_4c_Dgruccus.Value   = ""
10308:                 loc_oPage.txt_4c_Contaccus.Value  = ""
10309:                 loc_oPage.txt_4c_Dcontaccus.Value = ""
10310:             ENDIF
10311:             loc_oPage.txt_4c_Dgruccus.Refresh()
10312:             loc_oPage.Refresh()
10313:         CATCH TO loc_oErro
10314:             MsgErro(loc_oErro.Message, "Erro")
10315:         ENDTRY
10316:         RETURN loc_lResultado
10317:     ENDPROC
10318: 
10319:     *--------------------------------------------------------------------------
10320:     * AbrirLookupGruccus - Abre busca de grupo C.C. (SigCdGcr)
10321:     *--------------------------------------------------------------------------
10322:     PROCEDURE AbrirLookupGruccus()
10323:         LOCAL loc_oBusca, loc_oPg
10324:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10325:         TRY
10326:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10327:                 "SigCdGcr", "cursor_4c_BuscaGruccus", "Codigos", ;
10328:                 ALLTRIM(loc_oPg.txt_4c_Gruccus.Value), "Busca de Grupo C.C.")
10329:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10330:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10331:             loc_oBusca.Show()
10332:             IF loc_oBusca.this_lSelecionou
10333:                 IF USED("cursor_4c_BuscaGruccus")
10334:                     SELECT cursor_4c_BuscaGruccus
10335:                     loc_oPg.txt_4c_Gruccus.Value  = ALLTRIM(Codigos)
10336:                     loc_oPg.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10337:                     USE IN cursor_4c_BuscaGruccus
10338:                 ENDIF
10339:             ENDIF
10340:             loc_oBusca.Release()
10341:             loc_oBusca = .NULL.
10342:         CATCH TO loc_oErro
10343:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo C.C.")
10344:         ENDTRY
10345:     ENDPROC
10346: 
10347:     *--------------------------------------------------------------------------
10348:     * TxtDgruccusKeyPress - KeyPress em txt_4c_Dgruccus (F4 abre lookup por descricao)
10349:     *--------------------------------------------------------------------------
10350:     PROCEDURE TxtDgruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10351:         IF par_nKeyCode = 115
10352:             THIS.AbrirLookupDgruccus()
10353:         ENDIF
10354:     ENDPROC
10355: 
10356:     *--------------------------------------------------------------------------
10357:     * AbrirLookupDgruccus - Busca reversa por descricao em SigCdGcr
10358:     *--------------------------------------------------------------------------
10359:     PROCEDURE AbrirLookupDgruccus()
10360:         LOCAL loc_oBusca, loc_oPg
10361:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10362:         TRY
10363:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10364:                 "SigCdGcr", "cursor_4c_BuscaGruccus", "Descrs", ;
10365:                 ALLTRIM(loc_oPg.txt_4c_Dgruccus.Value), "Busca de Grupo C.C.")
10366:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10367:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10368:             loc_oBusca.Show()
10369:             IF loc_oBusca.this_lSelecionou
10370:                 IF USED("cursor_4c_BuscaGruccus")
10371:                     SELECT cursor_4c_BuscaGruccus
10372:                     loc_oPg.txt_4c_Gruccus.Value  = ALLTRIM(Codigos)
10373:                     loc_oPg.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10374:                     USE IN cursor_4c_BuscaGruccus
10375:                 ENDIF
10376:             ENDIF
10377:             loc_oBusca.Release()
10378:             loc_oBusca = .NULL.
10379:         CATCH TO loc_oErro
10380:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo C.C.")
10381:         ENDTRY
10382:     ENDPROC
10383: 
10384:     *--------------------------------------------------------------------------
10385:     * TxtContaccusKeyPress - KeyPress em txt_4c_Contaccus (F4 abre lookup SigCdCli)
10386:     *--------------------------------------------------------------------------
10387:     PROCEDURE TxtContaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10388:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10389:             THIS.ValidarContaccus()
10390:         ENDIF
10391:         IF par_nKeyCode = 115
10392:             THIS.AbrirLookupContaccus()
10393:         ENDIF
10394:     ENDPROC
10395: 
10396:     *--------------------------------------------------------------------------
10397:     * ValidarContaccus - LostFocus/Enter em txt_4c_Contaccus
10398:     * Lookup: SigCdCli filtrado por Grupos = gruccus (IClis / Rclis)
10399:     *--------------------------------------------------------------------------
10400:     PROCEDURE ValidarContaccus()
10401:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_cGrupo, loc_lcSQL
10402:         loc_lResultado = .T.
10403:         TRY
10404:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10405:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Contaccus.Value, ""))
10406:             loc_cGrupo  = ALLTRIM(NVL(loc_oPage.txt_4c_Gruccus.Value, ""))
10407:             IF EMPTY(loc_cCodigo)
10408:                 loc_oPage.txt_4c_Dcontaccus.Value = ""
10409:                 loc_lResultado = loc_lResultado
10410:             ENDIF
10411:             loc_lcSQL = "SELECT IClis, Rclis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cCodigo)
10412:             IF !EMPTY(loc_cGrupo)
10413:                 loc_lcSQL = loc_lcSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
10414:             ENDIF
10415:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValContaccus") <= 0 OR EOF("cursor_4c_ValContaccus")
10416:                 IF USED("cursor_4c_ValContaccus")
10417:                     USE IN cursor_4c_ValContaccus
10418:                 ENDIF
10419:                 THIS.AbrirLookupContaccus()
10420:                 loc_lResultado = loc_lResultado
10421:             ENDIF
10422:             SELECT cursor_4c_ValContaccus
10423:             loc_oPage.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
10424:             loc_oPage.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
10425:             loc_oPage.txt_4c_Contaccus.Refresh()
10426:             loc_oPage.txt_4c_Dcontaccus.Refresh()
10427:             IF USED("cursor_4c_ValContaccus")
10428:                 USE IN cursor_4c_ValContaccus
10429:             ENDIF
10430:         CATCH TO loc_oErro
10431:             MsgErro(loc_oErro.Message, "Erro")
10432:         ENDTRY
10433:         RETURN loc_lResultado
10434:     ENDPROC
10435: 
10436:     *--------------------------------------------------------------------------
10437:     * AbrirLookupContaccus - Abre busca de conta C.C. (SigCdCli filtrado por grupo)
10438:     *--------------------------------------------------------------------------
10439:     PROCEDURE AbrirLookupContaccus()
10440:         LOCAL loc_oBusca, loc_oPg, loc_cGrupo, loc_cTabela
10441:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10442:         loc_cGrupo = ALLTRIM(NVL(loc_oPg.txt_4c_Gruccus.Value, ""))
10443:         TRY
10444:             loc_cTabela = "SigCdCli"
10445:             IF !EMPTY(loc_cGrupo)
10446:                 loc_cTabela = "SigCdCli WHERE Grupos = " + EscaparSQL(loc_cGrupo)
10447:                 loc_cTabela = "(SELECT IClis, Rclis FROM SigCdCli WHERE Grupos = " + EscaparSQL(loc_cGrupo) + ") AS t"
10448:             ENDIF
10449:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10450:                 "SigCdCli", "cursor_4c_BuscaContaccus", "IClis", ;
10451:                 ALLTRIM(loc_oPg.txt_4c_Contaccus.Value), "Busca de Conta C.C.")
10452:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10453:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10454:             loc_oBusca.Show()
10455:             IF loc_oBusca.this_lSelecionou
10456:                 IF USED("cursor_4c_BuscaContaccus")
10457:                     SELECT cursor_4c_BuscaContaccus
10458:                     loc_oPg.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
10459:                     loc_oPg.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
10460:                     USE IN cursor_4c_BuscaContaccus
10461:                 ENDIF
10462:             ENDIF
10463:             loc_oBusca.Release()
10464:             loc_oBusca = .NULL.
10465:         CATCH TO loc_oErro
10466:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de conta C.C.")
10467:         ENDTRY
10468:     ENDPROC
10469: 
10470:     *--------------------------------------------------------------------------
10471:     * TxtDcontaccusKeyPress - KeyPress em txt_4c_Dcontaccus (F4 abre lookup por nome)
10472:     *--------------------------------------------------------------------------
10473:     PROCEDURE TxtDcontaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10474:         IF par_nKeyCode = 115
10475:             THIS.AbrirLookupDcontaccus()
10476:         ENDIF
10477:     ENDPROC
10478: 
10479:     *--------------------------------------------------------------------------
10480:     * AbrirLookupDcontaccus - Busca reversa por nome em SigCdCli
10481:     *--------------------------------------------------------------------------
10482:     PROCEDURE AbrirLookupDcontaccus()
10483:         LOCAL loc_oBusca, loc_oPg
10484:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10485:         TRY
10486:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10487:                 "SigCdCli", "cursor_4c_BuscaContaccus", "Rclis", ;
10488:                 ALLTRIM(loc_oPg.txt_4c_Dcontaccus.Value), "Busca de Conta C.C.")
10489:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10490:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10491:             loc_oBusca.Show()
10492:             IF loc_oBusca.this_lSelecionou
10493:                 IF USED("cursor_4c_BuscaContaccus")
10494:                     SELECT cursor_4c_BuscaContaccus
10495:                     loc_oPg.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
10496:                     loc_oPg.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
10497:                     USE IN cursor_4c_BuscaContaccus
10498:                 ENDIF
10499:             ENDIF
10500:             loc_oBusca.Release()
10501:             loc_oBusca = .NULL.
10502:         CATCH TO loc_oErro
10503:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de conta C.C.")
10504:         ENDTRY
10505:     ENDPROC
10506: 
10507:     *--------------------------------------------------------------------------
10508:     * TxtClfiscalKeyPress - KeyPress em txt_4c_Clfiscal (F4 abre lookup SigCdClf)
10509:     *--------------------------------------------------------------------------
10510:     PROCEDURE TxtClfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10511:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10512:             THIS.ValidarClfiscal()
10513:         ENDIF
10514:         IF par_nKeyCode = 115
10515:             THIS.AbrirLookupClfiscal()
10516:         ENDIF
10517:     ENDPROC
10518: 
10519:     *--------------------------------------------------------------------------
10520:     * ValidarClfiscal - LostFocus/Enter em txt_4c_Clfiscal
10521:     * Lookup: SigCdClf (Codigos / Descricaos)
10522:     *--------------------------------------------------------------------------
10523:     PROCEDURE ValidarClfiscal()
10524:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10525:         loc_lResultado = .T.
10526:         TRY
10527:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10528:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Clfiscal.Value, ""))
10529:             IF EMPTY(loc_cCodigo)
10530:                 loc_oPage.txt_4c_Dclfiscal.Value = ""
10531:                 loc_lResultado = loc_lResultado
10532:             ENDIF
10533:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10534:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValClf") <= 0 OR EOF("cursor_4c_ValClf")
10535:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10536:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValClf"
10537:                 loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10538:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10539:                 loc_oLookup.cTabela     = "SigCdClf"
10540:                 loc_oLookup.cCampoChave = "Codigos"
10541:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10542:                 loc_oLookup.Show()
10543:                 IF loc_oLookup.this_lSelecionou
10544:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10545:                 ELSE
10546:                     loc_cCodigo = ""
10547:                 ENDIF
10548:             ELSE
10549:                 SELECT cursor_4c_ValClf
10550:                 loc_oPage.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10551:             ENDIF
10552:             IF USED("cursor_4c_ValClf")
10553:                 USE IN cursor_4c_ValClf
10554:             ENDIF
10555:             loc_oPage.txt_4c_Clfiscal.Value = loc_cCodigo
10556:             IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dclfiscal.Value)
10557:                 *-- Recarregar descricao apos lookup
10558:                 loc_lcSQL = "SELECT Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10559:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValClf2") > 0 AND !EOF("cursor_4c_ValClf2")
10560:                     SELECT cursor_4c_ValClf2
10561:                     loc_oPage.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10562:                 ENDIF
10563:                 IF USED("cursor_4c_ValClf2")
10564:                     USE IN cursor_4c_ValClf2
10565:                 ENDIF
10566:             ENDIF
10567:             loc_oPage.txt_4c_Clfiscal.Refresh()
10568:             loc_oPage.txt_4c_Dclfiscal.Refresh()
10569:             loc_oPage.Refresh()
10570:         CATCH TO loc_oErro
10571:             MsgErro(loc_oErro.Message, "Erro")
10572:         ENDTRY
10573:         RETURN loc_lResultado
10574:     ENDPROC
10575: 
10576:     *--------------------------------------------------------------------------
10577:     * AbrirLookupClfiscal - Abre busca de classificacao fiscal (SigCdClf)
10578:     *--------------------------------------------------------------------------
10579:     PROCEDURE AbrirLookupClfiscal()
10580:         LOCAL loc_oBusca, loc_oPg
10581:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10582:         TRY
10583:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10584:                 "SigCdClf", "cursor_4c_BuscaClf", "Codigos", ;
10585:                 ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value), "Busca de Classifica" + CHR(231) + CHR(227) + "o Fiscal")
10586:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10587:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10588:             loc_oBusca.Show()
10589:             IF loc_oBusca.this_lSelecionou
10590:                 IF USED("cursor_4c_BuscaClf")
10591:                     SELECT cursor_4c_BuscaClf
10592:                     loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(Codigos)
10593:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10594:                     USE IN cursor_4c_BuscaClf
10595:                 ENDIF
10596:             ENDIF
10597:             loc_oBusca.Release()
10598:             loc_oBusca = .NULL.
10599:         CATCH TO loc_oErro
10600:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o fiscal")
10601:         ENDTRY
10602:     ENDPROC
10603: 
10604:     *--------------------------------------------------------------------------
10605:     * TxtDclfiscalKeyPress - KeyPress em txt_4c_Dclfiscal (F4 busca reversa)
10606:     *--------------------------------------------------------------------------
10607:     PROCEDURE TxtDclfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10608:         IF par_nKeyCode = 115
10609:             THIS.AbrirLookupDclfiscal()
10610:         ENDIF
10611:     ENDPROC
10612: 
10613:     *--------------------------------------------------------------------------
10614:     * AbrirLookupDclfiscal - Busca reversa por descricao em SigCdClf
10615:     *--------------------------------------------------------------------------
10616:     PROCEDURE AbrirLookupDclfiscal()
10617:         LOCAL loc_oBusca, loc_oPg
10618:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10619:         TRY
10620:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10621:                 "SigCdClf", "cursor_4c_BuscaClf", "Descricaos", ;
10622:                 ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value), "Busca de Classifica" + CHR(231) + CHR(227) + "o Fiscal")
10623:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10624:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10625:             loc_oBusca.Show()
10626:             IF loc_oBusca.this_lSelecionou
10627:                 IF USED("cursor_4c_BuscaClf")
10628:                     SELECT cursor_4c_BuscaClf
10629:                     loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(Codigos)
10630:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10631:                     USE IN cursor_4c_BuscaClf
10632:                 ENDIF
10633:             ENDIF
10634:             loc_oBusca.Release()
10635:             loc_oBusca = .NULL.
10636:         CATCH TO loc_oErro
10637:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o fiscal")
10638:         ENDTRY
10639:     ENDPROC
10640: 
10641:     *--------------------------------------------------------------------------
10642:     * TxtOrigmercKeyPress - KeyPress em txt_4c_Origmerc (F4 abre lookup SigCdOrg)
10643:     *--------------------------------------------------------------------------
10644:     PROCEDURE TxtOrigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10645:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10646:             THIS.ValidarOrigmerc()
10647:         ENDIF
10648:         IF par_nKeyCode = 115
10649:             THIS.AbrirLookupOrigmerc()
10650:         ENDIF
10651:     ENDPROC
10652: 
10653:     *--------------------------------------------------------------------------
10654:     * ValidarOrigmerc - LostFocus/Enter em txt_4c_Origmerc
10655:     * Lookup: SigCdOrg (Codigos / Descricaos)
10656:     *--------------------------------------------------------------------------
10657:     PROCEDURE ValidarOrigmerc()
10658:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10659:         loc_lResultado = .T.
10660:         TRY
10661:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10662:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Origmerc.Value, ""))
10663:             IF EMPTY(loc_cCodigo)
10664:                 loc_oPage.txt_4c_Dorigmerc.Value = ""
10665:                 loc_lResultado = loc_lResultado
10666:             ENDIF
10667:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdOrg WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10668:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOrg") <= 0 OR EOF("cursor_4c_ValOrg")
10669:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10670:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValOrg"
10671:                 loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10672:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10673:                 loc_oLookup.cTabela     = "SigCdOrg"
10674:                 loc_oLookup.cCampoChave = "Codigos"
10675:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10676:                 loc_oLookup.Show()
10677:                 IF loc_oLookup.this_lSelecionou
10678:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10679:                 ELSE
10680:                     loc_cCodigo = ""
10681:                 ENDIF
10682:             ELSE
10683:                 SELECT cursor_4c_ValOrg
10684:                 loc_oPage.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10685:             ENDIF
10686:             IF USED("cursor_4c_ValOrg")
10687:                 USE IN cursor_4c_ValOrg
10688:             ENDIF
10689:             loc_oPage.txt_4c_Origmerc.Value = loc_cCodigo
10690:             IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dorigmerc.Value)
10691:                 loc_lcSQL = "SELECT Descricaos FROM SigCdOrg WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10692:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOrg2") > 0 AND !EOF("cursor_4c_ValOrg2")
10693:                     SELECT cursor_4c_ValOrg2
10694:                     loc_oPage.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10695:                 ENDIF
10696:                 IF USED("cursor_4c_ValOrg2")
10697:                     USE IN cursor_4c_ValOrg2
10698:                 ENDIF
10699:             ENDIF
10700:             loc_oPage.txt_4c_Origmerc.Refresh()
10701:             loc_oPage.txt_4c_Dorigmerc.Refresh()
10702:             loc_oPage.Refresh()
10703:         CATCH TO loc_oErro
10704:             MsgErro(loc_oErro.Message, "Erro")
10705:         ENDTRY
10706:         RETURN loc_lResultado
10707:     ENDPROC
10708: 
10709:     *--------------------------------------------------------------------------
10710:     * AbrirLookupOrigmerc - Abre busca de origem da mercadoria (SigCdOrg)
10711:     *--------------------------------------------------------------------------
10712:     PROCEDURE AbrirLookupOrigmerc()
10713:         LOCAL loc_oBusca, loc_oPg
10714:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10715:         TRY
10716:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10717:                 "SigCdOrg", "cursor_4c_BuscaOrg", "Codigos", ;
10718:                 ALLTRIM(loc_oPg.txt_4c_Origmerc.Value), "Busca de Origem da Mercadoria")
10719:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10720:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10721:             loc_oBusca.Show()
10722:             IF loc_oBusca.this_lSelecionou
10723:                 IF USED("cursor_4c_BuscaOrg")
10724:                     SELECT cursor_4c_BuscaOrg
10725:                     loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(Codigos)
10726:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10727:                     USE IN cursor_4c_BuscaOrg
10728:                 ENDIF
10729:             ENDIF
10730:             loc_oBusca.Release()
10731:             loc_oBusca = .NULL.
10732:         CATCH TO loc_oErro
10733:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de origem da mercadoria")
10734:         ENDTRY
10735:     ENDPROC
10736: 
10737:     *--------------------------------------------------------------------------
10738:     * TxtDorigmercKeyPress - KeyPress em txt_4c_Dorigmerc (F4 busca reversa)
10739:     *--------------------------------------------------------------------------
10740:     PROCEDURE TxtDorigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10741:         IF par_nKeyCode = 115
10742:             THIS.AbrirLookupDorigmerc()
10743:         ENDIF
10744:     ENDPROC
10745: 
10746:     *--------------------------------------------------------------------------
10747:     * AbrirLookupDorigmerc - Busca reversa por descricao em SigCdOrg
10748:     *--------------------------------------------------------------------------
10749:     PROCEDURE AbrirLookupDorigmerc()
10750:         LOCAL loc_oBusca, loc_oPg
10751:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10752:         TRY
10753:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10754:                 "SigCdOrg", "cursor_4c_BuscaOrg", "Descricaos", ;
10755:                 ALLTRIM(loc_oPg.txt_4c_Dorigmerc.Value), "Busca de Origem da Mercadoria")
10756:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10757:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10758:             loc_oBusca.Show()
10759:             IF loc_oBusca.this_lSelecionou
10760:                 IF USED("cursor_4c_BuscaOrg")
10761:                     SELECT cursor_4c_BuscaOrg
10762:                     loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(Codigos)
10763:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10764:                     USE IN cursor_4c_BuscaOrg
10765:                 ENDIF
10766:             ENDIF
10767:             loc_oBusca.Release()
10768:             loc_oBusca = .NULL.
10769:         CATCH TO loc_oErro
10770:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de origem da mercadoria")
10771:         ENDTRY
10772:     ENDPROC
10773: 
10774:     *--------------------------------------------------------------------------
10775:     * TxtSittricmKeyPress - KeyPress em txt_4c_Sittricm (F4 abre lookup SigCdIcm)
10776:     *--------------------------------------------------------------------------
10777:     PROCEDURE TxtSittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10778:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10779:             THIS.ValidarSittricm()
10780:         ENDIF
10781:         IF par_nKeyCode = 115
10782:             THIS.AbrirLookupSittricm()
10783:         ENDIF
10784:     ENDPROC
10785: 
10786:     *--------------------------------------------------------------------------
10787:     * ValidarSittricm - LostFocus/Enter em txt_4c_Sittricm
10788:     * Lookup: SigCdIcm (Codigos / Descricaos)
10789:     *--------------------------------------------------------------------------
10790:     PROCEDURE ValidarSittricm()
10791:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10792:         loc_lResultado = .T.
10793:         TRY
10794:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10795:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Sittricm.Value, ""))
10796:             IF EMPTY(loc_cCodigo)
10797:                 loc_oPage.txt_4c_Dsittricm.Value = ""
10798:                 loc_lResultado = loc_lResultado
10799:             ENDIF
10800:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10801:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValIcm") <= 0 OR EOF("cursor_4c_ValIcm")
10802:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10803:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValIcm"
10804:                 loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10805:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10806:                 loc_oLookup.cTabela     = "SigCdIcm"
10807:                 loc_oLookup.cCampoChave = "Codigos"
10808:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10809:                 loc_oLookup.Show()
10810:                 IF loc_oLookup.this_lSelecionou
10811:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10812:                 ELSE
10813:                     loc_cCodigo = ""
10814:                 ENDIF
10815:             ELSE
10816:                 SELECT cursor_4c_ValIcm
10817:                 loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10818:             ENDIF
10819:             IF USED("cursor_4c_ValIcm")
10820:                 USE IN cursor_4c_ValIcm
10821:             ENDIF
10822:             loc_oPage.txt_4c_Sittricm.Value = loc_cCodigo
10823:             IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dsittricm.Value)
10824:                 loc_lcSQL = "SELECT Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10825:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValIcm2") > 0 AND !EOF("cursor_4c_ValIcm2")
10826:                     SELECT cursor_4c_ValIcm2
10827:                     loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10828:                 ENDIF
10829:                 IF USED("cursor_4c_ValIcm2")
10830:                     USE IN cursor_4c_ValIcm2
10831:                 ENDIF
10832:             ENDIF
10833:             loc_oPage.txt_4c_Sittricm.Refresh()
10834:             loc_oPage.txt_4c_Dsittricm.Refresh()
10835:             loc_oPage.Refresh()
10836:         CATCH TO loc_oErro
10837:             MsgErro(loc_oErro.Message, "Erro")
10838:         ENDTRY
10839:         RETURN loc_lResultado
10840:     ENDPROC
10841: 
10842:     *--------------------------------------------------------------------------
10843:     * AbrirLookupSittricm - Abre busca situacao tributaria ICMS (SigCdIcm)
10844:     *--------------------------------------------------------------------------
10845:     PROCEDURE AbrirLookupSittricm()
10846:         LOCAL loc_oBusca, loc_oPg
10847:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10848:         TRY
10849:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10850:                 "SigCdIcm", "cursor_4c_BuscaIcm", "Codigos", ;
10851:                 ALLTRIM(loc_oPg.txt_4c_Sittricm.Value), "Busca de Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
10852:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10853:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10854:             loc_oBusca.Show()
10855:             IF loc_oBusca.this_lSelecionou
10856:                 IF USED("cursor_4c_BuscaIcm")
10857:                     SELECT cursor_4c_BuscaIcm
10858:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10859:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10860:                     USE IN cursor_4c_BuscaIcm
10861:                 ENDIF
10862:             ENDIF
10863:             loc_oBusca.Release()
10864:             loc_oBusca = .NULL.
10865:         CATCH TO loc_oErro
10866:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
10867:         ENDTRY
10868:     ENDPROC
10869: 
10870:     *--------------------------------------------------------------------------
10871:     * TxtDsittricmKeyPress - KeyPress em txt_4c_Dsittricm (F4 busca reversa)
10872:     *--------------------------------------------------------------------------
10873:     PROCEDURE TxtDsittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10874:         IF par_nKeyCode = 115
10875:             THIS.AbrirLookupDsittricm()
10876:         ENDIF
10877:     ENDPROC
10878: 
10879:     *--------------------------------------------------------------------------
10880:     * AbrirLookupDsittricm - Busca reversa por descricao em SigCdIcm
10881:     *--------------------------------------------------------------------------
10882:     PROCEDURE AbrirLookupDsittricm()
10883:         LOCAL loc_oBusca, loc_oPg
10884:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10885:         TRY
10886:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10887:                 "SigCdIcm", "cursor_4c_BuscaIcm", "Descricaos", ;
10888:                 ALLTRIM(loc_oPg.txt_4c_Dsittricm.Value), "Busca de Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
10889:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10890:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10891:             loc_oBusca.Show()
10892:             IF loc_oBusca.this_lSelecionou
10893:                 IF USED("cursor_4c_BuscaIcm")
10894:                     SELECT cursor_4c_BuscaIcm
10895:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10896:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10897:                     USE IN cursor_4c_BuscaIcm
10898:                 ENDIF
10899:             ENDIF
10900:             loc_oBusca.Release()
10901:             loc_oBusca = .NULL.
10902:         CATCH TO loc_oErro
10903:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
10904:         ENDTRY
10905:     ENDPROC
10906: 
10907:     *--------------------------------------------------------------------------
10908:     * TxtCodServsKeyPress - KeyPress em txt_4c_CodServs (F4 abre lookup SigCdIcm)
10909:     *--------------------------------------------------------------------------
10910:     PROCEDURE TxtCodServsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10911:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10912:             THIS.ValidarCodServs()
10913:         ENDIF
10914:         IF par_nKeyCode = 115
10915:             THIS.AbrirLookupCodServs()
10916:         ENDIF
10917:     ENDPROC
10918: 
10919:     *--------------------------------------------------------------------------
10920:     * ValidarCodServs - LostFocus/Enter em txt_4c_CodServs
10921:     * Lookup: SigCdIcm (Codigos) -> preenche txt_4c_Sittricm
10922:     *--------------------------------------------------------------------------
10923:     PROCEDURE ValidarCodServs()
10924:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10925:         loc_lResultado = .T.
10926:         TRY
10927:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10928:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_CodServs.Value, ""))
10929:             IF EMPTY(loc_cCodigo)
10930:                 loc_lResultado = loc_lResultado
10931:             ENDIF
10932:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10933:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCodServs") <= 0 OR EOF("cursor_4c_ValCodServs")
10934:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10935:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValServs"
10936:                 loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10937:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10938:                 loc_oLookup.cTabela     = "SigCdIcm"
10939:                 loc_oLookup.cCampoChave = "Codigos"
10940:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10941:                 loc_oLookup.Show()
10942:                 IF loc_oLookup.this_lSelecionou
10943:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10944:                 ELSE
10945:                     loc_cCodigo = ""
10946:                 ENDIF
10947:             ELSE
10948:                 *-- Get_CodServs preenche txt_4c_Sittricm (conforme original)
10949:                 SELECT cursor_4c_ValCodServs
10950:                 loc_oPage.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10951:                 loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10952:                 loc_oPage.txt_4c_Sittricm.Refresh()
10953:                 loc_oPage.txt_4c_Dsittricm.Refresh()
10954:             ENDIF
10955:             IF USED("cursor_4c_ValCodServs")
10956:                 USE IN cursor_4c_ValCodServs
10957:             ENDIF
10958:             loc_oPage.txt_4c_CodServs.Value = loc_cCodigo
10959:             loc_oPage.txt_4c_CodServs.Refresh()
10960:             loc_oPage.Refresh()
10961:         CATCH TO loc_oErro
10962:             MsgErro(loc_oErro.Message, "Erro")
10963:         ENDTRY
10964:         RETURN loc_lResultado
10965:     ENDPROC
10966: 
10967:     *--------------------------------------------------------------------------
10968:     * AbrirLookupCodServs - Abre busca codigo servicos ICMS (SigCdIcm)
10969:     *--------------------------------------------------------------------------
10970:     PROCEDURE AbrirLookupCodServs()
10971:         LOCAL loc_oBusca, loc_oPg
10972:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10973:         TRY
10974:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10975:                 "SigCdIcm", "cursor_4c_BuscaIcm", "Codigos", ;
10976:                 ALLTRIM(loc_oPg.txt_4c_CodServs.Value), "Busca de C" + CHR(243) + "digo de Servi" + CHR(231) + "os")
10977:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10978:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10979:             loc_oBusca.Show()
10980:             IF loc_oBusca.this_lSelecionou
10981:                 IF USED("cursor_4c_BuscaIcm")
10982:                     SELECT cursor_4c_BuscaIcm
10983:                     loc_oPg.txt_4c_CodServs.Value  = ALLTRIM(Codigos)
10984:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10985:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10986:                     USE IN cursor_4c_BuscaIcm
10987:                 ENDIF
10988:             ENDIF
10989:             loc_oBusca.Release()
10990:             loc_oBusca = .NULL.
10991:         CATCH TO loc_oErro
10992:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de c" + CHR(243) + "digo de servi" + CHR(231) + "os")
10993:         ENDTRY
10994:     ENDPROC
10995: 
10996:     *--------------------------------------------------------------------------
10997:     * TxtTpTribKeyPress - KeyPress em txt_4c_TpTrib (F4 abre lookup SigPrTri)
10998:     *--------------------------------------------------------------------------
10999:     PROCEDURE TxtTpTribKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11000:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
11001:             THIS.ValidarTpTrib()
11002:         ENDIF
11003:         IF par_nKeyCode = 115
11004:             THIS.AbrirLookupTpTrib()
11005:         ENDIF
11006:     ENDPROC
11007: 
11008:     *--------------------------------------------------------------------------
11009:     * ValidarTpTrib - LostFocus/Enter em txt_4c_TpTrib
11010:     * Lookup: SigPrTri (Tipos / Descs)
11011:     *--------------------------------------------------------------------------
11012:     PROCEDURE ValidarTpTrib()
11013:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
11014:         loc_lResultado = .T.
11015:         TRY
11016:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11017:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_TpTrib.Value, ""))
11018:             IF EMPTY(loc_cCodigo)
11019:                 loc_lResultado = loc_lResultado
11020:             ENDIF
11021:             loc_lcSQL = "SELECT Tipos FROM SigPrTri WHERE Tipos = " + EscaparSQL(loc_cCodigo)
11022:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTrib") <= 0 OR EOF("cursor_4c_ValTrib")
11023:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
11024:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValTrib"
11025:                 loc_oLookup.mAddColuna("Tipos", "", "Tipo")
11026:                 loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11027:                 loc_oLookup.cTabela     = "SigPrTri"
11028:                 loc_oLookup.cCampoChave = "Tipos"
11029:                 loc_oLookup.cFiltroIni  = loc_cCodigo
11030:                 loc_oLookup.Show()
11031:                 IF loc_oLookup.this_lSelecionou
11032:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
11033:                 ELSE
11034:                     loc_cCodigo = ""
11035:                 ENDIF
11036:             ENDIF
11037:             IF USED("cursor_4c_ValTrib")
11038:                 USE IN cursor_4c_ValTrib
11039:             ENDIF
11040:             loc_oPage.txt_4c_TpTrib.Value = loc_cCodigo
11041:             loc_oPage.txt_4c_TpTrib.Refresh()
11042:             loc_oPage.Refresh()
11043:         CATCH TO loc_oErro
11044:             MsgErro(loc_oErro.Message, "Erro")
11045:         ENDTRY
11046:         RETURN loc_lResultado
11047:     ENDPROC
11048: 
11049:     *--------------------------------------------------------------------------
11050:     * AbrirLookupTpTrib - Abre busca de tipo de tributacao (SigPrTri)
11051:     *--------------------------------------------------------------------------
11052:     PROCEDURE AbrirLookupTpTrib()
11053:         LOCAL loc_oBusca, loc_oPg
11054:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11055:         TRY
11056:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11057:                 "SigPrTri", "cursor_4c_BuscaTrib", "Tipos", ;
11058:                 ALLTRIM(loc_oPg.txt_4c_TpTrib.Value), "Busca de Tipo de Tributa" + CHR(231) + CHR(227) + "o")
11059:             loc_oBusca.mAddColuna("Tipos", "", "Tipo")
11060:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11061:             loc_oBusca.Show()
11062:             IF loc_oBusca.this_lSelecionou
11063:                 IF USED("cursor_4c_BuscaTrib")
11064:                     SELECT cursor_4c_BuscaTrib
11065:                     loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(Tipos)
11066:                     USE IN cursor_4c_BuscaTrib
11067:                 ENDIF
11068:             ENDIF
11069:             loc_oBusca.Release()
11070:             loc_oBusca = .NULL.
11071:         CATCH TO loc_oErro
11072:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de tipo de tributa" + CHR(231) + CHR(227) + "o")
11073:         ENDTRY
11074:     ENDPROC
11075: 
11076:     *--------------------------------------------------------------------------
11077:     * ValidarIat - LostFocus em txt_4c_Iat
11078:     * Valida: deve ser 'A' (Arredondamento) ou 'T' (Truncamento) ou vazio
11079:     *--------------------------------------------------------------------------
11080:     PROCEDURE ValidarIat()
11081:         LOCAL loc_oPage, loc_cValor
11082:         TRY
11083:             loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11084:             loc_cValor = UPPER(ALLTRIM(NVL(loc_oPage.txt_4c_Iat.Value, "")))
11085:             IF EMPTY(loc_cValor)
11086:                 RETURN
11087:             ENDIF
11088:             IF !INLIST(loc_cValor, "A", "T")
11089:                 MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
11090:                     "Digite [A] Indicador de Arredondamento ou [T] Indicador de Truncamento!")
11091:                 loc_oPage.txt_4c_Iat.Value = ""
11092:                 loc_oPage.txt_4c_Iat.Refresh()
11093:             ELSE
11094:                 loc_oPage.txt_4c_Iat.Value = loc_cValor
11095:             ENDIF
11096:         CATCH TO loc_oErro
11097:             MsgErro(loc_oErro.Message, "Erro")
11098:         ENDTRY
11099:     ENDPROC
11100: 
11101:     *--------------------------------------------------------------------------
11102:     * ValidarAliqIPI - LostFocus em txt_4c_AliqIPI
11103:     * Verifica se aliquota informada eh identica a da classificacao fiscal
11104:     *--------------------------------------------------------------------------
11105:     PROCEDURE ValidarAliqIPI()
11106:         LOCAL loc_oPage, loc_nAliq, loc_nAliqClf, loc_lcSQL
11107:         TRY
11108:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11109:             loc_nAliq   = loc_oPage.txt_4c_AliqIPI.Value
11110:             IF EMPTY(ALLTRIM(NVL(loc_oPage.txt_4c_Clfiscal.Value, ""))) OR loc_nAliq = 0
11111:                 RETURN
11112:             ENDIF
11113:             loc_lcSQL = "SELECT aIpis FROM SigCdClf WHERE Codigos = " + EscaparSQL(ALLTRIM(loc_oPage.txt_4c_Clfiscal.Value))
11114:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAliqIPI") > 0 AND !EOF("cursor_4c_ValAliqIPI")
11115:                 SELECT cursor_4c_ValAliqIPI
11116:                 loc_nAliqClf = aIpis
11117:                 IF loc_nAliq = loc_nAliqClf
11118:                     MsgAviso("Al" + CHR(237) + "quota de IPI informada no produto id" + CHR(234) + "ntica " + ;
11119:                         CHR(224) + " classifica" + CHR(231) + CHR(227) + "o fiscal, " + ;
11120:                         "deixe zero e ser" + CHR(225) + " utilizada a classifica" + CHR(231) + CHR(227) + "o fiscal!")
11121:                 ENDIF
11122:             ENDIF
11123:             IF USED("cursor_4c_ValAliqIPI")
11124:                 USE IN cursor_4c_ValAliqIPI
11125:             ENDIF
11126:             loc_oPage.Refresh()
11127:         CATCH TO loc_oErro
11128:             MsgErro(loc_oErro.Message, "Erro")
11129:         ENDTRY
11130:     ENDPROC
11131: 
11132:     *--------------------------------------------------------------------------
11133:     * TxtMvalorKeyPress - KeyPress em txt_4c_Mvalor (F4 abre lookup SigCdMoe)
11134:     *--------------------------------------------------------------------------
11135:     PROCEDURE TxtMvalorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11136:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
11137:             THIS.ValidarMvalor()
11138:         ENDIF
11139:         IF par_nKeyCode = 115
11140:             THIS.AbrirLookupMvalor()
11141:         ENDIF
11142:     ENDPROC
11143: 
11144:     *--------------------------------------------------------------------------
11145:     * ValidarMvalor - LostFocus/Enter em txt_4c_Mvalor
11146:     * Lookup: SigCdMoe (CMoes / DMoes)
11147:     *--------------------------------------------------------------------------
11148:     PROCEDURE ValidarMvalor()
11149:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
11150:         loc_lResultado = .T.
11151:         TRY
11152:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11153:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Mvalor.Value, ""))
11154:             IF EMPTY(loc_cCodigo)
11155:                 loc_lResultado = loc_lResultado
11156:             ENDIF
11157:             loc_lcSQL = "SELECT cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCodigo)
11158:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValMvalor") <= 0 OR EOF("cursor_4c_ValMvalor")
11159:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
11160:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaValMoe"
11161:                 loc_oLookup.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
11162:                 loc_oLookup.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11163:                 loc_oLookup.cTabela     = "SigCdMoe"
11164:                 loc_oLookup.cCampoChave = "cmoes"
11165:                 loc_oLookup.cFiltroIni  = loc_cCodigo
11166:                 loc_oLookup.Show()
11167:                 IF loc_oLookup.this_lSelecionou
11168:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
11169:                 ELSE
11170:                     loc_cCodigo = ""
11171:                 ENDIF
11172:             ENDIF
11173:             IF USED("cursor_4c_ValMvalor")
11174:                 USE IN cursor_4c_ValMvalor
11175:             ENDIF
11176:             loc_oPage.txt_4c_Mvalor.Value = loc_cCodigo
11177:             loc_oPage.txt_4c_Mvalor.Refresh()
11178:             loc_oPage.Refresh()
11179:         CATCH TO loc_oErro
11180:             MsgErro(loc_oErro.Message, "Erro")
11181:         ENDTRY
11182:         RETURN loc_lResultado
11183:     ENDPROC
11184: 
11185:     *--------------------------------------------------------------------------
11186:     * AbrirLookupMvalor - Abre busca de moeda do valor estimado (SigCdMoe)
11187:     *--------------------------------------------------------------------------
11188:     PROCEDURE AbrirLookupMvalor()
11189:         LOCAL loc_oBusca, loc_oPg
11190:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11191:         TRY
11192:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11193:                 "SigCdMoe", "cursor_4c_BuscaMvalor", "cmoes", ;
11194:                 ALLTRIM(loc_oPg.txt_4c_Mvalor.Value), "Busca de Moeda")
11195:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
11196:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11197:             loc_oBusca.Show()
11198:             IF loc_oBusca.this_lSelecionou
11199:                 IF USED("cursor_4c_BuscaMvalor")
11200:                     SELECT cursor_4c_BuscaMvalor
11201:                     loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(cmoes)
11202:                     USE IN cursor_4c_BuscaMvalor
11203:                 ENDIF
11204:             ENDIF
11205:             loc_oBusca.Release()
11206:             loc_oBusca = .NULL.
11207:         CATCH TO loc_oErro
11208:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
11209:         ENDTRY
11210:     ENDPROC
11211: 
11212:     *--------------------------------------------------------------------------
11213:     * TxtMetalKeyPress - KeyPress em txt_4c_Metal (F4 abre lookup metal)
11214:     *--------------------------------------------------------------------------
11215:     PROCEDURE TxtMetalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11216:         IF par_nKeyCode = 115
11217:             THIS.AbrirLookupMetal()
11218:         ENDIF
11219:     ENDPROC
11220: 
11221:     *--------------------------------------------------------------------------
11222:     * AbrirLookupMetal - Abre busca de metal (TmpMTal - cursor pre-carregado)
11223:     * Nota: TmpMTal deve ser carregado pelo form durante init com dados da tabela de metais
11224:     *--------------------------------------------------------------------------
11225:     PROCEDURE AbrirLookupMetal()
11226:         LOCAL loc_oBusca, loc_oPg
11227:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11228:         TRY
11229:             IF USED("TmpMTal")
11230:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11231:                     "TmpMTal", "cursor_4c_BuscaMetal", "Codigos", ;
11232:                     ALLTRIM(loc_oPg.txt_4c_Metal.Value), "Busca de Metal")
11233:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
11234:                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11235:                 loc_oBusca.Show()
11236:                 IF loc_oBusca.this_lSelecionou
11237:                     IF USED("cursor_4c_BuscaMetal")
11238:                         SELECT cursor_4c_BuscaMetal
11239:                         loc_oPg.txt_4c_Metal.Value   = ALLTRIM(Codigos)
11240:                         loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(Descs)
11241:                         USE IN cursor_4c_BuscaMetal
11242:                     ENDIF
11243:                 ENDIF
11244:                 loc_oBusca.Release()
11245:                 loc_oBusca = .NULL.
11246:             ENDIF
11247:         CATCH TO loc_oErro
11248:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de metal")
11249:         ENDTRY
11250:     ENDPROC
11251: 
11252:     *--------------------------------------------------------------------------
11253:     * TxtTeorKeyPress - KeyPress em txt_4c_Teor (F4 abre lookup teor)
11254:     *--------------------------------------------------------------------------
11255:     PROCEDURE TxtTeorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11256:         IF par_nKeyCode = 115
11257:             THIS.AbrirLookupTeor()
11258:         ENDIF
11259:     ENDPROC
11260: 
11261:     *--------------------------------------------------------------------------
11262:     * AbrirLookupTeor - Abre busca de teor (TmpTeor - cursor pre-carregado)
11263:     * Nota: TmpTeor deve ser carregado pelo form durante init com dados da tabela de teores
11264:     *--------------------------------------------------------------------------
11265:     PROCEDURE AbrirLookupTeor()
11266:         LOCAL loc_oBusca, loc_oPg
11267:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11268:         TRY
11269:             IF USED("TmpTeor")
11270:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11271:                     "TmpTeor", "cursor_4c_BuscaTeor", "Codigos", ;
11272:                     ALLTRIM(loc_oPg.txt_4c_Teor.Value), "Busca de Teor")
11273:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
11274:                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11275:                 loc_oBusca.Show()
11276:                 IF loc_oBusca.this_lSelecionou
11277:                     IF USED("cursor_4c_BuscaTeor")
11278:                         SELECT cursor_4c_BuscaTeor
11279:                         loc_oPg.txt_4c_Teor.Value   = ALLTRIM(Codigos)
11280:                         loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(Descs)
11281:                         USE IN cursor_4c_BuscaTeor
11282:                     ENDIF
11283:                 ENDIF
11284:                 loc_oBusca.Release()
11285:                 loc_oBusca = .NULL.
11286:             ENDIF
11287:         CATCH TO loc_oErro
11288:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de teor")
11289:         ENDTRY
11290:     ENDPROC
11291: 
11292:     *--------------------------------------------------------------------------
11293:     * CmdBtnDescFisClick - Click em cmd_4c_BtnDescFis
11294:     * Gera descricao fiscal a partir da composicao do produto (campo DescFis em SigCdPro)
11295:     *--------------------------------------------------------------------------
11296:     PROCEDURE CmdBtnDescFisClick()
11297:         LOCAL loc_oPage, loc_cCpros, loc_lcSQL, loc_cDescFis
11298:         TRY
11299:             loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11300:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11301:             IF EMPTY(loc_cCpros)
11302:                 MsgAviso("Salve o produto antes de gerar a descri" + CHR(231) + CHR(227) + "o fiscal.")
11303:                 RETURN
11304:             ENDIF
11305:             *-- Gerar descricao fiscal baseada na composicao do produto (simplificado)
11306:             loc_lcSQL = "SELECT TOP 1 dpros + ' ' + ISNULL(dpro2s,'') AS descFis " + ;
11307:                 "FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
11308:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_DescFis") > 0 AND !EOF("cursor_4c_DescFis")
11309:                 SELECT cursor_4c_DescFis
11310:                 loc_cDescFis = ALLTRIM(descFis)
11311:                 IF !EMPTY(loc_cDescFis)
11312:                     loc_oPage.obj_4c_Mgetdescfi.Value = loc_cDescFis
11313:                     loc_oPage.obj_4c_Mgetdescfi.Refresh()
11314:                     *-- Persistir no banco
11315:                     loc_lcSQL = "UPDATE SigCdPro SET DescFis = " + EscaparSQL(loc_cDescFis) + ;
11316:                         " WHERE cpros = " + EscaparSQL(loc_cCpros)
11317:                     SQLEXEC(gnConnHandle, loc_lcSQL)
11318:                 ELSE
11319:                     MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + CHR(231) + CHR(227) + "o fiscal!")
11320:                 ENDIF
11321:             ELSE
11322:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + CHR(231) + CHR(227) + "o fiscal!")
11323:             ENDIF
11324:             IF USED("cursor_4c_DescFis")
11325:                 USE IN cursor_4c_DescFis
11326:             ENDIF
11327:         CATCH TO loc_oErro
11328:             MsgErro(loc_oErro.Message, "Erro ao gerar descri" + CHR(231) + CHR(227) + "o fiscal")
11329:         ENDTRY
11330:     ENDPROC
11331: 
11332:     *--------------------------------------------------------------------------
11333:     * AtualizarSigCdPro - Salva campos editaveis de SigCdPro apos salvar SigPrFtp
11334:     * Chamado por BtnSalvarClick() apos this_oBusinessObject.Salvar() com sucesso
11335:     *--------------------------------------------------------------------------
11336:     PROTECTED PROCEDURE AtualizarSigCdPro()
11337:         LOCAL loc_oPg, loc_cCpros, loc_cSQL, loc_lFabrProprs, loc_lConsig, loc_lEncoms
11338:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
11339:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11340: 
11341:         IF EMPTY(loc_cCpros)
11342:             RETURN
11343:         ENDIF
11344: 
11345:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11346:             RETURN
11347:         ENDIF
11348: 
11349:         *-- Converter CheckBox.Value (logico) para 0/1
11350:         loc_lFabrProprs = IIF(loc_oPg.chk_4c_FabrProprs.Value, 1, 0)
11351:         loc_lConsig     = IIF(loc_oPg.chk_4c_Consig.Value,     1, 0)
11352:         loc_lEncoms     = IIF(loc_oPg.chk_4c_Encoms.Value,     1, 0)
11353: 
11354:         *-- Coletar campos fiscais (Page3)
11355:         LOCAL loc_oPg3U, loc_cIpiVal
11356:         loc_oPg3U = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11357:         loc_cIpiVal = LEFT(UPPER(ALLTRIM(loc_oPg3U.cbo_4c_CmbIpi.Value)), 1)
11358: 
11359:         TRY
11360:             loc_cSQL = "UPDATE SigCdPro SET " + ;
11361:                 "dpro2s = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_DPro2s.Value))      + ", " + ;
11362:                 "cbars = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cbar.Value))        + ", " + ;
11363:                 "cgrus = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cgrus.Value))       + ", " + ;
11364:                 "linhas = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Lin.Value))         + ", " + ;
11365:                 "colecoes = "   + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Col.Value))         + ", " + ;
11366:                 "ifors = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Ifor.Value))        + ", " + ;
11367:                 "reffs = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Refs.Value))        + ", " + ;
11368:                 "codcors = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cor.Value))         + ", " + ;
11369:                 "codtams = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Tam.Value))         + ", " + ;
11370:                 "codfinp = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CodFinP.Value))     + ", " + ;
11371:                 "pesobs = "     + FormatarNumeroSQL(loc_oPg.txt_4c_PesoB.Value)         + ", " + ;
11372:                 "codacbs = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CodAcb.Value))      + ", " + ;
11373:                 "cclass = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Class.Value))       + ", " + ;
11374:                 "locals = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Local.Value))       + ", " + ;
11375:                 "cunis = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cuni.Value))        + ", " + ;
11376:                 "cunips = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cunip.Value))       + ", " + ;

*-- Linhas 11416 a 11481:
11416:     *--------------------------------------------------------------------------
11417:     * Destroy - Liberacao de recursos
11418:     *--------------------------------------------------------------------------
11419:     PROCEDURE Destroy()
11420:         LOCAL loc_aCursors(42), loc_nI
11421:         *-- Lista de todos os cursors possiveis deste form
11422:         loc_aCursors(1)  = "cursor_4c_Dados"
11423:         loc_aCursors(2)  = "cursor_4c_Busca"
11424:         loc_aCursors(3)  = "cursor_4c_ProdDados"
11425:         loc_aCursors(4)  = "cursor_4c_DescGru"
11426:         loc_aCursors(5)  = "cursor_4c_DescLin"
11427:         loc_aCursors(6)  = "cursor_4c_DescCol"
11428:         loc_aCursors(7)  = "cursor_4c_DescIfor"
11429:         loc_aCursors(8)  = "cursor_4c_ValPro"
11430:         loc_aCursors(9)  = "cursor_4c_ValGru"
11431:         loc_aCursors(10) = "cursor_4c_Registro"
11432:         *-- Fase 6: cursors adicionais
11433:         loc_aCursors(11) = "cursor_4c_DescCor"
11434:         loc_aCursors(12) = "cursor_4c_DescTam"
11435:         loc_aCursors(13) = "cursor_4c_DescFinP"
11436:         loc_aCursors(14) = "cursor_4c_DescAcb"
11437:         loc_aCursors(15) = "cursor_4c_DescClass"
11438:         loc_aCursors(16) = "cursor_4c_DescLocal"
11439:         loc_aCursors(17) = "cursor_4c_DescUni"
11440:         loc_aCursors(18) = "cursor_4c_DescMoe"
11441:         loc_aCursors(19) = "cursor_4c_BuscaCor"
11442:         loc_aCursors(20) = "cursor_4c_BuscaTam"
11443:         loc_aCursors(21) = "cursor_4c_BuscaFinP"
11444:         loc_aCursors(22) = "cursor_4c_BuscaAcb"
11445:         loc_aCursors(23) = "cursor_4c_BuscaClass"
11446:         loc_aCursors(24) = "cursor_4c_BuscaLocal"
11447:         loc_aCursors(25) = "cursor_4c_BuscaUni"
11448:         loc_aCursors(26) = "cursor_4c_BuscaUniP"
11449:         loc_aCursors(27) = "cursor_4c_BuscaMoe"
11450:         loc_aCursors(28) = "cursor_4c_BuscaGrupo"
11451:         loc_aCursors(29) = "cursor_4c_ValGru"
11452:         loc_aCursors(30) = "cursor_4c_DescGru"
11453:         *-- Fase 9: cursors de composicao
11454:         loc_aCursors(31) = "cursor_4c_Compo"
11455:         loc_aCursors(32) = "cursor_4c_SubCp"
11456:         loc_aCursors(33) = "cursor_4c_TotGrupo"
11457:         loc_aCursors(34) = "cursor_4c_BuscaMoeCompo"
11458:         loc_aCursors(35) = "cursor_4c_BuscaAuxMoe"
11459:         *-- Fase 10: cursors de custo
11460:         loc_aCursors(36) = "cursor_4c_CustoCompo"
11461:         loc_aCursors(37) = "cursor_4c_TotGrupoCusto"
11462:         *-- Fase 12: cursors de fases de processo e matrizes
11463:         loc_aCursors(38) = "cursor_4c_Fase"
11464:         loc_aCursors(39) = "cursor_4c_Matrizes"
11465:         *-- Fase 13: cursor dados fiscais
11466:         loc_aCursors(40) = "cursor_4c_Cmv"
11467:         *-- Fase 14: cursors designer
11468:         loc_aCursors(41) = "cursor_4c_Tarefas"
11469:         loc_aCursors(42) = "cursor_4c_Arquivos"
11470: 
11471:         FOR loc_nI = 1 TO 42
11472:             IF USED(loc_aCursors(loc_nI))
11473:                 USE IN (loc_aCursors(loc_nI))
11474:             ENDIF
11475:         ENDFOR
11476: 
11477:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
11478:             THIS.this_oBusinessObject = .NULL.
11479:         ENDIF
11480: 
11481:         DODEFAULT()


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

