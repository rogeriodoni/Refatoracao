# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (201)
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
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarConquilha' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarConquilhaValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarCor' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarCorValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarTam' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarTamValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarAcabamento' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarAcabamentoValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [METODO-INEXISTENTE] Metodo 'THIS.MontarFiltro()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Dados' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_DadosTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Compo' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_SubCp' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TotGrupo' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Cmv' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_CustoCompo' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TotGrupoCusto' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GrdCons' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GrDTEMP' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Fase' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Matrizes' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Tarefas' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Arquivos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Cmv' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Cmv' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [CURSOR-ORDEM] CREATE CURSOR 'cursor_4c_Cmv' aparece em mais de um local com ORDEM DE CAMPOS DIFERENTE. Primeira ocorrencia: []. Segunda ocorrencia: [DATAS,VALCUSS,MOEDAS]. A ordem DEVE ser IDENTICA em TODOS os CREATE CURSOR do mesmo nome.
- [CURSOR-ORDEM] CREATE CURSOR 'cursor_4c_Cmv' aparece em mais de um local com ORDEM DE CAMPOS DIFERENTE. Primeira ocorrencia: []. Segunda ocorrencia: [DATAS,VALCUSS,MOEDAS]. A ordem DEVE ser IDENTICA em TODOS os CREATE CURSOR do mesmo nome.
- [GRID-HEADER] Header Caption 'Total ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Descrição, Grupo, Subgrp., Ref. Fornecedor, Usuário, I, Empresa, Quantidade, Material, Un, Valor, Qtde., Total, Moe, Observação, E, Consumo, Ord, Moeda, Tam, Período, Valor Custo GR, Ordem, Fase, Utilização, Uni. Produtiva, Matriz, Local, Qtde, Componente, Uni, Ord., Cat., Agrupamento, Tempo %, Item, Qtd, Etiq, Grp, Data de Início, Data de Conclusão, Tarefa, Arquivos Para Designer. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Total ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Descrição, Grupo, Subgrp., Ref. Fornecedor, Usuário, I, Empresa, Quantidade, Material, Un, Valor, Qtde., Total, Moe, Observação, E, Consumo, Ord, Moeda, Tam, Período, Valor Custo GR, Ordem, Fase, Utilização, Uni. Produtiva, Matriz, Local, Qtde, Componente, Uni, Ord., Cat., Agrupamento, Tempo %, Item, Qtd, Etiq, Grp, Data de Início, Data de Conclusão, Tarefa, Arquivos Para Designer. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (11392 linhas total):

*-- Linhas 31 a 157:
31:     *--------------------------------------------------------------------------
32:     * Init - Inicializacao do formulario
33:     *--------------------------------------------------------------------------
34:     PROCEDURE Init()
35:         *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
36:         RETURN DODEFAULT()
37:     ENDPROC
38: 
39:     *--------------------------------------------------------------------------
40:     * InicializarForm - Configuracao inicial do formulario
41:     *--------------------------------------------------------------------------
42:     PROTECTED PROCEDURE InicializarForm()
43:         LOCAL loc_lSucesso
44:         loc_lSucesso = .F.
45: 
46:         TRY
47:             *-- Criar instancia do Business Object
48:             THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")
49: 
50:             IF ISNULL(THIS.this_oBusinessObject)
51:                 MostrarErro("Erro ao criar Business Object ProdutoBO", "Erro Cr" + CHR(237) + "tico")
52:             ELSE
53:                 THIS.ConfigurarPageFrame()
54:                 THIS.ConfigurarPaginaLista()
55:                 THIS.ConfigurarPaginaDados()
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
57: 
58:                 *-- Pula CarregarLista() se estiver validando UI (sem conexao SQL)
59:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
60:                     IF !THIS.CarregarLista()
61:                         *-- Se falhar ao carregar, nao impede abertura
62:                     ENDIF
63:                 ENDIF
64: 
65:                 THIS.AjustarBotoesPorModo()
66:                 THIS.pgf_4c_Paginas.Visible = .T.
67:                 THIS.pgf_4c_Paginas.ActivePage = 1
68:                 THIS.this_cModoAtual = "LISTA"
69:                 loc_lSucesso = .T.
70:             ENDIF
71: 
72:         CATCH TO loc_oErro
73:             MostrarErro("Erro ao inicializar FormProduto:" + CHR(13) + ;
74:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
75:                 loc_oErro.Message, "Erro")
76:             loc_lSucesso = .F.
77:         ENDTRY
78: 
79:         RETURN loc_lSucesso
80:     ENDPROC
81: 
82:     *--------------------------------------------------------------------------
83:     * ConfigurarPageFrame - Configura o PageFrame principal
84:     * Legado: Pagina Top=-29 (oculta abas), Width=1003, Height=631
85:     * Compensacao +29 aplicada em controles das Pages
86:     *--------------------------------------------------------------------------
87:     PROTECTED PROCEDURE ConfigurarPageFrame()
88:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
89: 
90:         WITH THIS.pgf_4c_Paginas
91:             .Top       = -29
92:             .Left      = 0
93:             .Width     = 1003
94:             .Height    = 631
95:             .PageCount = 2
96:             .Tabs      = .F.
97:             .Visible   = .T.
98: 
99:             *-- Page1 - Lista
100:             .Page1.Caption  = "Lista"
101:             .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:             .Page1.BackColor = RGB(255, 255, 255)
103: 
104:             *-- Page2 - Dados
105:             .Page2.Caption  = "Dados"
106:             .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107:             .Page2.BackColor = RGB(255, 255, 255)
108:         ENDWITH
109:     ENDPROC
110: 
111:     *--------------------------------------------------------------------------
112:     * ConfigurarPaginaLista - Configura Page1 (Lista)
113:     * Top original = -1 dos grupos -> compensado para 28 (+29)
114:     * Grade: Top=173, Left=38, Width=922, Height=409 (7 colunas)
115:     * cntFiltros: Top=82, Left=0, Width=383, Height=87
116:     *--------------------------------------------------------------------------
117:     PROTECTED PROCEDURE ConfigurarPaginaLista()
118:         LOCAL loc_oPagina, loc_oGrade
119:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
120: 
121:         *-- Container de cabecalho (cntSombra: Top=1+29=30, Width=1000, Height=80)
122:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
123:         WITH loc_oPagina.cnt_4c_Cabecalho
124:             .Top         = 30
125:             .Left        = 0
126:             .Width       = 1000
127:             .Height      = 80
128:             .BackStyle   = 1
129:             .BackColor   = RGB(53, 53, 53)
130:             .BorderWidth = 0
131:             .Visible     = .T.
132:         ENDWITH
133: 
134:         *-- Label titulo no cabecalho
135:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
136:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
137:             .Caption   = "Cadastro de Produtos"
138:             .Top       = 20
139:             .Left      = 20
140:             .Width     = 400
141:             .Height    = 30
142:             .FontName  = "Tahoma"
143:             .FontSize  = 14
144:             .FontBold  = .T.
145:             .BackStyle = 0
146:             .ForeColor = RGB(255, 255, 255)
147:             .Visible   = .T.
148:         ENDWITH
149: 
150:         *-- Container de filtros (cntFiltros: Top=82+29=111, Left=0, W=383, H=87)
151:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
152:         WITH loc_oPagina.cnt_4c_Filtros
153:             .Top         = 111
154:             .Left        = 0
155:             .Width       = 383
156:             .Height      = 87
157:             .BackStyle   = 0

*-- Linhas 187 a 230:
187:             .Themes   = .F.
188:             .Visible  = .T.
189:         ENDWITH
190:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_FilCgru, "KeyPress", THIS, "TxtFilCgruKeyPress")
191: 
192:         *-- TextBox Dgru (getDgru: Top=14, Left=149, W=156, H=23)
193:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FilDgru", "TextBox")
194:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FilDgru
195:             .Value    = ""
196:             .Top      = 14
197:             .Left     = 149
198:             .Width    = 156
199:             .Height   = 23
200:             .FontName = "Tahoma"
201:             .FontSize = 8
202:             .Themes   = .F.
203:             .ReadOnly = .T.
204:             .Visible  = .T.
205:         ENDWITH
206: 
207:         *-- Label Ultima Alteracao
208:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData1", "Label")
209:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData1
210:             .Caption   = CHR(218) + "ltima Altera" + CHR(231) + CHR(227) + "o :"
211:             .Top       = 43
212:             .Left      = 28
213:             .Width     = 87
214:             .Height    = 15
215:             .BackStyle = 0
216:             .ForeColor = RGB(90, 90, 90)
217:             .FontName  = "Tahoma"
218:             .FontSize  = 8
219:             .Visible   = .T.
220:         ENDWITH
221: 
222:         *-- TextBox DtIni (getDtIni: Top=39, Left=116, H=23)
223:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FilDtIni", "TextBox")
224:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FilDtIni
225:             .Value       = {}
226:             .Top         = 39
227:             .Left        = 116
228:             .Width       = 85
229:             .Height      = 23
230:             .FontName    = "Tahoma"

*-- Linhas 264 a 495:
264:             .Visible     = .T.
265:         ENDWITH
266: 
267:         *-- OptionGroup Situacao (optFilSituas: Top=19, Left=303, W=78, H=46, ButtonCount=3)
268:         loc_oPagina.cnt_4c_Filtros.AddObject("obj_4c_OptFilSituas", "OptionGroup")
269:         WITH loc_oPagina.cnt_4c_Filtros.obj_4c_OptFilSituas
270:             .ButtonCount = 3
271:             .Top         = 19
272:             .Left        = 303
273:             .Width       = 78
274:             .Height      = 46
275:             .BorderStyle = 0
276:             .Visible     = .T.
277:         ENDWITH
278:         WITH loc_oPagina.cnt_4c_Filtros.obj_4c_OptFilSituas.Buttons(1)
279:             .Caption  = "Todos"
280:             .Top      = 2
281:             .Left     = 2
282:             .AutoSize = .T.
283:             .FontName = "Tahoma"
284:             .FontSize = 8
285:             .Themes   = .F.
286:             .Value    = 1
287:             .Visible  = .T.
288:         ENDWITH
289:         WITH loc_oPagina.cnt_4c_Filtros.obj_4c_OptFilSituas.Buttons(2)
290:             .Caption  = "Ativo"
291:             .Top      = 16
292:             .Left     = 2
293:             .AutoSize = .T.
294:             .FontName = "Tahoma"
295:             .FontSize = 8
296:             .Themes   = .F.
297:             .Visible  = .T.
298:         ENDWITH
299:         WITH loc_oPagina.cnt_4c_Filtros.obj_4c_OptFilSituas.Buttons(3)
300:             .Caption  = "Inativo"
301:             .Top      = 30
302:             .Left     = 2
303:             .AutoSize = .T.
304:             .FontName = "Tahoma"
305:             .FontSize = 8
306:             .Themes   = .F.
307:             .Visible  = .T.
308:         ENDWITH
309:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.obj_4c_OptFilSituas, "InteractiveChange", THIS, "FiltroSituacaoChange")
310: 
311:         *-- Container de botoes CRUD (Grupo_op: Left=542, Top=-1+29=28)
312:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
313:         WITH loc_oPagina.cnt_4c_Botoes
314:             .Top         = 28
315:             .Left        = 542
316:             .Width       = 400
317:             .Height      = 85
318:             .BackStyle = 1
319:             .BackColor = RGB(53, 53, 53)
320:             .BorderWidth = 0
321:             .Visible     = .T.
322:         ENDWITH
323: 
324:         *-- Botao Incluir (Inserir: Left=5)
325:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
326:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
327:             .Caption         = "Incluir"
328:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
329:             .PicturePosition = 13
330:             .Width           = 75
331:             .Height          = 75
332:             .Left            = 5
333:             .Top             = 5
334:             .FontName        = "Tahoma"
335:             .FontSize        = 8
336:             .Themes          = .F.
337:             .SpecialEffect   = 0
338:             .BackColor       = RGB(255, 255, 255)
339:             .ForeColor       = RGB(90, 90, 90)
340:             .Visible         = .T.
341:         ENDWITH
342:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
343: 
344:         *-- Botao Visualizar (Consultar: Left=80)
345:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
346:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
347:             .Caption         = "Visualizar"
348:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
349:             .PicturePosition = 13
350:             .Width           = 75
351:             .Height          = 75
352:             .Left            = 80
353:             .Top             = 5
354:             .FontName        = "Tahoma"
355:             .FontSize        = 8
356:             .Themes          = .F.
357:             .SpecialEffect   = 0
358:             .BackColor       = RGB(255, 255, 255)
359:             .ForeColor       = RGB(90, 90, 90)
360:             .Visible         = .T.
361:         ENDWITH
362:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
363: 
364:         *-- Botao Alterar (Left=155)
365:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
366:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
367:             .Caption         = "Alterar"
368:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
369:             .PicturePosition = 13
370:             .Width           = 75
371:             .Height          = 75
372:             .Left            = 155
373:             .Top             = 5
374:             .FontName        = "Tahoma"
375:             .FontSize        = 8
376:             .Themes          = .F.
377:             .SpecialEffect   = 0
378:             .BackColor       = RGB(255, 255, 255)
379:             .ForeColor       = RGB(90, 90, 90)
380:             .Visible         = .T.
381:         ENDWITH
382:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
383: 
384:         *-- Botao Excluir (Left=230)
385:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
386:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
387:             .Caption         = "Excluir"
388:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
389:             .PicturePosition = 13
390:             .Width           = 75
391:             .Height          = 75
392:             .Left            = 230
393:             .Top             = 5
394:             .FontName        = "Tahoma"
395:             .FontSize        = 8
396:             .Themes          = .F.
397:             .SpecialEffect   = 0
398:             .BackColor       = RGB(255, 255, 255)
399:             .ForeColor       = RGB(90, 90, 90)
400:             .Visible         = .T.
401:         ENDWITH
402:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
403: 
404:         *-- Botao Procurar (Left=305)
405:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Procurar", "CommandButton")
406:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Procurar
407:             .Caption         = "Procurar"
408:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
409:             .PicturePosition = 13
410:             .Width           = 75
411:             .Height          = 75
412:             .Left            = 305
413:             .Top             = 5
414:             .FontName        = "Tahoma"
415:             .FontSize        = 8
416:             .Themes          = .F.
417:             .SpecialEffect   = 0
418:             .BackColor       = RGB(255, 255, 255)
419:             .ForeColor       = RGB(90, 90, 90)
420:             .Visible         = .T.
421:         ENDWITH
422:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Procurar, "Click", THIS, "BtnProcurarClick")
423: 
424:         *-- Container Sair (Grupo_Saida: Left=917, Top=-1+29=28)
425:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
426:         WITH loc_oPagina.cnt_4c_Saida
427:             .Top         = 28
428:             .Left        = 917
429:             .Width       = 80
430:             .Height      = 85
431:             .BackStyle = 1
432:             .BackColor = RGB(53, 53, 53)
433:             .BorderWidth = 0
434:             .Visible     = .T.
435:         ENDWITH
436: 
437:         *-- Botao Sair (Sair: Left=5)
438:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Sair", "CommandButton")
439:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Sair
440:             .Caption         = "Sair"
441:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
442:             .PicturePosition = 13
443:             .Width           = 75
444:             .Height          = 75
445:             .Left            = 5
446:             .Top             = 5
447:             .FontName        = "Tahoma"
448:             .FontSize        = 8
449:             .Themes          = .F.
450:             .SpecialEffect   = 0
451:             .BackColor       = RGB(255, 255, 255)
452:             .ForeColor       = RGB(90, 90, 90)
453:             .Visible         = .T.
454:         ENDWITH
455:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
456: 
457:         *-- Grade principal (Grade: Left=38, Top=173+29=202, W=922, H=409, 7 colunas)
458:         *-- IMPORTANTE: RecordMark=.F., DeleteMark=.F.
459:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
460:         loc_oGrade = loc_oPagina.grd_4c_Dados
461:         WITH loc_oGrade
462:             .Top           = 202
463:             .Left          = 38
464:             .Width         = 922
465:             .Height        = 409
466:             .FontName      = "Arial"
467:             .FontSize      = 8
468:             .RecordMark    = .F.
469:             .DeleteMark    = .F.
470:             .GridLines     = 3
471:             .ReadOnly      = .T.
472:             .Themes        = .F.
473:             .ColumnCount   = 7
474:             .Visible       = .T.
475:         ENDWITH
476: 
477:         *-- Configurar colunas APOS ColumnCount (cabecalhos serao re-aplicados pos RecordSource)
478:         WITH loc_oGrade.Column1
479:             .Width     = 110
480:             .Movable   = .F.
481:             .Resizable = .F.
482:             .ReadOnly  = .T.
483:         ENDWITH
484:         WITH loc_oGrade.Column2
485:             .Width     = 408
486:             .Movable   = .F.
487:             .Resizable = .F.
488:             .ReadOnly  = .T.
489:         ENDWITH
490:         WITH loc_oGrade.Column3
491:             .Width     = 40
492:             .Movable   = .F.
493:             .Resizable = .F.
494:             .ReadOnly  = .T.
495:         ENDWITH

*-- Linhas 540 a 737:
540:             .Visible   = .T.
541:         ENDWITH
542: 
543:         THIS.TornarControlesVisiveis(loc_oPagina)
544:     ENDPROC
545: 
546:     *--------------------------------------------------------------------------
547:     * ConfigurarPaginaDados - Configura Page2 (Dados)
548:     * Estrutura: botoes Salvar/Cancelar + PageFrame interno (7 abas)
549:     * Grupo_Salva: Left=842, Top=5+29=34, H=85
550:     * pgframeDados: Top=-54+29=-25, Left=-1, W=1003, H=656, 7 paginas
551:     *--------------------------------------------------------------------------
552:     PROTECTED PROCEDURE ConfigurarPaginaDados()
553:         LOCAL loc_oPagina, loc_oPgf
554:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
555: 
556:         *-- Container de botoes Salvar/Cancelar (Grupo_Salva)
557:         loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
558:         WITH loc_oPagina.cnt_4c_BotoesDados
559:             .Top         = 34
560:             .Left        = 842
561:             .Width       = 155
562:             .Height      = 85
563:             .BackStyle = 1
564:             .BackColor = RGB(53, 53, 53)
565:             .BorderWidth = 0
566:             .Visible     = .T.
567:         ENDWITH
568: 
569:         *-- Botao Salvar (Salva: Left=5)
570:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
571:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
572:             .Caption         = "Salvar"
573:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
574:             .PicturePosition = 13
575:             .Width           = 75
576:             .Height          = 75
577:             .Left            = 5
578:             .Top             = 5
579:             .FontName        = "Tahoma"
580:             .FontSize        = 8
581:             .Themes          = .F.
582:             .SpecialEffect   = 0
583:             .BackColor       = RGB(255, 255, 255)
584:             .ForeColor       = RGB(90, 90, 90)
585:             .Visible         = .T.
586:         ENDWITH
587:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
588: 
589:         *-- Botao Cancelar (Cancelar: Left=80)
590:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
591:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
592:             .Caption         = "Cancelar"
593:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
594:             .PicturePosition = 13
595:             .Width           = 75
596:             .Height          = 75
597:             .Left            = 80
598:             .Top             = 5
599:             .FontName        = "Tahoma"
600:             .FontSize        = 8
601:             .Themes          = .F.
602:             .SpecialEffect   = 0
603:             .BackColor       = RGB(255, 255, 255)
604:             .ForeColor       = RGB(90, 90, 90)
605:             .Visible         = .T.
606:         ENDWITH
607:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
608: 
609:         *-- PageFrame interno (pgframeDados: Top=-54+29=-25, Left=-1, W=1003, H=656, 7 pags)
610:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
611:         loc_oPgf = loc_oPagina.pgf_4c_Dados
612:         WITH loc_oPgf
613:             .Top       = -25
614:             .Left      = -1
615:             .Width     = 1003
616:             .Height    = 656
617:             .PageCount = 7
618:             .Tabs      = .F.
619:             .Visible   = .T.
620:         ENDWITH
621: 
622:         *-- Configurar abas do PageFrame interno
623:         WITH loc_oPgf
624:             .Page1.Caption = "Dados"
625:             .Page2.Caption = "Composi" + CHR(231) + CHR(227) + "o"
626:             .Page3.Caption = "Dados Fiscais"
627:             .Page4.Caption = "Fases P."
628:             .Page5.Caption = "Cons. P."
629:             .Page6.Caption = "Custo"
630:             .Page7.Caption = "Designer"
631:         ENDWITH
632: 
633:         *-- Configurar pgDados (Page1 do PageFrame interno)
634:         THIS.ConfigurarPaginaDadosPrincipal(loc_oPgf.Page1)
635: 
636:         *-- Configurar pgComposicao (Page2 do PageFrame interno)
637:         THIS.ConfigurarPgpgComposicao(loc_oPgf.Page2)
638: 
639:         *-- Configurar pgCusto (Page6 do PageFrame interno)
640:         THIS.ConfigurarPgpgCusto(loc_oPgf.Page6)
641: 
642:         *-- Configurar PgDadosFaseP (Page4 do PageFrame interno)
643:         THIS.ConfigurarPgPgDadosFaseP(loc_oPgf.Page4)
644: 
645:         *-- Configurar PgDadosConsP (Page5 do PageFrame interno)
646:         THIS.ConfigurarPgPgDadosConsP(loc_oPgf.Page5)
647: 
648:         *-- Configurar pgDadosFiscais (Page3 do PageFrame interno)
649:         THIS.ConfigurarPgpgDadosFiscais(loc_oPgf.Page3)
650: 
651:         *-- Configurar pgDesigner (Page7 do PageFrame interno)
652:         THIS.ConfigurarPgpgDesigner(loc_oPgf.Page7)
653: 
654:         THIS.TornarControlesVisiveis(loc_oPagina)
655:     ENDPROC
656: 
657:     *--------------------------------------------------------------------------
658:     * ConfigurarPaginaDadosPrincipal - Aba "Dados" do PageFrame interno (pgDados)
659:     * Fase 5: Campos principais parte 1 (50%)
660:     * Posicoes = valores ORIGINAIS do layout.json (pgf_4c_Dados.Tabs=.F. -> sem +29)
661:     * Colunas SigCdPro: cpros, dpros, dpro2s, cgrus, cods, cbars, clins, ccols, ifors, reffs
662:     *--------------------------------------------------------------------------
663:     PROTECTED PROCEDURE ConfigurarPaginaDadosPrincipal(par_oPage)
664:         LOCAL loc_oPg
665:         loc_oPg = par_oPage
666: 
667:         *-- ===================================================================
668:         *-- LINHA 1 (top=130): getCpro + getDpro
669:         *-- ===================================================================
670:         loc_oPg.AddObject("lbl_4c_LblProduto", "Label")
671:         WITH loc_oPg.lbl_4c_LblProduto
672:             .Caption   = "Produto :"
673:             .Top       = 134
674:             .Left      = 58
675:             .Width     = 53
676:             .Height    = 15
677:             .BackStyle = 0
678:             .ForeColor = RGB(90, 90, 90)
679:             .FontName  = "Tahoma"
680:             .FontSize  = 8
681:             .Visible   = .T.
682:         ENDWITH
683: 
684:         *-- TextBox getCpro (cpros: Top=130, Left=113, W=108, H=23)
685:         loc_oPg.AddObject("txt_4c_Cpros", "TextBox")
686:         WITH loc_oPg.txt_4c_Cpros
687:             .Value    = ""
688:             .Top      = 130
689:             .Left     = 113
690:             .Width    = 108
691:             .Height   = 23
692:             .FontName = "Tahoma"
693:             .FontSize = 8
694:             .Themes   = .F.
695:             .Visible  = .T.
696:         ENDWITH
697:         BINDEVENT(loc_oPg.txt_4c_Cpros, "KeyPress", THIS, "TxtCprosKeyPress")
698: 
699:         *-- TextBox getDpro (dpros: Top=130, Left=222, W=290, H=23 - READ ONLY)
700:         loc_oPg.AddObject("txt_4c_Dpros", "TextBox")
701:         WITH loc_oPg.txt_4c_Dpros
702:             .Value     = ""
703:             .Top       = 130
704:             .Left      = 222
705:             .Width     = 290
706:             .Height    = 23
707:             .FontName  = "Tahoma"
708:             .FontSize  = 8
709:             .ReadOnly  = .T.
710:             .BackColor = RGB(224, 235, 235)
711:             .Themes    = .F.
712:             .Visible   = .T.
713:         ENDWITH
714: 
715:         *-- ===================================================================
716:         *-- LINHA 2 (top=154): getDPro2s | getCbar (right, top=155)
717:         *-- ===================================================================
718: 
719:         *-- TextBox getDPro2s (dpro2s: Top=154, Left=113, W=399, H=23 - segunda descricao)
720:         loc_oPg.AddObject("txt_4c_DPro2s", "TextBox")
721:         WITH loc_oPg.txt_4c_DPro2s
722:             .Value    = ""
723:             .Top      = 154
724:             .Left     = 113
725:             .Width    = 399
726:             .Height   = 23
727:             .FontName = "Tahoma"
728:             .FontSize = 8
729:             .Themes   = .F.
730:             .Visible  = .T.
731:         ENDWITH
732: 
733:         *-- Label Barra
734:         loc_oPg.AddObject("lbl_4c_LblCbar", "Label")
735:         WITH loc_oPg.lbl_4c_LblCbar
736:             .Caption   = "Barra :"
737:             .Top       = 159

*-- Linhas 789 a 832:
789:             .Themes   = .F.
790:             .Visible  = .T.
791:         ENDWITH
792:         BINDEVENT(loc_oPg.txt_4c_Cgrus, "KeyPress", THIS, "TxtCgrusKeyPress")
793: 
794:         *-- TextBox getDgru display (dgrus: Top=178, Left=145, W=171, H=23 - READ ONLY)
795:         loc_oPg.AddObject("txt_4c_DgruDisplay", "TextBox")
796:         WITH loc_oPg.txt_4c_DgruDisplay
797:             .Value     = ""
798:             .Top       = 178
799:             .Left      = 145
800:             .Width     = 171
801:             .Height    = 23
802:             .FontName  = "Tahoma"
803:             .FontSize  = 8
804:             .ReadOnly  = .T.
805:             .BackColor = RGB(224, 235, 235)
806:             .Themes    = .F.
807:             .Visible   = .T.
808:         ENDWITH
809: 
810:         *-- ===================================================================
811:         *-- LINHA 4 (top=202): GetCSGru + GetDsGru
812:         *-- ===================================================================
813:         loc_oPg.AddObject("lbl_4c_LblSubgrupo", "Label")
814:         WITH loc_oPg.lbl_4c_LblSubgrupo
815:             .Caption   = "Subgrupo :"
816:             .Top       = 206
817:             .Left      = 56
818:             .Width     = 55
819:             .Height    = 15
820:             .BackStyle = 0
821:             .ForeColor = RGB(90, 90, 90)
822:             .FontName  = "Tahoma"
823:             .FontSize  = 8
824:             .Visible   = .T.
825:         ENDWITH
826: 
827:         *-- TextBox GetCSGru (cods: Top=202, Left=113, W=52, H=23)
828:         loc_oPg.AddObject("txt_4c_Cods", "TextBox")
829:         WITH loc_oPg.txt_4c_Cods
830:             .Value    = ""
831:             .Top      = 202
832:             .Left     = 113

*-- Linhas 884 a 1023:
884:             .Themes   = .F.
885:             .Visible  = .T.
886:         ENDWITH
887:         BINDEVENT(loc_oPg.txt_4c_Lin, "KeyPress", THIS, "TxtLinKeyPress")
888: 
889:         *-- TextBox GetDLin display (dlins: Top=226, Left=194, W=318, H=23 - READ ONLY)
890:         loc_oPg.AddObject("txt_4c_DLinDisplay", "TextBox")
891:         WITH loc_oPg.txt_4c_DLinDisplay
892:             .Value     = ""
893:             .Top       = 226
894:             .Left      = 194
895:             .Width     = 318
896:             .Height    = 23
897:             .FontName  = "Tahoma"
898:             .FontSize  = 8
899:             .ReadOnly  = .T.
900:             .BackColor = RGB(224, 235, 235)
901:             .Themes    = .F.
902:             .Visible   = .T.
903:         ENDWITH
904: 
905:         *-- ===================================================================
906:         *-- LINHA 6 (top=250): GetCol + GetDCol (Grupo de Venda / SigCdCol)
907:         *-- ===================================================================
908:         loc_oPg.AddObject("lbl_4c_LblCol", "Label")
909:         WITH loc_oPg.lbl_4c_LblCol
910:             .Caption   = "Grupo Venda :"
911:             .Top       = 254
912:             .Left      = 42
913:             .Width     = 69
914:             .Height    = 15
915:             .BackStyle = 0
916:             .ForeColor = RGB(90, 90, 90)
917:             .FontName  = "Tahoma"
918:             .FontSize  = 8
919:             .Visible   = .T.
920:         ENDWITH
921: 
922:         *-- TextBox GetCol (ccols: Top=250, Left=113, W=80, H=23)
923:         loc_oPg.AddObject("txt_4c_Col", "TextBox")
924:         WITH loc_oPg.txt_4c_Col
925:             .Value    = ""
926:             .Top      = 250
927:             .Left     = 113
928:             .Width    = 80
929:             .Height   = 23
930:             .FontName = "Tahoma"
931:             .FontSize = 8
932:             .Themes   = .F.
933:             .Visible  = .T.
934:         ENDWITH
935:         BINDEVENT(loc_oPg.txt_4c_Col, "KeyPress", THIS, "TxtColKeyPress")
936: 
937:         *-- TextBox GetDCol display (dcols: Top=250, Left=194, W=318, H=23 - READ ONLY)
938:         loc_oPg.AddObject("txt_4c_DColDisplay", "TextBox")
939:         WITH loc_oPg.txt_4c_DColDisplay
940:             .Value     = ""
941:             .Top       = 250
942:             .Left      = 194
943:             .Width     = 318
944:             .Height    = 23
945:             .FontName  = "Tahoma"
946:             .FontSize  = 8
947:             .ReadOnly  = .T.
948:             .BackColor = RGB(224, 235, 235)
949:             .Themes    = .F.
950:             .Visible   = .T.
951:         ENDWITH
952: 
953:         *-- ===================================================================
954:         *-- LINHA 7 (top=274): getIfor + getDfor (Fornecedor)
955:         *-- ===================================================================
956:         loc_oPg.AddObject("lbl_4c_LblIfor", "Label")
957:         WITH loc_oPg.lbl_4c_LblIfor
958:             .Caption   = "Fornecedor :"
959:             .Top       = 278
960:             .Left      = 44
961:             .Width     = 67
962:             .Height    = 15
963:             .BackStyle = 0
964:             .ForeColor = RGB(90, 90, 90)
965:             .FontName  = "Tahoma"
966:             .FontSize  = 8
967:             .Visible   = .T.
968:         ENDWITH
969: 
970:         *-- TextBox getIfor (ifors: Top=274, Left=113, W=80, H=23)
971:         loc_oPg.AddObject("txt_4c_Ifor", "TextBox")
972:         WITH loc_oPg.txt_4c_Ifor
973:             .Value    = ""
974:             .Top      = 274
975:             .Left     = 113
976:             .Width    = 80
977:             .Height   = 23
978:             .FontName = "Tahoma"
979:             .FontSize = 8
980:             .Themes   = .F.
981:             .Visible  = .T.
982:         ENDWITH
983:         BINDEVENT(loc_oPg.txt_4c_Ifor, "KeyPress", THIS, "TxtIforKeyPress")
984: 
985:         *-- TextBox getDfor display (nome fornecedor: Top=274, Left=194, W=318, H=23 - READ ONLY)
986:         loc_oPg.AddObject("txt_4c_DforDisplay", "TextBox")
987:         WITH loc_oPg.txt_4c_DforDisplay
988:             .Value     = ""
989:             .Top       = 274
990:             .Left      = 194
991:             .Width     = 318
992:             .Height    = 23
993:             .FontName  = "Tahoma"
994:             .FontSize  = 8
995:             .ReadOnly  = .T.
996:             .BackColor = RGB(224, 235, 235)
997:             .Themes    = .F.
998:             .Visible   = .T.
999:         ENDWITH
1000: 
1001:         *-- ===================================================================
1002:         *-- LINHA 8 (top=298): getRefs (Referencia do Fornecedor)
1003:         *-- ===================================================================
1004:         loc_oPg.AddObject("lbl_4c_LblRefs", "Label")
1005:         WITH loc_oPg.lbl_4c_LblRefs
1006:             .Caption   = "Ref. Fornecedor :"
1007:             .Top       = 302
1008:             .Left      = 20
1009:             .Width     = 91
1010:             .Height    = 15
1011:             .BackStyle = 0
1012:             .ForeColor = RGB(90, 90, 90)
1013:             .FontName  = "Tahoma"
1014:             .FontSize  = 8
1015:             .Visible   = .T.
1016:         ENDWITH
1017: 
1018:         *-- TextBox getRefs (reffs: Top=298, Left=113, W=152, H=23)
1019:         loc_oPg.AddObject("txt_4c_Refs", "TextBox")
1020:         WITH loc_oPg.txt_4c_Refs
1021:             .Value    = ""
1022:             .Top      = 298
1023:             .Left     = 113

*-- Linhas 1059 a 1133:
1059:             .Themes   = .F.
1060:             .Visible  = .T.
1061:         ENDWITH
1062:         BINDEVENT(loc_oPg.txt_4c_Cor, "KeyPress", THIS, "TxtCorKeyPress")
1063:         BINDEVENT(loc_oPg.txt_4c_Cor, "DblClick", THIS, "AbrirLookupCor")
1064: 
1065:         loc_oPg.AddObject("lbl_4c_LblTam", "Label")
1066:         WITH loc_oPg.lbl_4c_LblTam
1067:             .Caption   = "Tam :"
1068:             .Top       = 302
1069:             .Left      = 445
1070:             .Width     = 27
1071:             .Height    = 15
1072:             .BackStyle = 0
1073:             .ForeColor = RGB(90, 90, 90)
1074:             .FontName  = "Tahoma"
1075:             .FontSize  = 8
1076:             .Visible   = .T.
1077:         ENDWITH
1078: 
1079:         *-- TextBox getTam (codtams: Top=298, Left=474, W=38, H=23)
1080:         loc_oPg.AddObject("txt_4c_Tam", "TextBox")
1081:         WITH loc_oPg.txt_4c_Tam
1082:             .Value    = ""
1083:             .Top      = 298
1084:             .Left     = 474
1085:             .Width    = 38
1086:             .Height   = 23
1087:             .FontName = "Tahoma"
1088:             .FontSize = 8
1089:             .Themes   = .F.
1090:             .Visible  = .T.
1091:         ENDWITH
1092:         BINDEVENT(loc_oPg.txt_4c_Tam, "KeyPress", THIS, "TxtTamKeyPress")
1093:         BINDEVENT(loc_oPg.txt_4c_Tam, "DblClick", THIS, "AbrirLookupTam")
1094: 
1095:         *-- RIGHT SIDE top area: getDtSituas (T:132, L:878)
1096:         loc_oPg.AddObject("lbl_4c_LblDtSitua", "Label")
1097:         WITH loc_oPg.lbl_4c_LblDtSitua
1098:             .Caption   = "Dt.Situa" + CHR(231) + CHR(227) + "o :"
1099:             .Top       = 120
1100:             .Left      = 785
1101:             .Width     = 91
1102:             .Height    = 15
1103:             .BackStyle = 0
1104:             .ForeColor = RGB(90, 90, 90)
1105:             .FontName  = "Tahoma"
1106:             .FontSize  = 8
1107:             .Visible   = .T.
1108:         ENDWITH
1109: 
1110:         *-- TextBox getDtSituas (dtsituas: Top=132, Left=878, W=80, H=21)
1111:         loc_oPg.AddObject("txt_4c_DtSituas", "TextBox")
1112:         WITH loc_oPg.txt_4c_DtSituas
1113:             .Value     = {}
1114:             .Top       = 132
1115:             .Left      = 878
1116:             .Width     = 80
1117:             .Height    = 21
1118:             .FontName  = "Tahoma"
1119:             .FontSize  = 8
1120:             .Format    = "D"
1121:             .ReadOnly  = .T.
1122:             .BackColor = RGB(224, 235, 235)
1123:             .Themes    = .F.
1124:             .Visible   = .T.
1125:         ENDWITH
1126: 
1127:         *-- ===================================================================
1128:         *-- LINHA 9 (top=322): getCodFinP + getDesFinP + getPesoBs
1129:         *-- ===================================================================
1130:         loc_oPg.AddObject("lbl_4c_LblFinP", "Label")
1131:         WITH loc_oPg.lbl_4c_LblFinP
1132:             .Caption   = "Ficha :"
1133:             .Top       = 326

*-- Linhas 1154 a 1198:
1154:             .Themes   = .F.
1155:             .Visible  = .T.
1156:         ENDWITH
1157:         BINDEVENT(loc_oPg.txt_4c_CodFinP, "KeyPress", THIS, "TxtCodFinPKeyPress")
1158:         BINDEVENT(loc_oPg.txt_4c_CodFinP, "DblClick", THIS, "AbrirLookupFinP")
1159: 
1160:         *-- TextBox getDesFinP (desc ficha: Top=322, Left=145, W=150, H=23 - READ ONLY)
1161:         loc_oPg.AddObject("txt_4c_DesFinP", "TextBox")
1162:         WITH loc_oPg.txt_4c_DesFinP
1163:             .Value     = ""
1164:             .Top       = 322
1165:             .Left      = 145
1166:             .Width     = 150
1167:             .Height    = 23
1168:             .FontName  = "Tahoma"
1169:             .FontSize  = 8
1170:             .ReadOnly  = .T.
1171:             .BackColor = RGB(224, 235, 235)
1172:             .Themes    = .F.
1173:             .Visible   = .T.
1174:         ENDWITH
1175: 
1176:         loc_oPg.AddObject("lbl_4c_LblPesoB", "Label")
1177:         WITH loc_oPg.lbl_4c_LblPesoB
1178:             .Caption   = "Peso Base :"
1179:             .Top       = 326
1180:             .Left      = 316
1181:             .Width     = 64
1182:             .Height    = 15
1183:             .BackStyle = 0
1184:             .ForeColor = RGB(90, 90, 90)
1185:             .FontName  = "Tahoma"
1186:             .FontSize  = 8
1187:             .Visible   = .T.
1188:         ENDWITH
1189: 
1190:         *-- TextBox getPesoBs (pesobs: Top=322, Left=401, W=111, H=23)
1191:         loc_oPg.AddObject("txt_4c_PesoB", "TextBox")
1192:         WITH loc_oPg.txt_4c_PesoB
1193:             .Value    = 0.0
1194:             .Top      = 322
1195:             .Left     = 401
1196:             .Width    = 111
1197:             .Height   = 23
1198:             .FontName = "Tahoma"

*-- Linhas 1231 a 1275:
1231:             .Themes   = .F.
1232:             .Visible  = .T.
1233:         ENDWITH
1234:         BINDEVENT(loc_oPg.txt_4c_CodAcb, "KeyPress", THIS, "TxtCodAcbKeyPress")
1235:         BINDEVENT(loc_oPg.txt_4c_CodAcb, "DblClick", THIS, "AbrirLookupAcb")
1236: 
1237:         *-- TextBox get_Dacb (desc acabamento: Top=346, Left=145, W=150, H=23 - READ ONLY)
1238:         loc_oPg.AddObject("txt_4c_DacbDisplay", "TextBox")
1239:         WITH loc_oPg.txt_4c_DacbDisplay
1240:             .Value     = ""
1241:             .Top       = 346
1242:             .Left      = 145
1243:             .Width     = 150
1244:             .Height    = 23
1245:             .FontName  = "Tahoma"
1246:             .FontSize  = 8
1247:             .ReadOnly  = .T.
1248:             .BackColor = RGB(224, 235, 235)
1249:             .Themes    = .F.
1250:             .Visible   = .T.
1251:         ENDWITH
1252: 
1253:         loc_oPg.AddObject("lbl_4c_LblPmedio", "Label")
1254:         WITH loc_oPg.lbl_4c_LblPmedio
1255:             .Caption   = "Pr." + CHR(233) + "dio :"
1256:             .Top       = 350
1257:             .Left      = 316
1258:             .Width     = 64
1259:             .Height    = 15
1260:             .BackStyle = 0
1261:             .ForeColor = RGB(90, 90, 90)
1262:             .FontName  = "Tahoma"
1263:             .FontSize  = 8
1264:             .Visible   = .T.
1265:         ENDWITH
1266: 
1267:         *-- TextBox getPmedio (pcuss: Top=346, Left=401, W=111, H=23 - READ ONLY custo)
1268:         loc_oPg.AddObject("txt_4c_Pmedio", "TextBox")
1269:         WITH loc_oPg.txt_4c_Pmedio
1270:             .Value     = 0.0
1271:             .Top       = 346
1272:             .Left      = 401
1273:             .Width     = 111
1274:             .Height    = 23
1275:             .FontName  = "Tahoma"

*-- Linhas 1310 a 1526:
1310:             .Themes   = .F.
1311:             .Visible  = .T.
1312:         ENDWITH
1313:         BINDEVENT(loc_oPg.txt_4c_Class, "KeyPress", THIS, "TxtClassKeyPress")
1314:         BINDEVENT(loc_oPg.txt_4c_Class, "DblClick", THIS, "AbrirLookupClass")
1315: 
1316:         *-- TextBox Get_DClass (desc classe: Top=370, Left=145, W=150, H=23 - READ ONLY)
1317:         loc_oPg.AddObject("txt_4c_DClassDisplay", "TextBox")
1318:         WITH loc_oPg.txt_4c_DClassDisplay
1319:             .Value     = ""
1320:             .Top       = 370
1321:             .Left      = 145
1322:             .Width     = 150
1323:             .Height    = 23
1324:             .FontName  = "Tahoma"
1325:             .FontSize  = 8
1326:             .ReadOnly  = .T.
1327:             .BackColor = RGB(224, 235, 235)
1328:             .Themes    = .F.
1329:             .Visible   = .T.
1330:         ENDWITH
1331: 
1332:         loc_oPg.AddObject("lbl_4c_LblLocal", "Label")
1333:         WITH loc_oPg.lbl_4c_LblLocal
1334:             .Caption   = "Local :"
1335:             .Top       = 374
1336:             .Left      = 346
1337:             .Width     = 36
1338:             .Height    = 15
1339:             .BackStyle = 0
1340:             .ForeColor = RGB(90, 90, 90)
1341:             .FontName  = "Tahoma"
1342:             .FontSize  = 8
1343:             .Visible   = .T.
1344:         ENDWITH
1345: 
1346:         *-- TextBox Get_Local (locals: Top=370, Left=401, W=111, H=23)
1347:         loc_oPg.AddObject("txt_4c_Local", "TextBox")
1348:         WITH loc_oPg.txt_4c_Local
1349:             .Value    = ""
1350:             .Top      = 370
1351:             .Left     = 401
1352:             .Width    = 111
1353:             .Height   = 23
1354:             .FontName = "Tahoma"
1355:             .FontSize = 8
1356:             .Themes   = .F.
1357:             .Visible  = .T.
1358:         ENDWITH
1359:         BINDEVENT(loc_oPg.txt_4c_Local, "KeyPress", THIS, "TxtLocalKeyPress")
1360:         BINDEVENT(loc_oPg.txt_4c_Local, "DblClick", THIS, "AbrirLookupLocal")
1361: 
1362:         *-- RIGHT SIDE: Custo Total + Moeda Custo (top=362/375)
1363:         loc_oPg.AddObject("lbl_4c_LblCtotal", "Label")
1364:         WITH loc_oPg.lbl_4c_LblCtotal
1365:             .Caption   = "Custo :"
1366:             .Top       = 362
1367:             .Left      = 572
1368:             .Width     = 53
1369:             .Height    = 15
1370:             .BackStyle = 0
1371:             .ForeColor = RGB(90, 90, 90)
1372:             .FontName  = "Tahoma"
1373:             .FontSize  = 8
1374:             .Visible   = .T.
1375:         ENDWITH
1376: 
1377:         *-- TextBox getCtotal (custofs: Top=375, Left=626, W=127, H=21 - READ ONLY)
1378:         loc_oPg.AddObject("txt_4c_Ctotal", "TextBox")
1379:         WITH loc_oPg.txt_4c_Ctotal
1380:             .Value     = 0.0
1381:             .Top       = 375
1382:             .Left      = 626
1383:             .Width     = 127
1384:             .Height    = 21
1385:             .FontName  = "Tahoma"
1386:             .FontSize  = 8
1387:             .ReadOnly  = .T.
1388:             .BackColor = RGB(224, 235, 235)
1389:             .Themes    = .F.
1390:             .Visible   = .T.
1391:         ENDWITH
1392: 
1393:         *-- TextBox getMctotal (moecs: Top=375, Left=754, W=31, H=21)
1394:         loc_oPg.AddObject("txt_4c_Mctotal", "TextBox")
1395:         WITH loc_oPg.txt_4c_Mctotal
1396:             .Value    = ""
1397:             .Top      = 375
1398:             .Left     = 754
1399:             .Width    = 31
1400:             .Height   = 21
1401:             .FontName = "Tahoma"
1402:             .FontSize = 8
1403:             .Themes   = .F.
1404:             .Visible  = .T.
1405:         ENDWITH
1406:         BINDEVENT(loc_oPg.txt_4c_Mctotal, "KeyPress", THIS, "TxtMctotalKeyPress")
1407:         BINDEVENT(loc_oPg.txt_4c_Mctotal, "DblClick", THIS, "AbrirLookupMctotal")
1408: 
1409:         *-- ===================================================================
1410:         *-- LINHA 12 (top=394): Get_Cuni + Get_Duni + Get_cunip + get_dunip
1411:         *-- ===================================================================
1412:         loc_oPg.AddObject("lbl_4c_LblCuni", "Label")
1413:         WITH loc_oPg.lbl_4c_LblCuni
1414:             .Caption   = "Unidade :"
1415:             .Top       = 398
1416:             .Left      = 55
1417:             .Width     = 57
1418:             .Height    = 15
1419:             .BackStyle = 0
1420:             .ForeColor = RGB(90, 90, 90)
1421:             .FontName  = "Tahoma"
1422:             .FontSize  = 8
1423:             .Visible   = .T.
1424:         ENDWITH
1425: 
1426:         *-- TextBox Get_Cuni (cunis: Top=394, Left=113, W=31, H=23)
1427:         loc_oPg.AddObject("txt_4c_Cuni", "TextBox")
1428:         WITH loc_oPg.txt_4c_Cuni
1429:             .Value    = ""
1430:             .Top      = 394
1431:             .Left     = 113
1432:             .Width    = 31
1433:             .Height   = 23
1434:             .FontName = "Tahoma"
1435:             .FontSize = 8
1436:             .Themes   = .F.
1437:             .Visible  = .T.
1438:         ENDWITH
1439:         BINDEVENT(loc_oPg.txt_4c_Cuni, "KeyPress", THIS, "TxtCuniKeyPress")
1440:         BINDEVENT(loc_oPg.txt_4c_Cuni, "DblClick", THIS, "AbrirLookupUni")
1441: 
1442:         *-- TextBox Get_Duni (desc unidade: Top=394, Left=145, W=150, H=23 - READ ONLY)
1443:         loc_oPg.AddObject("txt_4c_DuniDisplay", "TextBox")
1444:         WITH loc_oPg.txt_4c_DuniDisplay
1445:             .Value     = ""
1446:             .Top       = 394
1447:             .Left      = 145
1448:             .Width     = 150
1449:             .Height    = 23
1450:             .FontName  = "Tahoma"
1451:             .FontSize  = 8
1452:             .ReadOnly  = .T.
1453:             .BackColor = RGB(224, 235, 235)
1454:             .Themes    = .F.
1455:             .Visible   = .T.
1456:         ENDWITH
1457: 
1458:         loc_oPg.AddObject("lbl_4c_LblCunip", "Label")
1459:         WITH loc_oPg.lbl_4c_LblCunip
1460:             .Caption   = "Uni.Ped. :"
1461:             .Top       = 398
1462:             .Left      = 278
1463:             .Width     = 51
1464:             .Height    = 15
1465:             .BackStyle = 0
1466:             .ForeColor = RGB(90, 90, 90)
1467:             .FontName  = "Tahoma"
1468:             .FontSize  = 8
1469:             .Visible   = .T.
1470:         ENDWITH
1471: 
1472:         *-- TextBox Get_cunip (cunips: Top=394, Left=330, W=31, H=23)
1473:         loc_oPg.AddObject("txt_4c_Cunip", "TextBox")
1474:         WITH loc_oPg.txt_4c_Cunip
1475:             .Value    = ""
1476:             .Top      = 394
1477:             .Left     = 330
1478:             .Width    = 31
1479:             .Height   = 23
1480:             .FontName = "Tahoma"
1481:             .FontSize = 8
1482:             .Themes   = .F.
1483:             .Visible  = .T.
1484:         ENDWITH
1485:         BINDEVENT(loc_oPg.txt_4c_Cunip, "KeyPress", THIS, "TxtCunipKeyPress")
1486:         BINDEVENT(loc_oPg.txt_4c_Cunip, "DblClick", THIS, "AbrirLookupUniP")
1487: 
1488:         *-- TextBox get_dunip (desc uni.pedido: Top=394, Left=362, W=150, H=23 - READ ONLY)
1489:         loc_oPg.AddObject("txt_4c_DunipDisplay", "TextBox")
1490:         WITH loc_oPg.txt_4c_DunipDisplay
1491:             .Value     = ""
1492:             .Top       = 394
1493:             .Left      = 362
1494:             .Width     = 150
1495:             .Height    = 23
1496:             .FontName  = "Tahoma"
1497:             .FontSize  = 8
1498:             .ReadOnly  = .T.
1499:             .BackColor = RGB(224, 235, 235)
1500:             .Themes    = .F.
1501:             .Visible   = .T.
1502:         ENDWITH
1503: 
1504:         *-- RIGHT SIDE: P.Venda + Moeda Pvenda + Datas Inc/Alt (top=384/397)
1505:         loc_oPg.AddObject("lbl_4c_LblPvenda", "Label")
1506:         WITH loc_oPg.lbl_4c_LblPvenda
1507:             .Caption   = "P.Venda :"
1508:             .Top       = 384
1509:             .Left      = 572
1510:             .Width     = 53
1511:             .Height    = 15
1512:             .BackStyle = 0
1513:             .ForeColor = RGB(90, 90, 90)
1514:             .FontName  = "Tahoma"
1515:             .FontSize  = 8
1516:             .Visible   = .T.
1517:         ENDWITH
1518: 
1519:         *-- TextBox getPvenda (pvens: Top=397, Left=626, W=127, H=21)
1520:         loc_oPg.AddObject("txt_4c_Pvenda", "TextBox")
1521:         WITH loc_oPg.txt_4c_Pvenda
1522:             .Value    = 0.0
1523:             .Top      = 397
1524:             .Left     = 626
1525:             .Width    = 127
1526:             .Height   = 21

*-- Linhas 1543 a 1587:
1543:             .Themes   = .F.
1544:             .Visible  = .T.
1545:         ENDWITH
1546:         BINDEVENT(loc_oPg.txt_4c_Mpvenda, "KeyPress", THIS, "TxtMpvendaKeyPress")
1547:         BINDEVENT(loc_oPg.txt_4c_Mpvenda, "DblClick", THIS, "AbrirLookupMpvenda")
1548: 
1549:         loc_oPg.AddObject("lbl_4c_LblInc", "Label")
1550:         WITH loc_oPg.lbl_4c_LblInc
1551:             .Caption   = "Inc."
1552:             .Top       = 384
1553:             .Left      = 793
1554:             .Width     = 39
1555:             .Height    = 15
1556:             .BackStyle = 0
1557:             .ForeColor = RGB(90, 90, 90)
1558:             .FontName  = "Tahoma"
1559:             .FontSize  = 8
1560:             .Visible   = .T.
1561:         ENDWITH
1562: 
1563:         *-- TextBox getDtIncs (dtincs: Top=397, Left=833, W=79, H=21 - READ ONLY)
1564:         loc_oPg.AddObject("txt_4c_DtIncs", "TextBox")
1565:         WITH loc_oPg.txt_4c_DtIncs
1566:             .Value     = {}
1567:             .Top       = 397
1568:             .Left      = 833
1569:             .Width     = 79
1570:             .Height    = 21
1571:             .FontName  = "Tahoma"
1572:             .FontSize  = 8
1573:             .Format    = "D"
1574:             .ReadOnly  = .T.
1575:             .BackColor = RGB(224, 235, 235)
1576:             .Themes    = .F.
1577:             .Visible   = .T.
1578:         ENDWITH
1579: 
1580:         loc_oPg.AddObject("lbl_4c_LblAlt", "Label")
1581:         WITH loc_oPg.lbl_4c_LblAlt
1582:             .Caption   = "Alt."
1583:             .Top       = 384
1584:             .Left      = 876
1585:             .Width     = 36
1586:             .Height    = 15
1587:             .BackStyle = 0

*-- Linhas 1681 a 1725:
1681:             .Themes   = .F.
1682:             .Visible  = .T.
1683:         ENDWITH
1684:         BINDEVENT(loc_oPg.txt_4c_Mfvenda, "KeyPress", THIS, "TxtMfvendaKeyPress")
1685:         BINDEVENT(loc_oPg.txt_4c_Mfvenda, "DblClick", THIS, "AbrirLookupMfvenda")
1686: 
1687:         *-- TextBox Get_Usuario (usuincs: Top=419, Left=833, W=79, H=21 - READ ONLY)
1688:         loc_oPg.AddObject("txt_4c_UsuIncs", "TextBox")
1689:         WITH loc_oPg.txt_4c_UsuIncs
1690:             .Value     = ""
1691:             .Top       = 419
1692:             .Left      = 833
1693:             .Width     = 79
1694:             .Height    = 21
1695:             .FontName  = "Tahoma"
1696:             .FontSize  = 8
1697:             .ReadOnly  = .T.
1698:             .BackColor = RGB(224, 235, 235)
1699:             .Themes    = .F.
1700:             .Visible   = .T.
1701:         ENDWITH
1702: 
1703:         *-- TextBox getUsuaAlts (usuaalts: Top=419, Left=914, W=79, H=21 - READ ONLY)
1704:         loc_oPg.AddObject("txt_4c_UsuaAlts", "TextBox")
1705:         WITH loc_oPg.txt_4c_UsuaAlts
1706:             .Value     = ""
1707:             .Top       = 419
1708:             .Left      = 914
1709:             .Width     = 79
1710:             .Height    = 21
1711:             .FontName  = "Tahoma"
1712:             .FontSize  = 8
1713:             .ReadOnly  = .T.
1714:             .BackColor = RGB(224, 235, 235)
1715:             .Themes    = .F.
1716:             .Visible   = .T.
1717:         ENDWITH
1718: 
1719:         *-- ===================================================================
1720:         *-- LINHA 14 (top=448): getdsccompras + checkboxes FabrProprs/Consig/Encoms
1721:         *-- ===================================================================
1722:         loc_oPg.AddObject("lbl_4c_LblDscComp", "Label")
1723:         WITH loc_oPg.lbl_4c_LblDscComp
1724:             .Caption   = "Descr.Compras :"
1725:             .Top       = 435

*-- Linhas 1852 a 1922:
1852:         ENDWITH
1853: 
1854:         *-- ===================================================================
1855:         *-- DBLCLICK BINDEVENTS para campos com lookup (Fase 5 + Fase 6)
1856:         *-- ===================================================================
1857:         BINDEVENT(loc_oPg.txt_4c_Cpros, "DblClick", THIS, "AbrirLookupProduto")
1858:         BINDEVENT(loc_oPg.txt_4c_Cgrus, "DblClick", THIS, "AbrirLookupGrupo")
1859:         BINDEVENT(loc_oPg.txt_4c_Lin,   "DblClick", THIS, "AbrirLookupLin")
1860:         BINDEVENT(loc_oPg.txt_4c_Col,   "DblClick", THIS, "AbrirLookupCol")
1861:         BINDEVENT(loc_oPg.txt_4c_Ifor,  "DblClick", THIS, "AbrirLookupIfor")
1862:     ENDPROC
1863: 
1864:     *--------------------------------------------------------------------------
1865:     * ConfigurarPgpgComposicao - Aba "Composicao" (Page2 de pgf_4c_Dados)
1866:     * Contem: grd_4c_Compo (14 cols), grd_4c_SubCp (15 cols), grd_4c_TotGrupo (3 cols)
1867:     *         cntMtPrima + ~30 textboxes + labels + checkboxes + commandgroups
1868:     * Posicoes = valores ORIGINAIS do layout.json (Tabs=.F. -> sem deslocamento)
1869:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1870:     *--------------------------------------------------------------------------
1871:     PROTECTED PROCEDURE ConfigurarPgpgComposicao(par_oPage)
1872:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2, loc_oGrd3, loc_oCnt
1873: 
1874:         loc_oPg = par_oPage
1875: 
1876:         *-- ===================================================================
1877:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
1878:         *-- ===================================================================
1879: 
1880:         *-- cursor_4c_Compo - composicao do produto (SIGPRCPO)
1881:         IF USED("cursor_4c_Compo")
1882:             USE IN cursor_4c_Compo
1883:         ENDIF
1884:         SET NULL OFF
1885:         CREATE CURSOR cursor_4c_Compo ( ;
1886:             mats      C(14), dcompos C(40), unicompos C(3),  ;
1887:             pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
1888:             moeds     C(3),  obscompos C(10), etiqs C(1),    ;
1889:             qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
1890:             ordems    N(2,0), tipos C(20))
1891: 
1892:         *-- cursor_4c_SubCp - sub-composicao (sigsubcp)
1893:         IF USED("cursor_4c_SubCp")
1894:             USE IN cursor_4c_SubCp
1895:         ENDIF
1896:         CREATE CURSOR cursor_4c_SubCp ( ;
1897:             mats      C(14), dcompos C(40), unicompos C(3),  ;
1898:             pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
1899:             moeds     C(3),  obscompos C(10), etiqs C(1),    ;
1900:             qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
1901:             ordems    N(2,0), matsubs C(14), codtams C(4))
1902: 
1903:         *-- cursor_4c_TotGrupo - totais por grupo (calculado)
1904:         IF USED("cursor_4c_TotGrupo")
1905:             USE IN cursor_4c_TotGrupo
1906:         ENDIF
1907:         CREATE CURSOR cursor_4c_TotGrupo ( ;
1908:             Grupo     C(3), ValGrupo N(11,3), Moeda C(3))
1909: 
1910:         *-- ===================================================================
1911:         *-- GRID grd_4c_Compo - Composicao principal (grdCompo: top=148, left=6, w=943, h=147)
1912:         *-- 14 colunas de SIGPRCPO
1913:         *-- ===================================================================
1914:         loc_oPg.AddObject("grd_4c_Compo", "Grid")
1915:         loc_oGrd = loc_oPg.grd_4c_Compo
1916:         WITH loc_oGrd
1917:             .Top         = 148
1918:             .Left        = 6
1919:             .Width       = 943
1920:             .Height      = 147
1921:             .FontName    = "Tahoma"
1922:             .FontSize    = 8

*-- Linhas 2009 a 2045:
2009:         WITH loc_oGrd.Column14
2010:             .Width = 108
2011:         ENDWITH
2012: 
2013:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
2014:         loc_oGrd.RecordSource = "cursor_4c_Compo"
2015: 
2016:         *-- ControlSource APOS RecordSource (obrigatorio)
2017:         loc_oGrd.Column1.ControlSource  = "cursor_4c_Compo.mats"
2018:         loc_oGrd.Column2.ControlSource  = "cursor_4c_Compo.dcompos"
2019:         loc_oGrd.Column3.ControlSource  = "cursor_4c_Compo.unicompos"
2020:         loc_oGrd.Column4.ControlSource  = "cursor_4c_Compo.pcompos"
2021:         loc_oGrd.Column5.ControlSource  = "cursor_4c_Compo.qtds"
2022:         loc_oGrd.Column6.ControlSource  = "cursor_4c_Compo.totas"
2023:         loc_oGrd.Column7.ControlSource  = "cursor_4c_Compo.moeds"
2024:         loc_oGrd.Column8.ControlSource  = "cursor_4c_Compo.obscompos"
2025:         loc_oGrd.Column9.ControlSource  = "cursor_4c_Compo.etiqs"
2026:         loc_oGrd.Column10.ControlSource = "cursor_4c_Compo.qtscons"
2027:         loc_oGrd.Column11.ControlSource = "cursor_4c_Compo.qtdcvs"
2028:         loc_oGrd.Column12.ControlSource = "cursor_4c_Compo.cunips"
2029:         loc_oGrd.Column13.ControlSource = "cursor_4c_Compo.ordems"
2030:         loc_oGrd.Column14.ControlSource = "cursor_4c_Compo.tipos"
2031: 
2032:         *-- Cabecalhos APOS RecordSource
2033:         loc_oGrd.Column1.Header1.Caption  = "Material"
2034:         loc_oGrd.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
2035:         loc_oGrd.Column3.Header1.Caption  = "Un"
2036:         loc_oGrd.Column4.Header1.Caption  = "Valor"
2037:         loc_oGrd.Column5.Header1.Caption  = "Qtde."
2038:         loc_oGrd.Column6.Header1.Caption  = "Total"
2039:         loc_oGrd.Column7.Header1.Caption  = "Moe"
2040:         loc_oGrd.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
2041:         loc_oGrd.Column9.Header1.Caption  = "E"
2042:         loc_oGrd.Column10.Header1.Caption = "Consumo"
2043:         loc_oGrd.Column11.Header1.Caption = "Qtde."
2044:         loc_oGrd.Column12.Header1.Caption = "Un"
2045:         loc_oGrd.Column13.Header1.Caption = "Ord"

*-- Linhas 2061 a 2105:
2061:         loc_oGrd.Column13.Width = 24
2062:         loc_oGrd.Column14.Width = 108
2063: 
2064:         *-- BINDEVENT grd_4c_Compo
2065:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")
2066: 
2067:         *-- ===================================================================
2068:         *-- GRID grd_4c_SubCp - Sub-composicao (grdsubcp: top=348, left=6, w=943, h=83)
2069:         *-- 15 colunas de sigsubcp
2070:         *-- ===================================================================
2071:         loc_oPg.AddObject("grd_4c_SubCp", "Grid")
2072:         loc_oGrd2 = loc_oPg.grd_4c_SubCp
2073:         WITH loc_oGrd2
2074:             .Top         = 348
2075:             .Left        = 6
2076:             .Width       = 943
2077:             .Height      = 83
2078:             .FontName    = "Tahoma"
2079:             .FontSize    = 8
2080:             .RecordMark  = .F.
2081:             .DeleteMark  = .F.
2082:             .GridLines   = 3
2083:             .ReadOnly    = .F.
2084:             .RowHeight   = 16
2085:             .ScrollBars  = 2
2086:             .Themes      = .F.
2087:             .ColumnCount = 15
2088:             .Visible     = .T.
2089:         ENDWITH
2090: 
2091:         *-- Colunas grd_4c_SubCp
2092:         WITH loc_oGrd2.Column1
2093:             .Width = 108
2094:             .Movable = .F.
2095:             .Resizable = .F.
2096:         ENDWITH
2097:         WITH loc_oGrd2.Column2
2098:             .Width = 149
2099:             .Movable = .F.
2100:             .Resizable = .F.
2101:         ENDWITH
2102:         WITH loc_oGrd2.Column3
2103:             .Width = 24
2104:             .Movable = .F.
2105:             .Resizable = .F.

*-- Linhas 2157 a 2194:
2157:         WITH loc_oGrd2.Column15
2158:             .Width = 38
2159:         ENDWITH
2160: 
2161:         *-- RecordSource APOS ColumnCount
2162:         loc_oGrd2.RecordSource = "cursor_4c_SubCp"
2163: 
2164:         *-- ControlSource APOS RecordSource
2165:         loc_oGrd2.Column1.ControlSource  = "cursor_4c_SubCp.mats"
2166:         loc_oGrd2.Column2.ControlSource  = "cursor_4c_SubCp.dcompos"
2167:         loc_oGrd2.Column3.ControlSource  = "cursor_4c_SubCp.unicompos"
2168:         loc_oGrd2.Column4.ControlSource  = "cursor_4c_SubCp.pcompos"
2169:         loc_oGrd2.Column5.ControlSource  = "cursor_4c_SubCp.qtds"
2170:         loc_oGrd2.Column6.ControlSource  = "cursor_4c_SubCp.totas"
2171:         loc_oGrd2.Column7.ControlSource  = "cursor_4c_SubCp.moeds"
2172:         loc_oGrd2.Column8.ControlSource  = "cursor_4c_SubCp.obscompos"
2173:         loc_oGrd2.Column9.ControlSource  = "cursor_4c_SubCp.etiqs"
2174:         loc_oGrd2.Column10.ControlSource = "cursor_4c_SubCp.qtscons"
2175:         loc_oGrd2.Column11.ControlSource = "cursor_4c_SubCp.qtdcvs"
2176:         loc_oGrd2.Column12.ControlSource = "cursor_4c_SubCp.cunips"
2177:         loc_oGrd2.Column13.ControlSource = "cursor_4c_SubCp.ordems"
2178:         loc_oGrd2.Column14.ControlSource = "cursor_4c_SubCp.matsubs"
2179:         loc_oGrd2.Column15.ControlSource = "cursor_4c_SubCp.codtams"
2180: 
2181:         *-- Cabecalhos grd_4c_SubCp APOS RecordSource
2182:         loc_oGrd2.Column1.Header1.Caption  = "Material"
2183:         loc_oGrd2.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
2184:         loc_oGrd2.Column3.Header1.Caption  = "Un"
2185:         loc_oGrd2.Column4.Header1.Caption  = "Valor"
2186:         loc_oGrd2.Column5.Header1.Caption  = "Qtde."
2187:         loc_oGrd2.Column6.Header1.Caption  = "Total"
2188:         loc_oGrd2.Column7.Header1.Caption  = "Moe"
2189:         loc_oGrd2.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
2190:         loc_oGrd2.Column9.Header1.Caption  = "E"
2191:         loc_oGrd2.Column10.Header1.Caption = "Consumo"
2192:         loc_oGrd2.Column11.Header1.Caption = "Qtde."
2193:         loc_oGrd2.Column12.Header1.Caption = "Un"
2194:         loc_oGrd2.Column13.Header1.Caption = "Ord"

*-- Linhas 2212 a 2279:
2212:         loc_oGrd2.Column14.Width = 108
2213:         loc_oGrd2.Column15.Width = 38
2214: 
2215:         *-- BINDEVENT grd_4c_SubCp
2216:         BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdSubCpAfterRowColChange")
2217: 
2218:         *-- ===================================================================
2219:         *-- GRID grd_4c_TotGrupo - Totais por grupo (GradeGRUPO: top=34, left=582, w=229, h=107)
2220:         *-- 3 colunas, ReadOnly
2221:         *-- ===================================================================
2222:         loc_oPg.AddObject("grd_4c_TotGrupo", "Grid")
2223:         loc_oGrd3 = loc_oPg.grd_4c_TotGrupo
2224:         WITH loc_oGrd3
2225:             .Top         = 34
2226:             .Left        = 582
2227:             .Width       = 229
2228:             .Height      = 107
2229:             .FontName    = "Courier New"
2230:             .FontSize    = 8
2231:             .RecordMark  = .F.
2232:             .DeleteMark  = .F.
2233:             .GridLines   = 3
2234:             .ReadOnly    = .T.
2235:             .RowHeight   = 17
2236:             .Themes      = .F.
2237:             .ColumnCount = 3
2238:             .Visible     = .T.
2239:         ENDWITH
2240: 
2241:         WITH loc_oGrd3.Column1
2242:             .Width     = 35
2243:             .Movable   = .F.
2244:             .Resizable = .F.
2245:             .ReadOnly  = .T.
2246:         ENDWITH
2247:         WITH loc_oGrd3.Column2
2248:             .Width     = 134
2249:             .Movable   = .F.
2250:             .Resizable = .F.
2251:             .ReadOnly  = .T.
2252:             .InputMask = "999,999,999.999"
2253:         ENDWITH
2254:         WITH loc_oGrd3.Column3
2255:             .Width     = 37
2256:             .Movable   = .F.
2257:             .Resizable = .F.
2258:             .ReadOnly  = .T.
2259:         ENDWITH
2260: 
2261:         loc_oGrd3.RecordSource = "cursor_4c_TotGrupo"
2262:         loc_oGrd3.Column1.ControlSource = "cursor_4c_TotGrupo.Grupo"
2263:         loc_oGrd3.Column2.ControlSource = "cursor_4c_TotGrupo.ValGrupo"
2264:         loc_oGrd3.Column3.ControlSource = "cursor_4c_TotGrupo.Moeda"
2265:         loc_oGrd3.Column1.Header1.Caption = "Grupo"
2266:         loc_oGrd3.Column2.Header1.Caption = "Total "
2267:         loc_oGrd3.Column3.Header1.Caption = "Moeda"
2268:         loc_oGrd3.Column1.Width = 35
2269:         loc_oGrd3.Column2.Width = 134
2270:         loc_oGrd3.Column3.Width = 37
2271: 
2272:         *-- ===================================================================
2273:         *-- CONTAINER cntMtPrima (top=511, left=752, w=242, h=108)
2274:         *-- Controles de montagem de descricao automatica
2275:         *-- ===================================================================
2276:         loc_oPg.AddObject("cnt_4c_MtPrima", "Container")
2277:         loc_oCnt = loc_oPg.cnt_4c_MtPrima
2278:         WITH loc_oCnt
2279:             .Top         = 511

*-- Linhas 2674 a 2732:
2674:             .Themes   = .F.
2675:             .Visible  = .T.
2676:         ENDWITH
2677:         BINDEVENT(loc_oPg.chk_4c_LiberaCusto, "Click", THIS, "ChkLiberaCustoClick")
2678: 
2679:         *-- chkLiberaVenda: liberar venda (top=459, left=323, w=39, h=38)
2680:         loc_oPg.AddObject("chk_4c_LiberaVenda", "CheckBox")
2681:         WITH loc_oPg.chk_4c_LiberaVenda
2682:             .Caption  = ""
2683:             .Top      = 459
2684:             .Left     = 323
2685:             .Width    = 39
2686:             .Height   = 38
2687:             .FontName = "Tahoma"
2688:             .FontSize = 8
2689:             .Themes   = .F.
2690:             .Visible  = .T.
2691:         ENDWITH
2692:         BINDEVENT(loc_oPg.chk_4c_LiberaVenda, "Click", THIS, "ChkLiberaVendaClick")
2693: 
2694:         *-- chkPlanCus: planejamento custo (top=556, left=36, w=25, h=25)
2695:         loc_oPg.AddObject("chk_4c_PlanCus", "CheckBox")
2696:         WITH loc_oPg.chk_4c_PlanCus
2697:             .Caption  = ""
2698:             .Top      = 556
2699:             .Left     = 36
2700:             .Width    = 25
2701:             .Height   = 25
2702:             .FontName = "Tahoma"
2703:             .FontSize = 8
2704:             .Themes   = .F.
2705:             .Visible  = .T.
2706:         ENDWITH
2707: 
2708:         *-- chkPlanVen: planejamento venda (top=556, left=387, w=25, h=25)
2709:         loc_oPg.AddObject("chk_4c_PlanVen", "CheckBox")
2710:         WITH loc_oPg.chk_4c_PlanVen
2711:             .Caption  = ""
2712:             .Top      = 556
2713:             .Left     = 387
2714:             .Width    = 25
2715:             .Height   = 25
2716:             .FontName = "Tahoma"
2717:             .FontSize = 8
2718:             .Themes   = .F.
2719:             .Visible  = .T.
2720:         ENDWITH
2721: 
2722:         *-- Chk_Pvenda: usar preco de venda (top=595, left=387, w=25, h=25)
2723:         loc_oPg.AddObject("chk_4c_Pvenda", "CheckBox")
2724:         WITH loc_oPg.chk_4c_Pvenda
2725:             .Caption  = ""
2726:             .Top      = 595
2727:             .Left     = 387
2728:             .Width    = 25
2729:             .Height   = 25
2730:             .FontName = "Tahoma"
2731:             .FontSize = 8
2732:             .Themes   = .F.

*-- Linhas 2765 a 2870:
2765:             .Themes   = .F.
2766:             .Visible  = .T.
2767:         ENDWITH
2768:         BINDEVENT(loc_oPg.txt_4c_Moec, "KeyPress", THIS, "TxtMoecKeyPress")
2769: 
2770:         *-- getPcus: preco de custo moeda1 (top=517, left=9, w=115, h=23)
2771:         loc_oPg.AddObject("txt_4c_Pcus", "TextBox")
2772:         WITH loc_oPg.txt_4c_Pcus
2773:             .Value     = 0
2774:             .Top       = 517
2775:             .Left      = 9
2776:             .Width     = 115
2777:             .Height    = 23
2778:             .FontName  = "Tahoma"
2779:             .FontSize  = 8
2780:             .InputMask = "99999,999.99999"
2781:             .Themes    = .F.
2782:             .Visible   = .T.
2783:         ENDWITH
2784:         BINDEVENT(loc_oPg.txt_4c_Pcus, "LostFocus", THIS, "TxtPcusValid")
2785: 
2786:         *-- lblCuVda: "Fator de Custo (Moeda 2)" (top=502, left=161, w=126, h=15)
2787:         loc_oPg.AddObject("lbl_4c_LblCuVda", "Label")
2788:         WITH loc_oPg.lbl_4c_LblCuVda
2789:             .Caption   = "Fator de Custo (Moeda 2)"
2790:             .Top       = 502
2791:             .Left      = 161
2792:             .Width     = 126
2793:             .Height    = 15
2794:             .BackStyle = 0
2795:             .ForeColor = RGB(90, 90, 90)
2796:             .FontName  = "Tahoma"
2797:             .FontSize  = 8
2798:             .Visible   = .T.
2799:         ENDWITH
2800: 
2801:         *-- getMoepc: moeda preco custo moeda2 (top=517, left=279, w=31, h=23)
2802:         loc_oPg.AddObject("txt_4c_Moepc", "TextBox")
2803:         WITH loc_oPg.txt_4c_Moepc
2804:             .Value    = ""
2805:             .Top      = 517
2806:             .Left     = 279
2807:             .Width    = 31
2808:             .Height   = 23
2809:             .FontName = "Tahoma"
2810:             .FontSize = 8
2811:             .Themes   = .F.
2812:             .Visible  = .T.
2813:         ENDWITH
2814:         BINDEVENT(loc_oPg.txt_4c_Moepc, "KeyPress", THIS, "TxtMoepcKeyPress")
2815: 
2816:         *-- getFcusto: fator de custo moeda2 (top=517, left=161, w=115, h=23)
2817:         loc_oPg.AddObject("txt_4c_Fcusto", "TextBox")
2818:         WITH loc_oPg.txt_4c_Fcusto
2819:             .Value     = 0
2820:             .Top       = 517
2821:             .Left      = 161
2822:             .Width     = 115
2823:             .Height    = 23
2824:             .FontName  = "Tahoma"
2825:             .FontSize  = 8
2826:             .InputMask = "99999,999.99999"
2827:             .Themes    = .F.
2828:             .Visible   = .T.
2829:         ENDWITH
2830:         BINDEVENT(loc_oPg.txt_4c_Fcusto, "LostFocus", THIS, "TxtFcustoValid")
2831: 
2832:         *-- Say8: "Total " (top=542, left=161, w=29, h=15)
2833:         loc_oPg.AddObject("lbl_4c_Say8", "Label")
2834:         WITH loc_oPg.lbl_4c_Say8
2835:             .Caption   = "Total "
2836:             .Top       = 542
2837:             .Left      = 161
2838:             .Width     = 29
2839:             .Height    = 15
2840:             .BackStyle = 0
2841:             .ForeColor = RGB(90, 90, 90)
2842:             .FontName  = "Tahoma"
2843:             .FontSize  = 8
2844:             .Visible   = .T.
2845:         ENDWITH
2846: 
2847:         *-- getMoecusf: moeda custo fator (top=557, left=279, w=31, h=23)
2848:         loc_oPg.AddObject("txt_4c_Moecusf", "TextBox")
2849:         WITH loc_oPg.txt_4c_Moecusf
2850:             .Value    = ""
2851:             .Top      = 557
2852:             .Left     = 279
2853:             .Width    = 31
2854:             .Height   = 23
2855:             .FontName = "Tahoma"
2856:             .FontSize = 8
2857:             .ReadOnly = .T.
2858:             .BackColor = RGB(224, 235, 235)
2859:             .Themes   = .F.
2860:             .Visible  = .T.
2861:         ENDWITH
2862: 
2863:         *-- getCustof: custo total fatorado (top=557, left=161, w=115, h=23)
2864:         loc_oPg.AddObject("txt_4c_Custof", "TextBox")
2865:         WITH loc_oPg.txt_4c_Custof
2866:             .Value     = 0
2867:             .Top       = 557
2868:             .Left      = 161
2869:             .Width     = 115
2870:             .Height    = 23

*-- Linhas 2922 a 2996:
2922:             .BackColor     = RGB(255, 255, 255)
2923:             .Visible       = .T.
2924:         ENDWITH
2925:         BINDEVENT(loc_oPg.cmd_4c_PesoM, "Click", THIS, "CmdPesoMClick")
2926: 
2927:         *-- Say7: "Cotacao" (top=581, left=161, w=42, h=15)
2928:         loc_oPg.AddObject("lbl_4c_Say7", "Label")
2929:         WITH loc_oPg.lbl_4c_Say7
2930:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
2931:             .Top       = 581
2932:             .Left      = 161
2933:             .Width     = 42
2934:             .Height    = 15
2935:             .BackStyle = 0
2936:             .ForeColor = RGB(90, 90, 90)
2937:             .FontName  = "Tahoma"
2938:             .FontSize  = 8
2939:             .Visible   = .T.
2940:         ENDWITH
2941: 
2942:         *-- GetCotaCalcP: cotacao calculada (top=596, left=161, w=115, h=23)
2943:         loc_oPg.AddObject("txt_4c_CotaCalcP", "TextBox")
2944:         WITH loc_oPg.txt_4c_CotaCalcP
2945:             .Value     = 0
2946:             .Top       = 596
2947:             .Left      = 161
2948:             .Width     = 115
2949:             .Height    = 23
2950:             .FontName  = "Tahoma"
2951:             .FontSize  = 8
2952:             .InputMask = "99999.999999"
2953:             .Themes    = .F.
2954:             .Visible   = .T.
2955:         ENDWITH
2956:         BINDEVENT(loc_oPg.txt_4c_CotaCalcP, "LostFocus", THIS, "TxtCotaCalcPValid")
2957: 
2958:         *-- ===================================================================
2959:         *-- SECAO CUSTO - MKP e Fator (lado custo)
2960:         *-- ===================================================================
2961: 
2962:         *-- Say22: "MKP" (top=542, left=9, w=22, h=15)
2963:         loc_oPg.AddObject("lbl_4c_Say22", "Label")
2964:         WITH loc_oPg.lbl_4c_Say22
2965:             .Caption   = "MKP"
2966:             .Top       = 542
2967:             .Left      = 9
2968:             .Width     = 22
2969:             .Height    = 15
2970:             .BackStyle = 0
2971:             .ForeColor = RGB(90, 90, 90)
2972:             .FontName  = "Tahoma"
2973:             .FontSize  = 8
2974:             .Visible   = .T.
2975:         ENDWITH
2976: 
2977:         *-- Get_cmkpc: MKP custo (top=557, left=9, w=24, h=23)
2978:         loc_oPg.AddObject("txt_4c_Cftiocs", "TextBox")
2979:         WITH loc_oPg.txt_4c_Cftiocs
2980:             .Value    = ""
2981:             .Top      = 557
2982:             .Left     = 9
2983:             .Width    = 24
2984:             .Height   = 23
2985:             .FontName = "Tahoma"
2986:             .FontSize = 8
2987:             .ReadOnly = .T.
2988:             .BackColor = RGB(224, 235, 235)
2989:             .Themes   = .F.
2990:             .Visible  = .T.
2991:         ENDWITH
2992: 
2993:         *-- lblValAdics: "Valor Adicional" (top=542, left=64, w=71, h=15)
2994:         loc_oPg.AddObject("lbl_4c_LblValAdics", "Label")
2995:         WITH loc_oPg.lbl_4c_LblValAdics
2996:             .Caption   = "Valor Adicional"

*-- Linhas 3055 a 3114:
3055:             .Themes    = .F.
3056:             .Visible   = .T.
3057:         ENDWITH
3058:         BINDEVENT(loc_oPg.txt_4c_Margem, "LostFocus", THIS, "TxtMargemValid")
3059: 
3060:         *-- getMarkupA: markup aplicado (top=596, left=323, w=62, h=23)
3061:         loc_oPg.AddObject("txt_4c_MarkupA", "TextBox")
3062:         WITH loc_oPg.txt_4c_MarkupA
3063:             .Value     = 0
3064:             .Top       = 596
3065:             .Left      = 323
3066:             .Width     = 62
3067:             .Height    = 23
3068:             .FontName  = "Tahoma"
3069:             .FontSize  = 8
3070:             .InputMask = "9999.999"
3071:             .Themes    = .F.
3072:             .Visible   = .T.
3073:         ENDWITH
3074:         BINDEVENT(loc_oPg.txt_4c_MarkupA, "LostFocus", THIS, "TxtMarkupAValid")
3075: 
3076:         *-- lblMkpApl: "MKP Aplic." (top=581, left=324, w=51, h=15)
3077:         loc_oPg.AddObject("lbl_4c_LblMkpApl", "Label")
3078:         WITH loc_oPg.lbl_4c_LblMkpApl
3079:             .Caption   = "MKP Aplic."
3080:             .Top       = 581
3081:             .Left      = 324
3082:             .Width     = 51
3083:             .Height    = 15
3084:             .BackStyle = 0
3085:             .ForeColor = RGB(90, 90, 90)
3086:             .FontName  = "Tahoma"
3087:             .FontSize  = 8
3088:             .Visible   = .T.
3089:         ENDWITH
3090: 
3091:         *-- Say14: "MKP" (top=542, left=360, w=22, h=15) - FT/IO custo
3092:         loc_oPg.AddObject("lbl_4c_Say14", "Label")
3093:         WITH loc_oPg.lbl_4c_Say14
3094:             .Caption   = "MKP"
3095:             .Top       = 542
3096:             .Left      = 360
3097:             .Width     = 22
3098:             .Height    = 15
3099:             .BackStyle = 0
3100:             .ForeColor = RGB(90, 90, 90)
3101:             .FontName  = "Tahoma"
3102:             .FontSize  = 8
3103:             .Visible   = .T.
3104:         ENDWITH
3105: 
3106:         *-- Getftio: fator tipo IO custo (top=557, left=360, w=24, h=23)
3107:         loc_oPg.AddObject("txt_4c_Cftios", "TextBox")
3108:         WITH loc_oPg.txt_4c_Cftios
3109:             .Value    = ""
3110:             .Top      = 557
3111:             .Left     = 360
3112:             .Width    = 24
3113:             .Height   = 23
3114:             .FontName = "Tahoma"

*-- Linhas 3185 a 3228:
3185:             .Themes   = .F.
3186:             .Visible  = .T.
3187:         ENDWITH
3188:         BINDEVENT(loc_oPg.txt_4c_Moeda, "KeyPress", THIS, "TxtMoedaKeyPress")
3189: 
3190:         *-- getPvideal: preco de venda ideal (top=517, left=416, w=110, h=23)
3191:         loc_oPg.AddObject("txt_4c_Pvideal", "TextBox")
3192:         WITH loc_oPg.txt_4c_Pvideal
3193:             .Value     = 0
3194:             .Top       = 517
3195:             .Left      = 416
3196:             .Width     = 110
3197:             .Height    = 23
3198:             .FontName  = "Tahoma"
3199:             .FontSize  = 8
3200:             .InputMask = "99999,999.99999"
3201:             .Themes    = .F.
3202:             .Visible   = .T.
3203:         ENDWITH
3204: 
3205:         *-- lblFIdeals: "Fator Ideal" (top=503, left=563, w=55, h=15)
3206:         loc_oPg.AddObject("lbl_4c_LblFIdeals", "Label")
3207:         WITH loc_oPg.lbl_4c_LblFIdeals
3208:             .Caption   = "Fator Ideal"
3209:             .Top       = 503
3210:             .Left      = 563
3211:             .Width     = 55
3212:             .Height    = 15
3213:             .BackStyle = 0
3214:             .ForeColor = RGB(90, 90, 90)
3215:             .FontName  = "Tahoma"
3216:             .FontSize  = 8
3217:             .Visible   = .T.
3218:         ENDWITH
3219: 
3220:         *-- getFIdeals: fator ideal (top=517, left=563, w=110, h=23)
3221:         loc_oPg.AddObject("txt_4c_Fideals", "TextBox")
3222:         WITH loc_oPg.txt_4c_Fideals
3223:             .Value     = 0
3224:             .Top       = 517
3225:             .Left      = 563
3226:             .Width     = 110
3227:             .Height    = 23
3228:             .FontName  = "Tahoma"

*-- Linhas 3340 a 3383:
3340:             .Themes   = .F.
3341:             .Visible  = .T.
3342:         ENDWITH
3343:         BINDEVENT(loc_oPg.txt_4c_Moepv, "KeyPress", THIS, "TxtMoepvKeyPress")
3344: 
3345:         *-- getPven: preco de venda (top=596, left=416, w=110, h=23)
3346:         loc_oPg.AddObject("txt_4c_Pvens", "TextBox")
3347:         WITH loc_oPg.txt_4c_Pvens
3348:             .Value     = 0
3349:             .Top       = 596
3350:             .Left      = 416
3351:             .Width     = 110
3352:             .Height    = 23
3353:             .FontName  = "Tahoma"
3354:             .FontSize  = 8
3355:             .InputMask = "99999,999.99999"
3356:             .Themes    = .F.
3357:             .Visible   = .T.
3358:         ENDWITH
3359: 
3360:         *-- lblFAtuals: "Fator Atual" (top=581, left=563, w=56, h=15)
3361:         loc_oPg.AddObject("lbl_4c_LblFAtuals", "Label")
3362:         WITH loc_oPg.lbl_4c_LblFAtuals
3363:             .Caption   = "Fator Atual"
3364:             .Top       = 581
3365:             .Left      = 563
3366:             .Width     = 56
3367:             .Height    = 15
3368:             .BackStyle = 0
3369:             .ForeColor = RGB(90, 90, 90)
3370:             .FontName  = "Tahoma"
3371:             .FontSize  = 8
3372:             .Visible   = .T.
3373:         ENDWITH
3374: 
3375:         *-- getMoev: moeda venda atual (top=596, left=529, w=31, h=23)
3376:         loc_oPg.AddObject("txt_4c_Moevs", "TextBox")
3377:         WITH loc_oPg.txt_4c_Moevs
3378:             .Value    = ""
3379:             .Top      = 596
3380:             .Left     = 529
3381:             .Width    = 31
3382:             .Height   = 23
3383:             .FontName = "Tahoma"

*-- Linhas 3456 a 3499:
3456:             .BackColor     = RGB(255, 255, 255)
3457:             .Visible       = .T.
3458:         ENDWITH
3459:         BINDEVENT(loc_oPg.cmd_4c_CalcVals, "Click", THIS, "CmdCalcValsClick")
3460: 
3461:         *-- ===================================================================
3462:         *-- COMMANDGROUP cmdgCompo - 5 botoes (top=145, left=947, w=50, h=210)
3463:         *-- ===================================================================
3464:         loc_oPg.AddObject("obj_4c_CmdgCompo", "CommandGroup")
3465:         WITH loc_oPg.obj_4c_CmdgCompo
3466:             .ButtonCount   = 5
3467:             .BorderStyle   = 0
3468:             .Top           = 145
3469:             .Left          = 947
3470:             .Width         = 50
3471:             .Height        = 210
3472:             .BackColor     = RGB(162, 214, 242)
3473:             .Themes        = .F.
3474:             .Visible       = .T.
3475:         ENDWITH
3476:         WITH loc_oPg.obj_4c_CmdgCompo
3477:             .Buttons(1).Top          = 5
3478:             .Buttons(1).Left         = 5
3479:             .Buttons(1).Height       = 40
3480:             .Buttons(1).Width        = 40
3481:             .Buttons(1).Caption      = ""
3482:             .Buttons(1).Picture      = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
3483:             .Buttons(1).ToolTipText  = "Inserir Item"
3484:             .Buttons(1).SpecialEffect = 0
3485:             .Buttons(1).BackColor    = RGB(255, 255, 255)
3486:             .Buttons(1).ForeColor    = RGB(0, 0, 0)
3487:             .Buttons(1).Themes       = .F.
3488:             .Buttons(2).Top          = 45
3489:             .Buttons(2).Left         = 5
3490:             .Buttons(2).Height       = 40
3491:             .Buttons(2).Width        = 40
3492:             .Buttons(2).Caption      = ""
3493:             .Buttons(2).Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3494:             .Buttons(2).ToolTipText  = "Excluir Item"
3495:             .Buttons(2).SpecialEffect = 0
3496:             .Buttons(2).BackColor    = RGB(255, 255, 255)
3497:             .Buttons(2).ForeColor    = RGB(0, 0, 0)
3498:             .Buttons(2).Themes       = .F.
3499:             .Buttons(3).Top          = 85

*-- Linhas 3526 a 3620:
3526:             .Buttons(5).BackColor    = RGB(255, 255, 255)
3527:             .Buttons(5).Themes       = .F.
3528:         ENDWITH
3529:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo, "Click", THIS, "CmdgCompoClick")
3530: 
3531:         *-- ===================================================================
3532:         *-- COMMANDGROUP cmdgSubCp - 2 botoes (top=345, left=947, w=50, h=90)
3533:         *-- ===================================================================
3534:         loc_oPg.AddObject("obj_4c_CmdgSubCp", "CommandGroup")
3535:         WITH loc_oPg.obj_4c_CmdgSubCp
3536:             .ButtonCount   = 2
3537:             .BorderStyle   = 0
3538:             .Top           = 345
3539:             .Left          = 947
3540:             .Width         = 50
3541:             .Height        = 90
3542:             .BackColor     = RGB(162, 214, 242)
3543:             .Themes        = .F.
3544:             .Visible       = .T.
3545:         ENDWITH
3546:         WITH loc_oPg.obj_4c_CmdgSubCp
3547:             .Buttons(1).Top          = 5
3548:             .Buttons(1).Left         = 5
3549:             .Buttons(1).Height       = 40
3550:             .Buttons(1).Width        = 40
3551:             .Buttons(1).Caption      = ""
3552:             .Buttons(1).Picture      = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
3553:             .Buttons(1).ToolTipText  = "Inserir Item"
3554:             .Buttons(1).SpecialEffect = 0
3555:             .Buttons(1).BackColor    = RGB(255, 255, 255)
3556:             .Buttons(1).ForeColor    = RGB(0, 0, 0)
3557:             .Buttons(1).Themes       = .F.
3558:             .Buttons(2).Top          = 45
3559:             .Buttons(2).Left         = 5
3560:             .Buttons(2).Height       = 40
3561:             .Buttons(2).Width        = 40
3562:             .Buttons(2).Caption      = ""
3563:             .Buttons(2).Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3564:             .Buttons(2).ToolTipText  = "Excluir Item"
3565:             .Buttons(2).SpecialEffect = 0
3566:             .Buttons(2).BackColor    = RGB(255, 255, 255)
3567:             .Buttons(2).ForeColor    = RGB(0, 0, 0)
3568:             .Buttons(2).Themes       = .F.
3569:         ENDWITH
3570:         BINDEVENT(loc_oPg.obj_4c_CmdgSubCp, "Click", THIS, "CmdgSubCpClick")
3571: 
3572:     ENDPROC
3573: 
3574:     *--------------------------------------------------------------------------
3575:     * ConfigurarPgpgDadosFiscais - Aba "Dados Fiscais" do PageFrame interno (pgDadosFiscais)
3576:     * Fase 13: Sub-pagina Dados Fiscais - 54 controles do original
3577:     * Posicoes: valores do layout.json (pgf_4c_Dados.Tabs=.F. -> sem +29)
3578:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
3579:     *--------------------------------------------------------------------------
3580:     PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais(par_oPage)
3581:         LOCAL loc_oPg, loc_oGrd
3582:         loc_oPg = par_oPage
3583: 
3584:         *-- ===================================================================
3585:         *-- CURSOR PLACEHOLDER (criar ANTES do grid)
3586:         *-- ===================================================================
3587: 
3588:         *-- cursor_4c_Cmv - historico valor do grama produzido (grdCmv)
3589:         IF USED("cursor_4c_Cmv")
3590:             USE IN cursor_4c_Cmv
3591:         ENDIF
3592:         SET NULL OFF
3593:         CREATE CURSOR cursor_4c_Cmv ( ;
3594:             datas    C(7), ;
3595:             valcuss  N(10,2), ;
3596:             moedas   C(3))
3597: 
3598:         *-- ===================================================================
3599:         *-- LABELS
3600:         *-- ===================================================================
3601: 
3602:         *-- Say16: Grupo C.C.
3603:         loc_oPg.AddObject("lbl_4c_Say16", "Label")
3604:         WITH loc_oPg.lbl_4c_Say16
3605:             .Caption  = "Grupo C.C. :"
3606:             .Top      = 165
3607:             .Left     = 138
3608:             .Width    = 63
3609:             .Height   = 15
3610:             .FontName = "Tahoma"
3611:             .FontSize = 8
3612:             .AutoSize = .F.
3613:             .Visible  = .T.
3614:         ENDWITH
3615: 
3616:         *-- Say17: Conta C.C.
3617:         loc_oPg.AddObject("lbl_4c_Say17", "Label")
3618:         WITH loc_oPg.lbl_4c_Say17
3619:             .Caption  = "Conta C.C. :"
3620:             .Top      = 189

*-- Linhas 3889 a 4190:
3889:             .InputMask = "!!!!!!!!!!"
3890:             .Visible   = .T.
3891:         ENDWITH
3892:         BINDEVENT(loc_oPg.txt_4c_Gruccus, "KeyPress", THIS, "TxtGruccusKeyPress")
3893:         BINDEVENT(loc_oPg.txt_4c_Gruccus, "DblClick", THIS, "AbrirLookupGruccus")
3894: 
3895:         *-- get_dgruccus (txt_4c_Dgruccus): Grupo C.C. descricao - T:161, L:288, W:318, H:23
3896:         loc_oPg.AddObject("txt_4c_Dgruccus", "TextBox")
3897:         WITH loc_oPg.txt_4c_Dgruccus
3898:             .Value    = ""
3899:             .Top      = 161
3900:             .Left     = 288
3901:             .Width    = 318
3902:             .Height   = 23
3903:             .FontName = "Tahoma"
3904:             .FontSize = 8
3905:             .Visible  = .T.
3906:         ENDWITH
3907:         BINDEVENT(loc_oPg.txt_4c_Dgruccus, "KeyPress", THIS, "TxtDgruccusKeyPress")
3908:         BINDEVENT(loc_oPg.txt_4c_Dgruccus, "DblClick", THIS, "AbrirLookupDgruccus")
3909: 
3910:         *-- get_contaccus (txt_4c_Contaccus): Conta C.C. codigo - T:186, L:206, W:80, H:23
3911:         loc_oPg.AddObject("txt_4c_Contaccus", "TextBox")
3912:         WITH loc_oPg.txt_4c_Contaccus
3913:             .Value     = ""
3914:             .Top       = 186
3915:             .Left      = 206
3916:             .Width     = 80
3917:             .Height    = 23
3918:             .FontName  = "Tahoma"
3919:             .FontSize  = 8
3920:             .InputMask = "!!!!!!!!!!"
3921:             .Visible   = .T.
3922:         ENDWITH
3923:         BINDEVENT(loc_oPg.txt_4c_Contaccus, "KeyPress", THIS, "TxtContaccusKeyPress")
3924:         BINDEVENT(loc_oPg.txt_4c_Contaccus, "DblClick", THIS, "AbrirLookupContaccus")
3925: 
3926:         *-- get_dcontaccus (txt_4c_Dcontaccus): Conta C.C. descricao - T:186, L:288, W:318, H:23
3927:         loc_oPg.AddObject("txt_4c_Dcontaccus", "TextBox")
3928:         WITH loc_oPg.txt_4c_Dcontaccus
3929:             .Value    = ""
3930:             .Top      = 186
3931:             .Left     = 288
3932:             .Width    = 318
3933:             .Height   = 23
3934:             .FontName = "Tahoma"
3935:             .FontSize = 8
3936:             .Visible  = .T.
3937:         ENDWITH
3938:         BINDEVENT(loc_oPg.txt_4c_Dcontaccus, "KeyPress", THIS, "TxtDcontaccusKeyPress")
3939:         BINDEVENT(loc_oPg.txt_4c_Dcontaccus, "DblClick", THIS, "AbrirLookupDcontaccus")
3940: 
3941:         *-- ===================================================================
3942:         *-- TEXTBOXES - Classificacao Fiscal (NCM)
3943:         *-- ===================================================================
3944: 
3945:         *-- getClfiscal (txt_4c_Clfiscal): NCM codigo - T:211, L:206, W:94, H:23
3946:         loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
3947:         WITH loc_oPg.txt_4c_Clfiscal
3948:             .Value     = ""
3949:             .Top       = 211
3950:             .Left      = 206
3951:             .Width     = 94
3952:             .Height    = 23
3953:             .FontName  = "Tahoma"
3954:             .FontSize  = 8
3955:             .InputMask = "9999.99.99"
3956:             .Visible   = .T.
3957:         ENDWITH
3958:         BINDEVENT(loc_oPg.txt_4c_Clfiscal, "KeyPress", THIS, "TxtClfiscalKeyPress")
3959:         BINDEVENT(loc_oPg.txt_4c_Clfiscal, "DblClick", THIS, "AbrirLookupClfiscal")
3960: 
3961:         *-- getDclfiscal (txt_4c_Dclfiscal): NCM descricao - T:211, L:303, W:303, H:23
3962:         loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
3963:         WITH loc_oPg.txt_4c_Dclfiscal
3964:             .Value    = ""
3965:             .Top      = 211
3966:             .Left     = 303
3967:             .Width    = 303
3968:             .Height   = 23
3969:             .FontName = "Tahoma"
3970:             .FontSize = 8
3971:             .Visible  = .T.
3972:         ENDWITH
3973:         BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "KeyPress", THIS, "TxtDclfiscalKeyPress")
3974:         BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "DblClick", THIS, "AbrirLookupDclfiscal")
3975: 
3976:         *-- ===================================================================
3977:         *-- TEXTBOXES - Origem da Mercadoria
3978:         *-- ===================================================================
3979: 
3980:         *-- getOrigmerc (txt_4c_Origmerc): Origem codigo - T:236, L:206, W:17, H:23
3981:         loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
3982:         WITH loc_oPg.txt_4c_Origmerc
3983:             .Value     = ""
3984:             .Top       = 236
3985:             .Left      = 206
3986:             .Width     = 17
3987:             .Height    = 23
3988:             .FontName  = "Tahoma"
3989:             .FontSize  = 8
3990:             .MaxLength = 1
3991:             .Visible   = .T.
3992:         ENDWITH
3993:         BINDEVENT(loc_oPg.txt_4c_Origmerc, "KeyPress", THIS, "TxtOrigmercKeyPress")
3994:         BINDEVENT(loc_oPg.txt_4c_Origmerc, "DblClick", THIS, "AbrirLookupOrigmerc")
3995: 
3996:         *-- getDorigmerc (txt_4c_Dorigmerc): Origem descricao - T:236, L:226, W:380, H:23
3997:         loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")
3998:         WITH loc_oPg.txt_4c_Dorigmerc
3999:             .Value    = ""
4000:             .Top      = 236
4001:             .Left     = 226
4002:             .Width    = 380
4003:             .Height   = 23
4004:             .FontName = "Tahoma"
4005:             .FontSize = 8
4006:             .Visible  = .T.
4007:         ENDWITH
4008:         BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "KeyPress", THIS, "TxtDorigmercKeyPress")
4009:         BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "DblClick", THIS, "AbrirLookupDorigmerc")
4010: 
4011:         *-- ===================================================================
4012:         *-- TEXTBOXES - Situacao Tributaria ICMS
4013:         *-- ===================================================================
4014: 
4015:         *-- getSittricm (txt_4c_Sittricm): ICMS codigo - T:261, L:206, W:31, H:23
4016:         loc_oPg.AddObject("txt_4c_Sittricm", "TextBox")
4017:         WITH loc_oPg.txt_4c_Sittricm
4018:             .Value     = ""
4019:             .Top       = 261
4020:             .Left      = 206
4021:             .Width     = 31
4022:             .Height    = 23
4023:             .FontName  = "Tahoma"
4024:             .FontSize  = 8
4025:             .InputMask = "!!!"
4026:             .Visible   = .T.
4027:         ENDWITH
4028:         BINDEVENT(loc_oPg.txt_4c_Sittricm, "KeyPress", THIS, "TxtSittricmKeyPress")
4029:         BINDEVENT(loc_oPg.txt_4c_Sittricm, "DblClick", THIS, "AbrirLookupSittricm")
4030: 
4031:         *-- getDsittricm (txt_4c_Dsittricm): ICMS descricao - T:261, L:240, W:366, H:23
4032:         loc_oPg.AddObject("txt_4c_Dsittricm", "TextBox")
4033:         WITH loc_oPg.txt_4c_Dsittricm
4034:             .Value    = ""
4035:             .Top      = 261
4036:             .Left     = 240
4037:             .Width    = 366
4038:             .Height   = 23
4039:             .FontName = "Tahoma"
4040:             .FontSize = 8
4041:             .Visible  = .T.
4042:         ENDWITH
4043:         BINDEVENT(loc_oPg.txt_4c_Dsittricm, "KeyPress", THIS, "TxtDsittricmKeyPress")
4044:         BINDEVENT(loc_oPg.txt_4c_Dsittricm, "DblClick", THIS, "AbrirLookupDsittricm")
4045: 
4046:         *-- ===================================================================
4047:         *-- TEXTBOXES - Linha de Servicos ICMS, Aliquotas, Tipo, IAT
4048:         *-- ===================================================================
4049: 
4050:         *-- Get_CodServs (txt_4c_CodServs): Codigo de Servicos - T:286, L:206, W:38, H:23
4051:         loc_oPg.AddObject("txt_4c_CodServs", "TextBox")
4052:         WITH loc_oPg.txt_4c_CodServs
4053:             .Value     = ""
4054:             .Top       = 286
4055:             .Left      = 206
4056:             .Width     = 38
4057:             .Height    = 23
4058:             .FontName  = "Tahoma"
4059:             .FontSize  = 8
4060:             .InputMask = "!!!"
4061:             .Visible   = .T.
4062:         ENDWITH
4063:         BINDEVENT(loc_oPg.txt_4c_CodServs, "KeyPress", THIS, "TxtCodServsKeyPress")
4064:         BINDEVENT(loc_oPg.txt_4c_CodServs, "DblClick", THIS, "AbrirLookupCodServs")
4065: 
4066:         *-- getIcms (txt_4c_Icms): Aliquota ICMS - T:286, L:342, W:45, H:23
4067:         loc_oPg.AddObject("txt_4c_Icms", "TextBox")
4068:         WITH loc_oPg.txt_4c_Icms
4069:             .Value     = 0
4070:             .Top       = 286
4071:             .Left      = 342
4072:             .Width     = 45
4073:             .Height    = 23
4074:             .FontName  = "Tahoma"
4075:             .FontSize  = 8
4076:             .InputMask = "999.99"
4077:             .Visible   = .T.
4078:         ENDWITH
4079: 
4080:         *-- Get_TpTrib (txt_4c_TpTrib): Tipo de Tributacao - T:286, L:513, W:38, H:23
4081:         loc_oPg.AddObject("txt_4c_TpTrib", "TextBox")
4082:         WITH loc_oPg.txt_4c_TpTrib
4083:             .Value     = ""
4084:             .Top       = 286
4085:             .Left      = 513
4086:             .Width     = 38
4087:             .Height    = 23
4088:             .FontName  = "Tahoma"
4089:             .FontSize  = 8
4090:             .InputMask = "!!!!"
4091:             .Visible   = .T.
4092:         ENDWITH
4093:         BINDEVENT(loc_oPg.txt_4c_TpTrib, "KeyPress", THIS, "TxtTpTribKeyPress")
4094:         BINDEVENT(loc_oPg.txt_4c_TpTrib, "DblClick", THIS, "AbrirLookupTpTrib")
4095: 
4096:         *-- getiat (txt_4c_Iat): IAT Arredondamento/Truncamento - T:286, L:589, W:17, H:23
4097:         loc_oPg.AddObject("txt_4c_Iat", "TextBox")
4098:         WITH loc_oPg.txt_4c_Iat
4099:             .Value     = ""
4100:             .Top       = 286
4101:             .Left      = 589
4102:             .Width     = 17
4103:             .Height    = 23
4104:             .FontName  = "Tahoma"
4105:             .FontSize  = 8
4106:             .MaxLength = 1
4107:             .InputMask = "!"
4108:             .Visible   = .T.
4109:         ENDWITH
4110:         BINDEVENT(loc_oPg.txt_4c_Iat, "LostFocus", THIS, "ValidarIat")
4111: 
4112:         *-- ===================================================================
4113:         *-- COMBOBOX - Situacao Tributaria IPI
4114:         *-- ===================================================================
4115: 
4116:         *-- cmbIpi (cbo_4c_CmbIpi): Sit. Trib. IPI - T:311, L:206, W:108, H:25
4117:         loc_oPg.AddObject("cbo_4c_CmbIpi", "ComboBox")
4118:         WITH loc_oPg.cbo_4c_CmbIpi
4119:             .Top      = 311
4120:             .Left     = 206
4121:             .Width    = 108
4122:             .Height   = 25
4123:             .FontName = "Tahoma"
4124:             .FontSize = 8
4125:             .Style    = 2
4126:             .Visible  = .T.
4127:         ENDWITH
4128:         loc_oPg.cbo_4c_CmbIpi.AddItem("")
4129:         loc_oPg.cbo_4c_CmbIpi.AddItem("Tributado")
4130:         loc_oPg.cbo_4c_CmbIpi.AddItem("Isento")
4131:         loc_oPg.cbo_4c_CmbIpi.AddItem("Outros")
4132: 
4133:         *-- ===================================================================
4134:         *-- TEXTBOXES - Aliquota IPI e Excecao TIPI
4135:         *-- ===================================================================
4136: 
4137:         *-- Get_AliqIPI (txt_4c_AliqIPI): Aliquota de IPI - T:311, L:425, W:45, H:25
4138:         loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
4139:         WITH loc_oPg.txt_4c_AliqIPI
4140:             .Value     = 0
4141:             .Top       = 311
4142:             .Left      = 425
4143:             .Width     = 45
4144:             .Height    = 25
4145:             .FontName  = "Tahoma"
4146:             .FontSize  = 8
4147:             .InputMask = "999.99"
4148:             .Visible   = .T.
4149:         ENDWITH
4150:         BINDEVENT(loc_oPg.txt_4c_AliqIPI, "LostFocus", THIS, "ValidarAliqIPI")
4151: 
4152:         *-- getextipi (txt_4c_Extipi): Excecao da TIPI - T:311, L:601, W:35, H:25
4153:         loc_oPg.AddObject("txt_4c_Extipi", "TextBox")
4154:         WITH loc_oPg.txt_4c_Extipi
4155:             .Value     = ""
4156:             .Top       = 311
4157:             .Left      = 601
4158:             .Width     = 35
4159:             .Height    = 25
4160:             .FontName  = "Tahoma"
4161:             .FontSize  = 8
4162:             .InputMask = "!!!!!"
4163:             .Visible   = .T.
4164:         ENDWITH
4165: 
4166:         *-- ===================================================================
4167:         *-- EDITBOX - Descricao Fiscal (memo)
4168:         *-- ===================================================================
4169: 
4170:         *-- mgetdescfi (obj_4c_Mgetdescfi): T:338, L:206, W:509, H:89
4171:         loc_oPg.AddObject("obj_4c_Mgetdescfi", "EditBox")
4172:         WITH loc_oPg.obj_4c_Mgetdescfi
4173:             .Value      = ""
4174:             .Top        = 338
4175:             .Left       = 206
4176:             .Width      = 509
4177:             .Height     = 89
4178:             .FontName   = "Tahoma"
4179:             .FontSize   = 8
4180:             .ScrollBars = 2
4181:             .Visible    = .T.
4182:         ENDWITH
4183: 
4184:         *-- ===================================================================
4185:         *-- COMMANDBUTTON - Gerar Descricao Fiscal
4186:         *-- ===================================================================
4187: 
4188:         *-- btnDescFis (cmd_4c_BtnDescFis): T:359, L:162, W:26, H:26
4189:         loc_oPg.AddObject("cmd_4c_BtnDescFis", "CommandButton")
4190:         WITH loc_oPg.cmd_4c_BtnDescFis

*-- Linhas 4198 a 4271:
4198:             .Themes   = .F.
4199:             .Visible  = .T.
4200:         ENDWITH
4201:         BINDEVENT(loc_oPg.cmd_4c_BtnDescFis, "Click", THIS, "CmdBtnDescFisClick")
4202: 
4203:         *-- ===================================================================
4204:         *-- GRID - Historico Valor do Grama Produzido (grdCmv)
4205:         *-- T:338, L:754, W:223, H:141, 3 colunas: Periodo / Valor Custo GR / Moe
4206:         *-- ===================================================================
4207: 
4208:         loc_oPg.AddObject("grd_4c_Dados", "Grid")
4209:         loc_oGrd = loc_oPg.grd_4c_Dados
4210:         WITH loc_oGrd
4211:             .Top         = 338
4212:             .Left        = 754
4213:             .Width       = 223
4214:             .Height      = 141
4215:             .FontName    = "Tahoma"
4216:             .FontSize    = 8
4217:             .RecordMark  = .F.
4218:             .DeleteMark  = .F.
4219:             .GridLines   = 3
4220:             .ReadOnly    = .T.
4221:             .RowHeight   = 16
4222:             .ScrollBars  = 2
4223:             .Themes      = .F.
4224:             .ColumnCount = 3
4225:             .Visible     = .T.
4226:         ENDWITH
4227: 
4228:         *-- Cabecalhos ANTES do RecordSource
4229:         loc_oGrd.Column1.Header1.Caption = "Per" + CHR(237) + "odo"
4230:         loc_oGrd.Column2.Header1.Caption = "Valor Custo GR"
4231:         loc_oGrd.Column3.Header1.Caption = "Moe"
4232: 
4233:         *-- Larguras das colunas
4234:         WITH loc_oGrd.Column1
4235:             .Width     = 60
4236:             .Movable   = .F.
4237:             .Resizable = .F.
4238:         ENDWITH
4239:         WITH loc_oGrd.Column2
4240:             .Width     = 120
4241:             .Movable   = .F.
4242:             .Resizable = .F.
4243:         ENDWITH
4244:         WITH loc_oGrd.Column3
4245:             .Width     = 40
4246:             .Movable   = .F.
4247:             .Resizable = .F.
4248:         ENDWITH
4249: 
4250:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
4251:         loc_oGrd.RecordSource = "cursor_4c_Cmv"
4252: 
4253:         *-- ControlSource APOS RecordSource (obrigatorio)
4254:         loc_oGrd.Column1.ControlSource = "cursor_4c_Cmv.datas"
4255:         loc_oGrd.Column2.ControlSource = "cursor_4c_Cmv.valcuss"
4256:         loc_oGrd.Column3.ControlSource = "cursor_4c_Cmv.moedas"
4257: 
4258:         *-- Reaplica larguras apos RecordSource (RecordSource pode resetar)
4259:         loc_oGrd.Column1.Width = 60
4260:         loc_oGrd.Column2.Width = 120
4261:         loc_oGrd.Column3.Width = 40
4262: 
4263:         *-- ===================================================================
4264:         *-- TEXTBOXES - Descricao ECF, Metal/Teor, Valor Estimado, IPPT/CST
4265:         *-- ===================================================================
4266: 
4267:         *-- getDescEcfs (txt_4c_DescEcfs): T:429, L:206, W:213, H:23
4268:         loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
4269:         WITH loc_oPg.txt_4c_DescEcfs
4270:             .Value    = ""
4271:             .Top      = 429

*-- Linhas 4290 a 4478:
4290:             .InputMask = "!!!!!!!!!!"
4291:             .Visible   = .T.
4292:         ENDWITH
4293:         BINDEVENT(loc_oPg.txt_4c_Metal, "KeyPress", THIS, "TxtMetalKeyPress")
4294:         BINDEVENT(loc_oPg.txt_4c_Metal, "DblClick", THIS, "AbrirLookupMetal")
4295: 
4296:         *-- Get_DesMetal (txt_4c_DesMetal): Metal descricao - T:429, L:564, W:150, H:23 (READ-ONLY)
4297:         loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
4298:         WITH loc_oPg.txt_4c_DesMetal
4299:             .Value    = ""
4300:             .Top      = 429
4301:             .Left     = 564
4302:             .Width    = 150
4303:             .Height   = 23
4304:             .FontName = "Tahoma"
4305:             .FontSize = 8
4306:             .ReadOnly = .T.
4307:             .Visible  = .T.
4308:         ENDWITH
4309: 
4310:         *-- getValor (txt_4c_Valor): Valor Estimado - T:454, L:206, W:108, H:23
4311:         loc_oPg.AddObject("txt_4c_Valor", "TextBox")
4312:         WITH loc_oPg.txt_4c_Valor
4313:             .Value     = 0
4314:             .Top       = 454
4315:             .Left      = 206
4316:             .Width     = 108
4317:             .Height    = 23
4318:             .FontName  = "Tahoma"
4319:             .FontSize  = 8
4320:             .InputMask = "9,999,999.9999"
4321:             .Visible   = .T.
4322:         ENDWITH
4323: 
4324:         *-- GetMvalor (txt_4c_Mvalor): Moeda do Valor Estimado - T:454, L:317, W:31, H:23
4325:         loc_oPg.AddObject("txt_4c_Mvalor", "TextBox")
4326:         WITH loc_oPg.txt_4c_Mvalor
4327:             .Value     = ""
4328:             .Top       = 454
4329:             .Left      = 317
4330:             .Width     = 31
4331:             .Height    = 23
4332:             .FontName  = "Tahoma"
4333:             .FontSize  = 8
4334:             .InputMask = "!!!"
4335:             .Visible   = .T.
4336:         ENDWITH
4337:         BINDEVENT(loc_oPg.txt_4c_Mvalor, "KeyPress", THIS, "TxtMvalorKeyPress")
4338:         BINDEVENT(loc_oPg.txt_4c_Mvalor, "DblClick", THIS, "AbrirLookupMvalor")
4339: 
4340:         *-- Get_teor (txt_4c_Teor): Teor codigo - T:454, L:537, W:24, H:23
4341:         loc_oPg.AddObject("txt_4c_Teor", "TextBox")
4342:         WITH loc_oPg.txt_4c_Teor
4343:             .Value     = ""
4344:             .Top       = 454
4345:             .Left      = 537
4346:             .Width     = 24
4347:             .Height    = 23
4348:             .FontName  = "Tahoma"
4349:             .FontSize  = 8
4350:             .InputMask = "!!!!!!!!!!"
4351:             .Visible   = .T.
4352:         ENDWITH
4353:         BINDEVENT(loc_oPg.txt_4c_Teor, "KeyPress", THIS, "TxtTeorKeyPress")
4354:         BINDEVENT(loc_oPg.txt_4c_Teor, "DblClick", THIS, "AbrirLookupTeor")
4355: 
4356:         *-- Get_DesTeor (txt_4c_DesTeor): Teor descricao - T:454, L:564, W:150, H:23 (READ-ONLY)
4357:         loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
4358:         WITH loc_oPg.txt_4c_DesTeor
4359:             .Value    = ""
4360:             .Top      = 454
4361:             .Left     = 564
4362:             .Width    = 150
4363:             .Height   = 23
4364:             .FontName = "Tahoma"
4365:             .FontSize = 8
4366:             .ReadOnly = .T.
4367:             .Visible  = .T.
4368:         ENDWITH
4369: 
4370:         *-- getIPPTCST (txt_4c_IPPTCST): IPPT/CST - T:479, L:206, W:108, H:23 (READ-ONLY)
4371:         loc_oPg.AddObject("txt_4c_IPPTCST", "TextBox")
4372:         WITH loc_oPg.txt_4c_IPPTCST
4373:             .Value    = ""
4374:             .Top      = 479
4375:             .Left     = 206
4376:             .Width    = 108
4377:             .Height   = 23
4378:             .FontName = "Tahoma"
4379:             .FontSize = 8
4380:             .ReadOnly = .T.
4381:             .Visible  = .T.
4382:         ENDWITH
4383: 
4384:     ENDPROC
4385: 
4386:     *--------------------------------------------------------------------------
4387:     * ConfigurarPgpgCusto - Aba "Custo" do PageFrame interno (pgCusto)
4388:     * Fase 10: Sub-pagina Custo - grdCompo 12 colunas, cmbTipos, cmdgCusto,
4389:     *          GradeGRUPO2 (totais por grupo), labels e shape
4390:     * Posicoes: valores do layout.json (pgf_4c_Dados.Tabs=.F. -> sem +29)
4391:     *--------------------------------------------------------------------------
4392:     PROTECTED PROCEDURE ConfigurarPgpgCusto(par_oPage)
4393:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
4394: 
4395:         loc_oPg = par_oPage
4396: 
4397:         *-- ===================================================================
4398:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
4399:         *-- ===================================================================
4400: 
4401:         *-- cursor_4c_CustoCompo - composicao custo (SIGPRCPO filtrado por tipo)
4402:         IF USED("cursor_4c_CustoCompo")
4403:             USE IN cursor_4c_CustoCompo
4404:         ENDIF
4405:         SET NULL OFF
4406:         CREATE CURSOR cursor_4c_CustoCompo ( ;
4407:             mats      C(14), dcompos C(40), unicompos C(3),  ;
4408:             pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
4409:             moeds     C(3), obscompos C(10), etiqs C(1),     ;
4410:             qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
4411:             CGrus     C(3), tipos C(20))
4412: 
4413:         *-- cursor_4c_TotGrupoCusto - totais por grupo custo (calculado)
4414:         IF USED("cursor_4c_TotGrupoCusto")
4415:             USE IN cursor_4c_TotGrupoCusto
4416:         ENDIF
4417:         CREATE CURSOR cursor_4c_TotGrupoCusto ( ;
4418:             Grupo     C(3), ValGrupo N(11,3), Moeda C(3))
4419: 
4420:         *-- ===================================================================
4421:         *-- COMBO cbo_4c_CmbTipos (cmbTipos: top=154, left=143, w=187, h=23)
4422:         *-- ===================================================================
4423:         loc_oPg.AddObject("cbo_4c_CmbTipos", "ComboBox")
4424:         WITH loc_oPg.cbo_4c_CmbTipos
4425:             .Top           = 154
4426:             .Left          = 143
4427:             .Width         = 187
4428:             .Height        = 23
4429:             .FontName      = "Tahoma"
4430:             .FontSize      = 8
4431:             .RowSourceType = 1
4432:             .RowSource     = ""
4433:             .Style         = 2
4434:             .SpecialEffect = 1
4435:             .Themes        = .F.
4436:             .Visible       = .T.
4437:         ENDWITH
4438:         BINDEVENT(loc_oPg.cbo_4c_CmbTipos, "InteractiveChange", THIS, "CboTiposCustoInteractiveChange")
4439: 
4440:         *-- LABEL lbl_4c_Label1 (Say1 "Tipo :": top=159, left=112, w=29, h=15)
4441:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
4442:         WITH loc_oPg.lbl_4c_Label1
4443:             .Caption   = "Tipo :"
4444:             .Top       = 159
4445:             .Left      = 112
4446:             .Width     = 29
4447:             .Height    = 15
4448:             .BackStyle = 0
4449:             .ForeColor = RGB(90, 90, 90)
4450:             .FontName  = "Tahoma"
4451:             .FontSize  = 8
4452:             .Visible   = .T.
4453:         ENDWITH
4454: 
4455:         *-- ===================================================================
4456:         *-- GRID grd_4c_CustoCompo (grdCompo: top=178, left=34, w=813, h=230)
4457:         *-- 12 colunas de SIGPRCPO
4458:         *-- ===================================================================
4459:         loc_oPg.AddObject("grd_4c_CustoCompo", "Grid")
4460:         loc_oGrd = loc_oPg.grd_4c_CustoCompo
4461:         WITH loc_oGrd
4462:             .Top         = 178
4463:             .Left        = 34
4464:             .Width       = 813
4465:             .Height      = 230
4466:             .FontName    = "Tahoma"
4467:             .FontSize    = 8
4468:             .RecordMark  = .F.
4469:             .DeleteMark  = .F.
4470:             .GridLines   = 3
4471:             .ReadOnly    = .F.
4472:             .RowHeight   = 16
4473:             .ScrollBars  = 2
4474:             .Themes      = .F.
4475:             .ColumnCount = 12
4476:             .Visible     = .T.
4477:         ENDWITH
4478: 

*-- Linhas 4548 a 4582:
4548:             .Resizable = .F.
4549:             .ReadOnly  = .T.
4550:         ENDWITH
4551: 
4552:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
4553:         loc_oGrd.RecordSource = "cursor_4c_CustoCompo"
4554: 
4555:         *-- ControlSource APOS RecordSource (obrigatorio)
4556:         loc_oGrd.Column1.ControlSource  = "cursor_4c_CustoCompo.mats"
4557:         loc_oGrd.Column2.ControlSource  = "cursor_4c_CustoCompo.dcompos"
4558:         loc_oGrd.Column3.ControlSource  = "cursor_4c_CustoCompo.unicompos"
4559:         loc_oGrd.Column4.ControlSource  = "cursor_4c_CustoCompo.pcompos"
4560:         loc_oGrd.Column5.ControlSource  = "cursor_4c_CustoCompo.qtds"
4561:         loc_oGrd.Column6.ControlSource  = "cursor_4c_CustoCompo.totas"
4562:         loc_oGrd.Column7.ControlSource  = "cursor_4c_CustoCompo.moeds"
4563:         loc_oGrd.Column8.ControlSource  = "cursor_4c_CustoCompo.obscompos"
4564:         loc_oGrd.Column9.ControlSource  = "cursor_4c_CustoCompo.etiqs"
4565:         loc_oGrd.Column10.ControlSource = "cursor_4c_CustoCompo.qtscons"
4566:         loc_oGrd.Column11.ControlSource = "cursor_4c_CustoCompo.qtdcvs"
4567:         loc_oGrd.Column12.ControlSource = "cursor_4c_CustoCompo.cunips"
4568: 
4569:         *-- Cabecalhos APOS RecordSource
4570:         loc_oGrd.Column1.Header1.Caption  = "Item"
4571:         loc_oGrd.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
4572:         loc_oGrd.Column3.Header1.Caption  = "Un"
4573:         loc_oGrd.Column4.Header1.Caption  = "Valor"
4574:         loc_oGrd.Column5.Header1.Caption  = "Qtd"
4575:         loc_oGrd.Column6.Header1.Caption  = "Total"
4576:         loc_oGrd.Column7.Header1.Caption  = "Moe"
4577:         loc_oGrd.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
4578:         loc_oGrd.Column9.Header1.Caption  = "Etiq"
4579:         loc_oGrd.Column10.Header1.Caption = "Consumo"
4580:         loc_oGrd.Column11.Header1.Caption = "Qtd"
4581:         loc_oGrd.Column12.Header1.Caption = "Un"
4582: 

*-- Linhas 4594 a 4680:
4594:         loc_oGrd.Column11.Width = 59
4595:         loc_oGrd.Column12.Width = 24
4596: 
4597:         *-- BINDEVENT grd_4c_CustoCompo
4598:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdCustoCompoAfterRowColChange")
4599: 
4600:         *-- ===================================================================
4601:         *-- COMMANDGROUP obj_4c_CmdgCusto (cmdgCompo: top=240, left=851, w=50, h=90)
4602:         *-- 2 botoes: Inserir, Excluir
4603:         *-- ===================================================================
4604:         loc_oPg.AddObject("obj_4c_CmdgCusto", "CommandGroup")
4605:         WITH loc_oPg.obj_4c_CmdgCusto
4606:             .ButtonCount   = 2
4607:             .BorderStyle   = 0
4608:             .Top           = 240
4609:             .Left          = 851
4610:             .Width         = 50
4611:             .Height        = 90
4612:             .BackColor     = RGB(162, 214, 242)
4613:             .Themes        = .F.
4614:             .Visible       = .T.
4615:         ENDWITH
4616:         WITH loc_oPg.obj_4c_CmdgCusto
4617:             .Buttons(1).Top           = 5
4618:             .Buttons(1).Left          = 5
4619:             .Buttons(1).Height        = 40
4620:             .Buttons(1).Width         = 40
4621:             .Buttons(1).Caption       = ""
4622:             .Buttons(1).Picture       = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
4623:             .Buttons(1).ToolTipText   = "Inserir Item"
4624:             .Buttons(1).SpecialEffect = 0
4625:             .Buttons(1).BackColor     = RGB(255, 255, 255)
4626:             .Buttons(1).ForeColor     = RGB(0, 0, 0)
4627:             .Buttons(1).Themes        = .F.
4628:             .Buttons(2).Top           = 45
4629:             .Buttons(2).Left          = 5
4630:             .Buttons(2).Height        = 40
4631:             .Buttons(2).Width         = 40
4632:             .Buttons(2).Caption       = ""
4633:             .Buttons(2).Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
4634:             .Buttons(2).ToolTipText   = "Excluir Item"
4635:             .Buttons(2).SpecialEffect = 0
4636:             .Buttons(2).BackColor     = RGB(255, 255, 255)
4637:             .Buttons(2).ForeColor     = RGB(0, 0, 0)
4638:             .Buttons(2).Themes        = .F.
4639:         ENDWITH
4640:         BINDEVENT(loc_oPg.obj_4c_CmdgCusto, "Click", THIS, "CmdgCustoClick")
4641: 
4642:         *-- ===================================================================
4643:         *-- LABEL + TEXTBOX para descricao e grupo do item selecionado
4644:         *-- ===================================================================
4645: 
4646:         *-- LABEL lbl_4c_Label16 (Say16 "Descricao :": top=415, left=52, w=55, h=15)
4647:         loc_oPg.AddObject("lbl_4c_Label16", "Label")
4648:         WITH loc_oPg.lbl_4c_Label16
4649:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
4650:             .Top       = 415
4651:             .Left      = 52
4652:             .Width     = 55
4653:             .Height    = 15
4654:             .BackStyle = 0
4655:             .ForeColor = RGB(90, 90, 90)
4656:             .FontName  = "Tahoma"
4657:             .FontSize  = 8
4658:             .Visible   = .T.
4659:         ENDWITH
4660: 
4661:         *-- TEXTBOX txt_4c_Desc (Get_Desc: top=412, left=116, w=304, h=21, ReadOnly)
4662:         loc_oPg.AddObject("txt_4c_Desc", "TextBox")
4663:         WITH loc_oPg.txt_4c_Desc
4664:             .Value     = ""
4665:             .Top       = 412
4666:             .Left      = 116
4667:             .Width     = 304
4668:             .Height    = 21
4669:             .FontName  = "Tahoma"
4670:             .FontSize  = 8
4671:             .ReadOnly  = .T.
4672:             .BackColor = RGB(224, 235, 235)
4673:             .Themes    = .F.
4674:             .Visible   = .T.
4675:         ENDWITH
4676: 
4677:         *-- LABEL lbl_4c_Label2 (Say2 "Grupo :": top=415, left=479, w=38, h=15)
4678:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
4679:         WITH loc_oPg.lbl_4c_Label2
4680:             .Caption   = "Grupo :"

*-- Linhas 4779 a 4850:
4779:             .Movable   = .F.
4780:             .Resizable = .F.
4781:             .ReadOnly  = .T.
4782:         ENDWITH
4783: 
4784:         loc_oGrd2.RecordSource = "cursor_4c_TotGrupoCusto"
4785:         loc_oGrd2.Column1.ControlSource = "cursor_4c_TotGrupoCusto.Grupo"
4786:         loc_oGrd2.Column2.ControlSource = "cursor_4c_TotGrupoCusto.ValGrupo"
4787:         loc_oGrd2.Column3.ControlSource = "cursor_4c_TotGrupoCusto.Moeda"
4788:         loc_oGrd2.Column1.Header1.Caption = "Grp"
4789:         loc_oGrd2.Column2.Header1.Caption = "Total "
4790:         loc_oGrd2.Column3.Header1.Caption = "Moe"
4791:         loc_oGrd2.Column1.Width = 35
4792:         loc_oGrd2.Column2.Width = 134
4793:         loc_oGrd2.Column3.Width = 37
4794: 
4795:     ENDPROC
4796: 
4797:     *--------------------------------------------------------------------------
4798:     * ConfigurarPgPgDadosConsP - Aba "Cons. P." (Page5 de pgf_4c_DadosInternos)
4799:     * Grid grd_4c_GrdCons (9 cols) - RecordSource: crSigPrCpo
4800:     * Ordem visual: Mats | Dcompos | Qtds | UniCompos | Grupos | Dscgrp | Ordems | QtsCons | Cats
4801:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
4802:     *--------------------------------------------------------------------------
4803:     PROTECTED PROCEDURE ConfigurarPgPgDadosConsP(par_oPage)
4804:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
4805: 
4806:         loc_oPg = par_oPage
4807: 
4808:         *-- ===================================================================
4809:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
4810:         *-- Campos na ORDEM VISUAL das colunas (sem ColumnOrder)
4811:         *-- ===================================================================
4812: 
4813:         *-- cursor_4c_GrdCons - consumo de produto (baseado em crSigPrCpo)
4814:         *-- Ordem: Mats(cod), Dcompos(desc), Qtds(qtde RO), UniCompos(uni RO),
4815:         *--        Grupos(fase), Dscgrp(desc fase), Ordems(ord RO), QtsCons(consumo), Cats(cat)
4816:         IF USED("cursor_4c_GrdCons")
4817:             USE IN cursor_4c_GrdCons
4818:         ENDIF
4819:         SET NULL OFF
4820:         CREATE CURSOR cursor_4c_GrdCons ( ;
4821:             Mats      C(14), ;
4822:             Dcompos   C(40), ;
4823:             Qtds      N(12,4), ;
4824:             UniCompos C(3), ;
4825:             Grupos    C(3), ;
4826:             Dscgrp    C(40), ;
4827:             Ordems    N(3,0), ;
4828:             QtsCons   N(12,4), ;
4829:             Cats      C(3))
4830: 
4831:         *-- cursor_4c_GrDTEMP - tempo por agrupamento (baseado em crSigProTp)
4832:         IF USED("cursor_4c_GrDTEMP")
4833:             USE IN cursor_4c_GrDTEMP
4834:         ENDIF
4835:         CREATE CURSOR cursor_4c_GrDTEMP ( ;
4836:             agrupas   C(3), ;
4837:             pertemps  N(12,3))
4838: 
4839:         *-- ===================================================================
4840:         *-- GRID grd_4c_GrdCons
4841:         *-- Original: top=155, left=6, w=987, h=362, RowHeight=17
4842:         *-- ===================================================================
4843:         loc_oPg.AddObject("grd_4c_GrdCons", "Grid")
4844:         loc_oGrd = loc_oPg.grd_4c_GrdCons
4845:         WITH loc_oGrd
4846:             .Top         = 155
4847:             .Left        = 6
4848:             .Width       = 987
4849:             .Height      = 362
4850:             .FontName    = "Tahoma"

*-- Linhas 4920 a 4951:
4920:             .Movable   = .F.
4921:             .Resizable = .F.
4922:         ENDWITH
4923: 
4924:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
4925:         loc_oGrd.RecordSource = "cursor_4c_GrdCons"
4926: 
4927:         *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
4928:         loc_oGrd.Column1.ControlSource = "cursor_4c_GrdCons.Mats"
4929:         loc_oGrd.Column2.ControlSource = "cursor_4c_GrdCons.Dcompos"
4930:         loc_oGrd.Column3.ControlSource = "cursor_4c_GrdCons.Qtds"
4931:         loc_oGrd.Column4.ControlSource = "cursor_4c_GrdCons.UniCompos"
4932:         loc_oGrd.Column5.ControlSource = "cursor_4c_GrdCons.Grupos"
4933:         loc_oGrd.Column6.ControlSource = "cursor_4c_GrdCons.Dscgrp"
4934:         loc_oGrd.Column7.ControlSource = "cursor_4c_GrdCons.Ordems"
4935:         loc_oGrd.Column8.ControlSource = "cursor_4c_GrdCons.QtsCons"
4936:         loc_oGrd.Column9.ControlSource = "cursor_4c_GrdCons.Cats"
4937: 
4938:         *-- Cabecalhos APOS RecordSource
4939:         loc_oGrd.Column1.Header1.Caption = "Componente"
4940:         loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4941:         loc_oGrd.Column3.Header1.Caption = "Qtde."
4942:         loc_oGrd.Column4.Header1.Caption = "Uni"
4943:         loc_oGrd.Column5.Header1.Caption = "Fase"
4944:         loc_oGrd.Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4945:         loc_oGrd.Column7.Header1.Caption = "Ord."
4946:         loc_oGrd.Column8.Header1.Caption = "Consumo"
4947:         loc_oGrd.Column9.Header1.Caption = "Cat."
4948: 
4949:         *-- Larguras re-aplicadas APOS RecordSource
4950:         loc_oGrd.Column1.Width = 108
4951:         loc_oGrd.Column2.Width = 223

*-- Linhas 4957 a 5022:
4957:         loc_oGrd.Column8.Width = 60
4958:         loc_oGrd.Column9.Width = 52
4959: 
4960:         *-- BINDEVENT grd_4c_GrdCons
4961:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdConsAfterRowColChange")
4962: 
4963:         *-- ===================================================================
4964:         *-- GRID grd_4c_GrDTEMP (grDTEMP: top=519, left=821, w=172, h=107, 2 cols)
4965:         *-- ===================================================================
4966:         loc_oPg.AddObject("grd_4c_GrDTEMP", "Grid")
4967:         loc_oGrd2 = loc_oPg.grd_4c_GrDTEMP
4968:         WITH loc_oGrd2
4969:             .Top         = 519
4970:             .Left        = 821
4971:             .Width       = 172
4972:             .Height      = 107
4973:             .FontName    = "Tahoma"
4974:             .FontSize    = 8
4975:             .RecordMark  = .T.
4976:             .DeleteMark  = .F.
4977:             .GridLines   = 3
4978:             .ReadOnly    = .T.
4979:             .RowHeight   = 17
4980:             .ScrollBars  = 2
4981:             .Themes      = .F.
4982:             .ColumnCount = 2
4983:             .Visible     = .T.
4984:         ENDWITH
4985: 
4986:         *-- Col1: Agrupamento/agrupas (80px, ReadOnly)
4987:         WITH loc_oGrd2.Column1
4988:             .Width     = 80
4989:             .Movable   = .F.
4990:             .Resizable = .F.
4991:             .ReadOnly  = .T.
4992:         ENDWITH
4993:         *-- Col2: Tempo %/pertemps (60px, ReadOnly)
4994:         WITH loc_oGrd2.Column2
4995:             .Width      = 60
4996:             .Movable    = .F.
4997:             .Resizable  = .F.
4998:             .ReadOnly   = .T.
4999:             .InputMask  = "999,999,999.999"
5000:         ENDWITH
5001: 
5002:         *-- RecordSource APOS ColumnCount
5003:         loc_oGrd2.RecordSource = "cursor_4c_GrDTEMP"
5004: 
5005:         *-- ControlSource APOS RecordSource
5006:         loc_oGrd2.Column1.ControlSource = "cursor_4c_GrDTEMP.agrupas"
5007:         loc_oGrd2.Column2.ControlSource = "cursor_4c_GrDTEMP.pertemps"
5008: 
5009:         *-- Cabecalhos APOS RecordSource
5010:         loc_oGrd2.Column1.Header1.Caption = "Agrupamento"
5011:         loc_oGrd2.Column2.Header1.Caption = "Tempo %"
5012: 
5013:         *-- Larguras re-aplicadas APOS RecordSource
5014:         loc_oGrd2.Column1.Width = 80
5015:         loc_oGrd2.Column2.Width = 60
5016: 
5017:         *-- ===================================================================
5018:         *-- LABEL lbl_4c_Say7 (Say7 "Qtde Componentes :": top=523, left=25, w=105, h=15)
5019:         *-- ===================================================================
5020:         loc_oPg.AddObject("lbl_4c_Say7", "Label")
5021:         WITH loc_oPg.lbl_4c_Say7
5022:             .Caption   = "Qtde Componentes : "

*-- Linhas 5102 a 5160:
5102:     * ImgFigJpg (foto do processo), ImgBorracha (foto da matriz)
5103:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
5104:     *--------------------------------------------------------------------------
5105:     PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP(par_oPage)
5106:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
5107: 
5108:         loc_oPg = par_oPage
5109: 
5110:         *-- ===================================================================
5111:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
5112:         *-- Campos na ORDEM VISUAL das colunas (sem ColumnOrder)
5113:         *-- ===================================================================
5114: 
5115:         *-- cursor_4c_Fase - fases de processo (baseado em crSigCdPrf)
5116:         *-- Ordem visual: Ordems | Grupos | Descrs | UniPrdts | TpMats
5117:         IF USED("cursor_4c_Fase")
5118:             USE IN cursor_4c_Fase
5119:         ENDIF
5120:         SET NULL OFF
5121:         CREATE CURSOR cursor_4c_Fase ( ;
5122:             Ordems    N(3,0), ;
5123:             Grupos    C(10), ;
5124:             Descrs    C(40), ;
5125:             UniPrdts  C(10), ;
5126:             TpMats    C(3), ;
5127:             FigProcs  M, ;
5128:             FkChaves  C(30), ;
5129:             GrpOrdem  C(12))
5130: 
5131:         *-- cursor_4c_Matrizes - matrizes do produto (baseado em crSigPrMtz)
5132:         *-- Ordem visual: CMats | Locals | QMatz
5133:         IF USED("cursor_4c_Matrizes")
5134:             USE IN cursor_4c_Matrizes
5135:         ENDIF
5136:         SET NULL OFF
5137:         CREATE CURSOR cursor_4c_Matrizes ( ;
5138:             CMats     C(14), ;
5139:             Locals    C(20), ;
5140:             QMatz     N(5,2), ;
5141:             CPros     C(14), ;
5142:             cIdChaves C(30), ;
5143:             DPros     C(40))
5144:         *-- Linha vazia placeholder (grdMatrizes sempre tem ao menos 1 linha)
5145:         INSERT INTO cursor_4c_Matrizes (CMats, Locals, QMatz, CPros, cIdChaves, DPros) ;
5146:             VALUES ("", "", 0, "", "", "")
5147: 
5148:         *-- ===================================================================
5149:         *-- GRID grd_4c_FasePro (GradFase: top=152, left=527, w=420, h=312, 5 cols)
5150:         *-- crSigCdPrf: Ordems N(3), Grupos C(10), Descrs C(40), UniPrdts C(10), TpMats C(3)
5151:         *-- ===================================================================
5152:         loc_oPg.AddObject("grd_4c_FasePro", "Grid")
5153:         loc_oGrd = loc_oPg.grd_4c_FasePro
5154:         WITH loc_oGrd
5155:             .Top         = 152
5156:             .Left        = 527
5157:             .Width       = 420
5158:             .Height      = 312
5159:             .FontName    = "Tahoma"
5160:             .FontSize    = 8

*-- Linhas 5203 a 5357:
5203:             .Resizable = .F.
5204:             .Sparse    = .F.
5205:         ENDWITH
5206: 
5207:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
5208:         loc_oGrd.RecordSource = "cursor_4c_Fase"
5209: 
5210:         *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
5211:         loc_oGrd.Column1.ControlSource = "cursor_4c_Fase.Ordems"
5212:         loc_oGrd.Column2.ControlSource = "cursor_4c_Fase.Grupos"
5213:         loc_oGrd.Column3.ControlSource = "cursor_4c_Fase.Descrs"
5214:         loc_oGrd.Column4.ControlSource = "cursor_4c_Fase.UniPrdts"
5215:         loc_oGrd.Column5.ControlSource = "cursor_4c_Fase.TpMats"
5216: 
5217:         *-- Cabecalhos APOS RecordSource
5218:         loc_oGrd.Column1.Header1.Caption = "Ordem"
5219:         loc_oGrd.Column2.Header1.Caption = "Fase"
5220:         loc_oGrd.Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
5221:         loc_oGrd.Column4.Header1.Caption = "Uni. Produtiva"
5222:         loc_oGrd.Column5.Header1.Caption = "Material"
5223: 
5224:         *-- Larguras re-aplicadas APOS RecordSource
5225:         loc_oGrd.Column1.Width = 40
5226:         loc_oGrd.Column2.Width = 70
5227:         loc_oGrd.Column3.Width = 165
5228:         loc_oGrd.Column4.Width = 100
5229:         loc_oGrd.Column5.Width = 45
5230: 
5231:         *-- BINDEVENT grd_4c_FasePro
5232:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdFaseAfterRowColChange")
5233:         BINDEVENT(loc_oGrd.Column2.Text1, "Valid", THIS, "FaseGrdCol2Valid")
5234:         BINDEVENT(loc_oGrd.Column4.Text1, "Valid", THIS, "FaseGrdCol4Valid")
5235:         BINDEVENT(loc_oGrd.Column5.Text1, "Valid", THIS, "FaseGrdCol5Valid")
5236: 
5237:         *-- ===================================================================
5238:         *-- COMMANDBUTTON cmd_4c_Incluir (inserir: top=152, left=950, 30x30)
5239:         *-- ===================================================================
5240:         loc_oPg.AddObject("cmd_4c_InsFase", "CommandButton")
5241:         WITH loc_oPg.cmd_4c_InsFase
5242:             .Top             = 152
5243:             .Left            = 950
5244:             .Width           = 30
5245:             .Height          = 30
5246:             .Caption         = ""
5247:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
5248:             .PicturePosition = 13
5249:             .ToolTipText     = "Inserir Fase"
5250:             .FontName        = "Tahoma"
5251:             .FontSize        = 8
5252:             .Themes          = .F.
5253:             .SpecialEffect   = 0
5254:             .BackColor       = RGB(255, 255, 255)
5255:             .Visible         = .T.
5256:         ENDWITH
5257:         BINDEVENT(loc_oPg.cmd_4c_InsFase, "Click", THIS, "FaseInserirClick")
5258: 
5259:         *-- COMMANDBUTTON cmd_4c_ExcFase (excluir: top=192, left=950, 30x30)
5260:         loc_oPg.AddObject("cmd_4c_ExcFase", "CommandButton")
5261:         WITH loc_oPg.cmd_4c_ExcFase
5262:             .Top             = 192
5263:             .Left            = 950
5264:             .Width           = 30
5265:             .Height          = 30
5266:             .Caption         = ""
5267:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
5268:             .PicturePosition = 13
5269:             .ToolTipText     = "Excluir Fase"
5270:             .FontName        = "Tahoma"
5271:             .FontSize        = 8
5272:             .Themes          = .F.
5273:             .SpecialEffect   = 0
5274:             .BackColor       = RGB(255, 255, 255)
5275:             .Visible         = .T.
5276:         ENDWITH
5277:         BINDEVENT(loc_oPg.cmd_4c_ExcFase, "Click", THIS, "FaseExcluirClick")
5278: 
5279:         *-- COMMANDBUTTON cmd_4c_AltFase (Alternativa: top=232, left=950, 30x30)
5280:         loc_oPg.AddObject("cmd_4c_AltFase", "CommandButton")
5281:         WITH loc_oPg.cmd_4c_AltFase
5282:             .Top             = 232
5283:             .Left            = 950
5284:             .Width           = 30
5285:             .Height          = 30
5286:             .Caption         = ""
5287:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
5288:             .PicturePosition = 13
5289:             .ToolTipText     = "Fase Alternativa"
5290:             .FontName        = "Tahoma"
5291:             .FontSize        = 8
5292:             .Themes          = .F.
5293:             .SpecialEffect   = 0
5294:             .BackColor       = RGB(255, 255, 255)
5295:             .Visible         = .T.
5296:         ENDWITH
5297:         BINDEVENT(loc_oPg.cmd_4c_AltFase, "Click", THIS, "FaseAlternativaClick")
5298: 
5299:         *-- COMMANDBUTTON cmd_4c_CmdFicha (CmdFicha: top=152, left=482, 30x30)
5300:         loc_oPg.AddObject("cmd_4c_CmdFicha", "CommandButton")
5301:         WITH loc_oPg.cmd_4c_CmdFicha
5302:             .Top             = 152
5303:             .Left            = 482
5304:             .Width           = 30
5305:             .Height          = 30
5306:             .Caption         = ""
5307:             .Picture         = gc_4c_CaminhoIcones + "relatorio_visualizar_26.jpg"
5308:             .PicturePosition = 13
5309:             .ToolTipText     = "Ficha T" + CHR(233) + "cnica"
5310:             .FontName        = "Tahoma"
5311:             .FontSize        = 8
5312:             .Themes          = .F.
5313:             .SpecialEffect   = 0
5314:             .BackColor       = RGB(255, 255, 255)
5315:             .Visible         = .T.
5316:         ENDWITH
5317:         BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaClick")
5318: 
5319:         *-- ===================================================================
5320:         *-- LABEL + TEXTBOX: Say13/getQmin "Qtd. Min. Producao :" (top=156/152, left=33/137)
5321:         *-- ===================================================================
5322:         loc_oPg.AddObject("lbl_4c_Label13", "Label")
5323:         WITH loc_oPg.lbl_4c_Label13
5324:             .Caption   = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
5325:             .Top       = 156
5326:             .Left      = 33
5327:             .Width     = 102
5328:             .Height    = 15
5329:             .BackStyle = 0
5330:             .ForeColor = RGB(90, 90, 90)
5331:             .FontName  = "Tahoma"
5332:             .FontSize  = 8
5333:             .Visible   = .T.
5334:         ENDWITH
5335: 
5336:         loc_oPg.AddObject("txt_4c_Qmin", "TextBox")
5337:         WITH loc_oPg.txt_4c_Qmin
5338:             .Top           = 152
5339:             .Left          = 137
5340:             .Width         = 80
5341:             .Height        = 23
5342:             .FontName      = "Tahoma"
5343:             .FontSize      = 8
5344:             .SpecialEffect = 1
5345:             .Themes        = .F.
5346:             .ReadOnly      = .F.
5347:             .Alignment     = 3
5348:             .InputMask     = "99999.999"
5349:             .Value         = 0
5350:             .Visible       = .T.
5351:         ENDWITH
5352: 
5353:         *-- ===================================================================
5354:         *-- LABEL + TEXTBOX: Say5/getCodGarras "Garra :" (top=181/177, left=99/137)
5355:         *-- getCodGarras.When = .F. -> ReadOnly
5356:         *-- ===================================================================
5357:         loc_oPg.AddObject("lbl_4c_Label5", "Label")

*-- Linhas 5414 a 5457:
5414:             .Value         = ""
5415:             .Visible       = .T.
5416:         ENDWITH
5417:         BINDEVENT(loc_oPg.txt_4c_Conquilha, "LostFocus", THIS, "ValidarConquilha")
5418: 
5419:         *-- ===================================================================
5420:         *-- LABEL + TEXTBOX: Say9/getPesoBris "Peso Brilhante :" (top=231/227, left=58/137)
5421:         *-- ===================================================================
5422:         loc_oPg.AddObject("lbl_4c_Label9", "Label")
5423:         WITH loc_oPg.lbl_4c_Label9
5424:             .Caption   = "Peso Brilhante :"
5425:             .Top       = 231
5426:             .Left      = 58
5427:             .Width     = 77
5428:             .Height    = 15
5429:             .BackStyle = 0
5430:             .ForeColor = RGB(90, 90, 90)
5431:             .FontName  = "Tahoma"
5432:             .FontSize  = 8
5433:             .Visible   = .T.
5434:         ENDWITH
5435: 
5436:         loc_oPg.AddObject("txt_4c_PesoBris", "TextBox")
5437:         WITH loc_oPg.txt_4c_PesoBris
5438:             .Top           = 227
5439:             .Left          = 137
5440:             .Width         = 80
5441:             .Height        = 23
5442:             .FontName      = "Tahoma"
5443:             .FontSize      = 8
5444:             .SpecialEffect = 1
5445:             .Themes        = .F.
5446:             .ReadOnly      = .F.
5447:             .Alignment     = 3
5448:             .InputMask     = "999.9999"
5449:             .Value         = 0
5450:             .Visible       = .T.
5451:         ENDWITH
5452: 
5453:         *-- ===================================================================
5454:         *-- LABEL + TEXTBOX: Say10/getPesoMetal "Peso Metal :" (top=256/252, left=74/137)
5455:         *-- ===================================================================
5456:         loc_oPg.AddObject("lbl_4c_Label10", "Label")
5457:         WITH loc_oPg.lbl_4c_Label10

*-- Linhas 5549 a 5592:
5549:             .Value         = ""
5550:             .Visible       = .T.
5551:         ENDWITH
5552:         BINDEVENT(loc_oPg.txt_4c_Cor, "LostFocus", THIS, "ValidarCor")
5553: 
5554:         *-- ===================================================================
5555:         *-- CHECKBOX: opc_CravCera "Cravacao em Cera" (top=306, left=180)
5556:         *-- ===================================================================
5557:         loc_oPg.AddObject("chk_4c_CravCera", "CheckBox")
5558:         WITH loc_oPg.chk_4c_CravCera
5559:             .Caption       = "Crava" + CHR(231) + CHR(227) + "o em Cera"
5560:             .Top           = 306
5561:             .Left          = 180
5562:             .Width         = 110
5563:             .Height        = 15
5564:             .FontName      = "Tahoma"
5565:             .FontSize      = 8
5566:             .BackStyle     = 0
5567:             .Alignment     = 0
5568:             .AutoSize      = .T.
5569:             .SpecialEffect = 1
5570:             .ForeColor     = RGB(90, 90, 90)
5571:             .Themes        = .F.
5572:             .Value         = .F.
5573:             .Visible       = .T.
5574:         ENDWITH
5575: 
5576:         *-- ===================================================================
5577:         *-- LABEL + TEXTBOX: Say2/getTam "Tamanho Padrao :" (top=331/327, left=45/137)
5578:         *-- ===================================================================
5579:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
5580:         WITH loc_oPg.lbl_4c_Label2
5581:             .Caption   = "Tamanho Padr" + CHR(227) + "o :"
5582:             .Top       = 331
5583:             .Left      = 45
5584:             .Width     = 90
5585:             .Height    = 15
5586:             .BackStyle = 0
5587:             .ForeColor = RGB(90, 90, 90)
5588:             .FontName  = "Tahoma"
5589:             .FontSize  = 8
5590:             .Visible   = .T.
5591:         ENDWITH
5592: 

*-- Linhas 5604 a 5647:
5604:             .Value         = ""
5605:             .Visible       = .T.
5606:         ENDWITH
5607:         BINDEVENT(loc_oPg.txt_4c_Tam, "LostFocus", THIS, "ValidarTam")
5608: 
5609:         *-- ===================================================================
5610:         *-- CHECKBOX: fwoption1 "Peso Variavel" (top=331, left=180)
5611:         *-- ===================================================================
5612:         loc_oPg.AddObject("chk_4c_PesoVar", "CheckBox")
5613:         WITH loc_oPg.chk_4c_PesoVar
5614:             .Caption       = "Peso Vari" + CHR(225) + "vel"
5615:             .Top           = 331
5616:             .Left          = 180
5617:             .Width         = 90
5618:             .Height        = 15
5619:             .FontName      = "Tahoma"
5620:             .FontSize      = 8
5621:             .BackStyle     = 0
5622:             .Alignment     = 0
5623:             .AutoSize      = .T.
5624:             .SpecialEffect = 1
5625:             .ForeColor     = RGB(90, 90, 90)
5626:             .Themes        = .F.
5627:             .Value         = .F.
5628:             .Visible       = .T.
5629:         ENDWITH
5630: 
5631:         *-- ===================================================================
5632:         *-- LABEL + TEXTBOX: lblAcabamento/get_codacb/get_Dacb (top=356/352, left=16/137/177)
5633:         *-- get_Dacb.When = .F. -> ReadOnly (preenchido pelo lookup de codacb)
5634:         *-- ===================================================================
5635:         loc_oPg.AddObject("lbl_4c_LblAcabamento", "Label")
5636:         WITH loc_oPg.lbl_4c_LblAcabamento
5637:             .Caption   = "Acabamento :"
5638:             .Top       = 356
5639:             .Left      = 16
5640:             .Width     = 119
5641:             .Height    = 15
5642:             .BackStyle = 0
5643:             .ForeColor = RGB(90, 90, 90)
5644:             .FontName  = "Tahoma"
5645:             .FontSize  = 8
5646:             .Visible   = .T.
5647:         ENDWITH

*-- Linhas 5660 a 5803:
5660:             .Value         = ""
5661:             .Visible       = .T.
5662:         ENDWITH
5663:         BINDEVENT(loc_oPg.txt_4c_CodAcb, "LostFocus", THIS, "ValidarAcabamento")
5664: 
5665:         loc_oPg.AddObject("txt_4c_Dacb", "TextBox")
5666:         WITH loc_oPg.txt_4c_Dacb
5667:             .Top           = 352
5668:             .Left          = 177
5669:             .Width         = 207
5670:             .Height        = 23
5671:             .FontName      = "Tahoma"
5672:             .FontSize      = 8
5673:             .SpecialEffect = 1
5674:             .Themes        = .F.
5675:             .ReadOnly      = .T.
5676:             .Value         = ""
5677:             .Visible       = .T.
5678:         ENDWITH
5679: 
5680:         *-- ===================================================================
5681:         *-- SHAPE shp_4c_ShpFig (shpFig: top=152, left=231, w=244, h=148)
5682:         *-- IMAGE img_4c_ImgFigJpg (ImgFigJpg: top=153, left=232, w=241, h=146)
5683:         *-- ===================================================================
5684:         loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
5685:         WITH loc_oPg.shp_4c_ShpFig
5686:             .Top         = 152
5687:             .Left        = 231
5688:             .Width       = 244
5689:             .Height      = 148
5690:             .BackColor   = RGB(240, 240, 240)
5691:             .BorderColor = RGB(128, 128, 128)
5692:             .BorderWidth = 1
5693:             .Visible     = .T.
5694:         ENDWITH
5695: 
5696:         loc_oPg.AddObject("img_4c_ImgFigJpg", "Image")
5697:         WITH loc_oPg.img_4c_ImgFigJpg
5698:             .Top     = 153
5699:             .Left    = 232
5700:             .Width   = 241
5701:             .Height  = 146
5702:             .Stretch = 2
5703:             .Visible = .F.
5704:         ENDWITH
5705:         BINDEVENT(loc_oPg.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")
5706: 
5707:         *-- ===================================================================
5708:         *-- COMMANDGROUP obj_4c_CmdgFigura (cmdgFigura: top=192, left=482, 40x40, 1 botao)
5709:         *-- Selecionar foto do processo
5710:         *-- ===================================================================
5711:         loc_oPg.AddObject("obj_4c_CmdgFigura", "CommandGroup")
5712:         WITH loc_oPg.obj_4c_CmdgFigura
5713:             .ButtonCount = 1
5714:             .BorderStyle = 0
5715:             .Top         = 192
5716:             .Left        = 482
5717:             .Width       = 40
5718:             .Height      = 40
5719:             .Themes      = .F.
5720:             .Visible     = .T.
5721:         ENDWITH
5722:         WITH loc_oPg.obj_4c_CmdgFigura
5723:             .Buttons(1).Top           = 0
5724:             .Buttons(1).Left          = 0
5725:             .Buttons(1).Height        = 40
5726:             .Buttons(1).Width         = 40
5727:             .Buttons(1).Caption       = ""
5728:             .Buttons(1).Picture       = gc_4c_CaminhoIcones + "geral_foto_26.jpg"
5729:             .Buttons(1).ToolTipText   = "Selecionar Foto"
5730:             .Buttons(1).SpecialEffect = 0
5731:             .Buttons(1).BackColor     = RGB(255, 255, 255)
5732:             .Buttons(1).Themes        = .F.
5733:         ENDWITH
5734:         BINDEVENT(loc_oPg.obj_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")
5735: 
5736:         *-- ===================================================================
5737:         *-- COMMANDGROUP obj_4c_CmdgFigCam (cmdgFigCam: top=232, left=482, 40x40, 1 botao)
5738:         *-- Capturar da camera
5739:         *-- ===================================================================
5740:         loc_oPg.AddObject("obj_4c_CmdgFigCam", "CommandGroup")
5741:         WITH loc_oPg.obj_4c_CmdgFigCam
5742:             .ButtonCount = 1
5743:             .BorderStyle = 0
5744:             .Top         = 232
5745:             .Left        = 482
5746:             .Width       = 40
5747:             .Height      = 40
5748:             .Themes      = .F.
5749:             .Visible     = .T.
5750:         ENDWITH
5751:         WITH loc_oPg.obj_4c_CmdgFigCam
5752:             .Buttons(1).Top           = 0
5753:             .Buttons(1).Left          = 0
5754:             .Buttons(1).Height        = 40
5755:             .Buttons(1).Width         = 40
5756:             .Buttons(1).Caption       = ""
5757:             .Buttons(1).Picture       = gc_4c_CaminhoIcones + "geral_camera_26.jpg"
5758:             .Buttons(1).ToolTipText   = "Capturar da C" + CHR(226) + "mera"
5759:             .Buttons(1).SpecialEffect = 0
5760:             .Buttons(1).BackColor     = RGB(255, 255, 255)
5761:             .Buttons(1).Themes        = .F.
5762:         ENDWITH
5763:         BINDEVENT(loc_oPg.obj_4c_CmdgFigCam, "Click", THIS, "CmdgFigCamClick")
5764: 
5765:         *-- ===================================================================
5766:         *-- LABEL lbl_4c_Label1 "Descricao :" (Say1: top=474, left=527, w=67, h=17)
5767:         *-- TEXTBOX txt_4c_Desc (Get_Desc: top=471, left=595, w=395, h=23)
5768:         *-- EDITBOX obj_4c_GetObs (Get_Obs: top=497, left=527, w=463, h=122)
5769:         *-- ===================================================================
5770:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
5771:         WITH loc_oPg.lbl_4c_Label1
5772:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
5773:             .Top       = 474
5774:             .Left      = 527
5775:             .Width     = 67
5776:             .Height    = 17
5777:             .BackStyle = 0
5778:             .ForeColor = RGB(90, 90, 90)
5779:             .FontName  = "Tahoma"
5780:             .FontSize  = 8
5781:             .Visible   = .T.
5782:         ENDWITH
5783: 
5784:         loc_oPg.AddObject("txt_4c_Desc", "TextBox")
5785:         WITH loc_oPg.txt_4c_Desc
5786:             .Top           = 471
5787:             .Left          = 595
5788:             .Width         = 395
5789:             .Height        = 23
5790:             .FontName      = "Tahoma"
5791:             .FontSize      = 8
5792:             .SpecialEffect = 1
5793:             .Themes        = .F.
5794:             .ReadOnly      = .F.
5795:             .Value         = ""
5796:             .Visible       = .T.
5797:         ENDWITH
5798: 
5799:         loc_oPg.AddObject("obj_4c_GetObs", "EditBox")
5800:         WITH loc_oPg.obj_4c_GetObs
5801:             .Top           = 497
5802:             .Left          = 527
5803:             .Width         = 463

*-- Linhas 5856 a 6005:
5856:             .Movable   = .F.
5857:             .Resizable = .F.
5858:         ENDWITH
5859: 
5860:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
5861:         loc_oGrd2.RecordSource = "cursor_4c_Matrizes"
5862: 
5863:         *-- ControlSource APOS RecordSource
5864:         loc_oGrd2.Column1.ControlSource = "cursor_4c_Matrizes.CMats"
5865:         loc_oGrd2.Column2.ControlSource = "cursor_4c_Matrizes.Locals"
5866:         loc_oGrd2.Column3.ControlSource = "cursor_4c_Matrizes.QMatz"
5867: 
5868:         *-- Cabecalhos APOS RecordSource
5869:         loc_oGrd2.Column1.Header1.Caption = "Matriz"
5870:         loc_oGrd2.Column2.Header1.Caption = "Local"
5871:         loc_oGrd2.Column3.Header1.Caption = "Qtde"
5872: 
5873:         *-- Larguras re-aplicadas APOS RecordSource
5874:         loc_oGrd2.Column1.Width = 80
5875:         loc_oGrd2.Column2.Width = 116
5876:         loc_oGrd2.Column3.Width = 50
5877: 
5878:         *-- BINDEVENT grd_4c_Matrizes
5879:         BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
5880:         BINDEVENT(loc_oGrd2.Column1.Text1, "Valid", THIS, "MatrizGrdCol1Valid")
5881: 
5882:         *-- ===================================================================
5883:         *-- COMMANDBUTTON cmd_4c_BtnInsereMtx (btnInsereMtx: top=380, left=258, 30x30)
5884:         *-- ===================================================================
5885:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
5886:         WITH loc_oPg.cmd_4c_BtnInsereMtx
5887:             .Top             = 380
5888:             .Left            = 258
5889:             .Width           = 30
5890:             .Height          = 30
5891:             .Caption         = ""
5892:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
5893:             .PicturePosition = 13
5894:             .ToolTipText     = "Inserir Matriz"
5895:             .FontName        = "Tahoma"
5896:             .FontSize        = 8
5897:             .Themes          = .F.
5898:             .SpecialEffect   = 0
5899:             .BackColor       = RGB(255, 255, 255)
5900:             .Visible         = .T.
5901:         ENDWITH
5902:         BINDEVENT(loc_oPg.cmd_4c_BtnInsereMtx, "Click", THIS, "BtnInsereMtxClick")
5903: 
5904:         *-- COMMANDBUTTON cmd_4c_BtnExcluiMtz (btnExcluiMtz: top=420, left=258, 30x30)
5905:         loc_oPg.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
5906:         WITH loc_oPg.cmd_4c_BtnExcluiMtz
5907:             .Top             = 420
5908:             .Left            = 258
5909:             .Width           = 30
5910:             .Height          = 30
5911:             .Caption         = ""
5912:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
5913:             .PicturePosition = 13
5914:             .ToolTipText     = "Excluir Matriz"
5915:             .FontName        = "Tahoma"
5916:             .FontSize        = 8
5917:             .Themes          = .F.
5918:             .SpecialEffect   = 0
5919:             .BackColor       = RGB(255, 255, 255)
5920:             .Visible         = .T.
5921:         ENDWITH
5922:         BINDEVENT(loc_oPg.cmd_4c_BtnExcluiMtz, "Click", THIS, "BtnExcluiMtzClick")
5923: 
5924:         *-- ===================================================================
5925:         *-- SHAPE shp_4c_ShpBorracha (shpBorracha: top=464, left=258, w=236, h=156)
5926:         *-- IMAGE img_4c_ImgBorracha (ImgBorracha: top=465, left=260, w=232, h=154)
5927:         *-- ===================================================================
5928:         loc_oPg.AddObject("shp_4c_ShpBorracha", "Shape")
5929:         WITH loc_oPg.shp_4c_ShpBorracha
5930:             .Top         = 464
5931:             .Left        = 258
5932:             .Width       = 236
5933:             .Height      = 156
5934:             .BackColor   = RGB(240, 240, 240)
5935:             .BorderColor = RGB(128, 128, 128)
5936:             .BorderWidth = 1
5937:             .Visible     = .T.
5938:         ENDWITH
5939: 
5940:         loc_oPg.AddObject("img_4c_ImgBorracha", "Image")
5941:         WITH loc_oPg.img_4c_ImgBorracha
5942:             .Top     = 465
5943:             .Left    = 260
5944:             .Width   = 232
5945:             .Height  = 154
5946:             .Stretch = 2
5947:             .Visible = .F.
5948:         ENDWITH
5949: 
5950:     ENDPROC
5951: 
5952:     *--------------------------------------------------------------------------
5953:     * ConfigurarPgpgDesigner - Aba "Designer" (Page7 do pgf_4c_Dados)
5954:     * Controles: grd_4c_Designer (4 cols tarefas), obj_4c_GetObsTarefas,
5955:     *            cmd_4c_BtnIniTarefa, cmd_4c_BtnFimTarefa,
5956:     *            grd_4c_Arquivos (1 col), cmd_4c_BtnInsArqs/OpnArqs/ExcArqs,
5957:     *            shp_4c_Shape1, img_4c_ImgArqJpg
5958:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
5959:     *--------------------------------------------------------------------------
5960:     PROTECTED PROCEDURE ConfigurarPgpgDesigner(par_oPage)
5961:         LOCAL loc_oPg, loc_oGrd, loc_oGrd2
5962: 
5963:         loc_oPg = par_oPage
5964: 
5965:         *-- ===================================================================
5966:         *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
5967:         *-- Campos na ORDEM VISUAL das colunas (sem ColumnOrder)
5968:         *-- ===================================================================
5969: 
5970:         *-- cursor_4c_Tarefas - tarefas do designer (baseado em crSigPrTar)
5971:         *-- Ordem visual: DtInis | DtFims | Usuars | Tarefas
5972:         IF USED("cursor_4c_Tarefas")
5973:             USE IN cursor_4c_Tarefas
5974:         ENDIF
5975:         SET NULL OFF
5976:         CREATE CURSOR cursor_4c_Tarefas ( ;
5977:             DtInis      T, ;
5978:             DtFims      T, ;
5979:             Usuars      C(10), ;
5980:             Tarefas     C(10), ;
5981:             ObsTarefas  M, ;
5982:             CPros       C(14), ;
5983:             pkChaves    C(30))
5984: 
5985:         *-- cursor_4c_Arquivos - arquivos do designer (baseado em crSigPrArq)
5986:         IF USED("cursor_4c_Arquivos")
5987:             USE IN cursor_4c_Arquivos
5988:         ENDIF
5989:         SET NULL OFF
5990:         CREATE CURSOR cursor_4c_Arquivos ( ;
5991:             Arquivos    C(254), ;
5992:             CPros       C(14), ;
5993:             pkChaves    C(30))
5994: 
5995:         *-- ===================================================================
5996:         *-- GRID grd_4c_Designer (grdDesigner: top=160, left=10, w=495, h=238, 4 cols)
5997:         *-- crSigPrTar: DtInis T | DtFims T | Usuars C(10) | Tarefas C(10)
5998:         *-- ===================================================================
5999:         loc_oPg.AddObject("grd_4c_Designer", "Grid")
6000:         loc_oGrd = loc_oPg.grd_4c_Designer
6001:         WITH loc_oGrd
6002:             .Top         = 160
6003:             .Left        = 10
6004:             .Width       = 495
6005:             .Height      = 238

*-- Linhas 6044 a 7358:
6044:             .Resizable = .F.
6045:             .Sparse    = .F.
6046:         ENDWITH
6047: 
6048:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
6049:         loc_oGrd.RecordSource = "cursor_4c_Tarefas"
6050: 
6051:         *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
6052:         loc_oGrd.Column1.ControlSource = "cursor_4c_Tarefas.DtInis"
6053:         loc_oGrd.Column2.ControlSource = "cursor_4c_Tarefas.DtFims"
6054:         loc_oGrd.Column3.ControlSource = "cursor_4c_Tarefas.Usuars"
6055:         loc_oGrd.Column4.ControlSource = "cursor_4c_Tarefas.Tarefas"
6056: 
6057:         *-- Cabecalhos APOS RecordSource
6058:         loc_oGrd.Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
6059:         loc_oGrd.Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"
6060:         loc_oGrd.Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
6061:         loc_oGrd.Column4.Header1.Caption = "Tarefa"
6062: 
6063:         *-- Larguras re-aplicadas APOS RecordSource
6064:         loc_oGrd.Column1.Width = 120
6065:         loc_oGrd.Column2.Width = 120
6066:         loc_oGrd.Column3.Width = 100
6067:         loc_oGrd.Column4.Width = 155
6068: 
6069:         *-- BINDEVENT grd_4c_Designer
6070:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")
6071:         BINDEVENT(loc_oGrd.Column4.Text1, "Valid", THIS, "DesignerCol4Valid")
6072: 
6073:         *-- ===================================================================
6074:         *-- LABEL lbl_4c_Say31 ("Observacao da Tarefa": top=144, left=583)
6075:         *-- ===================================================================
6076:         loc_oPg.AddObject("lbl_4c_Say31", "Label")
6077:         WITH loc_oPg.lbl_4c_Say31
6078:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
6079:             .Top       = 144
6080:             .Left      = 583
6081:             .Width     = 120
6082:             .Height    = 15
6083:             .BackStyle = 0
6084:             .ForeColor = RGB(90, 90, 90)
6085:             .FontName  = "Tahoma"
6086:             .FontSize  = 8
6087:             .Visible   = .T.
6088:         ENDWITH
6089: 
6090:         *-- ===================================================================
6091:         *-- EDITBOX obj_4c_GetObsTarefas (getObsTarefas: top=160, left=584, w=407, h=238)
6092:         *-- When: InList(pcEscolha, INSERIR, ALTERAR) -> editavel so em modo edicao
6093:         *-- ===================================================================
6094:         loc_oPg.AddObject("obj_4c_GetObsTarefas", "EditBox")
6095:         WITH loc_oPg.obj_4c_GetObsTarefas
6096:             .Value         = ""
6097:             .Top           = 160
6098:             .Left          = 584
6099:             .Width         = 407
6100:             .Height        = 238
6101:             .FontName      = "Tahoma"
6102:             .FontSize      = 8
6103:             .ScrollBars    = 2
6104:             .ReadOnly      = .F.
6105:             .Themes        = .F.
6106:             .ControlSource = "cursor_4c_Tarefas.ObsTarefas"
6107:             .Visible       = .T.
6108:         ENDWITH
6109: 
6110:         *-- ===================================================================
6111:         *-- COMMANDBUTTON cmd_4c_BtnIniTarefa (btnIniTarefa: top=161, left=509, w=42, h=42)
6112:         *-- When: InList(pcEscolha, INSERIR, ALTERAR)
6113:         *-- Click: Valida tarefa aberta + insere nova linha em cursor_4c_Tarefas
6114:         *-- ===================================================================
6115:         loc_oPg.AddObject("cmd_4c_BtnIniTarefa", "CommandButton")
6116:         WITH loc_oPg.cmd_4c_BtnIniTarefa
6117:             .Top             = 161
6118:             .Left            = 509
6119:             .Width           = 42
6120:             .Height          = 42
6121:             .Caption         = ""
6122:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
6123:             .PicturePosition = 13
6124:             .ToolTipText     = "Iniciar Tarefa"
6125:             .FontName        = "Tahoma"
6126:             .FontSize        = 8
6127:             .Themes          = .F.
6128:             .SpecialEffect   = 0
6129:             .BackColor       = RGB(255, 255, 255)
6130:             .Visible         = .T.
6131:         ENDWITH
6132:         BINDEVENT(loc_oPg.cmd_4c_BtnIniTarefa, "Click", THIS, "BtnIniTarefaClick")
6133: 
6134:         *-- ===================================================================
6135:         *-- COMMANDBUTTON cmd_4c_BtnFimTarefa (btnFimTarefa: top=203, left=509, w=42, h=42)
6136:         *-- When: InList(pcEscolha, INSERIR, ALTERAR)
6137:         *-- Click: Valida pertencimento + registra DtFims
6138:         *-- ===================================================================
6139:         loc_oPg.AddObject("cmd_4c_BtnFimTarefa", "CommandButton")
6140:         WITH loc_oPg.cmd_4c_BtnFimTarefa
6141:             .Top             = 203
6142:             .Left            = 509
6143:             .Width           = 42
6144:             .Height          = 42
6145:             .Caption         = ""
6146:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
6147:             .PicturePosition = 13
6148:             .ToolTipText     = "Finalizar Tarefa"
6149:             .FontName        = "Tahoma"
6150:             .FontSize        = 8
6151:             .Themes          = .F.
6152:             .SpecialEffect   = 0
6153:             .BackColor       = RGB(255, 255, 255)
6154:             .Visible         = .T.
6155:         ENDWITH
6156:         BINDEVENT(loc_oPg.cmd_4c_BtnFimTarefa, "Click", THIS, "BtnFimTarefaClick")
6157: 
6158:         *-- ===================================================================
6159:         *-- GRID grd_4c_Arquivos (grdArquivos: top=415, left=10, w=495, h=202, 1 col)
6160:         *-- crSigPrArq: Arquivos C(254)
6161:         *-- ===================================================================
6162:         loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
6163:         loc_oGrd2 = loc_oPg.grd_4c_Arquivos
6164:         WITH loc_oGrd2
6165:             .Top         = 415
6166:             .Left        = 10
6167:             .Width       = 495
6168:             .Height      = 202
6169:             .FontName    = "Tahoma"
6170:             .FontSize    = 8
6171:             .RecordMark  = .F.
6172:             .DeleteMark  = .F.
6173:             .GridLines   = 3
6174:             .ReadOnly    = .F.
6175:             .RowHeight   = 17
6176:             .ScrollBars  = 2
6177:             .Themes      = .F.
6178:             .ColumnCount = 1
6179:             .Visible     = .T.
6180:         ENDWITH
6181: 
6182:         *-- Col1: Arquivos (495px, editavel)
6183:         WITH loc_oGrd2.Column1
6184:             .Width     = 495
6185:             .Movable   = .F.
6186:             .Resizable = .F.
6187:             .Sparse    = .F.
6188:         ENDWITH
6189: 
6190:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
6191:         loc_oGrd2.RecordSource = "cursor_4c_Arquivos"
6192: 
6193:         *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
6194:         loc_oGrd2.Column1.ControlSource = "cursor_4c_Arquivos.Arquivos"
6195: 
6196:         *-- Cabecalho APOS RecordSource
6197:         loc_oGrd2.Column1.Header1.Caption = "Arquivos Para Designer"
6198: 
6199:         *-- Largura re-aplicada APOS RecordSource
6200:         loc_oGrd2.Column1.Width = 495
6201: 
6202:         *-- BINDEVENT grd_4c_Arquivos
6203:         BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")
6204: 
6205:         *-- ===================================================================
6206:         *-- COMMANDBUTTON cmd_4c_BtnInsArqs (btnInsArqs: top=416, left=509, w=42, h=42)
6207:         *-- When: InList(pcEscolha, INSERIR, ALTERAR)
6208:         *-- Click: GetFile -> Insert Into cursor_4c_Arquivos
6209:         *-- ===================================================================
6210:         loc_oPg.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
6211:         WITH loc_oPg.cmd_4c_BtnInsArqs
6212:             .Top             = 416
6213:             .Left            = 509
6214:             .Width           = 42
6215:             .Height          = 42
6216:             .Caption         = ""
6217:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
6218:             .PicturePosition = 13
6219:             .ToolTipText     = "Inserir Arquivo"
6220:             .FontName        = "Tahoma"
6221:             .FontSize        = 8
6222:             .Themes          = .F.
6223:             .SpecialEffect   = 0
6224:             .BackColor       = RGB(255, 255, 255)
6225:             .Visible         = .T.
6226:         ENDWITH
6227:         BINDEVENT(loc_oPg.cmd_4c_BtnInsArqs, "Click", THIS, "BtnInsArqsClick")
6228: 
6229:         *-- ===================================================================
6230:         *-- COMMANDBUTTON cmd_4c_BtnExcArqs (btnExcArqs: top=458, left=509, w=42, h=42)
6231:         *-- When: InList(pcEscolha, INSERIR, ALTERAR)
6232:         *-- Click: Delete from cursor_4c_Arquivos
6233:         *-- ===================================================================
6234:         loc_oPg.AddObject("cmd_4c_BtnExcArqs", "CommandButton")
6235:         WITH loc_oPg.cmd_4c_BtnExcArqs
6236:             .Top             = 458
6237:             .Left            = 509
6238:             .Width           = 42
6239:             .Height          = 42
6240:             .Caption         = ""
6241:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
6242:             .PicturePosition = 13
6243:             .ToolTipText     = "Excluir Arquivo"
6244:             .FontName        = "Tahoma"
6245:             .FontSize        = 8
6246:             .Themes          = .F.
6247:             .SpecialEffect   = 0
6248:             .BackColor       = RGB(255, 255, 255)
6249:             .Visible         = .T.
6250:         ENDWITH
6251:         BINDEVENT(loc_oPg.cmd_4c_BtnExcArqs, "Click", THIS, "BtnExcArqsClick")
6252: 
6253:         *-- ===================================================================
6254:         *-- COMMANDBUTTON cmd_4c_BtnOpnArqs (btnOpnArqs: top=500, left=509, w=42, h=42)
6255:         *-- When: sempre habilitado (.T.)
6256:         *-- Click: Shell.Application.Open(arquivo)
6257:         *-- ===================================================================
6258:         loc_oPg.AddObject("cmd_4c_BtnOpnArqs", "CommandButton")
6259:         WITH loc_oPg.cmd_4c_BtnOpnArqs
6260:             .Top             = 500
6261:             .Left            = 509
6262:             .Width           = 42
6263:             .Height          = 42
6264:             .Caption         = ""
6265:             .Picture         = gc_4c_CaminhoIcones + "relatorio_visualizar_26.jpg"
6266:             .PicturePosition = 13
6267:             .ToolTipText     = "Abrir Arquivo"
6268:             .FontName        = "Tahoma"
6269:             .FontSize        = 8
6270:             .Themes          = .F.
6271:             .SpecialEffect   = 0
6272:             .BackColor       = RGB(255, 255, 255)
6273:             .Visible         = .T.
6274:         ENDWITH
6275:         BINDEVENT(loc_oPg.cmd_4c_BtnOpnArqs, "Click", THIS, "BtnOpnArqsClick")
6276: 
6277:         *-- ===================================================================
6278:         *-- SHAPE shp_4c_Shape1 (Shape1: top=415, left=584, w=407, h=202)
6279:         *-- Borda visual ao redor da area de preview de imagem
6280:         *-- ===================================================================
6281:         loc_oPg.AddObject("shp_4c_Shape1", "Shape")
6282:         WITH loc_oPg.shp_4c_Shape1
6283:             .Top         = 415
6284:             .Left        = 584
6285:             .Width       = 407
6286:             .Height      = 202
6287:             .BorderColor = RGB(128, 128, 128)
6288:             .BorderWidth = 1
6289:             .BackStyle   = 0
6290:             .Visible     = .T.
6291:         ENDWITH
6292: 
6293:         *-- ===================================================================
6294:         *-- IMAGE img_4c_ImgArqJpg (imgArqJpg: top=417, left=586, w=403, h=198)
6295:         *-- Visible=.F. por padrao; exibida ao selecionar arquivo JPG/ICO/BMP/JPEG
6296:         *-- Click: Do Form SigOpZom (zoom do arquivo)
6297:         *-- ===================================================================
6298:         loc_oPg.AddObject("img_4c_ImgArqJpg", "Image")
6299:         WITH loc_oPg.img_4c_ImgArqJpg
6300:             .Top     = 417
6301:             .Left    = 586
6302:             .Width   = 403
6303:             .Height  = 198
6304:             .Stretch = 2
6305:             .Visible = .F.
6306:         ENDWITH
6307:         BINDEVENT(loc_oPg.img_4c_ImgArqJpg, "Click", THIS, "ImgArqJpgClick")
6308: 
6309:     ENDPROC
6310: 
6311:     *--------------------------------------------------------------------------
6312:     * GrdDesignerAfterRowColChange - Handler AfterRowColChange do grd_4c_Designer
6313:     * Atualiza exibicao da observacao da tarefa selecionada
6314:     *--------------------------------------------------------------------------
6315:     PROCEDURE GrdDesignerAfterRowColChange(par_nColIndex)
6316:         LOCAL loc_oPg
6317:         TRY
6318:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
6319:             IF PEMSTATUS(loc_oPg, "obj_4c_GetObsTarefas", 5)
6320:                 loc_oPg.obj_4c_GetObsTarefas.Refresh()
6321:             ENDIF
6322:         CATCH TO loc_oErro
6323:             MsgErro(loc_oErro.Message, "Erro")
6324:         ENDTRY
6325:     ENDPROC
6326: 
6327:     *--------------------------------------------------------------------------
6328:     * DesignerCol4Valid - Valid do Column4 (Tarefa) do grd_4c_Designer
6329:     * Lookup: SigCdCad (CodCads, DesCads) - catalogo de tarefas designer
6330:     *--------------------------------------------------------------------------
6331:     PROCEDURE DesignerCol4Valid(par_nColIndex)
6332:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
6333:         loc_lResultado = .T.
6334:         TRY
6335:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer
6336:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column4.Text1.Value, ""))
6337:             IF EMPTY(loc_cCodigo)
6338:                 loc_lResultado = loc_lResultado
6339:             ENDIF
6340:             loc_lcSQL = "SELECT CodCads, DesCads FROM SigCdCad WHERE CodCads = " + EscaparSQL(loc_cCodigo)
6341:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTarefas") <= 0 OR EOF("cursor_4c_ValTarefas")
6342:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6343:                 loc_oLookup.mAddColuna("CodCads", "", "C" + CHR(243) + "digo")
6344:                 loc_oLookup.mAddColuna("DesCads", "", "Descri" + CHR(231) + CHR(227) + "o")
6345:                 loc_oLookup.cTabela     = "SigCdCad"
6346:                 loc_oLookup.cCampoChave = "CodCads"
6347:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6348:                 loc_oLookup.Show()
6349:                 IF loc_oLookup.this_lSelecionou
6350:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6351:                 ELSE
6352:                     loc_cCodigo = ""
6353:                 ENDIF
6354:             ENDIF
6355:             IF USED("cursor_4c_ValTarefas")
6356:                 USE IN cursor_4c_ValTarefas
6357:             ENDIF
6358:             IF USED("cursor_4c_Tarefas") AND !EOF("cursor_4c_Tarefas")
6359:                 SELECT cursor_4c_Tarefas
6360:                 REPLACE Tarefas WITH PADR(loc_cCodigo, 10) IN cursor_4c_Tarefas
6361:                 loc_oGrd.Column4.Text1.Value = loc_cCodigo
6362:             ENDIF
6363:         CATCH TO loc_oErro
6364:             MsgErro(loc_oErro.Message, "Erro")
6365:         ENDTRY
6366:         RETURN loc_lResultado
6367:     ENDPROC
6368: 
6369:     *--------------------------------------------------------------------------
6370:     * GrdArquivosAfterRowColChange - Handler AfterRowColChange do grd_4c_Arquivos
6371:     * Exibe preview de imagem se arquivo for JPG/ICO/BMP/JPEG
6372:     *--------------------------------------------------------------------------
6373:     PROCEDURE GrdArquivosAfterRowColChange(par_nColIndex)
6374:         LOCAL loc_lcArq, loc_oPg, loc_nPonto
6375:         TRY
6376:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
6377:             CLEAR RESOURCES
6378:             loc_oPg.img_4c_ImgArqJpg.Picture = ""
6379:             loc_oPg.img_4c_ImgArqJpg.Visible = .F.
6380:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
6381:                 RETURN
6382:             ENDIF
6383:             loc_lcArq  = ALLTRIM(cursor_4c_Arquivos.Arquivos)
6384:             loc_nPonto = AT(".", loc_lcArq)
6385:             IF !EMPTY(loc_lcArq) AND loc_nPonto > 0 AND ;
6386:                 INLIST(ALLTRIM(UPPER(SUBSTR(loc_lcArq, loc_nPonto, 5))), ".JPG", ".ICO", ".BMP", ".JPEG")
6387:                 loc_oPg.img_4c_ImgArqJpg.Picture = loc_lcArq
6388:                 loc_oPg.img_4c_ImgArqJpg.Visible = .T.
6389:             ENDIF
6390:         CATCH TO loc_oErro
6391:             MsgErro(loc_oErro.Message, "Erro")
6392:         ENDTRY
6393:     ENDPROC
6394: 
6395:     *--------------------------------------------------------------------------
6396:     * BtnIniTarefaClick - Inicia nova tarefa no grd_4c_Designer
6397:     * Valida: sem tarefa aberta para o usuario + sem tarefa sem codigo
6398:     *--------------------------------------------------------------------------
6399:     PROCEDURE BtnIniTarefaClick()
6400:         LOCAL loc_lResultado, loc_oGrd, loc_tDataHora
6401:         loc_lResultado = .F.
6402:         TRY
6403:             IF !USED("cursor_4c_Tarefas")
6404:                 loc_lResultado = loc_lResultado
6405:             ENDIF
6406:             loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer
6407: 
6408:             *-- Validar: nao pode ter tarefa aberta (DtFims vazia) para este usuario
6409:             SELECT cursor_4c_Tarefas
6410:             GO TOP IN cursor_4c_Tarefas
6411:             LOCATE FOR ALLTRIM(Usuars) = ALLTRIM(gc_4c_UsuarioLogado) AND EMPTY(DtFims)
6412:             IF !EOF("cursor_4c_Tarefas")
6413:                 MsgAviso("Existe Uma Tarefa N" + CHR(227) + "o Encerrada Para Esse Usu" + CHR(225) + "rio!!!")
6414:                 loc_oGrd.Column4.SetFocus()
6415:                 loc_lResultado = loc_lResultado
6416:             ENDIF
6417: 
6418:             *-- Validar: nao pode ter tarefa com codigo vazio para este usuario
6419:             SELECT cursor_4c_Tarefas
6420:             GO TOP IN cursor_4c_Tarefas
6421:             LOCATE FOR ALLTRIM(Usuars) = ALLTRIM(gc_4c_UsuarioLogado) AND EMPTY(Tarefas)
6422:             IF !EOF("cursor_4c_Tarefas")
6423:                 MsgAviso("Existe Uma Tarefa Ainda N" + CHR(227) + "o Informada!!!")
6424:                 loc_oGrd.Column4.SetFocus()
6425:                 loc_lResultado = loc_lResultado
6426:             ENDIF
6427: 
6428:             *-- Inserir nova linha com DtInis = agora, DtFims = vazio ({})
6429:             loc_tDataHora = DATETIME()
6430:             INSERT INTO cursor_4c_Tarefas (DtInis, DtFims, Usuars, Tarefas, CPros, pkChaves) ;
6431:                 VALUES (loc_tDataHora, {}, ;
6432:                         PADR(gc_4c_UsuarioLogado, 10), PADR("", 10), ;
6433:                         PADR(THIS.this_oBusinessObject.this_cCpros, 14), "")
6434: 
6435:             SELECT cursor_4c_Tarefas
6436:             GO BOTTOM IN cursor_4c_Tarefas
6437:             loc_oGrd.Refresh()
6438:             loc_oGrd.Column4.SetFocus()
6439:             loc_lResultado = .T.
6440:         CATCH TO loc_oErro
6441:             MsgErro(loc_oErro.Message, "Erro")
6442:         ENDTRY
6443:         RETURN loc_lResultado
6444:     ENDPROC
6445: 
6446:     *--------------------------------------------------------------------------
6447:     * BtnFimTarefaClick - Finaliza tarefa corrente no grd_4c_Designer
6448:     * Valida: tarefa pertence ao usuario + nao esta ja finalizada
6449:     *--------------------------------------------------------------------------
6450:     PROCEDURE BtnFimTarefaClick()
6451:         LOCAL loc_lResultado, loc_oGrd, loc_tDataHora
6452:         loc_lResultado = .F.
6453:         TRY
6454:             IF !USED("cursor_4c_Tarefas") OR EOF("cursor_4c_Tarefas") OR BOF("cursor_4c_Tarefas")
6455:                 loc_lResultado = loc_lResultado
6456:             ENDIF
6457:             loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer
6458: 
6459:             *-- Validar: tarefa deve pertencer ao usuario logado
6460:             IF ALLTRIM(cursor_4c_Tarefas.Usuars) <> ALLTRIM(gc_4c_UsuarioLogado)
6461:                 MsgAviso("Essa Tarefa N" + CHR(227) + "o Pertence a Esse Usu" + CHR(225) + "rio!!!")
6462:                 loc_oGrd.Column4.SetFocus()
6463:                 loc_lResultado = loc_lResultado
6464:             ENDIF
6465: 
6466:             *-- Validar: tarefa nao pode estar ja finalizada
6467:             IF !EMPTY(cursor_4c_Tarefas.DtFims)
6468:                 MsgAviso("Essa Tarefa J" + CHR(225) + " Se Encontra Finalizada!!!")
6469:                 loc_oGrd.Column4.SetFocus()
6470:                 loc_lResultado = loc_lResultado
6471:             ENDIF
6472: 
6473:             *-- Registrar data/hora de finalizacao
6474:             loc_tDataHora = DATETIME()
6475:             SELECT cursor_4c_Tarefas
6476:             REPLACE DtFims WITH loc_tDataHora IN cursor_4c_Tarefas
6477: 
6478:             loc_oGrd.Refresh()
6479:             loc_lResultado = .T.
6480:         CATCH TO loc_oErro
6481:             MsgErro(loc_oErro.Message, "Erro")
6482:         ENDTRY
6483:         RETURN loc_lResultado
6484:     ENDPROC
6485: 
6486:     *--------------------------------------------------------------------------
6487:     * BtnInsArqsClick - Insere arquivo no grd_4c_Arquivos via dialog GetFile
6488:     *--------------------------------------------------------------------------
6489:     PROCEDURE BtnInsArqsClick()
6490:         LOCAL loc_lResultado, loc_lcArq, loc_oGrd
6491:         loc_lResultado = .F.
6492:         TRY
6493:             loc_oGrd  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos
6494:             loc_lcArq = GETFILE("", "Selecione o Arquivo", "Selecione o Arquivo", 0, ;
6495:                 "Sele" + CHR(231) + CHR(227) + "o de Arquivos")
6496:             IF !EMPTY(loc_lcArq)
6497:                 INSERT INTO cursor_4c_Arquivos (CPros, pkChaves, Arquivos) ;
6498:                     VALUES (PADR(THIS.this_oBusinessObject.this_cCpros, 14), "", UPPER(loc_lcArq))
6499:                 loc_oGrd.Refresh()
6500:             ENDIF
6501:             loc_lResultado = .T.
6502:         CATCH TO loc_oErro
6503:             MsgErro(loc_oErro.Message, "Erro")
6504:         ENDTRY
6505:         RETURN loc_lResultado
6506:     ENDPROC
6507: 
6508:     *--------------------------------------------------------------------------
6509:     * BtnOpnArqsClick - Abre arquivo selecionado no grd_4c_Arquivos com Shell
6510:     *--------------------------------------------------------------------------
6511:     PROCEDURE BtnOpnArqsClick()
6512:         LOCAL loc_lResultado, loc_lcArq, loc_oApp
6513:         loc_lResultado = .F.
6514:         TRY
6515:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
6516:                 loc_lResultado = loc_lResultado
6517:             ENDIF
6518:             loc_lcArq = ALLTRIM(cursor_4c_Arquivos.Arquivos)
6519:             IF !EMPTY(loc_lcArq) AND FILE(loc_lcArq)
6520:                 loc_oApp = CREATEOBJECT("Shell.Application")
6521:                 loc_oApp.Open(loc_lcArq)
6522:                 loc_lResultado = .T.
6523:             ELSE
6524:                 MsgAviso("Arquivo N" + CHR(227) + "o Encontrado!!!")
6525:             ENDIF
6526:         CATCH TO loc_oErro
6527:             MsgErro(loc_oErro.Message, "Erro")
6528:         ENDTRY
6529:         RETURN loc_lResultado
6530:     ENDPROC
6531: 
6532:     *--------------------------------------------------------------------------
6533:     * BtnExcArqsClick - Exclui arquivo selecionado do grd_4c_Arquivos
6534:     *--------------------------------------------------------------------------
6535:     PROCEDURE BtnExcArqsClick()
6536:         LOCAL loc_lResultado, loc_oGrd
6537:         loc_lResultado = .F.
6538:         TRY
6539:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos") OR BOF("cursor_4c_Arquivos")
6540:                 loc_lResultado = loc_lResultado
6541:             ENDIF
6542:             loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos
6543:             IF !EMPTY(cursor_4c_Arquivos.Arquivos)
6544:                 SELECT cursor_4c_Arquivos
6545:                 DELETE IN cursor_4c_Arquivos
6546:                 IF !EOF("cursor_4c_Arquivos")
6547:                     SKIP IN cursor_4c_Arquivos
6548:                 ENDIF
6549:                 IF EOF("cursor_4c_Arquivos")
6550:                     GO BOTTOM IN cursor_4c_Arquivos
6551:                 ENDIF
6552:                 PACK IN cursor_4c_Arquivos
6553:             ENDIF
6554:             loc_oGrd.Refresh()
6555:             loc_lResultado = .T.
6556:         CATCH TO loc_oErro
6557:             MsgErro(loc_oErro.Message, "Erro")
6558:         ENDTRY
6559:         RETURN loc_lResultado
6560:     ENDPROC
6561: 
6562:     *--------------------------------------------------------------------------
6563:     * ImgArqJpgClick - Abre visualizador de imagem em tela cheia (SigOpZom)
6564:     *--------------------------------------------------------------------------
6565:     PROCEDURE ImgArqJpgClick()
6566:         LOCAL loc_lResultado, loc_lcArq, loc_nPonto
6567:         loc_lResultado = .F.
6568:         TRY
6569:             IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
6570:                 loc_lResultado = loc_lResultado
6571:             ENDIF
6572:             loc_lcArq  = ALLTRIM(cursor_4c_Arquivos.Arquivos)
6573:             loc_nPonto = AT(".", loc_lcArq)
6574:             IF !EMPTY(loc_lcArq) AND FILE(loc_lcArq) AND loc_nPonto > 0 AND ;
6575:                 INLIST(ALLTRIM(UPPER(SUBSTR(loc_lcArq, loc_nPonto, 5))), ".JPG", ".ICO", ".BMP", ".JPEG")
6576:                 DO FORM SigOpZom WITH loc_lcArq, "Arquivo : " + loc_lcArq
6577:             ENDIF
6578:             loc_lResultado = .T.
6579:         CATCH TO loc_oErro
6580:             MsgErro(loc_oErro.Message, "Erro")
6581:         ENDTRY
6582:         RETURN loc_lResultado
6583:     ENDPROC
6584: 
6585:     *--------------------------------------------------------------------------
6586:     * GrdConsAfterRowColChange - Handler AfterRowColChange do grd_4c_GrdCons
6587:     *--------------------------------------------------------------------------
6588:     PROCEDURE GrdConsAfterRowColChange(par_nColIndex)
6589:         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
6590:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
6591:         ENDIF
6592:     ENDPROC
6593: 
6594:     *--------------------------------------------------------------------------
6595:     * GrdFaseAfterRowColChange - Handler AfterRowColChange do grd_4c_FasePro
6596:     * Carrega imagem FigProcs do campo memo na img_4c_ImgFigJpg
6597:     *--------------------------------------------------------------------------
6598:     PROCEDURE GrdFaseAfterRowColChange(par_nColIndex)
6599:         LOCAL loc_oPage, loc_lcArquivo
6600:         TRY
6601:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6602:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6603:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6604:                 CLEAR RESOURCES
6605:                 loc_oPage.img_4c_ImgFigJpg.Picture = ""
6606:                 loc_oPage.img_4c_ImgFigJpg.Visible = .F.
6607:                 IF !EMPTY(cursor_4c_Fase.FigProcs) AND !ISNULL(cursor_4c_Fase.FigProcs)
6608:                     IF STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo) > 0
6609:                         loc_oPage.img_4c_ImgFigJpg.Visible = .T.
6610:                         loc_oPage.img_4c_ImgFigJpg.Picture = loc_lcArquivo
6611:                     ENDIF
6612:                 ENDIF
6613:             ENDIF
6614:         CATCH TO loc_oErro
6615:             MsgErro(loc_oErro.Message, "Erro")
6616:         ENDTRY
6617:     ENDPROC
6618: 
6619:     *--------------------------------------------------------------------------
6620:     * GrdMatrizesAfterRowColChange - Handler AfterRowColChange do grd_4c_Matrizes
6621:     * Carrega imagem do produto matriz na img_4c_ImgBorracha via SQL
6622:     *--------------------------------------------------------------------------
6623:     PROCEDURE GrdMatrizesAfterRowColChange(par_nColIndex)
6624:         LOCAL loc_oPage, loc_lcArquivo, loc_lcSQL
6625:         TRY
6626:             IF USED("cursor_4c_Matrizes") AND !EOF("cursor_4c_Matrizes")
6627:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6628:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6629:                 CLEAR RESOURCES
6630:                 loc_oPage.img_4c_ImgBorracha.Picture = ""
6631:                 loc_oPage.img_4c_ImgBorracha.Visible = .F.
6632:                 IF !EMPTY(cursor_4c_Matrizes.CMats)
6633:                     loc_lcSQL = "SELECT FigProcs FROM SigCdPro WHERE CPros = '" + ;
6634:                         EscaparSQL(ALLTRIM(cursor_4c_Matrizes.CMats))
6635:                     IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_BorrachaImg") > 0
6636:                         IF !EOF("cursor_4c_BorrachaImg")
6637:                             IF !EMPTY(cursor_4c_BorrachaImg.FigProcs) AND !ISNULL(cursor_4c_BorrachaImg.FigProcs)
6638:                                 IF STRTOFILE(cursor_4c_BorrachaImg.FigProcs, loc_lcArquivo) > 0
6639:                                     loc_oPage.img_4c_ImgBorracha.Visible = .T.
6640:                                     loc_oPage.img_4c_ImgBorracha.Picture = loc_lcArquivo
6641:                                 ENDIF
6642:                             ENDIF
6643:                         ENDIF
6644:                         IF USED("cursor_4c_BorrachaImg")
6645:                             USE IN cursor_4c_BorrachaImg
6646:                         ENDIF
6647:                     ENDIF
6648:                 ENDIF
6649:                 loc_oPage.grd_4c_Matrizes.Refresh()
6650:             ENDIF
6651:         CATCH TO loc_oErro
6652:             MsgErro(loc_oErro.Message, "Erro")
6653:         ENDTRY
6654:     ENDPROC
6655: 
6656:     *--------------------------------------------------------------------------
6657:     * ImgFigJpgClick - Click na imagem -> amplia em zoom (SigOpZom)
6658:     *--------------------------------------------------------------------------
6659:     PROCEDURE ImgFigJpgClick()
6660:         LOCAL loc_lcArquivo
6661:         TRY
6662:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6663:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6664:                 IF !EMPTY(cursor_4c_Fase.FigProcs) AND !ISNULL(cursor_4c_Fase.FigProcs)
6665:                     STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo)
6666:                     IF FILE(loc_lcArquivo)
6667:                         DO FORM SigOpZom WITH loc_lcArquivo, .F.
6668:                     ENDIF
6669:                 ENDIF
6670:             ENDIF
6671:         CATCH TO loc_oErro
6672:             MsgErro(loc_oErro.Message, "Erro")
6673:         ENDTRY
6674:     ENDPROC
6675: 
6676:     *--------------------------------------------------------------------------
6677:     * CmdgFiguraClick - Seleciona foto do processo via GetPict
6678:     *--------------------------------------------------------------------------
6679:     PROCEDURE CmdgFiguraClick()
6680:         LOCAL loc_lcFigura, loc_lcArquivo, loc_oPage
6681:         TRY
6682:             IF !USED("cursor_4c_Fase") OR EOF("cursor_4c_Fase")
6683:                 RETURN
6684:             ENDIF
6685:             IF THIS.this_cModoAtual = "VISUALIZAR"
6686:                 RETURN
6687:             ENDIF
6688:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6689:             loc_oPage.grd_4c_FasePro.SetFocus()
6690:             loc_lcFigura = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Nome do Arquivo:", "Selecionar")
6691:             IF !EMPTY(loc_lcFigura)
6692:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6693:                 CLEAR RESOURCES
6694:                 SELECT cursor_4c_Fase
6695:                 REPLACE FigProcs WITH FILETOSTR(loc_lcFigura) IN cursor_4c_Fase
6696:                 IF STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo) > 0
6697:                     loc_oPage.img_4c_ImgFigJpg.Visible = .T.
6698:                     loc_oPage.img_4c_ImgFigJpg.Picture = loc_lcArquivo
6699:                 ENDIF
6700:             ENDIF
6701:         CATCH TO loc_oErro
6702:             MsgErro(loc_oErro.Message, "Erro")
6703:         ENDTRY
6704:     ENDPROC
6705: 
6706:     *--------------------------------------------------------------------------
6707:     * CmdgFigCamClick - Captura foto via camera (reutiliza logica de GetPict)
6708:     *--------------------------------------------------------------------------
6709:     PROCEDURE CmdgFigCamClick()
6710:         THIS.CmdgFiguraClick()
6711:     ENDPROC
6712: 
6713:     *--------------------------------------------------------------------------
6714:     * FaseInserirClick - Insere nova linha no grd_4c_FasePro
6715:     *--------------------------------------------------------------------------
6716:     PROCEDURE FaseInserirClick()
6717:         LOCAL loc_lResultado, loc_nOrdem, loc_oPage
6718:         loc_lResultado = .F.
6719:         TRY
6720:             IF !USED("cursor_4c_Fase")
6721:                 loc_lResultado = loc_lResultado
6722:             ENDIF
6723:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6724:             SELECT cursor_4c_Fase
6725:             IF !EOF("cursor_4c_Fase")
6726:                 IF EMPTY(cursor_4c_Fase.Grupos)
6727:                     loc_oPage.grd_4c_FasePro.SetFocus()
6728:                     loc_lResultado = loc_lResultado
6729:                 ENDIF
6730:                 loc_nOrdem = cursor_4c_Fase.Ordems
6731:             ELSE
6732:                 loc_nOrdem = 0
6733:             ENDIF
6734:             *-- Incrementa ordens dos registros apos o atual
6735:             SELECT cursor_4c_Fase
6736:             SCAN FOR Ordems > loc_nOrdem
6737:                 REPLACE Ordems WITH cursor_4c_Fase.Ordems + 1 IN cursor_4c_Fase
6738:             ENDSCAN
6739:             *-- Insere nova linha com ordem logo apos o atual
6740:             INSERT INTO cursor_4c_Fase (Ordems, Grupos, Descrs, UniPrdts, TpMats, FkChaves) ;
6741:                 VALUES (loc_nOrdem + 1, "", "", "", "", "")
6742:             GO TOP IN cursor_4c_Fase
6743:             LOCATE FOR Ordems = loc_nOrdem + 1 AND EMPTY(Grupos)
6744:             loc_oPage.grd_4c_FasePro.Refresh()
6745:             loc_oPage.grd_4c_FasePro.SetFocus()
6746:             loc_lResultado = .T.
6747:         CATCH TO loc_oErro
6748:             MsgErro(loc_oErro.Message, "Erro")
6749:         ENDTRY
6750:         RETURN loc_lResultado
6751:     ENDPROC
6752: 
6753:     *--------------------------------------------------------------------------
6754:     * FaseExcluirClick - Exclui linha atual do grd_4c_FasePro
6755:     *--------------------------------------------------------------------------
6756:     PROCEDURE FaseExcluirClick()
6757:         LOCAL loc_lResultado, loc_oPage
6758:         loc_lResultado = .F.
6759:         TRY
6760:             IF !USED("cursor_4c_Fase") OR EOF("cursor_4c_Fase") OR BOF("cursor_4c_Fase")
6761:                 loc_lResultado = loc_lResultado
6762:             ENDIF
6763:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6764:             SELECT cursor_4c_Fase
6765:             DELETE IN cursor_4c_Fase
6766:             IF !EOF("cursor_4c_Fase")
6767:                 SKIP IN cursor_4c_Fase
6768:             ENDIF
6769:             IF EOF("cursor_4c_Fase")
6770:                 GO BOTTOM IN cursor_4c_Fase
6771:             ENDIF
6772:             PACK IN cursor_4c_Fase
6773:             loc_oPage.grd_4c_FasePro.Refresh()
6774:             loc_oPage.grd_4c_FasePro.SetFocus()
6775:             loc_oPage.grd_4c_FasePro.Column2.SetFocus()
6776:             loc_lResultado = .T.
6777:         CATCH TO loc_oErro
6778:             MsgErro(loc_oErro.Message, "Erro")
6779:         ENDTRY
6780:         RETURN loc_lResultado
6781:     ENDPROC
6782: 
6783:     *--------------------------------------------------------------------------
6784:     * FaseAlternativaClick - Insere fase alternativa (mesma ordem do atual)
6785:     *--------------------------------------------------------------------------
6786:     PROCEDURE FaseAlternativaClick()
6787:         LOCAL loc_lResultado, loc_nOrdem, loc_oPage
6788:         loc_lResultado = .F.
6789:         TRY
6790:             IF !USED("cursor_4c_Fase")
6791:                 loc_lResultado = loc_lResultado
6792:             ENDIF
6793:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6794:             SELECT cursor_4c_Fase
6795:             IF EOF("cursor_4c_Fase") OR BOF("cursor_4c_Fase")
6796:                 loc_oPage.grd_4c_FasePro.SetFocus()
6797:                 loc_lResultado = loc_lResultado
6798:             ENDIF
6799:             loc_nOrdem = cursor_4c_Fase.Ordems
6800:             *-- Insere linha alternativa com mesma ordem (alternativa ao atual)
6801:             INSERT INTO cursor_4c_Fase (Ordems, Grupos, Descrs, UniPrdts, TpMats, FkChaves) ;
6802:                 VALUES (loc_nOrdem, "", "", "", "", "")
6803:             GO TOP IN cursor_4c_Fase
6804:             LOCATE FOR Ordems = loc_nOrdem AND EMPTY(Grupos)
6805:             loc_oPage.grd_4c_FasePro.Refresh()
6806:             loc_oPage.grd_4c_FasePro.SetFocus()
6807:             loc_lResultado = .T.
6808:         CATCH TO loc_oErro
6809:             MsgErro(loc_oErro.Message, "Erro")
6810:         ENDTRY
6811:         RETURN loc_lResultado
6812:     ENDPROC
6813: 
6814:     *--------------------------------------------------------------------------
6815:     * CmdFichaClick - Abre Ficha Tecnica do produto
6816:     *--------------------------------------------------------------------------
6817:     PROCEDURE CmdFichaClick()
6818:         LOCAL loc_lResultado
6819:         loc_lResultado = .F.
6820:         TRY
6821:             MsgAviso("Ficha T" + CHR(233) + "cnica n" + CHR(227) + "o dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", ;
6822:                 "Ficha T" + CHR(233) + "cnica")
6823:         CATCH TO loc_oErro
6824:             MsgErro(loc_oErro.Message, "Erro")
6825:         ENDTRY
6826:         RETURN loc_lResultado
6827:     ENDPROC
6828: 
6829:     *--------------------------------------------------------------------------
6830:     * FaseGrdCol2Valid - Valid do Column2 (Fase/Grupos) do grd_4c_FasePro
6831:     * Lookup: SigCdGcr (Codigos / Descrs)
6832:     *--------------------------------------------------------------------------
6833:     PROCEDURE FaseGrdCol2Valid(par_nColIndex)
6834:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_cDescr, loc_lcSQL
6835:         loc_lResultado = .T.
6836:         TRY
6837:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
6838:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column2.Text1.Value, ""))
6839:             IF EMPTY(loc_cCodigo)
6840:                 loc_lResultado = loc_lResultado
6841:             ENDIF
6842:             loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
6843:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGcr") <= 0 OR EOF("cursor_4c_ValGcr")
6844:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6845:                 loc_oLookup.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
6846:                 loc_oLookup.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
6847:                 loc_oLookup.cTabela     = "SigCdGcr"
6848:                 loc_oLookup.cCampoChave = "Codigos"
6849:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6850:                 loc_oLookup.Show()
6851:                 IF loc_oLookup.this_lSelecionou
6852:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6853:                     loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
6854:                     IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGcr") > 0 AND !EOF("cursor_4c_ValGcr")
6855:                         loc_cDescr = ALLTRIM(NVL(cursor_4c_ValGcr.Descrs, ""))
6856:                     ELSE
6857:                         loc_cDescr = ""
6858:                     ENDIF
6859:                 ELSE
6860:                     loc_cCodigo = ""
6861:                     loc_cDescr  = ""
6862:                 ENDIF
6863:                 IF USED("cursor_4c_ValGcr")
6864:                     USE IN cursor_4c_ValGcr
6865:                 ENDIF
6866:             ELSE
6867:                 loc_cDescr = ALLTRIM(NVL(cursor_4c_ValGcr.Descrs, ""))
6868:                 IF USED("cursor_4c_ValGcr")
6869:                     USE IN cursor_4c_ValGcr
6870:                 ENDIF
6871:             ENDIF
6872:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6873:                 SELECT cursor_4c_Fase
6874:                 REPLACE Grupos WITH PADR(loc_cCodigo, 10) IN cursor_4c_Fase
6875:                 REPLACE Descrs WITH PADR(loc_cDescr,  40) IN cursor_4c_Fase
6876:                 loc_oGrd.Column2.Text1.Value = loc_cCodigo
6877:                 loc_oGrd.Column3.Text1.Value = loc_cDescr
6878:             ENDIF
6879:         CATCH TO loc_oErro
6880:             MsgErro(loc_oErro.Message, "Erro")
6881:         ENDTRY
6882:         RETURN loc_lResultado
6883:     ENDPROC
6884: 
6885:     *--------------------------------------------------------------------------
6886:     * FaseGrdCol4Valid - Valid do Column4 (Uni. Produtiva/UniPrdts) do grd_4c_FasePro
6887:     * Lookup: SigCdUpd (UniPrdts) filtrado pelo Grupo atual
6888:     *--------------------------------------------------------------------------
6889:     PROCEDURE FaseGrdCol4Valid(par_nColIndex)
6890:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_cGrupo, loc_lcSQL
6891:         loc_lResultado = .T.
6892:         TRY
6893:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
6894:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column4.Text1.Value, ""))
6895:             IF EMPTY(loc_cCodigo)
6896:                 loc_lResultado = loc_lResultado
6897:             ENDIF
6898:             loc_cGrupo = ""
6899:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6900:                 loc_cGrupo = ALLTRIM(cursor_4c_Fase.Grupos)
6901:             ENDIF
6902:             IF !EMPTY(loc_cGrupo)
6903:                 loc_lcSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupo)
6904:             ELSE
6905:                 loc_lcSQL = "SELECT UniPrdts FROM SigCdUpd"
6906:             ENDIF
6907:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValUpd") <= 0
6908:                 IF USED("cursor_4c_ValUpd")
6909:                     USE IN cursor_4c_ValUpd
6910:                 ENDIF
6911:                 loc_lResultado = loc_lResultado
6912:             ENDIF
6913:             SELECT cursor_4c_ValUpd
6914:             LOCATE FOR ALLTRIM(UniPrdts) = loc_cCodigo
6915:             IF EOF("cursor_4c_ValUpd")
6916:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6917:                 loc_oLookup.mAddColuna("UniPrdts", "", "Uni. Produtiva")
6918:                 loc_oLookup.cTabela     = "SigCdUpd"
6919:                 loc_oLookup.cCampoChave = "UniPrdts"
6920:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6921:                 loc_oLookup.Show()
6922:                 IF loc_oLookup.this_lSelecionou
6923:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6924:                 ELSE
6925:                     loc_cCodigo = ""
6926:                 ENDIF
6927:             ENDIF
6928:             IF USED("cursor_4c_ValUpd")
6929:                 USE IN cursor_4c_ValUpd
6930:             ENDIF
6931:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6932:                 SELECT cursor_4c_Fase
6933:                 REPLACE UniPrdts WITH PADR(loc_cCodigo, 10) IN cursor_4c_Fase
6934:                 loc_oGrd.Column4.Text1.Value = loc_cCodigo
6935:             ENDIF
6936:         CATCH TO loc_oErro
6937:             MsgErro(loc_oErro.Message, "Erro")
6938:         ENDTRY
6939:         RETURN loc_lResultado
6940:     ENDPROC
6941: 
6942:     *--------------------------------------------------------------------------
6943:     * FaseGrdCol5Valid - Valid do Column5 (Material/TpMats) do grd_4c_FasePro
6944:     * Lookup: SigOpOpt (Cods / Descs)
6945:     *--------------------------------------------------------------------------
6946:     PROCEDURE FaseGrdCol5Valid(par_nColIndex)
6947:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
6948:         loc_lResultado = .T.
6949:         TRY
6950:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
6951:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column5.Text1.Value, ""))
6952:             IF EMPTY(loc_cCodigo)
6953:                 loc_lResultado = loc_lResultado
6954:             ENDIF
6955:             loc_lcSQL = "SELECT Cods, Descs FROM SigOpOpt WHERE Cods = " + EscaparSQL(loc_cCodigo)
6956:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOpt") <= 0 OR EOF("cursor_4c_ValOpt")
6957:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6958:                 loc_oLookup.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
6959:                 loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
6960:                 loc_oLookup.cTabela     = "SigOpOpt"
6961:                 loc_oLookup.cCampoChave = "Cods"
6962:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6963:                 loc_oLookup.Show()
6964:                 IF loc_oLookup.this_lSelecionou
6965:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6966:                 ELSE
6967:                     loc_cCodigo = ""
6968:                 ENDIF
6969:             ENDIF
6970:             IF USED("cursor_4c_ValOpt")
6971:                 USE IN cursor_4c_ValOpt
6972:             ENDIF
6973:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6974:                 SELECT cursor_4c_Fase
6975:                 REPLACE TpMats WITH PADR(loc_cCodigo, 3) IN cursor_4c_Fase
6976:                 loc_oGrd.Column5.Text1.Value = loc_cCodigo
6977:             ENDIF
6978:             loc_oGrd.Refresh()
6979:         CATCH TO loc_oErro
6980:             MsgErro(loc_oErro.Message, "Erro")
6981:         ENDTRY
6982:         RETURN loc_lResultado
6983:     ENDPROC
6984: 
6985:     *--------------------------------------------------------------------------
6986:     * ValidarAcabamento - LostFocus do txt_4c_CodAcb
6987:     * Lookup: SigCdAca (Cods / Descrs) -> preenche txt_4c_Dacb
6988:     *--------------------------------------------------------------------------
6989:     PROCEDURE ValidarAcabamento()
6990:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_cDescr, loc_lcSQL
6991:         loc_lResultado = .T.
6992:         TRY
6993:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6994:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_CodAcb.Value, ""))
6995:             IF EMPTY(loc_cCodigo)
6996:                 loc_oPage.txt_4c_Dacb.Value = ""
6997:                 loc_lResultado = loc_lResultado
6998:             ENDIF
6999:             loc_lcSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Cods = " + EscaparSQL(loc_cCodigo)
7000:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAca") <= 0 OR EOF("cursor_4c_ValAca")
7001:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7002:                 loc_oLookup.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
7003:                 loc_oLookup.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7004:                 loc_oLookup.cTabela     = "SigCdAca"
7005:                 loc_oLookup.cCampoChave = "Cods"
7006:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7007:                 loc_oLookup.Show()
7008:                 IF loc_oLookup.this_lSelecionou
7009:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7010:                     loc_lcSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Cods = " + EscaparSQL(loc_cCodigo)
7011:                     IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAca") > 0 AND !EOF("cursor_4c_ValAca")
7012:                         loc_cDescr = ALLTRIM(NVL(cursor_4c_ValAca.Descrs, ""))
7013:                     ELSE
7014:                         loc_cDescr = ""
7015:                     ENDIF
7016:                 ELSE
7017:                     loc_cCodigo = ""
7018:                     loc_cDescr  = ""
7019:                 ENDIF
7020:             ELSE
7021:                 loc_cDescr = ALLTRIM(NVL(cursor_4c_ValAca.Descrs, ""))
7022:             ENDIF
7023:             IF USED("cursor_4c_ValAca")
7024:                 USE IN cursor_4c_ValAca
7025:             ENDIF
7026:             loc_oPage.txt_4c_CodAcb.Value = loc_cCodigo
7027:             loc_oPage.txt_4c_Dacb.Value   = loc_cDescr
7028:         CATCH TO loc_oErro
7029:             MsgErro(loc_oErro.Message, "Erro")
7030:         ENDTRY
7031:         RETURN loc_lResultado
7032:     ENDPROC
7033: 
7034:     *--------------------------------------------------------------------------
7035:     * ValidarConquilha - LostFocus do txt_4c_Conquilha
7036:     * Lookup: SigCdCnq (conquilhas)
7037:     *--------------------------------------------------------------------------
7038:     PROCEDURE ValidarConquilha()
7039:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cValor, loc_lcSQL
7040:         loc_lResultado = .T.
7041:         TRY
7042:             loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7043:             loc_cValor = ALLTRIM(NVL(loc_oPage.txt_4c_Conquilha.Value, ""))
7044:             IF EMPTY(loc_cValor)
7045:                 loc_lResultado = loc_lResultado
7046:             ENDIF
7047:             loc_lcSQL = "SELECT conquilhas FROM SigCdCnq GROUP BY conquilhas"
7048:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCnq") > 0
7049:                 SELECT cursor_4c_ValCnq
7050:                 LOCATE FOR ALLTRIM(conquilhas) = loc_cValor
7051:                 IF EOF("cursor_4c_ValCnq")
7052:                     loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7053:                     loc_oLookup.mAddColuna("conquilhas", "", "Conquilhas")
7054:                     loc_oLookup.cTabela     = "SigCdCnq"
7055:                     loc_oLookup.cCampoChave = "conquilhas"
7056:                     loc_oLookup.cFiltroIni  = loc_cValor
7057:                     loc_oLookup.Show()
7058:                     IF loc_oLookup.this_lSelecionou
7059:                         loc_cValor = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7060:                     ELSE
7061:                         loc_cValor = ""
7062:                     ENDIF
7063:                 ENDIF
7064:                 IF USED("cursor_4c_ValCnq")
7065:                     USE IN cursor_4c_ValCnq
7066:                 ENDIF
7067:             ENDIF
7068:             loc_oPage.txt_4c_Conquilha.Value = loc_cValor
7069:         CATCH TO loc_oErro
7070:             MsgErro(loc_oErro.Message, "Erro")
7071:         ENDTRY
7072:         RETURN loc_lResultado
7073:     ENDPROC
7074: 
7075:     *--------------------------------------------------------------------------
7076:     * ValidarCor - LostFocus do txt_4c_Cor
7077:     * Lookup: SigCdCor (Cods / Descs)
7078:     *--------------------------------------------------------------------------
7079:     PROCEDURE ValidarCor()
7080:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
7081:         loc_lResultado = .T.
7082:         TRY
7083:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7084:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Cor.Value, ""))
7085:             IF EMPTY(loc_cCodigo)
7086:                 loc_lResultado = loc_lResultado
7087:             ENDIF
7088:             loc_lcSQL = "SELECT Cods FROM SigCdCor WHERE Cods = " + EscaparSQL(loc_cCodigo)
7089:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCor") <= 0 OR EOF("cursor_4c_ValCor")
7090:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7091:                 loc_oLookup.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
7092:                 loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7093:                 loc_oLookup.cTabela     = "SigCdCor"
7094:                 loc_oLookup.cCampoChave = "Cods"
7095:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7096:                 loc_oLookup.Show()
7097:                 IF loc_oLookup.this_lSelecionou
7098:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7099:                 ELSE
7100:                     loc_cCodigo = ""
7101:                 ENDIF
7102:             ENDIF
7103:             IF USED("cursor_4c_ValCor")
7104:                 USE IN cursor_4c_ValCor
7105:             ENDIF
7106:             loc_oPage.txt_4c_Cor.Value = loc_cCodigo
7107:             loc_oPage.txt_4c_Cor.Refresh()
7108:         CATCH TO loc_oErro
7109:             MsgErro(loc_oErro.Message, "Erro")
7110:         ENDTRY
7111:         RETURN loc_lResultado
7112:     ENDPROC
7113: 
7114:     *--------------------------------------------------------------------------
7115:     * ValidarTam - LostFocus do txt_4c_Tam
7116:     * Lookup: SigCdTam (Cods / Descs)
7117:     *--------------------------------------------------------------------------
7118:     PROCEDURE ValidarTam()
7119:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
7120:         loc_lResultado = .T.
7121:         TRY
7122:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7123:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Tam.Value, ""))
7124:             IF EMPTY(loc_cCodigo)
7125:                 loc_lResultado = loc_lResultado
7126:             ENDIF
7127:             loc_lcSQL = "SELECT Cods FROM SigCdTam WHERE Cods = " + EscaparSQL(loc_cCodigo)
7128:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTam") <= 0 OR EOF("cursor_4c_ValTam")
7129:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7130:                 loc_oLookup.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
7131:                 loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7132:                 loc_oLookup.cTabela     = "SigCdTam"
7133:                 loc_oLookup.cCampoChave = "Cods"
7134:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7135:                 loc_oLookup.Show()
7136:                 IF loc_oLookup.this_lSelecionou
7137:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7138:                 ELSE
7139:                     loc_cCodigo = ""
7140:                 ENDIF
7141:             ENDIF
7142:             IF USED("cursor_4c_ValTam")
7143:                 USE IN cursor_4c_ValTam
7144:             ENDIF
7145:             loc_oPage.txt_4c_Tam.Value = loc_cCodigo
7146:             loc_oPage.txt_4c_Tam.Refresh()
7147:         CATCH TO loc_oErro
7148:             MsgErro(loc_oErro.Message, "Erro")
7149:         ENDTRY
7150:         RETURN loc_lResultado
7151:     ENDPROC
7152: 
7153:     *--------------------------------------------------------------------------
7154:     * BtnInsereMtxClick - Insere nova linha no grd_4c_Matrizes
7155:     *--------------------------------------------------------------------------
7156:     PROCEDURE BtnInsereMtxClick()
7157:         LOCAL loc_lResultado, loc_oPage
7158:         loc_lResultado = .F.
7159:         TRY
7160:             IF !USED("cursor_4c_Matrizes")
7161:                 loc_lResultado = loc_lResultado
7162:             ENDIF
7163:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7164:             SELECT cursor_4c_Matrizes
7165:             *-- Localiza linha vazia (placeholder); se nao houver, insere uma nova
7166:             GO TOP IN cursor_4c_Matrizes
7167:             LOCATE FOR EMPTY(cursor_4c_Matrizes.CMats)
7168:             IF EOF("cursor_4c_Matrizes")
7169:                 INSERT INTO cursor_4c_Matrizes (CMats, Locals, QMatz, CPros, cIdChaves, DPros) ;
7170:                     VALUES ("", "", 0, "", "", "")
7171:             ENDIF
7172:             loc_oPage.grd_4c_Matrizes.Refresh()
7173:             loc_oPage.grd_4c_Matrizes.SetFocus()
7174:             loc_oPage.grd_4c_Matrizes.Column1.SetFocus()
7175:             loc_lResultado = .T.
7176:         CATCH TO loc_oErro
7177:             MsgErro(loc_oErro.Message, "Erro")
7178:         ENDTRY
7179:         RETURN loc_lResultado
7180:     ENDPROC
7181: 
7182:     *--------------------------------------------------------------------------
7183:     * BtnExcluiMtzClick - Exclui linha atual do grd_4c_Matrizes
7184:     * Garante sempre ao menos uma linha vazia no cursor
7185:     *--------------------------------------------------------------------------
7186:     PROCEDURE BtnExcluiMtzClick()
7187:         LOCAL loc_lResultado, loc_oPage
7188:         loc_lResultado = .F.
7189:         TRY
7190:             IF !USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes")
7191:                 loc_lResultado = loc_lResultado
7192:             ENDIF
7193:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7194:             SELECT cursor_4c_Matrizes
7195:             DELETE IN cursor_4c_Matrizes
7196:             PACK IN cursor_4c_Matrizes
7197:             *-- Garante sempre ao menos uma linha vazia
7198:             GO TOP IN cursor_4c_Matrizes
7199:             LOCATE FOR EMPTY(cursor_4c_Matrizes.CMats)
7200:             IF EOF("cursor_4c_Matrizes")
7201:                 INSERT INTO cursor_4c_Matrizes (CMats, Locals, QMatz, CPros, cIdChaves, DPros) ;
7202:                     VALUES ("", "", 0, "", "", "")
7203:             ENDIF
7204:             loc_oPage.grd_4c_Matrizes.Refresh()
7205:             loc_oPage.grd_4c_Matrizes.SetFocus()
7206:             loc_oPage.grd_4c_Matrizes.Column1.SetFocus()
7207:             loc_lResultado = .T.
7208:         CATCH TO loc_oErro
7209:             MsgErro(loc_oErro.Message, "Erro")
7210:         ENDTRY
7211:         RETURN loc_lResultado
7212:     ENDPROC
7213: 
7214:     *--------------------------------------------------------------------------
7215:     * MatrizGrdCol1Valid - Valid do Column1 (Matriz/CMats) do grd_4c_Matrizes
7216:     * Lookup: SigCdPro (CPros / DPros) - produto usado como matriz
7217:     *--------------------------------------------------------------------------
7218:     PROCEDURE MatrizGrdCol1Valid(par_nColIndex)
7219:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
7220:         loc_lResultado = .T.
7221:         TRY
7222:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_Matrizes
7223:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column1.Text1.Value, ""))
7224:             IF EMPTY(loc_cCodigo)
7225:                 loc_lResultado = loc_lResultado
7226:             ENDIF
7227:             loc_lcSQL = "SELECT CPros, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCodigo)
7228:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValMtz") <= 0 OR EOF("cursor_4c_ValMtz")
7229:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7230:                 loc_oLookup.mAddColuna("CPros", "", "Matriz")
7231:                 loc_oLookup.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
7232:                 loc_oLookup.cTabela     = "SigCdPro"
7233:                 loc_oLookup.cCampoChave = "CPros"
7234:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7235:                 loc_oLookup.Show()
7236:                 IF loc_oLookup.this_lSelecionou
7237:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7238:                 ELSE
7239:                     loc_cCodigo = ""
7240:                 ENDIF
7241:             ENDIF
7242:             IF USED("cursor_4c_ValMtz")
7243:                 USE IN cursor_4c_ValMtz
7244:             ENDIF
7245:             IF USED("cursor_4c_Matrizes") AND !EOF("cursor_4c_Matrizes")
7246:                 SELECT cursor_4c_Matrizes
7247:                 REPLACE CMats WITH PADR(loc_cCodigo, 14) IN cursor_4c_Matrizes
7248:                 loc_oGrd.Column1.Text1.Value = loc_cCodigo
7249:                 loc_oGrd.Refresh()
7250:             ENDIF
7251:         CATCH TO loc_oErro
7252:             MsgErro(loc_oErro.Message, "Erro")
7253:         ENDTRY
7254:         RETURN loc_lResultado
7255:     ENDPROC
7256: 
7257:     *--------------------------------------------------------------------------
7258:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
7259:     * par_oContainer: container a processar (Page1, Page2, etc.)
7260:     *--------------------------------------------------------------------------
7261:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
7262:         LOCAL loc_nI, loc_oObjeto, loc_nP
7263: 
7264:         FOR loc_nI = 1 TO par_oContainer.ControlCount
7265:             loc_oObjeto = par_oContainer.Controls(loc_nI)
7266: 
7267:             IF VARTYPE(loc_oObjeto) = "O"
7268:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
7269:                     loc_oObjeto.Visible = .T.
7270:                 ENDIF
7271: 
7272:                 *-- Itera Pages de PageFrame
7273:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
7274:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
7275:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
7276:                     ENDFOR
7277:                 ENDIF
7278: 
7279:                 *-- Itera containers com ControlCount
7280:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
7281:                     THIS.TornarControlesVisiveis(loc_oObjeto)
7282:                 ENDIF
7283:             ENDIF
7284:         ENDFOR
7285:     ENDPROC
7286: 
7287:     *--------------------------------------------------------------------------
7288:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
7289:     *--------------------------------------------------------------------------
7290:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
7291:         THIS.pgf_4c_Paginas.Visible   = .T.
7292:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
7293: 
7294:         IF par_nPagina = 1
7295:             THIS.AjustarBotoesPorModo()
7296:             THIS.CarregarLista()
7297:         ENDIF
7298:     ENDPROC
7299: 
7300:     *--------------------------------------------------------------------------
7301:     * CarregarLista - Busca registros do SigPrFtp com JOIN SigCdPro
7302:     *--------------------------------------------------------------------------
7303:     PROCEDURE CarregarLista()
7304:         LOCAL loc_lResultado, loc_cSQL, loc_cWhere
7305:         loc_lResultado = .F.
7306: 
7307:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
7308:             RETURN loc_lResultado
7309:         ENDIF
7310: 
7311:         TRY
7312:             loc_cWhere = THIS.MontarFiltro()
7313: 
7314:             loc_cSQL = "SELECT t.pkchaves, t.cpros, " + ;
7315:                 "ISNULL(p.dpros,'') AS dpros, " + ;
7316:                 "t.cgrus, t.cods, " + ;
7317:                 "ISNULL(p.reffs,'') AS reffs, " + ;
7318:                 "ISNULL(p.usuincs,'') AS usuincs, " + ;
7319:                 "ISNULL(p.situas,0) AS situas " + ;
7320:                 "FROM sigprftp t " + ;
7321:                 "LEFT JOIN SigCdPro p ON p.cpros = t.cpros "
7322: 
7323:             IF !EMPTY(loc_cWhere)
7324:                 loc_cSQL = loc_cSQL + "WHERE " + loc_cWhere + " "
7325:             ENDIF
7326: 
7327:             loc_cSQL = loc_cSQL + "ORDER BY t.cpros"
7328: 
7329:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") > 0
7330:                 LOCAL loc_oGrd
7331:                 loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
7332: 
7333:                 *-- RecordSource FORA de WITH (causa erro se acessar .Column dentro do WITH)
7334:                 loc_oGrd.RecordSource = "cursor_4c_Dados"
7335: 
7336:                 *-- Definir ControlSource (OBRIGATORIO apos RecordSource)
7337:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Dados.cpros"
7338:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Dados.dpros"
7339:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Dados.cgrus"
7340:                 loc_oGrd.Column4.ControlSource = "cursor_4c_Dados.cods"
7341:                 loc_oGrd.Column5.ControlSource = "cursor_4c_Dados.reffs"
7342:                 loc_oGrd.Column6.ControlSource = "cursor_4c_Dados.usuincs"
7343:                 loc_oGrd.Column7.ControlSource = "cursor_4c_Dados.situas"
7344: 
7345:                 *-- Re-aplicar larguras e cabecalhos (RecordSource reseta esses valores)
7346:                 loc_oGrd.Column1.Width = 110
7347:                 loc_oGrd.Column2.Width = 408
7348:                 loc_oGrd.Column3.Width = 40
7349:                 loc_oGrd.Column4.Width = 70
7350:                 loc_oGrd.Column5.Width = 150
7351:                 loc_oGrd.Column6.Width = 100
7352:                 loc_oGrd.Column7.Width = 16
7353:                 loc_oGrd.Column1.Header1.Caption = "Produto"
7354:                 loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7355:                 loc_oGrd.Column3.Header1.Caption = "Grupo"
7356:                 loc_oGrd.Column4.Header1.Caption = "Subgrp."
7357:                 loc_oGrd.Column5.Header1.Caption = "Ref. Fornecedor"
7358:                 loc_oGrd.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"

*-- Linhas 7426 a 7533:
7426:     * FormatarGridLista - Formata visual do grid (FontName/Size)
7427:     * RecordSource + ControlSource ja definidos em CarregarLista
7428:     *--------------------------------------------------------------------------
7429:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
7430:         WITH par_oGrid
7431:             IF .ColumnCount > 0
7432:                 .FontName = "Arial"
7433:                 .FontSize = 8
7434:             ENDIF
7435:         ENDWITH
7436:     ENDPROC
7437: 
7438:     *--------------------------------------------------------------------------
7439:     * AtualizarContagemProdutos - Atualiza label de contagem
7440:     *--------------------------------------------------------------------------
7441:     PROTECTED PROCEDURE AtualizarContagemProdutos()
7442:         LOCAL loc_nTotal
7443:         loc_nTotal = 0
7444: 
7445:         TRY
7446:             IF USED("cursor_4c_Dados")
7447:                 loc_nTotal = RECCOUNT("cursor_4c_Dados")
7448:             ENDIF
7449:             THIS.pgf_4c_Paginas.Page1.lbl_4c_Produtos.Caption = ;
7450:                 "Produtos Selecionados : " + TRANSFORM(loc_nTotal)
7451:         CATCH TO loc_oErro
7452:             MsgErro(loc_oErro.Message, "Erro ao atualizar contagem")
7453:         ENDTRY
7454:     ENDPROC
7455: 
7456:     *--------------------------------------------------------------------------
7457:     * FormParaBO - Transfere dados do formulario para o BO
7458:     * Fase 5: cpros/cgrus/cods mapeados para SigPrFtp
7459:     * Campos SigCdPro (DPro2s, Cbar, Lin, Col, Ifor, Refs) serao
7460:     * persistidos em fase futura (Phase 7) via SQL direto em SigCdPro
7461:     *--------------------------------------------------------------------------
7462:     PROTECTED PROCEDURE FormParaBO()
7463:         LOCAL loc_oPg
7464:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7465: 
7466:         THIS.this_oBusinessObject.this_cCpros = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
7467:         THIS.this_oBusinessObject.this_cCgrus = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
7468:         THIS.this_oBusinessObject.this_cCods  = ALLTRIM(loc_oPg.txt_4c_Cods.Value)
7469:         *-- coefs/valors: sem controle visual em pgDados -> mantidos como 0 no BO
7470:         *-- pkchaves: gerado em BtnSalvarClick, nao vem do form
7471:     ENDPROC
7472: 
7473:     *--------------------------------------------------------------------------
7474:     * BOParaForm - Transfere dados do BO para o formulario
7475:     * Fase 5: preenche SigPrFtp e carrega descritivos de SigCdPro
7476:     *--------------------------------------------------------------------------
7477:     PROTECTED PROCEDURE BOParaForm()
7478:         LOCAL loc_oPg
7479:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7480: 
7481:         loc_oPg.txt_4c_Cpros.Value = THIS.this_oBusinessObject.this_cCpros
7482:         loc_oPg.txt_4c_Cgrus.Value = THIS.this_oBusinessObject.this_cCgrus
7483:         loc_oPg.txt_4c_Cods.Value  = THIS.this_oBusinessObject.this_cCods
7484: 
7485:         *-- Carregar todos os descritivos do SigCdPro vinculado
7486:         THIS.CarregarDadosSigCdPro(THIS.this_oBusinessObject.this_cCpros)
7487:     ENDPROC
7488: 
7489:     *--------------------------------------------------------------------------
7490:     * CarregarDadosSigCdPro - Busca e preenche campos de exibicao do SigCdPro
7491:     * par_cCpros: codigo do produto
7492:     *--------------------------------------------------------------------------
7493:     PROTECTED PROCEDURE CarregarDadosSigCdPro(par_cCpros)
7494:         LOCAL loc_cSQL, loc_oPg
7495:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7496: 
7497:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
7498:             RETURN
7499:         ENDIF
7500: 
7501:         *-- Limpar campos de exibicao (Fase 5)
7502:         loc_oPg.txt_4c_Dpros.Value        = ""
7503:         loc_oPg.txt_4c_DPro2s.Value       = ""
7504:         loc_oPg.txt_4c_Cbar.Value         = ""
7505:         loc_oPg.txt_4c_DgruDisplay.Value  = ""
7506:         loc_oPg.txt_4c_DcodsDisplay.Value = ""
7507:         loc_oPg.txt_4c_Lin.Value          = ""
7508:         loc_oPg.txt_4c_DLinDisplay.Value  = ""
7509:         loc_oPg.txt_4c_Col.Value          = ""
7510:         loc_oPg.txt_4c_DColDisplay.Value  = ""
7511:         loc_oPg.txt_4c_Ifor.Value         = ""
7512:         loc_oPg.txt_4c_DforDisplay.Value  = ""
7513:         loc_oPg.txt_4c_Refs.Value         = ""
7514:         *-- Limpar campos de exibicao (Fase 6)
7515:         loc_oPg.txt_4c_Cor.Value          = ""
7516:         loc_oPg.txt_4c_Tam.Value          = ""
7517:         loc_oPg.txt_4c_CodFinP.Value      = ""
7518:         loc_oPg.txt_4c_DesFinP.Value      = ""
7519:         loc_oPg.txt_4c_PesoB.Value        = 0.0
7520:         loc_oPg.txt_4c_CodAcb.Value       = ""
7521:         loc_oPg.txt_4c_DacbDisplay.Value  = ""
7522:         loc_oPg.txt_4c_Pmedio.Value       = 0.0
7523:         loc_oPg.txt_4c_Class.Value        = ""
7524:         loc_oPg.txt_4c_DClassDisplay.Value = ""
7525:         loc_oPg.txt_4c_Local.Value        = ""
7526:         loc_oPg.txt_4c_Ctotal.Value       = 0.0
7527:         loc_oPg.txt_4c_Mctotal.Value      = ""
7528:         loc_oPg.txt_4c_Cuni.Value         = ""
7529:         loc_oPg.txt_4c_DuniDisplay.Value  = ""
7530:         loc_oPg.txt_4c_Cunip.Value        = ""
7531:         loc_oPg.txt_4c_DunipDisplay.Value = ""
7532:         loc_oPg.txt_4c_Pvenda.Value       = 0.0
7533:         loc_oPg.txt_4c_Mpvenda.Value      = ""

*-- Linhas 7576 a 7600:
7576:         loc_oPg3Clear.txt_4c_Mvalor.Value     = ""
7577:         loc_oPg3Clear.txt_4c_Teor.Value       = ""
7578:         loc_oPg3Clear.txt_4c_DesTeor.Value    = ""
7579:         loc_oPg3Clear.txt_4c_IPPTCST.Value    = ""
7580:         *-- Limpar grid sigcdcmv
7581:         IF USED("cursor_4c_Cmv")
7582:             USE IN cursor_4c_Cmv
7583:         ENDIF
7584:         SET NULL OFF
7585:         CREATE CURSOR cursor_4c_Cmv (datas C(7), valcuss N(10,2), moedas C(3))
7586:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.grd_4c_Dados.Refresh()
7587: 
7588:         IF EMPTY(par_cCpros)
7589:             RETURN
7590:         ENDIF
7591: 
7592:         TRY
7593:             *-- Fase 5+6: colunas corretas de SigCdPro (linhas=linha, colecoes=col.venda)
7594:             loc_cSQL = "SELECT p.dpros, ISNULL(p.dpro2s,'') AS dpro2s, " + ;
7595:                 "ISNULL(p.cbars,'') AS cbars, " + ;
7596:                 "ISNULL(p.cgrus,'') AS cgrus, " + ;
7597:                 "ISNULL(p.linhas,'') AS linhas, " + ;
7598:                 "ISNULL(p.colecoes,'') AS colecoes, " + ;
7599:                 "ISNULL(p.ifors,'') AS ifors, ISNULL(p.reffs,'') AS reffs, " + ;
7600:                 "ISNULL(p.codcors,'') AS codcors, ISNULL(p.codtams,'') AS codtams, " + ;

*-- Linhas 7745 a 8165:
7745:     *--------------------------------------------------------------------------
7746:     * AtualizarDescricaoProduto - Compatibilidade: delega para CarregarDadosSigCdPro
7747:     *--------------------------------------------------------------------------
7748:     PROTECTED PROCEDURE AtualizarDescricaoProduto(par_cCpros)
7749:         THIS.CarregarDadosSigCdPro(par_cCpros)
7750:     ENDPROC
7751: 
7752:     *--------------------------------------------------------------------------
7753:     * CarregarDescGrupo - Carrega descricao do grupo (SigCdGrp)
7754:     *--------------------------------------------------------------------------
7755:     PROTECTED PROCEDURE CarregarDescGrupo(par_cCgrus)
7756:         LOCAL loc_cSQL, loc_oPg
7757:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7758: 
7759:         IF EMPTY(par_cCgrus)
7760:             loc_oPg.txt_4c_DgruDisplay.Value = ""
7761:             RETURN
7762:         ENDIF
7763: 
7764:         TRY
7765:             loc_cSQL = "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(par_cCgrus)
7766:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescGru") > 0
7767:                 IF !EOF("cursor_4c_DescGru")
7768:                     SELECT cursor_4c_DescGru
7769:                     loc_oPg.txt_4c_DgruDisplay.Value = ALLTRIM(dgrus)
7770:                 ELSE
7771:                     loc_oPg.txt_4c_DgruDisplay.Value = ""
7772:                 ENDIF
7773:                 IF USED("cursor_4c_DescGru")
7774:                     USE IN cursor_4c_DescGru
7775:                 ENDIF
7776:             ENDIF
7777:         CATCH TO loc_oErro
7778:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
7779:         ENDTRY
7780:     ENDPROC
7781: 
7782:     *--------------------------------------------------------------------------
7783:     * CarregarDescCods - Carrega descricao do subgrupo (via SigCdGrp ou tabela propria)
7784:     *--------------------------------------------------------------------------
7785:     PROTECTED PROCEDURE CarregarDescCods(par_cCods)
7786:         LOCAL loc_oPg, loc_cSQL
7787:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7788: 
7789:         IF EMPTY(par_cCods)
7790:             loc_oPg.txt_4c_DcodsDisplay.Value = ""
7791:             RETURN
7792:         ENDIF
7793: 
7794:         TRY
7795:             loc_cSQL = "SELECT dgrus AS descSubGrupo FROM SigCdGrp WHERE cgrus = " + EscaparSQL(par_cCods)
7796:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCods") > 0
7797:                 IF !EOF("cursor_4c_DescCods")
7798:                     SELECT cursor_4c_DescCods
7799:                     loc_oPg.txt_4c_DcodsDisplay.Value = ALLTRIM(descSubGrupo)
7800:                 ELSE
7801:                     loc_oPg.txt_4c_DcodsDisplay.Value = ""
7802:                 ENDIF
7803:                 IF USED("cursor_4c_DescCods")
7804:                     USE IN cursor_4c_DescCods
7805:                 ENDIF
7806:             ELSE
7807:                 loc_oPg.txt_4c_DcodsDisplay.Value = ""
7808:             ENDIF
7809:         CATCH TO loc_oErro
7810:             MsgErro(loc_oErro.Message, "Erro ao buscar subgrupo")
7811:         ENDTRY
7812:     ENDPROC
7813: 
7814:     *--------------------------------------------------------------------------
7815:     * CarregarDescLin - Carrega descricao da linha (SigCdLin, PK=linhas, desc=descs)
7816:     *--------------------------------------------------------------------------
7817:     PROTECTED PROCEDURE CarregarDescLin(par_cLinhas)
7818:         LOCAL loc_cSQL, loc_oPg
7819:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7820: 
7821:         IF EMPTY(par_cLinhas)
7822:             loc_oPg.txt_4c_DLinDisplay.Value = ""
7823:             RETURN
7824:         ENDIF
7825: 
7826:         TRY
7827:             loc_cSQL = "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(par_cLinhas)
7828:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescLin") > 0
7829:                 IF !EOF("cursor_4c_DescLin")
7830:                     SELECT cursor_4c_DescLin
7831:                     loc_oPg.txt_4c_DLinDisplay.Value = ALLTRIM(descs)
7832:                 ELSE
7833:                     loc_oPg.txt_4c_DLinDisplay.Value = ""
7834:                 ENDIF
7835:                 IF USED("cursor_4c_DescLin")
7836:                     USE IN cursor_4c_DescLin
7837:                 ENDIF
7838:             ENDIF
7839:         CATCH TO loc_oErro
7840:             MsgErro(loc_oErro.Message, "Erro ao buscar linha")
7841:         ENDTRY
7842:     ENDPROC
7843: 
7844:     *--------------------------------------------------------------------------
7845:     * CarregarDescCol - Exibe colecoes (campo texto direto em SigCdPro)
7846:     * Nota: nao existe tabela SigCdCol no banco; colecoes e campo texto livre
7847:     *--------------------------------------------------------------------------
7848:     PROTECTED PROCEDURE CarregarDescCol(par_cColecoes)
7849:         LOCAL loc_oPg
7850:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7851:         *-- Colecoes nao tem tabela de descricao - exibir o proprio valor
7852:         loc_oPg.txt_4c_DColDisplay.Value = par_cColecoes
7853:     ENDPROC
7854: 
7855:     *--------------------------------------------------------------------------
7856:     * CarregarDescIfor - Carrega nome do fornecedor
7857:     *--------------------------------------------------------------------------
7858:     PROTECTED PROCEDURE CarregarDescIfor(par_cIfors)
7859:         LOCAL loc_cSQL, loc_oPg
7860:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7861: 
7862:         IF EMPTY(par_cIfors)
7863:             loc_oPg.txt_4c_DforDisplay.Value = ""
7864:             RETURN
7865:         ENDIF
7866: 
7867:         TRY
7868:             *-- Fornecedor buscado via SigCdCli (ou tabela de fornecedores)
7869:             loc_cSQL = "SELECT Rclis AS dfors FROM SigCdCli WHERE Iclis = " + EscaparSQL(par_cIfors)
7870:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescIfor") > 0
7871:                 IF !EOF("cursor_4c_DescIfor")
7872:                     SELECT cursor_4c_DescIfor
7873:                     loc_oPg.txt_4c_DforDisplay.Value = ALLTRIM(dfors)
7874:                 ELSE
7875:                     loc_oPg.txt_4c_DforDisplay.Value = ""
7876:                 ENDIF
7877:                 IF USED("cursor_4c_DescIfor")
7878:                     USE IN cursor_4c_DescIfor
7879:                 ENDIF
7880:             ENDIF
7881:         CATCH TO loc_oErro
7882:             MsgErro(loc_oErro.Message, "Erro ao buscar fornecedor")
7883:         ENDTRY
7884:     ENDPROC
7885: 
7886:     *--------------------------------------------------------------------------
7887:     * CarregarDescCor - Carrega descricao da cor (SigCdCor, PK=cods, desc=descs)
7888:     *--------------------------------------------------------------------------
7889:     PROTECTED PROCEDURE CarregarDescCor(par_cCodCor)
7890:         LOCAL loc_cSQL, loc_oPg
7891:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7892:         IF EMPTY(par_cCodCor)
7893:             RETURN
7894:         ENDIF
7895:         TRY
7896:             loc_cSQL = "SELECT descs FROM SigCdCor WHERE cods = " + EscaparSQL(par_cCodCor)
7897:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCor") > 0
7898:                 IF !EOF("cursor_4c_DescCor")
7899:                     SELECT cursor_4c_DescCor
7900:                     loc_oPg.txt_4c_Cor.ToolTipText = ALLTRIM(descs)
7901:                 ENDIF
7902:                 IF USED("cursor_4c_DescCor")
7903:                     USE IN cursor_4c_DescCor
7904:                 ENDIF
7905:             ENDIF
7906:         CATCH TO loc_oErro
7907:             MsgErro(loc_oErro.Message, "Erro ao buscar cor")
7908:         ENDTRY
7909:     ENDPROC
7910: 
7911:     *--------------------------------------------------------------------------
7912:     * CarregarDescTam - Carrega descricao do tamanho (SigCdTam, PK=cods, desc=descs)
7913:     *--------------------------------------------------------------------------
7914:     PROTECTED PROCEDURE CarregarDescTam(par_cCodTam)
7915:         LOCAL loc_cSQL, loc_oPg
7916:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7917:         IF EMPTY(par_cCodTam)
7918:             RETURN
7919:         ENDIF
7920:         TRY
7921:             loc_cSQL = "SELECT descs FROM SigCdTam WHERE cods = " + EscaparSQL(par_cCodTam)
7922:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescTam") > 0
7923:                 IF !EOF("cursor_4c_DescTam")
7924:                     SELECT cursor_4c_DescTam
7925:                     loc_oPg.txt_4c_Tam.ToolTipText = ALLTRIM(descs)
7926:                 ENDIF
7927:                 IF USED("cursor_4c_DescTam")
7928:                     USE IN cursor_4c_DescTam
7929:                 ENDIF
7930:             ENDIF
7931:         CATCH TO loc_oErro
7932:             MsgErro(loc_oErro.Message, "Erro ao buscar tamanho")
7933:         ENDTRY
7934:     ENDPROC
7935: 
7936:     *--------------------------------------------------------------------------
7937:     * CarregarDescFinP - Carrega descricao da ficha (SigCdFip, PK=cods, desc=descs)
7938:     *--------------------------------------------------------------------------
7939:     PROTECTED PROCEDURE CarregarDescFinP(par_cCodFinP)
7940:         LOCAL loc_cSQL, loc_oPg
7941:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7942:         IF EMPTY(par_cCodFinP)
7943:             loc_oPg.txt_4c_DesFinP.Value = ""
7944:             RETURN
7945:         ENDIF
7946:         TRY
7947:             loc_cSQL = "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(par_cCodFinP)
7948:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFinP") > 0
7949:                 IF !EOF("cursor_4c_DescFinP")
7950:                     SELECT cursor_4c_DescFinP
7951:                     loc_oPg.txt_4c_DesFinP.Value = ALLTRIM(descs)
7952:                 ELSE
7953:                     loc_oPg.txt_4c_DesFinP.Value = ""
7954:                 ENDIF
7955:                 IF USED("cursor_4c_DescFinP")
7956:                     USE IN cursor_4c_DescFinP
7957:                 ENDIF
7958:             ENDIF
7959:         CATCH TO loc_oErro
7960:             MsgErro(loc_oErro.Message, "Erro ao buscar ficha")
7961:         ENDTRY
7962:     ENDPROC
7963: 
7964:     *--------------------------------------------------------------------------
7965:     * CarregarDescAcb - Carrega descricao do acabamento (SigCdAca, PK=cods, desc=descrs)
7966:     *--------------------------------------------------------------------------
7967:     PROTECTED PROCEDURE CarregarDescAcb(par_cCodAcb)
7968:         LOCAL loc_cSQL, loc_oPg
7969:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7970:         IF EMPTY(par_cCodAcb)
7971:             loc_oPg.txt_4c_DacbDisplay.Value = ""
7972:             RETURN
7973:         ENDIF
7974:         TRY
7975:             loc_cSQL = "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(par_cCodAcb)
7976:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescAcb") > 0
7977:                 IF !EOF("cursor_4c_DescAcb")
7978:                     SELECT cursor_4c_DescAcb
7979:                     loc_oPg.txt_4c_DacbDisplay.Value = ALLTRIM(descrs)
7980:                 ELSE
7981:                     loc_oPg.txt_4c_DacbDisplay.Value = ""
7982:                 ENDIF
7983:                 IF USED("cursor_4c_DescAcb")
7984:                     USE IN cursor_4c_DescAcb
7985:                 ENDIF
7986:             ENDIF
7987:         CATCH TO loc_oErro
7988:             MsgErro(loc_oErro.Message, "Erro ao buscar acabamento")
7989:         ENDTRY
7990:     ENDPROC
7991: 
7992:     *--------------------------------------------------------------------------
7993:     * CarregarDescClass - Carrega descricao da classificacao (SIGCDCLS, PK=cods, desc=descs)
7994:     *--------------------------------------------------------------------------
7995:     PROTECTED PROCEDURE CarregarDescClass(par_cCclass)
7996:         LOCAL loc_cSQL, loc_oPg
7997:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7998:         IF EMPTY(par_cCclass)
7999:             loc_oPg.txt_4c_DClassDisplay.Value = ""
8000:             RETURN
8001:         ENDIF
8002:         TRY
8003:             loc_cSQL = "SELECT descs FROM SIGCDCLS WHERE cods = " + EscaparSQL(par_cCclass)
8004:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescClass") > 0
8005:                 IF !EOF("cursor_4c_DescClass")
8006:                     SELECT cursor_4c_DescClass
8007:                     loc_oPg.txt_4c_DClassDisplay.Value = ALLTRIM(descs)
8008:                 ELSE
8009:                     loc_oPg.txt_4c_DClassDisplay.Value = ""
8010:                 ENDIF
8011:                 IF USED("cursor_4c_DescClass")
8012:                     USE IN cursor_4c_DescClass
8013:                 ENDIF
8014:             ENDIF
8015:         CATCH TO loc_oErro
8016:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o")
8017:         ENDTRY
8018:     ENDPROC
8019: 
8020:     *--------------------------------------------------------------------------
8021:     * CarregarDescLocal - Carrega descricao do local (SigPrLcl, PK=codigos, desc=descricaos)
8022:     *--------------------------------------------------------------------------
8023:     PROTECTED PROCEDURE CarregarDescLocal(par_cLocals)
8024:         LOCAL loc_cSQL, loc_oPg
8025:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8026:         IF EMPTY(par_cLocals)
8027:             RETURN
8028:         ENDIF
8029:         TRY
8030:             loc_cSQL = "SELECT descricaos FROM SigPrLcl WHERE codigos = " + EscaparSQL(par_cLocals)
8031:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescLocal") > 0
8032:                 IF !EOF("cursor_4c_DescLocal")
8033:                     SELECT cursor_4c_DescLocal
8034:                     loc_oPg.txt_4c_Local.ToolTipText = ALLTRIM(descricaos)
8035:                 ENDIF
8036:                 IF USED("cursor_4c_DescLocal")
8037:                     USE IN cursor_4c_DescLocal
8038:                 ENDIF
8039:             ENDIF
8040:         CATCH TO loc_oErro
8041:             MsgErro(loc_oErro.Message, "Erro ao buscar local")
8042:         ENDTRY
8043:     ENDPROC
8044: 
8045:     *--------------------------------------------------------------------------
8046:     * CarregarDescUni - Carrega descricao da unidade (SigCdUni, PK=cunis, desc=dunis)
8047:     * par_cTipo: "uni" = unidade principal, "unip" = unidade de pedido
8048:     *--------------------------------------------------------------------------
8049:     PROTECTED PROCEDURE CarregarDescUni(par_cCunis, par_cTipo)
8050:         LOCAL loc_cSQL, loc_oPg
8051:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8052:         IF EMPTY(par_cCunis)
8053:             IF par_cTipo = "uni"
8054:                 loc_oPg.txt_4c_DuniDisplay.Value  = ""
8055:             ELSE
8056:                 loc_oPg.txt_4c_DunipDisplay.Value = ""
8057:             ENDIF
8058:             RETURN
8059:         ENDIF
8060:         TRY
8061:             loc_cSQL = "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(par_cCunis)
8062:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescUni") > 0
8063:                 IF !EOF("cursor_4c_DescUni")
8064:                     SELECT cursor_4c_DescUni
8065:                     IF par_cTipo = "uni"
8066:                         loc_oPg.txt_4c_DuniDisplay.Value  = ALLTRIM(dunis)
8067:                     ELSE
8068:                         loc_oPg.txt_4c_DunipDisplay.Value = ALLTRIM(dunis)
8069:                     ENDIF
8070:                 ELSE
8071:                     IF par_cTipo = "uni"
8072:                         loc_oPg.txt_4c_DuniDisplay.Value  = ""
8073:                     ELSE
8074:                         loc_oPg.txt_4c_DunipDisplay.Value = ""
8075:                     ENDIF
8076:                 ENDIF
8077:                 IF USED("cursor_4c_DescUni")
8078:                     USE IN cursor_4c_DescUni
8079:                 ENDIF
8080:             ENDIF
8081:         CATCH TO loc_oErro
8082:             MsgErro(loc_oErro.Message, "Erro ao buscar unidade")
8083:         ENDTRY
8084:     ENDPROC
8085: 
8086:     *--------------------------------------------------------------------------
8087:     * CarregarDescMoe - Carrega descricao da moeda (SigCdMoe, PK=cmoes, desc=dmoes)
8088:     * par_cTipo: "total" | "pvenda" | "fvenda"
8089:     *--------------------------------------------------------------------------
8090:     PROTECTED PROCEDURE CarregarDescMoe(par_cCmoes, par_cTipo)
8091:         LOCAL loc_cSQL, loc_oPg, loc_cDesc
8092:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8093:         loc_cDesc = ""
8094:         IF EMPTY(par_cCmoes)
8095:             RETURN
8096:         ENDIF
8097:         TRY
8098:             loc_cSQL = "SELECT dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(par_cCmoes)
8099:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescMoe") > 0
8100:                 IF !EOF("cursor_4c_DescMoe")
8101:                     SELECT cursor_4c_DescMoe
8102:                     loc_cDesc = ALLTRIM(dmoes)
8103:                 ENDIF
8104:                 IF USED("cursor_4c_DescMoe")
8105:                     USE IN cursor_4c_DescMoe
8106:                 ENDIF
8107:             ENDIF
8108:         CATCH TO loc_oErro
8109:             MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
8110:         ENDTRY
8111:         DO CASE
8112:         CASE par_cTipo = "total"
8113:             loc_oPg.txt_4c_Mctotal.ToolTipText = loc_cDesc
8114:         CASE par_cTipo = "pvenda"
8115:             loc_oPg.txt_4c_Mpvenda.ToolTipText = loc_cDesc
8116:         CASE par_cTipo = "fvenda"
8117:             loc_oPg.txt_4c_Mfvenda.ToolTipText = loc_cDesc
8118:         ENDCASE
8119:     ENDPROC
8120: 
8121:     *--------------------------------------------------------------------------
8122:     * CarregarDescFiscais - Carrega descricoes e historico CMV da Fase 13
8123:     * par_cCpros: codigo produto; demais: codigos para lookup de descricoes
8124:     *--------------------------------------------------------------------------
8125:     PROTECTED PROCEDURE CarregarDescFiscais(par_cCpros, par_cGruccus, par_cContaccus, ;
8126:                                              par_cClfiscals, par_cOrigmercs, par_cSittricms, ;
8127:                                              par_cMetals, par_cTeors)
8128:         LOCAL loc_oPg3, loc_cSQL, loc_cDesc
8129:         loc_oPg3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
8130: 
8131:         TRY
8132:             *-- Grupo CC (SigCdGcr)
8133:             IF !EMPTY(par_cGruccus)
8134:                 loc_cSQL = "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(par_cGruccus)
8135:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
8136:                     loc_oPg3.txt_4c_Dgruccus.Value = ALLTRIM(cursor_4c_DescFisc.descrs)
8137:                 ENDIF
8138:                 IF USED("cursor_4c_DescFisc")
8139:                     USE IN cursor_4c_DescFisc
8140:                 ENDIF
8141:             ENDIF
8142: 
8143:             *-- Conta CC (SigCdCli)
8144:             IF !EMPTY(par_cContaccus)
8145:                 loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE IClis = " + EscaparSQL(par_cContaccus)
8146:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
8147:                     loc_oPg3.txt_4c_Dcontaccus.Value = ALLTRIM(cursor_4c_DescFisc.Rclis)
8148:                 ENDIF
8149:                 IF USED("cursor_4c_DescFisc")
8150:                     USE IN cursor_4c_DescFisc
8151:                 ENDIF
8152:             ENDIF
8153: 
8154:             *-- Classificacao Fiscal (SigCdClf)
8155:             IF !EMPTY(par_cClfiscals)
8156:                 loc_cSQL = "SELECT Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(par_cClfiscals)
8157:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
8158:                     loc_oPg3.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_DescFisc.Descricaos)
8159:                 ENDIF
8160:                 IF USED("cursor_4c_DescFisc")
8161:                     USE IN cursor_4c_DescFisc
8162:                 ENDIF
8163:             ENDIF
8164: 
8165:             *-- Origem da Mercadoria (SigCdOrg)

*-- Linhas 8204 a 8286:
8204: 
8205:             *-- Carregar historico CMV (sigcdcmv)
8206:             IF !EMPTY(par_cCpros)
8207:                 loc_cSQL = "SELECT datas, valcuss, moedas FROM sigcdcmv " + ;
8208:                            "WHERE cpros = " + EscaparSQL(par_cCpros) + " ORDER BY datas DESC"
8209:                 IF USED("cursor_4c_Cmv")
8210:                     USE IN cursor_4c_Cmv
8211:                 ENDIF
8212:                 SET NULL OFF
8213:                 CREATE CURSOR cursor_4c_Cmv (datas C(7), valcuss N(10,2), moedas C(3))
8214:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmvTemp") > 0
8215:                     IF !EOF("cursor_4c_CmvTemp")
8216:                         SELECT cursor_4c_CmvTemp
8217:                         GO TOP
8218:                         SCAN
8219:                             LOCAL loc_cDatas, loc_nValcuss, loc_cMoedas
8220:                             loc_cDatas   = ALLTRIM(cursor_4c_CmvTemp.datas)
8221:                             loc_nValcuss = cursor_4c_CmvTemp.valcuss
8222:                             loc_cMoedas  = ALLTRIM(cursor_4c_CmvTemp.moedas)
8223:                             INSERT INTO cursor_4c_Cmv (datas, valcuss, moedas) ;
8224:                                 VALUES (loc_cDatas, loc_nValcuss, loc_cMoedas)
8225:                         ENDSCAN
8226:                     ENDIF
8227:                     IF USED("cursor_4c_CmvTemp")
8228:                         USE IN cursor_4c_CmvTemp
8229:                     ENDIF
8230:                 ENDIF
8231:                 SELECT cursor_4c_Cmv
8232:                 IF RECCOUNT() > 0
8233:                     GO TOP
8234:                 ENDIF
8235:                 loc_oPg3.grd_4c_Dados.Refresh()
8236:             ENDIF
8237: 
8238:         CATCH TO loc_oErro
8239:             MsgErro(loc_oErro.Message, "Erro ao carregar dados fiscais")
8240:         ENDTRY
8241:     ENDPROC
8242: 
8243:     *--------------------------------------------------------------------------
8244:     * HabilitarCampos - Habilita/desabilita campos editaveis conforme modo
8245:     *--------------------------------------------------------------------------
8246:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
8247:         LOCAL loc_oPg, loc_lReadOnly, loc_cBgEdit, loc_cBgRO
8248:         loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8249:         loc_lReadOnly = !par_lHabilitar
8250:         loc_cBgEdit  = RGB(255, 255, 255)
8251:         loc_cBgRO    = RGB(224, 235, 235)
8252: 
8253:         TRY
8254:             *-- Fase 5: Campos editaveis basicos
8255:             loc_oPg.txt_4c_Cpros.ReadOnly  = loc_lReadOnly
8256:             loc_oPg.txt_4c_Cpros.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8257: 
8258:             loc_oPg.txt_4c_DPro2s.ReadOnly  = loc_lReadOnly
8259:             loc_oPg.txt_4c_DPro2s.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8260: 
8261:             loc_oPg.txt_4c_Cbar.ReadOnly  = loc_lReadOnly
8262:             loc_oPg.txt_4c_Cbar.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8263: 
8264:             loc_oPg.txt_4c_Cgrus.ReadOnly  = loc_lReadOnly
8265:             loc_oPg.txt_4c_Cgrus.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8266: 
8267:             loc_oPg.txt_4c_Cods.ReadOnly  = loc_lReadOnly
8268:             loc_oPg.txt_4c_Cods.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8269: 
8270:             loc_oPg.txt_4c_Lin.ReadOnly  = loc_lReadOnly
8271:             loc_oPg.txt_4c_Lin.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8272: 
8273:             loc_oPg.txt_4c_Col.ReadOnly  = loc_lReadOnly
8274:             loc_oPg.txt_4c_Col.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8275: 
8276:             loc_oPg.txt_4c_Ifor.ReadOnly  = loc_lReadOnly
8277:             loc_oPg.txt_4c_Ifor.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8278: 
8279:             loc_oPg.txt_4c_Refs.ReadOnly  = loc_lReadOnly
8280:             loc_oPg.txt_4c_Refs.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8281: 
8282:             *-- Fase 6: Novos campos editaveis
8283:             loc_oPg.txt_4c_Cor.ReadOnly  = loc_lReadOnly
8284:             loc_oPg.txt_4c_Cor.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)
8285: 
8286:             loc_oPg.txt_4c_Tam.ReadOnly  = loc_lReadOnly

*-- Linhas 8405 a 8448:
8405:     *--------------------------------------------------------------------------
8406:     * LimparCampos - Limpa todos os campos da aba pgDados
8407:     *--------------------------------------------------------------------------
8408:     PROTECTED PROCEDURE LimparCampos()
8409:         LOCAL loc_oPg
8410:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8411: 
8412:         TRY
8413:             *-- Linha 1: Produto
8414:             loc_oPg.txt_4c_Cpros.Value        = ""
8415:             loc_oPg.txt_4c_Dpros.Value        = ""
8416:             *-- Linha 2: Descritivo 2 + Barra
8417:             loc_oPg.txt_4c_DPro2s.Value       = ""
8418:             loc_oPg.txt_4c_Cbar.Value         = ""
8419:             *-- Linha 3: Grupo
8420:             loc_oPg.txt_4c_Cgrus.Value        = ""
8421:             loc_oPg.txt_4c_DgruDisplay.Value  = ""
8422:             *-- Linha 4: Subgrupo
8423:             loc_oPg.txt_4c_Cods.Value         = ""
8424:             loc_oPg.txt_4c_DcodsDisplay.Value = ""
8425:             *-- Linha 5: Linha
8426:             loc_oPg.txt_4c_Lin.Value          = ""
8427:             loc_oPg.txt_4c_DLinDisplay.Value  = ""
8428:             *-- Linha 6: Colecao/Venda
8429:             loc_oPg.txt_4c_Col.Value          = ""
8430:             loc_oPg.txt_4c_DColDisplay.Value  = ""
8431:             *-- Linha 7: Fornecedor
8432:             loc_oPg.txt_4c_Ifor.Value         = ""
8433:             loc_oPg.txt_4c_DforDisplay.Value  = ""
8434:             *-- Linha 8: Ref. Fornecedor + Cor + Tamanho
8435:             loc_oPg.txt_4c_Refs.Value         = ""
8436:             loc_oPg.txt_4c_Cor.Value          = ""
8437:             loc_oPg.txt_4c_Tam.Value          = ""
8438:             *-- Linha 9: Ficha + Peso Base
8439:             loc_oPg.txt_4c_CodFinP.Value      = ""
8440:             loc_oPg.txt_4c_DesFinP.Value      = ""
8441:             loc_oPg.txt_4c_PesoB.Value        = 0.0
8442:             *-- Linha 10: Acabamento + Preco Medio
8443:             loc_oPg.txt_4c_CodAcb.Value       = ""
8444:             loc_oPg.txt_4c_DacbDisplay.Value  = ""
8445:             loc_oPg.txt_4c_Pmedio.Value       = 0.0
8446:             *-- Linha 11: Classificacao + Local
8447:             loc_oPg.txt_4c_Class.Value         = ""
8448:             loc_oPg.txt_4c_DClassDisplay.Value = ""

*-- Linhas 8514 a 11284:
8514:     *--------------------------------------------------------------------------
8515:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
8516:     *--------------------------------------------------------------------------
8517:     PROTECTED PROCEDURE AjustarBotoesPorModo()
8518:         LOCAL loc_oCnt, loc_lTemRegistro
8519:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
8520:         loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
8521: 
8522:         TRY
8523:             loc_oCnt.cmd_4c_Incluir.Enabled    = .T.
8524:             loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
8525:             loc_oCnt.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
8526:             loc_oCnt.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
8527:             loc_oCnt.cmd_4c_Procurar.Enabled   = .T.
8528:         CATCH TO loc_oErro
8529:             MsgErro(loc_oErro.Message, "Erro ao ajustar bot" + CHR(245) + "es")
8530:         ENDTRY
8531:     ENDPROC
8532: 
8533:     *==========================================================================
8534:     * HANDLERS DE BOTOES CRUD
8535:     *==========================================================================
8536: 
8537:     *--------------------------------------------------------------------------
8538:     * BtnIncluirClick - Acao do botao Incluir
8539:     *--------------------------------------------------------------------------
8540:     PROCEDURE BtnIncluirClick()
8541:         THIS.this_oBusinessObject.NovoRegistro()
8542:         THIS.LimparCampos()
8543:         THIS.this_cModoAtual = "INCLUIR"
8544:         THIS.HabilitarCampos(.T.)
8545:         THIS.AlternarPagina(2)
8546:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.txt_4c_Cpros.SetFocus()
8547:     ENDPROC
8548: 
8549:     *--------------------------------------------------------------------------
8550:     * BtnVisualizarClick - Acao do botao Visualizar
8551:     *--------------------------------------------------------------------------
8552:     PROCEDURE BtnVisualizarClick()
8553:         LOCAL loc_cChave
8554: 
8555:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
8556:             MsgAviso("Nenhum registro selecionado.")
8557:             RETURN
8558:         ENDIF
8559: 
8560:         loc_cChave = ALLTRIM(cursor_4c_Dados.pkchaves)
8561: 
8562:         TRY
8563:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
8564:                 THIS.BOParaForm()
8565:                 THIS.this_cModoAtual = "VISUALIZAR"
8566:                 THIS.HabilitarCampos(.F.)
8567:                 THIS.AlternarPagina(2)
8568:             ENDIF
8569:         CATCH TO loc_oErro
8570:             MsgErro(loc_oErro.Message, "Erro ao visualizar registro")
8571:         ENDTRY
8572:     ENDPROC
8573: 
8574:     *--------------------------------------------------------------------------
8575:     * BtnAlterarClick - Acao do botao Alterar
8576:     *--------------------------------------------------------------------------
8577:     PROCEDURE BtnAlterarClick()
8578:         LOCAL loc_cChave
8579: 
8580:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
8581:             MsgAviso("Nenhum registro selecionado.")
8582:             RETURN
8583:         ENDIF
8584: 
8585:         loc_cChave = ALLTRIM(cursor_4c_Dados.pkchaves)
8586: 
8587:         TRY
8588:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
8589:                 THIS.this_oBusinessObject.EditarRegistro()
8590:                 THIS.BOParaForm()
8591:                 THIS.this_cModoAtual = "ALTERAR"
8592:                 THIS.HabilitarCampos(.T.)
8593:                 THIS.AlternarPagina(2)
8594:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.txt_4c_Cpros.SetFocus()
8595:             ENDIF
8596:         CATCH TO loc_oErro
8597:             MsgErro(loc_oErro.Message, "Erro ao alterar registro")
8598:         ENDTRY
8599:     ENDPROC
8600: 
8601:     *--------------------------------------------------------------------------
8602:     * BtnExcluirClick - Acao do botao Excluir
8603:     *--------------------------------------------------------------------------
8604:     PROCEDURE BtnExcluirClick()
8605:         LOCAL loc_cChave
8606: 
8607:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
8608:             MsgAviso("Nenhum registro selecionado.")
8609:             RETURN
8610:         ENDIF
8611: 
8612:         loc_cChave = ALLTRIM(cursor_4c_Dados.pkchaves)
8613: 
8614:         TRY
8615:             IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
8616:                 "Excluir Produto")
8617:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
8618:                     IF THIS.this_oBusinessObject.Excluir()
8619:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Exclu" + CHR(237) + "do")
8620:                         THIS.CarregarLista()
8621:                         THIS.AjustarBotoesPorModo()
8622:                     ELSE
8623:                         MsgErro("Erro ao excluir registro.", "Erro")
8624:                     ENDIF
8625:                 ENDIF
8626:             ENDIF
8627:         CATCH TO loc_oErro
8628:             MsgErro(loc_oErro.Message, "Erro ao excluir registro")
8629:         ENDTRY
8630:     ENDPROC
8631: 
8632:     *--------------------------------------------------------------------------
8633:     * BtnProcurarClick - Acao do botao Procurar (busca e seleciona produto na lista)
8634:     *--------------------------------------------------------------------------
8635:     PROCEDURE BtnProcurarClick()
8636:         LOCAL loc_oBusca, loc_cCpros
8637: 
8638:         TRY
8639:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Busca de Produto")
8640:             loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
8641:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
8642:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
8643:             loc_oBusca.Show()
8644: 
8645:             IF loc_oBusca.this_lSelecionou
8646:                 IF USED("cursor_4c_Busca")
8647:                     SELECT cursor_4c_Busca
8648:                     loc_cCpros = ALLTRIM(cpros)
8649:                     USE IN cursor_4c_Busca
8650:                 ENDIF
8651: 
8652:                 *-- Posiciona grid na linha do produto selecionado
8653:                 IF !EMPTY(loc_cCpros) AND USED("cursor_4c_Dados")
8654:                     SELECT cursor_4c_Dados
8655:                     LOCATE FOR ALLTRIM(cpros) = loc_cCpros
8656:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
8657:                 ENDIF
8658:             ENDIF
8659: 
8660:             IF VARTYPE(loc_oBusca) = "O"
8661:                 loc_oBusca.Release()
8662:                 loc_oBusca = .NULL.
8663:             ENDIF
8664:         CATCH TO loc_oErro
8665:             MsgErro(loc_oErro.Message, "Erro ao procurar produto")
8666:         ENDTRY
8667:     ENDPROC
8668: 
8669:     *--------------------------------------------------------------------------
8670:     * BtnSalvarClick - Acao do botao Salvar
8671:     *--------------------------------------------------------------------------
8672:     PROCEDURE BtnSalvarClick()
8673:         LOCAL loc_oPg
8674: 
8675:         *-- Validar campos obrigatorios
8676:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8677: 
8678:         IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Cpros.Value))
8679:             MsgAviso("Campo Produto " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
8680:             loc_oPg.txt_4c_Cpros.SetFocus()
8681:             RETURN
8682:         ENDIF
8683: 
8684:         IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Cgrus.Value))
8685:             MsgAviso("Campo Grupo " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
8686:             loc_oPg.txt_4c_Cgrus.SetFocus()
8687:             RETURN
8688:         ENDIF
8689: 
8690:         TRY
8691:             THIS.FormParaBO()
8692: 
8693:             IF THIS.this_cModoAtual = "INCLUIR"
8694:                 *-- Gerar pkchaves: char(20), unica
8695:                 THIS.this_oBusinessObject.this_cPkchaves = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)
8696:             ENDIF
8697: 
8698:             IF THIS.this_oBusinessObject.Salvar()
8699:                 THIS.AtualizarSigCdPro()
8700:                 MsgInfo("Registro salvo com sucesso.", "Salvo")
8701:                 THIS.AlternarPagina(1)
8702:             ELSE
8703:                 MsgErro("Erro ao salvar registro.", "Erro")
8704:             ENDIF
8705: 
8706:         CATCH TO loc_oErro
8707:             MsgErro(loc_oErro.Message, "Erro ao salvar")
8708:         ENDTRY
8709:     ENDPROC
8710: 
8711:     *--------------------------------------------------------------------------
8712:     * BtnCancelarClick - Acao do botao Cancelar
8713:     *--------------------------------------------------------------------------
8714:     PROCEDURE BtnCancelarClick()
8715:         THIS.this_oBusinessObject.CancelarEdicao()
8716:         THIS.AlternarPagina(1)
8717:     ENDPROC
8718: 
8719:     *--------------------------------------------------------------------------
8720:     * BtnSairClick - Acao do botao Sair
8721:     *--------------------------------------------------------------------------
8722:     PROCEDURE BtnSairClick()
8723:         THIS.Release()
8724:     ENDPROC
8725: 
8726:     *==========================================================================
8727:     * HANDLERS DE FILTROS
8728:     *==========================================================================
8729: 
8730:     *--------------------------------------------------------------------------
8731:     * FiltroSituacaoChange - Disparado quando muda opcao de situacao no filtro
8732:     *--------------------------------------------------------------------------
8733:     PROCEDURE FiltroSituacaoChange()
8734:         IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
8735:             THIS.CarregarLista()
8736:         ENDIF
8737:     ENDPROC
8738: 
8739:     *==========================================================================
8740:     * HANDLERS DE KEYPRESS (ENTER/TAB/F4 disparam lookup)
8741:     *==========================================================================
8742: 
8743:     *--------------------------------------------------------------------------
8744:     * TxtFilCgruKeyPress - KeyPress no filtro de grupo (ENTER/TAB carrega lista)
8745:     *--------------------------------------------------------------------------
8746:     PROCEDURE TxtFilCgruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8747:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8748:             IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
8749:                 THIS.CarregarLista()
8750:             ENDIF
8751:         ENDIF
8752:     ENDPROC
8753: 
8754:     *--------------------------------------------------------------------------
8755:     * TxtCprosKeyPress - KeyPress no campo Cpros (ENTER/F4 abre lookup SigCdPro)
8756:     *--------------------------------------------------------------------------
8757:     PROCEDURE TxtCprosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8758:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8759:             *-- Validar produto ao sair
8760:             THIS.ValidarCpros()
8761:         ENDIF
8762:         IF par_nKeyCode = 115
8763:             *-- F4 = 115 -> abrir lookup
8764:             THIS.AbrirLookupProduto()
8765:         ENDIF
8766:     ENDPROC
8767: 
8768:     *--------------------------------------------------------------------------
8769:     * TxtCgrusKeyPress - KeyPress no campo Cgrus (ENTER/F4 abre lookup de grupo)
8770:     *--------------------------------------------------------------------------
8771:     PROCEDURE TxtCgrusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8772:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8773:             THIS.ValidarCgrus()
8774:         ENDIF
8775:         IF par_nKeyCode = 115
8776:             THIS.AbrirLookupGrupo()
8777:         ENDIF
8778:     ENDPROC
8779: 
8780:     *--------------------------------------------------------------------------
8781:     * TxtLinKeyPress - KeyPress no campo Lin (ENTER/F4 abre lookup SigCdLin)
8782:     *--------------------------------------------------------------------------
8783:     PROCEDURE TxtLinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8784:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8785:             THIS.ValidarLin()
8786:         ENDIF
8787:         IF par_nKeyCode = 115
8788:             THIS.AbrirLookupLin()
8789:         ENDIF
8790:     ENDPROC
8791: 
8792:     *--------------------------------------------------------------------------
8793:     * TxtColKeyPress - KeyPress no campo Col (ENTER/F4 abre lookup SigCdCol)
8794:     *--------------------------------------------------------------------------
8795:     PROCEDURE TxtColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8796:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8797:             THIS.ValidarCol()
8798:         ENDIF
8799:         IF par_nKeyCode = 115
8800:             THIS.AbrirLookupCol()
8801:         ENDIF
8802:     ENDPROC
8803: 
8804:     *--------------------------------------------------------------------------
8805:     * TxtIforKeyPress - KeyPress no campo Ifor (ENTER/F4 abre lookup fornecedor)
8806:     *--------------------------------------------------------------------------
8807:     PROCEDURE TxtIforKeyPress(par_nKeyCode, par_nShiftAltCtrl)
8808:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
8809:             THIS.ValidarIfor()
8810:         ENDIF
8811:         IF par_nKeyCode = 115
8812:             THIS.AbrirLookupIfor()
8813:         ENDIF
8814:     ENDPROC
8815: 
8816:     *==========================================================================
8817:     * VALIDACOES
8818:     *==========================================================================
8819: 
8820:     *--------------------------------------------------------------------------
8821:     * ValidarCpros - Valida campo cpros e carrega todos os dados do SigCdPro
8822:     *--------------------------------------------------------------------------
8823:     PROTECTED PROCEDURE ValidarCpros()
8824:         LOCAL loc_cCpros, loc_cSQL, loc_oPg
8825:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8826:         loc_cCpros = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
8827: 
8828:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8829:             RETURN
8830:         ENDIF
8831: 
8832:         IF EMPTY(loc_cCpros)
8833:             THIS.CarregarDadosSigCdPro("")
8834:             RETURN
8835:         ENDIF
8836: 
8837:         TRY
8838:             *-- Verificar se produto existe antes de carregar todos os dados
8839:             loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
8840: 
8841:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValPro") > 0
8842:                 SELECT cursor_4c_ValPro
8843:                 IF nExiste > 0
8844:                     IF USED("cursor_4c_ValPro")
8845:                         USE IN cursor_4c_ValPro
8846:                     ENDIF
8847:                     THIS.CarregarDadosSigCdPro(loc_cCpros)
8848:                 ELSE
8849:                     IF USED("cursor_4c_ValPro")
8850:                         USE IN cursor_4c_ValPro
8851:                     ENDIF
8852:                     THIS.CarregarDadosSigCdPro("")
8853:                     MsgAviso("Produto " + loc_cCpros + " n" + CHR(227) + "o encontrado.", "Produto Inv" + CHR(225) + "lido")
8854:                 ENDIF
8855:             ENDIF
8856:         CATCH TO loc_oErro
8857:             MsgErro(loc_oErro.Message, "Erro ao validar produto")
8858:         ENDTRY
8859:     ENDPROC
8860: 
8861:     *--------------------------------------------------------------------------
8862:     * ValidarCgrus - Valida campo cgrus e carrega descricao do grupo
8863:     *--------------------------------------------------------------------------
8864:     PROTECTED PROCEDURE ValidarCgrus()
8865:         LOCAL loc_cCgrus, loc_oPg
8866:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8867:         loc_cCgrus = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
8868: 
8869:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8870:             RETURN
8871:         ENDIF
8872: 
8873:         THIS.CarregarDescGrupo(loc_cCgrus)
8874: 
8875:         IF !EMPTY(loc_cCgrus) AND EMPTY(loc_oPg.txt_4c_DgruDisplay.Value)
8876:             MsgAviso("Grupo " + loc_cCgrus + " n" + CHR(227) + "o encontrado.", "Grupo Inv" + CHR(225) + "lido")
8877:         ENDIF
8878:     ENDPROC
8879: 
8880:     *--------------------------------------------------------------------------
8881:     * ValidarLin - Valida campo lin e carrega descricao da linha (SigCdLin)
8882:     *--------------------------------------------------------------------------
8883:     PROTECTED PROCEDURE ValidarLin()
8884:         LOCAL loc_cClins, loc_oPg
8885:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8886:         loc_cClins = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
8887: 
8888:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8889:             RETURN
8890:         ENDIF
8891: 
8892:         THIS.CarregarDescLin(loc_cClins)
8893: 
8894:         IF !EMPTY(loc_cClins) AND EMPTY(loc_oPg.txt_4c_DLinDisplay.Value)
8895:             MsgAviso("Linha " + loc_cClins + " n" + CHR(227) + "o encontrada.", "Linha Inv" + CHR(225) + "lida")
8896:         ENDIF
8897:     ENDPROC
8898: 
8899:     *--------------------------------------------------------------------------
8900:     * ValidarCol - Valida campo col e carrega descricao do grupo de venda (SigCdCol)
8901:     *--------------------------------------------------------------------------
8902:     PROTECTED PROCEDURE ValidarCol()
8903:         LOCAL loc_cCcols, loc_oPg
8904:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8905:         loc_cCcols = ALLTRIM(loc_oPg.txt_4c_Col.Value)
8906: 
8907:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8908:             RETURN
8909:         ENDIF
8910: 
8911:         THIS.CarregarDescCol(loc_cCcols)
8912: 
8913:         IF !EMPTY(loc_cCcols) AND EMPTY(loc_oPg.txt_4c_DColDisplay.Value)
8914:             MsgAviso("Grupo de venda " + loc_cCcols + " n" + CHR(227) + "o encontrado.", "Inv" + CHR(225) + "lido")
8915:         ENDIF
8916:     ENDPROC
8917: 
8918:     *--------------------------------------------------------------------------
8919:     * ValidarIfor - Valida campo ifor e carrega nome do fornecedor
8920:     *--------------------------------------------------------------------------
8921:     PROTECTED PROCEDURE ValidarIfor()
8922:         LOCAL loc_cIfors, loc_oPg
8923:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8924:         loc_cIfors = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)
8925: 
8926:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8927:             RETURN
8928:         ENDIF
8929: 
8930:         THIS.CarregarDescIfor(loc_cIfors)
8931: 
8932:         IF !EMPTY(loc_cIfors) AND EMPTY(loc_oPg.txt_4c_DforDisplay.Value)
8933:             MsgAviso("Fornecedor " + loc_cIfors + " n" + CHR(227) + "o encontrado.", "Inv" + CHR(225) + "lido")
8934:         ENDIF
8935:     ENDPROC
8936: 
8937:     *==========================================================================
8938:     * LOOKUPS (FormBuscaAuxiliar)
8939:     *==========================================================================
8940: 
8941:     *--------------------------------------------------------------------------
8942:     * AbrirLookupProduto - Abre busca de produto (SigCdPro)
8943:     *--------------------------------------------------------------------------
8944:     PROCEDURE AbrirLookupProduto()
8945:         LOCAL loc_oBusca, loc_oPg
8946:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8947: 
8948:         TRY
8949:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Busca de Produto")
8950:             loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
8951:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
8952:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
8953:             loc_oBusca.Show()
8954: 
8955:             IF loc_oBusca.this_lSelecionou
8956:                 IF USED("cursor_4c_Busca")
8957:                     SELECT cursor_4c_Busca
8958:                     loc_oPg.txt_4c_Cpros.Value = ALLTRIM(cpros)
8959:                     loc_oPg.txt_4c_Dpros.Value = ALLTRIM(dpros)
8960:                     USE IN cursor_4c_Busca
8961:                 ENDIF
8962:             ENDIF
8963: 
8964:             loc_oBusca.Release()
8965:             loc_oBusca = .NULL.
8966:         CATCH TO loc_oErro
8967:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de produto")
8968:         ENDTRY
8969:     ENDPROC
8970: 
8971:     *--------------------------------------------------------------------------
8972:     * AbrirLookupGrupo - Abre busca de grupo (SigCdGrp)
8973:     *--------------------------------------------------------------------------
8974:     PROCEDURE AbrirLookupGrupo()
8975:         LOCAL loc_oBusca, loc_oPg
8976:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8977: 
8978:         TRY
8979:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", "cursor_4c_Busca", "cgrus", "", "Busca de Grupo")
8980:             loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
8981:             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
8982:             loc_oBusca.Show()
8983: 
8984:             IF loc_oBusca.this_lSelecionou
8985:                 IF USED("cursor_4c_Busca")
8986:                     SELECT cursor_4c_Busca
8987:                     loc_oPg.txt_4c_Cgrus.Value       = ALLTRIM(cgrus)
8988:                     loc_oPg.txt_4c_DgruDisplay.Value = ALLTRIM(dgrus)
8989:                     USE IN cursor_4c_Busca
8990:                 ENDIF
8991:             ENDIF
8992: 
8993:             loc_oBusca.Release()
8994:             loc_oBusca = .NULL.
8995:         CATCH TO loc_oErro
8996:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo")
8997:         ENDTRY
8998:     ENDPROC
8999: 
9000:     *--------------------------------------------------------------------------
9001:     * AbrirLookupLin - Abre busca de linha (SigCdLin)
9002:     *--------------------------------------------------------------------------
9003:     PROCEDURE AbrirLookupLin()
9004:         LOCAL loc_oBusca, loc_oPg
9005:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9006: 
9007:         TRY
9008:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLin", "cursor_4c_Busca", "clins", "", "Busca de Linha")
9009:             loc_oBusca.mAddColuna("clins", "", "C" + CHR(243) + "digo")
9010:             loc_oBusca.mAddColuna("dlins", "", "Descri" + CHR(231) + CHR(227) + "o")
9011:             loc_oBusca.Show()
9012: 
9013:             IF loc_oBusca.this_lSelecionou
9014:                 IF USED("cursor_4c_Busca")
9015:                     SELECT cursor_4c_Busca
9016:                     loc_oPg.txt_4c_Lin.Value          = ALLTRIM(clins)
9017:                     loc_oPg.txt_4c_DLinDisplay.Value  = ALLTRIM(dlins)
9018:                     USE IN cursor_4c_Busca
9019:                 ENDIF
9020:             ENDIF
9021: 
9022:             loc_oBusca.Release()
9023:             loc_oBusca = .NULL.
9024:         CATCH TO loc_oErro
9025:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de linha")
9026:         ENDTRY
9027:     ENDPROC
9028: 
9029:     *--------------------------------------------------------------------------
9030:     * AbrirLookupCol - Abre busca de grupo de venda (SigCdCol)
9031:     *--------------------------------------------------------------------------
9032:     PROCEDURE AbrirLookupCol()
9033:         LOCAL loc_oBusca, loc_oPg
9034:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9035: 
9036:         TRY
9037:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", "cursor_4c_Busca", "ccols", "", "Busca de Grupo de Venda")
9038:             loc_oBusca.mAddColuna("ccols", "", "C" + CHR(243) + "digo")
9039:             loc_oBusca.mAddColuna("dcols", "", "Descri" + CHR(231) + CHR(227) + "o")
9040:             loc_oBusca.Show()
9041: 
9042:             IF loc_oBusca.this_lSelecionou
9043:                 IF USED("cursor_4c_Busca")
9044:                     SELECT cursor_4c_Busca
9045:                     loc_oPg.txt_4c_Col.Value          = ALLTRIM(ccols)
9046:                     loc_oPg.txt_4c_DColDisplay.Value  = ALLTRIM(dcols)
9047:                     USE IN cursor_4c_Busca
9048:                 ENDIF
9049:             ENDIF
9050: 
9051:             loc_oBusca.Release()
9052:             loc_oBusca = .NULL.
9053:         CATCH TO loc_oErro
9054:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo de venda")
9055:         ENDTRY
9056:     ENDPROC
9057: 
9058:     *--------------------------------------------------------------------------
9059:     * AbrirLookupIfor - Abre busca de fornecedor (SigCdCli)
9060:     *--------------------------------------------------------------------------
9061:     PROCEDURE AbrirLookupIfor()
9062:         LOCAL loc_oBusca, loc_oPg
9063:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9064: 
9065:         TRY
9066:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_Busca", "Iclis", "", "Busca de Fornecedor")
9067:             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
9068:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
9069:             loc_oBusca.Show()
9070: 
9071:             IF loc_oBusca.this_lSelecionou
9072:                 IF USED("cursor_4c_Busca")
9073:                     SELECT cursor_4c_Busca
9074:                     loc_oPg.txt_4c_Ifor.Value         = ALLTRIM(Iclis)
9075:                     loc_oPg.txt_4c_DforDisplay.Value  = ALLTRIM(Rclis)
9076:                     USE IN cursor_4c_Busca
9077:                 ENDIF
9078:             ENDIF
9079: 
9080:             loc_oBusca.Release()
9081:             loc_oBusca = .NULL.
9082:         CATCH TO loc_oErro
9083:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de fornecedor")
9084:         ENDTRY
9085:     ENDPROC
9086: 
9087:     *==========================================================================
9088:     * HANDLERS DE KEYPRESS - FASE 6 (novos campos com lookup)
9089:     *==========================================================================
9090: 
9091:     *--------------------------------------------------------------------------
9092:     * TxtCorKeyPress - KeyPress no campo Cor (ENTER/F4 abre lookup SigCdCor)
9093:     *--------------------------------------------------------------------------
9094:     PROCEDURE TxtCorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9095:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9096:             THIS.ValidarCor()
9097:         ENDIF
9098:         IF par_nKeyCode = 115
9099:             THIS.AbrirLookupCor()
9100:         ENDIF
9101:     ENDPROC
9102: 
9103:     *--------------------------------------------------------------------------
9104:     * TxtTamKeyPress - KeyPress no campo Tamanho (ENTER/F4 abre lookup SigCdTam)
9105:     *--------------------------------------------------------------------------
9106:     PROCEDURE TxtTamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9107:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9108:             THIS.ValidarTam()
9109:         ENDIF
9110:         IF par_nKeyCode = 115
9111:             THIS.AbrirLookupTam()
9112:         ENDIF
9113:     ENDPROC
9114: 
9115:     *--------------------------------------------------------------------------
9116:     * TxtCodFinPKeyPress - KeyPress no campo Ficha (ENTER/F4 abre lookup SigCdFip)
9117:     *--------------------------------------------------------------------------
9118:     PROCEDURE TxtCodFinPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9119:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9120:             THIS.ValidarCodFinP()
9121:         ENDIF
9122:         IF par_nKeyCode = 115
9123:             THIS.AbrirLookupFinP()
9124:         ENDIF
9125:     ENDPROC
9126: 
9127:     *--------------------------------------------------------------------------
9128:     * TxtCodAcbKeyPress - KeyPress no campo Acabamento (ENTER/F4 abre lookup SigCdAca)
9129:     *--------------------------------------------------------------------------
9130:     PROCEDURE TxtCodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9131:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9132:             THIS.ValidarCodAcb()
9133:         ENDIF
9134:         IF par_nKeyCode = 115
9135:             THIS.AbrirLookupAcb()
9136:         ENDIF
9137:     ENDPROC
9138: 
9139:     *--------------------------------------------------------------------------
9140:     * TxtClassKeyPress - KeyPress no campo Classe (ENTER/F4 abre lookup SIGCDCLS)
9141:     *--------------------------------------------------------------------------
9142:     PROCEDURE TxtClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9143:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9144:             THIS.ValidarClass()
9145:         ENDIF
9146:         IF par_nKeyCode = 115
9147:             THIS.AbrirLookupClass()
9148:         ENDIF
9149:     ENDPROC
9150: 
9151:     *--------------------------------------------------------------------------
9152:     * TxtLocalKeyPress - KeyPress no campo Local (ENTER/F4 abre lookup SigPrLcl)
9153:     *--------------------------------------------------------------------------
9154:     PROCEDURE TxtLocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9155:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9156:             THIS.ValidarLocal()
9157:         ENDIF
9158:         IF par_nKeyCode = 115
9159:             THIS.AbrirLookupLocal()
9160:         ENDIF
9161:     ENDPROC
9162: 
9163:     *--------------------------------------------------------------------------
9164:     * TxtCuniKeyPress - KeyPress no campo Unidade (ENTER/F4 abre lookup SigCdUni)
9165:     *--------------------------------------------------------------------------
9166:     PROCEDURE TxtCuniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9167:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9168:             THIS.ValidarCuni()
9169:         ENDIF
9170:         IF par_nKeyCode = 115
9171:             THIS.AbrirLookupUni()
9172:         ENDIF
9173:     ENDPROC
9174: 
9175:     *--------------------------------------------------------------------------
9176:     * TxtCunipKeyPress - KeyPress no campo Uni.Pedido (ENTER/F4 abre lookup SigCdUni)
9177:     *--------------------------------------------------------------------------
9178:     PROCEDURE TxtCunipKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9179:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9180:             THIS.ValidarCunip()
9181:         ENDIF
9182:         IF par_nKeyCode = 115
9183:             THIS.AbrirLookupUniP()
9184:         ENDIF
9185:     ENDPROC
9186: 
9187:     *--------------------------------------------------------------------------
9188:     * TxtMctotalKeyPress - KeyPress no campo Moeda Custo (ENTER/F4 abre lookup SigCdMoe)
9189:     *--------------------------------------------------------------------------
9190:     PROCEDURE TxtMctotalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9191:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9192:             THIS.ValidarMoe("total")
9193:         ENDIF
9194:         IF par_nKeyCode = 115
9195:             THIS.AbrirLookupMctotal()
9196:         ENDIF
9197:     ENDPROC
9198: 
9199:     *--------------------------------------------------------------------------
9200:     * TxtMpvendaKeyPress - KeyPress no campo Moeda P.Venda (ENTER/F4 abre lookup SigCdMoe)
9201:     *--------------------------------------------------------------------------
9202:     PROCEDURE TxtMpvendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9203:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9204:             THIS.ValidarMoe("pvenda")
9205:         ENDIF
9206:         IF par_nKeyCode = 115
9207:             THIS.AbrirLookupMpvenda()
9208:         ENDIF
9209:     ENDPROC
9210: 
9211:     *--------------------------------------------------------------------------
9212:     * TxtMfvendaKeyPress - KeyPress no campo Moeda F.Venda (ENTER/F4 abre lookup SigCdMoe)
9213:     *--------------------------------------------------------------------------
9214:     PROCEDURE TxtMfvendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9215:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9216:             THIS.ValidarMoe("fvenda")
9217:         ENDIF
9218:         IF par_nKeyCode = 115
9219:             THIS.AbrirLookupMfvenda()
9220:         ENDIF
9221:     ENDPROC
9222: 
9223:     *==========================================================================
9224:     * HANDLERS - FASE 9 - pgComposicao
9225:     *==========================================================================
9226: 
9227:     *--------------------------------------------------------------------------
9228:     * GrdCompoAfterRowColChange - AfterRowColChange do grid de composicao
9229:     * Refresha campos de descricao e observacao da OF quando muda a linha
9230:     *--------------------------------------------------------------------------
9231:     PROCEDURE GrdCompoAfterRowColChange(par_nColIndex)
9232:         LOCAL loc_oPg
9233:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9234:         IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
9235:             loc_oPg.txt_4c_DescComp.Value = ALLTRIM(cursor_4c_Compo.dcompos)
9236:             loc_oPg.txt_4c_ObsOFs.Value   = ALLTRIM(cursor_4c_Compo.obscompos)
9237:         ELSE
9238:             loc_oPg.txt_4c_DescComp.Value = ""
9239:             loc_oPg.txt_4c_ObsOFs.Value   = ""
9240:         ENDIF
9241:     ENDPROC
9242: 
9243:     *--------------------------------------------------------------------------
9244:     * GrdSubCpAfterRowColChange - AfterRowColChange do grid de sub-composicao
9245:     *--------------------------------------------------------------------------
9246:     PROCEDURE GrdSubCpAfterRowColChange(par_nColIndex)
9247:         LOCAL loc_oPg
9248:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9249:         IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
9250:             loc_oPg.txt_4c_DescSubCp.Value = ALLTRIM(cursor_4c_SubCp.dcompos)
9251:             loc_oPg.txt_4c_MatSubs.Value   = ALLTRIM(cursor_4c_SubCp.matsubs)
9252:         ELSE
9253:             loc_oPg.txt_4c_DescSubCp.Value = ""
9254:             loc_oPg.txt_4c_MatSubs.Value   = ""
9255:         ENDIF
9256:     ENDPROC
9257: 
9258:     *--------------------------------------------------------------------------
9259:     * ChkLiberaCustoClick - habilitar/desabilitar campos de custo
9260:     *--------------------------------------------------------------------------
9261:     PROCEDURE ChkLiberaCustoClick()
9262:         LOCAL loc_oPg, loc_lLiberado
9263:         loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9264:         loc_lLiberado = (loc_oPg.chk_4c_LiberaCusto.Value = 1)
9265:         loc_oPg.txt_4c_Pcus.ReadOnly      = !loc_lLiberado
9266:         loc_oPg.txt_4c_Fcusto.ReadOnly    = !loc_lLiberado
9267:         loc_oPg.txt_4c_Moec.ReadOnly      = !loc_lLiberado
9268:         loc_oPg.txt_4c_Moepc.ReadOnly     = !loc_lLiberado
9269:         loc_oPg.txt_4c_CotaCalcP.ReadOnly = !loc_lLiberado
9270:         IF loc_lLiberado
9271:             loc_oPg.txt_4c_Pcus.BackColor   = RGB(255, 255, 255)
9272:             loc_oPg.txt_4c_Fcusto.BackColor  = RGB(255, 255, 255)
9273:             loc_oPg.txt_4c_CotaCalcP.BackColor = RGB(255, 255, 255)
9274:         ELSE
9275:             loc_oPg.txt_4c_Pcus.BackColor   = RGB(224, 235, 235)
9276:             loc_oPg.txt_4c_Fcusto.BackColor  = RGB(224, 235, 235)
9277:             loc_oPg.txt_4c_CotaCalcP.BackColor = RGB(224, 235, 235)
9278:         ENDIF
9279:     ENDPROC
9280: 
9281:     *--------------------------------------------------------------------------
9282:     * ChkLiberaVendaClick - habilitar/desabilitar campos de venda
9283:     *--------------------------------------------------------------------------
9284:     PROCEDURE ChkLiberaVendaClick()
9285:         LOCAL loc_oPg, loc_lLiberado
9286:         loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9287:         loc_lLiberado = (loc_oPg.chk_4c_LiberaVenda.Value = 1)
9288:         loc_oPg.txt_4c_FAtuals.ReadOnly = !loc_lLiberado
9289:         loc_oPg.txt_4c_Fideals.ReadOnly = !loc_lLiberado
9290:         IF loc_lLiberado
9291:             loc_oPg.txt_4c_FAtuals.BackColor = RGB(255, 255, 255)
9292:             loc_oPg.txt_4c_Fideals.BackColor = RGB(255, 255, 255)
9293:         ELSE
9294:             loc_oPg.txt_4c_FAtuals.BackColor = RGB(224, 235, 235)
9295:             loc_oPg.txt_4c_Fideals.BackColor = RGB(224, 235, 235)
9296:         ENDIF
9297:     ENDPROC
9298: 
9299:     *--------------------------------------------------------------------------
9300:     * TxtPcusValid - Valid no campo Preco de Custo -> recalcula precos
9301:     *--------------------------------------------------------------------------
9302:     PROCEDURE TxtPcusValid()
9303:         THIS.CalcPrecoComposicao()
9304:     ENDPROC
9305: 
9306:     *--------------------------------------------------------------------------
9307:     * TxtFcustoValid - Valid no campo Fator de Custo -> recalcula precos
9308:     *--------------------------------------------------------------------------
9309:     PROCEDURE TxtFcustoValid()
9310:         THIS.CalcPrecoComposicao()
9311:     ENDPROC
9312: 
9313:     *--------------------------------------------------------------------------
9314:     * TxtMargemValid - Valid na Margem/MKP -> recalcula precos
9315:     *--------------------------------------------------------------------------
9316:     PROCEDURE TxtMargemValid()
9317:         THIS.CalcPrecoComposicao()
9318:     ENDPROC
9319: 
9320:     *--------------------------------------------------------------------------
9321:     * TxtMarkupAValid - Valid no MarkupA -> recalcula precos
9322:     *--------------------------------------------------------------------------
9323:     PROCEDURE TxtMarkupAValid()
9324:         THIS.CalcPrecoComposicao()
9325:     ENDPROC
9326: 
9327:     *--------------------------------------------------------------------------
9328:     * TxtCotaCalcPValid - Valid na Cotacao -> recalcula precos
9329:     *--------------------------------------------------------------------------
9330:     PROCEDURE TxtCotaCalcPValid()
9331:         THIS.CalcPrecoComposicao()
9332:         LOCAL loc_oPg
9333:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9334:         loc_oPg.Refresh()
9335:     ENDPROC
9336: 
9337:     *--------------------------------------------------------------------------
9338:     * TxtMoecKeyPress - KeyPress no campo Moeda Custo (ENTER/F4 abre lookup SigCdMoe)
9339:     *--------------------------------------------------------------------------
9340:     PROCEDURE TxtMoecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9341:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9342:             THIS.ValidarMoeCompo("moec")
9343:         ENDIF
9344:         IF par_nKeyCode = 115
9345:             THIS.AbrirLookupMoeCompo("moec")
9346:         ENDIF
9347:     ENDPROC
9348: 
9349:     *--------------------------------------------------------------------------
9350:     * TxtMoepcKeyPress - KeyPress no campo Moeda P.Custo (ENTER/F4 abre lookup SigCdMoe)
9351:     *--------------------------------------------------------------------------
9352:     PROCEDURE TxtMoepcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9353:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9354:             THIS.ValidarMoeCompo("moepc")
9355:         ENDIF
9356:         IF par_nKeyCode = 115
9357:             THIS.AbrirLookupMoeCompo("moepc")
9358:         ENDIF
9359:     ENDPROC
9360: 
9361:     *--------------------------------------------------------------------------
9362:     * TxtMoedaKeyPress - KeyPress no campo Moeda Venda (ENTER/F4 abre lookup SigCdMoe)
9363:     *--------------------------------------------------------------------------
9364:     PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9365:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9366:             THIS.ValidarMoeCompo("moeda")
9367:         ENDIF
9368:         IF par_nKeyCode = 115
9369:             THIS.AbrirLookupMoeCompo("moeda")
9370:         ENDIF
9371:     ENDPROC
9372: 
9373:     *--------------------------------------------------------------------------
9374:     * TxtMoepvKeyPress - KeyPress no campo Moeda P.Venda (ENTER/F4 abre lookup SigCdMoe)
9375:     *--------------------------------------------------------------------------
9376:     PROCEDURE TxtMoepvKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9377:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9378:             THIS.ValidarMoeCompo("moepv")
9379:         ENDIF
9380:         IF par_nKeyCode = 115
9381:             THIS.AbrirLookupMoeCompo("moepv")
9382:         ENDIF
9383:     ENDPROC
9384: 
9385:     *--------------------------------------------------------------------------
9386:     * ValidarMoeCompo - Valida campo de moeda na pagina composicao
9387:     * par_cTipo: "moec"|"moepc"|"moeda"|"moepv"
9388:     *--------------------------------------------------------------------------
9389:     PROTECTED PROCEDURE ValidarMoeCompo(par_cTipo)
9390:         LOCAL loc_oPg, loc_oTxt, loc_cCodMoe, loc_cSQL, loc_lOk
9391:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9392:         DO CASE
9393:         CASE par_cTipo = "moec"
9394:             loc_oTxt = loc_oPg.txt_4c_Moec
9395:         CASE par_cTipo = "moepc"
9396:             loc_oTxt = loc_oPg.txt_4c_Moepc
9397:         CASE par_cTipo = "moeda"
9398:             loc_oTxt = loc_oPg.txt_4c_Moeda
9399:         CASE par_cTipo = "moepv"
9400:             loc_oTxt = loc_oPg.txt_4c_Moepv
9401:         OTHERWISE
9402:             RETURN
9403:         ENDCASE
9404:         loc_cCodMoe = ALLTRIM(loc_oTxt.Value)
9405:         IF EMPTY(loc_cCodMoe)
9406:             RETURN
9407:         ENDIF
9408:         loc_lOk = .F.
9409:         TRY
9410:             loc_cSQL = "SELECT cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCodMoe)
9411:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeCompo") > 0
9412:                 loc_lOk = .T.
9413:             ENDIF
9414:         CATCH TO loc_oErro
9415:             MsgErro(loc_oErro.Message, "Erro ao validar moeda")
9416:         ENDTRY
9417:         IF loc_lOk
9418:             IF EOF("cursor_4c_BuscaMoeCompo")
9419:                 MsgAviso("Moeda " + loc_cCodMoe + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9420:                 loc_oTxt.Value = ""
9421:             ENDIF
9422:             IF USED("cursor_4c_BuscaMoeCompo")
9423:                 USE IN cursor_4c_BuscaMoeCompo
9424:             ENDIF
9425:         ENDIF
9426:     ENDPROC
9427: 
9428:     *--------------------------------------------------------------------------
9429:     * AbrirLookupMoeCompo - Abre lookup de moeda na pagina composicao
9430:     *--------------------------------------------------------------------------
9431:     PROTECTED PROCEDURE AbrirLookupMoeCompo(par_cTipo)
9432:         LOCAL loc_oBusca, loc_oPg, loc_oTxt
9433:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9434:         DO CASE
9435:         CASE par_cTipo = "moec"
9436:             loc_oTxt = loc_oPg.txt_4c_Moec
9437:         CASE par_cTipo = "moepc"
9438:             loc_oTxt = loc_oPg.txt_4c_Moepc
9439:         CASE par_cTipo = "moeda"
9440:             loc_oTxt = loc_oPg.txt_4c_Moeda
9441:         CASE par_cTipo = "moepv"
9442:             loc_oTxt = loc_oPg.txt_4c_Moepv
9443:         OTHERWISE
9444:             RETURN
9445:         ENDCASE
9446:         TRY
9447:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
9448:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo", .T.)
9449:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o", .F.)
9450:             loc_oBusca.this_cTabela    = "SigCdMoe"
9451:             loc_oBusca.this_cCampoBusca = "cmoes"
9452:             loc_oBusca.this_cValorInicial = ALLTRIM(loc_oTxt.Value)
9453:             loc_oBusca.Show()
9454:             IF loc_oBusca.this_lSelecionou
9455:                 loc_oTxt.Value = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
9456:             ENDIF
9457:             IF USED("cursor_4c_BuscaAuxMoe")
9458:                 USE IN cursor_4c_BuscaAuxMoe
9459:             ENDIF
9460:             loc_oBusca.Release()
9461:         CATCH TO loc_oErro
9462:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de moeda")
9463:         ENDTRY
9464:     ENDPROC
9465: 
9466:     *--------------------------------------------------------------------------
9467:     * CalcPrecoComposicao - Recalcula precos baseado nos valores de custo/margem
9468:     * Equivalente ao CalcPreco/CalcPreMoe do legado (stub - logica completa no BO)
9469:     *--------------------------------------------------------------------------
9470:     PROTECTED PROCEDURE CalcPrecoComposicao()
9471:         LOCAL loc_oPg, loc_nPcus, loc_nMargem, loc_nPven
9472:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9473:         loc_nPcus  = loc_oPg.txt_4c_Pcus.Value
9474:         loc_nMargem = loc_oPg.txt_4c_Margem.Value
9475:         *-- Calculo simplificado: Preco Venda = Custo * (1 + Margem/100)
9476:         *-- O calculo completo com fatores/moedas sera feito via BO
9477:         IF loc_nMargem > 0 AND loc_nPcus > 0
9478:             loc_nPven = loc_nPcus * (1 + loc_nMargem / 100)
9479:             loc_oPg.txt_4c_Pvens.Value = loc_nPven
9480:         ENDIF
9481:     ENDPROC
9482: 
9483:     *--------------------------------------------------------------------------
9484:     * CmdCalcValsClick - Botao Calcular Valores (cmdCalcVals)
9485:     * Aciona recalculo completo de precos (equivalente ao CalcPreco do legado)
9486:     *--------------------------------------------------------------------------
9487:     PROCEDURE CmdCalcValsClick()
9488:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9489:             RETURN
9490:         ENDIF
9491:         THIS.CalcPrecoComposicao()
9492:     ENDPROC
9493: 
9494:     *--------------------------------------------------------------------------
9495:     * CmdPesoMClick - Botao calcular peso medio (abre form sigcdpes)
9496:     *--------------------------------------------------------------------------
9497:     PROCEDURE CmdPesoMClick()
9498:         MsgAviso("Fun" + CHR(231) + CHR(227) + "o de c" + CHR(225) + "lculo de peso n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Peso M" + CHR(233) + "dio")
9499:     ENDPROC
9500: 
9501:     *--------------------------------------------------------------------------
9502:     * CmdgCompoClick - Click no CommandGroup de composicao (5 botoes)
9503:     * .Value=1 Inserir | 2 Excluir | 3 Atualizar Custo | 4 Atualizar Preco | 5 Atualizar Pesos
9504:     *--------------------------------------------------------------------------
9505:     PROCEDURE CmdgCompoClick()
9506:         LOCAL loc_oPg, loc_nBtn, loc_oGrd
9507:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9508:         loc_nBtn = loc_oPg.obj_4c_CmdgCompo.Value
9509:         loc_oGrd = loc_oPg.grd_4c_Compo
9510: 
9511:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9512:             RETURN
9513:         ENDIF
9514: 
9515:         DO CASE
9516:         CASE loc_nBtn = 1
9517:             *-- Inserir item de composicao
9518:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9519:                 MsgAviso("Selecione o modo Incluir ou Alterar para inserir itens.", "Aten" + CHR(231) + CHR(227) + "o")
9520:                 RETURN
9521:             ENDIF
9522:             IF USED("cursor_4c_Compo")
9523:                 SELECT cursor_4c_Compo
9524:                 APPEND BLANK
9525:                 loc_oGrd.Refresh()
9526:             ENDIF
9527: 
9528:         CASE loc_nBtn = 2
9529:             *-- Excluir item de composicao
9530:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9531:                 RETURN
9532:             ENDIF
9533:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
9534:                 IF MsgConfirma("Excluir o item selecionado?", "Confirmar")
9535:                     SELECT cursor_4c_Compo
9536:                     DELETE
9537:                     IF !EOF("cursor_4c_Compo")
9538:                         SKIP
9539:                         SKIP -1
9540:                     ENDIF
9541:                     loc_oGrd.Refresh()
9542:                 ENDIF
9543:             ENDIF
9544: 
9545:         CASE loc_nBtn = 3
9546:             *-- Atualizar custo
9547:             THIS.CalcPrecoComposicao()
9548: 
9549:         CASE loc_nBtn = 4
9550:             *-- Atualizar preco
9551:             THIS.CalcPrecoComposicao()
9552: 
9553:         CASE loc_nBtn = 5
9554:             *-- Atualizar pesos
9555:             THIS.CmdPesoMClick()
9556: 
9557:         ENDCASE
9558:     ENDPROC
9559: 
9560:     *--------------------------------------------------------------------------
9561:     * CmdgSubCpClick - Click no CommandGroup de sub-composicao (2 botoes)
9562:     * .Value=1 Inserir | 2 Excluir
9563:     *--------------------------------------------------------------------------
9564:     PROCEDURE CmdgSubCpClick()
9565:         LOCAL loc_oPg, loc_nBtn, loc_oGrd
9566:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9567:         loc_nBtn = loc_oPg.obj_4c_CmdgSubCp.Value
9568:         loc_oGrd = loc_oPg.grd_4c_SubCp
9569: 
9570:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9571:             RETURN
9572:         ENDIF
9573: 
9574:         DO CASE
9575:         CASE loc_nBtn = 1
9576:             *-- Inserir item de sub-composicao
9577:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9578:                 MsgAviso("Selecione o modo Incluir ou Alterar para inserir itens.", "Aten" + CHR(231) + CHR(227) + "o")
9579:                 RETURN
9580:             ENDIF
9581:             IF USED("cursor_4c_SubCp")
9582:                 SELECT cursor_4c_SubCp
9583:                 APPEND BLANK
9584:                 loc_oGrd.Refresh()
9585:             ENDIF
9586: 
9587:         CASE loc_nBtn = 2
9588:             *-- Excluir item de sub-composicao
9589:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9590:                 RETURN
9591:             ENDIF
9592:             IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
9593:                 IF MsgConfirma("Excluir o sub-item selecionado?", "Confirmar")
9594:                     SELECT cursor_4c_SubCp
9595:                     DELETE
9596:                     IF !EOF("cursor_4c_SubCp")
9597:                         SKIP
9598:                         SKIP -1
9599:                     ENDIF
9600:                     loc_oGrd.Refresh()
9601:                 ENDIF
9602:             ENDIF
9603: 
9604:         ENDCASE
9605:     ENDPROC
9606: 
9607:     *--------------------------------------------------------------------------
9608:     * GrdCustoCompoAfterRowColChange - AfterRowColChange do grid Custo
9609:     * Atualiza txt_4c_Desc (descricao item) e txt_4c_DGruCompos (desc grupo)
9610:     *--------------------------------------------------------------------------
9611:     PROCEDURE GrdCustoCompoAfterRowColChange(par_nColIndex)
9612:         LOCAL loc_oPg, loc_cGrupo, loc_nRet, loc_oErro
9613:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9614: 
9615:         IF USED("cursor_4c_CustoCompo") AND !EOF("cursor_4c_CustoCompo")
9616:             loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_CustoCompo.dcompos)
9617:             loc_cGrupo = ALLTRIM(cursor_4c_CustoCompo.CGrus)
9618:             IF !EMPTY(loc_cGrupo)
9619:                 TRY
9620:                     loc_nRet = SQLEXEC(gnConnHandle, ;
9621:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cGrupo), ;
9622:                         "cursor_4c_GruCustoDesc")
9623:                     IF loc_nRet > 0 AND USED("cursor_4c_GruCustoDesc") AND !EOF("cursor_4c_GruCustoDesc")
9624:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_GruCustoDesc.DGrus)
9625:                     ELSE
9626:                         loc_oPg.txt_4c_DGruCompos.Value = ""
9627:                     ENDIF
9628:                     IF USED("cursor_4c_GruCustoDesc")
9629:                         USE IN cursor_4c_GruCustoDesc
9630:                     ENDIF
9631:                 CATCH TO loc_oErro
9632:                     MsgErro(loc_oErro.Message, "Erro ao buscar grupo da composi" + CHR(231) + CHR(227) + "o")
9633:                 ENDTRY
9634:             ELSE
9635:                 loc_oPg.txt_4c_DGruCompos.Value = ""
9636:             ENDIF
9637:         ELSE
9638:             loc_oPg.txt_4c_Desc.Value       = ""
9639:             loc_oPg.txt_4c_DGruCompos.Value = ""
9640:         ENDIF
9641:     ENDPROC
9642: 
9643:     *--------------------------------------------------------------------------
9644:     * CmdgCustoClick - Click no CommandGroup de composicao Custo (2 botoes)
9645:     * .Value=1 Inserir | .Value=2 Excluir
9646:     *--------------------------------------------------------------------------
9647:     PROCEDURE CmdgCustoClick()
9648:         LOCAL loc_oPg, loc_nBtn, loc_oGrd
9649:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9650:         loc_nBtn = loc_oPg.obj_4c_CmdgCusto.Value
9651:         loc_oGrd = loc_oPg.grd_4c_CustoCompo
9652: 
9653:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9654:             RETURN
9655:         ENDIF
9656: 
9657:         DO CASE
9658:         CASE loc_nBtn = 1
9659:             *-- Inserir item de composicao custo
9660:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9661:                 MsgAviso("Selecione o modo Incluir ou Alterar para inserir itens.", "Aten" + CHR(231) + CHR(227) + "o")
9662:                 RETURN
9663:             ENDIF
9664:             IF USED("cursor_4c_CustoCompo")
9665:                 SELECT cursor_4c_CustoCompo
9666:                 APPEND BLANK
9667:                 loc_oGrd.Refresh()
9668:             ENDIF
9669: 
9670:         CASE loc_nBtn = 2
9671:             *-- Excluir item de composicao custo
9672:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9673:                 RETURN
9674:             ENDIF
9675:             IF USED("cursor_4c_CustoCompo") AND !EOF("cursor_4c_CustoCompo")
9676:                 IF MsgConfirma("Excluir o item selecionado?", "Confirmar")
9677:                     SELECT cursor_4c_CustoCompo
9678:                     DELETE
9679:                     IF !EOF("cursor_4c_CustoCompo")
9680:                         SKIP
9681:                         SKIP -1
9682:                     ENDIF
9683:                     loc_oGrd.Refresh()
9684:                 ENDIF
9685:             ENDIF
9686: 
9687:         ENDCASE
9688:     ENDPROC
9689: 
9690:     *--------------------------------------------------------------------------
9691:     * CboTiposCustoInteractiveChange - InteractiveChange do cmbTipos na aba Custo
9692:     * Filtra/recarrega grid de composicao pelo tipo selecionado
9693:     *--------------------------------------------------------------------------
9694:     PROCEDURE CboTiposCustoInteractiveChange()
9695:         LOCAL loc_oPg
9696:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9697: 
9698:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9699:             RETURN
9700:         ENDIF
9701: 
9702:         IF USED("cursor_4c_CustoCompo")
9703:             GO TOP IN cursor_4c_CustoCompo
9704:         ENDIF
9705:         loc_oPg.grd_4c_CustoCompo.Refresh()
9706:     ENDPROC
9707: 
9708:     *==========================================================================
9709:     * VALIDACOES - FASE 6
9710:     *==========================================================================
9711: 
9712:     *--------------------------------------------------------------------------
9713:     * ValidarCor - Valida e carrega tooltip da cor (SigCdCor)
9714:     *--------------------------------------------------------------------------
9715:     PROTECTED PROCEDURE ValidarCor()
9716:         LOCAL loc_cCodCor, loc_oPg
9717:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9718:         loc_cCodCor = ALLTRIM(loc_oPg.txt_4c_Cor.Value)
9719:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9720:             RETURN
9721:         ENDIF
9722:         THIS.CarregarDescCor(loc_cCodCor)
9723:     ENDPROC
9724: 
9725:     *--------------------------------------------------------------------------
9726:     * ValidarTam - Valida e carrega tooltip do tamanho (SigCdTam)
9727:     *--------------------------------------------------------------------------
9728:     PROTECTED PROCEDURE ValidarTam()
9729:         LOCAL loc_cCodTam, loc_oPg
9730:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9731:         loc_cCodTam = ALLTRIM(loc_oPg.txt_4c_Tam.Value)
9732:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9733:             RETURN
9734:         ENDIF
9735:         THIS.CarregarDescTam(loc_cCodTam)
9736:     ENDPROC
9737: 
9738:     *--------------------------------------------------------------------------
9739:     * ValidarCodFinP - Valida campo ficha e carrega descricao (SigCdFip)
9740:     *--------------------------------------------------------------------------
9741:     PROTECTED PROCEDURE ValidarCodFinP()
9742:         LOCAL loc_cCodFinP, loc_oPg
9743:         loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9744:         loc_cCodFinP = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
9745:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9746:             RETURN
9747:         ENDIF
9748:         THIS.CarregarDescFinP(loc_cCodFinP)
9749:         IF !EMPTY(loc_cCodFinP) AND EMPTY(loc_oPg.txt_4c_DesFinP.Value)
9750:             MsgAviso("Ficha " + loc_cCodFinP + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9751:         ENDIF
9752:     ENDPROC
9753: 
9754:     *--------------------------------------------------------------------------
9755:     * ValidarCodAcb - Valida campo acabamento e carrega descricao (SigCdAca)
9756:     *--------------------------------------------------------------------------
9757:     PROTECTED PROCEDURE ValidarCodAcb()
9758:         LOCAL loc_cCodAcb, loc_oPg
9759:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9760:         loc_cCodAcb = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
9761:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9762:             RETURN
9763:         ENDIF
9764:         THIS.CarregarDescAcb(loc_cCodAcb)
9765:         IF !EMPTY(loc_cCodAcb) AND EMPTY(loc_oPg.txt_4c_DacbDisplay.Value)
9766:             MsgAviso("Acabamento " + loc_cCodAcb + " n" + CHR(227) + "o encontrado.", "Inv" + CHR(225) + "lido")
9767:         ENDIF
9768:     ENDPROC
9769: 
9770:     *--------------------------------------------------------------------------
9771:     * ValidarClass - Valida campo classificacao e carrega descricao (SIGCDCLS)
9772:     *--------------------------------------------------------------------------
9773:     PROTECTED PROCEDURE ValidarClass()
9774:         LOCAL loc_cCclass, loc_oPg
9775:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9776:         loc_cCclass = ALLTRIM(loc_oPg.txt_4c_Class.Value)
9777:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9778:             RETURN
9779:         ENDIF
9780:         THIS.CarregarDescClass(loc_cCclass)
9781:         IF !EMPTY(loc_cCclass) AND EMPTY(loc_oPg.txt_4c_DClassDisplay.Value)
9782:             MsgAviso("Classifica" + CHR(231) + CHR(227) + "o " + loc_cCclass + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9783:         ENDIF
9784:     ENDPROC
9785: 
9786:     *--------------------------------------------------------------------------
9787:     * ValidarLocal - Valida campo local (SigPrLcl)
9788:     *--------------------------------------------------------------------------
9789:     PROTECTED PROCEDURE ValidarLocal()
9790:         LOCAL loc_cLocals, loc_oPg
9791:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9792:         loc_cLocals = ALLTRIM(loc_oPg.txt_4c_Local.Value)
9793:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9794:             RETURN
9795:         ENDIF
9796:         THIS.CarregarDescLocal(loc_cLocals)
9797:     ENDPROC
9798: 
9799:     *--------------------------------------------------------------------------
9800:     * ValidarCuni - Valida campo unidade e carrega descricao (SigCdUni)
9801:     *--------------------------------------------------------------------------
9802:     PROTECTED PROCEDURE ValidarCuni()
9803:         LOCAL loc_cCunis, loc_oPg
9804:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9805:         loc_cCunis  = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
9806:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9807:             RETURN
9808:         ENDIF
9809:         THIS.CarregarDescUni(loc_cCunis, "uni")
9810:         IF !EMPTY(loc_cCunis) AND EMPTY(loc_oPg.txt_4c_DuniDisplay.Value)
9811:             MsgAviso("Unidade " + loc_cCunis + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9812:         ENDIF
9813:     ENDPROC
9814: 
9815:     *--------------------------------------------------------------------------
9816:     * ValidarCunip - Valida campo unidade de pedido (SigCdUni)
9817:     *--------------------------------------------------------------------------
9818:     PROTECTED PROCEDURE ValidarCunip()
9819:         LOCAL loc_cCunips, loc_oPg
9820:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9821:         loc_cCunips = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
9822:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9823:             RETURN
9824:         ENDIF
9825:         THIS.CarregarDescUni(loc_cCunips, "unip")
9826:         IF !EMPTY(loc_cCunips) AND EMPTY(loc_oPg.txt_4c_DunipDisplay.Value)
9827:             MsgAviso("Unidade " + loc_cCunips + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9828:         ENDIF
9829:     ENDPROC
9830: 
9831:     *--------------------------------------------------------------------------
9832:     * ValidarMoe - Valida campo moeda (SigCdMoe)
9833:     * par_cTipo: "total" | "pvenda" | "fvenda"
9834:     *--------------------------------------------------------------------------
9835:     PROTECTED PROCEDURE ValidarMoe(par_cTipo)
9836:         LOCAL loc_cCmoes, loc_oPg
9837:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9838:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9839:             RETURN
9840:         ENDIF
9841:         DO CASE
9842:         CASE par_cTipo = "total"
9843:             loc_cCmoes = ALLTRIM(loc_oPg.txt_4c_Mctotal.Value)
9844:         CASE par_cTipo = "pvenda"
9845:             loc_cCmoes = ALLTRIM(loc_oPg.txt_4c_Mpvenda.Value)
9846:         OTHERWISE
9847:             loc_cCmoes = ALLTRIM(loc_oPg.txt_4c_Mfvenda.Value)
9848:         ENDCASE
9849:         THIS.CarregarDescMoe(loc_cCmoes, par_cTipo)
9850:     ENDPROC
9851: 
9852:     *==========================================================================
9853:     * LOOKUPS - FASE 6
9854:     *==========================================================================
9855: 
9856:     *--------------------------------------------------------------------------
9857:     * AbrirLookupCor - Abre busca de cor (SigCdCor)
9858:     *--------------------------------------------------------------------------
9859:     PROCEDURE AbrirLookupCor()
9860:         LOCAL loc_oBusca, loc_oPg
9861:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9862:         TRY
9863:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9864:                 "SigCdCor", "cursor_4c_BuscaCor", "cods", ;
9865:                 ALLTRIM(loc_oPg.txt_4c_Cor.Value), "Busca de Cor")
9866:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9867:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9868:             loc_oBusca.Show()
9869:             IF loc_oBusca.this_lSelecionou
9870:                 IF USED("cursor_4c_BuscaCor")
9871:                     SELECT cursor_4c_BuscaCor
9872:                     loc_oPg.txt_4c_Cor.Value = ALLTRIM(cods)
9873:                     USE IN cursor_4c_BuscaCor
9874:                 ENDIF
9875:             ENDIF
9876:             loc_oBusca.Release()
9877:             loc_oBusca = .NULL.
9878:         CATCH TO loc_oErro
9879:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de cor")
9880:         ENDTRY
9881:     ENDPROC
9882: 
9883:     *--------------------------------------------------------------------------
9884:     * AbrirLookupTam - Abre busca de tamanho (SigCdTam)
9885:     *--------------------------------------------------------------------------
9886:     PROCEDURE AbrirLookupTam()
9887:         LOCAL loc_oBusca, loc_oPg
9888:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9889:         TRY
9890:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9891:                 "SigCdTam", "cursor_4c_BuscaTam", "cods", ;
9892:                 ALLTRIM(loc_oPg.txt_4c_Tam.Value), "Busca de Tamanho")
9893:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9894:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9895:             loc_oBusca.Show()
9896:             IF loc_oBusca.this_lSelecionou
9897:                 IF USED("cursor_4c_BuscaTam")
9898:                     SELECT cursor_4c_BuscaTam
9899:                     loc_oPg.txt_4c_Tam.Value = ALLTRIM(cods)
9900:                     USE IN cursor_4c_BuscaTam
9901:                 ENDIF
9902:             ENDIF
9903:             loc_oBusca.Release()
9904:             loc_oBusca = .NULL.
9905:         CATCH TO loc_oErro
9906:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de tamanho")
9907:         ENDTRY
9908:     ENDPROC
9909: 
9910:     *--------------------------------------------------------------------------
9911:     * AbrirLookupFinP - Abre busca de ficha de produto (SigCdFip)
9912:     *--------------------------------------------------------------------------
9913:     PROCEDURE AbrirLookupFinP()
9914:         LOCAL loc_oBusca, loc_oPg
9915:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9916:         TRY
9917:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9918:                 "SigCdFip", "cursor_4c_BuscaFinP", "cods", ;
9919:                 ALLTRIM(loc_oPg.txt_4c_CodFinP.Value), "Busca de Ficha")
9920:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9921:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9922:             loc_oBusca.Show()
9923:             IF loc_oBusca.this_lSelecionou
9924:                 IF USED("cursor_4c_BuscaFinP")
9925:                     SELECT cursor_4c_BuscaFinP
9926:                     loc_oPg.txt_4c_CodFinP.Value  = ALLTRIM(cods)
9927:                     loc_oPg.txt_4c_DesFinP.Value  = ALLTRIM(descs)
9928:                     USE IN cursor_4c_BuscaFinP
9929:                 ENDIF
9930:             ENDIF
9931:             loc_oBusca.Release()
9932:             loc_oBusca = .NULL.
9933:         CATCH TO loc_oErro
9934:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de ficha")
9935:         ENDTRY
9936:     ENDPROC
9937: 
9938:     *--------------------------------------------------------------------------
9939:     * AbrirLookupAcb - Abre busca de acabamento (SigCdAca)
9940:     *--------------------------------------------------------------------------
9941:     PROCEDURE AbrirLookupAcb()
9942:         LOCAL loc_oBusca, loc_oPg
9943:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9944:         TRY
9945:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9946:                 "SigCdAca", "cursor_4c_BuscaAcb", "cods", ;
9947:                 ALLTRIM(loc_oPg.txt_4c_CodAcb.Value), "Busca de Acabamento")
9948:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9949:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
9950:             loc_oBusca.Show()
9951:             IF loc_oBusca.this_lSelecionou
9952:                 IF USED("cursor_4c_BuscaAcb")
9953:                     SELECT cursor_4c_BuscaAcb
9954:                     loc_oPg.txt_4c_CodAcb.Value       = ALLTRIM(cods)
9955:                     loc_oPg.txt_4c_DacbDisplay.Value  = ALLTRIM(descrs)
9956:                     USE IN cursor_4c_BuscaAcb
9957:                 ENDIF
9958:             ENDIF
9959:             loc_oBusca.Release()
9960:             loc_oBusca = .NULL.
9961:         CATCH TO loc_oErro
9962:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de acabamento")
9963:         ENDTRY
9964:     ENDPROC
9965: 
9966:     *--------------------------------------------------------------------------
9967:     * AbrirLookupClass - Abre busca de classificacao (SIGCDCLS)
9968:     *--------------------------------------------------------------------------
9969:     PROCEDURE AbrirLookupClass()
9970:         LOCAL loc_oBusca, loc_oPg
9971:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9972:         TRY
9973:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9974:                 "SIGCDCLS", "cursor_4c_BuscaClass", "cods", ;
9975:                 ALLTRIM(loc_oPg.txt_4c_Class.Value), ;
9976:                 "Busca de Classifica" + CHR(231) + CHR(227) + "o")
9977:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9978:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9979:             loc_oBusca.Show()
9980:             IF loc_oBusca.this_lSelecionou
9981:                 IF USED("cursor_4c_BuscaClass")
9982:                     SELECT cursor_4c_BuscaClass
9983:                     loc_oPg.txt_4c_Class.Value         = ALLTRIM(cods)
9984:                     loc_oPg.txt_4c_DClassDisplay.Value = ALLTRIM(descs)
9985:                     USE IN cursor_4c_BuscaClass
9986:                 ENDIF
9987:             ENDIF
9988:             loc_oBusca.Release()
9989:             loc_oBusca = .NULL.
9990:         CATCH TO loc_oErro
9991:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o")
9992:         ENDTRY
9993:     ENDPROC
9994: 
9995:     *--------------------------------------------------------------------------
9996:     * AbrirLookupLocal - Abre busca de local (SigPrLcl)
9997:     *--------------------------------------------------------------------------
9998:     PROCEDURE AbrirLookupLocal()
9999:         LOCAL loc_oBusca, loc_oPg
10000:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10001:         TRY
10002:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10003:                 "SigPrLcl", "cursor_4c_BuscaLocal", "codigos", ;
10004:                 ALLTRIM(loc_oPg.txt_4c_Local.Value), "Busca de Local")
10005:             loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
10006:             loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10007:             loc_oBusca.Show()
10008:             IF loc_oBusca.this_lSelecionou
10009:                 IF USED("cursor_4c_BuscaLocal")
10010:                     SELECT cursor_4c_BuscaLocal
10011:                     loc_oPg.txt_4c_Local.Value = ALLTRIM(codigos)
10012:                     USE IN cursor_4c_BuscaLocal
10013:                 ENDIF
10014:             ENDIF
10015:             loc_oBusca.Release()
10016:             loc_oBusca = .NULL.
10017:         CATCH TO loc_oErro
10018:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de local")
10019:         ENDTRY
10020:     ENDPROC
10021: 
10022:     *--------------------------------------------------------------------------
10023:     * AbrirLookupUni - Abre busca de unidade (SigCdUni) para campo Cuni
10024:     *--------------------------------------------------------------------------
10025:     PROCEDURE AbrirLookupUni()
10026:         LOCAL loc_oBusca, loc_oPg
10027:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10028:         TRY
10029:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10030:                 "SigCdUni", "cursor_4c_BuscaUni", "cunis", ;
10031:                 ALLTRIM(loc_oPg.txt_4c_Cuni.Value), "Busca de Unidade")
10032:             loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
10033:             loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
10034:             loc_oBusca.Show()
10035:             IF loc_oBusca.this_lSelecionou
10036:                 IF USED("cursor_4c_BuscaUni")
10037:                     SELECT cursor_4c_BuscaUni
10038:                     loc_oPg.txt_4c_Cuni.Value          = ALLTRIM(cunis)
10039:                     loc_oPg.txt_4c_DuniDisplay.Value   = ALLTRIM(dunis)
10040:                     USE IN cursor_4c_BuscaUni
10041:                 ENDIF
10042:             ENDIF
10043:             loc_oBusca.Release()
10044:             loc_oBusca = .NULL.
10045:         CATCH TO loc_oErro
10046:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de unidade")
10047:         ENDTRY
10048:     ENDPROC
10049: 
10050:     *--------------------------------------------------------------------------
10051:     * AbrirLookupUniP - Abre busca de unidade de pedido (SigCdUni) para campo Cunip
10052:     *--------------------------------------------------------------------------
10053:     PROCEDURE AbrirLookupUniP()
10054:         LOCAL loc_oBusca, loc_oPg
10055:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10056:         TRY
10057:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10058:                 "SigCdUni", "cursor_4c_BuscaUniP", "cunis", ;
10059:                 ALLTRIM(loc_oPg.txt_4c_Cunip.Value), "Busca de Uni.Pedido")
10060:             loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
10061:             loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
10062:             loc_oBusca.Show()
10063:             IF loc_oBusca.this_lSelecionou
10064:                 IF USED("cursor_4c_BuscaUniP")
10065:                     SELECT cursor_4c_BuscaUniP
10066:                     loc_oPg.txt_4c_Cunip.Value          = ALLTRIM(cunis)
10067:                     loc_oPg.txt_4c_DunipDisplay.Value   = ALLTRIM(dunis)
10068:                     USE IN cursor_4c_BuscaUniP
10069:                 ENDIF
10070:             ENDIF
10071:             loc_oBusca.Release()
10072:             loc_oBusca = .NULL.
10073:         CATCH TO loc_oErro
10074:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de unidade de pedido")
10075:         ENDTRY
10076:     ENDPROC
10077: 
10078:     *--------------------------------------------------------------------------
10079:     * AbrirLookupMctotal - Abre busca de moeda custo (SigCdMoe)
10080:     *--------------------------------------------------------------------------
10081:     PROCEDURE AbrirLookupMctotal()
10082:         LOCAL loc_oBusca, loc_oPg
10083:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10084:         TRY
10085:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10086:                 "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
10087:                 ALLTRIM(loc_oPg.txt_4c_Mctotal.Value), "Busca de Moeda (Custo)")
10088:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
10089:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10090:             loc_oBusca.Show()
10091:             IF loc_oBusca.this_lSelecionou
10092:                 IF USED("cursor_4c_BuscaMoe")
10093:                     SELECT cursor_4c_BuscaMoe
10094:                     loc_oPg.txt_4c_Mctotal.Value = ALLTRIM(cmoes)
10095:                     THIS.CarregarDescMoe(ALLTRIM(cmoes), "total")
10096:                     USE IN cursor_4c_BuscaMoe
10097:                 ENDIF
10098:             ENDIF
10099:             loc_oBusca.Release()
10100:             loc_oBusca = .NULL.
10101:         CATCH TO loc_oErro
10102:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
10103:         ENDTRY
10104:     ENDPROC
10105: 
10106:     *--------------------------------------------------------------------------
10107:     * AbrirLookupMpvenda - Abre busca de moeda P.Venda (SigCdMoe)
10108:     *--------------------------------------------------------------------------
10109:     PROCEDURE AbrirLookupMpvenda()
10110:         LOCAL loc_oBusca, loc_oPg
10111:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10112:         TRY
10113:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10114:                 "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
10115:                 ALLTRIM(loc_oPg.txt_4c_Mpvenda.Value), "Busca de Moeda (P.Venda)")
10116:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
10117:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10118:             loc_oBusca.Show()
10119:             IF loc_oBusca.this_lSelecionou
10120:                 IF USED("cursor_4c_BuscaMoe")
10121:                     SELECT cursor_4c_BuscaMoe
10122:                     loc_oPg.txt_4c_Mpvenda.Value = ALLTRIM(cmoes)
10123:                     THIS.CarregarDescMoe(ALLTRIM(cmoes), "pvenda")
10124:                     USE IN cursor_4c_BuscaMoe
10125:                 ENDIF
10126:             ENDIF
10127:             loc_oBusca.Release()
10128:             loc_oBusca = .NULL.
10129:         CATCH TO loc_oErro
10130:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
10131:         ENDTRY
10132:     ENDPROC
10133: 
10134:     *--------------------------------------------------------------------------
10135:     * AbrirLookupMfvenda - Abre busca de moeda F.Venda (SigCdMoe)
10136:     *--------------------------------------------------------------------------
10137:     PROCEDURE AbrirLookupMfvenda()
10138:         LOCAL loc_oBusca, loc_oPg
10139:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
10140:         TRY
10141:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10142:                 "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
10143:                 ALLTRIM(loc_oPg.txt_4c_Mfvenda.Value), "Busca de Moeda (F.Venda)")
10144:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
10145:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10146:             loc_oBusca.Show()
10147:             IF loc_oBusca.this_lSelecionou
10148:                 IF USED("cursor_4c_BuscaMoe")
10149:                     SELECT cursor_4c_BuscaMoe
10150:                     loc_oPg.txt_4c_Mfvenda.Value = ALLTRIM(cmoes)
10151:                     THIS.CarregarDescMoe(ALLTRIM(cmoes), "fvenda")
10152:                     USE IN cursor_4c_BuscaMoe
10153:                 ENDIF
10154:             ENDIF
10155:             loc_oBusca.Release()
10156:             loc_oBusca = .NULL.
10157:         CATCH TO loc_oErro
10158:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
10159:         ENDTRY
10160:     ENDPROC
10161: 
10162:     *==========================================================================
10163:     * HANDLERS - FASE 13: pgDadosFiscais
10164:     *==========================================================================
10165: 
10166:     *--------------------------------------------------------------------------
10167:     * TxtGruccusKeyPress - KeyPress em txt_4c_Gruccus (F4/F5 abre lookup SigCdGcr)
10168:     *--------------------------------------------------------------------------
10169:     PROCEDURE TxtGruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10170:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10171:             THIS.ValidarGruccus()
10172:         ENDIF
10173:         IF par_nKeyCode = 115
10174:             THIS.AbrirLookupGruccus()
10175:         ENDIF
10176:     ENDPROC
10177: 
10178:     *--------------------------------------------------------------------------
10179:     * ValidarGruccus - LostFocus/Enter em txt_4c_Gruccus
10180:     * Lookup: SigCdGcr (Codigos / Descrs)
10181:     *--------------------------------------------------------------------------
10182:     PROCEDURE ValidarGruccus()
10183:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10184:         loc_lResultado = .T.
10185:         TRY
10186:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10187:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Gruccus.Value, ""))
10188:             IF EMPTY(loc_cCodigo)
10189:                 loc_oPage.txt_4c_Dgruccus.Value    = ""
10190:                 loc_oPage.txt_4c_Contaccus.Value   = ""
10191:                 loc_oPage.txt_4c_Dcontaccus.Value  = ""
10192:                 loc_lResultado = loc_lResultado
10193:             ENDIF
10194:             loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10195:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGruccus") <= 0 OR EOF("cursor_4c_ValGruccus")
10196:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10197:                 loc_oLookup.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10198:                 loc_oLookup.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10199:                 loc_oLookup.cTabela     = "SigCdGcr"
10200:                 loc_oLookup.cCampoChave = "Codigos"
10201:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10202:                 loc_oLookup.Show()
10203:                 IF loc_oLookup.this_lSelecionou
10204:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10205:                 ELSE
10206:                     loc_cCodigo = ""
10207:                 ENDIF
10208:             ELSE
10209:                 SELECT cursor_4c_ValGruccus
10210:                 loc_oPage.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10211:             ENDIF
10212:             IF USED("cursor_4c_ValGruccus")
10213:                 USE IN cursor_4c_ValGruccus
10214:             ENDIF
10215:             IF !EMPTY(loc_cCodigo)
10216:                 loc_oPage.txt_4c_Gruccus.Value = loc_cCodigo
10217:                 loc_oPage.txt_4c_Gruccus.Refresh()
10218:                 *-- Recarregar descricao se veio do lookup
10219:                 loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10220:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGruccus2") > 0 AND !EOF("cursor_4c_ValGruccus2")
10221:                     SELECT cursor_4c_ValGruccus2
10222:                     loc_oPage.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10223:                 ENDIF
10224:                 IF USED("cursor_4c_ValGruccus2")
10225:                     USE IN cursor_4c_ValGruccus2
10226:                 ENDIF
10227:             ELSE
10228:                 loc_oPage.txt_4c_Gruccus.Value    = ""
10229:                 loc_oPage.txt_4c_Dgruccus.Value   = ""
10230:                 loc_oPage.txt_4c_Contaccus.Value  = ""
10231:                 loc_oPage.txt_4c_Dcontaccus.Value = ""
10232:             ENDIF
10233:             loc_oPage.txt_4c_Dgruccus.Refresh()
10234:         CATCH TO loc_oErro
10235:             MsgErro(loc_oErro.Message, "Erro")
10236:         ENDTRY
10237:         RETURN loc_lResultado
10238:     ENDPROC
10239: 
10240:     *--------------------------------------------------------------------------
10241:     * AbrirLookupGruccus - Abre busca de grupo C.C. (SigCdGcr)
10242:     *--------------------------------------------------------------------------
10243:     PROCEDURE AbrirLookupGruccus()
10244:         LOCAL loc_oBusca, loc_oPg
10245:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10246:         TRY
10247:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10248:                 "SigCdGcr", "cursor_4c_BuscaGruccus", "Codigos", ;
10249:                 ALLTRIM(loc_oPg.txt_4c_Gruccus.Value), "Busca de Grupo C.C.")
10250:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10251:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10252:             loc_oBusca.Show()
10253:             IF loc_oBusca.this_lSelecionou
10254:                 IF USED("cursor_4c_BuscaGruccus")
10255:                     SELECT cursor_4c_BuscaGruccus
10256:                     loc_oPg.txt_4c_Gruccus.Value  = ALLTRIM(Codigos)
10257:                     loc_oPg.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10258:                     USE IN cursor_4c_BuscaGruccus
10259:                 ENDIF
10260:             ENDIF
10261:             loc_oBusca.Release()
10262:             loc_oBusca = .NULL.
10263:         CATCH TO loc_oErro
10264:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo C.C.")
10265:         ENDTRY
10266:     ENDPROC
10267: 
10268:     *--------------------------------------------------------------------------
10269:     * TxtDgruccusKeyPress - KeyPress em txt_4c_Dgruccus (F4 abre lookup por descricao)
10270:     *--------------------------------------------------------------------------
10271:     PROCEDURE TxtDgruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10272:         IF par_nKeyCode = 115
10273:             THIS.AbrirLookupDgruccus()
10274:         ENDIF
10275:     ENDPROC
10276: 
10277:     *--------------------------------------------------------------------------
10278:     * AbrirLookupDgruccus - Busca reversa por descricao em SigCdGcr
10279:     *--------------------------------------------------------------------------
10280:     PROCEDURE AbrirLookupDgruccus()
10281:         LOCAL loc_oBusca, loc_oPg
10282:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10283:         TRY
10284:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10285:                 "SigCdGcr", "cursor_4c_BuscaGruccus", "Descrs", ;
10286:                 ALLTRIM(loc_oPg.txt_4c_Dgruccus.Value), "Busca de Grupo C.C.")
10287:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10288:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10289:             loc_oBusca.Show()
10290:             IF loc_oBusca.this_lSelecionou
10291:                 IF USED("cursor_4c_BuscaGruccus")
10292:                     SELECT cursor_4c_BuscaGruccus
10293:                     loc_oPg.txt_4c_Gruccus.Value  = ALLTRIM(Codigos)
10294:                     loc_oPg.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10295:                     USE IN cursor_4c_BuscaGruccus
10296:                 ENDIF
10297:             ENDIF
10298:             loc_oBusca.Release()
10299:             loc_oBusca = .NULL.
10300:         CATCH TO loc_oErro
10301:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo C.C.")
10302:         ENDTRY
10303:     ENDPROC
10304: 
10305:     *--------------------------------------------------------------------------
10306:     * TxtContaccusKeyPress - KeyPress em txt_4c_Contaccus (F4 abre lookup SigCdCli)
10307:     *--------------------------------------------------------------------------
10308:     PROCEDURE TxtContaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10309:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10310:             THIS.ValidarContaccus()
10311:         ENDIF
10312:         IF par_nKeyCode = 115
10313:             THIS.AbrirLookupContaccus()
10314:         ENDIF
10315:     ENDPROC
10316: 
10317:     *--------------------------------------------------------------------------
10318:     * ValidarContaccus - LostFocus/Enter em txt_4c_Contaccus
10319:     * Lookup: SigCdCli filtrado por Grupos = gruccus (IClis / Rclis)
10320:     *--------------------------------------------------------------------------
10321:     PROCEDURE ValidarContaccus()
10322:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_cGrupo, loc_lcSQL
10323:         loc_lResultado = .T.
10324:         TRY
10325:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10326:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Contaccus.Value, ""))
10327:             loc_cGrupo  = ALLTRIM(NVL(loc_oPage.txt_4c_Gruccus.Value, ""))
10328:             IF EMPTY(loc_cCodigo)
10329:                 loc_oPage.txt_4c_Dcontaccus.Value = ""
10330:                 loc_lResultado = loc_lResultado
10331:             ENDIF
10332:             loc_lcSQL = "SELECT IClis, Rclis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cCodigo)
10333:             IF !EMPTY(loc_cGrupo)
10334:                 loc_lcSQL = loc_lcSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
10335:             ENDIF
10336:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValContaccus") <= 0 OR EOF("cursor_4c_ValContaccus")
10337:                 IF USED("cursor_4c_ValContaccus")
10338:                     USE IN cursor_4c_ValContaccus
10339:                 ENDIF
10340:                 THIS.AbrirLookupContaccus()
10341:                 loc_lResultado = loc_lResultado
10342:             ENDIF
10343:             SELECT cursor_4c_ValContaccus
10344:             loc_oPage.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
10345:             loc_oPage.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
10346:             loc_oPage.txt_4c_Contaccus.Refresh()
10347:             loc_oPage.txt_4c_Dcontaccus.Refresh()
10348:             IF USED("cursor_4c_ValContaccus")
10349:                 USE IN cursor_4c_ValContaccus
10350:             ENDIF
10351:         CATCH TO loc_oErro
10352:             MsgErro(loc_oErro.Message, "Erro")
10353:         ENDTRY
10354:         RETURN loc_lResultado
10355:     ENDPROC
10356: 
10357:     *--------------------------------------------------------------------------
10358:     * AbrirLookupContaccus - Abre busca de conta C.C. (SigCdCli filtrado por grupo)
10359:     *--------------------------------------------------------------------------
10360:     PROCEDURE AbrirLookupContaccus()
10361:         LOCAL loc_oBusca, loc_oPg, loc_cGrupo, loc_cTabela
10362:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10363:         loc_cGrupo = ALLTRIM(NVL(loc_oPg.txt_4c_Gruccus.Value, ""))
10364:         TRY
10365:             loc_cTabela = "SigCdCli"
10366:             IF !EMPTY(loc_cGrupo)
10367:                 loc_cTabela = "SigCdCli WHERE Grupos = " + EscaparSQL(loc_cGrupo)
10368:                 loc_cTabela = "(SELECT IClis, Rclis FROM SigCdCli WHERE Grupos = " + EscaparSQL(loc_cGrupo) + ") AS t"
10369:             ENDIF
10370:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10371:                 "SigCdCli", "cursor_4c_BuscaContaccus", "IClis", ;
10372:                 ALLTRIM(loc_oPg.txt_4c_Contaccus.Value), "Busca de Conta C.C.")
10373:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10374:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10375:             loc_oBusca.Show()
10376:             IF loc_oBusca.this_lSelecionou
10377:                 IF USED("cursor_4c_BuscaContaccus")
10378:                     SELECT cursor_4c_BuscaContaccus
10379:                     loc_oPg.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
10380:                     loc_oPg.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
10381:                     USE IN cursor_4c_BuscaContaccus
10382:                 ENDIF
10383:             ENDIF
10384:             loc_oBusca.Release()
10385:             loc_oBusca = .NULL.
10386:         CATCH TO loc_oErro
10387:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de conta C.C.")
10388:         ENDTRY
10389:     ENDPROC
10390: 
10391:     *--------------------------------------------------------------------------
10392:     * TxtDcontaccusKeyPress - KeyPress em txt_4c_Dcontaccus (F4 abre lookup por nome)
10393:     *--------------------------------------------------------------------------
10394:     PROCEDURE TxtDcontaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10395:         IF par_nKeyCode = 115
10396:             THIS.AbrirLookupDcontaccus()
10397:         ENDIF
10398:     ENDPROC
10399: 
10400:     *--------------------------------------------------------------------------
10401:     * AbrirLookupDcontaccus - Busca reversa por nome em SigCdCli
10402:     *--------------------------------------------------------------------------
10403:     PROCEDURE AbrirLookupDcontaccus()
10404:         LOCAL loc_oBusca, loc_oPg
10405:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10406:         TRY
10407:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10408:                 "SigCdCli", "cursor_4c_BuscaContaccus", "Rclis", ;
10409:                 ALLTRIM(loc_oPg.txt_4c_Dcontaccus.Value), "Busca de Conta C.C.")
10410:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10411:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10412:             loc_oBusca.Show()
10413:             IF loc_oBusca.this_lSelecionou
10414:                 IF USED("cursor_4c_BuscaContaccus")
10415:                     SELECT cursor_4c_BuscaContaccus
10416:                     loc_oPg.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
10417:                     loc_oPg.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
10418:                     USE IN cursor_4c_BuscaContaccus
10419:                 ENDIF
10420:             ENDIF
10421:             loc_oBusca.Release()
10422:             loc_oBusca = .NULL.
10423:         CATCH TO loc_oErro
10424:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de conta C.C.")
10425:         ENDTRY
10426:     ENDPROC
10427: 
10428:     *--------------------------------------------------------------------------
10429:     * TxtClfiscalKeyPress - KeyPress em txt_4c_Clfiscal (F4 abre lookup SigCdClf)
10430:     *--------------------------------------------------------------------------
10431:     PROCEDURE TxtClfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10432:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10433:             THIS.ValidarClfiscal()
10434:         ENDIF
10435:         IF par_nKeyCode = 115
10436:             THIS.AbrirLookupClfiscal()
10437:         ENDIF
10438:     ENDPROC
10439: 
10440:     *--------------------------------------------------------------------------
10441:     * ValidarClfiscal - LostFocus/Enter em txt_4c_Clfiscal
10442:     * Lookup: SigCdClf (Codigos / Descricaos)
10443:     *--------------------------------------------------------------------------
10444:     PROCEDURE ValidarClfiscal()
10445:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10446:         loc_lResultado = .T.
10447:         TRY
10448:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10449:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Clfiscal.Value, ""))
10450:             IF EMPTY(loc_cCodigo)
10451:                 loc_oPage.txt_4c_Dclfiscal.Value = ""
10452:                 loc_lResultado = loc_lResultado
10453:             ENDIF
10454:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10455:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValClf") <= 0 OR EOF("cursor_4c_ValClf")
10456:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10457:                 loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10458:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10459:                 loc_oLookup.cTabela     = "SigCdClf"
10460:                 loc_oLookup.cCampoChave = "Codigos"
10461:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10462:                 loc_oLookup.Show()
10463:                 IF loc_oLookup.this_lSelecionou
10464:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10465:                 ELSE
10466:                     loc_cCodigo = ""
10467:                 ENDIF
10468:             ELSE
10469:                 SELECT cursor_4c_ValClf
10470:                 loc_oPage.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10471:             ENDIF
10472:             IF USED("cursor_4c_ValClf")
10473:                 USE IN cursor_4c_ValClf
10474:             ENDIF
10475:             loc_oPage.txt_4c_Clfiscal.Value = loc_cCodigo
10476:             IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dclfiscal.Value)
10477:                 *-- Recarregar descricao apos lookup
10478:                 loc_lcSQL = "SELECT Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10479:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValClf2") > 0 AND !EOF("cursor_4c_ValClf2")
10480:                     SELECT cursor_4c_ValClf2
10481:                     loc_oPage.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10482:                 ENDIF
10483:                 IF USED("cursor_4c_ValClf2")
10484:                     USE IN cursor_4c_ValClf2
10485:                 ENDIF
10486:             ENDIF
10487:             loc_oPage.txt_4c_Clfiscal.Refresh()
10488:             loc_oPage.txt_4c_Dclfiscal.Refresh()
10489:         CATCH TO loc_oErro
10490:             MsgErro(loc_oErro.Message, "Erro")
10491:         ENDTRY
10492:         RETURN loc_lResultado
10493:     ENDPROC
10494: 
10495:     *--------------------------------------------------------------------------
10496:     * AbrirLookupClfiscal - Abre busca de classificacao fiscal (SigCdClf)
10497:     *--------------------------------------------------------------------------
10498:     PROCEDURE AbrirLookupClfiscal()
10499:         LOCAL loc_oBusca, loc_oPg
10500:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10501:         TRY
10502:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10503:                 "SigCdClf", "cursor_4c_BuscaClf", "Codigos", ;
10504:                 ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value), "Busca de Classifica" + CHR(231) + CHR(227) + "o Fiscal")
10505:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10506:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10507:             loc_oBusca.Show()
10508:             IF loc_oBusca.this_lSelecionou
10509:                 IF USED("cursor_4c_BuscaClf")
10510:                     SELECT cursor_4c_BuscaClf
10511:                     loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(Codigos)
10512:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10513:                     USE IN cursor_4c_BuscaClf
10514:                 ENDIF
10515:             ENDIF
10516:             loc_oBusca.Release()
10517:             loc_oBusca = .NULL.
10518:         CATCH TO loc_oErro
10519:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o fiscal")
10520:         ENDTRY
10521:     ENDPROC
10522: 
10523:     *--------------------------------------------------------------------------
10524:     * TxtDclfiscalKeyPress - KeyPress em txt_4c_Dclfiscal (F4 busca reversa)
10525:     *--------------------------------------------------------------------------
10526:     PROCEDURE TxtDclfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10527:         IF par_nKeyCode = 115
10528:             THIS.AbrirLookupDclfiscal()
10529:         ENDIF
10530:     ENDPROC
10531: 
10532:     *--------------------------------------------------------------------------
10533:     * AbrirLookupDclfiscal - Busca reversa por descricao em SigCdClf
10534:     *--------------------------------------------------------------------------
10535:     PROCEDURE AbrirLookupDclfiscal()
10536:         LOCAL loc_oBusca, loc_oPg
10537:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10538:         TRY
10539:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10540:                 "SigCdClf", "cursor_4c_BuscaClf", "Descricaos", ;
10541:                 ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value), "Busca de Classifica" + CHR(231) + CHR(227) + "o Fiscal")
10542:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10543:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10544:             loc_oBusca.Show()
10545:             IF loc_oBusca.this_lSelecionou
10546:                 IF USED("cursor_4c_BuscaClf")
10547:                     SELECT cursor_4c_BuscaClf
10548:                     loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(Codigos)
10549:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10550:                     USE IN cursor_4c_BuscaClf
10551:                 ENDIF
10552:             ENDIF
10553:             loc_oBusca.Release()
10554:             loc_oBusca = .NULL.
10555:         CATCH TO loc_oErro
10556:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o fiscal")
10557:         ENDTRY
10558:     ENDPROC
10559: 
10560:     *--------------------------------------------------------------------------
10561:     * TxtOrigmercKeyPress - KeyPress em txt_4c_Origmerc (F4 abre lookup SigCdOrg)
10562:     *--------------------------------------------------------------------------
10563:     PROCEDURE TxtOrigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10564:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10565:             THIS.ValidarOrigmerc()
10566:         ENDIF
10567:         IF par_nKeyCode = 115
10568:             THIS.AbrirLookupOrigmerc()
10569:         ENDIF
10570:     ENDPROC
10571: 
10572:     *--------------------------------------------------------------------------
10573:     * ValidarOrigmerc - LostFocus/Enter em txt_4c_Origmerc
10574:     * Lookup: SigCdOrg (Codigos / Descricaos)
10575:     *--------------------------------------------------------------------------
10576:     PROCEDURE ValidarOrigmerc()
10577:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10578:         loc_lResultado = .T.
10579:         TRY
10580:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10581:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Origmerc.Value, ""))
10582:             IF EMPTY(loc_cCodigo)
10583:                 loc_oPage.txt_4c_Dorigmerc.Value = ""
10584:                 loc_lResultado = loc_lResultado
10585:             ENDIF
10586:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdOrg WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10587:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOrg") <= 0 OR EOF("cursor_4c_ValOrg")
10588:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10589:                 loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10590:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10591:                 loc_oLookup.cTabela     = "SigCdOrg"
10592:                 loc_oLookup.cCampoChave = "Codigos"
10593:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10594:                 loc_oLookup.Show()
10595:                 IF loc_oLookup.this_lSelecionou
10596:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10597:                 ELSE
10598:                     loc_cCodigo = ""
10599:                 ENDIF
10600:             ELSE
10601:                 SELECT cursor_4c_ValOrg
10602:                 loc_oPage.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10603:             ENDIF
10604:             IF USED("cursor_4c_ValOrg")
10605:                 USE IN cursor_4c_ValOrg
10606:             ENDIF
10607:             loc_oPage.txt_4c_Origmerc.Value = loc_cCodigo
10608:             IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dorigmerc.Value)
10609:                 loc_lcSQL = "SELECT Descricaos FROM SigCdOrg WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10610:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOrg2") > 0 AND !EOF("cursor_4c_ValOrg2")
10611:                     SELECT cursor_4c_ValOrg2
10612:                     loc_oPage.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10613:                 ENDIF
10614:                 IF USED("cursor_4c_ValOrg2")
10615:                     USE IN cursor_4c_ValOrg2
10616:                 ENDIF
10617:             ENDIF
10618:             loc_oPage.txt_4c_Origmerc.Refresh()
10619:             loc_oPage.txt_4c_Dorigmerc.Refresh()
10620:         CATCH TO loc_oErro
10621:             MsgErro(loc_oErro.Message, "Erro")
10622:         ENDTRY
10623:         RETURN loc_lResultado
10624:     ENDPROC
10625: 
10626:     *--------------------------------------------------------------------------
10627:     * AbrirLookupOrigmerc - Abre busca de origem da mercadoria (SigCdOrg)
10628:     *--------------------------------------------------------------------------
10629:     PROCEDURE AbrirLookupOrigmerc()
10630:         LOCAL loc_oBusca, loc_oPg
10631:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10632:         TRY
10633:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10634:                 "SigCdOrg", "cursor_4c_BuscaOrg", "Codigos", ;
10635:                 ALLTRIM(loc_oPg.txt_4c_Origmerc.Value), "Busca de Origem da Mercadoria")
10636:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10637:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10638:             loc_oBusca.Show()
10639:             IF loc_oBusca.this_lSelecionou
10640:                 IF USED("cursor_4c_BuscaOrg")
10641:                     SELECT cursor_4c_BuscaOrg
10642:                     loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(Codigos)
10643:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10644:                     USE IN cursor_4c_BuscaOrg
10645:                 ENDIF
10646:             ENDIF
10647:             loc_oBusca.Release()
10648:             loc_oBusca = .NULL.
10649:         CATCH TO loc_oErro
10650:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de origem da mercadoria")
10651:         ENDTRY
10652:     ENDPROC
10653: 
10654:     *--------------------------------------------------------------------------
10655:     * TxtDorigmercKeyPress - KeyPress em txt_4c_Dorigmerc (F4 busca reversa)
10656:     *--------------------------------------------------------------------------
10657:     PROCEDURE TxtDorigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10658:         IF par_nKeyCode = 115
10659:             THIS.AbrirLookupDorigmerc()
10660:         ENDIF
10661:     ENDPROC
10662: 
10663:     *--------------------------------------------------------------------------
10664:     * AbrirLookupDorigmerc - Busca reversa por descricao em SigCdOrg
10665:     *--------------------------------------------------------------------------
10666:     PROCEDURE AbrirLookupDorigmerc()
10667:         LOCAL loc_oBusca, loc_oPg
10668:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10669:         TRY
10670:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10671:                 "SigCdOrg", "cursor_4c_BuscaOrg", "Descricaos", ;
10672:                 ALLTRIM(loc_oPg.txt_4c_Dorigmerc.Value), "Busca de Origem da Mercadoria")
10673:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10674:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10675:             loc_oBusca.Show()
10676:             IF loc_oBusca.this_lSelecionou
10677:                 IF USED("cursor_4c_BuscaOrg")
10678:                     SELECT cursor_4c_BuscaOrg
10679:                     loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(Codigos)
10680:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10681:                     USE IN cursor_4c_BuscaOrg
10682:                 ENDIF
10683:             ENDIF
10684:             loc_oBusca.Release()
10685:             loc_oBusca = .NULL.
10686:         CATCH TO loc_oErro
10687:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de origem da mercadoria")
10688:         ENDTRY
10689:     ENDPROC
10690: 
10691:     *--------------------------------------------------------------------------
10692:     * TxtSittricmKeyPress - KeyPress em txt_4c_Sittricm (F4 abre lookup SigCdIcm)
10693:     *--------------------------------------------------------------------------
10694:     PROCEDURE TxtSittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10695:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10696:             THIS.ValidarSittricm()
10697:         ENDIF
10698:         IF par_nKeyCode = 115
10699:             THIS.AbrirLookupSittricm()
10700:         ENDIF
10701:     ENDPROC
10702: 
10703:     *--------------------------------------------------------------------------
10704:     * ValidarSittricm - LostFocus/Enter em txt_4c_Sittricm
10705:     * Lookup: SigCdIcm (Codigos / Descricaos)
10706:     *--------------------------------------------------------------------------
10707:     PROCEDURE ValidarSittricm()
10708:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10709:         loc_lResultado = .T.
10710:         TRY
10711:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10712:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Sittricm.Value, ""))
10713:             IF EMPTY(loc_cCodigo)
10714:                 loc_oPage.txt_4c_Dsittricm.Value = ""
10715:                 loc_lResultado = loc_lResultado
10716:             ENDIF
10717:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10718:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValIcm") <= 0 OR EOF("cursor_4c_ValIcm")
10719:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10720:                 loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10721:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10722:                 loc_oLookup.cTabela     = "SigCdIcm"
10723:                 loc_oLookup.cCampoChave = "Codigos"
10724:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10725:                 loc_oLookup.Show()
10726:                 IF loc_oLookup.this_lSelecionou
10727:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10728:                 ELSE
10729:                     loc_cCodigo = ""
10730:                 ENDIF
10731:             ELSE
10732:                 SELECT cursor_4c_ValIcm
10733:                 loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10734:             ENDIF
10735:             IF USED("cursor_4c_ValIcm")
10736:                 USE IN cursor_4c_ValIcm
10737:             ENDIF
10738:             loc_oPage.txt_4c_Sittricm.Value = loc_cCodigo
10739:             IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dsittricm.Value)
10740:                 loc_lcSQL = "SELECT Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10741:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValIcm2") > 0 AND !EOF("cursor_4c_ValIcm2")
10742:                     SELECT cursor_4c_ValIcm2
10743:                     loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10744:                 ENDIF
10745:                 IF USED("cursor_4c_ValIcm2")
10746:                     USE IN cursor_4c_ValIcm2
10747:                 ENDIF
10748:             ENDIF
10749:             loc_oPage.txt_4c_Sittricm.Refresh()
10750:             loc_oPage.txt_4c_Dsittricm.Refresh()
10751:         CATCH TO loc_oErro
10752:             MsgErro(loc_oErro.Message, "Erro")
10753:         ENDTRY
10754:         RETURN loc_lResultado
10755:     ENDPROC
10756: 
10757:     *--------------------------------------------------------------------------
10758:     * AbrirLookupSittricm - Abre busca situacao tributaria ICMS (SigCdIcm)
10759:     *--------------------------------------------------------------------------
10760:     PROCEDURE AbrirLookupSittricm()
10761:         LOCAL loc_oBusca, loc_oPg
10762:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10763:         TRY
10764:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10765:                 "SigCdIcm", "cursor_4c_BuscaIcm", "Codigos", ;
10766:                 ALLTRIM(loc_oPg.txt_4c_Sittricm.Value), "Busca de Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
10767:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10768:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10769:             loc_oBusca.Show()
10770:             IF loc_oBusca.this_lSelecionou
10771:                 IF USED("cursor_4c_BuscaIcm")
10772:                     SELECT cursor_4c_BuscaIcm
10773:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10774:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10775:                     USE IN cursor_4c_BuscaIcm
10776:                 ENDIF
10777:             ENDIF
10778:             loc_oBusca.Release()
10779:             loc_oBusca = .NULL.
10780:         CATCH TO loc_oErro
10781:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
10782:         ENDTRY
10783:     ENDPROC
10784: 
10785:     *--------------------------------------------------------------------------
10786:     * TxtDsittricmKeyPress - KeyPress em txt_4c_Dsittricm (F4 busca reversa)
10787:     *--------------------------------------------------------------------------
10788:     PROCEDURE TxtDsittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10789:         IF par_nKeyCode = 115
10790:             THIS.AbrirLookupDsittricm()
10791:         ENDIF
10792:     ENDPROC
10793: 
10794:     *--------------------------------------------------------------------------
10795:     * AbrirLookupDsittricm - Busca reversa por descricao em SigCdIcm
10796:     *--------------------------------------------------------------------------
10797:     PROCEDURE AbrirLookupDsittricm()
10798:         LOCAL loc_oBusca, loc_oPg
10799:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10800:         TRY
10801:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10802:                 "SigCdIcm", "cursor_4c_BuscaIcm", "Descricaos", ;
10803:                 ALLTRIM(loc_oPg.txt_4c_Dsittricm.Value), "Busca de Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
10804:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10805:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10806:             loc_oBusca.Show()
10807:             IF loc_oBusca.this_lSelecionou
10808:                 IF USED("cursor_4c_BuscaIcm")
10809:                     SELECT cursor_4c_BuscaIcm
10810:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10811:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10812:                     USE IN cursor_4c_BuscaIcm
10813:                 ENDIF
10814:             ENDIF
10815:             loc_oBusca.Release()
10816:             loc_oBusca = .NULL.
10817:         CATCH TO loc_oErro
10818:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
10819:         ENDTRY
10820:     ENDPROC
10821: 
10822:     *--------------------------------------------------------------------------
10823:     * TxtCodServsKeyPress - KeyPress em txt_4c_CodServs (F4 abre lookup SigCdIcm)
10824:     *--------------------------------------------------------------------------
10825:     PROCEDURE TxtCodServsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10826:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10827:             THIS.ValidarCodServs()
10828:         ENDIF
10829:         IF par_nKeyCode = 115
10830:             THIS.AbrirLookupCodServs()
10831:         ENDIF
10832:     ENDPROC
10833: 
10834:     *--------------------------------------------------------------------------
10835:     * ValidarCodServs - LostFocus/Enter em txt_4c_CodServs
10836:     * Lookup: SigCdIcm (Codigos) -> preenche txt_4c_Sittricm
10837:     *--------------------------------------------------------------------------
10838:     PROCEDURE ValidarCodServs()
10839:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10840:         loc_lResultado = .T.
10841:         TRY
10842:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10843:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_CodServs.Value, ""))
10844:             IF EMPTY(loc_cCodigo)
10845:                 loc_lResultado = loc_lResultado
10846:             ENDIF
10847:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10848:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCodServs") <= 0 OR EOF("cursor_4c_ValCodServs")
10849:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10850:                 loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10851:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10852:                 loc_oLookup.cTabela     = "SigCdIcm"
10853:                 loc_oLookup.cCampoChave = "Codigos"
10854:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10855:                 loc_oLookup.Show()
10856:                 IF loc_oLookup.this_lSelecionou
10857:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10858:                 ELSE
10859:                     loc_cCodigo = ""
10860:                 ENDIF
10861:             ELSE
10862:                 *-- Get_CodServs preenche txt_4c_Sittricm (conforme original)
10863:                 SELECT cursor_4c_ValCodServs
10864:                 loc_oPage.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10865:                 loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10866:                 loc_oPage.txt_4c_Sittricm.Refresh()
10867:                 loc_oPage.txt_4c_Dsittricm.Refresh()
10868:             ENDIF
10869:             IF USED("cursor_4c_ValCodServs")
10870:                 USE IN cursor_4c_ValCodServs
10871:             ENDIF
10872:             loc_oPage.txt_4c_CodServs.Value = loc_cCodigo
10873:             loc_oPage.txt_4c_CodServs.Refresh()
10874:         CATCH TO loc_oErro
10875:             MsgErro(loc_oErro.Message, "Erro")
10876:         ENDTRY
10877:         RETURN loc_lResultado
10878:     ENDPROC
10879: 
10880:     *--------------------------------------------------------------------------
10881:     * AbrirLookupCodServs - Abre busca codigo servicos ICMS (SigCdIcm)
10882:     *--------------------------------------------------------------------------
10883:     PROCEDURE AbrirLookupCodServs()
10884:         LOCAL loc_oBusca, loc_oPg
10885:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10886:         TRY
10887:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10888:                 "SigCdIcm", "cursor_4c_BuscaIcm", "Codigos", ;
10889:                 ALLTRIM(loc_oPg.txt_4c_CodServs.Value), "Busca de C" + CHR(243) + "digo de Servi" + CHR(231) + "os")
10890:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10891:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10892:             loc_oBusca.Show()
10893:             IF loc_oBusca.this_lSelecionou
10894:                 IF USED("cursor_4c_BuscaIcm")
10895:                     SELECT cursor_4c_BuscaIcm
10896:                     loc_oPg.txt_4c_CodServs.Value  = ALLTRIM(Codigos)
10897:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10898:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10899:                     USE IN cursor_4c_BuscaIcm
10900:                 ENDIF
10901:             ENDIF
10902:             loc_oBusca.Release()
10903:             loc_oBusca = .NULL.
10904:         CATCH TO loc_oErro
10905:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de c" + CHR(243) + "digo de servi" + CHR(231) + "os")
10906:         ENDTRY
10907:     ENDPROC
10908: 
10909:     *--------------------------------------------------------------------------
10910:     * TxtTpTribKeyPress - KeyPress em txt_4c_TpTrib (F4 abre lookup SigPrTri)
10911:     *--------------------------------------------------------------------------
10912:     PROCEDURE TxtTpTribKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10913:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10914:             THIS.ValidarTpTrib()
10915:         ENDIF
10916:         IF par_nKeyCode = 115
10917:             THIS.AbrirLookupTpTrib()
10918:         ENDIF
10919:     ENDPROC
10920: 
10921:     *--------------------------------------------------------------------------
10922:     * ValidarTpTrib - LostFocus/Enter em txt_4c_TpTrib
10923:     * Lookup: SigPrTri (Tipos / Descs)
10924:     *--------------------------------------------------------------------------
10925:     PROCEDURE ValidarTpTrib()
10926:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
10927:         loc_lResultado = .T.
10928:         TRY
10929:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10930:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_TpTrib.Value, ""))
10931:             IF EMPTY(loc_cCodigo)
10932:                 loc_lResultado = loc_lResultado
10933:             ENDIF
10934:             loc_lcSQL = "SELECT Tipos FROM SigPrTri WHERE Tipos = " + EscaparSQL(loc_cCodigo)
10935:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTrib") <= 0 OR EOF("cursor_4c_ValTrib")
10936:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10937:                 loc_oLookup.mAddColuna("Tipos", "", "Tipo")
10938:                 loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10939:                 loc_oLookup.cTabela     = "SigPrTri"
10940:                 loc_oLookup.cCampoChave = "Tipos"
10941:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10942:                 loc_oLookup.Show()
10943:                 IF loc_oLookup.this_lSelecionou
10944:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10945:                 ELSE
10946:                     loc_cCodigo = ""
10947:                 ENDIF
10948:             ENDIF
10949:             IF USED("cursor_4c_ValTrib")
10950:                 USE IN cursor_4c_ValTrib
10951:             ENDIF
10952:             loc_oPage.txt_4c_TpTrib.Value = loc_cCodigo
10953:             loc_oPage.txt_4c_TpTrib.Refresh()
10954:         CATCH TO loc_oErro
10955:             MsgErro(loc_oErro.Message, "Erro")
10956:         ENDTRY
10957:         RETURN loc_lResultado
10958:     ENDPROC
10959: 
10960:     *--------------------------------------------------------------------------
10961:     * AbrirLookupTpTrib - Abre busca de tipo de tributacao (SigPrTri)
10962:     *--------------------------------------------------------------------------
10963:     PROCEDURE AbrirLookupTpTrib()
10964:         LOCAL loc_oBusca, loc_oPg
10965:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10966:         TRY
10967:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10968:                 "SigPrTri", "cursor_4c_BuscaTrib", "Tipos", ;
10969:                 ALLTRIM(loc_oPg.txt_4c_TpTrib.Value), "Busca de Tipo de Tributa" + CHR(231) + CHR(227) + "o")
10970:             loc_oBusca.mAddColuna("Tipos", "", "Tipo")
10971:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10972:             loc_oBusca.Show()
10973:             IF loc_oBusca.this_lSelecionou
10974:                 IF USED("cursor_4c_BuscaTrib")
10975:                     SELECT cursor_4c_BuscaTrib
10976:                     loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(Tipos)
10977:                     USE IN cursor_4c_BuscaTrib
10978:                 ENDIF
10979:             ENDIF
10980:             loc_oBusca.Release()
10981:             loc_oBusca = .NULL.
10982:         CATCH TO loc_oErro
10983:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de tipo de tributa" + CHR(231) + CHR(227) + "o")
10984:         ENDTRY
10985:     ENDPROC
10986: 
10987:     *--------------------------------------------------------------------------
10988:     * ValidarIat - LostFocus em txt_4c_Iat
10989:     * Valida: deve ser 'A' (Arredondamento) ou 'T' (Truncamento) ou vazio
10990:     *--------------------------------------------------------------------------
10991:     PROCEDURE ValidarIat()
10992:         LOCAL loc_oPage, loc_cValor
10993:         TRY
10994:             loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10995:             loc_cValor = UPPER(ALLTRIM(NVL(loc_oPage.txt_4c_Iat.Value, "")))
10996:             IF EMPTY(loc_cValor)
10997:                 RETURN
10998:             ENDIF
10999:             IF !INLIST(loc_cValor, "A", "T")
11000:                 MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
11001:                     "Digite [A] Indicador de Arredondamento ou [T] Indicador de Truncamento!")
11002:                 loc_oPage.txt_4c_Iat.Value = ""
11003:                 loc_oPage.txt_4c_Iat.Refresh()
11004:             ELSE
11005:                 loc_oPage.txt_4c_Iat.Value = loc_cValor
11006:             ENDIF
11007:         CATCH TO loc_oErro
11008:             MsgErro(loc_oErro.Message, "Erro")
11009:         ENDTRY
11010:     ENDPROC
11011: 
11012:     *--------------------------------------------------------------------------
11013:     * ValidarAliqIPI - LostFocus em txt_4c_AliqIPI
11014:     * Verifica se aliquota informada eh identica a da classificacao fiscal
11015:     *--------------------------------------------------------------------------
11016:     PROCEDURE ValidarAliqIPI()
11017:         LOCAL loc_oPage, loc_nAliq, loc_nAliqClf, loc_lcSQL
11018:         TRY
11019:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11020:             loc_nAliq   = loc_oPage.txt_4c_AliqIPI.Value
11021:             IF EMPTY(ALLTRIM(NVL(loc_oPage.txt_4c_Clfiscal.Value, ""))) OR loc_nAliq = 0
11022:                 RETURN
11023:             ENDIF
11024:             loc_lcSQL = "SELECT aIpis FROM SigCdClf WHERE Codigos = " + EscaparSQL(ALLTRIM(loc_oPage.txt_4c_Clfiscal.Value))
11025:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAliqIPI") > 0 AND !EOF("cursor_4c_ValAliqIPI")
11026:                 SELECT cursor_4c_ValAliqIPI
11027:                 loc_nAliqClf = aIpis
11028:                 IF loc_nAliq = loc_nAliqClf
11029:                     MsgAviso("Al" + CHR(237) + "quota de IPI informada no produto id" + CHR(234) + "ntica " + ;
11030:                         CHR(224) + " classifica" + CHR(231) + CHR(227) + "o fiscal, " + ;
11031:                         "deixe zero e ser" + CHR(225) + " utilizada a classifica" + CHR(231) + CHR(227) + "o fiscal!")
11032:                 ENDIF
11033:             ENDIF
11034:             IF USED("cursor_4c_ValAliqIPI")
11035:                 USE IN cursor_4c_ValAliqIPI
11036:             ENDIF
11037:         CATCH TO loc_oErro
11038:             MsgErro(loc_oErro.Message, "Erro")
11039:         ENDTRY
11040:     ENDPROC
11041: 
11042:     *--------------------------------------------------------------------------
11043:     * TxtMvalorKeyPress - KeyPress em txt_4c_Mvalor (F4 abre lookup SigCdMoe)
11044:     *--------------------------------------------------------------------------
11045:     PROCEDURE TxtMvalorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11046:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
11047:             THIS.ValidarMvalor()
11048:         ENDIF
11049:         IF par_nKeyCode = 115
11050:             THIS.AbrirLookupMvalor()
11051:         ENDIF
11052:     ENDPROC
11053: 
11054:     *--------------------------------------------------------------------------
11055:     * ValidarMvalor - LostFocus/Enter em txt_4c_Mvalor
11056:     * Lookup: SigCdMoe (CMoes / DMoes)
11057:     *--------------------------------------------------------------------------
11058:     PROCEDURE ValidarMvalor()
11059:         LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
11060:         loc_lResultado = .T.
11061:         TRY
11062:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11063:             loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Mvalor.Value, ""))
11064:             IF EMPTY(loc_cCodigo)
11065:                 loc_lResultado = loc_lResultado
11066:             ENDIF
11067:             loc_lcSQL = "SELECT cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCodigo)
11068:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValMvalor") <= 0 OR EOF("cursor_4c_ValMvalor")
11069:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
11070:                 loc_oLookup.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
11071:                 loc_oLookup.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11072:                 loc_oLookup.cTabela     = "SigCdMoe"
11073:                 loc_oLookup.cCampoChave = "cmoes"
11074:                 loc_oLookup.cFiltroIni  = loc_cCodigo
11075:                 loc_oLookup.Show()
11076:                 IF loc_oLookup.this_lSelecionou
11077:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
11078:                 ELSE
11079:                     loc_cCodigo = ""
11080:                 ENDIF
11081:             ENDIF
11082:             IF USED("cursor_4c_ValMvalor")
11083:                 USE IN cursor_4c_ValMvalor
11084:             ENDIF
11085:             loc_oPage.txt_4c_Mvalor.Value = loc_cCodigo
11086:             loc_oPage.txt_4c_Mvalor.Refresh()
11087:         CATCH TO loc_oErro
11088:             MsgErro(loc_oErro.Message, "Erro")
11089:         ENDTRY
11090:         RETURN loc_lResultado
11091:     ENDPROC
11092: 
11093:     *--------------------------------------------------------------------------
11094:     * AbrirLookupMvalor - Abre busca de moeda do valor estimado (SigCdMoe)
11095:     *--------------------------------------------------------------------------
11096:     PROCEDURE AbrirLookupMvalor()
11097:         LOCAL loc_oBusca, loc_oPg
11098:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11099:         TRY
11100:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11101:                 "SigCdMoe", "cursor_4c_BuscaMvalor", "cmoes", ;
11102:                 ALLTRIM(loc_oPg.txt_4c_Mvalor.Value), "Busca de Moeda")
11103:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
11104:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11105:             loc_oBusca.Show()
11106:             IF loc_oBusca.this_lSelecionou
11107:                 IF USED("cursor_4c_BuscaMvalor")
11108:                     SELECT cursor_4c_BuscaMvalor
11109:                     loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(cmoes)
11110:                     USE IN cursor_4c_BuscaMvalor
11111:                 ENDIF
11112:             ENDIF
11113:             loc_oBusca.Release()
11114:             loc_oBusca = .NULL.
11115:         CATCH TO loc_oErro
11116:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
11117:         ENDTRY
11118:     ENDPROC
11119: 
11120:     *--------------------------------------------------------------------------
11121:     * TxtMetalKeyPress - KeyPress em txt_4c_Metal (F4 abre lookup metal)
11122:     *--------------------------------------------------------------------------
11123:     PROCEDURE TxtMetalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11124:         IF par_nKeyCode = 115
11125:             THIS.AbrirLookupMetal()
11126:         ENDIF
11127:     ENDPROC
11128: 
11129:     *--------------------------------------------------------------------------
11130:     * AbrirLookupMetal - Abre busca de metal (TmpMTal - cursor pre-carregado)
11131:     * Nota: TmpMTal deve ser carregado pelo form durante init com dados da tabela de metais
11132:     *--------------------------------------------------------------------------
11133:     PROCEDURE AbrirLookupMetal()
11134:         LOCAL loc_oBusca, loc_oPg
11135:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11136:         TRY
11137:             IF USED("TmpMTal")
11138:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11139:                     "TmpMTal", "cursor_4c_BuscaMetal", "Codigos", ;
11140:                     ALLTRIM(loc_oPg.txt_4c_Metal.Value), "Busca de Metal")
11141:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
11142:                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11143:                 loc_oBusca.Show()
11144:                 IF loc_oBusca.this_lSelecionou
11145:                     IF USED("cursor_4c_BuscaMetal")
11146:                         SELECT cursor_4c_BuscaMetal
11147:                         loc_oPg.txt_4c_Metal.Value   = ALLTRIM(Codigos)
11148:                         loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(Descs)
11149:                         USE IN cursor_4c_BuscaMetal
11150:                     ENDIF
11151:                 ENDIF
11152:                 loc_oBusca.Release()
11153:                 loc_oBusca = .NULL.
11154:             ENDIF
11155:         CATCH TO loc_oErro
11156:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de metal")
11157:         ENDTRY
11158:     ENDPROC
11159: 
11160:     *--------------------------------------------------------------------------
11161:     * TxtTeorKeyPress - KeyPress em txt_4c_Teor (F4 abre lookup teor)
11162:     *--------------------------------------------------------------------------
11163:     PROCEDURE TxtTeorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11164:         IF par_nKeyCode = 115
11165:             THIS.AbrirLookupTeor()
11166:         ENDIF
11167:     ENDPROC
11168: 
11169:     *--------------------------------------------------------------------------
11170:     * AbrirLookupTeor - Abre busca de teor (TmpTeor - cursor pre-carregado)
11171:     * Nota: TmpTeor deve ser carregado pelo form durante init com dados da tabela de teores
11172:     *--------------------------------------------------------------------------
11173:     PROCEDURE AbrirLookupTeor()
11174:         LOCAL loc_oBusca, loc_oPg
11175:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11176:         TRY
11177:             IF USED("TmpTeor")
11178:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11179:                     "TmpTeor", "cursor_4c_BuscaTeor", "Codigos", ;
11180:                     ALLTRIM(loc_oPg.txt_4c_Teor.Value), "Busca de Teor")
11181:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
11182:                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11183:                 loc_oBusca.Show()
11184:                 IF loc_oBusca.this_lSelecionou
11185:                     IF USED("cursor_4c_BuscaTeor")
11186:                         SELECT cursor_4c_BuscaTeor
11187:                         loc_oPg.txt_4c_Teor.Value   = ALLTRIM(Codigos)
11188:                         loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(Descs)
11189:                         USE IN cursor_4c_BuscaTeor
11190:                     ENDIF
11191:                 ENDIF
11192:                 loc_oBusca.Release()
11193:                 loc_oBusca = .NULL.
11194:             ENDIF
11195:         CATCH TO loc_oErro
11196:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de teor")
11197:         ENDTRY
11198:     ENDPROC
11199: 
11200:     *--------------------------------------------------------------------------
11201:     * CmdBtnDescFisClick - Click em cmd_4c_BtnDescFis
11202:     * Gera descricao fiscal a partir da composicao do produto (campo DescFis em SigCdPro)
11203:     *--------------------------------------------------------------------------
11204:     PROCEDURE CmdBtnDescFisClick()
11205:         LOCAL loc_oPage, loc_cCpros, loc_lcSQL, loc_cDescFis
11206:         TRY
11207:             loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11208:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11209:             IF EMPTY(loc_cCpros)
11210:                 MsgAviso("Salve o produto antes de gerar a descri" + CHR(231) + CHR(227) + "o fiscal.")
11211:                 RETURN
11212:             ENDIF
11213:             *-- Gerar descricao fiscal baseada na composicao do produto (simplificado)
11214:             loc_lcSQL = "SELECT TOP 1 dpros + ' ' + ISNULL(dpro2s,'') AS descFis " + ;
11215:                 "FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
11216:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_DescFis") > 0 AND !EOF("cursor_4c_DescFis")
11217:                 SELECT cursor_4c_DescFis
11218:                 loc_cDescFis = ALLTRIM(descFis)
11219:                 IF !EMPTY(loc_cDescFis)
11220:                     loc_oPage.obj_4c_Mgetdescfi.Value = loc_cDescFis
11221:                     loc_oPage.obj_4c_Mgetdescfi.Refresh()
11222:                     *-- Persistir no banco
11223:                     loc_lcSQL = "UPDATE SigCdPro SET DescFis = " + EscaparSQL(loc_cDescFis) + ;
11224:                         " WHERE cpros = " + EscaparSQL(loc_cCpros)
11225:                     SQLEXEC(gnConnHandle, loc_lcSQL)
11226:                 ELSE
11227:                     MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + CHR(231) + CHR(227) + "o fiscal!")
11228:                 ENDIF
11229:             ELSE
11230:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + CHR(231) + CHR(227) + "o fiscal!")
11231:             ENDIF
11232:             IF USED("cursor_4c_DescFis")
11233:                 USE IN cursor_4c_DescFis
11234:             ENDIF
11235:         CATCH TO loc_oErro
11236:             MsgErro(loc_oErro.Message, "Erro ao gerar descri" + CHR(231) + CHR(227) + "o fiscal")
11237:         ENDTRY
11238:     ENDPROC
11239: 
11240:     *--------------------------------------------------------------------------
11241:     * AtualizarSigCdPro - Salva campos editaveis de SigCdPro apos salvar SigPrFtp
11242:     * Chamado por BtnSalvarClick() apos this_oBusinessObject.Salvar() com sucesso
11243:     *--------------------------------------------------------------------------
11244:     PROTECTED PROCEDURE AtualizarSigCdPro()
11245:         LOCAL loc_oPg, loc_cCpros, loc_cSQL, loc_lFabrProprs, loc_lConsig, loc_lEncoms
11246:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
11247:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11248: 
11249:         IF EMPTY(loc_cCpros)
11250:             RETURN
11251:         ENDIF
11252: 
11253:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11254:             RETURN
11255:         ENDIF
11256: 
11257:         *-- Converter CheckBox.Value (logico) para 0/1
11258:         loc_lFabrProprs = IIF(loc_oPg.chk_4c_FabrProprs.Value, 1, 0)
11259:         loc_lConsig     = IIF(loc_oPg.chk_4c_Consig.Value,     1, 0)
11260:         loc_lEncoms     = IIF(loc_oPg.chk_4c_Encoms.Value,     1, 0)
11261: 
11262:         *-- Coletar campos fiscais (Page3)
11263:         LOCAL loc_oPg3U, loc_cIpiVal
11264:         loc_oPg3U = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11265:         loc_cIpiVal = LEFT(UPPER(ALLTRIM(loc_oPg3U.cbo_4c_CmbIpi.Value)), 1)
11266: 
11267:         TRY
11268:             loc_cSQL = "UPDATE SigCdPro SET " + ;
11269:                 "dpro2s = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_DPro2s.Value))      + ", " + ;
11270:                 "cbars = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cbar.Value))        + ", " + ;
11271:                 "cgrus = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cgrus.Value))       + ", " + ;
11272:                 "linhas = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Lin.Value))         + ", " + ;
11273:                 "colecoes = "   + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Col.Value))         + ", " + ;
11274:                 "ifors = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Ifor.Value))        + ", " + ;
11275:                 "reffs = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Refs.Value))        + ", " + ;
11276:                 "codcors = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cor.Value))         + ", " + ;
11277:                 "codtams = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Tam.Value))         + ", " + ;
11278:                 "codfinp = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CodFinP.Value))     + ", " + ;
11279:                 "pesobs = "     + FormatarNumeroSQL(loc_oPg.txt_4c_PesoB.Value)         + ", " + ;
11280:                 "codacbs = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CodAcb.Value))      + ", " + ;
11281:                 "cclass = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Class.Value))       + ", " + ;
11282:                 "locals = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Local.Value))       + ", " + ;
11283:                 "cunis = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cuni.Value))        + ", " + ;
11284:                 "cunips = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cunip.Value))       + ", " + ;

*-- Linhas 11324 a 11392:
11324:     *--------------------------------------------------------------------------
11325:     * Destroy - Liberacao de recursos
11326:     *--------------------------------------------------------------------------
11327:     PROCEDURE Destroy()
11328:         LOCAL loc_aCursors(42), loc_nI
11329:         *-- Lista de todos os cursors possiveis deste form
11330:         loc_aCursors(1)  = "cursor_4c_Dados"
11331:         loc_aCursors(2)  = "cursor_4c_Busca"
11332:         loc_aCursors(3)  = "cursor_4c_ProdDados"
11333:         loc_aCursors(4)  = "cursor_4c_DescGru"
11334:         loc_aCursors(5)  = "cursor_4c_DescLin"
11335:         loc_aCursors(6)  = "cursor_4c_DescCol"
11336:         loc_aCursors(7)  = "cursor_4c_DescIfor"
11337:         loc_aCursors(8)  = "cursor_4c_ValPro"
11338:         loc_aCursors(9)  = "cursor_4c_ValGru"
11339:         loc_aCursors(10) = "cursor_4c_Registro"
11340:         *-- Fase 6: cursors adicionais
11341:         loc_aCursors(11) = "cursor_4c_DescCor"
11342:         loc_aCursors(12) = "cursor_4c_DescTam"
11343:         loc_aCursors(13) = "cursor_4c_DescFinP"
11344:         loc_aCursors(14) = "cursor_4c_DescAcb"
11345:         loc_aCursors(15) = "cursor_4c_DescClass"
11346:         loc_aCursors(16) = "cursor_4c_DescLocal"
11347:         loc_aCursors(17) = "cursor_4c_DescUni"
11348:         loc_aCursors(18) = "cursor_4c_DescMoe"
11349:         loc_aCursors(19) = "cursor_4c_BuscaCor"
11350:         loc_aCursors(20) = "cursor_4c_BuscaTam"
11351:         loc_aCursors(21) = "cursor_4c_BuscaFinP"
11352:         loc_aCursors(22) = "cursor_4c_BuscaAcb"
11353:         loc_aCursors(23) = "cursor_4c_BuscaClass"
11354:         loc_aCursors(24) = "cursor_4c_BuscaLocal"
11355:         loc_aCursors(25) = "cursor_4c_BuscaUni"
11356:         loc_aCursors(26) = "cursor_4c_BuscaUniP"
11357:         loc_aCursors(27) = "cursor_4c_BuscaMoe"
11358:         loc_aCursors(28) = "cursor_4c_BuscaGrupo"
11359:         loc_aCursors(29) = "cursor_4c_ValGru"
11360:         loc_aCursors(30) = "cursor_4c_DescGru"
11361:         *-- Fase 9: cursors de composicao
11362:         loc_aCursors(31) = "cursor_4c_Compo"
11363:         loc_aCursors(32) = "cursor_4c_SubCp"
11364:         loc_aCursors(33) = "cursor_4c_TotGrupo"
11365:         loc_aCursors(34) = "cursor_4c_BuscaMoeCompo"
11366:         loc_aCursors(35) = "cursor_4c_BuscaAuxMoe"
11367:         *-- Fase 10: cursors de custo
11368:         loc_aCursors(36) = "cursor_4c_CustoCompo"
11369:         loc_aCursors(37) = "cursor_4c_TotGrupoCusto"
11370:         *-- Fase 12: cursors de fases de processo e matrizes
11371:         loc_aCursors(38) = "cursor_4c_Fase"
11372:         loc_aCursors(39) = "cursor_4c_Matrizes"
11373:         *-- Fase 13: cursor dados fiscais
11374:         loc_aCursors(40) = "cursor_4c_Cmv"
11375:         *-- Fase 14: cursors designer
11376:         loc_aCursors(41) = "cursor_4c_Tarefas"
11377:         loc_aCursors(42) = "cursor_4c_Arquivos"
11378: 
11379:         FOR loc_nI = 1 TO 42
11380:             IF USED(loc_aCursors(loc_nI))
11381:                 USE IN (loc_aCursors(loc_nI))
11382:             ENDIF
11383:         ENDFOR
11384: 
11385:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
11386:             THIS.this_oBusinessObject = .NULL.
11387:         ENDIF
11388: 
11389:         DODEFAULT()
11390:     ENDPROC
11391: 
11392: ENDDEFINE


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

