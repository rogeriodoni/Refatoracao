# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (89)
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
- [CARGA-DADOS] Metodo ValidarClfiscal faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarAliqIPI faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] OptionGroup 'opt_4c_Situas' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_ProdWeb' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_Varias' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
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
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarFiltroGrupo' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarFiltroGrupoValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabPrincipal_CgruLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabPrincipal_CgruLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabPrincipal_LinhasLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabPrincipal_LinhasLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabPrincipal_ColecoesLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabPrincipal_ColecoesLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabPrincipal_IforsLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabPrincipal_IforsLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabPrincipal_CunisLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabPrincipal_CunisLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabPrincipal_CunipsLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabPrincipal_CunipsLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabPrincipal_CodacbsLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabPrincipal_CodacbsLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabPrincipal_CodcorsLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabPrincipal_CodcorsLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_DescLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_DescLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_MatPLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_MatPLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_DesccpLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_DesccpLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_MatsubLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_MatsubLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_CmkpcLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_CmkpcLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_MoedaLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_MoedaLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_FtioLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_FtioLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_MoepvLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_MoepvLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_MoevLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_MoevLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_MoecLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_MoecLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabCompo_MoecusfLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabCompo_MoecusfLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarGruccus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarGruccusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDgruccus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDgruccusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarContaccus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarContaccusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDcontaccus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDcontaccusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarClfiscal' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarClfiscalValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDclfiscal' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDclfiscalValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarOrigmerc' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarOrigmercValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDorigmerc' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDorigmercValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarSittricms' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarSittricmsValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDsittricms' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDsittricmsValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarCodServs' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarCodServsValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarTptribs' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarTptribsValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarMoedaEstimada' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarMoedaEstimadaValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabFases_CodcorsLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabFases_CodcorsLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabFases_CodtamsLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabFases_CodtamsLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabFases_CodacbsLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabFases_CodacbsLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabFases_ConquilhaLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabFases_ConquilhaLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TabFases_GarraLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTabFases_GarraLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarDesc()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarDescSgru()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Tarefas' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDPRO.Pagina.Lista.cntMensagem): Top original=32 vs migrado 'lbl_4c_Label1' Top=473 (diff=441px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Top original=171 vs migrado 'cnt_4c_Botoes' Top=29 (diff=142px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Left original=959 vs migrado 'cnt_4c_Botoes' Left=542 (diff=417px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Top original=5 vs migrado 'lbl_4c_Label8' Top=542 (diff=537px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Left original=8 vs migrado 'lbl_4c_Label8' Left=161 (diff=153px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=134 vs migrado 'lbl_4c_Label24' Top=542 (diff=408px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=58 vs migrado 'lbl_4c_Label24' Left=324 (diff=266px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblAltura' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=474 vs migrado 'lbl_4c_LblAltura' Top=250 (diff=224px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblAltura' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=749 vs migrado 'lbl_4c_LblAltura' Left=881 (diff=132px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (13419 linhas total):

*-- Linhas 52 a 394:
52:     *--------------------------------------------------------------------------
53:     * Init - Inicializacao do formulario
54:     *--------------------------------------------------------------------------
55:     PROCEDURE Init()
56:         RETURN DODEFAULT()
57:     ENDPROC
58: 
59:     *--------------------------------------------------------------------------
60:     * InicializarForm - Configuracao inicial do formulario
61:     *--------------------------------------------------------------------------
62:     PROTECTED PROCEDURE InicializarForm()
63:         LOCAL loc_lSucesso
64:         loc_lSucesso = .F.
65: 
66:         TRY
67:             *-- Guard: evitar loops de SQL durante validacao UI
68:             IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
69:                 gb_4c_ValidandoUI = .F.
70:             ENDIF
71: 
72:             *-- Criar instancia do Business Object
73:             THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")
74: 
75:             IF ISNULL(THIS.this_oBusinessObject)
76:                 MsgErro("Erro ao criar Business Object ProdutoBO", "FormProduto.InicializarForm")
77:                 loc_lSucesso = .F.
78:             ELSE
79:                 THIS.ConfigurarPageFrame()
80:                 THIS.ConfigurarPaginaLista()
81:                 THIS.ConfigurarPaginaDados()
82:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
83: 
84:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
85:                     IF !THIS.CarregarLista()
86:                         *-- Se falhar ao carregar, nao impede abertura
87:                     ENDIF
88:                 ENDIF
89: 
90:                 THIS.pgf_4c_Paginas.Visible    = .T.
91:                 THIS.pgf_4c_Paginas.ActivePage = 1
92:                 THIS.this_cModoAtual           = "LISTA"
93:                 loc_lSucesso = .T.
94:             ENDIF
95: 
96:         CATCH TO loc_oErro
97:             MsgErro("Erro ao inicializar FormProduto:" + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "FormProduto.InicializarForm")
98:             loc_lSucesso = .F.
99:         ENDTRY
100: 
101:         RETURN loc_lSucesso
102:     ENDPROC
103: 
104:     *--------------------------------------------------------------------------
105:     * ConfigurarPageFrame - Configura o PageFrame principal (2 paginas)
106:     *--------------------------------------------------------------------------
107:     PROTECTED PROCEDURE ConfigurarPageFrame()
108:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
109: 
110:         WITH THIS.pgf_4c_Paginas
111:             .Top       = -29
112:             .Left      = 0
113:             .Width     = 1003
114:             .Height    = 660
115:             .PageCount = 2
116:             .Tabs      = .F.
117:             .Visible   = .T.
118: 
119:             .Page1.Caption  = "Lista"
120:             .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
121:             .Page1.BackColor = RGB(255, 255, 255)
122: 
123:             .Page2.Caption  = "Dados"
124:             .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
125:             .Page2.BackColor = RGB(255, 255, 255)
126:         ENDWITH
127:     ENDPROC
128: 
129:     *--------------------------------------------------------------------------
130:     * ConfigurarPaginaLista - Configura Page1 (Lista de Produtos)
131:     * Compensacao +29: Top_legado + 29
132:     * Grid legado: Grade top=173, left=38, width=922, height=409
133:     *--------------------------------------------------------------------------
134:     PROTECTED PROCEDURE ConfigurarPaginaLista()
135:         LOCAL loc_oPagina
136:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
137: 
138:         *-- Container cabecalho
139:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
140:         WITH loc_oPagina.cnt_4c_Cabecalho
141:             .Top         = 31
142:             .Left        = 0
143:             .Width       = 1020
144:             .Height      = 80
145:             .BackStyle   = 1
146:             .BackColor   = RGB(53, 53, 53)
147:             .BorderWidth = 0
148:             .Visible     = .T.
149:         ENDWITH
150: 
151:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
152:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
153:             .Caption   = "Cadastro de Produtos"
154:             .Top       = 20
155:             .Left      = 20
156:             .Width     = 400
157:             .Height    = 30
158:             .FontName  = "Tahoma"
159:             .FontSize  = 14
160:             .FontBold  = .T.
161:             .BackStyle = 0
162:             .ForeColor = RGB(255, 255, 255)
163:             .Visible   = .T.
164:         ENDWITH
165: 
166:         *-- Container de botoes CRUD (Grupo_op: Left=542 no legado, Top=0 -> 29)
167:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
168:         WITH loc_oPagina.cnt_4c_Botoes
169:             .Top         = 29
170:             .Left        = 542
171:             .Width       = 380
172:             .Height      = 85
173:             .BackStyle = 1
174:             .BackColor = RGB(53, 53, 53)
175:             .BorderWidth = 0
176:             .Visible     = .T.
177:         ENDWITH
178: 
179:         *-- Botao Incluir (Left=5)
180:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
181:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
182:             .Caption         = "Incluir"
183:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
184:             .PicturePosition = 13
185:             .Width           = 75
186:             .Height          = 75
187:             .Left            = 5
188:             .Top             = 5
189:             .FontName        = "Tahoma"
190:             .FontSize        = 8
191:             .Themes          = .F.
192:             .SpecialEffect   = 0
193:             .BackColor       = RGB(255, 255, 255)
194:             .ForeColor       = RGB(90, 90, 90)
195:             .Visible         = .T.
196:         ENDWITH
197:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
198: 
199:         *-- Botao Visualizar (Left=80)
200:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
201:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
202:             .Caption         = "Visualizar"
203:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
204:             .PicturePosition = 13
205:             .Width           = 75
206:             .Height          = 75
207:             .Left            = 80
208:             .Top             = 5
209:             .FontName        = "Tahoma"
210:             .FontSize        = 8
211:             .Themes          = .F.
212:             .SpecialEffect   = 0
213:             .BackColor       = RGB(255, 255, 255)
214:             .ForeColor       = RGB(90, 90, 90)
215:             .Visible         = .T.
216:         ENDWITH
217:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
218: 
219:         *-- Botao Alterar (Left=155)
220:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
221:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
222:             .Caption         = "Alterar"
223:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
224:             .PicturePosition = 13
225:             .Width           = 75
226:             .Height          = 75
227:             .Left            = 155
228:             .Top             = 5
229:             .FontName        = "Tahoma"
230:             .FontSize        = 8
231:             .Themes          = .F.
232:             .SpecialEffect   = 0
233:             .BackColor       = RGB(255, 255, 255)
234:             .ForeColor       = RGB(90, 90, 90)
235:             .Visible         = .T.
236:         ENDWITH
237:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
238: 
239:         *-- Botao Excluir (Left=230)
240:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
241:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
242:             .Caption         = "Excluir"
243:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
244:             .PicturePosition = 13
245:             .Width           = 75
246:             .Height          = 75
247:             .Left            = 230
248:             .Top             = 5
249:             .FontName        = "Tahoma"
250:             .FontSize        = 8
251:             .Themes          = .F.
252:             .SpecialEffect   = 0
253:             .BackColor       = RGB(255, 255, 255)
254:             .ForeColor       = RGB(90, 90, 90)
255:             .Visible         = .T.
256:         ENDWITH
257:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
258: 
259:         *-- Botao Buscar (Left=305)
260:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
261:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
262:             .Caption         = "Buscar"
263:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
264:             .PicturePosition = 13
265:             .Width           = 75
266:             .Height          = 75
267:             .Left            = 305
268:             .Top             = 5
269:             .FontName        = "Tahoma"
270:             .FontSize        = 8
271:             .Themes          = .F.
272:             .SpecialEffect   = 0
273:             .BackColor       = RGB(255, 255, 255)
274:             .ForeColor       = RGB(90, 90, 90)
275:             .Visible         = .T.
276:         ENDWITH
277:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
278: 
279:         *-- Container de saida separado (Left=917, Top=29)
280:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
281:         WITH loc_oPagina.cnt_4c_Saida
282:             .Top         = 29
283:             .Left        = 917
284:             .Width       = 90
285:             .Height      = 85
286:             .BackStyle = 1
287:             .BackColor = RGB(53, 53, 53)
288:             .BorderWidth = 0
289:             .Visible     = .T.
290:         ENDWITH
291: 
292:         *-- Botao Encerrar
293:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
294:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
295:             .Caption         = "Encerrar"
296:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
297:             .PicturePosition = 13
298:             .Width           = 75
299:             .Height          = 75
300:             .Left            = 5
301:             .Top             = 5
302:             .FontName        = "Tahoma"
303:             .FontSize        = 8
304:             .Themes          = .F.
305:             .SpecialEffect   = 0
306:             .BackColor       = RGB(255, 255, 255)
307:             .ForeColor       = RGB(90, 90, 90)
308:             .Visible         = .T.
309:         ENDWITH
310:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
311: 
312:         *-- Container de filtros (cntFiltros legado: continha getCgru/getDgru/getDtIni/Fim/optFilSituas)
313:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
314:         WITH loc_oPagina.cnt_4c_Filtros
315:             .Top         = 120
316:             .Left        = 12
317:             .Width       = 940
318:             .Height      = 55
319:             .BackStyle   = 0
320:             .BorderWidth = 0
321:             .Visible     = .T.
322:         ENDWITH
323: 
324:         *-- Filtro: Label Grupo
325:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblGrupo", "Label")
326:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblGrupo
327:             .Caption   = "Grupo:"
328:             .Left      = 5
329:             .Top       = 8
330:             .Width     = 40
331:             .Height    = 15
332:             .FontName  = "Tahoma"
333:             .FontSize  = 8
334:             .BackStyle = 0
335:             .ForeColor = RGB(90, 90, 90)
336:             .Visible   = .T.
337:         ENDWITH
338: 
339:         *-- Filtro: Codigo do grupo
340:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroCgru", "TextBox")
341:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroCgru
342:             .Value         = ""
343:             .Left          = 47
344:             .Top           = 3
345:             .Width         = 35
346:             .Height        = 22
347:             .FontName      = "Tahoma"
348:             .FontSize      = 8
349:             .SpecialEffect = 1
350:             .MaxLength     = 3
351:             .Visible       = .T.
352:         ENDWITH
353:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroCgru, "KeyPress", THIS, "FiltroGrupo_KeyPress")
354:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroCgru, "LostFocus", THIS, "ValidarFiltroGrupo")
355: 
356:         *-- Filtro: Descricao do grupo (leitura)
357:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroDgru", "TextBox")
358:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroDgru
359:             .Value         = ""
360:             .Left          = 84
361:             .Top           = 3
362:             .Width         = 156
363:             .Height        = 22
364:             .FontName      = "Tahoma"
365:             .FontSize      = 8
366:             .SpecialEffect = 1
367:             .ReadOnly      = .T.
368:             .Enabled       = .F.
369:             .Visible       = .T.
370:         ENDWITH
371: 
372:         *-- Filtro: Label Ultima alteracao
373:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData", "Label")
374:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData
375:             .Caption   = "Ult. Alt.:"
376:             .Left      = 248
377:             .Top       = 8
378:             .Width     = 52
379:             .Height    = 15
380:             .FontName  = "Tahoma"
381:             .FontSize  = 8
382:             .BackStyle = 0
383:             .ForeColor = RGB(90, 90, 90)
384:             .Visible   = .T.
385:         ENDWITH
386: 
387:         *-- Filtro: Data Inicio
388:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroDataIni", "TextBox")
389:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroDataIni
390:             .Value         = {}
391:             .Left          = 302
392:             .Top           = 3
393:             .Width         = 80
394:             .Height        = 22

*-- Linhas 428 a 626:
428:         ENDWITH
429: 
430:         *-- Filtro: Situacao (Todos/Ativos/Inativos) - legado: optFilSituas
431:         loc_oPagina.cnt_4c_Filtros.AddObject("opt_4c_FiltraSituas", "OptionGroup")
432:         WITH loc_oPagina.cnt_4c_Filtros.opt_4c_FiltraSituas
433:             .Left        = 500
434:             .Top         = 3
435:             .Width       = 200
436:             .Height      = 25
437:             .ButtonCount = 3
438:             .BorderStyle = 0
439:             .Themes      = .F.
440:             .Value       = 1
441:             .Visible     = .T.
442:         ENDWITH
443:         WITH loc_oPagina.cnt_4c_Filtros.opt_4c_FiltraSituas
444:             .Buttons(1).Caption   = "Todos"
445:             .Buttons(1).Left      = 0
446:             .Buttons(1).Top       = 0
447:             .Buttons(1).AutoSize  = .T.
448:             .Buttons(1).Themes    = .F.
449:             .Buttons(1).FontName  = "Tahoma"
450:             .Buttons(1).FontSize  = 8
451:             .Buttons(2).Caption   = "Ativos"
452:             .Buttons(2).Left      = 65
453:             .Buttons(2).Top       = 0
454:             .Buttons(2).AutoSize  = .T.
455:             .Buttons(2).Themes    = .F.
456:             .Buttons(2).FontName  = "Tahoma"
457:             .Buttons(2).FontSize  = 8
458:             .Buttons(3).Caption   = "Inativos"
459:             .Buttons(3).Left      = 130
460:             .Buttons(3).Top       = 0
461:             .Buttons(3).AutoSize  = .T.
462:             .Buttons(3).Themes    = .F.
463:             .Buttons(3).FontName  = "Tahoma"
464:             .Buttons(3).FontSize  = 8
465:         ENDWITH
466:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.opt_4c_FiltraSituas, "InteractiveChange", THIS, "FiltroSituas_InteractiveChange")
467: 
468:         *-- Botao Pesquisar
469:         loc_oPagina.cnt_4c_Filtros.AddObject("cmd_4c_Pesquisar", "CommandButton")
470:         WITH loc_oPagina.cnt_4c_Filtros.cmd_4c_Pesquisar
471:             .Caption         = "Pesquisar"
472:             .Left            = 708
473:             .Top             = 2
474:             .Width           = 75
475:             .Height          = 22
476:             .FontName        = "Tahoma"
477:             .FontSize        = 8
478:             .Themes          = .F.
479:             .SpecialEffect   = 0
480:             .BackColor       = RGB(255, 255, 255)
481:             .ForeColor       = RGB(90, 90, 90)
482:             .Visible         = .T.
483:         ENDWITH
484:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.cmd_4c_Pesquisar, "Click", THIS, "BtnPesquisarClick")
485: 
486:         *-- Label contador de produtos (legado: lblProdutos top=584)
487:         loc_oPagina.AddObject("lbl_4c_ContadorProdutos", "Label")
488:         WITH loc_oPagina.lbl_4c_ContadorProdutos
489:             .Caption   = "0 produto(s)"
490:             .Top       = 583
491:             .Left      = 38
492:             .Width     = 200
493:             .Height    = 15
494:             .FontName  = "Tahoma"
495:             .FontSize  = 8
496:             .BackStyle = 0
497:             .ForeColor = RGB(90, 90, 90)
498:             .Visible   = .T.
499:         ENDWITH
500: 
501:         *-- Grid de lista (Grade: top=173, left=38, width=922, height=409)
502:         *-- 7 colunas: cpros, dpros, cgrus, sgrus, reffs, usuaalts, situacao
503:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
504:         WITH loc_oPagina.grd_4c_Lista
505:             .Top               = 182
506:             .Left              = 12
507:             .Width             = 940
508:             .Height            = 395
509:             .ReadOnly          = .T.
510:             .DeleteMark        = .F.
511:             .RecordMark        = .F.
512:             .ScrollBars        = 3
513:             .GridLines         = 3
514:             .ColumnCount       = 7
515:             .AllowHeaderSizing = .T.
516:             .Visible           = .T.
517:         ENDWITH
518:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GrdLista_DblClick")
519: 
520:         THIS.TornarControlesVisiveis(loc_oPagina)
521:     ENDPROC
522: 
523:     *--------------------------------------------------------------------------
524:     * ConfigurarPaginaDados - Configura Page2 (Dados do Produto)
525:     * Legado: Optiongroup1 top=5->34, pgframeDados top=-54->-54
526:     *--------------------------------------------------------------------------
527:     PROTECTED PROCEDURE ConfigurarPaginaDados()
528:         LOCAL loc_oPagina
529:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
530: 
531:         *-- Container de botoes Salvar/Cancelar (Top=34, Left=819)
532:         loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
533:         WITH loc_oPagina.cnt_4c_BotoesDados
534:             .Top         = 34
535:             .Left        = 819
536:             .Width       = 165
537:             .Height      = 85
538:             .BackStyle = 1
539:             .BackColor = RGB(53, 53, 53)
540:             .BorderWidth = 0
541:             .Visible     = .T.
542:         ENDWITH
543: 
544:         *-- Botao Salvar (Left=7, Top=5)
545:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
546:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
547:             .Caption         = "Salvar"
548:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
549:             .PicturePosition = 13
550:             .Width           = 75
551:             .Height          = 75
552:             .Left            = 7
553:             .Top             = 5
554:             .FontName        = "Tahoma"
555:             .FontSize        = 8
556:             .Themes          = .F.
557:             .SpecialEffect   = 0
558:             .BackColor       = RGB(255, 255, 255)
559:             .ForeColor       = RGB(90, 90, 90)
560:             .Visible         = .T.
561:         ENDWITH
562:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
563: 
564:         *-- Botao Cancelar (Left=83, Top=5)
565:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
566:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
567:             .Caption         = "Cancelar"
568:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
569:             .PicturePosition = 13
570:             .Width           = 75
571:             .Height          = 75
572:             .Left            = 83
573:             .Top             = 5
574:             .FontName        = "Tahoma"
575:             .FontSize        = 8
576:             .Themes          = .F.
577:             .SpecialEffect   = 0
578:             .BackColor       = RGB(255, 255, 255)
579:             .ForeColor       = RGB(90, 90, 90)
580:             .Visible         = .T.
581:         ENDWITH
582:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
583: 
584:         *-- OptionGroup para navegacao entre abas internas
585:         *-- Legado: Optiongroup1 top=5->34, left=5, width=535, height=85, buttonCount=7
586:         loc_oPagina.AddObject("opt_4c_Abas", "OptionGroup")
587:         WITH loc_oPagina.opt_4c_Abas
588:             .Left        = 5
589:             .Top         = 34
590:             .Width       = 800
591:             .Height      = 85
592:             .ButtonCount = 7
593:             .BorderStyle = 0
594:             .Themes      = .F.
595:             .Value       = 1
596:             .Visible     = .T.
597:         ENDWITH
598:         WITH loc_oPagina.opt_4c_Abas
599:             .Buttons(1).Caption   = "Principal"
600:             .Buttons(1).Left      = 0
601:             .Buttons(1).Top       = 25
602:             .Buttons(1).Width     = 85
603:             .Buttons(1).Height    = 30
604:             .Buttons(1).Themes    = .F.
605:             .Buttons(1).FontName  = "Tahoma"
606:             .Buttons(1).FontSize  = 8
607:             .Buttons(1).ForeColor = RGB(50, 50, 50)
608:             .Buttons(2).Caption   = "Composi" + CHR(231) + CHR(227) + "o"
609:             .Buttons(2).Left      = 90
610:             .Buttons(2).Top       = 25
611:             .Buttons(2).Width     = 90
612:             .Buttons(2).Height    = 30
613:             .Buttons(2).Themes    = .F.
614:             .Buttons(2).FontName  = "Tahoma"
615:             .Buttons(2).FontSize  = 8
616:             .Buttons(2).ForeColor = RGB(50, 50, 50)
617:             .Buttons(3).Caption   = "Custos"
618:             .Buttons(3).Left      = 185
619:             .Buttons(3).Top       = 25
620:             .Buttons(3).Width     = 75
621:             .Buttons(3).Height    = 30
622:             .Buttons(3).Themes    = .F.
623:             .Buttons(3).FontName  = "Tahoma"
624:             .Buttons(3).FontSize  = 8
625:             .Buttons(3).ForeColor = RGB(50, 50, 50)
626:             .Buttons(4).Caption   = "Dados Fiscais"

*-- Linhas 660 a 752:
660:             .Buttons(7).FontSize  = 8
661:             .Buttons(7).ForeColor = RGB(50, 50, 50)
662:         ENDWITH
663:         BINDEVENT(loc_oPagina.opt_4c_Abas, "InteractiveChange", THIS, "OpcaoAbasChange")
664: 
665:         *-- PageFrame interno (pgframeDados legado: top=-54, left=-1, width=1003, height=656)
666:         *-- Tabs=.F. para ocultar abas (navegacao pelo OptionGroup)
667:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
668:         WITH loc_oPagina.pgf_4c_Dados
669:             .Top       = -54
670:             .Left      = -1
671:             .Width     = 1003
672:             .Height    = 685
673:             .PageCount = 7
674:             .Tabs      = .F.
675:             .Visible   = .T.
676: 
677:             .Page1.Caption  = "Principal"
678:             .Page1.BackColor = RGB(255, 255, 255)
679:             .Page2.Caption  = "Composicao"
680:             .Page2.BackColor = RGB(255, 255, 255)
681:             .Page3.Caption  = "Custos"
682:             .Page3.BackColor = RGB(255, 255, 255)
683:             .Page4.Caption  = "Dados Fiscais"
684:             .Page4.BackColor = RGB(255, 255, 255)
685:             .Page5.Caption  = "Designer"
686:             .Page5.BackColor = RGB(255, 255, 255)
687:             .Page6.Caption  = "Consulta"
688:             .Page6.BackColor = RGB(255, 255, 255)
689:             .Page7.Caption  = "Fases"
690:             .Page7.BackColor = RGB(255, 255, 255)
691:         ENDWITH
692: 
693:         *-- Configurar conteudo de cada aba
694:         THIS.ConfigurarTabPrincipal()
695:         THIS.ConfigurarTabComposicao()
696:         THIS.ConfigurarTabCustos()
697:         THIS.ConfigurarTabDadosFiscais()
698:         THIS.ConfigurarPgpgDadosFiscais()
699:         THIS.ConfigurarTabDesigner()
700:         THIS.ConfigurarPgpgDesigner()
701:         THIS.ConfigurarTabConsulta()
702:         THIS.ConfigurarTabFases()
703: 
704:         THIS.TornarControlesVisiveis(loc_oPagina)
705:     ENDPROC
706: 
707:     *--------------------------------------------------------------------------
708:     * ConfigurarTabPrincipal - Aba 1: Dados principais do produto (pgDados)
709:     * Legado: pgframeDados.pgDados (167 controles)
710:     * Posicoes direto do layout.json (sem compensacao - dentro de pgf_4c_Dados)
711:     *--------------------------------------------------------------------------
712:     PROTECTED PROCEDURE ConfigurarTabPrincipal()
713:         LOCAL loc_oPg
714:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
715: 
716:         *-- === CODIGO e DESCRICAO =============================================
717: 
718:         loc_oPg.AddObject("lbl_4c_LblCpros", "Label")
719:         WITH loc_oPg.lbl_4c_LblCpros
720:             .Caption = "Produto :"
721:             .Top = 134
722:             .Left = 58
723:             .Width = 53
724:             .Height = 15
725:             .FontName = "Tahoma"
726:             .FontSize = 8
727:             .BackStyle = 0
728:             .ForeColor = RGB(90,90,90)
729:         ENDWITH
730: 
731:         loc_oPg.AddObject("txt_4c_Cpros", "TextBox")
732:         WITH loc_oPg.txt_4c_Cpros
733:             .Value = ""
734:             .Top = 130
735:             .Left = 113
736:             .Width = 108
737:             .Height = 23
738:             .FontName = "Tahoma"
739:             .FontSize = 8
740:             .SpecialEffect = 1
741:             .MaxLength = 14
742:         ENDWITH
743: 
744:         loc_oPg.AddObject("lbl_4c_LblDpros", "Label")
745:         WITH loc_oPg.lbl_4c_LblDpros
746:             .Caption = "Descri" + CHR(231) + CHR(227) + "o :"
747:             .Top = 134
748:             .Left = 222
749:             .Width = 70
750:             .Height = 15
751:             .FontName = "Tahoma"
752:             .FontSize = 8

*-- Linhas 820 a 864:
820:             .SpecialEffect = 1
821:             .MaxLength = 3
822:         ENDWITH
823:         BINDEVENT(loc_oPg.txt_4c_Cgrus, "KeyPress", THIS, "TabPrincipal_CgruKeyPress")
824:         BINDEVENT(loc_oPg.txt_4c_Cgrus, "LostFocus", THIS, "TabPrincipal_CgruLostFocus")
825: 
826:         loc_oPg.AddObject("txt_4c_Dgrus", "TextBox")
827:         WITH loc_oPg.txt_4c_Dgrus
828:             .Value = ""
829:             .Top = 178
830:             .Left = 145
831:             .Width = 171
832:             .Height = 23
833:             .FontName = "Tahoma"
834:             .FontSize = 8
835:             .SpecialEffect = 1
836:             .ReadOnly = .T.
837:             .Enabled = .F.
838:         ENDWITH
839: 
840:         loc_oPg.AddObject("lbl_4c_LblSgrus", "Label")
841:         WITH loc_oPg.lbl_4c_LblSgrus
842:             .Caption = "Subgrupo :"
843:             .Top = 206
844:             .Left = 56
845:             .Width = 55
846:             .Height = 15
847:             .FontName = "Tahoma"
848:             .FontSize = 8
849:             .BackStyle = 0
850:             .ForeColor = RGB(90,90,90)
851:         ENDWITH
852: 
853:         loc_oPg.AddObject("txt_4c_Csgrus", "TextBox")
854:         WITH loc_oPg.txt_4c_Csgrus
855:             .Value = ""
856:             .Top = 202
857:             .Left = 113
858:             .Width = 52
859:             .Height = 23
860:             .FontName = "Tahoma"
861:             .FontSize = 8
862:             .SpecialEffect = 1
863:             .MaxLength = 6
864:         ENDWITH

*-- Linhas 904 a 1034:
904:             .SpecialEffect = 1
905:             .MaxLength = 10
906:         ENDWITH
907:         BINDEVENT(loc_oPg.txt_4c_Linhas, "KeyPress", THIS, "TabPrincipal_LinhasKeyPress")
908:         BINDEVENT(loc_oPg.txt_4c_Linhas, "LostFocus", THIS, "TabPrincipal_LinhasLostFocus")
909: 
910:         loc_oPg.AddObject("txt_4c_Dlinhas", "TextBox")
911:         WITH loc_oPg.txt_4c_Dlinhas
912:             .Value = ""
913:             .Top = 226
914:             .Left = 194
915:             .Width = 318
916:             .Height = 23
917:             .FontName = "Tahoma"
918:             .FontSize = 8
919:             .SpecialEffect = 1
920:             .ReadOnly = .T.
921:             .Enabled = .F.
922:         ENDWITH
923: 
924:         loc_oPg.AddObject("lbl_4c_LblColecoes", "Label")
925:         WITH loc_oPg.lbl_4c_LblColecoes
926:             .Caption = "Grupo de Venda :"
927:             .Top = 253
928:             .Left = 25
929:             .Width = 86
930:             .Height = 15
931:             .FontName = "Tahoma"
932:             .FontSize = 8
933:             .BackStyle = 0
934:             .ForeColor = RGB(90,90,90)
935:         ENDWITH
936: 
937:         loc_oPg.AddObject("txt_4c_Colecoes", "TextBox")
938:         WITH loc_oPg.txt_4c_Colecoes
939:             .Value = ""
940:             .Top = 250
941:             .Left = 113
942:             .Width = 80
943:             .Height = 23
944:             .FontName = "Tahoma"
945:             .FontSize = 8
946:             .SpecialEffect = 1
947:             .MaxLength = 10
948:         ENDWITH
949:         BINDEVENT(loc_oPg.txt_4c_Colecoes, "KeyPress", THIS, "TabPrincipal_ColecoesKeyPress")
950:         BINDEVENT(loc_oPg.txt_4c_Colecoes, "LostFocus", THIS, "TabPrincipal_ColecoesLostFocus")
951: 
952:         loc_oPg.AddObject("txt_4c_Dcolecoes", "TextBox")
953:         WITH loc_oPg.txt_4c_Dcolecoes
954:             .Value = ""
955:             .Top = 250
956:             .Left = 194
957:             .Width = 318
958:             .Height = 23
959:             .FontName = "Tahoma"
960:             .FontSize = 8
961:             .SpecialEffect = 1
962:             .ReadOnly = .T.
963:             .Enabled = .F.
964:         ENDWITH
965: 
966:         *-- === FORNECEDOR / REF ==============================================
967: 
968:         loc_oPg.AddObject("lbl_4c_LblIfors", "Label")
969:         WITH loc_oPg.lbl_4c_LblIfors
970:             .Caption = "Fornecedor :"
971:             .Top = 278
972:             .Left = 47
973:             .Width = 64
974:             .Height = 15
975:             .FontName = "Tahoma"
976:             .FontSize = 8
977:             .BackStyle = 0
978:             .ForeColor = RGB(90,90,90)
979:         ENDWITH
980: 
981:         loc_oPg.AddObject("txt_4c_Ifors", "TextBox")
982:         WITH loc_oPg.txt_4c_Ifors
983:             .Value = ""
984:             .Top = 274
985:             .Left = 113
986:             .Width = 80
987:             .Height = 23
988:             .FontName = "Tahoma"
989:             .FontSize = 8
990:             .SpecialEffect = 1
991:             .MaxLength = 10
992:         ENDWITH
993:         BINDEVENT(loc_oPg.txt_4c_Ifors, "KeyPress", THIS, "TabPrincipal_IforsKeyPress")
994:         BINDEVENT(loc_oPg.txt_4c_Ifors, "LostFocus", THIS, "TabPrincipal_IforsLostFocus")
995: 
996:         loc_oPg.AddObject("txt_4c_Dfors", "TextBox")
997:         WITH loc_oPg.txt_4c_Dfors
998:             .Value = ""
999:             .Top = 274
1000:             .Left = 194
1001:             .Width = 318
1002:             .Height = 23
1003:             .FontName = "Tahoma"
1004:             .FontSize = 8
1005:             .SpecialEffect = 1
1006:             .ReadOnly = .T.
1007:             .Enabled = .F.
1008:         ENDWITH
1009: 
1010:         loc_oPg.AddObject("lbl_4c_LblReffs", "Label")
1011:         WITH loc_oPg.lbl_4c_LblReffs
1012:             .Caption = "Ref. Fornecedor :"
1013:             .Top = 301
1014:             .Left = 23
1015:             .Width = 88
1016:             .Height = 15
1017:             .FontName = "Tahoma"
1018:             .FontSize = 8
1019:             .BackStyle = 0
1020:             .ForeColor = RGB(90,90,90)
1021:         ENDWITH
1022: 
1023:         loc_oPg.AddObject("txt_4c_Reffs", "TextBox")
1024:         WITH loc_oPg.txt_4c_Reffs
1025:             .Value = ""
1026:             .Top = 298
1027:             .Left = 113
1028:             .Width = 152
1029:             .Height = 23
1030:             .FontName = "Tahoma"
1031:             .FontSize = 8
1032:             .SpecialEffect = 1
1033:             .MaxLength = 40
1034:         ENDWITH

*-- Linhas 1140 a 1183:
1140:             .SpecialEffect = 1
1141:             .MaxLength = 14
1142:         ENDWITH
1143:         BINDEVENT(loc_oPg.txt_4c_Cproeqs, "KeyPress", THIS, "TabPrincipal_CproeqsKeyPress")
1144: 
1145:         loc_oPg.AddObject("lbl_4c_LblCbars", "Label")
1146:         WITH loc_oPg.lbl_4c_LblCbars
1147:             .Caption = "Barra :"
1148:             .Top = 157
1149:             .Left = 590
1150:             .Width = 35
1151:             .Height = 15
1152:             .FontName = "Tahoma"
1153:             .FontSize = 8
1154:             .BackStyle = 0
1155:             .ForeColor = RGB(90,90,90)
1156:         ENDWITH
1157: 
1158:         loc_oPg.AddObject("txt_4c_Cbars", "TextBox")
1159:         WITH loc_oPg.txt_4c_Cbars
1160:             .Value = 0
1161:             .Top = 155
1162:             .Left = 626
1163:             .Width = 108
1164:             .Height = 21
1165:             .FontName = "Tahoma"
1166:             .FontSize = 8
1167:             .SpecialEffect = 1
1168:         ENDWITH
1169: 
1170:         loc_oPg.AddObject("lbl_4c_LblEan13", "Label")
1171:         WITH loc_oPg.lbl_4c_LblEan13
1172:             .Caption = "EAN/GTIN :"
1173:             .Top = 181
1174:             .Left = 568
1175:             .Width = 57
1176:             .Height = 15
1177:             .FontName = "Tahoma"
1178:             .FontSize = 8
1179:             .BackStyle = 0
1180:             .ForeColor = RGB(90,90,90)
1181:         ENDWITH
1182: 
1183:         loc_oPg.AddObject("txt_4c_Ean13", "TextBox")

*-- Linhas 1192 a 1237:
1192:             .SpecialEffect = 1
1193:         ENDWITH
1194: 
1195:         *-- === SITUACAO / DATA SITUACAO ======================================
1196: 
1197:         loc_oPg.AddObject("opt_4c_Situas", "OptionGroup")
1198:         WITH loc_oPg.opt_4c_Situas
1199:             .Top = 130
1200:             .Left = 735
1201:             .Width = 142
1202:             .Height = 25
1203:             .ButtonCount = 2
1204:             .BorderStyle = 0
1205:             .Themes = .F.
1206:             .Value = 1
1207:         ENDWITH
1208:         WITH loc_oPg.opt_4c_Situas
1209:             .Buttons(1).Caption = "Ativo"  
1210:             .Buttons(1).Left = 0 
1211:             .Buttons(1).Top = 0
1212:             .Buttons(1).AutoSize = .T.
1213:             .Buttons(1).Themes = .F.
1214:             .Buttons(1).FontName = "Tahoma"
1215:             .Buttons(1).FontSize = 8
1216:             .Buttons(2).Caption = "Inativo"
1217:             .Buttons(2).Left = 60
1218:             .Buttons(2).Top = 0
1219:             .Buttons(2).AutoSize = .T.
1220:             .Buttons(2).Themes = .F.
1221:             .Buttons(2).FontName = "Tahoma"
1222:             .Buttons(2).FontSize = 8
1223:         ENDWITH
1224: 
1225:         loc_oPg.AddObject("txt_4c_DtSituas", "TextBox")
1226:         WITH loc_oPg.txt_4c_DtSituas
1227:             .Value = {}
1228:             .Top = 132
1229:             .Left = 878
1230:             .Width = 80
1231:             .Height = 21
1232:             .FontName = "Tahoma"
1233:             .FontSize = 8
1234:             .SpecialEffect = 1
1235:             .ReadOnly = .T.
1236:             .Enabled = .F.
1237:         ENDWITH

*-- Linhas 1555 a 1639:
1555:             .SpecialEffect = 1
1556:             .MaxLength = 3
1557:         ENDWITH
1558:         BINDEVENT(loc_oPg.txt_4c_Moecs, "KeyPress", THIS, "TabPrincipal_MoeKeyPress")
1559:         BINDEVENT(loc_oPg.txt_4c_Moecs, "LostFocus", THIS, "TabPrincipal_MoeLostFocus")
1560: 
1561:         loc_oPg.AddObject("lbl_4c_LblPvens", "Label")
1562:         WITH loc_oPg.lbl_4c_LblPvens
1563:             .Caption = "Valor de Venda :"
1564:             .Top = 400
1565:             .Left = 505
1566:             .Width = 120
1567:             .Height = 15
1568:             .FontName = "Tahoma"
1569:             .FontSize = 8
1570:             .BackStyle = 0
1571:             .ForeColor = RGB(90,90,90)
1572:         ENDWITH
1573: 
1574:         loc_oPg.AddObject("txt_4c_Pvens", "TextBox")
1575:         WITH loc_oPg.txt_4c_Pvens
1576:             .Value = 0
1577:             .Top = 397
1578:             .Left = 626
1579:             .Width = 127
1580:             .Height = 21
1581:             .FontName = "Tahoma"
1582:             .FontSize = 8
1583:             .SpecialEffect = 1
1584:         ENDWITH
1585: 
1586:         loc_oPg.AddObject("txt_4c_Moepvs", "TextBox")
1587:         WITH loc_oPg.txt_4c_Moepvs
1588:             .Value = ""
1589:             .Top = 397
1590:             .Left = 754
1591:             .Width = 31
1592:             .Height = 21
1593:             .FontName = "Tahoma"
1594:             .FontSize = 8
1595:             .SpecialEffect = 1
1596:             .MaxLength = 3
1597:         ENDWITH
1598:         BINDEVENT(loc_oPg.txt_4c_Moepvs, "KeyPress", THIS, "TabPrincipal_MoeKeyPress")
1599:         BINDEVENT(loc_oPg.txt_4c_Moepvs, "LostFocus", THIS, "TabPrincipal_MoeLostFocus")
1600: 
1601:         loc_oPg.AddObject("lbl_4c_LblFvendas", "Label")
1602:         WITH loc_oPg.lbl_4c_LblFvendas
1603:             .Caption = "Fator  de Venda :"
1604:             .Top = 422
1605:             .Left = 539
1606:             .Width = 86
1607:             .Height = 15
1608:             .FontName = "Tahoma"
1609:             .FontSize = 8
1610:             .BackStyle = 0
1611:             .ForeColor = RGB(90,90,90)
1612:         ENDWITH
1613: 
1614:         loc_oPg.AddObject("txt_4c_Fvendas", "TextBox")
1615:         WITH loc_oPg.txt_4c_Fvendas
1616:             .Value = 0
1617:             .Top = 419
1618:             .Left = 626
1619:             .Width = 127
1620:             .Height = 21
1621:             .FontName = "Tahoma"
1622:             .FontSize = 8
1623:             .SpecialEffect = 1
1624:         ENDWITH
1625: 
1626:         loc_oPg.AddObject("txt_4c_Moevs", "TextBox")
1627:         WITH loc_oPg.txt_4c_Moevs
1628:             .Value = ""
1629:             .Top = 419
1630:             .Left = 754
1631:             .Width = 31
1632:             .Height = 21
1633:             .FontName = "Tahoma"
1634:             .FontSize = 8
1635:             .SpecialEffect = 1
1636:             .MaxLength = 3
1637:         ENDWITH
1638: 
1639:         *-- === AUDITORIA (ReadOnly) ==========================================

*-- Linhas 1760 a 1846:
1760:             .SpecialEffect = 1
1761:             .MaxLength = 3
1762:         ENDWITH
1763:         BINDEVENT(loc_oPg.txt_4c_Cunis, "KeyPress", THIS, "TabPrincipal_CunisKeyPress")
1764:         BINDEVENT(loc_oPg.txt_4c_Cunis, "LostFocus", THIS, "TabPrincipal_CunisLostFocus")
1765: 
1766:         loc_oPg.AddObject("txt_4c_Dunis", "TextBox")
1767:         WITH loc_oPg.txt_4c_Dunis
1768:             .Value = ""
1769:             .Top = 394
1770:             .Left = 145
1771:             .Width = 150
1772:             .Height = 23
1773:             .FontName = "Tahoma"
1774:             .FontSize = 8
1775:             .SpecialEffect = 1
1776:             .ReadOnly = .T.
1777:             .Enabled = .F.
1778:         ENDWITH
1779: 
1780:         loc_oPg.AddObject("lbl_4c_LblCunips", "Label")
1781:         WITH loc_oPg.lbl_4c_LblCunips
1782:             .Caption = "(2) :"
1783:             .Top = 398
1784:             .Left = 301
1785:             .Width = 23
1786:             .Height = 15
1787:             .FontName = "Tahoma"
1788:             .FontSize = 8
1789:             .BackStyle = 0
1790:             .ForeColor = RGB(90,90,90)
1791:         ENDWITH
1792: 
1793:         loc_oPg.AddObject("txt_4c_Cunips", "TextBox")
1794:         WITH loc_oPg.txt_4c_Cunips
1795:             .Value = ""
1796:             .Top = 394
1797:             .Left = 330
1798:             .Width = 31
1799:             .Height = 23
1800:             .FontName = "Tahoma"
1801:             .FontSize = 8
1802:             .SpecialEffect = 1
1803:             .MaxLength = 3
1804:         ENDWITH
1805:         BINDEVENT(loc_oPg.txt_4c_Cunips, "KeyPress", THIS, "TabPrincipal_CunipsKeyPress")
1806:         BINDEVENT(loc_oPg.txt_4c_Cunips, "LostFocus", THIS, "TabPrincipal_CunipsLostFocus")
1807: 
1808:         loc_oPg.AddObject("txt_4c_Dunips", "TextBox")
1809:         WITH loc_oPg.txt_4c_Dunips
1810:             .Value = ""
1811:             .Top = 394
1812:             .Left = 362
1813:             .Width = 150
1814:             .Height = 23
1815:             .FontName = "Tahoma"
1816:             .FontSize = 8
1817:             .SpecialEffect = 1
1818:             .ReadOnly = .T.
1819:             .Enabled = .F.
1820:         ENDWITH
1821: 
1822:         *-- === CLASSIFICACAO / MODELO / ACABAMENTO / LOCAL ===================
1823: 
1824:         loc_oPg.AddObject("lbl_4c_LblCclass", "Label")
1825:         WITH loc_oPg.lbl_4c_LblCclass
1826:             .Caption = "Classifica" + CHR(231) + CHR(227) + "o :"
1827:             .Top = 374
1828:             .Left = 7
1829:             .Width = 104
1830:             .Height = 15
1831:             .FontName = "Tahoma"
1832:             .FontSize = 8
1833:             .BackStyle = 0
1834:             .ForeColor = RGB(90,90,90)
1835:         ENDWITH
1836: 
1837:         loc_oPg.AddObject("txt_4c_Cclass", "TextBox")
1838:         WITH loc_oPg.txt_4c_Cclass
1839:             .Value = ""
1840:             .Top = 370
1841:             .Left = 113
1842:             .Width = 31
1843:             .Height = 23
1844:             .FontName = "Tahoma"
1845:             .FontSize = 8
1846:             .SpecialEffect = 1

*-- Linhas 1926 a 1970:
1926:             .SpecialEffect = 1
1927:             .MaxLength = 3
1928:         ENDWITH
1929:         BINDEVENT(loc_oPg.txt_4c_Codacbs, "KeyPress", THIS, "TabPrincipal_CodacbsKeyPress")
1930:         BINDEVENT(loc_oPg.txt_4c_Codacbs, "LostFocus", THIS, "TabPrincipal_CodacbsLostFocus")
1931: 
1932:         loc_oPg.AddObject("txt_4c_Dcodacbs", "TextBox")
1933:         WITH loc_oPg.txt_4c_Dcodacbs
1934:             .Value = ""
1935:             .Top = 346
1936:             .Left = 145
1937:             .Width = 150
1938:             .Height = 23
1939:             .FontName = "Tahoma"
1940:             .FontSize = 8
1941:             .SpecialEffect = 1
1942:             .ReadOnly = .T.
1943:             .Enabled = .F.
1944:         ENDWITH
1945: 
1946:         loc_oPg.AddObject("lbl_4c_LblLocals", "Label")
1947:         WITH loc_oPg.lbl_4c_LblLocals
1948:             .Caption = "Local :"
1949:             .Top = 374
1950:             .Left = 364
1951:             .Width = 33
1952:             .Height = 15
1953:             .FontName = "Tahoma"
1954:             .FontSize = 8
1955:             .BackStyle = 0
1956:             .ForeColor = RGB(90,90,90)
1957:         ENDWITH
1958: 
1959:         loc_oPg.AddObject("txt_4c_Locals", "TextBox")
1960:         WITH loc_oPg.txt_4c_Locals
1961:             .Value = ""
1962:             .Top = 370
1963:             .Left = 401
1964:             .Width = 111
1965:             .Height = 23
1966:             .FontName = "Tahoma"
1967:             .FontSize = 8
1968:             .SpecialEffect = 1
1969:             .MaxLength = 10
1970:         ENDWITH

*-- Linhas 2046 a 2117:
2046:             .SpecialEffect = 1
2047:             .MaxLength = 4
2048:         ENDWITH
2049:         BINDEVENT(loc_oPg.txt_4c_Codcors, "KeyPress", THIS, "TabPrincipal_CodcorsKeyPress")
2050:         BINDEVENT(loc_oPg.txt_4c_Codcors, "LostFocus", THIS, "TabPrincipal_CodcorsLostFocus")
2051: 
2052:         loc_oPg.AddObject("lbl_4c_LblCodtams", "Label")
2053:         WITH loc_oPg.lbl_4c_LblCodtams
2054:             .Caption = "Tam:"
2055:             .Top = 302
2056:             .Left = 442
2057:             .Width = 30
2058:             .Height = 15
2059:             .FontName = "Tahoma"
2060:             .FontSize = 8
2061:             .BackStyle = 0
2062:             .ForeColor = RGB(90,90,90)
2063:         ENDWITH
2064: 
2065:         loc_oPg.AddObject("txt_4c_Codtams", "TextBox")
2066:         WITH loc_oPg.txt_4c_Codtams
2067:             .Value = ""
2068:             .Top = 298
2069:             .Left = 474
2070:             .Width = 38
2071:             .Height = 23
2072:             .FontName = "Tahoma"
2073:             .FontSize = 8
2074:             .SpecialEffect = 1
2075:             .MaxLength = 4
2076:         ENDWITH
2077:         BINDEVENT(loc_oPg.txt_4c_Codtams, "KeyPress", THIS, "TabPrincipal_CodtamsKeyPress")
2078: 
2079:         loc_oPg.AddObject("lbl_4c_LblCodident", "Label")
2080:         WITH loc_oPg.lbl_4c_LblCodident
2081:             .Caption = "Cod. Identidade :"
2082:             .Top = 422
2083:             .Left = 24
2084:             .Width = 87
2085:             .Height = 15
2086:             .FontName = "Tahoma"
2087:             .FontSize = 8
2088:             .BackStyle = 0
2089:             .ForeColor = RGB(90,90,90)
2090:         ENDWITH
2091: 
2092:         loc_oPg.AddObject("txt_4c_Codident", "TextBox")
2093:         WITH loc_oPg.txt_4c_Codident
2094:             .Value = ""
2095:             .Top = 418
2096:             .Left = 113
2097:             .Width = 182
2098:             .Height = 23
2099:             .FontName = "Tahoma"
2100:             .FontSize = 8
2101:             .SpecialEffect = 1
2102:             .MaxLength = 20
2103:         ENDWITH
2104: 
2105:         *-- === GARANTIA / PRODUTO WEB / VARIACAO =============================
2106: 
2107:         loc_oPg.AddObject("lbl_4c_LblDiasgar", "Label")
2108:         WITH loc_oPg.lbl_4c_LblDiasgar
2109:             .Caption = "Garantia :"
2110:             .Top = 228
2111:             .Left = 827
2112:             .Width = 50
2113:             .Height = 15
2114:             .FontName = "Tahoma"
2115:             .FontSize = 8
2116:             .BackStyle = 0
2117:             .ForeColor = RGB(90,90,90)

*-- Linhas 2166 a 2211:
2166:             .FontSize = 8
2167:             .BackStyle = 0
2168:             .ForeColor = RGB(90,90,90)
2169:         ENDWITH
2170: 
2171:         loc_oPg.AddObject("opt_4c_ProdWeb", "OptionGroup")
2172:         WITH loc_oPg.opt_4c_ProdWeb
2173:             .Top = 172
2174:             .Left = 879
2175:             .Width = 117
2176:             .Height = 42
2177:             .ButtonCount = 4
2178:             .BorderStyle = 0
2179:             .Themes = .F.
2180:             .Value = 1
2181:         ENDWITH
2182:         WITH loc_oPg.opt_4c_ProdWeb
2183:             .Buttons(1).Caption = "N" + CHR(227) + "o"
2184:             .Buttons(1).Left = 0 
2185:             .Buttons(1).Top = 0
2186:             .Buttons(1).AutoSize = .T.
2187:             .Buttons(1).Themes = .F.
2188:             .Buttons(1).FontName = "Tahoma"
2189:             .Buttons(1).FontSize = 8
2190:             .Buttons(2).Caption = "Sim"  
2191:             .Buttons(2).Left = 35
2192:             .Buttons(2).Top = 0
2193:             .Buttons(2).AutoSize = .T.
2194:             .Buttons(2).Themes = .F.
2195:             .Buttons(2).FontName = "Tahoma"
2196:             .Buttons(2).FontSize = 8
2197:             .Buttons(3).Caption = "Img"  
2198:             .Buttons(3).Left = 65
2199:             .Buttons(3).Top = 0
2200:             .Buttons(3).AutoSize = .T.
2201:             .Buttons(3).Themes = .F.
2202:             .Buttons(3).FontName = "Tahoma"
2203:             .Buttons(3).FontSize = 8
2204:             .Buttons(4).Caption = "Sim+Img"
2205:             .Buttons(4).Left = 0
2206:             .Buttons(4).Top = 22
2207:             .Buttons(4).AutoSize = .T.
2208:             .Buttons(4).Themes = .F.
2209:             .Buttons(4).FontName = "Tahoma"
2210:             .Buttons(4).FontSize = 8
2211:         ENDWITH

*-- Linhas 2221 a 2266:
2221:             .FontSize = 8
2222:             .BackStyle = 0
2223:             .ForeColor = RGB(90,90,90)
2224:         ENDWITH
2225: 
2226:         loc_oPg.AddObject("opt_4c_Varias", "OptionGroup")
2227:         WITH loc_oPg.opt_4c_Varias
2228:             .Top = 203
2229:             .Left = 874
2230:             .Width = 107
2231:             .Height = 22
2232:             .ButtonCount = 2
2233:             .BorderStyle = 0
2234:             .Themes = .F.
2235:             .Value = 2
2236:         ENDWITH
2237:         WITH loc_oPg.opt_4c_Varias
2238:             .Buttons(1).Caption = "Sim"        
2239:             .Buttons(1).Left = 0 
2240:             .Buttons(1).Top = 0
2241:             .Buttons(1).AutoSize = .T.
2242:             .Buttons(1).Themes = .F.
2243:             .Buttons(1).FontName = "Tahoma"
2244:             .Buttons(1).FontSize = 8
2245:             .Buttons(2).Caption = "N" + CHR(227) + "o"
2246:             .Buttons(2).Left = 42
2247:             .Buttons(2).Top = 0
2248:             .Buttons(2).AutoSize = .T.
2249:             .Buttons(2).Themes = .F.
2250:             .Buttons(2).FontName = "Tahoma"
2251:             .Buttons(2).FontSize = 8
2252:         ENDWITH
2253: 
2254:         *-- === DIMENSOES FINAS (altura/largura/diametro/espessura/comprimento) =
2255: 
2256:         loc_oPg.AddObject("lbl_4c_LblAltura", "Label")
2257:         WITH loc_oPg.lbl_4c_LblAltura
2258:             .Caption = "Altura :"
2259:             .Top = 250
2260:             .Left = 881
2261:             .Width = 38
2262:             .Height = 15
2263:             .FontName = "Tahoma"
2264:             .FontSize = 8
2265:             .BackStyle = 0
2266:             .ForeColor = RGB(90,90,90)

*-- Linhas 2749 a 2792:
2749:     * ConfigurarTabComposicao - Aba 2: Composicao de materiais (pgComposicao)
2750:     * IMPLEMENTADO NA FASE 5
2751:     *--------------------------------------------------------------------------
2752:     PROTECTED PROCEDURE ConfigurarTabComposicao()
2753:         LOCAL loc_oPg
2754:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2755: 
2756:         *-- GradeGRUPO (top=34, left=582, width=229, height=107, 3 cols)
2757:         *-- Mostra totais por grupo de composicao
2758:         loc_oPg.AddObject("grd_4c_GrupoCompo", "Grid")
2759:         WITH loc_oPg.grd_4c_GrupoCompo
2760:             .Top         = 34
2761:             .Left        = 582
2762:             .Width       = 229
2763:             .Height      = 107
2764:             .ReadOnly    = .T.
2765:             .DeleteMark  = .F.
2766:             .RecordMark  = .F.
2767:             .ScrollBars  = 3
2768:             .GridLines   = 3
2769:             .ColumnCount = 3
2770:             .FontName    = "Verdana"
2771:             .FontSize    = 8
2772:             .Visible     = .T.
2773:         ENDWITH
2774:         WITH loc_oPg.grd_4c_GrupoCompo
2775:             .Column1.Header1.Caption = "Grupo"
2776:             .Column1.Width = 70
2777:             .Column2.Header1.Caption = "Total"
2778:             .Column2.Width = 95
2779:             .Column3.Header1.Caption = "Moe"
2780:             .Column3.Width = 50
2781:         ENDWITH
2782: 
2783:         *-- grdCompo - Composicao principal (top=148, left=6, width=943, height=147, 14 cols)
2784:         *-- Dados: SIGPRCPO - Material, Descricao, Unidade, Valor, Qtde, Total, Moeda, Obs, Etiq, Consumo, QtdCV, UnCV, Ordem, Compos
2785:         loc_oPg.AddObject("grd_4c_Compo", "Grid")
2786:         WITH loc_oPg.grd_4c_Compo
2787:             .Top         = 148
2788:             .Left        = 6
2789:             .Width       = 943
2790:             .Height      = 147
2791:             .ReadOnly    = .T.
2792:             .DeleteMark  = .F.

*-- Linhas 3157 a 3323:
3157:             .ToolTipText     = "Incluir"
3158:             .Visible         = .T.
3159:         ENDWITH
3160:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoIncluir, "Click", THIS, "CmdCompoIncluirClick")
3161: 
3162:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoExcluir", "CommandButton")
3163:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoExcluir
3164:             .Caption         = "-"
3165:             .Top             = 42
3166:             .Left            = 0
3167:             .Width           = 50
3168:             .Height          = 42
3169:             .FontName        = "Tahoma"
3170:             .FontSize        = 14
3171:             .FontBold        = .T.
3172:             .Themes          = .F.
3173:             .SpecialEffect   = 0
3174:             .BackColor       = RGB(255,255,255)
3175:             .ForeColor       = RGB(180,0,0)
3176:             .ToolTipText     = "Excluir"
3177:             .Visible         = .T.
3178:         ENDWITH
3179:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoExcluir, "Click", THIS, "CmdCompoExcluirClick")
3180: 
3181:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoAtualizar", "CommandButton")
3182:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoAtualizar
3183:             .Caption         = CHR(8635)
3184:             .Top             = 84
3185:             .Left            = 0
3186:             .Width           = 50
3187:             .Height          = 42
3188:             .FontName        = "Tahoma"
3189:             .FontSize        = 10
3190:             .Themes          = .F.
3191:             .SpecialEffect   = 0
3192:             .BackColor       = RGB(255,255,255)
3193:             .ForeColor       = RGB(0,0,180)
3194:             .ToolTipText     = "Atualizar Pre" + CHR(231) + "os"
3195:             .Visible         = .T.
3196:         ENDWITH
3197:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoAtualizar, "Click", THIS, "CmdCompoAtualizarClick")
3198: 
3199:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoPeso", "CommandButton")
3200:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoPeso
3201:             .Caption         = "Kg"
3202:             .Top             = 126
3203:             .Left            = 0
3204:             .Width           = 50
3205:             .Height          = 42
3206:             .FontName        = "Tahoma"
3207:             .FontSize        = 8
3208:             .Themes          = .F.
3209:             .SpecialEffect   = 0
3210:             .BackColor       = RGB(255,255,255)
3211:             .ForeColor       = RGB(90,90,90)
3212:             .ToolTipText     = "Atualizar Pesos"
3213:             .Visible         = .T.
3214:         ENDWITH
3215:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoPeso, "Click", THIS, "CmdCompoAtuPesosClick")
3216: 
3217:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoRecalc", "CommandButton")
3218:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoRecalc
3219:             .Caption         = "="
3220:             .Top             = 168
3221:             .Left            = 0
3222:             .Width           = 50
3223:             .Height          = 42
3224:             .FontName        = "Tahoma"
3225:             .FontSize        = 14
3226:             .Themes          = .F.
3227:             .SpecialEffect   = 0
3228:             .BackColor       = RGB(255,255,255)
3229:             .ForeColor       = RGB(90,90,90)
3230:             .ToolTipText     = "Recalcular"
3231:             .Visible         = .T.
3232:         ENDWITH
3233:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoRecalc, "Click", THIS, "CmdCompoRecalcClick")
3234: 
3235:         *-- === COMANDOS PARA grdsubcp (Container com 2 botoes, top=345, left=947) ==========
3236:         loc_oPg.AddObject("obj_4c_CmdgSubCp", "Container")
3237:         WITH loc_oPg.obj_4c_CmdgSubCp
3238:             .Top         = 345
3239:             .Left        = 947
3240:             .Width       = 50
3241:             .Height      = 90
3242:             .BackStyle   = 0
3243:             .BorderWidth = 0
3244:             .Visible     = .T.
3245:         ENDWITH
3246: 
3247:         loc_oPg.obj_4c_CmdgSubCp.AddObject("cmd_4c_SubCpIncluir", "CommandButton")
3248:         WITH loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpIncluir
3249:             .Caption         = "+"
3250:             .Top             = 0
3251:             .Left            = 0
3252:             .Width           = 50
3253:             .Height          = 45
3254:             .FontName        = "Tahoma"
3255:             .FontSize        = 14
3256:             .FontBold        = .T.
3257:             .Themes          = .F.
3258:             .SpecialEffect   = 0
3259:             .BackColor       = RGB(255,255,255)
3260:             .ForeColor       = RGB(0,128,0)
3261:             .ToolTipText     = "Incluir Sub-Componente"
3262:             .Visible         = .T.
3263:         ENDWITH
3264:         BINDEVENT(loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpIncluir, "Click", THIS, "CmdSubCpIncluirClick")
3265: 
3266:         loc_oPg.obj_4c_CmdgSubCp.AddObject("cmd_4c_SubCpExcluir", "CommandButton")
3267:         WITH loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpExcluir
3268:             .Caption         = "-"
3269:             .Top             = 45
3270:             .Left            = 0
3271:             .Width           = 50
3272:             .Height          = 45
3273:             .FontName        = "Tahoma"
3274:             .FontSize        = 14
3275:             .FontBold        = .T.
3276:             .Themes          = .F.
3277:             .SpecialEffect   = 0
3278:             .BackColor       = RGB(255,255,255)
3279:             .ForeColor       = RGB(180,0,0)
3280:             .ToolTipText     = "Excluir Sub-Componente"
3281:             .Visible         = .T.
3282:         ENDWITH
3283:         BINDEVENT(loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpExcluir, "Click", THIS, "CmdSubCpExcluirClick")
3284: 
3285:         *-- === OBSERVACAO E DESCRICAO (entre grdCompo e grdsubcp, top=297-325) =============
3286:         loc_oPg.AddObject("lbl_4c_Label4", "Label")
3287:         WITH loc_oPg.lbl_4c_Label4
3288:             .Caption   = "Obs. da OF :"
3289:             .Top       = 300
3290:             .Left      = 36
3291:             .Width     = 64
3292:             .Height    = 15
3293:             .FontName  = "Tahoma"
3294:             .FontSize  = 8
3295:             .BackStyle = 0
3296:             .ForeColor = RGB(90,90,90)
3297:         ENDWITH
3298: 
3299:         loc_oPg.AddObject("txt_4c_ObsOFs", "TextBox")
3300:         WITH loc_oPg.txt_4c_ObsOFs
3301:             .Value    = ""
3302:             .Top      = 297
3303:             .Left     = 99
3304:             .Width    = 850
3305:             .Height   = 21
3306:             .FontName = "Tahoma"
3307:             .FontSize = 8
3308:             .MaxLength = 100
3309:         ENDWITH
3310: 
3311:         loc_oPg.AddObject("lbl_4c_Label16", "Label")
3312:         WITH loc_oPg.lbl_4c_Label16
3313:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
3314:             .Top       = 324
3315:             .Left      = 45
3316:             .Width     = 55
3317:             .Height    = 15
3318:             .FontName  = "Tahoma"
3319:             .FontSize  = 8
3320:             .BackStyle = 0
3321:             .ForeColor = RGB(90,90,90)
3322:         ENDWITH
3323: 

*-- Linhas 3331 a 3483:
3331:             .FontName = "Tahoma"
3332:             .FontSize = 8
3333:         ENDWITH
3334:         BINDEVENT(loc_oPg.txt_4c_Desc, "LostFocus", THIS, "TabCompo_DescLostFocus")
3335: 
3336:         loc_oPg.AddObject("lbl_4c_Label15", "Label")
3337:         WITH loc_oPg.lbl_4c_Label15
3338:             .Caption   = "Material Principal :"
3339:             .Top       = 324
3340:             .Left      = 421
3341:             .Width     = 89
3342:             .Height    = 15
3343:             .FontName  = "Tahoma"
3344:             .FontSize  = 8
3345:             .BackStyle = 0
3346:             .ForeColor = RGB(90,90,90)
3347:         ENDWITH
3348: 
3349:         loc_oPg.AddObject("txt_4c_MatP", "TextBox")
3350:         WITH loc_oPg.txt_4c_MatP
3351:             .Value    = ""
3352:             .Top      = 321
3353:             .Left     = 517
3354:             .Width    = 108
3355:             .Height   = 21
3356:             .FontName = "Tahoma"
3357:             .FontSize = 8
3358:         ENDWITH
3359:         BINDEVENT(loc_oPg.txt_4c_MatP, "LostFocus", THIS, "TabCompo_MatPLostFocus")
3360: 
3361:         *-- === CAMPOS SUB-COMPONENTE (abaixo de grdsubcp, top=432-435) =====================
3362:         loc_oPg.AddObject("lbl_4c_Label3", "Label")
3363:         WITH loc_oPg.lbl_4c_Label3
3364:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
3365:             .Top       = 435
3366:             .Left      = 39
3367:             .Width     = 55
3368:             .Height    = 15
3369:             .FontName  = "Tahoma"
3370:             .FontSize  = 8
3371:             .BackStyle = 0
3372:             .ForeColor = RGB(90,90,90)
3373:         ENDWITH
3374: 
3375:         loc_oPg.AddObject("txt_4c__desccp", "TextBox")
3376:         WITH loc_oPg.txt_4c__desccp
3377:             .Value    = ""
3378:             .Top      = 432
3379:             .Left     = 99
3380:             .Width    = 298
3381:             .Height   = 21
3382:             .FontName = "Tahoma"
3383:             .FontSize = 8
3384:         ENDWITH
3385:         BINDEVENT(loc_oPg.txt_4c__desccp, "LostFocus", THIS, "TabCompo_DesccpLostFocus")
3386: 
3387:         loc_oPg.AddObject("lbl_4c_Label5", "Label")
3388:         WITH loc_oPg.lbl_4c_Label5
3389:             .Caption   = "Substitui :"
3390:             .Top       = 435
3391:             .Left      = 465
3392:             .Width     = 50
3393:             .Height    = 15
3394:             .FontName  = "Tahoma"
3395:             .FontSize  = 8
3396:             .BackStyle = 0
3397:             .ForeColor = RGB(90,90,90)
3398:         ENDWITH
3399: 
3400:         loc_oPg.AddObject("txt_4c__matsub", "TextBox")
3401:         WITH loc_oPg.txt_4c__matsub
3402:             .Value    = ""
3403:             .Top      = 432
3404:             .Left     = 517
3405:             .Width    = 108
3406:             .Height   = 21
3407:             .FontName = "Tahoma"
3408:             .FontSize = 8
3409:         ENDWITH
3410:         BINDEVENT(loc_oPg.txt_4c__matsub, "LostFocus", THIS, "TabCompo_MatsubLostFocus")
3411: 
3412:         *-- === CHECKBOXES LIBERAR CUSTO / VENDA (top=458-459) ==============================
3413:         loc_oPg.AddObject("chk_4c_ChkLiberaCusto", "CheckBox")
3414:         WITH loc_oPg.chk_4c_ChkLiberaCusto
3415:             .Caption   = "Custo"
3416:             .Value     = .F.
3417:             .Top       = 458
3418:             .Left      = 9
3419:             .Width     = 39
3420:             .Height    = 38
3421:             .FontName  = "Tahoma"
3422:             .FontSize  = 8
3423:             .BackStyle = 0
3424:             .Themes    = .F.
3425:             .Visible   = .T.
3426:         ENDWITH
3427:         BINDEVENT(loc_oPg.chk_4c_ChkLiberaCusto, "Click", THIS, "ChkLiberaCustoClick")
3428: 
3429:         loc_oPg.AddObject("chk_4c_ChkLiberaVenda", "CheckBox")
3430:         WITH loc_oPg.chk_4c_ChkLiberaVenda
3431:             .Caption   = "Venda"
3432:             .Value     = .F.
3433:             .Top       = 459
3434:             .Left      = 323
3435:             .Width     = 39
3436:             .Height    = 38
3437:             .FontName  = "Tahoma"
3438:             .FontSize  = 8
3439:             .BackStyle = 0
3440:             .Themes    = .F.
3441:             .Visible   = .T.
3442:         ENDWITH
3443:         BINDEVENT(loc_oPg.chk_4c_ChkLiberaVenda, "Click", THIS, "ChkLiberaVendaClick")
3444: 
3445:         *-- === LABELS DIVISORES CUSTO/VENDA (top=473-474) ==================================
3446:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
3447:         WITH loc_oPg.lbl_4c_Label1
3448:             .Caption   = " Custo "
3449:             .Top       = 473
3450:             .Left      = 47
3451:             .Width     = 46
3452:             .Height    = 16
3453:             .FontName  = "Tahoma"
3454:             .FontSize  = 8
3455:             .BackStyle = 1
3456:             .BackColor = RGB(220,220,220)
3457:             .ForeColor = RGB(50,50,50)
3458:         ENDWITH
3459: 
3460:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
3461:         WITH loc_oPg.lbl_4c_Label2
3462:             .Caption   = " Venda "
3463:             .Top       = 474
3464:             .Left      = 361
3465:             .Width     = 48
3466:             .Height    = 16
3467:             .FontName  = "Tahoma"
3468:             .FontSize  = 8
3469:             .BackStyle = 1
3470:             .BackColor = RGB(220,220,220)
3471:             .ForeColor = RGB(50,50,50)
3472:         ENDWITH
3473: 
3474:         *-- === SHAPES DIVISORES VISUAIS (top=497-498) ======================================
3475:         loc_oPg.AddObject("shp_4c_Shape6", "Shape")
3476:         WITH loc_oPg.shp_4c_Shape6
3477:             .Top         = 497
3478:             .Left        = 9
3479:             .Width       = 158
3480:             .Height      = 2
3481:             .BackColor   = RGB(180,180,180)
3482:             .BackStyle   = 1
3483:             .BorderColor = RGB(180,180,180)

*-- Linhas 3581 a 3651:
3581:             .ToolTipText     = "Calcular Peso"
3582:             .Visible         = .T.
3583:         ENDWITH
3584:         BINDEVENT(loc_oPg.cmd_4c_CmdPesoM, "Click", THIS, "CmdPesoMClick")
3585: 
3586:         *-- Say22 "MKP" (top=542, left=9) - label para Get_cmkpc
3587:         loc_oPg.AddObject("lbl_4c_Label22", "Label")
3588:         WITH loc_oPg.lbl_4c_Label22
3589:             .Caption   = "MKP"
3590:             .Top       = 542
3591:             .Left      = 9
3592:             .Width     = 22
3593:             .Height    = 15
3594:             .FontName  = "Tahoma"
3595:             .FontSize  = 8
3596:             .BackStyle = 0
3597:             .ForeColor = RGB(90,90,90)
3598:         ENDWITH
3599: 
3600:         *-- Get_cmkpc (top=557, left=9, w=24): markup de custo
3601:         loc_oPg.AddObject("txt_4c_Cmkpc", "TextBox")
3602:         WITH loc_oPg.txt_4c_Cmkpc
3603:             .Value    = ""
3604:             .Top      = 557
3605:             .Left     = 9
3606:             .Width    = 24
3607:             .Height   = 23
3608:             .FontName = "Tahoma"
3609:             .FontSize = 8
3610:         ENDWITH
3611:         BINDEVENT(loc_oPg.txt_4c_Cmkpc, "LostFocus", THIS, "TabCompo_CmkpcLostFocus")
3612: 
3613:         *-- lblValAdics (top=542, left=64): "Valor Adicional"
3614:         loc_oPg.AddObject("lbl_4c_LblValAdics", "Label")
3615:         WITH loc_oPg.lbl_4c_LblValAdics
3616:             .Caption   = "Valor Adicional"
3617:             .Top       = 542
3618:             .Left      = 64
3619:             .Width     = 71
3620:             .Height    = 15
3621:             .FontName  = "Tahoma"
3622:             .FontSize  = 8
3623:             .BackStyle = 0
3624:             .ForeColor = RGB(90,90,90)
3625:         ENDWITH
3626: 
3627:         *-- get_pftioc (top=557, left=64, w=94): valor adicional custo (read-only)
3628:         loc_oPg.AddObject("txt_4c__pftioc", "TextBox")
3629:         WITH loc_oPg.txt_4c__pftioc
3630:             .Value    = 0
3631:             .Top      = 557
3632:             .Left     = 64
3633:             .Width    = 94
3634:             .Height   = 23
3635:             .FontName = "Tahoma"
3636:             .FontSize = 8
3637:             .ReadOnly = .T.
3638:         ENDWITH
3639: 
3640:         *-- chkPlanCus (top=556, left=36): planejamento custo
3641:         loc_oPg.AddObject("chk_4c_ChkPlanCus", "CheckBox")
3642:         WITH loc_oPg.chk_4c_ChkPlanCus
3643:             .Caption   = ""
3644:             .Value     = .F.
3645:             .Top       = 556
3646:             .Left      = 36
3647:             .Width     = 25
3648:             .Height    = 25
3649:             .BackStyle = 0
3650:             .Themes    = .F.
3651:             .Visible   = .T.

*-- Linhas 3677 a 3760:
3677:             .FontName = "Tahoma"
3678:             .FontSize = 8
3679:         ENDWITH
3680:         BINDEVENT(loc_oPg.txt_4c_Margem, "LostFocus", THIS, "TabCompo_MargemLostFocus")
3681: 
3682:         *-- lblIdeal "Preco Ideal (Moeda 1)" (top=503, left=416)
3683:         loc_oPg.AddObject("lbl_4c_LblIdeal", "Label")
3684:         WITH loc_oPg.lbl_4c_LblIdeal
3685:             .Caption   = "Pre" + CHR(231) + "o Ideal  (Moeda 1)"
3686:             .Top       = 503
3687:             .Left      = 416
3688:             .Width     = 111
3689:             .Height    = 15
3690:             .FontName  = "Tahoma"
3691:             .FontSize  = 8
3692:             .BackStyle = 0
3693:             .ForeColor = RGB(90,90,90)
3694:         ENDWITH
3695: 
3696:         *-- getPvideal (top=517, left=416, w=110): preco ideal (read-only)
3697:         loc_oPg.AddObject("txt_4c_Pvideal", "TextBox")
3698:         WITH loc_oPg.txt_4c_Pvideal
3699:             .Value    = 0
3700:             .Top      = 517
3701:             .Left     = 416
3702:             .Width    = 110
3703:             .Height   = 23
3704:             .FontName = "Tahoma"
3705:             .FontSize = 8
3706:             .ReadOnly = .T.
3707:         ENDWITH
3708: 
3709:         *-- getMoeda (top=517, left=529, w=31): moeda de venda (editable+lookup)
3710:         loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
3711:         WITH loc_oPg.txt_4c_Moeda
3712:             .Value    = ""
3713:             .Top      = 517
3714:             .Left     = 529
3715:             .Width    = 31
3716:             .Height   = 23
3717:             .FontName = "Tahoma"
3718:             .FontSize = 8
3719:         ENDWITH
3720:         BINDEVENT(loc_oPg.txt_4c_Moeda, "LostFocus", THIS, "TabCompo_MoedaLostFocus")
3721: 
3722:         *-- lblFIdeals "Fator Ideal" (top=503, left=563)
3723:         loc_oPg.AddObject("lbl_4c_LblFIdeals", "Label")
3724:         WITH loc_oPg.lbl_4c_LblFIdeals
3725:             .Caption   = "Fator Ideal"
3726:             .Top       = 503
3727:             .Left      = 563
3728:             .Width     = 55
3729:             .Height    = 15
3730:             .FontName  = "Tahoma"
3731:             .FontSize  = 8
3732:             .BackStyle = 0
3733:             .ForeColor = RGB(90,90,90)
3734:         ENDWITH
3735: 
3736:         *-- getFIdeals (top=517, left=563, w=110): fator ideal (read-only)
3737:         loc_oPg.AddObject("txt_4c_FIdeals", "TextBox")
3738:         WITH loc_oPg.txt_4c_FIdeals
3739:             .Value    = 0
3740:             .Top      = 517
3741:             .Left     = 563
3742:             .Width    = 110
3743:             .Height   = 23
3744:             .FontName = "Tahoma"
3745:             .FontSize = 8
3746:             .ReadOnly = .T.
3747:         ENDWITH
3748: 
3749:         *-- Say14 "MKP" (top=542, left=360) - label para Getftio
3750:         loc_oPg.AddObject("lbl_4c_Label14", "Label")
3751:         WITH loc_oPg.lbl_4c_Label14
3752:             .Caption   = "MKP"
3753:             .Top       = 542
3754:             .Left      = 360
3755:             .Width     = 22
3756:             .Height    = 15
3757:             .FontName  = "Tahoma"
3758:             .FontSize  = 8
3759:             .BackStyle = 0
3760:             .ForeColor = RGB(90,90,90)

*-- Linhas 3771 a 3814:
3771:             .FontName = "Tahoma"
3772:             .FontSize = 8
3773:         ENDWITH
3774:         BINDEVENT(loc_oPg.txt_4c_Ftio, "LostFocus", THIS, "TabCompo_FtioLostFocus")
3775: 
3776:         *-- Say13 "Valor Adicional" (top=542, left=416)
3777:         loc_oPg.AddObject("lbl_4c_Label13", "Label")
3778:         WITH loc_oPg.lbl_4c_Label13
3779:             .Caption   = "Valor Adicional"
3780:             .Top       = 542
3781:             .Left      = 416
3782:             .Width     = 71
3783:             .Height    = 15
3784:             .FontName  = "Tahoma"
3785:             .FontSize  = 8
3786:             .BackStyle = 0
3787:             .ForeColor = RGB(90,90,90)
3788:         ENDWITH
3789: 
3790:         *-- Get_Pftio (top=557, left=416, w=110): valor adicional/preco com fiacao (read-only)
3791:         loc_oPg.AddObject("txt_4c_Pftio", "TextBox")
3792:         WITH loc_oPg.txt_4c_Pftio
3793:             .Value    = 0
3794:             .Top      = 557
3795:             .Left     = 416
3796:             .Width    = 110
3797:             .Height   = 23
3798:             .FontName = "Tahoma"
3799:             .FontSize = 8
3800:             .ReadOnly = .T.
3801:         ENDWITH
3802: 
3803:         *-- Say12 "Fator" (top=542, left=563)
3804:         loc_oPg.AddObject("lbl_4c_Label12", "Label")
3805:         WITH loc_oPg.lbl_4c_Label12
3806:             .Caption   = "Fator"
3807:             .Top       = 542
3808:             .Left      = 563
3809:             .Width     = 28
3810:             .Height    = 15
3811:             .FontName  = "Tahoma"
3812:             .FontSize  = 8
3813:             .BackStyle = 0
3814:             .ForeColor = RGB(90,90,90)

*-- Linhas 3825 a 3991:
3825:             .FontName = "Tahoma"
3826:             .FontSize = 8
3827:         ENDWITH
3828:         BINDEVENT(loc_oPg.txt_4c_Fvenda, "LostFocus", THIS, "TabCompo_FvendaLostFocus")
3829: 
3830:         *-- getMoepv (top=557, left=677, w=31): moeda preco venda (editable+lookup)
3831:         loc_oPg.AddObject("txt_4c_Moepv", "TextBox")
3832:         WITH loc_oPg.txt_4c_Moepv
3833:             .Value    = ""
3834:             .Top      = 557
3835:             .Left     = 677
3836:             .Width    = 31
3837:             .Height   = 23
3838:             .FontName = "Tahoma"
3839:             .FontSize = 8
3840:         ENDWITH
3841:         BINDEVENT(loc_oPg.txt_4c_Moepv, "LostFocus", THIS, "TabCompo_MoepvLostFocus")
3842: 
3843:         *-- Get_mftio (top=557, left=529, w=31): markup fiacao (read-only)
3844:         loc_oPg.AddObject("txt_4c_Mftio", "TextBox")
3845:         WITH loc_oPg.txt_4c_Mftio
3846:             .Value    = 0
3847:             .Top      = 557
3848:             .Left     = 529
3849:             .Width    = 31
3850:             .Height   = 23
3851:             .FontName = "Tahoma"
3852:             .FontSize = 8
3853:             .ReadOnly = .T.
3854:         ENDWITH
3855: 
3856:         *-- Say24 "Sts" (top=542, left=324) - label para getStatus
3857:         loc_oPg.AddObject("lbl_4c_Label24", "Label")
3858:         WITH loc_oPg.lbl_4c_Label24
3859:             .Caption   = "Sts"
3860:             .Top       = 542
3861:             .Left      = 324
3862:             .Width     = 17
3863:             .Height    = 15
3864:             .FontName  = "Tahoma"
3865:             .FontSize  = 8
3866:             .BackStyle = 0
3867:             .ForeColor = RGB(90,90,90)
3868:         ENDWITH
3869: 
3870:         *-- getStatus (top=557, left=324, w=31): status composicao (editable+lookup)
3871:         loc_oPg.AddObject("txt_4c_Status", "TextBox")
3872:         WITH loc_oPg.txt_4c_Status
3873:             .Value    = ""
3874:             .Top      = 557
3875:             .Left     = 324
3876:             .Width    = 31
3877:             .Height   = 23
3878:             .FontName = "Tahoma"
3879:             .FontSize = 8
3880:         ENDWITH
3881:         BINDEVENT(loc_oPg.txt_4c_Status, "LostFocus", THIS, "TabCompo_StatusLostFocus")
3882: 
3883:         *-- chkPlanVen (top=556, left=387): planejamento venda
3884:         loc_oPg.AddObject("chk_4c_ChkPlanVen", "CheckBox")
3885:         WITH loc_oPg.chk_4c_ChkPlanVen
3886:             .Caption   = ""
3887:             .Value     = .F.
3888:             .Top       = 556
3889:             .Left      = 387
3890:             .Width     = 25
3891:             .Height    = 25
3892:             .BackStyle = 0
3893:             .Themes    = .F.
3894:             .Visible   = .T.
3895:         ENDWITH
3896: 
3897:         *-- Chk_Pvenda (top=595, left=387, w=25, h=25): usar preco ideal
3898:         loc_oPg.AddObject("chk_4c_ChkPvenda", "CheckBox")
3899:         WITH loc_oPg.chk_4c_ChkPvenda
3900:             .Caption   = ""
3901:             .Value     = .F.
3902:             .Top       = 595
3903:             .Left      = 387
3904:             .Width     = 25
3905:             .Height    = 25
3906:             .BackStyle = 0
3907:             .Themes    = .F.
3908:             .ToolTipText = "Usar Pre" + CHR(231) + "o Ideal"
3909:             .Visible   = .T.
3910:         ENDWITH
3911:         BINDEVENT(loc_oPg.chk_4c_ChkPvenda, "Click", THIS, "ChkPvendaClick")
3912: 
3913:         *-- lblVenda "Preco Atual (Moeda 2)" (top=581, left=416)
3914:         loc_oPg.AddObject("lbl_4c_LblVenda", "Label")
3915:         WITH loc_oPg.lbl_4c_LblVenda
3916:             .Caption   = "Pre" + CHR(231) + "o  Atual  (Moeda 2)"
3917:             .Top       = 581
3918:             .Left      = 416
3919:             .Width     = 115
3920:             .Height    = 15
3921:             .FontName  = "Tahoma"
3922:             .FontSize  = 8
3923:             .BackStyle = 0
3924:             .ForeColor = RGB(90,90,90)
3925:         ENDWITH
3926: 
3927:         *-- getPven (top=596, left=416, w=110): preco de venda atual (read-only)
3928:         loc_oPg.AddObject("txt_4c_Pven", "TextBox")
3929:         WITH loc_oPg.txt_4c_Pven
3930:             .Value    = 0
3931:             .Top      = 596
3932:             .Left     = 416
3933:             .Width    = 110
3934:             .Height   = 23
3935:             .FontName = "Tahoma"
3936:             .FontSize = 8
3937:             .ReadOnly = .T.
3938:         ENDWITH
3939: 
3940:         *-- getMoev (top=596, left=529, w=31): moeda valor venda (editable+lookup)
3941:         loc_oPg.AddObject("txt_4c_Moev", "TextBox")
3942:         WITH loc_oPg.txt_4c_Moev
3943:             .Value    = ""
3944:             .Top      = 596
3945:             .Left     = 529
3946:             .Width    = 31
3947:             .Height   = 23
3948:             .FontName = "Tahoma"
3949:             .FontSize = 8
3950:         ENDWITH
3951:         BINDEVENT(loc_oPg.txt_4c_Moev, "LostFocus", THIS, "TabCompo_MoevLostFocus")
3952: 
3953:         *-- lblFAtuals "Fator Atual" (top=581, left=563)
3954:         loc_oPg.AddObject("lbl_4c_LblFAtuals", "Label")
3955:         WITH loc_oPg.lbl_4c_LblFAtuals
3956:             .Caption   = "Fator Atual"
3957:             .Top       = 581
3958:             .Left      = 563
3959:             .Width     = 56
3960:             .Height    = 15
3961:             .FontName  = "Tahoma"
3962:             .FontSize  = 8
3963:             .BackStyle = 0
3964:             .ForeColor = RGB(90,90,90)
3965:         ENDWITH
3966: 
3967:         *-- getFAtuals (top=596, left=563, w=110): fator atual (read-only)
3968:         loc_oPg.AddObject("txt_4c_FAtuals", "TextBox")
3969:         WITH loc_oPg.txt_4c_FAtuals
3970:             .Value    = 0
3971:             .Top      = 596
3972:             .Left     = 563
3973:             .Width    = 110
3974:             .Height   = 23
3975:             .FontName = "Tahoma"
3976:             .FontSize = 8
3977:             .ReadOnly = .T.
3978:         ENDWITH
3979: 
3980:         *-- Say25 "Financeiro" (top=581, left=678) - label para Get_Encarg
3981:         loc_oPg.AddObject("lbl_4c_Label25", "Label")
3982:         WITH loc_oPg.lbl_4c_Label25
3983:             .Caption   = "Financeiro"
3984:             .Top       = 581
3985:             .Left      = 678
3986:             .Width     = 51
3987:             .Height    = 15
3988:             .FontName  = "Tahoma"
3989:             .FontSize  = 8
3990:             .BackStyle = 0
3991:             .ForeColor = RGB(90,90,90)

*-- Linhas 4035 a 4086:
4035:             .ToolTipText     = "Calcular Valores"
4036:             .Visible         = .T.
4037:         ENDWITH
4038:         BINDEVENT(loc_oPg.cmd_4c_CmdCalcVals, "Click", THIS, "CmdCalcValsClick")
4039: 
4040:         *-- BINDEVENT para campos de moeda existentes (getMoec, getMoecusf)
4041:         BINDEVENT(loc_oPg.txt_4c_PcusMoe,  "LostFocus", THIS, "TabCompo_MoecLostFocus")
4042:         BINDEVENT(loc_oPg.txt_4c_MoecusFoe,"LostFocus", THIS, "TabCompo_MoecusfLostFocus")
4043: 
4044:         *-- BINDEVENT para AfterRowColChange dos grids
4045:         BINDEVENT(loc_oPg.grd_4c_Compo,    "AfterRowColChange", THIS, "CompoGrd_AfterRowColChange")
4046:         BINDEVENT(loc_oPg.grd_4c_SubCompo, "AfterRowColChange", THIS, "SubCompoGrd_AfterRowColChange")
4047: 
4048:         *-- Criar cursors placeholder para os grids (evitar erro de RecordSource vazio)
4049:         IF !USED("cursor_4c_Compo")
4050:             SET NULL ON
4051:             CREATE CURSOR cursor_4c_Compo (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3), ordems N(2,0), compos C(10))
4052:             SET NULL OFF
4053:         ENDIF
4054:         loc_oPg.grd_4c_Compo.RecordSource = "cursor_4c_Compo"
4055:         WITH loc_oPg.grd_4c_Compo
4056:             .Column1.ControlSource  = "cursor_4c_Compo.mats"
4057:             .Column2.ControlSource  = "cursor_4c_Compo.dcompos"
4058:             .Column3.ControlSource  = "cursor_4c_Compo.unicompos"
4059:             .Column4.ControlSource  = "cursor_4c_Compo.pcompos"
4060:             .Column5.ControlSource  = "cursor_4c_Compo.qtds"
4061:             .Column6.ControlSource  = "cursor_4c_Compo.totas"
4062:             .Column7.ControlSource  = "cursor_4c_Compo.moeds"
4063:             .Column8.ControlSource  = "cursor_4c_Compo.obscompos"
4064:             .Column9.ControlSource  = "cursor_4c_Compo.etiqs"
4065:             .Column10.ControlSource = "cursor_4c_Compo.qtscons"
4066:             .Column11.ControlSource = "cursor_4c_Compo.qtdcvs"
4067:             .Column12.ControlSource = "cursor_4c_Compo.cunips"
4068:             .Column13.ControlSource = "cursor_4c_Compo.ordems"
4069:             .Column14.ControlSource = "cursor_4c_Compo.compos"
4070:         ENDWITH
4071: 
4072:         IF !USED("cursor_4c_SubCompo")
4073:             SET NULL ON
4074:             CREATE CURSOR cursor_4c_SubCompo (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3), ordems N(2,0), matsubs C(14), codtams C(4))
4075:             SET NULL OFF
4076:         ENDIF
4077:         loc_oPg.grd_4c_SubCompo.RecordSource = "cursor_4c_SubCompo"
4078:         WITH loc_oPg.grd_4c_SubCompo
4079:             .Column1.ControlSource  = "cursor_4c_SubCompo.mats"
4080:             .Column2.ControlSource  = "cursor_4c_SubCompo.dcompos"
4081:             .Column3.ControlSource  = "cursor_4c_SubCompo.unicompos"
4082:             .Column4.ControlSource  = "cursor_4c_SubCompo.pcompos"
4083:             .Column5.ControlSource  = "cursor_4c_SubCompo.qtds"
4084:             .Column6.ControlSource  = "cursor_4c_SubCompo.totas"
4085:             .Column7.ControlSource  = "cursor_4c_SubCompo.moeds"
4086:             .Column8.ControlSource  = "cursor_4c_SubCompo.obscompos"

*-- Linhas 4109 a 4287:
4109:     *--------------------------------------------------------------------------
4110:     * ConfigurarTabCustos - Aba 3: Custo da composicao (pgCusto)
4111:     * Legado: pgframeDados.pgCusto (grdCompo 12-col, cmbTipos, cmdgCompo)
4112:     * FASE 9: implementacao completa com BINDEVENTs e botoes
4113:     *--------------------------------------------------------------------------
4114:     PROTECTED PROCEDURE ConfigurarTabCustos()
4115:         LOCAL loc_oPg
4116:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
4117: 
4118:         *-- Label "Tipo :" (top=159, left=112)
4119:         loc_oPg.AddObject("lbl_4c_TipoCusto", "Label")
4120:         WITH loc_oPg.lbl_4c_TipoCusto
4121:             .Caption   = "Tipo :"
4122:             .Top       = 159
4123:             .Left      = 112
4124:             .Width     = 29
4125:             .Height    = 15
4126:             .FontName  = "Tahoma"
4127:             .FontSize  = 8
4128:             .BackStyle = 0
4129:             .ForeColor = RGB(90, 90, 90)
4130:         ENDWITH
4131: 
4132:         *-- ComboBox cmbTipos (top=154, left=143, width=187)
4133:         *-- Filtra o grid de custos por tipo de calculo de custo
4134:         loc_oPg.AddObject("cmb_4c_TiposCusto", "ComboBox")
4135:         WITH loc_oPg.cmb_4c_TiposCusto
4136:             .Top       = 154
4137:             .Left      = 143
4138:             .Width     = 187
4139:             .Height    = 23
4140:             .Style     = 2
4141:             .FontName  = "Tahoma"
4142:             .FontSize  = 8
4143:         ENDWITH
4144:         WITH loc_oPg.cmb_4c_TiposCusto
4145:             .AddItem("Todos")
4146:             .AddItem("Custo Completo")
4147:             .AddItem("Custo Parcial")
4148:             .AddItem("Custo Calculado")
4149:             .ListIndex = 1
4150:         ENDWITH
4151:         BINDEVENT(loc_oPg.cmb_4c_TiposCusto, "LostFocus", THIS, "CmbTiposCustoValid")
4152: 
4153:         *-- grdCompo - Grid de composicao de custo (top=178, left=34, width=813, height=230, 12 cols)
4154:         *-- Dados: SIGPRCPO filtrado por Tipos (tipo de calculo)
4155:         loc_oPg.AddObject("grd_4c_CompoCusto", "Grid")
4156:         WITH loc_oPg.grd_4c_CompoCusto
4157:             .Top         = 178
4158:             .Left        = 34
4159:             .Width       = 813
4160:             .Height      = 230
4161:             .ReadOnly    = .F.
4162:             .DeleteMark  = .F.
4163:             .RecordMark  = .F.
4164:             .ScrollBars  = 3
4165:             .GridLines   = 3
4166:             .ColumnCount = 12
4167:             .FontName    = "Verdana"
4168:             .FontSize    = 8
4169:             .Visible     = .T.
4170:         ENDWITH
4171:         WITH loc_oPg.grd_4c_CompoCusto
4172:             .Column1.Header1.Caption  = "Item"
4173:             .Column1.Width  = 80
4174:             .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
4175:             .Column2.Width  = 180
4176:             .Column3.Header1.Caption  = "Un"
4177:             .Column3.Width  = 35
4178:             .Column4.Header1.Caption  = "Valor"
4179:             .Column4.Width  = 75
4180:             .Column5.Header1.Caption  = "Qtd"
4181:             .Column5.Width  = 60
4182:             .Column6.Header1.Caption  = "Total"
4183:             .Column6.Width  = 75
4184:             .Column7.Header1.Caption  = "Moe"
4185:             .Column7.Width  = 35
4186:             .Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
4187:             .Column8.Width  = 75
4188:             .Column9.Header1.Caption  = "Etiq"
4189:             .Column9.Width  = 35
4190:             .Column10.Header1.Caption = "Consumo"
4191:             .Column10.Width = 70
4192:             .Column11.Header1.Caption = "Qtd"
4193:             .Column11.Width = 55
4194:             .Column12.Header1.Caption = "Un"
4195:             .Column12.Width = 35
4196:         ENDWITH
4197:         BINDEVENT(loc_oPg.grd_4c_CompoCusto, "AfterRowColChange", THIS, "CustosGrd_AfterRowColChange")
4198: 
4199:         *-- Botoes Incluir/Excluir para grid de custo
4200:         *-- Legado: cmdgCompo (CommandGroup) top=240, left=851, buttonCount=2
4201:         loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
4202:         WITH loc_oPg.cnt_4c_BotoesCusto
4203:             .Top         = 178
4204:             .Left        = 851
4205:             .Width       = 50
4206:             .Height      = 90
4207:             .BackStyle = 1
4208:             .BackColor = RGB(53, 53, 53)
4209:             .BorderWidth = 0
4210:             .Visible     = .T.
4211:         ENDWITH
4212: 
4213:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_CustoIncluir", "CommandButton")
4214:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoIncluir
4215:             .Caption       = "+"
4216:             .Top           = 0
4217:             .Left          = 0
4218:             .Width         = 50
4219:             .Height        = 45
4220:             .FontName      = "Tahoma"
4221:             .FontSize      = 14
4222:             .FontBold      = .T.
4223:             .Themes        = .F.
4224:             .SpecialEffect = 0
4225:             .BackColor     = RGB(230, 255, 230)
4226:             .ForeColor     = RGB(0, 128, 0)
4227:             .Visible       = .T.
4228:         ENDWITH
4229:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoIncluir, "Click", THIS, "CmdCustoIncluirClick")
4230: 
4231:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_CustoExcluir", "CommandButton")
4232:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoExcluir
4233:             .Caption       = "-"
4234:             .Top           = 45
4235:             .Left          = 0
4236:             .Width         = 50
4237:             .Height        = 45
4238:             .FontName      = "Tahoma"
4239:             .FontSize      = 14
4240:             .FontBold      = .T.
4241:             .Themes        = .F.
4242:             .SpecialEffect = 0
4243:             .BackColor     = RGB(255, 230, 230)
4244:             .ForeColor     = RGB(192, 0, 0)
4245:             .Visible       = .T.
4246:         ENDWITH
4247:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoExcluir, "Click", THIS, "CmdCustoExcluirClick")
4248: 
4249:         *-- Shape separador horizontal (Shape2: top=460, left=35, width=158, height=2)
4250:         loc_oPg.AddObject("shp_4c_SepCusto", "Shape")
4251:         WITH loc_oPg.shp_4c_SepCusto
4252:             .Top         = 460
4253:             .Left        = 35
4254:             .Width       = 158
4255:             .Height      = 2
4256:             .FillColor   = RGB(180, 180, 180)
4257:             .BackColor   = RGB(180, 180, 180)
4258:             .BorderColor = RGB(180, 180, 180)
4259:         ENDWITH
4260: 
4261:         *-- Label "Descricao :" (Say16: top=415, left=52)
4262:         loc_oPg.AddObject("lbl_4c_DescCusto", "Label")
4263:         WITH loc_oPg.lbl_4c_DescCusto
4264:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
4265:             .Top       = 415
4266:             .Left      = 52
4267:             .Width     = 62
4268:             .Height    = 15
4269:             .FontName  = "Tahoma"
4270:             .FontSize  = 8
4271:             .BackStyle = 0
4272:             .ForeColor = RGB(90, 90, 90)
4273:         ENDWITH
4274: 
4275:         *-- TextBox Get_Desc - mostra descricao do item selecionado (top=412, left=116, width=304)
4276:         loc_oPg.AddObject("txt_4c_DescCusto", "TextBox")
4277:         WITH loc_oPg.txt_4c_DescCusto
4278:             .Value    = ""
4279:             .Top      = 412
4280:             .Left     = 116
4281:             .Width    = 304
4282:             .Height   = 21
4283:             .FontName = "Tahoma"
4284:             .FontSize = 8
4285:             .ReadOnly = .T.
4286:         ENDWITH
4287: 

*-- Linhas 4392 a 4464:
4392:     * ConfigurarTabDadosFiscais - Aba 4: Dados fiscais (pgDadosFiscais)
4393:     * IMPLEMENTADO NA FASE 6
4394:     *--------------------------------------------------------------------------
4395:     PROTECTED PROCEDURE ConfigurarTabDadosFiscais()
4396:         LOCAL loc_oPg
4397:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
4398: 
4399:         *-- Classificacao Fiscal (top=211, left=206, width=94)
4400:         loc_oPg.AddObject("lbl_4c_Clfiscal", "Label")
4401:         WITH loc_oPg.lbl_4c_Clfiscal
4402:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal :"
4403:             .Top       = 216
4404:             .Left      = 102
4405:             .Width     = 99
4406:             .Height    = 15
4407:             .FontName  = "Tahoma"
4408:             .FontSize  = 8
4409:             .BackStyle = 0
4410:             .ForeColor = RGB(90,90,90)
4411:         ENDWITH
4412: 
4413:         loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
4414:         WITH loc_oPg.txt_4c_Clfiscal
4415:             .Value    = ""
4416:             .Top      = 211
4417:             .Left     = 206
4418:             .Width    = 94
4419:             .Height   = 23
4420:             .FontName = "Tahoma"
4421:             .FontSize = 8
4422:             .MaxLength = 10
4423:         ENDWITH
4424:         BINDEVENT(loc_oPg.txt_4c_Clfiscal, "KeyPress", THIS, "TabFiscal_ClfiscalKeyPress")
4425: 
4426:         loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
4427:         WITH loc_oPg.txt_4c_Dclfiscal
4428:             .Value    = ""
4429:             .Top      = 211
4430:             .Left     = 303
4431:             .Width    = 303
4432:             .Height   = 23
4433:             .FontName = "Tahoma"
4434:             .FontSize = 8
4435:             .ReadOnly = .T.
4436:         ENDWITH
4437: 
4438:         *-- Origem Mercadoria (top=236, left=206, width=17)
4439:         loc_oPg.AddObject("lbl_4c_Origmerc", "Label")
4440:         WITH loc_oPg.lbl_4c_Origmerc
4441:             .Caption   = "Origem da Mercadoria :"
4442:             .Top       = 241
4443:             .Left      = 87
4444:             .Width     = 114
4445:             .Height    = 15
4446:             .FontName  = "Tahoma"
4447:             .FontSize  = 8
4448:             .BackStyle = 0
4449:             .ForeColor = RGB(90,90,90)
4450:         ENDWITH
4451: 
4452:         loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
4453:         WITH loc_oPg.txt_4c_Origmerc
4454:             .Value    = ""
4455:             .Top      = 236
4456:             .Left     = 206
4457:             .Width    = 17
4458:             .Height   = 23
4459:             .FontName = "Tahoma"
4460:             .FontSize = 8
4461:             .MaxLength = 1
4462:         ENDWITH
4463: 
4464:         loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")

*-- Linhas 4670 a 4752:
4670:             .FontSize = 8
4671:             .MaxLength = 2
4672:         ENDWITH
4673:         BINDEVENT(loc_oPg.txt_4c_Metal, "KeyPress", THIS, "TabFiscal_MetalKeyPress")
4674: 
4675:         loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
4676:         WITH loc_oPg.txt_4c_DesMetal
4677:             .Value    = ""
4678:             .Top      = 429
4679:             .Left     = 564
4680:             .Width    = 150
4681:             .Height   = 23
4682:             .FontName = "Tahoma"
4683:             .FontSize = 8
4684:             .ReadOnly = .T.
4685:         ENDWITH
4686: 
4687:         *-- Teor (top=454, left=537)
4688:         loc_oPg.AddObject("lbl_4c_Teor", "Label")
4689:         WITH loc_oPg.lbl_4c_Teor
4690:             .Caption   = "Teor :"
4691:             .Top       = 454
4692:             .Left      = 490
4693:             .Width     = 45
4694:             .Height    = 15
4695:             .FontName  = "Tahoma"
4696:             .FontSize  = 8
4697:             .BackStyle = 0
4698:             .ForeColor = RGB(90,90,90)
4699:         ENDWITH
4700: 
4701:         loc_oPg.AddObject("txt_4c_Teor", "TextBox")
4702:         WITH loc_oPg.txt_4c_Teor
4703:             .Value    = ""
4704:             .Top      = 454
4705:             .Left     = 537
4706:             .Width    = 24
4707:             .Height   = 23
4708:             .FontName = "Tahoma"
4709:             .FontSize = 8
4710:             .MaxLength = 2
4711:         ENDWITH
4712:         BINDEVENT(loc_oPg.txt_4c_Teor, "KeyPress", THIS, "TabFiscal_TeorKeyPress")
4713: 
4714:         loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
4715:         WITH loc_oPg.txt_4c_DesTeor
4716:             .Value    = ""
4717:             .Top      = 454
4718:             .Left     = 564
4719:             .Width    = 150
4720:             .Height   = 23
4721:             .FontName = "Tahoma"
4722:             .FontSize = 8
4723:             .ReadOnly = .T.
4724:         ENDWITH
4725: 
4726:         *-- Descricao ECF (top=429, left=206, width=213)
4727:         loc_oPg.AddObject("lbl_4c_DescEcf", "Label")
4728:         WITH loc_oPg.lbl_4c_DescEcf
4729:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o ECF :"
4730:             .Top       = 433
4731:             .Left      = 124
4732:             .Width     = 77
4733:             .Height    = 15
4734:             .FontName  = "Tahoma"
4735:             .FontSize  = 8
4736:             .BackStyle = 0
4737:             .ForeColor = RGB(90,90,90)
4738:         ENDWITH
4739: 
4740:         loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
4741:         WITH loc_oPg.txt_4c_DescEcfs
4742:             .Value    = ""
4743:             .Top      = 429
4744:             .Left     = 206
4745:             .Width    = 213
4746:             .Height   = 23
4747:             .FontName = "Tahoma"
4748:             .FontSize = 8
4749:             .MaxLength = 29
4750:         ENDWITH
4751: 
4752:         *-- Valor Estimado (top=454, left=206)

*-- Linhas 4789 a 5017:
4789: 
4790:     *--------------------------------------------------------------------------
4791:     * ConfigurarPgpgDadosFiscais - Completa Aba 4 Dados Fiscais
4792:     * Adiciona controles restantes + BINDEVENTs de todos os campos do tab fiscal
4793:     * Chamado de ConfigurarPaginaDados() APOS ConfigurarTabDadosFiscais()
4794:     *--------------------------------------------------------------------------
4795:     PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais()
4796:         LOCAL loc_oPg
4797:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
4798: 
4799:         *-- === GRUPO C.C. (get_gruccus: top=161, left=206, width=80) ============
4800: 
4801:         loc_oPg.AddObject("lbl_4c_Gruccus", "Label")
4802:         WITH loc_oPg.lbl_4c_Gruccus
4803:             .Caption   = "Grupo C.C. :"
4804:             .Top       = 165
4805:             .Left      = 138
4806:             .Width     = 63
4807:             .Height    = 15
4808:             .FontName  = "Tahoma"
4809:             .FontSize  = 8
4810:             .BackStyle = 0
4811:             .ForeColor = RGB(90, 90, 90)
4812:         ENDWITH
4813: 
4814:         loc_oPg.AddObject("txt_4c__gruccus", "TextBox")
4815:         WITH loc_oPg.txt_4c__gruccus
4816:             .Value         = ""
4817:             .Top           = 161
4818:             .Left          = 206
4819:             .Width         = 80
4820:             .Height        = 23
4821:             .FontName      = "Tahoma"
4822:             .FontSize      = 8
4823:             .MaxLength     = 10
4824:             .SpecialEffect = 1
4825:         ENDWITH
4826:         BINDEVENT(loc_oPg.txt_4c__gruccus, "LostFocus", THIS, "ValidarGruccus")
4827: 
4828:         loc_oPg.AddObject("txt_4c__dgruccus", "TextBox")
4829:         WITH loc_oPg.txt_4c__dgruccus
4830:             .Value    = ""
4831:             .Top      = 161
4832:             .Left     = 288
4833:             .Width    = 318
4834:             .Height   = 23
4835:             .FontName = "Tahoma"
4836:             .FontSize = 8
4837:             .ReadOnly = .T.
4838:         ENDWITH
4839:         BINDEVENT(loc_oPg.txt_4c__dgruccus, "LostFocus", THIS, "ValidarDgruccus")
4840: 
4841:         *-- === CONTA C.C. (get_contaccus: top=186, left=206, width=80) ==========
4842: 
4843:         loc_oPg.AddObject("lbl_4c_Contaccus", "Label")
4844:         WITH loc_oPg.lbl_4c_Contaccus
4845:             .Caption   = "Conta C.C. :"
4846:             .Top       = 189
4847:             .Left      = 138
4848:             .Width     = 63
4849:             .Height    = 15
4850:             .FontName  = "Tahoma"
4851:             .FontSize  = 8
4852:             .BackStyle = 0
4853:             .ForeColor = RGB(90, 90, 90)
4854:         ENDWITH
4855: 
4856:         loc_oPg.AddObject("txt_4c__contaccus", "TextBox")
4857:         WITH loc_oPg.txt_4c__contaccus
4858:             .Value         = ""
4859:             .Top           = 186
4860:             .Left          = 206
4861:             .Width         = 80
4862:             .Height        = 23
4863:             .FontName      = "Tahoma"
4864:             .FontSize      = 8
4865:             .MaxLength     = 10
4866:             .SpecialEffect = 1
4867:         ENDWITH
4868:         BINDEVENT(loc_oPg.txt_4c__contaccus, "LostFocus", THIS, "ValidarContaccus")
4869: 
4870:         loc_oPg.AddObject("txt_4c__dcontaccus", "TextBox")
4871:         WITH loc_oPg.txt_4c__dcontaccus
4872:             .Value    = ""
4873:             .Top      = 186
4874:             .Left     = 288
4875:             .Width    = 318
4876:             .Height   = 23
4877:             .FontName = "Tahoma"
4878:             .FontSize = 8
4879:             .ReadOnly = .T.
4880:         ENDWITH
4881:         BINDEVENT(loc_oPg.txt_4c__dcontaccus, "LostFocus", THIS, "ValidarDcontaccus")
4882: 
4883:         *-- === ALIQUOTA IPI (Get_AliqIPI: top=311, left=425, width=45) ==========
4884: 
4885:         loc_oPg.AddObject("lbl_4c_AliqIPI", "Label")
4886:         WITH loc_oPg.lbl_4c_AliqIPI
4887:             .Caption   = "Al" + CHR(237) + "quota de IPI :"
4888:             .Top       = 316
4889:             .Left      = 327
4890:             .Width     = 90
4891:             .Height    = 15
4892:             .FontName  = "Tahoma"
4893:             .FontSize  = 8
4894:             .BackStyle = 0
4895:             .ForeColor = RGB(90, 90, 90)
4896:         ENDWITH
4897: 
4898:         loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
4899:         WITH loc_oPg.txt_4c_AliqIPI
4900:             .Value    = 0
4901:             .Top      = 311
4902:             .Left     = 425
4903:             .Width    = 45
4904:             .Height   = 25
4905:             .FontName = "Tahoma"
4906:             .FontSize = 8
4907:         ENDWITH
4908:         BINDEVENT(loc_oPg.txt_4c_AliqIPI, "LostFocus", THIS, "ValidarAliqIPI")
4909: 
4910:         *-- === EXCECAO DA TIPI/IPI (getextipi: top=311, left=601, width=35) ======
4911: 
4912:         loc_oPg.AddObject("lbl_4c_Extipi", "Label")
4913:         WITH loc_oPg.lbl_4c_Extipi
4914:             .Caption   = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
4915:             .Top       = 316
4916:             .Left      = 495
4917:             .Width     = 98
4918:             .Height    = 15
4919:             .FontName  = "Tahoma"
4920:             .FontSize  = 8
4921:             .BackStyle = 0
4922:             .ForeColor = RGB(90, 90, 90)
4923:         ENDWITH
4924: 
4925:         loc_oPg.AddObject("txt_4c_Extipi", "TextBox")
4926:         WITH loc_oPg.txt_4c_Extipi
4927:             .Value     = ""
4928:             .Top       = 311
4929:             .Left      = 601
4930:             .Width     = 35
4931:             .Height    = 25
4932:             .FontName  = "Tahoma"
4933:             .FontSize  = 8
4934:             .MaxLength = 3
4935:         ENDWITH
4936:         BINDEVENT(loc_oPg.txt_4c_Extipi, "GotFocus", THIS, "TabFiscal_ExtIpiGotFocus")
4937: 
4938:         *-- === IAT (getiat: top=286, left=589, width=17) ========================
4939: 
4940:         loc_oPg.AddObject("lbl_4c_Iat", "Label")
4941:         WITH loc_oPg.lbl_4c_Iat
4942:             .Caption   = "IAT :"
4943:             .Top       = 290
4944:             .Left      = 558
4945:             .Width     = 26
4946:             .Height    = 15
4947:             .FontName  = "Tahoma"
4948:             .FontSize  = 8
4949:             .BackStyle = 0
4950:             .ForeColor = RGB(90, 90, 90)
4951:         ENDWITH
4952: 
4953:         loc_oPg.AddObject("lbl_4c_IatDesc", "Label")
4954:         WITH loc_oPg.lbl_4c_IatDesc
4955:             .Caption   = "[A]rredondamento [T]runcamento"
4956:             .Top       = 290
4957:             .Left      = 609
4958:             .Width     = 165
4959:             .Height    = 15
4960:             .FontName  = "Tahoma"
4961:             .FontSize  = 8
4962:             .BackStyle = 0
4963:             .ForeColor = RGB(120, 120, 120)
4964:         ENDWITH
4965: 
4966:         loc_oPg.AddObject("txt_4c_Iat", "TextBox")
4967:         WITH loc_oPg.txt_4c_Iat
4968:             .Value     = ""
4969:             .Top       = 286
4970:             .Left      = 589
4971:             .Width     = 17
4972:             .Height    = 23
4973:             .FontName  = "Tahoma"
4974:             .FontSize  = 8
4975:             .MaxLength = 1
4976:         ENDWITH
4977:         BINDEVENT(loc_oPg.txt_4c_Iat, "LostFocus", THIS, "ValidarIat")
4978: 
4979:         *-- === IPPT/CST (getIPPTCST: top=479, left=206, width=108) =============
4980:         *-- Campo de exibicao calculado: nao armazenado, somente leitura
4981: 
4982:         loc_oPg.AddObject("lbl_4c_IPPTCST", "Label")
4983:         WITH loc_oPg.lbl_4c_IPPTCST
4984:             .Caption   = "IPPT/CST :"
4985:             .Top       = 483
4986:             .Left      = 147
4987:             .Width     = 54
4988:             .Height    = 15
4989:             .FontName  = "Tahoma"
4990:             .FontSize  = 8
4991:             .BackStyle = 0
4992:             .ForeColor = RGB(90, 90, 90)
4993:         ENDWITH
4994: 
4995:         loc_oPg.AddObject("txt_4c_IPPTCST", "TextBox")
4996:         WITH loc_oPg.txt_4c_IPPTCST
4997:             .Value    = ""
4998:             .Top      = 479
4999:             .Left     = 206
5000:             .Width    = 108
5001:             .Height   = 23
5002:             .FontName = "Tahoma"
5003:             .FontSize = 8
5004:             .ReadOnly = .T.
5005:         ENDWITH
5006: 
5007:         *-- === GRID CMV - Custo GR (grdCmv: top=338, left=754, width=223, h=141)
5008:         *-- 3 colunas: Periodo, Valor Custo GR, Moe
5009: 
5010:         loc_oPg.AddObject("lbl_4c_CmvTitulo", "Label")
5011:         WITH loc_oPg.lbl_4c_CmvTitulo
5012:             .Caption   = "Valor do Grama Produzido"
5013:             .Top       = 320
5014:             .Left      = 756
5015:             .Width     = 125
5016:             .Height    = 15
5017:             .FontName  = "Tahoma"

*-- Linhas 5074 a 5139:
5074:             .SpecialEffect   = 0
5075:             .ToolTipText     = "Gerar Descri" + CHR(231) + CHR(227) + "o Fiscal"
5076:         ENDWITH
5077:         BINDEVENT(loc_oPg.cmd_4c_BtnDescFis, "Click", THIS, "BtnDescFisClick")
5078: 
5079:         *-- === BINDEVENTS para controles JA CRIADOS em ConfigurarTabDadosFiscais ==
5080:         *-- Adicionar LostFocus nos campos lookup existentes
5081: 
5082:         BINDEVENT(loc_oPg.txt_4c_Clfiscal,  "LostFocus", THIS, "ValidarClfiscal")
5083:         BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "LostFocus", THIS, "ValidarDclfiscal")
5084:         BINDEVENT(loc_oPg.txt_4c_Origmerc,  "LostFocus", THIS, "ValidarOrigmerc")
5085:         BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "LostFocus", THIS, "ValidarDorigmerc")
5086:         BINDEVENT(loc_oPg.txt_4c_Sittricms, "LostFocus", THIS, "ValidarSittricms")
5087:         BINDEVENT(loc_oPg.txt_4c_Dsittricms,"LostFocus", THIS, "ValidarDsittricms")
5088:         BINDEVENT(loc_oPg.txt_4c_CodServs,  "LostFocus", THIS, "ValidarCodServs")
5089:         BINDEVENT(loc_oPg.txt_4c_Tptribs,   "LostFocus", THIS, "ValidarTptribs")
5090:         BINDEVENT(loc_oPg.txt_4c_Metal,     "LostFocus", THIS, "ValidarMetal")
5091:         BINDEVENT(loc_oPg.txt_4c_Teor,      "LostFocus", THIS, "ValidarTeor")
5092:         BINDEVENT(loc_oPg.txt_4c_Moedas,    "LostFocus", THIS, "ValidarMoedaEstimada")
5093:     ENDPROC
5094: 
5095:     *--------------------------------------------------------------------------
5096:     * ConfigurarTabDesigner - Aba 5: Designer/arquivos (pgDesigner)
5097:     * IMPLEMENTADO NA FASE 7
5098:     *--------------------------------------------------------------------------
5099:     PROTECTED PROCEDURE ConfigurarTabDesigner()
5100:         LOCAL loc_oPg
5101:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
5102: 
5103:         *-- grdDesigner (top=160, left=10, width=495, height=238, 4 cols)
5104:         *-- Dados: sigprtar - Data Inicio, Data Conclusao, Usuario, Tarefa
5105:         loc_oPg.AddObject("grd_4c_Designer", "Grid")
5106:         WITH loc_oPg.grd_4c_Designer
5107:             .Top         = 160
5108:             .Left        = 10
5109:             .Width       = 495
5110:             .Height      = 238
5111:             .ReadOnly    = .T.
5112:             .DeleteMark  = .F.
5113:             .RecordMark  = .F.
5114:             .ScrollBars  = 3
5115:             .GridLines   = 3
5116:             .ColumnCount = 4
5117:             .FontName    = "Verdana"
5118:             .FontSize    = 8
5119:             .Visible     = .T.
5120:         ENDWITH
5121:         WITH loc_oPg.grd_4c_Designer
5122:             .Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
5123:             .Column1.Width = 110
5124:             .Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"
5125:             .Column2.Width = 120
5126:             .Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
5127:             .Column3.Width = 100
5128:             .Column4.Header1.Caption = "Tarefa"
5129:             .Column4.Width = 160
5130:         ENDWITH
5131: 
5132:         *-- Observacao da Tarefa - EditBox (top=160, left=584, width=407, height=238)
5133:         loc_oPg.AddObject("lbl_4c_ObsTarefa", "Label")
5134:         WITH loc_oPg.lbl_4c_ObsTarefa
5135:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
5136:             .Top       = 144
5137:             .Left      = 583
5138:             .Width     = 130
5139:             .Height    = 15

*-- Linhas 5168 a 5384:
5168:             .Themes  = .F.
5169:             .Visible = .T.
5170:         ENDWITH
5171:         BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "Click", THIS, "BtnIniTarefaClick")
5172: 
5173:         loc_oPg.AddObject("cmd_4c_FimTarefa", "CommandButton")
5174:         WITH loc_oPg.cmd_4c_FimTarefa
5175:             .Caption = "Fim"
5176:             .Top     = 203
5177:             .Left    = 509
5178:             .Width   = 42
5179:             .Height  = 42
5180:             .FontName = "Tahoma"
5181:             .FontSize = 7
5182:             .Themes  = .F.
5183:             .Visible = .T.
5184:         ENDWITH
5185:         BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "Click", THIS, "BtnFimTarefaClick")
5186: 
5187:         *-- grdArquivos (top=415, left=10, width=495, height=202, 1 col)
5188:         *-- Dados: sigprarq - Arquivos do designer
5189:         loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
5190:         WITH loc_oPg.grd_4c_Arquivos
5191:             .Top         = 415
5192:             .Left        = 10
5193:             .Width       = 495
5194:             .Height      = 202
5195:             .ReadOnly    = .T.
5196:             .DeleteMark  = .F.
5197:             .RecordMark  = .F.
5198:             .ScrollBars  = 3
5199:             .GridLines   = 3
5200:             .ColumnCount = 1
5201:             .FontName    = "Verdana"
5202:             .FontSize    = 8
5203:             .Visible     = .T.
5204:         ENDWITH
5205:         WITH loc_oPg.grd_4c_Arquivos
5206:             .Column1.Header1.Caption = "Arquivos Para Designer"
5207:             .Column1.Width = 492
5208:         ENDWITH
5209: 
5210:         *-- Botoes de arquivo (top=416, 458, 500, left=509)
5211:         loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")
5212:         WITH loc_oPg.cmd_4c_InsArqs
5213:             .Caption = "Inserir"
5214:             .Top     = 416
5215:             .Left    = 509
5216:             .Width   = 42
5217:             .Height  = 42
5218:             .FontName = "Tahoma"
5219:             .FontSize = 7
5220:             .Themes  = .F.
5221:             .Visible = .T.
5222:         ENDWITH
5223:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "Click", THIS, "BtnInsArqsClick")
5224: 
5225:         loc_oPg.AddObject("cmd_4c_ExcArqs", "CommandButton")
5226:         WITH loc_oPg.cmd_4c_ExcArqs
5227:             .Caption = "Excluir"
5228:             .Top     = 458
5229:             .Left    = 509
5230:             .Width   = 42
5231:             .Height  = 42
5232:             .FontName = "Tahoma"
5233:             .FontSize = 7
5234:             .Themes  = .F.
5235:             .Visible = .T.
5236:         ENDWITH
5237:         BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "Click", THIS, "BtnExcArqsClick")
5238: 
5239:         loc_oPg.AddObject("cmd_4c_OpnArqs", "CommandButton")
5240:         WITH loc_oPg.cmd_4c_OpnArqs
5241:             .Caption = "Abrir"
5242:             .Top     = 500
5243:             .Left    = 509
5244:             .Width   = 42
5245:             .Height  = 42
5246:             .FontName = "Tahoma"
5247:             .FontSize = 7
5248:             .Themes  = .F.
5249:             .Visible = .T.
5250:         ENDWITH
5251:         BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "Click", THIS, "BtnOpnArqsClick")
5252: 
5253:         *-- Criar cursors placeholder
5254:         IF !USED("cursor_4c_Designer")
5255:             SET NULL ON
5256:             CREATE CURSOR cursor_4c_Designer (dtinis D, dtfims D, usuars C(10), tarefas C(20))
5257:             SET NULL OFF
5258:         ENDIF
5259:         loc_oPg.grd_4c_Designer.RecordSource = "cursor_4c_Designer"
5260:         WITH loc_oPg.grd_4c_Designer
5261:             .Column1.ControlSource = "cursor_4c_Designer.dtinis"
5262:             .Column2.ControlSource = "cursor_4c_Designer.dtfims"
5263:             .Column3.ControlSource = "cursor_4c_Designer.usuars"
5264:             .Column4.ControlSource = "cursor_4c_Designer.tarefas"
5265:         ENDWITH
5266: 
5267:         IF !USED("cursor_4c_Arquivos")
5268:             SET NULL ON
5269:             CREATE CURSOR cursor_4c_Arquivos (arquivos C(250))
5270:             SET NULL OFF
5271:         ENDIF
5272:         loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_Arquivos"
5273:         WITH loc_oPg.grd_4c_Arquivos
5274:             .Column1.ControlSource = "cursor_4c_Arquivos.arquivos"
5275:         ENDWITH
5276:     ENDPROC
5277: 
5278:     *--------------------------------------------------------------------------
5279:     * ConfigurarPgpgDesigner - Completa Aba 5 Designer
5280:     * Adiciona img_4c_ImgArqJpg, shp_4c_Shape1 e todos os BINDEVENTs
5281:     * Chamado de ConfigurarPaginaDados() APOS ConfigurarTabDesigner()
5282:     *--------------------------------------------------------------------------
5283:     PROTECTED PROCEDURE ConfigurarPgpgDesigner()
5284:         LOCAL loc_oPg
5285:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
5286: 
5287:         *-- Corrigir ReadOnly do grd_4c_Designer: .F. para Column4 ser editavel
5288:         *-- Colunas 1-3 usam When=.F. via BINDEVENT para somente leitura
5289:         loc_oPg.grd_4c_Designer.ReadOnly = .F.
5290: 
5291:         *-- Shape decorativo em volta da area de imagem (top=415, left=584, width=407, height=202)
5292:         loc_oPg.AddObject("shp_4c_Shape1", "Shape")
5293:         WITH loc_oPg.shp_4c_Shape1
5294:             .Top         = 415
5295:             .Left        = 584
5296:             .Width       = 407
5297:             .Height      = 202
5298:             .BorderColor = RGB(128, 128, 128)
5299:             .BorderWidth = 1
5300:             .BackStyle   = 0
5301:             .Visible     = .T.
5302:         ENDWITH
5303: 
5304:         *-- Imagem preview do arquivo selecionado (top=417, left=586, width=403, height=198)
5305:         loc_oPg.AddObject("img_4c_ImgArqJpg", "Image")
5306:         WITH loc_oPg.img_4c_ImgArqJpg
5307:             .Top     = 417
5308:             .Left    = 586
5309:             .Width   = 403
5310:             .Height  = 198
5311:             .Stretch = 2
5312:             .Visible = .F.
5313:         ENDWITH
5314:         BINDEVENT(loc_oPg.img_4c_ImgArqJpg, "Click", THIS, "ImgArqJpgClick")
5315: 
5316:         *-- BINDEVENTs para AfterRowColChange dos grids
5317:         BINDEVENT(loc_oPg.grd_4c_Designer, "AfterRowColChange", THIS, "DesignerGrd_AfterRowColChange")
5318:         BINDEVENT(loc_oPg.grd_4c_Arquivos, "AfterRowColChange", THIS, "ArquivosGrd_AfterRowColChange")
5319: 
5320:         *-- BINDEVENTs Colunas 1/2/3 do grd_4c_Designer (somente leitura sempre)
5321:         BINDEVENT(loc_oPg.grd_4c_Designer.Column1.Text1, "When", THIS, "GrdDesignerColReadOnlyWhen")
5322:         BINDEVENT(loc_oPg.grd_4c_Designer.Column2.Text1, "When", THIS, "GrdDesignerColReadOnlyWhen")
5323:         BINDEVENT(loc_oPg.grd_4c_Designer.Column3.Text1, "When", THIS, "GrdDesignerColReadOnlyWhen")
5324: 
5325:         *-- BINDEVENTs Coluna 4 do grd_4c_Designer (Tarefa: editavel condicionalmente)
5326:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "When",      THIS, "GrdDesignerCol4When")
5327:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "Valid",     THIS, "GrdDesignerCol4Valid")
5328:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "LostFocus", THIS, "GrdDesignerCol4LostFocus")
5329: 
5330:         *-- BINDEVENT Column1 do grd_4c_Arquivos (editavel em INCLUIR/ALTERAR)
5331:         BINDEVENT(loc_oPg.grd_4c_Arquivos.Column1.Text1, "When", THIS, "GrdArquivosCol1When")
5332: 
5333:         *-- Cursor de tarefas para lookup do Column4 (codigo + descricao)
5334:         IF !USED("cursor_4c_Tarefas")
5335:             CREATE CURSOR cursor_4c_Tarefas (CodCads C(20), DesCads C(50))
5336:         ENDIF
5337:     ENDPROC
5338: 
5339:     *--------------------------------------------------------------------------
5340:     * ConfigurarTabConsulta - Aba 6: Consulta de componentes por fase (PgDadosConsP)
5341:     * Legado: PgDadosConsP com GrdCons (9 cols editaveis) e grDTEMP (2 cols)
5342:     * IMPLEMENTADO NA FASE 9
5343:     *--------------------------------------------------------------------------
5344:     PROTECTED PROCEDURE ConfigurarTabConsulta()
5345:         LOCAL loc_oPg
5346:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
5347: 
5348:         *-- Criar cursors placeholder ANTES dos grids (evitar erro de RecordSource vazio)
5349:         *-- cursor_4c_Consulta: SIGPRCPO - componentes com fase (SigCdPrf) e categoria (SigCdCat)
5350:         IF !USED("cursor_4c_Consulta")
5351:             SET NULL ON
5352:             CREATE CURSOR cursor_4c_Consulta (mats C(14) NULL, qtds N(8,3) NULL, unicompos C(3) NULL, grupos C(10) NULL, dcompos C(40) NULL, ordems N(2,0) NULL, qtscons N(8,3) NULL, cats C(6) NULL, dscgrp C(20) NULL)
5353:             SET NULL OFF
5354:         ENDIF
5355: 
5356:         *-- cursor_4c_Temp: agrupamento x tempo (grDTEMP)
5357:         IF !USED("cursor_4c_Temp")
5358:             SET NULL ON
5359:             CREATE CURSOR cursor_4c_Temp (grupos C(10) NULL, totas N(11,3) NULL)
5360:             SET NULL OFF
5361:         ENDIF
5362: 
5363:         *-- GrdCons - Grid de componentes consulta (top=155, left=6, width=987, height=362, 9 cols)
5364:         *-- Colunas editaveis (INSERIR/ALTERAR): 4-Fase, 5-Descricao, 7-Consumo, 8-Cat
5365:         *-- Colunas somente leitura: 1-Componente, 2-Qtde, 3-Uni, 6-Ord, 9-DescCat
5366:         loc_oPg.AddObject("grd_4c_Consulta", "Grid")
5367:         WITH loc_oPg.grd_4c_Consulta
5368:             .Top         = 155
5369:             .Left        = 6
5370:             .Width       = 987
5371:             .Height      = 362
5372:             .ReadOnly    = .F.
5373:             .DeleteMark  = .F.
5374:             .RecordMark  = .F.
5375:             .ScrollBars  = 3
5376:             .GridLines   = 3
5377:             .ColumnCount = 9
5378:             .FontName    = "Verdana"
5379:             .FontSize    = 8
5380:             .Visible     = .T.
5381:         ENDWITH
5382:         *-- RecordSource ANTES dos headers/ControlSources (evita reset de colunas)
5383:         loc_oPg.grd_4c_Consulta.RecordSource = "cursor_4c_Consulta"
5384:         WITH loc_oPg.grd_4c_Consulta

*-- Linhas 5415 a 5458:
5415:             .Column9.ControlSource   = "cursor_4c_Consulta.dscgrp"
5416:             .Column9.ReadOnly        = .T.
5417:         ENDWITH
5418:         BINDEVENT(loc_oPg.grd_4c_Consulta, "AfterRowColChange", THIS, "ConsultaGrd_AfterRowColChange")
5419: 
5420:         *-- Say7/lbl_4c_QtdCpnt: "Qtde Componentes :" (top=523, left=25)
5421:         loc_oPg.AddObject("lbl_4c_QtdCpnt", "Label")
5422:         WITH loc_oPg.lbl_4c_QtdCpnt
5423:             .Caption   = "Qtde Componentes : "
5424:             .Top       = 523
5425:             .Left      = 25
5426:             .Width     = 115
5427:             .Height    = 15
5428:             .FontName  = "Tahoma"
5429:             .FontSize  = 8
5430:             .BackStyle = 0
5431:             .ForeColor = RGB(90, 90, 90)
5432:         ENDWITH
5433: 
5434:         *-- Getqtcpnt/txt_4c_QtdCpnt: quantidade de componentes (top=519, left=131, width=31)
5435:         loc_oPg.AddObject("txt_4c_QtdCpnt", "TextBox")
5436:         WITH loc_oPg.txt_4c_QtdCpnt
5437:             .Top           = 519
5438:             .Left          = 131
5439:             .Width         = 31
5440:             .Height        = 23
5441:             .Value         = 0
5442:             .ReadOnly      = .T.
5443:             .SpecialEffect = 1
5444:             .FontName      = "Tahoma"
5445:             .FontSize      = 8
5446:         ENDWITH
5447: 
5448:         *-- chkFund/chk_4c_ChkFund: "Nao Checar Cadastro de Fundicao" (top=544, left=10)
5449:         loc_oPg.AddObject("chk_4c_ChkFund", "CheckBox")
5450:         WITH loc_oPg.chk_4c_ChkFund
5451:             .Caption  = "N" + CHR(227) + "o Checar Cadastro de Fundi" + CHR(231) + CHR(227) + "o"
5452:             .Top      = 544
5453:             .Left     = 10
5454:             .Width    = 200
5455:             .Height   = 15
5456:             .FontName = "Tahoma"
5457:             .FontSize = 8
5458:             .Value    = 0

*-- Linhas 5507 a 5550:
5507:     * ConfigurarTabFases - Aba 7: Fases de producao (PgDadosFaseP)
5508:     * IMPLEMENTADO NA FASE 7
5509:     *--------------------------------------------------------------------------
5510:     PROTECTED PROCEDURE ConfigurarTabFases()
5511:         LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oCtrl, loc_oLbl, loc_oChk
5512:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
5513: 
5514:         *-- Cursor placeholder para GradFase (SigCdPrf)
5515:         *-- ordems N(2,0), grupos C(10), minutos N(9,1), uniprdts C(10), matprdts C(15)
5516:         IF !USED("cursor_4c_Fases")
5517:             SET NULL ON
5518:             CREATE CURSOR cursor_4c_Fases (ordems N(2,0) NULL, grupos C(10) NULL, minutos N(9,1) NULL, uniprdts C(10) NULL, matprdts C(15) NULL)
5519:             SET NULL OFF
5520:         ENDIF
5521: 
5522:         *-- Cursor placeholder para grdMatrizes (SigPrMtz + Locals de SigCdPro)
5523:         IF !USED("cursor_4c_Matrizes")
5524:             SET NULL ON
5525:             CREATE CURSOR cursor_4c_Matrizes (cidchaves C(20) NULL, cmats C(14) NULL, cpros C(14) NULL, qtds N(3,0) NULL, locals C(10) NULL)
5526:             SET NULL OFF
5527:         ENDIF
5528: 
5529:         *======================================================
5530:         *-- LABEL: Say13 - "Qtd. Min. Producao :"
5531:         *======================================================
5532:         loc_oPg.AddObject("lbl_4c_Qmin", "Label")
5533:         WITH loc_oPg.lbl_4c_Qmin
5534:             .Top      = 156
5535:             .Left     = 33
5536:             .Width    = 102
5537:             .Height   = 15
5538:             .Caption  = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
5539:             .AutoSize = .F.
5540:             .FontName = "Tahoma"
5541:             .FontSize = 8
5542:             .Visible  = .T.
5543:         ENDWITH
5544: 
5545:         *======================================================
5546:         *-- TEXTBOX: getQmin - Qtde minima fabricacao
5547:         *======================================================
5548:         loc_oPg.AddObject("txt_4c_Qminfab", "TextBox")
5549:         WITH loc_oPg.txt_4c_Qminfab
5550:             .Top           = 152

*-- Linhas 5983 a 6296:
5983:             .Stretch = 2
5984:             .Visible = .F.
5985:         ENDWITH
5986:         BINDEVENT(loc_oPg.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")
5987: 
5988:         *======================================================
5989:         *-- BUTTON: cmd_4c_CmdFicha - Imprimir ficha da fase
5990:         *-- top=152, left=482
5991:         *======================================================
5992:         loc_oPg.AddObject("cmd_4c_CmdFicha", "CommandButton")
5993:         WITH loc_oPg.cmd_4c_CmdFicha
5994:             .Caption       = "Ficha"
5995:             .Top           = 152
5996:             .Left          = 482
5997:             .Width         = 38
5998:             .Height        = 23
5999:             .FontName      = "Tahoma"
6000:             .FontSize      = 8
6001:             .Themes        = .F.
6002:             .SpecialEffect = 0
6003:             .BackColor     = RGB(255, 255, 255)
6004:             .ForeColor     = RGB(90, 90, 90)
6005:             .Visible       = .T.
6006:         ENDWITH
6007:         BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaClick")
6008: 
6009:         *======================================================
6010:         *-- BUTTON: cmd_4c_CmdgFigura - Carregar imagem da fase (cmdgFigura)
6011:         *-- top=192, left=482
6012:         *======================================================
6013:         loc_oPg.AddObject("cmd_4c_CmdgFigura", "CommandButton")
6014:         WITH loc_oPg.cmd_4c_CmdgFigura
6015:             .Caption       = "..."
6016:             .Top           = 192
6017:             .Left          = 482
6018:             .Width         = 38
6019:             .Height        = 23
6020:             .FontName      = "Tahoma"
6021:             .FontSize      = 8
6022:             .Themes        = .F.
6023:             .SpecialEffect = 0
6024:             .BackColor     = RGB(255, 255, 255)
6025:             .ForeColor     = RGB(90, 90, 90)
6026:             .Visible       = .T.
6027:         ENDWITH
6028:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")
6029: 
6030:         *======================================================
6031:         *-- BUTTON: cmd_4c_CmdgFigCam - Camera para imagem de borracha (cmdgFigCam)
6032:         *-- top=232, left=482
6033:         *======================================================
6034:         loc_oPg.AddObject("cmd_4c_CmdgFigCam", "CommandButton")
6035:         WITH loc_oPg.cmd_4c_CmdgFigCam
6036:             .Caption       = "..."
6037:             .Top           = 232
6038:             .Left          = 482
6039:             .Width         = 38
6040:             .Height        = 23
6041:             .FontName      = "Tahoma"
6042:             .FontSize      = 8
6043:             .Themes        = .F.
6044:             .SpecialEffect = 0
6045:             .BackColor     = RGB(255, 255, 255)
6046:             .ForeColor     = RGB(90, 90, 90)
6047:             .Visible       = .T.
6048:         ENDWITH
6049:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigCam, "Click", THIS, "CmdgFigCamClick")
6050: 
6051:         *======================================================
6052:         *-- BUTTON: cmd_4c_InserirFase - Inserir nova fase (inserir)
6053:         *-- top=152, left=950
6054:         *======================================================
6055:         loc_oPg.AddObject("cmd_4c_InserirFase", "CommandButton")
6056:         WITH loc_oPg.cmd_4c_InserirFase
6057:             .Caption       = "Inserir"
6058:             .Top           = 152
6059:             .Left          = 950
6060:             .Width         = 45
6061:             .Height        = 23
6062:             .FontName      = "Tahoma"
6063:             .FontSize      = 8
6064:             .Themes        = .F.
6065:             .SpecialEffect = 0
6066:             .BackColor     = RGB(255, 255, 255)
6067:             .ForeColor     = RGB(90, 90, 90)
6068:             .Visible       = .T.
6069:         ENDWITH
6070:         BINDEVENT(loc_oPg.cmd_4c_InserirFase, "Click", THIS, "BtnInserirFaseClick")
6071: 
6072:         *======================================================
6073:         *-- BUTTON: cmd_4c_ExcluirFase - Excluir fase (excluir)
6074:         *-- top=192, left=950
6075:         *======================================================
6076:         loc_oPg.AddObject("cmd_4c_ExcluirFase", "CommandButton")
6077:         WITH loc_oPg.cmd_4c_ExcluirFase
6078:             .Caption       = "Excluir"
6079:             .Top           = 192
6080:             .Left          = 950
6081:             .Width         = 45
6082:             .Height        = 23
6083:             .FontName      = "Tahoma"
6084:             .FontSize      = 8
6085:             .Themes        = .F.
6086:             .SpecialEffect = 0
6087:             .BackColor     = RGB(255, 255, 255)
6088:             .ForeColor     = RGB(90, 90, 90)
6089:             .Visible       = .T.
6090:         ENDWITH
6091:         BINDEVENT(loc_oPg.cmd_4c_ExcluirFase, "Click", THIS, "BtnExcluirFaseClick")
6092: 
6093:         *======================================================
6094:         *-- BUTTON: cmd_4c_Alternativa - Alternativa de fase
6095:         *-- top=232, left=950
6096:         *======================================================
6097:         loc_oPg.AddObject("cmd_4c_Alternativa", "CommandButton")
6098:         WITH loc_oPg.cmd_4c_Alternativa
6099:             .Caption       = "Altern."
6100:             .Top           = 232
6101:             .Left          = 950
6102:             .Width         = 45
6103:             .Height        = 23
6104:             .FontName      = "Tahoma"
6105:             .FontSize      = 8
6106:             .Themes        = .F.
6107:             .SpecialEffect = 0
6108:             .BackColor     = RGB(255, 255, 255)
6109:             .ForeColor     = RGB(90, 90, 90)
6110:             .Visible       = .T.
6111:         ENDWITH
6112:         BINDEVENT(loc_oPg.cmd_4c_Alternativa, "Click", THIS, "BtnAlternativaFaseClick")
6113: 
6114:         *======================================================
6115:         *-- BUTTON: cmd_4c_BtnInsereMtx - Inserir linha na grade de matrizes
6116:         *-- top=380, left=258
6117:         *======================================================
6118:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
6119:         WITH loc_oPg.cmd_4c_BtnInsereMtx
6120:             .Caption       = "+"
6121:             .Top           = 380
6122:             .Left          = 258
6123:             .Width         = 23
6124:             .Height        = 23
6125:             .FontName      = "Tahoma"
6126:             .FontSize      = 10
6127:             .FontBold      = .T.
6128:             .Themes        = .F.
6129:             .SpecialEffect = 0
6130:             .BackColor     = RGB(255, 255, 255)
6131:             .ForeColor     = RGB(90, 90, 90)
6132:             .Visible       = .T.
6133:         ENDWITH
6134:         BINDEVENT(loc_oPg.cmd_4c_BtnInsereMtx, "Click", THIS, "BtnInserirMatrizClick")
6135: 
6136:         *======================================================
6137:         *-- BUTTON: cmd_4c_BtnExcluiMtz - Excluir linha da grade de matrizes
6138:         *-- top=420, left=258
6139:         *======================================================
6140:         loc_oPg.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
6141:         WITH loc_oPg.cmd_4c_BtnExcluiMtz
6142:             .Caption       = "-"
6143:             .Top           = 420
6144:             .Left          = 258
6145:             .Width         = 23
6146:             .Height        = 23
6147:             .FontName      = "Tahoma"
6148:             .FontSize      = 10
6149:             .FontBold      = .T.
6150:             .Themes        = .F.
6151:             .SpecialEffect = 0
6152:             .BackColor     = RGB(255, 255, 255)
6153:             .ForeColor     = RGB(90, 90, 90)
6154:             .Visible       = .T.
6155:         ENDWITH
6156:         BINDEVENT(loc_oPg.cmd_4c_BtnExcluiMtz, "Click", THIS, "BtnExcluirMatrizClick")
6157: 
6158:         *======================================================
6159:         *-- SHAPE: shp_4c_ShpBorracha - Borda ao redor da imagem da borracha
6160:         *-- top=464, left=258, width=236, height=156
6161:         *======================================================
6162:         loc_oPg.AddObject("shp_4c_ShpBorracha", "Shape")
6163:         WITH loc_oPg.shp_4c_ShpBorracha
6164:             .Top         = 464
6165:             .Left        = 258
6166:             .Width       = 236
6167:             .Height      = 156
6168:             .BorderColor = RGB(150, 150, 150)
6169:             .BorderWidth = 1
6170:             .FillStyle   = 1
6171:             .Curvature   = 0
6172:             .Visible     = .T.
6173:         ENDWITH
6174: 
6175:         *======================================================
6176:         *-- IMAGE: img_4c_ImgBorracha - Imagem da borracha (molde)
6177:         *-- top=465, left=260, width=232, height=154
6178:         *======================================================
6179:         loc_oPg.AddObject("img_4c_ImgBorracha", "Image")
6180:         WITH loc_oPg.img_4c_ImgBorracha
6181:             .Top     = 465
6182:             .Left    = 260
6183:             .Width   = 232
6184:             .Height  = 154
6185:             .Stretch = 2
6186:             .Visible = .F.
6187:         ENDWITH
6188: 
6189:         *======================================================
6190:         *-- BINDEVENTs para grids (AfterRowColChange)
6191:         *======================================================
6192:         BINDEVENT(loc_oPg.grd_4c_Fases,    "AfterRowColChange", THIS, "GrdFasesAfterRowColChange")
6193:         BINDEVENT(loc_oPg.grd_4c_Matrizes, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
6194: 
6195:         *======================================================
6196:         *-- BINDEVENTs para lookups da aba Fases
6197:         *======================================================
6198:         BINDEVENT(loc_oPg.txt_4c_CodcorsFas,  "KeyPress", THIS, "TabFases_CodcorsKeyPress")
6199:         BINDEVENT(loc_oPg.txt_4c_CodcorsFas,  "LostFocus", THIS, "TabFases_CodcorsLostFocus")
6200:         BINDEVENT(loc_oPg.txt_4c_CodtamsFas,  "KeyPress", THIS, "TabFases_CodtamsKeyPress")
6201:         BINDEVENT(loc_oPg.txt_4c_CodtamsFas,  "LostFocus", THIS, "TabFases_CodtamsLostFocus")
6202:         BINDEVENT(loc_oPg.txt_4c_CodacbsFas,  "KeyPress", THIS, "TabFases_CodacbsKeyPress")
6203:         BINDEVENT(loc_oPg.txt_4c_CodacbsFas,  "LostFocus", THIS, "TabFases_CodacbsLostFocus")
6204:         BINDEVENT(loc_oPg.txt_4c_Conquilhas,  "KeyPress", THIS, "TabFases_ConquilhaKeyPress")
6205:         BINDEVENT(loc_oPg.txt_4c_Conquilhas,  "LostFocus", THIS, "TabFases_ConquilhaLostFocus")
6206:         BINDEVENT(loc_oPg.txt_4c_Codgarras,   "KeyPress", THIS, "TabFases_GarraKeyPress")
6207:         BINDEVENT(loc_oPg.txt_4c_Codgarras,   "LostFocus", THIS, "TabFases_GarraLostFocus")
6208: 
6209:     ENDPROC
6210: 
6211:     *--------------------------------------------------------------------------
6212:     * OpcaoAbasChange - Navegacao entre abas pelo OptionGroup
6213:     * Legado: Optiongroup1.InteractiveChange
6214:     *--------------------------------------------------------------------------
6215:     PROCEDURE OpcaoAbasChange()
6216:         LOCAL loc_nAba, loc_lTemProduto
6217:         loc_nAba      = THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value
6218:         loc_lTemProduto = !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCpros))
6219: 
6220:         DO CASE
6221:             CASE loc_nAba = 1   && Principal
6222:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
6223:             CASE loc_nAba = 2   && Composicao
6224:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 2
6225:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6226:                     THIS.CarregarComposicao()
6227:                 ENDIF
6228:             CASE loc_nAba = 3   && Custos
6229:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 3
6230:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6231:                     THIS.CarregarCustos()
6232:                 ENDIF
6233:             CASE loc_nAba = 4   && Dados Fiscais
6234:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 4
6235:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6236:                     THIS.CarregarDadosFiscais()
6237:                 ENDIF
6238:             CASE loc_nAba = 5   && Designer
6239:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 5
6240:             CASE loc_nAba = 6   && Consulta P.
6241:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 6
6242:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6243:                     THIS.CarregarConsultaP()
6244:                 ENDIF
6245:             CASE loc_nAba = 7   && Fases
6246:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 7
6247:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6248:                     THIS.CarregarFases()
6249:                 ENDIF
6250:         ENDCASE
6251:     ENDPROC
6252: 
6253:     *--------------------------------------------------------------------------
6254:     * CarregarLista - Busca e exibe lista de produtos no grid
6255:     *--------------------------------------------------------------------------
6256:     PROCEDURE CarregarLista()
6257:         LOCAL loc_oGrid, loc_lResultado, loc_cFiltro, loc_cWhere
6258:         LOCAL loc_cCgru, loc_dIni, loc_dFim, loc_nSit
6259:         loc_lResultado = .F.
6260: 
6261:         TRY
6262:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
6263: 
6264:             *-- Montar filtro a partir dos controles
6265:             loc_cWhere = ""
6266:             loc_cFiltro = ""
6267: 
6268:             *-- Filtro grupo
6269:             loc_cCgru = ""
6270:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros, "ControlCount", 5)
6271:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru, "Value", 5)
6272:                     loc_cCgru = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value)
6273:                 ENDIF
6274:             ENDIF
6275: 
6276:             IF !EMPTY(loc_cCgru)
6277:                 loc_cFiltro = "p.cgrus = " + EscaparSQL(loc_cCgru)
6278:             ENDIF
6279: 
6280:             *-- Filtro situacao
6281:             loc_nSit = 1
6282:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros, "ControlCount", 5)
6283:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_FiltraSituas, "Value", 5)
6284:                     loc_nSit = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_FiltraSituas.Value
6285:                 ENDIF
6286:             ENDIF
6287: 
6288:             IF loc_nSit = 2   && Apenas ativos (situas=1)
6289:                 IF !EMPTY(loc_cFiltro)
6290:                     loc_cFiltro = loc_cFiltro + " AND p.situas = 1"
6291:                 ELSE
6292:                     loc_cFiltro = "p.situas = 1"
6293:                 ENDIF
6294:             ENDIF
6295:             IF loc_nSit = 3   && Apenas inativos (situas=2)
6296:                 IF !EMPTY(loc_cFiltro)

*-- Linhas 6369 a 6412:
6369:     * FormParaBO - Transfere dados do formulario para o Business Object
6370:     * Todos os campos editaveis da aba Principal
6371:     *--------------------------------------------------------------------------
6372:     PROTECTED PROCEDURE FormParaBO()
6373:         LOCAL loc_oBO, loc_oPg
6374:         loc_oBO = THIS.this_oBusinessObject
6375:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6376: 
6377:         *-- Identificacao
6378:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
6379:             loc_oBO.this_cCpros  = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
6380:         ENDIF
6381:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
6382:             loc_oBO.this_cDpros  = ALLTRIM(loc_oPg.txt_4c_Dpros.Value)
6383:         ENDIF
6384:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
6385:             loc_oBO.this_cDpro2s = ALLTRIM(loc_oPg.txt_4c_Dpro2s.Value)
6386:         ENDIF
6387: 
6388:         *-- Grupo / Subgrupo
6389:         IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
6390:             loc_oBO.this_cCgrus  = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
6391:         ENDIF
6392:         IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
6393:             loc_oBO.this_cSgrus  = ALLTRIM(loc_oPg.txt_4c_Csgrus.Value)
6394:         ENDIF
6395: 
6396:         *-- Linha / Colecao / Fornecedor / Referencia
6397:         IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
6398:             loc_oBO.this_cLinhas   = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
6399:         ENDIF
6400:         IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
6401:             loc_oBO.this_cColecoes = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
6402:         ENDIF
6403:         IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
6404:             loc_oBO.this_cIfors    = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
6405:         ENDIF
6406:         IF PEMSTATUS(loc_oPg, "txt_4c_Reffs", 5)
6407:             loc_oBO.this_cReffs    = ALLTRIM(loc_oPg.txt_4c_Reffs.Value)
6408:         ENDIF
6409: 
6410:         *-- Tipo / Identificador / Conjunto / Equivalente
6411:         IF PEMSTATUS(loc_oPg, "txt_4c_Mercs", 5)
6412:             loc_oBO.this_cMercs    = ALLTRIM(loc_oPg.txt_4c_Mercs.Value)

*-- Linhas 6428 a 6472:
6428:         IF PEMSTATUS(loc_oPg, "txt_4c_Ean13", 5)
6429:             loc_oBO.this_nEan13 = loc_oPg.txt_4c_Ean13.Value
6430:         ENDIF
6431: 
6432:         *-- Situacao (OptionGroup Value=1=Ativo, Value=2=Inativo -> nSituas)
6433:         IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
6434:             loc_oBO.this_nSituas = loc_oPg.opt_4c_Situas.Value
6435:         ENDIF
6436: 
6437:         *-- Lote Minimo / Qtde
6438:         IF PEMSTATUS(loc_oPg, "txt_4c_Ltminsv", 5)
6439:             loc_oBO.this_nLtminsv = loc_oPg.txt_4c_Ltminsv.Value
6440:         ENDIF
6441:         IF PEMSTATUS(loc_oPg, "txt_4c_Qmins", 5)
6442:             loc_oBO.this_nQmins   = loc_oPg.txt_4c_Qmins.Value
6443:         ENDIF
6444:         IF PEMSTATUS(loc_oPg, "txt_4c_Qtped", 5)
6445:             loc_oBO.this_nQtped   = loc_oPg.txt_4c_Qtped.Value
6446:         ENDIF
6447: 
6448:         *-- Observacoes curtas
6449:         IF PEMSTATUS(loc_oPg, "txt_4c_Obsetqs", 5)
6450:             loc_oBO.this_cObsetqs = ALLTRIM(loc_oPg.txt_4c_Obsetqs.Value)
6451:         ENDIF
6452:         IF PEMSTATUS(loc_oPg, "txt_4c_Obspeds", 5)
6453:             loc_oBO.this_cObspeds = ALLTRIM(loc_oPg.txt_4c_Obspeds.Value)
6454:         ENDIF
6455:         IF PEMSTATUS(loc_oPg, "txt_4c_Obspes", 5)
6456:             loc_oBO.this_cObspes  = ALLTRIM(loc_oPg.txt_4c_Obspes.Value)
6457:         ENDIF
6458: 
6459:         *-- Custo / Moeda custo
6460:         IF PEMSTATUS(loc_oPg, "txt_4c_Custofs", 5)
6461:             loc_oBO.this_nCustofs = loc_oPg.txt_4c_Custofs.Value
6462:         ENDIF
6463:         IF PEMSTATUS(loc_oPg, "txt_4c_Moecs", 5)
6464:             loc_oBO.this_cMoecs   = ALLTRIM(loc_oPg.txt_4c_Moecs.Value)
6465:         ENDIF
6466: 
6467:         *-- Preco / Moeda preco
6468:         IF PEMSTATUS(loc_oPg, "txt_4c_Pvens", 5)
6469:             loc_oBO.this_nPvens   = loc_oPg.txt_4c_Pvens.Value
6470:         ENDIF
6471:         IF PEMSTATUS(loc_oPg, "txt_4c_Moepvs", 5)
6472:             loc_oBO.this_cMoepvs  = ALLTRIM(loc_oPg.txt_4c_Moepvs.Value)

*-- Linhas 6526 a 6552:
6526:         IF PEMSTATUS(loc_oPg, "chk_4c_Chkgarvit", 5)
6527:             loc_oBO.this_lChkgarvit = (loc_oPg.chk_4c_Chkgarvit.Value = 1)
6528:         ENDIF
6529: 
6530:         *-- Produto Web (Value=1=Nao=.F., Value>1=Sim=.T.)
6531:         IF PEMSTATUS(loc_oPg, "opt_4c_ProdWeb", 5)
6532:             loc_oBO.this_lProdwebs = (loc_oPg.opt_4c_ProdWeb.Value > 1)
6533:         ENDIF
6534: 
6535:         *-- Variacao (Value=1=Sim=.T., Value=2=Nao=.F.)
6536:         IF PEMSTATUS(loc_oPg, "opt_4c_Varias", 5)
6537:             loc_oBO.this_lVarias = (loc_oPg.opt_4c_Varias.Value = 1)
6538:         ENDIF
6539: 
6540:         *-- CheckBoxes situacao produto
6541:         IF PEMSTATUS(loc_oPg, "chk_4c_Consigs", 5)
6542:             loc_oBO.this_lConsigs    = (loc_oPg.chk_4c_Consigs.Value = 1)
6543:         ENDIF
6544:         IF PEMSTATUS(loc_oPg, "chk_4c_Fabrproprs", 5)
6545:             loc_oBO.this_lFabrproprs = (loc_oPg.chk_4c_Fabrproprs.Value = 1)
6546:         ENDIF
6547:         IF PEMSTATUS(loc_oPg, "chk_4c_Encoms", 5)
6548:             loc_oBO.this_lEncoms     = (loc_oPg.chk_4c_Encoms.Value = 1)
6549:         ENDIF
6550: 
6551:         *-- Entrega / Dimensoes / Volumes
6552:         IF PEMSTATUS(loc_oPg, "txt_4c_Tents", 5)

*-- Linhas 6677 a 6720:
6677:     * BOParaForm - Transfere dados do Business Object para o formulario
6678:     * Inclui carga de descricoes de campos lookup via SQL
6679:     *--------------------------------------------------------------------------
6680:     PROTECTED PROCEDURE BOParaForm()
6681:         LOCAL loc_oBO, loc_oPg
6682:         loc_oBO = THIS.this_oBusinessObject
6683:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6684: 
6685:         *-- Identificacao
6686:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
6687:             loc_oPg.txt_4c_Cpros.Value  = loc_oBO.this_cCpros
6688:         ENDIF
6689:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
6690:             loc_oPg.txt_4c_Dpros.Value  = loc_oBO.this_cDpros
6691:         ENDIF
6692:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
6693:             loc_oPg.txt_4c_Dpro2s.Value = loc_oBO.this_cDpro2s
6694:         ENDIF
6695: 
6696:         *-- Grupo + descricao
6697:         IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
6698:             loc_oPg.txt_4c_Cgrus.Value = loc_oBO.this_cCgrus
6699:         ENDIF
6700:         IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
6701:             loc_oPg.txt_4c_Dgrus.Value = THIS.CarregarDesc("SigCdGrp", "cgrus", loc_oBO.this_cCgrus, "dgrus")
6702:         ENDIF
6703: 
6704:         *-- Subgrupo + descricao
6705:         IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
6706:             loc_oPg.txt_4c_Csgrus.Value = loc_oBO.this_cSgrus
6707:         ENDIF
6708:         IF PEMSTATUS(loc_oPg, "txt_4c_Dsgrus", 5)
6709:             loc_oPg.txt_4c_Dsgrus.Value = THIS.CarregarDescSgru(loc_oBO.this_cCgrus, loc_oBO.this_cSgrus)
6710:         ENDIF
6711: 
6712:         *-- Linha + descricao
6713:         IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
6714:             loc_oPg.txt_4c_Linhas.Value  = loc_oBO.this_cLinhas
6715:         ENDIF
6716:         IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
6717:             loc_oPg.txt_4c_Dlinhas.Value = THIS.CarregarDesc("SigCdLin", "Linhas", loc_oBO.this_cLinhas, "Descs")
6718:         ENDIF
6719: 
6720:         *-- Colecao + descricao

*-- Linhas 6759 a 6803:
6759:         IF PEMSTATUS(loc_oPg, "txt_4c_Ean13", 5)
6760:             loc_oPg.txt_4c_Ean13.Value = loc_oBO.this_nEan13
6761:         ENDIF
6762: 
6763:         *-- Situacao (nSituas 1=Ativo, 2=Inativo -> OptionGroup.Value)
6764:         IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
6765:             loc_oPg.opt_4c_Situas.Value = IIF(loc_oBO.this_nSituas >= 1, loc_oBO.this_nSituas, 1)
6766:         ENDIF
6767:         IF PEMSTATUS(loc_oPg, "txt_4c_DtSituas", 5)
6768:             loc_oPg.txt_4c_DtSituas.Value = NVL(loc_oBO.this_dDtsituas, {})
6769:         ENDIF
6770: 
6771:         *-- Lote Minimo / Qtde
6772:         IF PEMSTATUS(loc_oPg, "txt_4c_Ltminsv", 5)
6773:             loc_oPg.txt_4c_Ltminsv.Value = loc_oBO.this_nLtminsv
6774:         ENDIF
6775:         IF PEMSTATUS(loc_oPg, "txt_4c_Qmins", 5)
6776:             loc_oPg.txt_4c_Qmins.Value   = loc_oBO.this_nQmins
6777:         ENDIF
6778:         IF PEMSTATUS(loc_oPg, "txt_4c_Qtped", 5)
6779:             loc_oPg.txt_4c_Qtped.Value   = loc_oBO.this_nQtped
6780:         ENDIF
6781: 
6782:         *-- Observacoes curtas
6783:         IF PEMSTATUS(loc_oPg, "txt_4c_Obsetqs", 5)
6784:             loc_oPg.txt_4c_Obsetqs.Value = loc_oBO.this_cObsetqs
6785:         ENDIF
6786:         IF PEMSTATUS(loc_oPg, "txt_4c_Obspeds", 5)
6787:             loc_oPg.txt_4c_Obspeds.Value = loc_oBO.this_cObspeds
6788:         ENDIF
6789:         IF PEMSTATUS(loc_oPg, "txt_4c_Obspes", 5)
6790:             loc_oPg.txt_4c_Obspes.Value  = loc_oBO.this_cObspes
6791:         ENDIF
6792: 
6793:         *-- Ultima Compra (ReadOnly)
6794:         IF PEMSTATUS(loc_oPg, "txt_4c_Dtucp", 5)
6795:             loc_oPg.txt_4c_Dtucp.Value      = NVL(loc_oBO.this_dUltcomps, {})
6796:         ENDIF
6797:         IF PEMSTATUS(loc_oPg, "txt_4c_Vucp", 5)
6798:             loc_oPg.txt_4c_Vucp.Value       = loc_oBO.this_nVultcomps
6799:         ENDIF
6800:         IF PEMSTATUS(loc_oPg, "txt_4c_Mucp", 5)
6801:             loc_oPg.txt_4c_Mucp.Value       = loc_oBO.this_cMultcomps
6802:         ENDIF
6803:         IF PEMSTATUS(loc_oPg, "txt_4c_Qtdultcomp", 5)

*-- Linhas 6903 a 6929:
6903:         IF PEMSTATUS(loc_oPg, "chk_4c_Chkgarvit", 5)
6904:             loc_oPg.chk_4c_Chkgarvit.Value = loc_oBO.this_lChkgarvit
6905:         ENDIF
6906: 
6907:         *-- Produto Web (lProdwebs .T.=Sim->Value=2, .F.=Nao->Value=1)
6908:         IF PEMSTATUS(loc_oPg, "opt_4c_ProdWeb", 5)
6909:             loc_oPg.opt_4c_ProdWeb.Value = IIF(loc_oBO.this_lProdwebs, 2, 1)
6910:         ENDIF
6911: 
6912:         *-- Variacao (lVarias .T.=Sim->Value=1, .F.=Nao->Value=2)
6913:         IF PEMSTATUS(loc_oPg, "opt_4c_Varias", 5)
6914:             loc_oPg.opt_4c_Varias.Value = IIF(loc_oBO.this_lVarias, 1, 2)
6915:         ENDIF
6916: 
6917:         *-- CheckBoxes situacao produto
6918:         IF PEMSTATUS(loc_oPg, "chk_4c_Consigs", 5)
6919:             loc_oPg.chk_4c_Consigs.Value    = loc_oBO.this_lConsigs
6920:         ENDIF
6921:         IF PEMSTATUS(loc_oPg, "chk_4c_Fabrproprs", 5)
6922:             loc_oPg.chk_4c_Fabrproprs.Value = loc_oBO.this_lFabrproprs
6923:         ENDIF
6924:         IF PEMSTATUS(loc_oPg, "chk_4c_Encoms", 5)
6925:             loc_oPg.chk_4c_Encoms.Value     = loc_oBO.this_lEncoms
6926:         ENDIF
6927: 
6928:         *-- Entrega / Dimensoes / Volumes
6929:         IF PEMSTATUS(loc_oPg, "txt_4c_Tents", 5)

*-- Linhas 7157 a 7200:
7157:     *--------------------------------------------------------------------------
7158:     * LimparCampos - Limpa todos os campos do formulario (aba Principal)
7159:     *--------------------------------------------------------------------------
7160:     PROTECTED PROCEDURE LimparCampos()
7161:         LOCAL loc_oPg
7162:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7163: 
7164:         *-- Identificacao
7165:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
7166:             loc_oPg.txt_4c_Cpros.Value  = ""
7167:         ENDIF
7168:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
7169:             loc_oPg.txt_4c_Dpros.Value  = ""
7170:         ENDIF
7171:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
7172:             loc_oPg.txt_4c_Dpro2s.Value = ""
7173:         ENDIF
7174: 
7175:         *-- Grupo / Subgrupo
7176:         IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
7177:             loc_oPg.txt_4c_Cgrus.Value  = ""
7178:         ENDIF
7179:         IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
7180:             loc_oPg.txt_4c_Dgrus.Value  = ""
7181:         ENDIF
7182:         IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
7183:             loc_oPg.txt_4c_Csgrus.Value = ""
7184:         ENDIF
7185:         IF PEMSTATUS(loc_oPg, "txt_4c_Dsgrus", 5)
7186:             loc_oPg.txt_4c_Dsgrus.Value = ""
7187:         ENDIF
7188: 
7189:         *-- Linha / Colecao / Fornecedor / Ref
7190:         IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
7191:             loc_oPg.txt_4c_Linhas.Value    = ""
7192:         ENDIF
7193:         IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
7194:             loc_oPg.txt_4c_Dlinhas.Value   = ""
7195:         ENDIF
7196:         IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
7197:             loc_oPg.txt_4c_Colecoes.Value  = ""
7198:         ENDIF
7199:         IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
7200:             loc_oPg.txt_4c_Dcolecoes.Value = ""

*-- Linhas 7230 a 7251:
7230:         IF PEMSTATUS(loc_oPg, "txt_4c_Ean13", 5)
7231:             loc_oPg.txt_4c_Ean13.Value = 0
7232:         ENDIF
7233: 
7234:         *-- Situacao
7235:         IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
7236:             loc_oPg.opt_4c_Situas.Value = 1
7237:         ENDIF
7238:         IF PEMSTATUS(loc_oPg, "txt_4c_DtSituas", 5)
7239:             loc_oPg.txt_4c_DtSituas.Value = {}
7240:         ENDIF
7241: 
7242:         *-- Lote Minimo / Qtde
7243:         IF PEMSTATUS(loc_oPg, "txt_4c_Ltminsv", 5)
7244:             loc_oPg.txt_4c_Ltminsv.Value = 0
7245:         ENDIF
7246:         IF PEMSTATUS(loc_oPg, "txt_4c_Qmins", 5)
7247:             loc_oPg.txt_4c_Qmins.Value   = 0
7248:         ENDIF
7249:         IF PEMSTATUS(loc_oPg, "txt_4c_Qtped", 5)
7250:             loc_oPg.txt_4c_Qtped.Value   = 0
7251:         ENDIF

*-- Linhas 7380 a 7404:
7380:             loc_oPg.txt_4c_Diasgar.Value    = 0
7381:         ENDIF
7382:         IF PEMSTATUS(loc_oPg, "chk_4c_Chkgarvit", 5)
7383:             loc_oPg.chk_4c_Chkgarvit.Value = 0
7384:         ENDIF
7385:         IF PEMSTATUS(loc_oPg, "opt_4c_ProdWeb", 5)
7386:             loc_oPg.opt_4c_ProdWeb.Value    = 1
7387:         ENDIF
7388:         IF PEMSTATUS(loc_oPg, "opt_4c_Varias", 5)
7389:             loc_oPg.opt_4c_Varias.Value     = 2
7390:         ENDIF
7391:         IF PEMSTATUS(loc_oPg, "chk_4c_Consigs", 5)
7392:             loc_oPg.chk_4c_Consigs.Value    = 0
7393:         ENDIF
7394:         IF PEMSTATUS(loc_oPg, "chk_4c_Fabrproprs", 5)
7395:             loc_oPg.chk_4c_Fabrproprs.Value = 0
7396:         ENDIF
7397:         IF PEMSTATUS(loc_oPg, "chk_4c_Encoms", 5)
7398:             loc_oPg.chk_4c_Encoms.Value     = 0
7399:         ENDIF
7400: 
7401:         *-- Entrega / Dimensoes / Volumes
7402:         IF PEMSTATUS(loc_oPg, "txt_4c_Tents", 5)
7403:             loc_oPg.txt_4c_Tents.Value      = 0
7404:         ENDIF

*-- Linhas 7664 a 7707:
7664:     * HabilitarCampos - Habilita/desabilita campos conforme modo de edicao
7665:     * par_lHabilitar: .T. = edicao/inclusao, .F. = visualizacao
7666:     *--------------------------------------------------------------------------
7667:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
7668:         LOCAL loc_oPg, loc_lNovoReg
7669:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7670:         loc_lNovoReg = (THIS.this_cModoAtual = "INCLUIR")
7671: 
7672:         *-- Codigo: editavel SOMENTE na inclusao (PK nao se altera)
7673:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
7674:             loc_oPg.txt_4c_Cpros.ReadOnly = !loc_lNovoReg
7675:         ENDIF
7676: 
7677:         *-- Campos texto editaveis
7678:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
7679:             loc_oPg.txt_4c_Dpros.ReadOnly    = !par_lHabilitar
7680:         ENDIF
7681:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
7682:             loc_oPg.txt_4c_Dpro2s.ReadOnly   = !par_lHabilitar
7683:         ENDIF
7684:         IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
7685:             loc_oPg.txt_4c_Cgrus.ReadOnly    = !par_lHabilitar
7686:         ENDIF
7687:         IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
7688:             loc_oPg.txt_4c_Csgrus.ReadOnly   = !par_lHabilitar
7689:         ENDIF
7690:         IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
7691:             loc_oPg.txt_4c_Linhas.ReadOnly   = !par_lHabilitar
7692:         ENDIF
7693:         IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
7694:             loc_oPg.txt_4c_Colecoes.ReadOnly = !par_lHabilitar
7695:         ENDIF
7696:         IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
7697:             loc_oPg.txt_4c_Ifors.ReadOnly    = !par_lHabilitar
7698:         ENDIF
7699:         IF PEMSTATUS(loc_oPg, "txt_4c_Reffs", 5)
7700:             loc_oPg.txt_4c_Reffs.ReadOnly    = !par_lHabilitar
7701:         ENDIF
7702:         IF PEMSTATUS(loc_oPg, "txt_4c_Mercs", 5)
7703:             loc_oPg.txt_4c_Mercs.ReadOnly    = !par_lHabilitar
7704:         ENDIF
7705:         IF PEMSTATUS(loc_oPg, "txt_4c_Idecpros", 5)
7706:             loc_oPg.txt_4c_Idecpros.ReadOnly  = !par_lHabilitar
7707:         ENDIF

*-- Linhas 7819 a 7863:
7819:         IF PEMSTATUS(loc_oPg, "txt_4c_Volumes", 5)
7820:             loc_oPg.txt_4c_Volumes.ReadOnly   = !par_lHabilitar
7821:         ENDIF
7822: 
7823:         *-- OptionGroups e CheckBoxes: Enabled
7824:         IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
7825:             loc_oPg.opt_4c_Situas.Enabled     = par_lHabilitar
7826:         ENDIF
7827:         IF PEMSTATUS(loc_oPg, "opt_4c_ProdWeb", 5)
7828:             loc_oPg.opt_4c_ProdWeb.Enabled    = par_lHabilitar
7829:         ENDIF
7830:         IF PEMSTATUS(loc_oPg, "opt_4c_Varias", 5)
7831:             loc_oPg.opt_4c_Varias.Enabled     = par_lHabilitar
7832:         ENDIF
7833:         IF PEMSTATUS(loc_oPg, "chk_4c_Chkgarvit", 5)
7834:             loc_oPg.chk_4c_Chkgarvit.Enabled  = par_lHabilitar
7835:         ENDIF
7836:         IF PEMSTATUS(loc_oPg, "chk_4c_Consigs", 5)
7837:             loc_oPg.chk_4c_Consigs.Enabled    = par_lHabilitar
7838:         ENDIF
7839:         IF PEMSTATUS(loc_oPg, "chk_4c_Fabrproprs", 5)
7840:             loc_oPg.chk_4c_Fabrproprs.Enabled = par_lHabilitar
7841:         ENDIF
7842:         IF PEMSTATUS(loc_oPg, "chk_4c_Encoms", 5)
7843:             loc_oPg.chk_4c_Encoms.Enabled     = par_lHabilitar
7844:         ENDIF
7845: 
7846:         *-- EditBoxes (Memo)
7847:         IF PEMSTATUS(loc_oPg, "edt_4c_Dsccompras", 5)
7848:             loc_oPg.edt_4c_Dsccompras.ReadOnly = !par_lHabilitar
7849:         ENDIF
7850:         IF PEMSTATUS(loc_oPg, "edt_4c_Dpro3s", 5)
7851:             loc_oPg.edt_4c_Dpro3s.ReadOnly     = !par_lHabilitar
7852:         ENDIF
7853:         IF PEMSTATUS(loc_oPg, "edt_4c_Obscompras", 5)
7854:             loc_oPg.edt_4c_Obscompras.ReadOnly  = !par_lHabilitar
7855:         ENDIF
7856: 
7857:         *-- Tab 7: Fases - campos e botoes de operacao
7858:         LOCAL loc_oPg7
7859:         loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
7860: 
7861:         IF PEMSTATUS(loc_oPg7, "txt_4c_Qminfab", 5)
7862:             loc_oPg7.txt_4c_Qminfab.ReadOnly   = !par_lHabilitar
7863:         ENDIF

*-- Linhas 7925 a 9173:
7925:     *--------------------------------------------------------------------------
7926:     * BtnIncluirClick - Incluir novo produto
7927:     *--------------------------------------------------------------------------
7928:     PROCEDURE BtnIncluirClick()
7929:         THIS.this_oBusinessObject.NovoRegistro()
7930:         THIS.LimparCampos()
7931:         THIS.this_cModoAtual = "INCLUIR"
7932:         THIS.HabilitarCampos(.T.)
7933:         THIS.AjustarBotoesPorModo()
7934:         THIS.AlternarPagina(2)
7935:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
7936:         THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
7937:     ENDPROC
7938: 
7939:     *--------------------------------------------------------------------------
7940:     * BtnVisualizarClick - Visualizar produto selecionado
7941:     *--------------------------------------------------------------------------
7942:     PROCEDURE BtnVisualizarClick()
7943:         LOCAL loc_cCodigo
7944: 
7945:         IF !USED("cursor_4c_Dados")
7946:             MsgAviso("Nenhum produto selecionado!")
7947:             RETURN
7948:         ENDIF
7949:         IF RECCOUNT("cursor_4c_Dados") = 0
7950:             MsgAviso("Nenhum produto selecionado!")
7951:             RETURN
7952:         ENDIF
7953: 
7954:         SELECT cursor_4c_Dados
7955:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
7956: 
7957:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
7958:             THIS.BOParaForm()
7959:             THIS.this_cModoAtual = "VISUALIZAR"
7960:             THIS.HabilitarCampos(.F.)
7961:             THIS.AjustarBotoesPorModo()
7962:             THIS.AlternarPagina(2)
7963:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
7964:             THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
7965:         ENDIF
7966:     ENDPROC
7967: 
7968:     *--------------------------------------------------------------------------
7969:     * BtnAlterarClick - Alterar produto selecionado
7970:     *--------------------------------------------------------------------------
7971:     PROCEDURE BtnAlterarClick()
7972:         LOCAL loc_cCodigo
7973: 
7974:         IF !USED("cursor_4c_Dados")
7975:             MsgAviso("Nenhum produto selecionado!")
7976:             RETURN
7977:         ENDIF
7978:         IF RECCOUNT("cursor_4c_Dados") = 0
7979:             MsgAviso("Nenhum produto selecionado!")
7980:             RETURN
7981:         ENDIF
7982: 
7983:         SELECT cursor_4c_Dados
7984:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
7985: 
7986:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
7987:             THIS.this_oBusinessObject.EditarRegistro()
7988:             THIS.BOParaForm()
7989:             THIS.this_cModoAtual = "ALTERAR"
7990:             THIS.HabilitarCampos(.T.)
7991:             THIS.AjustarBotoesPorModo()
7992:             THIS.AlternarPagina(2)
7993:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
7994:             THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
7995:         ENDIF
7996:     ENDPROC
7997: 
7998:     *--------------------------------------------------------------------------
7999:     * BtnExcluirClick - Excluir produto selecionado
8000:     * Legado: verifica se produto e usado em pedidos/fichas tecnicas
8001:     *--------------------------------------------------------------------------
8002:     PROCEDURE BtnExcluirClick()
8003:         LOCAL loc_cCodigo, loc_cSQL, loc_nResultado
8004: 
8005:         IF !USED("cursor_4c_Dados")
8006:             MsgAviso("Nenhum produto selecionado!")
8007:             RETURN
8008:         ENDIF
8009:         IF RECCOUNT("cursor_4c_Dados") = 0
8010:             MsgAviso("Nenhum produto selecionado!")
8011:             RETURN
8012:         ENDIF
8013: 
8014:         SELECT cursor_4c_Dados
8015:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
8016: 
8017:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8018: 
8019:             *-- Verificar uso em itens de pedido (SigMvCIte)
8020:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8021:                 SELECT COUNT(*) AS nExiste
8022:                 FROM SigMvCIte
8023:                 WHERE cpros = <<EscaparSQL(loc_cCodigo)>>
8024:             ENDTEXT
8025: 
8026:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerPro")
8027: 
8028:             IF loc_nResultado < 0
8029:                 MsgErro("Falha ao verificar uso do produto!")
8030:                 IF USED("cursor_4c_VerPro")
8031:                     USE IN cursor_4c_VerPro
8032:                 ENDIF
8033:                 RETURN
8034:             ENDIF
8035: 
8036:             IF NVL(cursor_4c_VerPro.nExiste, 0) > 0
8037:                 MsgAviso("Produto em uso em pedidos - n" + CHR(227) + "o pode ser exclu" + CHR(237) + "do!")
8038:                 IF USED("cursor_4c_VerPro")
8039:                     USE IN cursor_4c_VerPro
8040:                 ENDIF
8041:                 RETURN
8042:             ENDIF
8043: 
8044:             IF USED("cursor_4c_VerPro")
8045:                 USE IN cursor_4c_VerPro
8046:             ENDIF
8047: 
8048:             IF MsgConfirma("Confirma exclus" + CHR(227) + "o do produto '" + loc_cCodigo + "'?")
8049:                 IF THIS.this_oBusinessObject.Excluir()
8050:                     MsgSucesso("Produto exclu" + CHR(237) + "do com sucesso!")
8051:                     THIS.CarregarLista()
8052:                 ENDIF
8053:             ENDIF
8054:         ENDIF
8055:     ENDPROC
8056: 
8057:     *--------------------------------------------------------------------------
8058:     * BtnSalvarClick - Salvar produto
8059:     *--------------------------------------------------------------------------
8060:     PROCEDURE BtnSalvarClick()
8061:         LOCAL loc_oPg, loc_cCodNovo, loc_cSQLDup, loc_nDup
8062: 
8063:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8064: 
8065:         *-- Validacao: codigo obrigatorio
8066:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
8067:             IF EMPTY(loc_oPg.txt_4c_Cpros.Value)
8068:                 MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o pode ficar em branco!")
8069:                 IF PEMSTATUS(loc_oPg.txt_4c_Cpros, "SetFocus", 5)
8070:                     loc_oPg.txt_4c_Cpros.SetFocus()
8071:                 ENDIF
8072:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8073:                 THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8074:                 RETURN
8075:             ENDIF
8076:         ENDIF
8077: 
8078:         *-- Validacao: codigo duplicado (apenas no modo INCLUIR)
8079:         IF THIS.this_cModoAtual = "INCLUIR"
8080:             IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
8081:                 loc_cCodNovo = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
8082: 
8083:                 TEXT TO loc_cSQLDup TEXTMERGE NOSHOW
8084:                     SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE cpros = <<EscaparSQL(loc_cCodNovo)>>
8085:                 ENDTEXT
8086: 
8087:                 loc_nDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_DupPro")
8088: 
8089:                 IF loc_nDup >= 0 AND NVL(cursor_4c_DupPro.nExiste, 0) > 0
8090:                     IF USED("cursor_4c_DupPro")
8091:                         USE IN cursor_4c_DupPro
8092:                     ENDIF
8093:                     MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
8094:                     IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
8095:                         loc_oPg.txt_4c_Cpros.SetFocus()
8096:                     ENDIF
8097:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8098:                     THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8099:                     RETURN
8100:                 ENDIF
8101: 
8102:                 IF USED("cursor_4c_DupPro")
8103:                     USE IN cursor_4c_DupPro
8104:                 ENDIF
8105:             ENDIF
8106:         ENDIF
8107: 
8108:         THIS.FormParaBO()
8109: 
8110:         IF THIS.this_oBusinessObject.Salvar()
8111:             MsgSucesso("Produto salvo com sucesso!")
8112:             THIS.AlternarPagina(1)
8113:             THIS.CarregarLista()
8114:         ENDIF
8115:     ENDPROC
8116: 
8117:     *--------------------------------------------------------------------------
8118:     * BtnCancelarClick - Cancelar edicao
8119:     *--------------------------------------------------------------------------
8120:     PROCEDURE BtnCancelarClick()
8121:         THIS.this_cModoAtual = "LISTA"
8122:         THIS.AlternarPagina(1)
8123:         THIS.CarregarLista()
8124:     ENDPROC
8125: 
8126:     *--------------------------------------------------------------------------
8127:     * BtnBuscarClick - Abre FormBuscaAuxiliar para busca de produtos
8128:     *--------------------------------------------------------------------------
8129:     PROCEDURE BtnBuscarClick()
8130:         LOCAL loc_oBusca, loc_cCodigo
8131: 
8132:         TRY
8133:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Buscar Produto")
8134: 
8135:             loc_oBusca.mAddColuna("cpros", "", "Produto")
8136:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
8137:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
8138: 
8139:             loc_oBusca.Show()
8140: 
8141:             IF loc_oBusca.this_lSelecionou
8142:                 IF USED("cursor_4c_Busca")
8143:                     loc_cCodigo = ALLTRIM(cursor_4c_Busca.cpros)
8144: 
8145:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8146:                         THIS.BOParaForm()
8147:                         THIS.this_cModoAtual = "VISUALIZAR"
8148:                         THIS.HabilitarCampos(.F.)
8149:                         THIS.AjustarBotoesPorModo()
8150:                         THIS.AlternarPagina(2)
8151:                         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8152:                         THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8153:                     ENDIF
8154:                 ENDIF
8155:             ENDIF
8156: 
8157:             IF USED("cursor_4c_Busca")
8158:                 USE IN cursor_4c_Busca
8159:             ENDIF
8160:             loc_oBusca.Release()
8161: 
8162:         CATCH TO loc_oErro
8163:             MsgErro("Erro ao buscar produto:" + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "FormProduto.BtnBuscarClick")
8164:         ENDTRY
8165:     ENDPROC
8166: 
8167:     *--------------------------------------------------------------------------
8168:     * BtnEncerrarClick - Fechar formulario
8169:     *--------------------------------------------------------------------------
8170:     PROCEDURE BtnEncerrarClick()
8171:         THIS.Release()
8172:     ENDPROC
8173: 
8174:     *--------------------------------------------------------------------------
8175:     * BtnPesquisarClick - Recarregar lista com filtros aplicados
8176:     *--------------------------------------------------------------------------
8177:     PROCEDURE BtnPesquisarClick()
8178:         THIS.CarregarLista()
8179:     ENDPROC
8180: 
8181:     *--------------------------------------------------------------------------
8182:     * GrdLista_DblClick - Duplo clique na grade abre visualizacao
8183:     *--------------------------------------------------------------------------
8184:     PROCEDURE GrdLista_DblClick()
8185:         THIS.BtnVisualizarClick()
8186:     ENDPROC
8187: 
8188:     *--------------------------------------------------------------------------
8189:     * FiltroGrupo_KeyPress - F4 no filtro de grupo abre lookup de grupos
8190:     *--------------------------------------------------------------------------
8191:     PROCEDURE FiltroGrupo_KeyPress
8192:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8193:         IF par_nKeyCode = 115    && F4=115 (VFP9)
8194:             THIS.AbrirLookupFiltroGrupo()
8195:         ENDIF
8196:     ENDPROC
8197: 
8198:     *--------------------------------------------------------------------------
8199:     * ValidarFiltroGrupo - LostFocus no filtro de grupo
8200:     *--------------------------------------------------------------------------
8201:     PROCEDURE ValidarFiltroGrupo()
8202:         LOCAL loc_cCgru, loc_cSQL, loc_nRes, loc_oBusca
8203:         loc_cCgru = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value)
8204: 
8205:         IF EMPTY(loc_cCgru)
8206:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ""
8207:             RETURN
8208:         ENDIF
8209: 
8210:         TRY
8211:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8212:                 SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE cgrus = <<EscaparSQL(loc_cCgru)>>
8213:             ENDTEXT
8214: 
8215:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerGru")
8216: 
8217:             IF loc_nRes > 0 AND !EOF("cursor_4c_VerGru")
8218:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ALLTRIM(cursor_4c_VerGru.dgrus)
8219:             ELSE
8220:                 *-- Codigo nao encontrado: abrir lookup
8221:                 THIS.AbrirLookupFiltroGrupo()
8222:             ENDIF
8223: 
8224:             IF USED("cursor_4c_VerGru")
8225:                 USE IN cursor_4c_VerGru
8226:             ENDIF
8227:         CATCH TO loc_oErro
8228:             MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarFiltroGrupo")
8229:         ENDTRY
8230:     ENDPROC
8231: 
8232:     *--------------------------------------------------------------------------
8233:     * AbrirLookupFiltroGrupo - Lookup F4 no filtro de grupo
8234:     *--------------------------------------------------------------------------
8235:     PROTECTED PROCEDURE AbrirLookupFiltroGrupo()
8236:         LOCAL loc_oBusca, loc_cValor
8237:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value)
8238: 
8239:         TRY
8240:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", "cursor_4c_Gru", "cgrus", loc_cValor, "Selecionar Grupo")
8241:             loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
8242:             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
8243:             loc_oBusca.Show()
8244: 
8245:             IF loc_oBusca.this_lSelecionou
8246:                 IF USED("cursor_4c_Gru")
8247:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value = ALLTRIM(cursor_4c_Gru.cgrus)
8248:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ALLTRIM(cursor_4c_Gru.dgrus)
8249:                 ENDIF
8250:             ELSE
8251:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value = ""
8252:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ""
8253:             ENDIF
8254: 
8255:             IF USED("cursor_4c_Gru")
8256:                 USE IN cursor_4c_Gru
8257:             ENDIF
8258:             loc_oBusca.Release()
8259:         CATCH TO loc_oErro
8260:             MsgErro("Erro no lookup de grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupFiltroGrupo")
8261:         ENDTRY
8262:     ENDPROC
8263: 
8264:     *--------------------------------------------------------------------------
8265:     * FiltroSituas_InteractiveChange - Mudar filtro de situacao
8266:     *--------------------------------------------------------------------------
8267:     PROCEDURE FiltroSituas_InteractiveChange()
8268:         THIS.CarregarLista()
8269:     ENDPROC
8270: 
8271:     *--------------------------------------------------------------------------
8272:     * FormatarGridLista - Formata visual do grid da lista
8273:     *--------------------------------------------------------------------------
8274:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
8275:         WITH par_oGrid
8276:             IF .ColumnCount > 0
8277:                 .FontName = "Tahoma"
8278:                 .FontSize = 8
8279:             ENDIF
8280:         ENDWITH
8281:     ENDPROC
8282: 
8283:     *--------------------------------------------------------------------------
8284:     * TornarControlesVisiveis - Torna todos os controles visiveis
8285:     * Filtra por nome para evitar tornar containers flutuantes visiveis
8286:     *--------------------------------------------------------------------------
8287:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
8288:         LOCAL loc_nI, loc_oObjeto, loc_cNome
8289: 
8290:         FOR loc_nI = 1 TO par_oContainer.ControlCount
8291:             loc_oObjeto = par_oContainer.Controls(loc_nI)
8292: 
8293:             IF VARTYPE(loc_oObjeto) = "O"
8294:                 loc_cNome = LOWER(loc_oObjeto.Name)
8295: 
8296:                 *-- Nao tornar visiveis containers flutuantes (Visible=.F. por design)
8297:                 IF INLIST(loc_cNome, "cntmensagem", "cntacabado")
8298:                     LOOP
8299:                 ENDIF
8300: 
8301:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
8302:                     loc_oObjeto.Visible = .T.
8303:                 ENDIF
8304: 
8305:                 *-- Trata PageFrame - itera Pages
8306:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
8307:                     LOCAL loc_nP
8308:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
8309:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
8310:                     ENDFOR
8311:                 ENDIF
8312: 
8313:                 *-- Trata containers com ControlCount
8314:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
8315:                     THIS.TornarControlesVisiveis(loc_oObjeto)
8316:                 ENDIF
8317:             ENDIF
8318:         ENDFOR
8319:     ENDPROC
8320: 
8321:     *--------------------------------------------------------------------------
8322:     * Destroy - Limpar recursos ao fechar
8323:     *--------------------------------------------------------------------------
8324:     PROCEDURE Destroy()
8325:         IF USED("cursor_4c_Dados")
8326:             USE IN cursor_4c_Dados
8327:         ENDIF
8328:         IF USED("cursor_4c_Busca")
8329:             USE IN cursor_4c_Busca
8330:         ENDIF
8331:         IF USED("cursor_4c_Registro")
8332:             USE IN cursor_4c_Registro
8333:         ENDIF
8334: 
8335:         IF !ISNULL(THIS.this_oBusinessObject)
8336:             THIS.this_oBusinessObject = .NULL.
8337:         ENDIF
8338: 
8339:         DODEFAULT()
8340:     ENDPROC
8341: 
8342:     *==========================================================================
8343:     * === METODOS PUBLICOS DE LOOKUP / VALIDACAO (Tab Principal) ==============
8344:     * BINDEVENT requer metodos PUBLIC
8345:     *==========================================================================
8346: 
8347:     *--------------------------------------------------------------------------
8348:     * TabPrincipal_CgruKeyPress - F4 no campo Grupo abre lookup
8349:     *--------------------------------------------------------------------------
8350:     PROCEDURE TabPrincipal_CgruKeyPress
8351:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8352:         IF par_nKeyCode = 115    && F4=115 em VFP9
8353:             THIS.AbrirLookupGrupo()
8354:         ENDIF
8355:     ENDPROC
8356: 
8357:     *--------------------------------------------------------------------------
8358:     * TabPrincipal_CgruLostFocus - LostFocus valida e carrega descricao do grupo
8359:     *--------------------------------------------------------------------------
8360:     PROCEDURE TabPrincipal_CgruLostFocus()
8361:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8362:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8363:         IF !PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
8364:             RETURN
8365:         ENDIF
8366:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
8367: 
8368:         IF EMPTY(loc_cCod)
8369:             IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8370:                 loc_oPg.txt_4c_Dgrus.Value = ""
8371:             ENDIF
8372:             RETURN
8373:         ENDIF
8374: 
8375:         TRY
8376:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8377:                 SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE cgrus = <<EscaparSQL(loc_cCod)>>
8378:             ENDTEXT
8379:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGrp")
8380:             IF loc_nR > 0 AND !EOF("cursor_4c_VGrp")
8381:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8382:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_VGrp.dgrus)
8383:                 ENDIF
8384:             ELSE
8385:                 THIS.AbrirLookupGrupo()
8386:             ENDIF
8387:             IF USED("cursor_4c_VGrp")
8388:                 USE IN cursor_4c_VGrp
8389:             ENDIF
8390:         CATCH TO loc_oErro
8391:             MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CgruLostFocus")
8392:         ENDTRY
8393:     ENDPROC
8394: 
8395:     *--------------------------------------------------------------------------
8396:     * AbrirLookupGrupo - Abre FormBuscaAuxiliar para selecionar grupo de produto
8397:     *--------------------------------------------------------------------------
8398:     PROTECTED PROCEDURE AbrirLookupGrupo()
8399:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8400:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8401:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5), ALLTRIM(loc_oPg.txt_4c_Cgrus.Value), "")
8402: 
8403:         TRY
8404:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", "cursor_4c_Grp", "cgrus", loc_cVal, "Selecionar Grupo")
8405:             loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
8406:             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
8407:             loc_oBusca.Show()
8408: 
8409:             IF loc_oBusca.this_lSelecionou
8410:                 IF USED("cursor_4c_Grp")
8411:                     IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
8412:                         loc_oPg.txt_4c_Cgrus.Value = ALLTRIM(cursor_4c_Grp.cgrus)
8413:                     ENDIF
8414:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8415:                         loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_Grp.dgrus)
8416:                     ENDIF
8417:                 ENDIF
8418:             ELSE
8419:                 IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
8420:                     loc_oPg.txt_4c_Cgrus.Value = ""
8421:                 ENDIF
8422:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8423:                     loc_oPg.txt_4c_Dgrus.Value = ""
8424:                 ENDIF
8425:             ENDIF
8426: 
8427:             IF USED("cursor_4c_Grp")
8428:                 USE IN cursor_4c_Grp
8429:             ENDIF
8430:             loc_oBusca.Release()
8431:         CATCH TO loc_oErro
8432:             MsgErro("Erro no lookup de grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupGrupo")
8433:         ENDTRY
8434:     ENDPROC
8435: 
8436:     *--------------------------------------------------------------------------
8437:     * TabPrincipal_LinhasKeyPress - F4 no campo Linha abre lookup
8438:     *--------------------------------------------------------------------------
8439:     PROCEDURE TabPrincipal_LinhasKeyPress
8440:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8441:         IF par_nKeyCode = 115
8442:             THIS.AbrirLookupLinha()
8443:         ENDIF
8444:     ENDPROC
8445: 
8446:     *--------------------------------------------------------------------------
8447:     * TabPrincipal_LinhasLostFocus - LostFocus valida e carrega descricao da linha
8448:     *--------------------------------------------------------------------------
8449:     PROCEDURE TabPrincipal_LinhasLostFocus()
8450:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8451:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8452:         IF !PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
8453:             RETURN
8454:         ENDIF
8455:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
8456: 
8457:         IF EMPTY(loc_cCod)
8458:             IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8459:                 loc_oPg.txt_4c_Dlinhas.Value = ""
8460:             ENDIF
8461:             RETURN
8462:         ENDIF
8463: 
8464:         TRY
8465:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8466:                 SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = <<EscaparSQL(loc_cCod)>>
8467:             ENDTEXT
8468:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VLin")
8469:             IF loc_nR > 0 AND !EOF("cursor_4c_VLin")
8470:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8471:                     loc_oPg.txt_4c_Dlinhas.Value = ALLTRIM(cursor_4c_VLin.Descs)
8472:                 ENDIF
8473:             ELSE
8474:                 THIS.AbrirLookupLinha()
8475:             ENDIF
8476:             IF USED("cursor_4c_VLin")
8477:                 USE IN cursor_4c_VLin
8478:             ENDIF
8479:         CATCH TO loc_oErro
8480:             MsgErro("Erro ao validar linha:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_LinhasLostFocus")
8481:         ENDTRY
8482:     ENDPROC
8483: 
8484:     *--------------------------------------------------------------------------
8485:     * AbrirLookupLinha - Abre FormBuscaAuxiliar para selecionar linha de produto
8486:     *--------------------------------------------------------------------------
8487:     PROTECTED PROCEDURE AbrirLookupLinha()
8488:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8489:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8490:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5), ALLTRIM(loc_oPg.txt_4c_Linhas.Value), "")
8491: 
8492:         TRY
8493:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLin", "cursor_4c_Lin", "Linhas", loc_cVal, "Selecionar Linha")
8494:             loc_oBusca.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
8495:             loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
8496:             loc_oBusca.Show()
8497: 
8498:             IF loc_oBusca.this_lSelecionou
8499:                 IF USED("cursor_4c_Lin")
8500:                     IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
8501:                         loc_oPg.txt_4c_Linhas.Value  = ALLTRIM(cursor_4c_Lin.Linhas)
8502:                     ENDIF
8503:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8504:                         loc_oPg.txt_4c_Dlinhas.Value = ALLTRIM(cursor_4c_Lin.Descs)
8505:                     ENDIF
8506:                 ENDIF
8507:             ELSE
8508:                 IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
8509:                     loc_oPg.txt_4c_Linhas.Value  = ""
8510:                 ENDIF
8511:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8512:                     loc_oPg.txt_4c_Dlinhas.Value = ""
8513:                 ENDIF
8514:             ENDIF
8515: 
8516:             IF USED("cursor_4c_Lin")
8517:                 USE IN cursor_4c_Lin
8518:             ENDIF
8519:             loc_oBusca.Release()
8520:         CATCH TO loc_oErro
8521:             MsgErro("Erro no lookup de linha:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupLinha")
8522:         ENDTRY
8523:     ENDPROC
8524: 
8525:     *--------------------------------------------------------------------------
8526:     * TabPrincipal_ColecoesKeyPress - F4 no campo Grupo de Venda abre lookup
8527:     *--------------------------------------------------------------------------
8528:     PROCEDURE TabPrincipal_ColecoesKeyPress
8529:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8530:         IF par_nKeyCode = 115
8531:             THIS.AbrirLookupColecao()
8532:         ENDIF
8533:     ENDPROC
8534: 
8535:     *--------------------------------------------------------------------------
8536:     * TabPrincipal_ColecoesLostFocus - LostFocus valida e carrega descricao
8537:     *--------------------------------------------------------------------------
8538:     PROCEDURE TabPrincipal_ColecoesLostFocus()
8539:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8540:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8541:         IF !PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
8542:             RETURN
8543:         ENDIF
8544:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
8545: 
8546:         IF EMPTY(loc_cCod)
8547:             IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8548:                 loc_oPg.txt_4c_Dcolecoes.Value = ""
8549:             ENDIF
8550:             RETURN
8551:         ENDIF
8552: 
8553:         TRY
8554:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8555:                 SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = <<EscaparSQL(loc_cCod)>>
8556:             ENDTEXT
8557:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCol")
8558:             IF loc_nR > 0 AND !EOF("cursor_4c_VCol")
8559:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8560:                     loc_oPg.txt_4c_Dcolecoes.Value = ALLTRIM(cursor_4c_VCol.Descs)
8561:                 ENDIF
8562:             ELSE
8563:                 THIS.AbrirLookupColecao()
8564:             ENDIF
8565:             IF USED("cursor_4c_VCol")
8566:                 USE IN cursor_4c_VCol
8567:             ENDIF
8568:         CATCH TO loc_oErro
8569:             MsgErro("Erro ao validar cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_ColecoesLostFocus")
8570:         ENDTRY
8571:     ENDPROC
8572: 
8573:     *--------------------------------------------------------------------------
8574:     * AbrirLookupColecao - Abre FormBuscaAuxiliar para selecionar grupo de venda
8575:     *--------------------------------------------------------------------------
8576:     PROTECTED PROCEDURE AbrirLookupColecao()
8577:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8578:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8579:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5), ALLTRIM(loc_oPg.txt_4c_Colecoes.Value), "")
8580: 
8581:         TRY
8582:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", "cursor_4c_Col", "Colecoes", loc_cVal, "Selecionar Grupo de Venda")
8583:             loc_oBusca.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
8584:             loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
8585:             loc_oBusca.Show()
8586: 
8587:             IF loc_oBusca.this_lSelecionou
8588:                 IF USED("cursor_4c_Col")
8589:                     IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
8590:                         loc_oPg.txt_4c_Colecoes.Value  = ALLTRIM(cursor_4c_Col.Colecoes)
8591:                     ENDIF
8592:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8593:                         loc_oPg.txt_4c_Dcolecoes.Value = ALLTRIM(cursor_4c_Col.Descs)
8594:                     ENDIF
8595:                 ENDIF
8596:             ELSE
8597:                 IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
8598:                     loc_oPg.txt_4c_Colecoes.Value  = ""
8599:                 ENDIF
8600:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8601:                     loc_oPg.txt_4c_Dcolecoes.Value = ""
8602:                 ENDIF
8603:             ENDIF
8604: 
8605:             IF USED("cursor_4c_Col")
8606:                 USE IN cursor_4c_Col
8607:             ENDIF
8608:             loc_oBusca.Release()
8609:         CATCH TO loc_oErro
8610:             MsgErro("Erro no lookup de cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupColecao")
8611:         ENDTRY
8612:     ENDPROC
8613: 
8614:     *--------------------------------------------------------------------------
8615:     * TabPrincipal_IforsKeyPress - F4 no campo Fornecedor abre lookup
8616:     *--------------------------------------------------------------------------
8617:     PROCEDURE TabPrincipal_IforsKeyPress
8618:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8619:         IF par_nKeyCode = 115
8620:             THIS.AbrirLookupFornecedor()
8621:         ENDIF
8622:     ENDPROC
8623: 
8624:     *--------------------------------------------------------------------------
8625:     * TabPrincipal_IforsLostFocus - LostFocus valida e carrega nome do fornecedor
8626:     *--------------------------------------------------------------------------
8627:     PROCEDURE TabPrincipal_IforsLostFocus()
8628:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8629:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8630:         IF !PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
8631:             RETURN
8632:         ENDIF
8633:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
8634: 
8635:         IF EMPTY(loc_cCod)
8636:             IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8637:                 loc_oPg.txt_4c_Dfors.Value = ""
8638:             ENDIF
8639:             RETURN
8640:         ENDIF
8641: 
8642:         TRY
8643:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8644:                 SELECT TOP 1 IClis, Rclis FROM SigCdCli WHERE IClis = <<EscaparSQL(loc_cCod)>>
8645:             ENDTEXT
8646:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VFor")
8647:             IF loc_nR > 0 AND !EOF("cursor_4c_VFor")
8648:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8649:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_VFor.Rclis)
8650:                 ENDIF
8651:             ELSE
8652:                 THIS.AbrirLookupFornecedor()
8653:             ENDIF
8654:             IF USED("cursor_4c_VFor")
8655:                 USE IN cursor_4c_VFor
8656:             ENDIF
8657:         CATCH TO loc_oErro
8658:             MsgErro("Erro ao validar fornecedor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_IforsLostFocus")
8659:         ENDTRY
8660:     ENDPROC
8661: 
8662:     *--------------------------------------------------------------------------
8663:     * AbrirLookupFornecedor - Abre FormBuscaAuxiliar para selecionar fornecedor
8664:     *--------------------------------------------------------------------------
8665:     PROTECTED PROCEDURE AbrirLookupFornecedor()
8666:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8667:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8668:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5), ALLTRIM(loc_oPg.txt_4c_Ifors.Value), "")
8669: 
8670:         TRY
8671:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_For", "IClis", loc_cVal, "Selecionar Fornecedor")
8672:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
8673:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
8674:             loc_oBusca.Show()
8675: 
8676:             IF loc_oBusca.this_lSelecionou
8677:                 IF USED("cursor_4c_For")
8678:                     IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
8679:                         loc_oPg.txt_4c_Ifors.Value = ALLTRIM(cursor_4c_For.IClis)
8680:                     ENDIF
8681:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8682:                         loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_For.Rclis)
8683:                     ENDIF
8684:                 ENDIF
8685:             ELSE
8686:                 IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
8687:                     loc_oPg.txt_4c_Ifors.Value = ""
8688:                 ENDIF
8689:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8690:                     loc_oPg.txt_4c_Dfors.Value = ""
8691:                 ENDIF
8692:             ENDIF
8693: 
8694:             IF USED("cursor_4c_For")
8695:                 USE IN cursor_4c_For
8696:             ENDIF
8697:             loc_oBusca.Release()
8698:         CATCH TO loc_oErro
8699:             MsgErro("Erro no lookup de fornecedor:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupFornecedor")
8700:         ENDTRY
8701:     ENDPROC
8702: 
8703:     *--------------------------------------------------------------------------
8704:     * TabPrincipal_CproeqsKeyPress - F4 no campo Produto Equivalente
8705:     *--------------------------------------------------------------------------
8706:     PROCEDURE TabPrincipal_CproeqsKeyPress
8707:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8708:         IF par_nKeyCode = 115
8709:             THIS.AbrirLookupEquivalente()
8710:         ENDIF
8711:     ENDPROC
8712: 
8713:     *--------------------------------------------------------------------------
8714:     * AbrirLookupEquivalente - Abre FormBuscaAuxiliar para produto equivalente
8715:     *--------------------------------------------------------------------------
8716:     PROTECTED PROCEDURE AbrirLookupEquivalente()
8717:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8718:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8719:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5), ALLTRIM(loc_oPg.txt_4c_Cproeqs.Value), "")
8720: 
8721:         TRY
8722:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Eq", "cpros", loc_cVal, "Selecionar Produto Equivalente")
8723:             loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
8724:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
8725:             loc_oBusca.Show()
8726: 
8727:             IF loc_oBusca.this_lSelecionou
8728:                 IF USED("cursor_4c_Eq")
8729:                     IF PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5)
8730:                         loc_oPg.txt_4c_Cproeqs.Value = ALLTRIM(cursor_4c_Eq.cpros)
8731:                     ENDIF
8732:                 ENDIF
8733:             ELSE
8734:                 IF PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5)
8735:                     loc_oPg.txt_4c_Cproeqs.Value = ""
8736:                 ENDIF
8737:             ENDIF
8738: 
8739:             IF USED("cursor_4c_Eq")
8740:                 USE IN cursor_4c_Eq
8741:             ENDIF
8742:             loc_oBusca.Release()
8743:         CATCH TO loc_oErro
8744:             MsgErro("Erro no lookup de equivalente:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupEquivalente")
8745:         ENDTRY
8746:     ENDPROC
8747: 
8748:     *--------------------------------------------------------------------------
8749:     * TabPrincipal_MoeKeyPress - F4 nos campos de moeda abre lookup
8750:     *--------------------------------------------------------------------------
8751:     PROCEDURE TabPrincipal_MoeKeyPress
8752:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8753:         IF par_nKeyCode = 115
8754:             THIS.AbrirLookupMoeda()
8755:         ENDIF
8756:     ENDPROC
8757: 
8758:     *--------------------------------------------------------------------------
8759:     * TabPrincipal_MoeLostFocus - LostFocus nos campos de moeda (sem acao)
8760:     * Validacao de moeda ocorre no BO.Validar() ao salvar
8761:     *--------------------------------------------------------------------------
8762:     PROCEDURE TabPrincipal_MoeLostFocus()
8763:         RETURN
8764:     ENDPROC
8765: 
8766:     *--------------------------------------------------------------------------
8767:     * AbrirLookupMoeda - Abre FormBuscaAuxiliar para selecionar moeda
8768:     *--------------------------------------------------------------------------
8769:     PROTECTED PROCEDURE AbrirLookupMoeda()
8770:         LOCAL loc_oBusca, loc_oPg, loc_cMoeCod
8771:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8772: 
8773:         TRY
8774:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", "cursor_4c_Moe", "CMoes", "", "Selecionar Moeda")
8775:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
8776:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
8777:             loc_oBusca.Show()
8778: 
8779:             IF loc_oBusca.this_lSelecionou
8780:                 IF USED("cursor_4c_Moe")
8781:                     loc_cMoeCod = ALLTRIM(cursor_4c_Moe.CMoes)
8782:                     *-- Aplicar ao campo de moeda que nao estiver ReadOnly
8783:                     IF PEMSTATUS(loc_oPg, "txt_4c_Moecs", 5)
8784:                         IF !loc_oPg.txt_4c_Moecs.ReadOnly
8785:                             loc_oPg.txt_4c_Moecs.Value = loc_cMoeCod
8786:                         ENDIF
8787:                     ENDIF
8788:                     IF PEMSTATUS(loc_oPg, "txt_4c_Moepvs", 5)
8789:                         IF !loc_oPg.txt_4c_Moepvs.ReadOnly
8790:                             loc_oPg.txt_4c_Moepvs.Value = loc_cMoeCod
8791:                         ENDIF
8792:                     ENDIF
8793:                 ENDIF
8794:             ENDIF
8795: 
8796:             IF USED("cursor_4c_Moe")
8797:                 USE IN cursor_4c_Moe
8798:             ENDIF
8799:             loc_oBusca.Release()
8800:         CATCH TO loc_oErro
8801:             MsgErro("Erro no lookup de moeda:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupMoeda")
8802:         ENDTRY
8803:     ENDPROC
8804: 
8805:     *--------------------------------------------------------------------------
8806:     * TabPrincipal_CunisKeyPress - F4 no campo Unidade 1 abre lookup
8807:     *--------------------------------------------------------------------------
8808:     PROCEDURE TabPrincipal_CunisKeyPress
8809:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8810:         IF par_nKeyCode = 115
8811:             THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunis", "txt_4c_Dunis")
8812:         ENDIF
8813:     ENDPROC
8814: 
8815:     *--------------------------------------------------------------------------
8816:     * TabPrincipal_CunisLostFocus - LostFocus valida unidade 1
8817:     *--------------------------------------------------------------------------
8818:     PROCEDURE TabPrincipal_CunisLostFocus()
8819:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8820:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8821:         IF !PEMSTATUS(loc_oPg, "txt_4c_Cunis", 5)
8822:             RETURN
8823:         ENDIF
8824:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunis.Value)
8825: 
8826:         IF EMPTY(loc_cCod)
8827:             IF PEMSTATUS(loc_oPg, "txt_4c_Dunis", 5)
8828:                 loc_oPg.txt_4c_Dunis.Value = ""
8829:             ENDIF
8830:             RETURN
8831:         ENDIF
8832: 
8833:         TRY
8834:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8835:                 SELECT TOP 1 cunis, dunis FROM SigCdUni WHERE cunis = <<EscaparSQL(loc_cCod)>>
8836:             ENDTEXT
8837:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VUni")
8838:             IF loc_nR > 0 AND !EOF("cursor_4c_VUni")
8839:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dunis", 5)
8840:                     loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_VUni.dunis)
8841:                 ENDIF
8842:             ELSE
8843:                 THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunis", "txt_4c_Dunis")
8844:             ENDIF
8845:             IF USED("cursor_4c_VUni")
8846:                 USE IN cursor_4c_VUni
8847:             ENDIF
8848:         CATCH TO loc_oErro
8849:             MsgErro("Erro ao validar unidade:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CunisLostFocus")
8850:         ENDTRY
8851:     ENDPROC
8852: 
8853:     *--------------------------------------------------------------------------
8854:     * TabPrincipal_CunipsKeyPress - F4 no campo Unidade 2 abre lookup
8855:     *--------------------------------------------------------------------------
8856:     PROCEDURE TabPrincipal_CunipsKeyPress
8857:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8858:         IF par_nKeyCode = 115
8859:             THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunips", "txt_4c_Dunips")
8860:         ENDIF
8861:     ENDPROC
8862: 
8863:     *--------------------------------------------------------------------------
8864:     * TabPrincipal_CunipsLostFocus - LostFocus valida unidade 2
8865:     *--------------------------------------------------------------------------
8866:     PROCEDURE TabPrincipal_CunipsLostFocus()
8867:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8868:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8869:         IF !PEMSTATUS(loc_oPg, "txt_4c_Cunips", 5)
8870:             RETURN
8871:         ENDIF
8872:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunips.Value)
8873: 
8874:         IF EMPTY(loc_cCod)
8875:             IF PEMSTATUS(loc_oPg, "txt_4c_Dunips", 5)
8876:                 loc_oPg.txt_4c_Dunips.Value = ""
8877:             ENDIF
8878:             RETURN
8879:         ENDIF
8880: 
8881:         TRY
8882:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8883:                 SELECT TOP 1 cunis, dunis FROM SigCdUni WHERE cunis = <<EscaparSQL(loc_cCod)>>
8884:             ENDTEXT
8885:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VUn2")
8886:             IF loc_nR > 0 AND !EOF("cursor_4c_VUn2")
8887:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dunips", 5)
8888:                     loc_oPg.txt_4c_Dunips.Value = ALLTRIM(cursor_4c_VUn2.dunis)
8889:                 ENDIF
8890:             ELSE
8891:                 THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunips", "txt_4c_Dunips")
8892:             ENDIF
8893:             IF USED("cursor_4c_VUn2")
8894:                 USE IN cursor_4c_VUn2
8895:             ENDIF
8896:         CATCH TO loc_oErro
8897:             MsgErro("Erro ao validar unidade 2:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CunipsLostFocus")
8898:         ENDTRY
8899:     ENDPROC
8900: 
8901:     *--------------------------------------------------------------------------
8902:     * AbrirLookupUnidade - Abre FormBuscaAuxiliar para selecionar unidade
8903:     * par_cKeyField: campo chave na SigCdUni
8904:     * par_cTxtCode: nome do TextBox de codigo na Page1
8905:     * par_cTxtDesc: nome do TextBox de descricao na Page1
8906:     *--------------------------------------------------------------------------
8907:     PROTECTED PROCEDURE AbrirLookupUnidade(par_cKeyField, par_cTxtCode, par_cTxtDesc)
8908:         LOCAL loc_oBusca, loc_oPg, loc_cVal, loc_cTxtCodeRef, loc_cTxtDescRef
8909:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8910:         loc_cVal = IIF(PEMSTATUS(loc_oPg, par_cTxtCode, 5), ALLTRIM(loc_oPg.&par_cTxtCode..Value), "")
8911: 
8912:         TRY
8913:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUni", "cursor_4c_Uni", par_cKeyField, loc_cVal, "Selecionar Unidade")
8914:             loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
8915:             loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
8916:             loc_oBusca.Show()
8917: 
8918:             IF loc_oBusca.this_lSelecionou
8919:                 IF USED("cursor_4c_Uni")
8920:                     IF PEMSTATUS(loc_oPg, par_cTxtCode, 5)
8921:                         loc_oPg.&par_cTxtCode..Value = ALLTRIM(cursor_4c_Uni.cunis)
8922:                     ENDIF
8923:                     IF PEMSTATUS(loc_oPg, par_cTxtDesc, 5)
8924:                         loc_oPg.&par_cTxtDesc..Value = ALLTRIM(cursor_4c_Uni.dunis)
8925:                     ENDIF
8926:                 ENDIF
8927:             ELSE
8928:                 IF PEMSTATUS(loc_oPg, par_cTxtCode, 5)
8929:                     loc_oPg.&par_cTxtCode..Value = ""
8930:                 ENDIF
8931:                 IF PEMSTATUS(loc_oPg, par_cTxtDesc, 5)
8932:                     loc_oPg.&par_cTxtDesc..Value = ""
8933:                 ENDIF
8934:             ENDIF
8935: 
8936:             IF USED("cursor_4c_Uni")
8937:                 USE IN cursor_4c_Uni
8938:             ENDIF
8939:             loc_oBusca.Release()
8940:         CATCH TO loc_oErro
8941:             MsgErro("Erro no lookup de unidade:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupUnidade")
8942:         ENDTRY
8943:     ENDPROC
8944: 
8945:     *--------------------------------------------------------------------------
8946:     * TabPrincipal_CodacbsKeyPress - F4 no campo Acabamento abre lookup
8947:     *--------------------------------------------------------------------------
8948:     PROCEDURE TabPrincipal_CodacbsKeyPress
8949:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8950:         IF par_nKeyCode = 115
8951:             THIS.AbrirLookupAcabamento()
8952:         ENDIF
8953:     ENDPROC
8954: 
8955:     *--------------------------------------------------------------------------
8956:     * TabPrincipal_CodacbsLostFocus - LostFocus valida acabamento
8957:     *--------------------------------------------------------------------------
8958:     PROCEDURE TabPrincipal_CodacbsLostFocus()
8959:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8960:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8961:         IF !PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
8962:             RETURN
8963:         ENDIF
8964:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codacbs.Value)
8965: 
8966:         IF EMPTY(loc_cCod)
8967:             IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
8968:                 loc_oPg.txt_4c_Dcodacbs.Value = ""
8969:             ENDIF
8970:             RETURN
8971:         ENDIF
8972: 
8973:         TRY
8974:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8975:                 SELECT TOP 1 cods, descrs FROM SigCdAca WHERE cods = <<EscaparSQL(loc_cCod)>>
8976:             ENDTEXT
8977:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VAcb")
8978:             IF loc_nR > 0 AND !EOF("cursor_4c_VAcb")
8979:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
8980:                     loc_oPg.txt_4c_Dcodacbs.Value = ALLTRIM(cursor_4c_VAcb.descrs)
8981:                 ENDIF
8982:             ELSE
8983:                 THIS.AbrirLookupAcabamento()
8984:             ENDIF
8985:             IF USED("cursor_4c_VAcb")
8986:                 USE IN cursor_4c_VAcb
8987:             ENDIF
8988:         CATCH TO loc_oErro
8989:             MsgErro("Erro ao validar acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CodacbsLostFocus")
8990:         ENDTRY
8991:     ENDPROC
8992: 
8993:     *--------------------------------------------------------------------------
8994:     * AbrirLookupAcabamento - Abre FormBuscaAuxiliar para selecionar acabamento
8995:     *--------------------------------------------------------------------------
8996:     PROTECTED PROCEDURE AbrirLookupAcabamento()
8997:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8998:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8999:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5), ALLTRIM(loc_oPg.txt_4c_Codacbs.Value), "")
9000: 
9001:         TRY
9002:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdAca", "cursor_4c_Acb", "cods", loc_cVal, "Selecionar Acabamento")
9003:             loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
9004:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
9005:             loc_oBusca.Show()
9006: 
9007:             IF loc_oBusca.this_lSelecionou
9008:                 IF USED("cursor_4c_Acb")
9009:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
9010:                         loc_oPg.txt_4c_Codacbs.Value  = ALLTRIM(cursor_4c_Acb.cods)
9011:                     ENDIF
9012:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
9013:                         loc_oPg.txt_4c_Dcodacbs.Value = ALLTRIM(cursor_4c_Acb.descrs)
9014:                     ENDIF
9015:                 ENDIF
9016:             ELSE
9017:                 IF PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
9018:                     loc_oPg.txt_4c_Codacbs.Value  = ""
9019:                 ENDIF
9020:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
9021:                     loc_oPg.txt_4c_Dcodacbs.Value = ""
9022:                 ENDIF
9023:             ENDIF
9024: 
9025:             IF USED("cursor_4c_Acb")
9026:                 USE IN cursor_4c_Acb
9027:             ENDIF
9028:             loc_oBusca.Release()
9029:         CATCH TO loc_oErro
9030:             MsgErro("Erro no lookup de acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupAcabamento")
9031:         ENDTRY
9032:     ENDPROC
9033: 
9034:     *--------------------------------------------------------------------------
9035:     * TabPrincipal_CodcorsKeyPress - F4 no campo Cor abre lookup
9036:     *--------------------------------------------------------------------------
9037:     PROCEDURE TabPrincipal_CodcorsKeyPress
9038:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9039:         IF par_nKeyCode = 115
9040:             THIS.AbrirLookupCor()
9041:         ENDIF
9042:     ENDPROC
9043: 
9044:     *--------------------------------------------------------------------------
9045:     * TabPrincipal_CodcorsLostFocus - LostFocus valida cor
9046:     *--------------------------------------------------------------------------
9047:     PROCEDURE TabPrincipal_CodcorsLostFocus()
9048:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
9049:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9050:         IF !PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
9051:             RETURN
9052:         ENDIF
9053:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codcors.Value)
9054: 
9055:         IF EMPTY(loc_cCod)
9056:             RETURN
9057:         ENDIF
9058: 
9059:         TRY
9060:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9061:                 SELECT TOP 1 cods FROM SigCdCor WHERE cods = <<EscaparSQL(loc_cCod)>>
9062:             ENDTEXT
9063:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCor")
9064:             IF loc_nR <= 0
9065:                 THIS.AbrirLookupCor()
9066:             ELSE
9067:                 IF EOF("cursor_4c_VCor")
9068:                     THIS.AbrirLookupCor()
9069:                 ENDIF
9070:             ENDIF
9071:             IF USED("cursor_4c_VCor")
9072:                 USE IN cursor_4c_VCor
9073:             ENDIF
9074:         CATCH TO loc_oErro
9075:             MsgErro("Erro ao validar cor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CodcorsLostFocus")
9076:         ENDTRY
9077:     ENDPROC
9078: 
9079:     *--------------------------------------------------------------------------
9080:     * AbrirLookupCor - Abre FormBuscaAuxiliar para selecionar cor
9081:     *--------------------------------------------------------------------------
9082:     PROTECTED PROCEDURE AbrirLookupCor()
9083:         LOCAL loc_oBusca, loc_oPg, loc_cVal
9084:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9085:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5), ALLTRIM(loc_oPg.txt_4c_Codcors.Value), "")
9086: 
9087:         TRY
9088:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCor", "cursor_4c_Cor", "cods", loc_cVal, "Selecionar Cor")
9089:             loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
9090:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9091:             loc_oBusca.Show()
9092: 
9093:             IF loc_oBusca.this_lSelecionou
9094:                 IF USED("cursor_4c_Cor")
9095:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
9096:                         loc_oPg.txt_4c_Codcors.Value = ALLTRIM(cursor_4c_Cor.cods)
9097:                     ENDIF
9098:                 ENDIF
9099:             ELSE
9100:                 IF PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
9101:                     loc_oPg.txt_4c_Codcors.Value = ""
9102:                 ENDIF
9103:             ENDIF
9104: 
9105:             IF USED("cursor_4c_Cor")
9106:                 USE IN cursor_4c_Cor
9107:             ENDIF
9108:             loc_oBusca.Release()
9109:         CATCH TO loc_oErro
9110:             MsgErro("Erro no lookup de cor:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupCor")
9111:         ENDTRY
9112:     ENDPROC
9113: 
9114:     *--------------------------------------------------------------------------
9115:     * TabPrincipal_CodtamsKeyPress - F4 no campo Tamanho abre lookup
9116:     *--------------------------------------------------------------------------
9117:     PROCEDURE TabPrincipal_CodtamsKeyPress
9118:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9119:         IF par_nKeyCode = 115
9120:             THIS.AbrirLookupTamanho()
9121:         ENDIF
9122:     ENDPROC
9123: 
9124:     *--------------------------------------------------------------------------
9125:     * AbrirLookupTamanho - Abre FormBuscaAuxiliar para selecionar tamanho
9126:     *--------------------------------------------------------------------------
9127:     PROTECTED PROCEDURE AbrirLookupTamanho()
9128:         LOCAL loc_oBusca, loc_oPg, loc_cVal
9129:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9130:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5), ALLTRIM(loc_oPg.txt_4c_Codtams.Value), "")
9131: 
9132:         TRY
9133:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", "cursor_4c_Tam", "cods", loc_cVal, "Selecionar Tamanho")
9134:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9135:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9136:             loc_oBusca.Show()
9137: 
9138:             IF loc_oBusca.this_lSelecionou
9139:                 IF USED("cursor_4c_Tam")
9140:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5)
9141:                         loc_oPg.txt_4c_Codtams.Value = ALLTRIM(cursor_4c_Tam.cods)
9142:                     ENDIF
9143:                 ENDIF
9144:             ELSE
9145:                 IF PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5)
9146:                     loc_oPg.txt_4c_Codtams.Value = ""
9147:                 ENDIF
9148:             ENDIF
9149: 
9150:             IF USED("cursor_4c_Tam")
9151:                 USE IN cursor_4c_Tam
9152:             ENDIF
9153:             loc_oBusca.Release()
9154:         CATCH TO loc_oErro
9155:             MsgErro("Erro no lookup de tamanho:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupTamanho")
9156:         ENDTRY
9157:     ENDPROC
9158: 
9159:     *--------------------------------------------------------------------------
9160:     * CarregarDesc - Helper: carrega descricao de um campo lookup via SQL
9161:     * Retorna "" se nao encontrado ou valor vazio
9162:     *--------------------------------------------------------------------------
9163:     PROTECTED FUNCTION CarregarDesc(par_cTabela, par_cCampoChave, par_cValor, par_cCampoDesc)
9164:         LOCAL loc_cDesc, loc_cSQL, loc_nR, loc_cAliasField
9165:         loc_cDesc = ""
9166: 
9167:         IF !EMPTY(par_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
9168:             TRY
9169:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9170:                     SELECT TOP 1 <<par_cCampoDesc>> FROM <<par_cTabela>> WHERE <<par_cCampoChave>> = <<EscaparSQL(par_cValor)>>
9171:                 ENDTEXT
9172:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescH")
9173:                 IF loc_nR > 0 AND !EOF("cursor_4c_DescH")

*-- Linhas 9189 a 9232:
9189:     * CarregarComposicao - Carrega grid de composicao (Tab 2)
9190:     * Tabela: SIGPRCPO JOIN SigCdPro
9191:     *--------------------------------------------------------------------------
9192:     PROTECTED PROCEDURE CarregarComposicao()
9193:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
9194:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9195:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9196: 
9197:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9198:             RETURN
9199:         ENDIF
9200: 
9201:         TRY
9202:             *-- Composicao principal
9203:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9204:                 SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9205:                        c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9206:                        c.qtdcvs, c.cunips, c.ordems, c.compos
9207:                 FROM SIGPRCPO c
9208:                 LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9209:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9210:                 ORDER BY c.ordems
9211:             ENDTEXT
9212:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoTmp")
9213:             IF loc_nR > 0
9214:                 IF USED("cursor_4c_Compo")
9215:                     SELECT cursor_4c_Compo
9216:                     ZAP
9217:                     APPEND FROM DBF("cursor_4c_CompoTmp")
9218:                 ENDIF
9219:                 IF USED("cursor_4c_CompoTmp")
9220:                     USE IN cursor_4c_CompoTmp
9221:                 ENDIF
9222:                 IF PEMSTATUS(loc_oPg, "grd_4c_Compo", 5)
9223:                     loc_oPg.grd_4c_Compo.Refresh()
9224:                 ENDIF
9225:             ENDIF
9226: 
9227:             *-- Sub-composicao
9228:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9229:                 SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9230:                        c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9231:                        c.qtdcvs, c.cunips, c.ordems, c.matsubs, c.codtams
9232:                 FROM sigsubcp c

*-- Linhas 9259 a 9302:
9259:     * GrdCons: SIGPRCPO JOIN SigCdPrf(fase) JOIN SigCdCat(categoria)
9260:     * grDTEMP:  SIGPRCPO agrupado por fase (consumo total)
9261:     *--------------------------------------------------------------------------
9262:     PROTECTED PROCEDURE CarregarConsultaP()
9263:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_nCount, loc_oPg
9264:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9265:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9266: 
9267:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9268:             RETURN
9269:         ENDIF
9270: 
9271:         TRY
9272:             *-- Carregar componentes com descricao de fase e categoria
9273:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9274:                 SELECT c.mats, c.qtds, c.unicompos, c.grupos,
9275:                        ISNULL((SELECT TOP 1 g.Descrs FROM SigCdGcr g WHERE RTRIM(g.Codigos) = RTRIM(c.grupos)), '') AS dcompos,
9276:                        c.ordems, c.qtscons, c.cats,
9277:                        ISNULL(cat.descs, '') AS dscgrp
9278:                 FROM SIGPRCPO c
9279:                 LEFT JOIN SigCdCat cat ON RTRIM(c.cats) = RTRIM(cat.cods)
9280:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9281:                 ORDER BY c.ordems, c.mats
9282:             ENDTEXT
9283:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaTmp")
9284:             IF loc_nR > 0
9285:                 IF USED("cursor_4c_Consulta")
9286:                     SELECT cursor_4c_Consulta
9287:                     ZAP
9288:                     APPEND FROM DBF("cursor_4c_ConsultaTmp")
9289:                 ENDIF
9290:                 IF USED("cursor_4c_ConsultaTmp")
9291:                     USE IN cursor_4c_ConsultaTmp
9292:                 ENDIF
9293:                 *-- Atualizar contagem de componentes
9294:                 loc_nCount = RECCOUNT("cursor_4c_Consulta")
9295:                 IF PEMSTATUS(loc_oPg, "txt_4c_QtdCpnt", 5)
9296:                     loc_oPg.txt_4c_QtdCpnt.Value = loc_nCount
9297:                 ENDIF
9298:                 IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
9299:                     loc_oPg.grd_4c_Consulta.Refresh()
9300:                 ENDIF
9301:             ENDIF
9302: 

*-- Linhas 9334 a 9377:
9334:     * CarregarCustos - Carrega grid de custo da composicao (Tab 3 - pgCusto)
9335:     * Tabela: SIGPRCPO filtrado por Tipos (tipo de calculo de custo)
9336:     *--------------------------------------------------------------------------
9337:     PROTECTED PROCEDURE CarregarCustos()
9338:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg, loc_nTipo
9339:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9340:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9341: 
9342:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9343:             RETURN
9344:         ENDIF
9345: 
9346:         TRY
9347:             *-- Obter tipo selecionado no combo (0=Todos, 1/2/3=tipo especifico)
9348:             loc_nTipo = 0
9349:             IF PEMSTATUS(loc_oPg, "cmb_4c_TiposCusto", 5)
9350:                 loc_nTipo = NVL(loc_oPg.cmb_4c_TiposCusto.ListIndex, 1) - 1
9351:             ENDIF
9352: 
9353:             *-- Composicao de custo
9354:             IF loc_nTipo = 0
9355:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9356:                     SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9357:                            c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9358:                            c.qtdcvs, c.cunips
9359:                     FROM SIGPRCPO c
9360:                     LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9361:                     WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9362:                     AND c.tipos IS NOT NULL
9363:                     ORDER BY c.mats
9364:                 ENDTEXT
9365:             ELSE
9366:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9367:                     SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9368:                            c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9369:                            c.qtdcvs, c.cunips
9370:                     FROM SIGPRCPO c
9371:                     LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9372:                     WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9373:                     AND c.tipos = <<TRANSFORM(loc_nTipo)>>
9374:                     ORDER BY c.mats
9375:                 ENDTEXT
9376:             ENDIF
9377: 

*-- Linhas 9445 a 9488:
9445:     * CarregarFases - Carrega grid de fases (Tab 7)
9446:     * Tabela: SigCdPrf
9447:     *--------------------------------------------------------------------------
9448:     PROTECTED PROCEDURE CarregarFases()
9449:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg, loc_oBO
9450:         loc_oBO    = THIS.this_oBusinessObject
9451:         loc_cCpros = ALLTRIM(loc_oBO.this_cCpros)
9452:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
9453: 
9454:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9455:             RETURN
9456:         ENDIF
9457: 
9458:         TRY
9459:             *-- Fases de producao
9460:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9461:                 SELECT ordems, grupos, minutos, uniprdts, matprdts
9462:                 FROM SigCdPrf
9463:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9464:                 ORDER BY ordems
9465:             ENDTEXT
9466:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FasesTmp")
9467:             IF loc_nR > 0
9468:                 IF USED("cursor_4c_Fases")
9469:                     SELECT cursor_4c_Fases
9470:                     ZAP
9471:                     APPEND FROM DBF("cursor_4c_FasesTmp")
9472:                 ENDIF
9473:                 IF USED("cursor_4c_FasesTmp")
9474:                     USE IN cursor_4c_FasesTmp
9475:                 ENDIF
9476:                 IF PEMSTATUS(loc_oPg, "grd_4c_Fases", 5)
9477:                     loc_oPg.grd_4c_Fases.Refresh()
9478:                 ENDIF
9479:             ENDIF
9480: 
9481:             *-- Matrizes
9482:             THIS.CarregarMatrizes()
9483: 
9484:             *-- Preencher campos do BO nas textboxes da tab
9485:             IF PEMSTATUS(loc_oPg, "txt_4c_Qminfab", 5)
9486:                 loc_oPg.txt_4c_Qminfab.Value   = loc_oBO.this_nQtminfabs
9487:             ENDIF
9488:             IF PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)

*-- Linhas 9528 a 9571:
9528:     * CarregarMatrizes - Carrega grid de matrizes (Tab 7 - sub-grid)
9529:     * Tabela: SigPrMtz JOIN SigCdPro (para Locals)
9530:     *--------------------------------------------------------------------------
9531:     PROTECTED PROCEDURE CarregarMatrizes()
9532:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
9533:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9534:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
9535: 
9536:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9537:             RETURN
9538:         ENDIF
9539: 
9540:         TRY
9541:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9542:                 SELECT a.cidchaves, a.cmats, a.cpros, a.qtds, b.locals
9543:                 FROM SigPrMtz a
9544:                 INNER JOIN SigCdPro b ON RTRIM(a.cmats) = RTRIM(b.cpros)
9545:                 WHERE RTRIM(a.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9546:             ENDTEXT
9547:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatrizesTmp")
9548:             IF loc_nR > 0
9549:                 IF USED("cursor_4c_Matrizes")
9550:                     SELECT cursor_4c_Matrizes
9551:                     ZAP
9552:                     APPEND FROM DBF("cursor_4c_MatrizesTmp")
9553:                 ENDIF
9554:                 IF USED("cursor_4c_MatrizesTmp")
9555:                     USE IN cursor_4c_MatrizesTmp
9556:                 ENDIF
9557:                 IF PEMSTATUS(loc_oPg, "grd_4c_Matrizes", 5)
9558:                     loc_oPg.grd_4c_Matrizes.Refresh()
9559:                 ENDIF
9560:             ENDIF
9561: 
9562:         CATCH TO loc_oErro
9563:             MsgErro("Erro ao carregar matrizes:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarMatrizes")
9564:         ENDTRY
9565:     ENDPROC
9566: 
9567:     *--------------------------------------------------------------------------
9568:     * CarregarDescSgru - Carrega descricao do subgrupo (SigCdPsg com filtro grupo)
9569:     *--------------------------------------------------------------------------
9570:     PROTECTED FUNCTION CarregarDescSgru(par_cCgrus, par_cSgrus)
9571:         LOCAL loc_cDesc, loc_cSQL, loc_nR

*-- Linhas 9596 a 10605:
9596:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
9597:     * par_nPagina: 1=Lista, 2=Dados
9598:     *--------------------------------------------------------------------------
9599:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
9600:         LOCAL loc_lResultado
9601:         loc_lResultado = .F.
9602: 
9603:         TRY
9604:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
9605:                 loc_lResultado = .F.
9606:             ELSE
9607:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
9608: 
9609:                 IF par_nPagina = 1
9610:                     THIS.CarregarLista()
9611:                 ENDIF
9612: 
9613:                 loc_lResultado = .T.
9614:             ENDIF
9615: 
9616:         CATCH TO loc_oErro
9617:             MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, "FormProduto.AlternarPagina")
9618:             loc_lResultado = .F.
9619:         ENDTRY
9620: 
9621:         RETURN loc_lResultado
9622:     ENDPROC
9623: 
9624:     *--------------------------------------------------------------------------
9625:     * TabFiscal_ClfiscalKeyPress - F4 no campo Classif. Fiscal abre lookup
9626:     *--------------------------------------------------------------------------
9627:     PROCEDURE TabFiscal_ClfiscalKeyPress
9628:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9629:         IF par_nKeyCode = 115
9630:             THIS.AbrirLookupClassFiscal()
9631:         ENDIF
9632:     ENDPROC
9633: 
9634:     *--------------------------------------------------------------------------
9635:     * AbrirLookupClassFiscal - Abre FormBuscaAuxiliar para Classif. Fiscal
9636:     * Tabela: SigCdClf | Chave: clfiscals | Desc: dclfiscals
9637:     *--------------------------------------------------------------------------
9638:     PROTECTED PROCEDURE AbrirLookupClassFiscal()
9639:         LOCAL loc_oBusca, loc_oPg, loc_cVal
9640:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9641:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5), ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value), "")
9642: 
9643:         TRY
9644:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", "cursor_4c_Clf", "clfiscals", loc_cVal, "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
9645:             loc_oBusca.mAddColuna("clfiscals",  "", "C" + CHR(243) + "digo")
9646:             loc_oBusca.mAddColuna("dclfiscals", "", "Descri" + CHR(231) + CHR(227) + "o")
9647:             loc_oBusca.Show()
9648: 
9649:             IF loc_oBusca.this_lSelecionou
9650:                 IF USED("cursor_4c_Clf")
9651:                     IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9652:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_Clf.clfiscals)
9653:                     ENDIF
9654:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9655:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_Clf.dclfiscals)
9656:                     ENDIF
9657:                 ENDIF
9658:             ELSE
9659:                 IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9660:                     loc_oPg.txt_4c_Clfiscal.Value  = ""
9661:                 ENDIF
9662:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9663:                     loc_oPg.txt_4c_Dclfiscal.Value = ""
9664:                 ENDIF
9665:             ENDIF
9666: 
9667:             IF USED("cursor_4c_Clf")
9668:                 USE IN cursor_4c_Clf
9669:             ENDIF
9670:             loc_oBusca.Release()
9671:         CATCH TO loc_oErro
9672:             MsgErro("Erro no lookup de classifica" + CHR(231) + CHR(227) + "o fiscal:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupClassFiscal")
9673:         ENDTRY
9674:     ENDPROC
9675: 
9676:     *--------------------------------------------------------------------------
9677:     * TabFiscal_MetalKeyPress - KeyPress no campo Metal (sem lookup auxiliar)
9678:     * Metal e Teor sao campos de classificacao IPI preenchidos manualmente
9679:     *--------------------------------------------------------------------------
9680:     PROCEDURE TabFiscal_MetalKeyPress
9681:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9682:         *-- Sem lookup: Metal e Teor sao codigos livres no contexto IPI
9683:     ENDPROC
9684: 
9685:     *--------------------------------------------------------------------------
9686:     * TabFiscal_TeorKeyPress - KeyPress no campo Teor (sem lookup auxiliar)
9687:     *--------------------------------------------------------------------------
9688:     PROCEDURE TabFiscal_TeorKeyPress
9689:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9690:         *-- Sem lookup: Teor e codigo livre no contexto IPI
9691:     ENDPROC
9692: 
9693:     *--------------------------------------------------------------------------
9694:     * ValidarClfiscal - LostFocus no campo Classificacao Fiscal
9695:     * Tabela: SigCdClf | Chave: Codigos | Desc: Descricaos
9696:     * Ao selecionar, popula AliqIPI com aliqipis da classificacao
9697:     *--------------------------------------------------------------------------
9698:     PROCEDURE ValidarClfiscal()
9699:         LOCAL loc_oPg, loc_cVal
9700:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9701:         IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9702:             RETURN
9703:         ENDIF
9704:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
9705: 
9706:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltClassFiscal
9707:             RETURN
9708:         ENDIF
9709:         THIS.this_cUltClassFiscal = loc_cVal
9710: 
9711:         TRY
9712:             LOCAL loc_oBusca, loc_cSQL, loc_nR
9713:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", "cursor_4c_ClfV", "Codigos", loc_cVal, "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
9714:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
9715:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
9716:             loc_oBusca.Show()
9717: 
9718:             IF loc_oBusca.this_lSelecionou
9719:                 IF USED("cursor_4c_ClfV")
9720:                     IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9721:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_ClfV.Codigos)
9722:                     ENDIF
9723:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9724:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfV.Descricaos)
9725:                     ENDIF
9726:                     *-- Popula AliqIPI com aliqipis da classificacao fiscal
9727:                     IF PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5)
9728:                         TEXT TO loc_cSQL TEXTMERGE NOSHOW
9729:                             SELECT aliqipis FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(ALLTRIM(cursor_4c_ClfV.Codigos))>>)
9730:                         ENDTEXT
9731:                         loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfAliq")
9732:                         IF loc_nR > 0 AND !EOF("cursor_4c_ClfAliq")
9733:                             loc_oPg.txt_4c_AliqIPI.Value = cursor_4c_ClfAliq.aliqipis
9734:                         ENDIF
9735:                         IF USED("cursor_4c_ClfAliq")
9736:                             USE IN cursor_4c_ClfAliq
9737:                         ENDIF
9738:                     ENDIF
9739:                 ENDIF
9740:             ELSE
9741:                 IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9742:                     loc_oPg.txt_4c_Clfiscal.Value  = ""
9743:                 ENDIF
9744:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9745:                     loc_oPg.txt_4c_Dclfiscal.Value = ""
9746:                 ENDIF
9747:                 THIS.this_cUltClassFiscal = ""
9748:             ENDIF
9749: 
9750:             IF USED("cursor_4c_ClfV")
9751:                 USE IN cursor_4c_ClfV
9752:             ENDIF
9753:             loc_oBusca.Release()
9754:         CATCH TO loc_oErro
9755:             MsgErro("Erro ao validar classifica" + CHR(231) + CHR(227) + "o fiscal:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarClfiscal")
9756:         ENDTRY
9757:     ENDPROC
9758: 
9759:     *--------------------------------------------------------------------------
9760:     * ValidarDclfiscal - LostFocus no campo Descricao Classificacao Fiscal
9761:     * Busca por descricao e preenche codigo
9762:     *--------------------------------------------------------------------------
9763:     PROCEDURE ValidarDclfiscal()
9764:         LOCAL loc_oPg, loc_cVal
9765:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9766:         IF !PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9767:             RETURN
9768:         ENDIF
9769:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value)
9770: 
9771:         *-- So abre busca se o codigo estiver vazio (getDclfiscal.When logic)
9772:         IF EMPTY(loc_cVal)
9773:             RETURN
9774:         ENDIF
9775:         IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9776:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))
9777:                 RETURN
9778:             ENDIF
9779:         ENDIF
9780: 
9781:         TRY
9782:             LOCAL loc_oBusca
9783:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", "cursor_4c_ClfD", "Descricaos", loc_cVal, "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
9784:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
9785:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
9786:             loc_oBusca.Show()
9787: 
9788:             IF loc_oBusca.this_lSelecionou
9789:                 IF USED("cursor_4c_ClfD")
9790:                     IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9791:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_ClfD.Codigos)
9792:                     ENDIF
9793:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9794:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfD.Descricaos)
9795:                     ENDIF
9796:                     THIS.this_cUltClassFiscal = ALLTRIM(cursor_4c_ClfD.Codigos)
9797:                 ENDIF
9798:             ELSE
9799:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9800:                     loc_oPg.txt_4c_Dclfiscal.Value = ""
9801:                 ENDIF
9802:             ENDIF
9803: 
9804:             IF USED("cursor_4c_ClfD")
9805:                 USE IN cursor_4c_ClfD
9806:             ENDIF
9807:             loc_oBusca.Release()
9808:         CATCH TO loc_oErro
9809:             MsgErro("Erro ao buscar classifica" + CHR(231) + CHR(227) + "o fiscal:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDclfiscal")
9810:         ENDTRY
9811:     ENDPROC
9812: 
9813:     *--------------------------------------------------------------------------
9814:     * ValidarOrigmerc - LostFocus no campo Origem Mercadoria
9815:     * Tabela: SigCdOrg | Chave: Codigos | Desc: Descricaos
9816:     *--------------------------------------------------------------------------
9817:     PROCEDURE ValidarOrigmerc()
9818:         LOCAL loc_oPg, loc_cVal
9819:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9820:         IF !PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9821:             RETURN
9822:         ENDIF
9823:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
9824: 
9825:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltOrganizacao
9826:             RETURN
9827:         ENDIF
9828:         THIS.this_cUltOrganizacao = loc_cVal
9829: 
9830:         TRY
9831:             LOCAL loc_oBusca
9832:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOrg", "cursor_4c_Org", "Codigos", loc_cVal, "Origem da Mercadoria")
9833:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
9834:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
9835:             loc_oBusca.Show()
9836: 
9837:             IF loc_oBusca.this_lSelecionou
9838:                 IF USED("cursor_4c_Org")
9839:                     IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9840:                         loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(cursor_4c_Org.Codigos)
9841:                     ENDIF
9842:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9843:                         loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_Org.Descricaos)
9844:                     ENDIF
9845:                 ENDIF
9846:             ELSE
9847:                 IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9848:                     loc_oPg.txt_4c_Origmerc.Value  = ""
9849:                 ENDIF
9850:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9851:                     loc_oPg.txt_4c_Dorigmerc.Value = ""
9852:                 ENDIF
9853:                 THIS.this_cUltOrganizacao = ""
9854:             ENDIF
9855: 
9856:             IF USED("cursor_4c_Org")
9857:                 USE IN cursor_4c_Org
9858:             ENDIF
9859:             loc_oBusca.Release()
9860:         CATCH TO loc_oErro
9861:             MsgErro("Erro ao validar origem da mercadoria:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarOrigmerc")
9862:         ENDTRY
9863:     ENDPROC
9864: 
9865:     *--------------------------------------------------------------------------
9866:     * ValidarDorigmerc - LostFocus no campo Descricao Origem Mercadoria
9867:     * Busca por descricao, preenche codigo (so se codigo estiver vazio)
9868:     *--------------------------------------------------------------------------
9869:     PROCEDURE ValidarDorigmerc()
9870:         LOCAL loc_oPg, loc_cVal
9871:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9872:         IF !PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9873:             RETURN
9874:         ENDIF
9875:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Dorigmerc.Value)
9876: 
9877:         IF EMPTY(loc_cVal)
9878:             RETURN
9879:         ENDIF
9880:         IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9881:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Origmerc.Value))
9882:                 RETURN
9883:             ENDIF
9884:         ENDIF
9885: 
9886:         TRY
9887:             LOCAL loc_oBusca
9888:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOrg", "cursor_4c_OrgD", "Descricaos", loc_cVal, "Origem da Mercadoria")
9889:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
9890:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
9891:             loc_oBusca.Show()
9892: 
9893:             IF loc_oBusca.this_lSelecionou
9894:                 IF USED("cursor_4c_OrgD")
9895:                     IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9896:                         loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(cursor_4c_OrgD.Codigos)
9897:                     ENDIF
9898:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9899:                         loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgD.Descricaos)
9900:                     ENDIF
9901:                     THIS.this_cUltOrganizacao = ALLTRIM(cursor_4c_OrgD.Codigos)
9902:                 ENDIF
9903:             ELSE
9904:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9905:                     loc_oPg.txt_4c_Dorigmerc.Value = ""
9906:                 ENDIF
9907:             ENDIF
9908: 
9909:             IF USED("cursor_4c_OrgD")
9910:                 USE IN cursor_4c_OrgD
9911:             ENDIF
9912:             loc_oBusca.Release()
9913:         CATCH TO loc_oErro
9914:             MsgErro("Erro ao buscar origem mercadoria:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDorigmerc")
9915:         ENDTRY
9916:     ENDPROC
9917: 
9918:     *--------------------------------------------------------------------------
9919:     * ValidarSittricms - LostFocus no campo Situacao Tributaria ICMS
9920:     * Tabela: SigCdIcm | Chave: Codigos | Desc: Descricaos
9921:     *--------------------------------------------------------------------------
9922:     PROCEDURE ValidarSittricms()
9923:         LOCAL loc_oPg, loc_cVal
9924:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9925:         IF !PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
9926:             RETURN
9927:         ENDIF
9928:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Sittricms.Value)
9929: 
9930:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltIcm
9931:             RETURN
9932:         ENDIF
9933:         THIS.this_cUltIcm = loc_cVal
9934: 
9935:         TRY
9936:             LOCAL loc_oBusca
9937:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", "cursor_4c_Icm", "Codigos", loc_cVal, "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
9938:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
9939:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
9940:             loc_oBusca.Show()
9941: 
9942:             IF loc_oBusca.this_lSelecionou
9943:                 IF USED("cursor_4c_Icm")
9944:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
9945:                         loc_oPg.txt_4c_Sittricms.Value  = ALLTRIM(cursor_4c_Icm.Codigos)
9946:                     ENDIF
9947:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
9948:                         loc_oPg.txt_4c_Dsittricms.Value = ALLTRIM(cursor_4c_Icm.Descricaos)
9949:                     ENDIF
9950:                 ENDIF
9951:             ELSE
9952:                 IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
9953:                     loc_oPg.txt_4c_Sittricms.Value  = ""
9954:                 ENDIF
9955:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
9956:                     loc_oPg.txt_4c_Dsittricms.Value = ""
9957:                 ENDIF
9958:                 THIS.this_cUltIcm = ""
9959:             ENDIF
9960: 
9961:             IF USED("cursor_4c_Icm")
9962:                 USE IN cursor_4c_Icm
9963:             ENDIF
9964:             loc_oBusca.Release()
9965:         CATCH TO loc_oErro
9966:             MsgErro("Erro ao validar situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarSittricms")
9967:         ENDTRY
9968:     ENDPROC
9969: 
9970:     *--------------------------------------------------------------------------
9971:     * ValidarDsittricms - LostFocus no campo Descricao Situacao Tributaria ICMS
9972:     * Busca por descricao (so se codigo estiver vazio)
9973:     *--------------------------------------------------------------------------
9974:     PROCEDURE ValidarDsittricms()
9975:         LOCAL loc_oPg, loc_cVal
9976:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9977:         IF !PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
9978:             RETURN
9979:         ENDIF
9980:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Dsittricms.Value)
9981: 
9982:         IF EMPTY(loc_cVal)
9983:             RETURN
9984:         ENDIF
9985:         IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
9986:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Sittricms.Value))
9987:                 RETURN
9988:             ENDIF
9989:         ENDIF
9990: 
9991:         TRY
9992:             LOCAL loc_oBusca
9993:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", "cursor_4c_IcmD", "Descricaos", loc_cVal, "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
9994:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
9995:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
9996:             loc_oBusca.Show()
9997: 
9998:             IF loc_oBusca.this_lSelecionou
9999:                 IF USED("cursor_4c_IcmD")
10000:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10001:                         loc_oPg.txt_4c_Sittricms.Value  = ALLTRIM(cursor_4c_IcmD.Codigos)
10002:                     ENDIF
10003:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10004:                         loc_oPg.txt_4c_Dsittricms.Value = ALLTRIM(cursor_4c_IcmD.Descricaos)
10005:                     ENDIF
10006:                     THIS.this_cUltIcm = ALLTRIM(cursor_4c_IcmD.Codigos)
10007:                 ENDIF
10008:             ELSE
10009:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10010:                     loc_oPg.txt_4c_Dsittricms.Value = ""
10011:                 ENDIF
10012:             ENDIF
10013: 
10014:             IF USED("cursor_4c_IcmD")
10015:                 USE IN cursor_4c_IcmD
10016:             ENDIF
10017:             loc_oBusca.Release()
10018:         CATCH TO loc_oErro
10019:             MsgErro("Erro ao buscar situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDsittricms")
10020:         ENDTRY
10021:     ENDPROC
10022: 
10023:     *--------------------------------------------------------------------------
10024:     * ValidarCodServs - LostFocus no campo Codigo de Servicos ICMS
10025:     * Tabela: SigCdIcm | tambem preenche getSittricm quando seleciona
10026:     *--------------------------------------------------------------------------
10027:     PROCEDURE ValidarCodServs()
10028:         LOCAL loc_oPg, loc_cVal
10029:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10030:         IF !PEMSTATUS(loc_oPg, "txt_4c_CodServs", 5)
10031:             RETURN
10032:         ENDIF
10033:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_CodServs.Value)
10034: 
10035:         IF EMPTY(loc_cVal)
10036:             RETURN
10037:         ENDIF
10038: 
10039:         TRY
10040:             LOCAL loc_oBusca
10041:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", "cursor_4c_CodServ", "Codigos", loc_cVal, "C" + CHR(243) + "digo Servi" + CHR(231) + "os ICMS")
10042:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10043:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10044:             loc_oBusca.Show()
10045: 
10046:             IF loc_oBusca.this_lSelecionou
10047:                 IF USED("cursor_4c_CodServ")
10048:                     IF PEMSTATUS(loc_oPg, "txt_4c_CodServs", 5)
10049:                         loc_oPg.txt_4c_CodServs.Value  = ALLTRIM(cursor_4c_CodServ.Codigos)
10050:                     ENDIF
10051:                     *-- Tambem preenche Sittricms (como no legado)
10052:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10053:                         loc_oPg.txt_4c_Sittricms.Value  = ALLTRIM(cursor_4c_CodServ.Codigos)
10054:                     ENDIF
10055:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10056:                         loc_oPg.txt_4c_Dsittricms.Value = ALLTRIM(cursor_4c_CodServ.Descricaos)
10057:                     ENDIF
10058:                     THIS.this_cUltIcm = ALLTRIM(cursor_4c_CodServ.Codigos)
10059:                 ENDIF
10060:             ELSE
10061:                 IF PEMSTATUS(loc_oPg, "txt_4c_CodServs", 5)
10062:                     loc_oPg.txt_4c_CodServs.Value = ""
10063:                 ENDIF
10064:             ENDIF
10065: 
10066:             IF USED("cursor_4c_CodServ")
10067:                 USE IN cursor_4c_CodServ
10068:             ENDIF
10069:             loc_oBusca.Release()
10070:         CATCH TO loc_oErro
10071:             MsgErro("Erro ao validar c" + CHR(243) + "digo de servi" + CHR(231) + "os:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarCodServs")
10072:         ENDTRY
10073:     ENDPROC
10074: 
10075:     *--------------------------------------------------------------------------
10076:     * ValidarTptribs - LostFocus no campo Tipo de Tributacao
10077:     * Tabela: SigPrTri | Chave: Tipos | Desc: Descs
10078:     *--------------------------------------------------------------------------
10079:     PROCEDURE ValidarTptribs()
10080:         LOCAL loc_oPg, loc_cVal
10081:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10082:         IF !PEMSTATUS(loc_oPg, "txt_4c_Tptribs", 5)
10083:             RETURN
10084:         ENDIF
10085:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Tptribs.Value)
10086: 
10087:         IF EMPTY(loc_cVal)
10088:             RETURN
10089:         ENDIF
10090: 
10091:         TRY
10092:             LOCAL loc_oBusca
10093:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrTri", "cursor_4c_TpTrib", "Tipos", loc_cVal, "Tipo de Tributa" + CHR(231) + CHR(227) + "o")
10094:             loc_oBusca.mAddColuna("Tipos", "", "Tipo")
10095:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10096:             loc_oBusca.Show()
10097: 
10098:             IF loc_oBusca.this_lSelecionou
10099:                 IF USED("cursor_4c_TpTrib")
10100:                     IF PEMSTATUS(loc_oPg, "txt_4c_Tptribs", 5)
10101:                         loc_oPg.txt_4c_Tptribs.Value = ALLTRIM(cursor_4c_TpTrib.Tipos)
10102:                     ENDIF
10103:                 ENDIF
10104:             ELSE
10105:                 IF PEMSTATUS(loc_oPg, "txt_4c_Tptribs", 5)
10106:                     loc_oPg.txt_4c_Tptribs.Value = ""
10107:                 ENDIF
10108:             ENDIF
10109: 
10110:             IF USED("cursor_4c_TpTrib")
10111:                 USE IN cursor_4c_TpTrib
10112:             ENDIF
10113:             loc_oBusca.Release()
10114:         CATCH TO loc_oErro
10115:             MsgErro("Erro ao validar tipo de tributa" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarTptribs")
10116:         ENDTRY
10117:     ENDPROC
10118: 
10119:     *--------------------------------------------------------------------------
10120:     * ValidarIat - LostFocus no campo IAT
10121:     * Aceita apenas: 'A' (arredondamento), 'T' (truncamento) ou vazio
10122:     *--------------------------------------------------------------------------
10123:     PROCEDURE ValidarIat()
10124:         LOCAL loc_oPg, loc_cVal
10125:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10126:         IF !PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
10127:             RETURN
10128:         ENDIF
10129:         loc_cVal = UPPER(ALLTRIM(loc_oPg.txt_4c_Iat.Value))
10130: 
10131:         IF EMPTY(loc_cVal)
10132:             RETURN
10133:         ENDIF
10134: 
10135:         IF !INLIST(loc_cVal, "A", "T")
10136:             MsgAviso("Op" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida. Digite [A] Arredondamento ou [T] Truncamento!", "IAT")
10137:             IF PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
10138:                 loc_oPg.txt_4c_Iat.Value = ""
10139:             ENDIF
10140:         ELSE
10141:             IF PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
10142:                 loc_oPg.txt_4c_Iat.Value = loc_cVal
10143:             ENDIF
10144:         ENDIF
10145:     ENDPROC
10146: 
10147:     *--------------------------------------------------------------------------
10148:     * ValidarAliqIPI - LostFocus no campo Aliquota IPI
10149:     * Avisa se identica a aliquota da classificacao fiscal
10150:     *--------------------------------------------------------------------------
10151:     PROCEDURE ValidarAliqIPI()
10152:         LOCAL loc_oPg, loc_nVal, loc_cSQL, loc_nR, loc_nAliqClf
10153:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10154:         IF !PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5)
10155:             RETURN
10156:         ENDIF
10157:         loc_nVal = loc_oPg.txt_4c_AliqIPI.Value
10158: 
10159:         IF loc_nVal = 0
10160:             RETURN
10161:         ENDIF
10162:         IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10163:             RETURN
10164:         ENDIF
10165:         IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))
10166:             RETURN
10167:         ENDIF
10168: 
10169:         TRY
10170:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10171:                 SELECT aliqipis FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))>>)
10172:             ENDTEXT
10173:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfAliqV")
10174:             IF loc_nR > 0 AND !EOF("cursor_4c_ClfAliqV")
10175:                 loc_nAliqClf = cursor_4c_ClfAliqV.aliqipis
10176:                 IF loc_nVal = loc_nAliqClf
10177:                     MsgAviso("Al" + CHR(237) + "quota de IPI informada no produto id" + CHR(234) + "ntica " + CHR(224) + " classifica" + CHR(231) + CHR(227) + "o fiscal." + CHR(13) + "Deixe zero para utilizar a classifica" + CHR(231) + CHR(227) + "o fiscal.", "Al" + CHR(237) + "quota IPI")
10178:                 ENDIF
10179:             ENDIF
10180:             IF USED("cursor_4c_ClfAliqV")
10181:                 USE IN cursor_4c_ClfAliqV
10182:             ENDIF
10183:         CATCH TO loc_oErro
10184:             MsgErro("Erro ao validar al" + CHR(237) + "quota IPI:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarAliqIPI")
10185:         ENDTRY
10186:     ENDPROC
10187: 
10188:     *--------------------------------------------------------------------------
10189:     * ValidarMetal - LostFocus no campo Metal (codigo livre IPI)
10190:     *--------------------------------------------------------------------------
10191:     PROCEDURE ValidarMetal()
10192:         RETURN
10193:     ENDPROC
10194: 
10195:     *--------------------------------------------------------------------------
10196:     * ValidarTeor - LostFocus no campo Teor (codigo livre IPI)
10197:     *--------------------------------------------------------------------------
10198:     PROCEDURE ValidarTeor()
10199:         RETURN
10200:     ENDPROC
10201: 
10202:     *--------------------------------------------------------------------------
10203:     * ValidarMoedaEstimada - LostFocus no campo Moeda Valor Estimado
10204:     * Tabela: SigCdMoe | Chave: CMoes | Desc: DMoes
10205:     *--------------------------------------------------------------------------
10206:     PROCEDURE ValidarMoedaEstimada()
10207:         LOCAL loc_oPg, loc_cVal
10208:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10209:         IF !PEMSTATUS(loc_oPg, "txt_4c_Moedas", 5)
10210:             RETURN
10211:         ENDIF
10212:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Moedas.Value)
10213: 
10214:         IF EMPTY(loc_cVal)
10215:             RETURN
10216:         ENDIF
10217: 
10218:         TRY
10219:             LOCAL loc_oBusca
10220:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", "cursor_4c_MoeEstim", "CMoes", loc_cVal, "Moeda")
10221:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
10222:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10223:             loc_oBusca.Show()
10224: 
10225:             IF loc_oBusca.this_lSelecionou
10226:                 IF USED("cursor_4c_MoeEstim")
10227:                     IF PEMSTATUS(loc_oPg, "txt_4c_Moedas", 5)
10228:                         loc_oPg.txt_4c_Moedas.Value = ALLTRIM(cursor_4c_MoeEstim.CMoes)
10229:                     ENDIF
10230:                 ENDIF
10231:             ELSE
10232:                 IF PEMSTATUS(loc_oPg, "txt_4c_Moedas", 5)
10233:                     loc_oPg.txt_4c_Moedas.Value = ""
10234:                 ENDIF
10235:             ENDIF
10236: 
10237:             IF USED("cursor_4c_MoeEstim")
10238:                 USE IN cursor_4c_MoeEstim
10239:             ENDIF
10240:             loc_oBusca.Release()
10241:         CATCH TO loc_oErro
10242:             MsgErro("Erro ao validar moeda:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarMoedaEstimada")
10243:         ENDTRY
10244:     ENDPROC
10245: 
10246:     *--------------------------------------------------------------------------
10247:     * ValidarGruccus - LostFocus no campo Grupo Conta Corrente Custo
10248:     * Tabela: SigCdGcr | Chave: Codigos | Desc: Descrs
10249:     *--------------------------------------------------------------------------
10250:     PROCEDURE ValidarGruccus()
10251:         LOCAL loc_oPg, loc_cVal
10252:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10253:         IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10254:             RETURN
10255:         ENDIF
10256:         loc_cVal = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
10257: 
10258:         IF EMPTY(loc_cVal)
10259:             IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10260:                 loc_oPg.txt_4c__dgruccus.Value  = ""
10261:             ENDIF
10262:             IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10263:                 loc_oPg.txt_4c__contaccus.Value = ""
10264:             ENDIF
10265:             IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10266:                 loc_oPg.txt_4c__dcontaccus.Value = ""
10267:             ENDIF
10268:             THIS.this_cUltGrupoCC = ""
10269:             RETURN
10270:         ENDIF
10271: 
10272:         IF loc_cVal = THIS.this_cUltGrupoCC
10273:             RETURN
10274:         ENDIF
10275:         THIS.this_cUltGrupoCC = loc_cVal
10276: 
10277:         TRY
10278:             LOCAL loc_oBusca
10279:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", "cursor_4c_Gcr", "Codigos", loc_cVal, "Grupo Conta Corrente")
10280:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10281:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10282:             loc_oBusca.Show()
10283: 
10284:             IF loc_oBusca.this_lSelecionou
10285:                 IF USED("cursor_4c_Gcr")
10286:                     IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10287:                         loc_oPg.txt_4c__gruccus.Value  = ALLTRIM(cursor_4c_Gcr.Codigos)
10288:                     ENDIF
10289:                     IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10290:                         loc_oPg.txt_4c__dgruccus.Value = ALLTRIM(cursor_4c_Gcr.Descrs)
10291:                     ENDIF
10292:                 ENDIF
10293:             ELSE
10294:                 IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10295:                     loc_oPg.txt_4c__gruccus.Value  = ""
10296:                 ENDIF
10297:                 IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10298:                     loc_oPg.txt_4c__dgruccus.Value = ""
10299:                 ENDIF
10300:                 IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10301:                     loc_oPg.txt_4c__contaccus.Value = ""
10302:                 ENDIF
10303:                 IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10304:                     loc_oPg.txt_4c__dcontaccus.Value = ""
10305:                 ENDIF
10306:                 THIS.this_cUltGrupoCC = ""
10307:             ENDIF
10308: 
10309:             IF USED("cursor_4c_Gcr")
10310:                 USE IN cursor_4c_Gcr
10311:             ENDIF
10312:             loc_oBusca.Release()
10313:         CATCH TO loc_oErro
10314:             MsgErro("Erro ao validar grupo conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarGruccus")
10315:         ENDTRY
10316:     ENDPROC
10317: 
10318:     *--------------------------------------------------------------------------
10319:     * ValidarDgruccus - LostFocus na Descricao do Grupo Conta Corrente
10320:     * Busca por descricao (so se codigo estiver vazio)
10321:     *--------------------------------------------------------------------------
10322:     PROCEDURE ValidarDgruccus()
10323:         LOCAL loc_oPg, loc_cVal
10324:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10325:         IF !PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10326:             RETURN
10327:         ENDIF
10328:         loc_cVal = ALLTRIM(loc_oPg.txt_4c__dgruccus.Value)
10329: 
10330:         IF EMPTY(loc_cVal)
10331:             RETURN
10332:         ENDIF
10333:         IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10334:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c__gruccus.Value))
10335:                 RETURN
10336:             ENDIF
10337:         ENDIF
10338: 
10339:         TRY
10340:             LOCAL loc_oBusca
10341:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", "cursor_4c_GcrD", "Descrs", loc_cVal, "Grupo Conta Corrente")
10342:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10343:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10344:             loc_oBusca.Show()
10345: 
10346:             IF loc_oBusca.this_lSelecionou
10347:                 IF USED("cursor_4c_GcrD")
10348:                     IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10349:                         loc_oPg.txt_4c__gruccus.Value  = ALLTRIM(cursor_4c_GcrD.Codigos)
10350:                     ENDIF
10351:                     IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10352:                         loc_oPg.txt_4c__dgruccus.Value = ALLTRIM(cursor_4c_GcrD.Descrs)
10353:                     ENDIF
10354:                     THIS.this_cUltGrupoCC = ALLTRIM(cursor_4c_GcrD.Codigos)
10355:                 ENDIF
10356:             ELSE
10357:                 IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10358:                     loc_oPg.txt_4c__dgruccus.Value = ""
10359:                 ENDIF
10360:             ENDIF
10361: 
10362:             IF USED("cursor_4c_GcrD")
10363:                 USE IN cursor_4c_GcrD
10364:             ENDIF
10365:             loc_oBusca.Release()
10366:         CATCH TO loc_oErro
10367:             MsgErro("Erro ao buscar grupo conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDgruccus")
10368:         ENDTRY
10369:     ENDPROC
10370: 
10371:     *--------------------------------------------------------------------------
10372:     * ValidarContaccus - LostFocus no campo Conta Corrente Custo
10373:     * Tabela: SigCdCli | Chave: IClis | Desc: Rclis
10374:     * So acessivel quando grupo gruccus preenchido
10375:     *--------------------------------------------------------------------------
10376:     PROCEDURE ValidarContaccus()
10377:         LOCAL loc_oPg, loc_cVal, loc_cGrupo
10378:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10379:         IF !PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10380:             RETURN
10381:         ENDIF
10382:         loc_cVal   = ALLTRIM(loc_oPg.txt_4c__contaccus.Value)
10383:         loc_cGrupo = ""
10384:         IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10385:             loc_cGrupo = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
10386:         ENDIF
10387: 
10388:         *-- Grupo obrigatorio para acessar conta
10389:         IF EMPTY(loc_cGrupo)
10390:             IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10391:                 loc_oPg.txt_4c__contaccus.Value = ""
10392:             ENDIF
10393:             IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10394:                 loc_oPg.txt_4c__dcontaccus.Value = ""
10395:             ENDIF
10396:             RETURN
10397:         ENDIF
10398: 
10399:         IF EMPTY(loc_cVal)
10400:             IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10401:                 loc_oPg.txt_4c__dcontaccus.Value = ""
10402:             ENDIF
10403:             THIS.this_cUltContaCC = ""
10404:             RETURN
10405:         ENDIF
10406: 
10407:         IF loc_cVal = THIS.this_cUltContaCC
10408:             RETURN
10409:         ENDIF
10410:         THIS.this_cUltContaCC = loc_cVal
10411: 
10412:         TRY
10413:             LOCAL loc_oBusca
10414:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_ContaCC", "IClis", loc_cVal, "Conta Corrente")
10415:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10416:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10417:             loc_oBusca.Show()
10418: 
10419:             IF loc_oBusca.this_lSelecionou
10420:                 IF USED("cursor_4c_ContaCC")
10421:                     IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10422:                         loc_oPg.txt_4c__contaccus.Value  = ALLTRIM(cursor_4c_ContaCC.IClis)
10423:                     ENDIF
10424:                     IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10425:                         loc_oPg.txt_4c__dcontaccus.Value = ALLTRIM(cursor_4c_ContaCC.Rclis)
10426:                     ENDIF
10427:                 ENDIF
10428:             ELSE
10429:                 IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10430:                     loc_oPg.txt_4c__contaccus.Value  = ""
10431:                 ENDIF
10432:                 IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10433:                     loc_oPg.txt_4c__dcontaccus.Value = ""
10434:                 ENDIF
10435:                 THIS.this_cUltContaCC = ""
10436:             ENDIF
10437: 
10438:             IF USED("cursor_4c_ContaCC")
10439:                 USE IN cursor_4c_ContaCC
10440:             ENDIF
10441:             loc_oBusca.Release()
10442:         CATCH TO loc_oErro
10443:             MsgErro("Erro ao validar conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarContaccus")
10444:         ENDTRY
10445:     ENDPROC
10446: 
10447:     *--------------------------------------------------------------------------
10448:     * ValidarDcontaccus - LostFocus na Descricao Conta Corrente
10449:     * Busca por nome (so se codigo estiver vazio e grupo preenchido)
10450:     *--------------------------------------------------------------------------
10451:     PROCEDURE ValidarDcontaccus()
10452:         LOCAL loc_oPg, loc_cVal, loc_cGrupo
10453:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10454:         IF !PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10455:             RETURN
10456:         ENDIF
10457:         loc_cVal   = ALLTRIM(loc_oPg.txt_4c__dcontaccus.Value)
10458:         loc_cGrupo = ""
10459:         IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10460:             loc_cGrupo = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
10461:         ENDIF
10462: 
10463:         IF EMPTY(loc_cVal) OR EMPTY(loc_cGrupo)
10464:             RETURN
10465:         ENDIF
10466:         IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10467:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c__contaccus.Value))
10468:                 RETURN
10469:             ENDIF
10470:         ENDIF
10471: 
10472:         TRY
10473:             LOCAL loc_oBusca
10474:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_ContaCCD", "Rclis", loc_cVal, "Conta Corrente")
10475:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10476:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10477:             loc_oBusca.Show()
10478: 
10479:             IF loc_oBusca.this_lSelecionou
10480:                 IF USED("cursor_4c_ContaCCD")
10481:                     IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10482:                         loc_oPg.txt_4c__contaccus.Value  = ALLTRIM(cursor_4c_ContaCCD.IClis)
10483:                     ENDIF
10484:                     IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10485:                         loc_oPg.txt_4c__dcontaccus.Value = ALLTRIM(cursor_4c_ContaCCD.Rclis)
10486:                     ENDIF
10487:                     THIS.this_cUltContaCC = ALLTRIM(cursor_4c_ContaCCD.IClis)
10488:                 ENDIF
10489:             ELSE
10490:                 IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10491:                     loc_oPg.txt_4c__dcontaccus.Value = ""
10492:                 ENDIF
10493:             ENDIF
10494: 
10495:             IF USED("cursor_4c_ContaCCD")
10496:                 USE IN cursor_4c_ContaCCD
10497:             ENDIF
10498:             loc_oBusca.Release()
10499:         CATCH TO loc_oErro
10500:             MsgErro("Erro ao buscar conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDcontaccus")
10501:         ENDTRY
10502:     ENDPROC
10503: 
10504:     *--------------------------------------------------------------------------
10505:     * TabFiscal_ExtIpiGotFocus - GotFocus no campo Excecao da TIPI
10506:     * Verifica se campo deve estar habilitado (IpiProds = 'S' em SigCdClf)
10507:     *--------------------------------------------------------------------------
10508:     PROCEDURE TabFiscal_ExtIpiGotFocus()
10509:         LOCAL loc_oPg, loc_cClf, loc_cSQL, loc_nR, loc_lHabilitar
10510:         loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10511:         loc_lHabilitar = .F.
10512: 
10513:         IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10514:             RETURN
10515:         ENDIF
10516:         loc_cClf = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
10517: 
10518:         IF EMPTY(loc_cClf)
10519:             RETURN
10520:         ENDIF
10521: 
10522:         TRY
10523:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10524:                 SELECT IpiProds FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(loc_cClf)>>)
10525:             ENDTEXT
10526:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfIpi")
10527:             IF loc_nR > 0 AND !EOF("cursor_4c_ClfIpi")
10528:                 loc_lHabilitar = (ALLTRIM(cursor_4c_ClfIpi.IpiProds) = "S")
10529:             ENDIF
10530:             IF USED("cursor_4c_ClfIpi")
10531:                 USE IN cursor_4c_ClfIpi
10532:             ENDIF
10533:         CATCH TO loc_oErro
10534:             MsgErro("Erro ao verificar IpiProds:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFiscal_ExtIpiGotFocus")
10535:         ENDTRY
10536: 
10537:         IF !loc_lHabilitar
10538:             IF PEMSTATUS(loc_oPg, "txt_4c_Extipi", 5)
10539:                 loc_oPg.txt_4c_Extipi.ReadOnly = .T.
10540:             ENDIF
10541:         ENDIF
10542:     ENDPROC
10543: 
10544:     *--------------------------------------------------------------------------
10545:     * BtnDescFisClick - Gerar Descricao Fiscal automaticamente
10546:     * Equivalente ao legacy fGerDescFis - stub funcional
10547:     *--------------------------------------------------------------------------
10548:     PROCEDURE BtnDescFisClick()
10549:         LOCAL loc_oPg, loc_cCpros
10550:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10551:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10552: 
10553:         IF EMPTY(loc_cCpros)
10554:             MsgAviso("Selecione um produto antes de gerar a descri" + CHR(231) + CHR(227) + "o fiscal.", "Descri" + CHR(231) + CHR(227) + "o Fiscal")
10555:             RETURN
10556:         ENDIF
10557: 
10558:         MsgAviso("Funcionalidade de gera" + CHR(231) + CHR(227) + "o autom" + CHR(225) + "tica de descri" + CHR(231) + CHR(227) + "o fiscal n" + CHR(227) + "o dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o." + CHR(13) + "Edite a descri" + CHR(231) + CHR(227) + "o fiscal diretamente no campo.", "Descri" + CHR(231) + CHR(227) + "o Fiscal")
10559:     ENDPROC
10560: 
10561:     *--------------------------------------------------------------------------
10562:     * CarregarDadosFiscais - Carrega grid CMV (custos gramas) da aba Fiscal
10563:     * Tabela: SigCdCmv | Colunas: Datas, ValCuss, Moedas
10564:     *--------------------------------------------------------------------------
10565:     PROTECTED PROCEDURE CarregarDadosFiscais()
10566:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
10567:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10568:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10569: 
10570:         IF EMPTY(loc_cCpros)
10571:             IF USED("cursor_4c_Cmv")
10572:                 ZAP IN cursor_4c_Cmv
10573:             ENDIF
10574:             IF PEMSTATUS(loc_oPg, "grd_4c_Cmv", 5)
10575:                 loc_oPg.grd_4c_Cmv.Refresh()
10576:             ENDIF
10577:             RETURN
10578:         ENDIF
10579: 
10580:         TRY
10581:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10582:                 SELECT Datas AS periodos, ValCuss AS valcustos, Moedas AS moedas
10583:                 FROM SigCdCmv
10584:                 WHERE RTRIM(Cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10585:                 ORDER BY Datas DESC
10586:             ENDTEXT
10587: 
10588:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmvTemp")
10589: 
10590:             IF USED("cursor_4c_Cmv")
10591:                 ZAP IN cursor_4c_Cmv
10592:             ENDIF
10593: 
10594:             IF loc_nR > 0
10595:                 IF !USED("cursor_4c_Cmv")
10596:                     SET NULL ON
10597:                     CREATE CURSOR cursor_4c_Cmv (periodos C(10) NULL, valcustos N(12, 2) NULL, moedas C(3) NULL)
10598:                     SET NULL OFF
10599:                 ENDIF
10600:                 IF USED("cursor_4c_CmvTemp")
10601:                     SELECT cursor_4c_Cmv
10602:                     APPEND FROM DBF("cursor_4c_CmvTemp")
10603:                 ENDIF
10604:             ENDIF
10605: 

*-- Linhas 10625 a 10820:
10625:     * BtnIniTarefaClick - Registra inicio de tarefa do Designer
10626:     * Tabela: sigprtar (cpros, dtinis, usuars)
10627:     *--------------------------------------------------------------------------
10628:     PROCEDURE BtnIniTarefaClick()
10629:         LOCAL loc_cCpros, loc_cSQL, loc_nR
10630:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10631: 
10632:         IF EMPTY(loc_cCpros)
10633:             MsgAviso("Selecione um produto antes de iniciar tarefa.", "Tarefa Designer")
10634:             RETURN
10635:         ENDIF
10636: 
10637:         TRY
10638:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10639:                 INSERT INTO sigprtar (cpros, dtinis, usuars)
10640:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<FormatarDataSQL(DATE())>>, <<EscaparSQL(gc_4c_UsuarioLogado)>>)
10641:             ENDTEXT
10642:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10643:             IF loc_nR > 0
10644:                 THIS.CarregarDesigner()
10645:             ELSE
10646:                 MsgErro("Erro ao registrar in" + CHR(237) + "cio de tarefa.", "FormProduto.BtnIniTarefaClick")
10647:             ENDIF
10648:         CATCH TO loc_oErro
10649:             MsgErro("Erro ao iniciar tarefa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnIniTarefaClick")
10650:         ENDTRY
10651:     ENDPROC
10652: 
10653:     *--------------------------------------------------------------------------
10654:     * BtnFimTarefaClick - Registra fim de tarefa do Designer
10655:     * Atualiza dtfims na ultima tarefa em aberto (dtfims IS NULL)
10656:     *--------------------------------------------------------------------------
10657:     PROCEDURE BtnFimTarefaClick()
10658:         LOCAL loc_cCpros, loc_cSQL, loc_nR
10659:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10660: 
10661:         IF EMPTY(loc_cCpros)
10662:             MsgAviso("Selecione um produto antes de finalizar tarefa.", "Tarefa Designer")
10663:             RETURN
10664:         ENDIF
10665: 
10666:         TRY
10667:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10668:                 UPDATE TOP(1) sigprtar SET dtfims = <<FormatarDataSQL(DATE())>>
10669:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10670:             ENDTEXT
10671:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10672:             IF loc_nR > 0
10673:                 THIS.CarregarDesigner()
10674:             ELSE
10675:                 MsgErro("Nenhuma tarefa em aberto para finalizar.", "FormProduto.BtnFimTarefaClick")
10676:             ENDIF
10677:         CATCH TO loc_oErro
10678:             MsgErro("Erro ao finalizar tarefa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnFimTarefaClick")
10679:         ENDTRY
10680:     ENDPROC
10681: 
10682:     *--------------------------------------------------------------------------
10683:     * BtnInsArqsClick - Insere arquivo do Designer via dialogo de arquivo
10684:     * Tabela: sigprarq (cpros, arquivos)
10685:     *--------------------------------------------------------------------------
10686:     PROCEDURE BtnInsArqsClick()
10687:         LOCAL loc_cCpros, loc_cArquivo, loc_cSQL, loc_nR
10688:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10689: 
10690:         IF EMPTY(loc_cCpros)
10691:             MsgAviso("Selecione um produto para inserir arquivo.", "Arquivos Designer")
10692:             RETURN
10693:         ENDIF
10694: 
10695:         loc_cArquivo = GETFILE("*.*", "Selecionar Arquivo para Designer")
10696:         IF EMPTY(loc_cArquivo)
10697:             RETURN
10698:         ENDIF
10699: 
10700:         TRY
10701:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10702:                 INSERT INTO sigprarq (cpros, arquivos)
10703:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<EscaparSQL(loc_cArquivo)>>)
10704:             ENDTEXT
10705:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10706:             IF loc_nR > 0
10707:                 THIS.CarregarDesigner()
10708:             ELSE
10709:                 MsgErro("Erro ao inserir arquivo.", "FormProduto.BtnInsArqsClick")
10710:             ENDIF
10711:         CATCH TO loc_oErro
10712:             MsgErro("Erro ao inserir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInsArqsClick")
10713:         ENDTRY
10714:     ENDPROC
10715: 
10716:     *--------------------------------------------------------------------------
10717:     * BtnExcArqsClick - Exclui arquivo selecionado no grid de arquivos
10718:     *--------------------------------------------------------------------------
10719:     PROCEDURE BtnExcArqsClick()
10720:         LOCAL loc_cCpros, loc_cArquivo, loc_cSQL, loc_nR
10721:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10722: 
10723:         IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
10724:             MsgAviso("Selecione um arquivo para excluir.", "Arquivos Designer")
10725:             RETURN
10726:         ENDIF
10727: 
10728:         loc_cArquivo = ALLTRIM(cursor_4c_Arquivos.arquivos)
10729: 
10730:         IF MsgConfirma("Excluir o arquivo selecionado?", "Arquivos Designer")
10731:             TRY
10732:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
10733:                     DELETE FROM sigprarq
10734:                     WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND RTRIM(arquivos) = RTRIM(<<EscaparSQL(loc_cArquivo)>>)
10735:                 ENDTEXT
10736:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10737:                 IF loc_nR > 0
10738:                     THIS.CarregarDesigner()
10739:                 ELSE
10740:                     MsgErro("Erro ao excluir arquivo.", "FormProduto.BtnExcArqsClick")
10741:                 ENDIF
10742:             CATCH TO loc_oErro
10743:                 MsgErro("Erro ao excluir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcArqsClick")
10744:             ENDTRY
10745:         ENDIF
10746:     ENDPROC
10747: 
10748:     *--------------------------------------------------------------------------
10749:     * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao
10750:     *--------------------------------------------------------------------------
10751:     PROCEDURE BtnOpnArqsClick()
10752:         LOCAL loc_cArquivo
10753: 
10754:         IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
10755:             MsgAviso("Selecione um arquivo para abrir.", "Arquivos Designer")
10756:             RETURN
10757:         ENDIF
10758: 
10759:         loc_cArquivo = ALLTRIM(cursor_4c_Arquivos.arquivos)
10760: 
10761:         IF EMPTY(loc_cArquivo)
10762:             MsgAviso("Caminho do arquivo n" + CHR(227) + "o informado.", "Arquivos Designer")
10763:             RETURN
10764:         ENDIF
10765: 
10766:         TRY
10767:             DECLARE INTEGER ShellExecute IN "Shell32.dll" ;
10768:                 INTEGER hwnd, STRING lpOperation, STRING lpFile, ;
10769:                 STRING lpParameters, STRING lpDirectory, INTEGER nShowCmd
10770:             ShellExecute(0, "open", loc_cArquivo, "", "", 1)
10771:         CATCH TO loc_oErro
10772:             MsgErro("Erro ao abrir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnOpnArqsClick")
10773:         ENDTRY
10774:     ENDPROC
10775: 
10776:     *--------------------------------------------------------------------------
10777:     * CarregarDesigner - Carrega grids de tarefas e arquivos do Designer (Tab 5)
10778:     * Tabelas: sigprtar (tarefas), sigprarq (arquivos)
10779:     *--------------------------------------------------------------------------
10780:     PROTECTED PROCEDURE CarregarDesigner()
10781:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
10782:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10783:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
10784: 
10785:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
10786:             RETURN
10787:         ENDIF
10788: 
10789:         TRY
10790:             *-- Tarefas do Designer
10791:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10792:                 SELECT dtinis, dtfims, usuars, tarefas
10793:                 FROM sigprtar
10794:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10795:                 ORDER BY dtinis DESC
10796:             ENDTEXT
10797:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesignerTmp")
10798:             IF loc_nR > 0
10799:                 IF USED("cursor_4c_Designer")
10800:                     SELECT cursor_4c_Designer
10801:                     ZAP
10802:                     APPEND FROM DBF("cursor_4c_DesignerTmp")
10803:                 ENDIF
10804:                 IF USED("cursor_4c_DesignerTmp")
10805:                     USE IN cursor_4c_DesignerTmp
10806:                 ENDIF
10807:                 IF PEMSTATUS(loc_oPg, "grd_4c_Designer", 5)
10808:                     loc_oPg.grd_4c_Designer.Refresh()
10809:                 ENDIF
10810:             ENDIF
10811: 
10812:             *-- Arquivos do Designer
10813:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10814:                 SELECT arquivos FROM sigprarq
10815:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10816:                 ORDER BY arquivos
10817:             ENDTEXT
10818:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ArquivosTmp")
10819:             IF loc_nR > 0
10820:                 IF USED("cursor_4c_Arquivos")

*-- Linhas 10829 a 11950:
10829:                     loc_oPg.grd_4c_Arquivos.Refresh()
10830:                 ENDIF
10831:             ENDIF
10832: 
10833:             *-- Tarefas dispon?veis para lookup Column4 (SigPrTrf = tabela mestre de tarefas)
10834:             IF USED("cursor_4c_Tarefas")
10835:                 ZAP IN cursor_4c_Tarefas
10836:             ENDIF
10837:             loc_nR = SQLEXEC(gnConnHandle, "SELECT CodCads, DesCads FROM SigPrTrf ORDER BY CodCads", "cursor_4c_TarefasTmp")
10838:             IF loc_nR > 0
10839:                 IF USED("cursor_4c_Tarefas")
10840:                     APPEND FROM DBF("cursor_4c_TarefasTmp")
10841:                 ENDIF
10842:                 IF USED("cursor_4c_TarefasTmp")
10843:                     USE IN cursor_4c_TarefasTmp
10844:                 ENDIF
10845:             ELSE
10846:                 *-- Tabela SigPrTrf nao localizada: cursor fica vazio (lookup manual)
10847:                 IF USED("cursor_4c_TarefasTmp")
10848:                     USE IN cursor_4c_TarefasTmp
10849:                 ENDIF
10850:             ENDIF
10851: 
10852:         CATCH TO loc_oErro
10853:             MsgErro("Erro ao carregar designer:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarDesigner")
10854:         ENDTRY
10855:     ENDPROC
10856: 
10857:     *--------------------------------------------------------------------------
10858:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
10859:     * Salvar: habilitado apenas em INCLUIR e ALTERAR
10860:     * Cancelar: sempre habilitado em Page2
10861:     *--------------------------------------------------------------------------
10862:     PROCEDURE AjustarBotoesPorModo()
10863:         LOCAL loc_oBotoesDados, loc_lEmEdicao
10864:         loc_oBotoesDados = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados
10865:         loc_lEmEdicao    = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
10866: 
10867:         TRY
10868:             IF PEMSTATUS(loc_oBotoesDados, "cmd_4c_Salvar", 5)
10869:                 loc_oBotoesDados.cmd_4c_Salvar.Enabled = loc_lEmEdicao
10870:             ENDIF
10871:             IF PEMSTATUS(loc_oBotoesDados, "cmd_4c_Cancelar", 5)
10872:                 loc_oBotoesDados.cmd_4c_Cancelar.Enabled = .T.
10873:             ENDIF
10874:         CATCH TO loc_oErro
10875:             MsgErro(loc_oErro.Message, "FormProduto.AjustarBotoesPorModo")
10876:         ENDTRY
10877:     ENDPROC
10878: 
10879:     *--------------------------------------------------------------------------
10880:     * CompoGrd_AfterRowColChange - Grid composicao: ao mover linha/coluna
10881:     * Atualiza campos Get_Desc e getObsOFs com dados da linha atual
10882:     *--------------------------------------------------------------------------
10883:     PROCEDURE CompoGrd_AfterRowColChange(par_nColIndex)
10884:         LOCAL loc_oPg
10885:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
10886: 
10887:         TRY
10888:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
10889:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
10890:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(NVL(cursor_4c_Compo.dcompos, ""))
10891:                 ENDIF
10892:             ENDIF
10893:         CATCH TO loc_oErro
10894:             MsgErro(loc_oErro.Message, "FormProduto.CompoGrd_AfterRowColChange")
10895:         ENDTRY
10896:     ENDPROC
10897: 
10898:     *--------------------------------------------------------------------------
10899:     * SubCompoGrd_AfterRowColChange - Grid sub-componente: ao mover linha
10900:     * Atualiza campos get_desccp e get_matsub com dados da linha atual
10901:     *--------------------------------------------------------------------------
10902:     PROCEDURE SubCompoGrd_AfterRowColChange(par_nColIndex)
10903:         LOCAL loc_oPg
10904:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
10905: 
10906:         TRY
10907:             IF USED("cursor_4c_SubCompo") AND !EOF("cursor_4c_SubCompo")
10908:                 IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
10909:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(NVL(cursor_4c_SubCompo.dcompos, ""))
10910:                 ENDIF
10911:                 IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
10912:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(NVL(cursor_4c_SubCompo.matsubs, ""))
10913:                 ENDIF
10914:             ENDIF
10915:         CATCH TO loc_oErro
10916:             MsgErro(loc_oErro.Message, "FormProduto.SubCompoGrd_AfterRowColChange")
10917:         ENDTRY
10918:     ENDPROC
10919: 
10920:     *--------------------------------------------------------------------------
10921:     * ChkLiberaCustoClick - Checkbox liberar custo: habilita/desabilita campos
10922:     *--------------------------------------------------------------------------
10923:     PROCEDURE ChkLiberaCustoClick()
10924:         LOCAL loc_oPg, loc_lLibera
10925:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
10926:         loc_lLibera = .F.
10927: 
10928:         TRY
10929:             IF PEMSTATUS(loc_oPg, "chk_4c_ChkLiberaCusto", 5)
10930:                 loc_lLibera = (loc_oPg.chk_4c_ChkLiberaCusto.Value = 1)
10931:             ENDIF
10932:             IF PEMSTATUS(loc_oPg, "txt_4c_Pcus", 5)
10933:                 loc_oPg.txt_4c_Pcus.ReadOnly     = !loc_lLibera
10934:             ENDIF
10935:             IF PEMSTATUS(loc_oPg, "txt_4c_PcusMoe", 5)
10936:                 loc_oPg.txt_4c_PcusMoe.ReadOnly  = !loc_lLibera
10937:             ENDIF
10938:             IF PEMSTATUS(loc_oPg, "txt_4c_Fcusto", 5)
10939:                 loc_oPg.txt_4c_Fcusto.ReadOnly   = !loc_lLibera
10940:             ENDIF
10941:             IF PEMSTATUS(loc_oPg, "txt_4c_Cmkpc", 5)
10942:                 loc_oPg.txt_4c_Cmkpc.ReadOnly    = !loc_lLibera
10943:             ENDIF
10944:         CATCH TO loc_oErro
10945:             MsgErro(loc_oErro.Message, "FormProduto.ChkLiberaCustoClick")
10946:         ENDTRY
10947:     ENDPROC
10948: 
10949:     *--------------------------------------------------------------------------
10950:     * ChkLiberaVendaClick - Checkbox liberar venda: habilita/desabilita campos
10951:     *--------------------------------------------------------------------------
10952:     PROCEDURE ChkLiberaVendaClick()
10953:         LOCAL loc_oPg, loc_lLibera
10954:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
10955:         loc_lLibera = .F.
10956: 
10957:         TRY
10958:             IF PEMSTATUS(loc_oPg, "chk_4c_ChkLiberaVenda", 5)
10959:                 loc_lLibera = (loc_oPg.chk_4c_ChkLiberaVenda.Value = 1)
10960:             ENDIF
10961:             IF PEMSTATUS(loc_oPg, "txt_4c_Margem", 5)
10962:                 loc_oPg.txt_4c_Margem.ReadOnly   = !loc_lLibera
10963:             ENDIF
10964:             IF PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
10965:                 loc_oPg.txt_4c_Moeda.ReadOnly    = !loc_lLibera
10966:             ENDIF
10967:             IF PEMSTATUS(loc_oPg, "txt_4c_Ftio", 5)
10968:                 loc_oPg.txt_4c_Ftio.ReadOnly     = !loc_lLibera
10969:             ENDIF
10970:             IF PEMSTATUS(loc_oPg, "txt_4c_Fvenda", 5)
10971:                 loc_oPg.txt_4c_Fvenda.ReadOnly   = !loc_lLibera
10972:             ENDIF
10973:             IF PEMSTATUS(loc_oPg, "txt_4c_Moepv", 5)
10974:                 loc_oPg.txt_4c_Moepv.ReadOnly    = !loc_lLibera
10975:             ENDIF
10976:             IF PEMSTATUS(loc_oPg, "txt_4c_Moev", 5)
10977:                 loc_oPg.txt_4c_Moev.ReadOnly     = !loc_lLibera
10978:             ENDIF
10979:         CATCH TO loc_oErro
10980:             MsgErro(loc_oErro.Message, "FormProduto.ChkLiberaVendaClick")
10981:         ENDTRY
10982:     ENDPROC
10983: 
10984:     *--------------------------------------------------------------------------
10985:     * ChkPvendaClick - Checkbox usar preco ideal: aplica preco ideal ao preco venda
10986:     *--------------------------------------------------------------------------
10987:     PROCEDURE ChkPvendaClick()
10988:         LOCAL loc_oPg, loc_nPvideal, loc_nEncarg
10989:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
10990: 
10991:         TRY
10992:             IF PEMSTATUS(loc_oPg, "txt_4c_Pvideal", 5)
10993:                 loc_nPvideal = loc_oPg.txt_4c_Pvideal.Value
10994:             ELSE
10995:                 loc_nPvideal = 0
10996:             ENDIF
10997:             IF PEMSTATUS(loc_oPg, "txt_4c_Encarg", 5)
10998:                 loc_nEncarg = loc_oPg.txt_4c_Encarg.Value
10999:             ELSE
11000:                 loc_nEncarg = 1
11001:             ENDIF
11002:             IF loc_nEncarg = 0
11003:                 loc_nEncarg = 1
11004:             ENDIF
11005:             IF PEMSTATUS(loc_oPg, "txt_4c_Pven", 5)
11006:                 loc_oPg.txt_4c_Pven.Value = loc_nPvideal / loc_nEncarg
11007:             ENDIF
11008:             IF PEMSTATUS(loc_oPg, "txt_4c_Moev", 5) AND PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
11009:                 loc_oPg.txt_4c_Moev.Value = loc_oPg.txt_4c_Moeda.Value
11010:             ENDIF
11011:         CATCH TO loc_oErro
11012:             MsgErro(loc_oErro.Message, "FormProduto.ChkPvendaClick")
11013:         ENDTRY
11014:     ENDPROC
11015: 
11016:     *--------------------------------------------------------------------------
11017:     * TabCompo_MoecLostFocus - LostFocus de txt_4c_PcusMoe (getMoec)
11018:     * Valida codigo de moeda de custo - lookup em SigCdMoe
11019:     *--------------------------------------------------------------------------
11020:     PROCEDURE TabCompo_MoecLostFocus()
11021:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11022:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11023:         loc_lResultado = .T.
11024: 
11025:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11026:             RETURN
11027:         ENDIF
11028: 
11029:         TRY
11030:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_PcusMoe", 5)
11031:                 RETURN
11032:             ENDIF
11033:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_PcusMoe.Value)
11034:             IF EMPTY(loc_cCod)
11035:                 RETURN
11036:             ENDIF
11037: 
11038:             gb_4c_ValidandoUI = .T.
11039:             loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11040:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoecTmp")
11041:             gb_4c_ValidandoUI = .F.
11042: 
11043:             IF loc_nR <= 0 OR EOF("cursor_4c_MoecTmp")
11044:                 *-- Nao encontrou: abre lookup
11045:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11046:                 loc_oForm.Caption = "Moedas"
11047:                 loc_oForm.mAddColuna("CMoes", "C" + CHR(243) + "digo", "C", 6)
11048:                 loc_oForm.mAddColuna("DMoes", "Descri" + CHR(231) + CHR(227) + "o", "C", 30)
11049:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11050:                 loc_oForm.Show()
11051:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11052:                     loc_oPg.txt_4c_PcusMoe.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11053:                     USE IN cursor_4c_BuscaAux
11054:                 ELSE
11055:                     loc_oPg.txt_4c_PcusMoe.Value = ""
11056:                 ENDIF
11057:                 loc_oForm.Release()
11058:             ENDIF
11059:             IF USED("cursor_4c_MoecTmp")
11060:                 USE IN cursor_4c_MoecTmp
11061:             ENDIF
11062:         CATCH TO loc_oErro
11063:             gb_4c_ValidandoUI = .F.
11064:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoecLostFocus")
11065:         ENDTRY
11066:     ENDPROC
11067: 
11068:     *--------------------------------------------------------------------------
11069:     * TabCompo_MoecusfLostFocus - LostFocus de txt_4c_MoecusFoe (getMoecusf)
11070:     * Valida codigo de moeda de custo com feitio - lookup em SigCdMoe
11071:     *--------------------------------------------------------------------------
11072:     PROCEDURE TabCompo_MoecusfLostFocus()
11073:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11074:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11075: 
11076:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11077:             RETURN
11078:         ENDIF
11079: 
11080:         TRY
11081:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_MoecusFoe", 5)
11082:                 RETURN
11083:             ENDIF
11084:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_MoecusFoe.Value)
11085:             IF EMPTY(loc_cCod)
11086:                 RETURN
11087:             ENDIF
11088: 
11089:             gb_4c_ValidandoUI = .T.
11090:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11091:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoecusfTmp")
11092:             gb_4c_ValidandoUI = .F.
11093: 
11094:             IF loc_nR <= 0 OR EOF("cursor_4c_MoecusfTmp")
11095:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11096:                 loc_oForm.Caption = "Moedas"
11097:                 loc_oForm.mAddColuna("CMoes", "C" + CHR(243) + "digo", "C", 6)
11098:                 loc_oForm.mAddColuna("DMoes", "Descri" + CHR(231) + CHR(227) + "o", "C", 30)
11099:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11100:                 loc_oForm.Show()
11101:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11102:                     loc_oPg.txt_4c_MoecusFoe.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11103:                     USE IN cursor_4c_BuscaAux
11104:                 ELSE
11105:                     loc_oPg.txt_4c_MoecusFoe.Value = ""
11106:                 ENDIF
11107:                 loc_oForm.Release()
11108:             ENDIF
11109:             IF USED("cursor_4c_MoecusfTmp")
11110:                 USE IN cursor_4c_MoecusfTmp
11111:             ENDIF
11112:         CATCH TO loc_oErro
11113:             gb_4c_ValidandoUI = .F.
11114:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoecusfLostFocus")
11115:         ENDTRY
11116:     ENDPROC
11117: 
11118:     *--------------------------------------------------------------------------
11119:     * TabCompo_MoedaLostFocus - LostFocus de txt_4c_Moeda (getMoeda)
11120:     * Valida moeda de venda - lookup em SigCdMoe
11121:     *--------------------------------------------------------------------------
11122:     PROCEDURE TabCompo_MoedaLostFocus()
11123:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11124:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11125: 
11126:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11127:             RETURN
11128:         ENDIF
11129: 
11130:         TRY
11131:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
11132:                 RETURN
11133:             ENDIF
11134:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)
11135:             IF EMPTY(loc_cCod)
11136:                 RETURN
11137:             ENDIF
11138: 
11139:             gb_4c_ValidandoUI = .T.
11140:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11141:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoedaTmp")
11142:             gb_4c_ValidandoUI = .F.
11143: 
11144:             IF loc_nR <= 0 OR EOF("cursor_4c_MoedaTmp")
11145:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11146:                 loc_oForm.Caption = "Moedas"
11147:                 loc_oForm.mAddColuna("CMoes", "C" + CHR(243) + "digo", "C", 6)
11148:                 loc_oForm.mAddColuna("DMoes", "Descri" + CHR(231) + CHR(227) + "o", "C", 30)
11149:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11150:                 loc_oForm.Show()
11151:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11152:                     loc_oPg.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11153:                     USE IN cursor_4c_BuscaAux
11154:                 ELSE
11155:                     loc_oPg.txt_4c_Moeda.Value = ""
11156:                 ENDIF
11157:                 loc_oForm.Release()
11158:             ENDIF
11159:             IF USED("cursor_4c_MoedaTmp")
11160:                 USE IN cursor_4c_MoedaTmp
11161:             ENDIF
11162:         CATCH TO loc_oErro
11163:             gb_4c_ValidandoUI = .F.
11164:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoedaLostFocus")
11165:         ENDTRY
11166:     ENDPROC
11167: 
11168:     *--------------------------------------------------------------------------
11169:     * TabCompo_MoepvLostFocus - LostFocus de txt_4c_Moepv (getMoepv)
11170:     * Valida moeda do preco de venda - lookup em SigCdMoe
11171:     *--------------------------------------------------------------------------
11172:     PROCEDURE TabCompo_MoepvLostFocus()
11173:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11174:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11175: 
11176:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11177:             RETURN
11178:         ENDIF
11179: 
11180:         TRY
11181:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Moepv", 5)
11182:                 RETURN
11183:             ENDIF
11184:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moepv.Value)
11185:             IF EMPTY(loc_cCod)
11186:                 RETURN
11187:             ENDIF
11188: 
11189:             gb_4c_ValidandoUI = .T.
11190:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11191:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoepvTmp")
11192:             gb_4c_ValidandoUI = .F.
11193: 
11194:             IF loc_nR <= 0 OR EOF("cursor_4c_MoepvTmp")
11195:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11196:                 loc_oForm.Caption = "Moedas"
11197:                 loc_oForm.mAddColuna("CMoes", "C" + CHR(243) + "digo", "C", 6)
11198:                 loc_oForm.mAddColuna("DMoes", "Descri" + CHR(231) + CHR(227) + "o", "C", 30)
11199:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11200:                 loc_oForm.Show()
11201:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11202:                     loc_oPg.txt_4c_Moepv.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11203:                     USE IN cursor_4c_BuscaAux
11204:                 ELSE
11205:                     loc_oPg.txt_4c_Moepv.Value = ""
11206:                 ENDIF
11207:                 loc_oForm.Release()
11208:             ENDIF
11209:             IF USED("cursor_4c_MoepvTmp")
11210:                 USE IN cursor_4c_MoepvTmp
11211:             ENDIF
11212:         CATCH TO loc_oErro
11213:             gb_4c_ValidandoUI = .F.
11214:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoepvLostFocus")
11215:         ENDTRY
11216:     ENDPROC
11217: 
11218:     *--------------------------------------------------------------------------
11219:     * TabCompo_MoevLostFocus - LostFocus de txt_4c_Moev (getMoev)
11220:     * Valida moeda do valor de venda - lookup em SigCdMoe
11221:     *--------------------------------------------------------------------------
11222:     PROCEDURE TabCompo_MoevLostFocus()
11223:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11224:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11225: 
11226:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11227:             RETURN
11228:         ENDIF
11229: 
11230:         TRY
11231:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Moev", 5)
11232:                 RETURN
11233:             ENDIF
11234:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moev.Value)
11235:             IF EMPTY(loc_cCod)
11236:                 RETURN
11237:             ENDIF
11238: 
11239:             gb_4c_ValidandoUI = .T.
11240:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11241:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoevTmp")
11242:             gb_4c_ValidandoUI = .F.
11243: 
11244:             IF loc_nR <= 0 OR EOF("cursor_4c_MoevTmp")
11245:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11246:                 loc_oForm.Caption = "Moedas"
11247:                 loc_oForm.mAddColuna("CMoes", "C" + CHR(243) + "digo", "C", 6)
11248:                 loc_oForm.mAddColuna("DMoes", "Descri" + CHR(231) + CHR(227) + "o", "C", 30)
11249:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11250:                 loc_oForm.Show()
11251:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11252:                     loc_oPg.txt_4c_Moev.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11253:                     USE IN cursor_4c_BuscaAux
11254:                 ELSE
11255:                     loc_oPg.txt_4c_Moev.Value = ""
11256:                 ENDIF
11257:                 loc_oForm.Release()
11258:             ENDIF
11259:             IF USED("cursor_4c_MoevTmp")
11260:                 USE IN cursor_4c_MoevTmp
11261:             ENDIF
11262:         CATCH TO loc_oErro
11263:             gb_4c_ValidandoUI = .F.
11264:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoevLostFocus")
11265:         ENDTRY
11266:     ENDPROC
11267: 
11268:     *--------------------------------------------------------------------------
11269:     * TabCompo_FtioLostFocus - LostFocus de txt_4c_Ftio (Getftio)
11270:     * Valida codigo de feitio de venda - lookup em SigPrFti (Tipos<>1)
11271:     *--------------------------------------------------------------------------
11272:     PROCEDURE TabCompo_FtioLostFocus()
11273:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11274:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11275: 
11276:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11277:             RETURN
11278:         ENDIF
11279: 
11280:         TRY
11281:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Ftio", 5)
11282:                 RETURN
11283:             ENDIF
11284:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ftio.Value)
11285:             IF EMPTY(loc_cCod)
11286:                 THIS.CarregarComposicao()
11287:                 RETURN
11288:             ENDIF
11289: 
11290:             gb_4c_ValidandoUI = .T.
11291:             loc_cSQL = "SELECT Cods, Descs, Acrescs FROM SigPrFti WHERE RTRIM(Cods)=" + EscaparSQL(loc_cCod) + " AND Tipos<>1"
11292:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FtioTmp")
11293:             gb_4c_ValidandoUI = .F.
11294: 
11295:             IF loc_nR <= 0 OR EOF("cursor_4c_FtioTmp")
11296:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11297:                 loc_oForm.Caption = "Feitios"
11298:                 loc_oForm.mAddColuna("Cods", "C" + CHR(243) + "digo", "C", 8)
11299:                 loc_oForm.mAddColuna("Descs", "Descri" + CHR(231) + CHR(227) + "o", "C", 30)
11300:                 loc_oForm.mSQL = "SELECT Cods, Descs FROM SigPrFti WHERE Tipos<>1 ORDER BY Cods"
11301:                 loc_oForm.Show()
11302:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11303:                     loc_oPg.txt_4c_Ftio.Value = ALLTRIM(cursor_4c_BuscaAux.Cods)
11304:                     USE IN cursor_4c_BuscaAux
11305:                 ELSE
11306:                     loc_oPg.txt_4c_Ftio.Value = ""
11307:                     IF USED("cursor_4c_FtioTmp")
11308:                         USE IN cursor_4c_FtioTmp
11309:                     ENDIF
11310:                     THIS.CarregarComposicao()
11311:                     RETURN
11312:                 ENDIF
11313:                 loc_oForm.Release()
11314:             ENDIF
11315:             IF USED("cursor_4c_FtioTmp")
11316:                 USE IN cursor_4c_FtioTmp
11317:             ENDIF
11318:             THIS.CarregarComposicao()
11319:         CATCH TO loc_oErro
11320:             gb_4c_ValidandoUI = .F.
11321:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_FtioLostFocus")
11322:         ENDTRY
11323:     ENDPROC
11324: 
11325:     *--------------------------------------------------------------------------
11326:     * TabCompo_CmkpcLostFocus - LostFocus de txt_4c_Cmkpc (Get_cmkpc)
11327:     * Valida codigo de feitio de custo - lookup em SigPrFti (Tipos=1)
11328:     *--------------------------------------------------------------------------
11329:     PROCEDURE TabCompo_CmkpcLostFocus()
11330:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11331:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11332: 
11333:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11334:             RETURN
11335:         ENDIF
11336: 
11337:         TRY
11338:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Cmkpc", 5)
11339:                 RETURN
11340:             ENDIF
11341:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cmkpc.Value)
11342:             IF EMPTY(loc_cCod)
11343:                 THIS.CarregarComposicao()
11344:                 RETURN
11345:             ENDIF
11346: 
11347:             gb_4c_ValidandoUI = .T.
11348:             loc_cSQL = "SELECT Cods, Descs FROM SigPrFti WHERE RTRIM(Cods)=" + EscaparSQL(loc_cCod) + " AND Tipos=1"
11349:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmkpcTmp")
11350:             gb_4c_ValidandoUI = .F.
11351: 
11352:             IF loc_nR <= 0 OR EOF("cursor_4c_CmkpcTmp")
11353:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11354:                 loc_oForm.Caption = "Feitios de Custo"
11355:                 loc_oForm.mAddColuna("Cods", "C" + CHR(243) + "digo", "C", 8)
11356:                 loc_oForm.mAddColuna("Descs", "Descri" + CHR(231) + CHR(227) + "o", "C", 30)
11357:                 loc_oForm.mSQL = "SELECT Cods, Descs FROM SigPrFti WHERE Tipos=1 ORDER BY Cods"
11358:                 loc_oForm.Show()
11359:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11360:                     loc_oPg.txt_4c_Cmkpc.Value = ALLTRIM(cursor_4c_BuscaAux.Cods)
11361:                     USE IN cursor_4c_BuscaAux
11362:                 ELSE
11363:                     loc_oPg.txt_4c_Cmkpc.Value = ""
11364:                     IF USED("cursor_4c_CmkpcTmp")
11365:                         USE IN cursor_4c_CmkpcTmp
11366:                     ENDIF
11367:                     THIS.CarregarComposicao()
11368:                     RETURN
11369:                 ENDIF
11370:                 loc_oForm.Release()
11371:             ENDIF
11372:             IF USED("cursor_4c_CmkpcTmp")
11373:                 USE IN cursor_4c_CmkpcTmp
11374:             ENDIF
11375:             THIS.CarregarComposicao()
11376:         CATCH TO loc_oErro
11377:             gb_4c_ValidandoUI = .F.
11378:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_CmkpcLostFocus")
11379:         ENDTRY
11380:     ENDPROC
11381: 
11382:     *--------------------------------------------------------------------------
11383:     * TabCompo_StatusLostFocus - LostFocus de txt_4c_Status (getStatus)
11384:     * Atualiza composicao apos mudanca de status
11385:     *--------------------------------------------------------------------------
11386:     PROCEDURE TabCompo_StatusLostFocus()
11387:         TRY
11388:             THIS.CarregarComposicao()
11389:         CATCH TO loc_oErro
11390:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_StatusLostFocus")
11391:         ENDTRY
11392:     ENDPROC
11393: 
11394:     *--------------------------------------------------------------------------
11395:     * TabCompo_MargemLostFocus - LostFocus de txt_4c_Margem (getMargem)
11396:     * Recalcula preco de venda ao mudar margem/markup
11397:     *--------------------------------------------------------------------------
11398:     PROCEDURE TabCompo_MargemLostFocus()
11399:         TRY
11400:             THIS.CarregarComposicao()
11401:         CATCH TO loc_oErro
11402:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MargemLostFocus")
11403:         ENDTRY
11404:     ENDPROC
11405: 
11406:     *--------------------------------------------------------------------------
11407:     * TabCompo_FvendaLostFocus - LostFocus de txt_4c_Fvenda (getFvenda)
11408:     * Recalcula preco de venda ao mudar fator
11409:     *--------------------------------------------------------------------------
11410:     PROCEDURE TabCompo_FvendaLostFocus()
11411:         TRY
11412:             THIS.CarregarComposicao()
11413:         CATCH TO loc_oErro
11414:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_FvendaLostFocus")
11415:         ENDTRY
11416:     ENDPROC
11417: 
11418:     *--------------------------------------------------------------------------
11419:     * TabCompo_DescLostFocus - LostFocus de txt_4c_Desc (Get_Desc)
11420:     * Valida/atualiza descricao do material de composicao
11421:     *--------------------------------------------------------------------------
11422:     PROCEDURE TabCompo_DescLostFocus()
11423:         LOCAL loc_oPg, loc_cDesc, loc_oForm, loc_nR, loc_cSQL
11424:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11425: 
11426:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11427:             RETURN
11428:         ENDIF
11429: 
11430:         TRY
11431:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11432:                 RETURN
11433:             ENDIF
11434:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c_Desc.Value)
11435:             IF EMPTY(loc_cDesc)
11436:                 RETURN
11437:             ENDIF
11438: 
11439:             gb_4c_ValidandoUI = .T.
11440:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc)
11441:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescTmp")
11442:             gb_4c_ValidandoUI = .F.
11443: 
11444:             IF loc_nR <= 0 OR EOF("cursor_4c_DescTmp")
11445:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11446:                 loc_oForm.Caption = "Produtos"
11447:                 loc_oForm.mAddColuna("CPros", "C" + CHR(243) + "digo", "C", 14)
11448:                 loc_oForm.mAddColuna("DPros", "Descri" + CHR(231) + CHR(227) + "o", "C", 40)
11449:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY DPros"
11450:                 loc_oForm.Show()
11451:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11452:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11453:                     IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
11454:                         loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11455:                     ENDIF
11456:                     USE IN cursor_4c_BuscaAux
11457:                 ELSE
11458:                     loc_oPg.txt_4c_Desc.Value = ""
11459:                 ENDIF
11460:                 loc_oForm.Release()
11461:             ELSE
11462:                 IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
11463:                     loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_DescTmp.CPros)
11464:                 ENDIF
11465:             ENDIF
11466:             IF USED("cursor_4c_DescTmp")
11467:                 USE IN cursor_4c_DescTmp
11468:             ENDIF
11469:         CATCH TO loc_oErro
11470:             gb_4c_ValidandoUI = .F.
11471:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_DescLostFocus")
11472:         ENDTRY
11473:     ENDPROC
11474: 
11475:     *--------------------------------------------------------------------------
11476:     * TabCompo_MatPLostFocus - LostFocus de txt_4c_MatP (Get_MatP)
11477:     * Valida codigo de material principal - lookup em SigCdPro
11478:     *--------------------------------------------------------------------------
11479:     PROCEDURE TabCompo_MatPLostFocus()
11480:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11481:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11482: 
11483:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11484:             RETURN
11485:         ENDIF
11486: 
11487:         TRY
11488:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
11489:                 RETURN
11490:             ENDIF
11491:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_MatP.Value)
11492:             IF EMPTY(loc_cCod)
11493:                 RETURN
11494:             ENDIF
11495: 
11496:             gb_4c_ValidandoUI = .T.
11497:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(CPros)=" + EscaparSQL(loc_cCod)
11498:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatPTmp")
11499:             gb_4c_ValidandoUI = .F.
11500: 
11501:             IF loc_nR <= 0 OR EOF("cursor_4c_MatPTmp")
11502:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11503:                 loc_oForm.Caption = "Material Principal"
11504:                 loc_oForm.mAddColuna("CPros", "C" + CHR(243) + "digo", "C", 14)
11505:                 loc_oForm.mAddColuna("DPros", "Descri" + CHR(231) + CHR(227) + "o", "C", 40)
11506:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY CPros"
11507:                 loc_oForm.Show()
11508:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11509:                     loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11510:                     IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11511:                         loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11512:                     ENDIF
11513:                     USE IN cursor_4c_BuscaAux
11514:                 ELSE
11515:                     loc_oPg.txt_4c_MatP.Value = ""
11516:                 ENDIF
11517:                 loc_oForm.Release()
11518:             ELSE
11519:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11520:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_MatPTmp.DPros)
11521:                 ENDIF
11522:             ENDIF
11523:             IF USED("cursor_4c_MatPTmp")
11524:                 USE IN cursor_4c_MatPTmp
11525:             ENDIF
11526:         CATCH TO loc_oErro
11527:             gb_4c_ValidandoUI = .F.
11528:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MatPLostFocus")
11529:         ENDTRY
11530:     ENDPROC
11531: 
11532:     *--------------------------------------------------------------------------
11533:     * TabCompo_DesccpLostFocus - LostFocus de txt_4c__desccp (get_desccp)
11534:     * Valida descricao de sub-componente - lookup em SigCdPro
11535:     *--------------------------------------------------------------------------
11536:     PROCEDURE TabCompo_DesccpLostFocus()
11537:         LOCAL loc_oPg, loc_cDesc, loc_oForm, loc_nR, loc_cSQL
11538:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11539: 
11540:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11541:             RETURN
11542:         ENDIF
11543: 
11544:         TRY
11545:             IF NOT PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11546:                 RETURN
11547:             ENDIF
11548:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c__desccp.Value)
11549:             IF EMPTY(loc_cDesc)
11550:                 RETURN
11551:             ENDIF
11552: 
11553:             gb_4c_ValidandoUI = .T.
11554:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc)
11555:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesccpTmp")
11556:             gb_4c_ValidandoUI = .F.
11557: 
11558:             IF loc_nR <= 0 OR EOF("cursor_4c_DesccpTmp")
11559:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11560:                 loc_oForm.Caption = "Sub-Componentes"
11561:                 loc_oForm.mAddColuna("CPros", "C" + CHR(243) + "digo", "C", 14)
11562:                 loc_oForm.mAddColuna("DPros", "Descri" + CHR(231) + CHR(227) + "o", "C", 40)
11563:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY DPros"
11564:                 loc_oForm.Show()
11565:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11566:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11567:                     IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11568:                         loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11569:                     ENDIF
11570:                     USE IN cursor_4c_BuscaAux
11571:                 ELSE
11572:                     loc_oPg.txt_4c__desccp.Value = ""
11573:                 ENDIF
11574:                 loc_oForm.Release()
11575:             ELSE
11576:                 IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11577:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_DesccpTmp.CPros)
11578:                 ENDIF
11579:             ENDIF
11580:             IF USED("cursor_4c_DesccpTmp")
11581:                 USE IN cursor_4c_DesccpTmp
11582:             ENDIF
11583:         CATCH TO loc_oErro
11584:             gb_4c_ValidandoUI = .F.
11585:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_DesccpLostFocus")
11586:         ENDTRY
11587:     ENDPROC
11588: 
11589:     *--------------------------------------------------------------------------
11590:     * TabCompo_MatsubLostFocus - LostFocus de txt_4c__matsub (get_matsub)
11591:     * Valida codigo do substituto - lookup em SigCdPro
11592:     *--------------------------------------------------------------------------
11593:     PROCEDURE TabCompo_MatsubLostFocus()
11594:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11595:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11596: 
11597:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11598:             RETURN
11599:         ENDIF
11600: 
11601:         TRY
11602:             IF NOT PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11603:                 RETURN
11604:             ENDIF
11605:             loc_cCod = ALLTRIM(loc_oPg.txt_4c__matsub.Value)
11606:             IF EMPTY(loc_cCod)
11607:                 RETURN
11608:             ENDIF
11609: 
11610:             gb_4c_ValidandoUI = .T.
11611:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(CPros)=" + EscaparSQL(loc_cCod)
11612:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatsubTmp")
11613:             gb_4c_ValidandoUI = .F.
11614: 
11615:             IF loc_nR <= 0 OR EOF("cursor_4c_MatsubTmp")
11616:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11617:                 loc_oForm.Caption = "Produto Substituto"
11618:                 loc_oForm.mAddColuna("CPros", "C" + CHR(243) + "digo", "C", 14)
11619:                 loc_oForm.mAddColuna("DPros", "Descri" + CHR(231) + CHR(227) + "o", "C", 40)
11620:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY CPros"
11621:                 loc_oForm.Show()
11622:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11623:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11624:                     IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11625:                         loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11626:                     ENDIF
11627:                     USE IN cursor_4c_BuscaAux
11628:                 ELSE
11629:                     loc_oPg.txt_4c__matsub.Value = ""
11630:                 ENDIF
11631:                 loc_oForm.Release()
11632:             ELSE
11633:                 IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11634:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_MatsubTmp.DPros)
11635:                 ENDIF
11636:             ENDIF
11637:             IF USED("cursor_4c_MatsubTmp")
11638:                 USE IN cursor_4c_MatsubTmp
11639:             ENDIF
11640:         CATCH TO loc_oErro
11641:             gb_4c_ValidandoUI = .F.
11642:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MatsubLostFocus")
11643:         ENDTRY
11644:     ENDPROC
11645: 
11646:     *--------------------------------------------------------------------------
11647:     * CmdCompoIncluirClick - Botao incluir linha na composicao (grdCompo)
11648:     *--------------------------------------------------------------------------
11649:     PROCEDURE CmdCompoIncluirClick()
11650:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
11651:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11652:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11653: 
11654:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11655:             RETURN
11656:         ENDIF
11657:         IF EMPTY(loc_cCpros)
11658:             RETURN
11659:         ENDIF
11660: 
11661:         TRY
11662:             loc_cSQL = "INSERT INTO SIGPRCPO (cpros, dtmovs, cidchaves) VALUES (" + ;
11663:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID())"
11664:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11665:             IF loc_nR > 0
11666:                 THIS.CarregarComposicao()
11667:                 IF PEMSTATUS(loc_oPg, "grd_4c_Compo", 5)
11668:                     loc_oPg.grd_4c_Compo.SetFocus()
11669:                 ENDIF
11670:             ELSE
11671:                 MsgErro("Erro ao incluir linha na composi" + CHR(231) + CHR(227) + "o.", "FormProduto.CmdCompoIncluirClick")
11672:             ENDIF
11673:         CATCH TO loc_oErro
11674:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoIncluirClick")
11675:         ENDTRY
11676:     ENDPROC
11677: 
11678:     *--------------------------------------------------------------------------
11679:     * CmdCompoExcluirClick - Botao excluir linha da composicao (grdCompo)
11680:     *--------------------------------------------------------------------------
11681:     PROCEDURE CmdCompoExcluirClick()
11682:         LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR, loc_oPg
11683:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11684:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11685: 
11686:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11687:             RETURN
11688:         ENDIF
11689:         IF NOT USED("cursor_4c_Compo") OR EOF("cursor_4c_Compo")
11690:             RETURN
11691:         ENDIF
11692: 
11693:         TRY
11694:             loc_cMats = ALLTRIM(NVL(cursor_4c_Compo.mats, ""))
11695:             IF EMPTY(loc_cMats)
11696:                 RETURN
11697:             ENDIF
11698:             loc_cSQL = "DELETE FROM SIGPRCPO WHERE RTRIM(cpros)=" + EscaparSQL(loc_cCpros) + ;
11699:                        " AND RTRIM(mats)=" + EscaparSQL(loc_cMats)
11700:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11701:             IF loc_nR > 0
11702:                 THIS.CarregarComposicao()
11703:             ELSE
11704:                 MsgErro("Erro ao excluir linha da composi" + CHR(231) + CHR(227) + "o.", "FormProduto.CmdCompoExcluirClick")
11705:             ENDIF
11706:         CATCH TO loc_oErro
11707:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoExcluirClick")
11708:         ENDTRY
11709:     ENDPROC
11710: 
11711:     *--------------------------------------------------------------------------
11712:     * CmdCompoAtualizarClick - Botao atualizar/recalcular precos da composicao
11713:     *--------------------------------------------------------------------------
11714:     PROCEDURE CmdCompoAtualizarClick()
11715:         TRY
11716:             THIS.CarregarComposicao()
11717:         CATCH TO loc_oErro
11718:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoAtualizarClick")
11719:         ENDTRY
11720:     ENDPROC
11721: 
11722:     *--------------------------------------------------------------------------
11723:     * CmdCompoAtuPesosClick - Botao atualizar pesos da composicao
11724:     *--------------------------------------------------------------------------
11725:     PROCEDURE CmdCompoAtuPesosClick()
11726:         TRY
11727:             THIS.CarregarComposicao()
11728:         CATCH TO loc_oErro
11729:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoAtuPesosClick")
11730:         ENDTRY
11731:     ENDPROC
11732: 
11733:     *--------------------------------------------------------------------------
11734:     * CmdCompoRecalcClick - Botao recalcular todos os precos
11735:     *--------------------------------------------------------------------------
11736:     PROCEDURE CmdCompoRecalcClick()
11737:         TRY
11738:             THIS.CarregarComposicao()
11739:         CATCH TO loc_oErro
11740:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoRecalcClick")
11741:         ENDTRY
11742:     ENDPROC
11743: 
11744:     *--------------------------------------------------------------------------
11745:     * CmdSubCpIncluirClick - Botao incluir sub-componente (grdsubcp)
11746:     *--------------------------------------------------------------------------
11747:     PROCEDURE CmdSubCpIncluirClick()
11748:         LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR, loc_oPg
11749:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11750:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11751: 
11752:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11753:             RETURN
11754:         ENDIF
11755:         IF EMPTY(loc_cCpros)
11756:             RETURN
11757:         ENDIF
11758:         IF NOT USED("cursor_4c_Compo") OR EOF("cursor_4c_Compo")
11759:             MsgErro("Selecione um item na composi" + CHR(231) + CHR(227) + "o principal primeiro.", "FormProduto.CmdSubCpIncluirClick")
11760:             RETURN
11761:         ENDIF
11762: 
11763:         TRY
11764:             loc_cMats = ALLTRIM(NVL(cursor_4c_Compo.mats, ""))
11765:             IF EMPTY(loc_cMats)
11766:                 MsgErro("Item da composi" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lido.", "FormProduto.CmdSubCpIncluirClick")
11767:                 RETURN
11768:             ENDIF
11769:             loc_cSQL = "INSERT INTO sigsubcp (cpros, dtmovs, cidchaves, matsubs) VALUES (" + ;
11770:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID(), " + EscaparSQL(loc_cMats) + ")"
11771:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11772:             IF loc_nR > 0
11773:                 THIS.CarregarComposicao()
11774:                 IF PEMSTATUS(loc_oPg, "grd_4c_SubCompo", 5)
11775:                     loc_oPg.grd_4c_SubCompo.SetFocus()
11776:                 ENDIF
11777:             ELSE
11778:                 MsgErro("Erro ao incluir sub-componente.", "FormProduto.CmdSubCpIncluirClick")
11779:             ENDIF
11780:         CATCH TO loc_oErro
11781:             MsgErro(loc_oErro.Message, "FormProduto.CmdSubCpIncluirClick")
11782:         ENDTRY
11783:     ENDPROC
11784: 
11785:     *--------------------------------------------------------------------------
11786:     * CmdSubCpExcluirClick - Botao excluir sub-componente (grdsubcp)
11787:     *--------------------------------------------------------------------------
11788:     PROCEDURE CmdSubCpExcluirClick()
11789:         LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR
11790:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11791: 
11792:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11793:             RETURN
11794:         ENDIF
11795:         IF NOT USED("cursor_4c_SubCompo") OR EOF("cursor_4c_SubCompo")
11796:             RETURN
11797:         ENDIF
11798: 
11799:         TRY
11800:             loc_cMats = ALLTRIM(NVL(cursor_4c_SubCompo.mats, ""))
11801:             IF EMPTY(loc_cMats)
11802:                 RETURN
11803:             ENDIF
11804:             loc_cSQL = "DELETE FROM sigsubcp WHERE RTRIM(cpros)=" + EscaparSQL(loc_cCpros) + ;
11805:                        " AND RTRIM(mats)=" + EscaparSQL(loc_cMats)
11806:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11807:             IF loc_nR > 0
11808:                 THIS.CarregarComposicao()
11809:             ELSE
11810:                 MsgErro("Erro ao excluir sub-componente.", "FormProduto.CmdSubCpExcluirClick")
11811:             ENDIF
11812:         CATCH TO loc_oErro
11813:             MsgErro(loc_oErro.Message, "FormProduto.CmdSubCpExcluirClick")
11814:         ENDTRY
11815:     ENDPROC
11816: 
11817:     *--------------------------------------------------------------------------
11818:     * CmdCalcValsClick - Botao calcular valores de preco/custo
11819:     *--------------------------------------------------------------------------
11820:     PROCEDURE CmdCalcValsClick()
11821:         TRY
11822:             THIS.CarregarComposicao()
11823:         CATCH TO loc_oErro
11824:             MsgErro(loc_oErro.Message, "FormProduto.CmdCalcValsClick")
11825:         ENDTRY
11826:     ENDPROC
11827: 
11828:     *--------------------------------------------------------------------------
11829:     * CmdPesoMClick - Botao calcular/atualizar peso medio
11830:     *--------------------------------------------------------------------------
11831:     PROCEDURE CmdPesoMClick()
11832:         LOCAL loc_oPg, loc_cCpros, loc_cSQL, loc_nR
11833:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11834:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11835: 
11836:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
11837:             RETURN
11838:         ENDIF
11839: 
11840:         TRY
11841:             *-- Busca peso calculado a partir da composicao
11842:             loc_cSQL = "SELECT SUM(c.qtds * p.pesobs) AS peso_calc " + ;
11843:                        "FROM SIGPRCPO c " + ;
11844:                        "LEFT JOIN SigCdPro p ON RTRIM(c.mats) = RTRIM(p.cpros) " + ;
11845:                        "WHERE RTRIM(c.cpros) = " + EscaparSQL(loc_cCpros)
11846:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PesoMTmp")
11847:             IF loc_nR > 0 AND !EOF("cursor_4c_PesoMTmp")
11848:                 IF PEMSTATUS(loc_oPg, "txt_4c_Pesom", 5)
11849:                     loc_oPg.txt_4c_Pesom.Value = NVL(cursor_4c_PesoMTmp.peso_calc, 0)
11850:                 ENDIF
11851:             ENDIF
11852:             IF USED("cursor_4c_PesoMTmp")
11853:                 USE IN cursor_4c_PesoMTmp
11854:             ENDIF
11855:         CATCH TO loc_oErro
11856:             MsgErro(loc_oErro.Message, "FormProduto.CmdPesoMClick")
11857:         ENDTRY
11858:     ENDPROC
11859: 
11860:     *--------------------------------------------------------------------------
11861:     * CustosGrd_AfterRowColChange - Grid custos: ao mudar linha/coluna
11862:     * Atualiza campos txt_4c_DescCusto e txt_4c_DGruCompos com dados do item
11863:     *--------------------------------------------------------------------------
11864:     PROCEDURE CustosGrd_AfterRowColChange(par_nColIndex)
11865:         LOCAL loc_oPg, loc_cMats, loc_cSQL, loc_nR
11866:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11867: 
11868:         TRY
11869:             IF USED("cursor_4c_CompoCusto") AND !EOF("cursor_4c_CompoCusto")
11870:                 *-- Atualizar campo Descricao
11871:                 IF PEMSTATUS(loc_oPg, "txt_4c_DescCusto", 5)
11872:                     loc_oPg.txt_4c_DescCusto.Value = ALLTRIM(NVL(cursor_4c_CompoCusto.dcompos, ""))
11873:                 ENDIF
11874: 
11875:                 *-- Buscar descricao do grupo com base no material
11876:                 loc_cMats = ALLTRIM(NVL(cursor_4c_CompoCusto.mats, ""))
11877:                 IF !EMPTY(loc_cMats) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
11878:                     loc_cSQL = "SELECT g.dgrus FROM SigCdPro p " + ;
11879:                                "INNER JOIN SigCdGrp g ON RTRIM(p.cgrus) = RTRIM(g.cgrus) " + ;
11880:                                "WHERE RTRIM(p.cpros) = " + EscaparSQL(loc_cMats)
11881:                     gb_4c_ValidandoUI = .T.
11882:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoTmpC")
11883:                     gb_4c_ValidandoUI = .F.
11884:                     IF loc_nR > 0 AND !EOF("cursor_4c_GrupoTmpC")
11885:                         IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
11886:                             loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(NVL(cursor_4c_GrupoTmpC.dgrus, ""))
11887:                         ENDIF
11888:                     ENDIF
11889:                     IF USED("cursor_4c_GrupoTmpC")
11890:                         USE IN cursor_4c_GrupoTmpC
11891:                     ENDIF
11892:                 ELSE
11893:                     IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
11894:                         loc_oPg.txt_4c_DGruCompos.Value = ""
11895:                     ENDIF
11896:                 ENDIF
11897:             ENDIF
11898:         CATCH TO loc_oErro
11899:             gb_4c_ValidandoUI = .F.
11900:             MsgErro(loc_oErro.Message, "FormProduto.CustosGrd_AfterRowColChange")
11901:         ENDTRY
11902:     ENDPROC
11903: 
11904:     *--------------------------------------------------------------------------
11905:     * ConsultaGrd_AfterRowColChange - Grid GrdCons consulta: ao sair de coluna
11906:     * Col4 (Fase/Grupos): busca descricao em SigCdPrf; se nao encontrado abre lookup
11907:     * Col5 (Descricao fase): busca grupos em SigCdPrf por descricao
11908:     * Col8 (Cat): busca descricao em SigCdCat; se nao encontrado abre lookup
11909:     *--------------------------------------------------------------------------
11910:     PROCEDURE ConsultaGrd_AfterRowColChange(par_nColIndex)
11911:         LOCAL loc_oPg, loc_cSQL, loc_nR, loc_cGrupos, loc_cCats, loc_cDcompos
11912:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
11913: 
11914:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11915:             RETURN
11916:         ENDIF
11917: 
11918:         IF !USED("cursor_4c_Consulta") OR EOF("cursor_4c_Consulta")
11919:             RETURN
11920:         ENDIF
11921: 
11922:         TRY
11923:             DO CASE
11924: 
11925:             *-- Coluna 4 (Fase/Grupos): busca descricao da fase em SigCdPrf
11926:             CASE par_nColIndex = 4
11927:                 loc_cGrupos = ALLTRIM(NVL(cursor_4c_Consulta.grupos, ""))
11928:                 IF !EMPTY(loc_cGrupos)
11929:                     loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr WHERE RTRIM(Codigos) = " + EscaparSQL(loc_cGrupos)
11930:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfDesc")
11931:                     IF loc_nR > 0 AND !EOF("cursor_4c_PrfDesc")
11932:                         REPLACE cursor_4c_Consulta.dcompos WITH ALLTRIM(NVL(cursor_4c_PrfDesc.descrs, ""))
11933:                         IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
11934:                             loc_oPg.grd_4c_Consulta.Refresh()
11935:                         ENDIF
11936:                     ELSE
11937:                         THIS.AbrirLookupConsultaFase()
11938:                     ENDIF
11939:                     IF USED("cursor_4c_PrfDesc")
11940:                         USE IN cursor_4c_PrfDesc
11941:                     ENDIF
11942:                 ENDIF
11943: 
11944:             *-- Coluna 5 (Descricao fase): busca grupos em SigCdPrf por descricao
11945:             CASE par_nColIndex = 5
11946:                 loc_cDcompos = ALLTRIM(NVL(cursor_4c_Consulta.dcompos, ""))
11947:                 IF !EMPTY(loc_cDcompos)
11948:                     loc_cSQL = "SELECT TOP 1 Codigos AS grupos, Descrs AS descrs FROM SigCdGcr WHERE RTRIM(Descrs) = " + EscaparSQL(loc_cDcompos)
11949:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfGrp")
11950:                     IF loc_nR > 0 AND !EOF("cursor_4c_PrfGrp")

*-- Linhas 11987 a 12220:
11987:     *--------------------------------------------------------------------------
11988:     * AbrirLookupConsultaFase - Abre lookup SigCdPrf para selecionar fase (col 4)
11989:     *--------------------------------------------------------------------------
11990:     PROCEDURE AbrirLookupConsultaFase()
11991:         LOCAL loc_oPg, loc_oBusca, loc_cGrupos, loc_cDescrs
11992: 
11993:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
11994: 
11995:         TRY
11996:             IF !USED("cursor_4c_Consulta") OR EOF("cursor_4c_Consulta")
11997:                 RETURN
11998:             ENDIF
11999: 
12000:             loc_cGrupos = ALLTRIM(NVL(cursor_4c_Consulta.grupos, ""))
12001:             loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPrf", "cursor_4c_PrfSel", "grupos", loc_cGrupos, "Selecionar Fase")
12002:             loc_oBusca.mAddColuna("grupos", "", "C" + CHR(243) + "digo")
12003:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
12004:             loc_oBusca.Show()
12005: 
12006:             IF loc_oBusca.this_lSelecionou
12007:                 IF USED("cursor_4c_PrfSel")
12008:                     loc_cGrupos = ALLTRIM(NVL(cursor_4c_PrfSel.grupos, ""))
12009:                     loc_cDescrs = ALLTRIM(NVL(cursor_4c_PrfSel.descrs, ""))
12010:                     REPLACE cursor_4c_Consulta.grupos  WITH loc_cGrupos
12011:                     REPLACE cursor_4c_Consulta.dcompos WITH loc_cDescrs
12012:                     IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
12013:                         loc_oPg.grd_4c_Consulta.Refresh()
12014:                     ENDIF
12015:                 ENDIF
12016:             ELSE
12017:                 REPLACE cursor_4c_Consulta.grupos  WITH ""
12018:                 REPLACE cursor_4c_Consulta.dcompos WITH ""
12019:             ENDIF
12020: 
12021:             IF USED("cursor_4c_PrfSel")
12022:                 USE IN cursor_4c_PrfSel
12023:             ENDIF
12024:             loc_oBusca.Release()
12025:             loc_oBusca = .NULL.
12026: 
12027:         CATCH TO loc_oErro
12028:             MsgErro(loc_oErro.Message, "FormProduto.AbrirLookupConsultaFase")
12029:         ENDTRY
12030:     ENDPROC
12031: 
12032:     *--------------------------------------------------------------------------
12033:     * AbrirLookupConsultaCat - Abre lookup SigCdCat para selecionar categoria (col 8)
12034:     *--------------------------------------------------------------------------
12035:     PROCEDURE AbrirLookupConsultaCat()
12036:         LOCAL loc_oPg, loc_oBusca, loc_cCods, loc_cDescs
12037: 
12038:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
12039: 
12040:         TRY
12041:             IF !USED("cursor_4c_Consulta") OR EOF("cursor_4c_Consulta")
12042:                 RETURN
12043:             ENDIF
12044: 
12045:             loc_cCods  = ALLTRIM(NVL(cursor_4c_Consulta.cats, ""))
12046:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCat", "cursor_4c_CatSel", "cods", loc_cCods, "Selecionar Categoria")
12047:             loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
12048:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
12049:             loc_oBusca.Show()
12050: 
12051:             IF loc_oBusca.this_lSelecionou
12052:                 IF USED("cursor_4c_CatSel")
12053:                     loc_cCods  = ALLTRIM(NVL(cursor_4c_CatSel.cods,  ""))
12054:                     loc_cDescs = ALLTRIM(NVL(cursor_4c_CatSel.descs, ""))
12055:                     REPLACE cursor_4c_Consulta.cats   WITH loc_cCods
12056:                     REPLACE cursor_4c_Consulta.dscgrp WITH loc_cDescs
12057:                     IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
12058:                         loc_oPg.grd_4c_Consulta.Refresh()
12059:                     ENDIF
12060:                 ENDIF
12061:             ELSE
12062:                 REPLACE cursor_4c_Consulta.cats   WITH ""
12063:                 REPLACE cursor_4c_Consulta.dscgrp WITH ""
12064:             ENDIF
12065: 
12066:             IF USED("cursor_4c_CatSel")
12067:                 USE IN cursor_4c_CatSel
12068:             ENDIF
12069:             loc_oBusca.Release()
12070:             loc_oBusca = .NULL.
12071: 
12072:         CATCH TO loc_oErro
12073:             MsgErro(loc_oErro.Message, "FormProduto.AbrirLookupConsultaCat")
12074:         ENDTRY
12075:     ENDPROC
12076: 
12077:     *--------------------------------------------------------------------------
12078:     * CmbTiposCustoValid - ComboBox tipo custo: ao mudar selecao, recarrega grid
12079:     *--------------------------------------------------------------------------
12080:     PROCEDURE CmbTiposCustoValid()
12081:         TRY
12082:             THIS.CarregarCustos()
12083:         CATCH TO loc_oErro
12084:             MsgErro(loc_oErro.Message, "FormProduto.CmbTiposCustoValid")
12085:         ENDTRY
12086:     ENDPROC
12087: 
12088:     *--------------------------------------------------------------------------
12089:     * CmdCustoIncluirClick - Botao incluir linha no grid de custo
12090:     * Insere novo registro em SIGPRCPO com Tipos = valor selecionado no combo
12091:     *--------------------------------------------------------------------------
12092:     PROCEDURE CmdCustoIncluirClick()
12093:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg, loc_nTipo
12094:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
12095:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12096: 
12097:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12098:             RETURN
12099:         ENDIF
12100:         IF EMPTY(loc_cCpros)
12101:             RETURN
12102:         ENDIF
12103: 
12104:         TRY
12105:             loc_nTipo = 1
12106:             IF PEMSTATUS(loc_oPg, "cmb_4c_TiposCusto", 5)
12107:                 loc_nTipo = NVL(loc_oPg.cmb_4c_TiposCusto.ListIndex, 1)
12108:                 *-- ListIndex 1=Todos: usar tipo 1; demais: usar o proprio valor
12109:                 IF loc_nTipo < 1
12110:                     loc_nTipo = 1
12111:                 ENDIF
12112:             ENDIF
12113: 
12114:             loc_cSQL = "INSERT INTO SIGPRCPO (cpros, dtmovs, cidchaves, tipos) VALUES (" + ;
12115:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID(), " + TRANSFORM(loc_nTipo) + ")"
12116:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12117:             IF loc_nR > 0
12118:                 THIS.CarregarCustos()
12119:                 IF PEMSTATUS(loc_oPg, "grd_4c_CompoCusto", 5)
12120:                     loc_oPg.grd_4c_CompoCusto.SetFocus()
12121:                 ENDIF
12122:             ELSE
12123:                 MsgErro("Erro ao incluir linha no custo.", "FormProduto.CmdCustoIncluirClick")
12124:             ENDIF
12125:         CATCH TO loc_oErro
12126:             MsgErro(loc_oErro.Message, "FormProduto.CmdCustoIncluirClick")
12127:         ENDTRY
12128:     ENDPROC
12129: 
12130:     *--------------------------------------------------------------------------
12131:     * CmdCustoExcluirClick - Botao excluir linha do grid de custo
12132:     * Remove registro de SIGPRCPO com base no material selecionado
12133:     *--------------------------------------------------------------------------
12134:     PROCEDURE CmdCustoExcluirClick()
12135:         LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR, loc_oPg, loc_lConfirma
12136:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
12137:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12138: 
12139:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12140:             RETURN
12141:         ENDIF
12142:         IF NOT USED("cursor_4c_CompoCusto") OR EOF("cursor_4c_CompoCusto")
12143:             RETURN
12144:         ENDIF
12145: 
12146:         TRY
12147:             loc_cMats = ALLTRIM(NVL(cursor_4c_CompoCusto.mats, ""))
12148: 
12149:             IF EMPTY(loc_cMats)
12150:                 MsgAviso("Selecione um item para excluir.", "FormProduto")
12151:                 RETURN
12152:             ENDIF
12153: 
12154:             loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do item '" + loc_cMats + "'?", "FormProduto")
12155:             IF !loc_lConfirma
12156:                 RETURN
12157:             ENDIF
12158: 
12159:             loc_cSQL = "DELETE FROM SIGPRCPO WHERE RTRIM(cpros) = " + EscaparSQL(loc_cCpros) + ;
12160:                        " AND RTRIM(mats) = " + EscaparSQL(loc_cMats)
12161:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12162:             IF loc_nR > 0
12163:                 THIS.CarregarCustos()
12164:             ELSE
12165:                 MsgErro("Erro ao excluir linha do custo.", "FormProduto.CmdCustoExcluirClick")
12166:             ENDIF
12167:         CATCH TO loc_oErro
12168:             MsgErro(loc_oErro.Message, "FormProduto.CmdCustoExcluirClick")
12169:         ENDTRY
12170:     ENDPROC
12171: 
12172:     *==========================================================================
12173:     * METODOS DA ABA FASES (Tab 7 - PgDadosFaseP)
12174:     *==========================================================================
12175: 
12176:     *--------------------------------------------------------------------------
12177:     * GrdFasesAfterRowColChange - Atualiza imagem + descricao ao navegar no grid
12178:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
12179:     *--------------------------------------------------------------------------
12180:     PROCEDURE GrdFasesAfterRowColChange
12181:         LPARAMETERS par_nColIndex
12182:         LOCAL loc_oPg, loc_cCpros, loc_cGrupos, loc_cSQL, loc_nR, loc_cArquivo
12183:         LOCAL loc_nOrdems
12184: 
12185:         TRY
12186:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12187:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12188: 
12189:             IF EMPTY(loc_cCpros) OR !USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases") OR BOF("cursor_4c_Fases")
12190:                 RETURN
12191:             ENDIF
12192: 
12193:             loc_cGrupos  = ALLTRIM(NVL(cursor_4c_Fases.grupos, ""))
12194:             loc_nOrdems  = NVL(cursor_4c_Fases.ordems, 0)
12195: 
12196:             *-- Limpar imagem anterior
12197:             IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5)
12198:                 loc_oPg.img_4c_ImgFigJpg.Picture = ""
12199:                 loc_oPg.img_4c_ImgFigJpg.Visible = .F.
12200:             ENDIF
12201: 
12202:             *-- Carregar imagem FigProcs da fase atual (campo binario em SigCdPrf)
12203:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND loc_nOrdems > 0
12204:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
12205:                     SELECT TOP 1 FigProcs FROM SigCdPrf
12206:                     WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12207:                     AND ordems = <<loc_nOrdems>>
12208:                 ENDTEXT
12209:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigFase")
12210:                 IF loc_nR > 0 AND !EOF("cursor_4c_FigFase")
12211:                     IF !EMPTY(NVL(cursor_4c_FigFase.FigProcs, ""))
12212:                         loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
12213:                         IF (STRTOFILE(cursor_4c_FigFase.FigProcs, loc_cArquivo) > 0)
12214:                             IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5) AND FILE(loc_cArquivo)
12215:                                 loc_oPg.img_4c_ImgFigJpg.Picture = loc_cArquivo
12216:                                 loc_oPg.img_4c_ImgFigJpg.Visible = .T.
12217:                             ENDIF
12218:                         ENDIF
12219:                     ENDIF
12220:                 ENDIF

*-- Linhas 12257 a 12302:
12257: 
12258:     *--------------------------------------------------------------------------
12259:     * GrdMatrizesAfterRowColChange - Atualiza imagem ao navegar no grid de matrizes
12260:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
12261:     *--------------------------------------------------------------------------
12262:     PROCEDURE GrdMatrizesAfterRowColChange
12263:         LPARAMETERS par_nColIndex
12264:         LOCAL loc_oPg, loc_cCmats, loc_cSQL, loc_nR, loc_cArquivo, loc_cFigB64
12265: 
12266:         TRY
12267:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12268: 
12269:             *-- Limpar imagem anterior
12270:             IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5)
12271:                 loc_oPg.img_4c_ImgBorracha.Picture = ""
12272:                 loc_oPg.img_4c_ImgBorracha.Visible = .F.
12273:             ENDIF
12274: 
12275:             IF !USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes") OR BOF("cursor_4c_Matrizes")
12276:                 RETURN
12277:             ENDIF
12278: 
12279:             loc_cCmats = ALLTRIM(NVL(cursor_4c_Matrizes.cmats, ""))
12280:             IF EMPTY(loc_cCmats) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
12281:                 RETURN
12282:             ENDIF
12283: 
12284:             *-- Carregar imagem FigJpgs do produto matriz (SigCdPro)
12285:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12286:                 SELECT TOP 1 FigJpgs FROM SigCdPro WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCmats)>>)
12287:             ENDTEXT
12288:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigBorr")
12289:             IF loc_nR > 0 AND !EOF("cursor_4c_FigBorr")
12290:                 loc_cFigB64 = NVL(cursor_4c_FigBorr.FigJpgs, "")
12291:                 IF !EMPTY(loc_cFigB64)
12292:                     *-- Converter de Base64 para binario
12293:                     LOCAL loc_cFigBin
12294:                     loc_cFigBin = STRCONV( ;
12295:                         STRTRAN(STRTRAN(STRTRAN(loc_cFigB64, ;
12296:                             "data:image/png;base64,", ""), ;
12297:                             "data:image/jpeg;base64,", ""), ;
12298:                             "data:image/jpg;base64,", ""), 14)
12299:                     loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
12300:                     IF STRTOFILE(loc_cFigBin, loc_cArquivo) > 0
12301:                         IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) AND FILE(loc_cArquivo)
12302:                             loc_oPg.img_4c_ImgBorracha.Picture = loc_cArquivo

*-- Linhas 12317 a 13019:
12317:     *--------------------------------------------------------------------------
12318:     * ImgFigJpgClick - Clique na imagem da fase: abre zoom
12319:     *--------------------------------------------------------------------------
12320:     PROCEDURE ImgFigJpgClick()
12321:         LOCAL loc_oPg, loc_cArquivo
12322:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12323:         IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5)
12324:             loc_cArquivo = loc_oPg.img_4c_ImgFigJpg.Picture
12325:             IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
12326:                 MsgInfo("Zoom de imagem: " + loc_cArquivo, "Imagem da Fase")
12327:             ENDIF
12328:         ENDIF
12329:     ENDPROC
12330: 
12331:     *--------------------------------------------------------------------------
12332:     * TabFases_CodcorsKeyPress - F4 no campo Cor (aba Fases) abre lookup
12333:     *--------------------------------------------------------------------------
12334:     PROCEDURE TabFases_CodcorsKeyPress
12335:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12336:         IF par_nKeyCode = 115
12337:             THIS.AbrirLookupCorFas()
12338:         ENDIF
12339:     ENDPROC
12340: 
12341:     *--------------------------------------------------------------------------
12342:     * TabFases_CodcorsLostFocus - LostFocus valida cor na aba Fases
12343:     *--------------------------------------------------------------------------
12344:     PROCEDURE TabFases_CodcorsLostFocus()
12345:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12346:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12347:         IF !PEMSTATUS(loc_oPg, "txt_4c_CodcorsFas", 5)
12348:             RETURN
12349:         ENDIF
12350:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodcorsFas.Value)
12351:         IF EMPTY(loc_cCod)
12352:             RETURN
12353:         ENDIF
12354:         TRY
12355:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12356:                 SELECT TOP 1 cods FROM SigCdCor WHERE cods = <<EscaparSQL(loc_cCod)>>
12357:             ENDTEXT
12358:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCorFas")
12359:             IF loc_nR <= 0 OR EOF("cursor_4c_VCorFas")
12360:                 THIS.AbrirLookupCorFas()
12361:             ELSE
12362:                 THIS.this_oBusinessObject.this_cCodcors = loc_cCod
12363:             ENDIF
12364:             IF USED("cursor_4c_VCorFas")
12365:                 USE IN cursor_4c_VCorFas
12366:             ENDIF
12367:         CATCH TO loc_oErro
12368:             MsgErro("Erro ao validar cor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodcorsLostFocus")
12369:         ENDTRY
12370:     ENDPROC
12371: 
12372:     *--------------------------------------------------------------------------
12373:     * AbrirLookupCorFas - Lookup Cor para a aba Fases
12374:     * Atualiza Page7 e Page1 (campos sincronizados)
12375:     *--------------------------------------------------------------------------
12376:     PROTECTED PROCEDURE AbrirLookupCorFas()
12377:         LOCAL loc_oBusca, loc_oPg7, loc_oPg1, loc_cVal
12378:         loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12379:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
12380:         loc_cVal = IIF(PEMSTATUS(loc_oPg7, "txt_4c_CodcorsFas", 5), ALLTRIM(loc_oPg7.txt_4c_CodcorsFas.Value), "")
12381: 
12382:         TRY
12383:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCor", "cursor_4c_CorFas", "cods", loc_cVal, "Selecionar Cor")
12384:             loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
12385:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
12386:             loc_oBusca.Show()
12387: 
12388:             IF loc_oBusca.this_lSelecionou
12389:                 IF USED("cursor_4c_CorFas")
12390:                     LOCAL loc_cCodSel
12391:                     loc_cCodSel = ALLTRIM(cursor_4c_CorFas.cods)
12392:                     IF PEMSTATUS(loc_oPg7, "txt_4c_CodcorsFas", 5)
12393:                         loc_oPg7.txt_4c_CodcorsFas.Value = loc_cCodSel
12394:                     ENDIF
12395:                     IF PEMSTATUS(loc_oPg1, "txt_4c_Codcors", 5)
12396:                         loc_oPg1.txt_4c_Codcors.Value = loc_cCodSel
12397:                     ENDIF
12398:                     THIS.this_oBusinessObject.this_cCodcors = loc_cCodSel
12399:                 ENDIF
12400:             ELSE
12401:                 IF PEMSTATUS(loc_oPg7, "txt_4c_CodcorsFas", 5)
12402:                     loc_oPg7.txt_4c_CodcorsFas.Value = ""
12403:                 ENDIF
12404:             ENDIF
12405: 
12406:             IF USED("cursor_4c_CorFas")
12407:                 USE IN cursor_4c_CorFas
12408:             ENDIF
12409:             loc_oBusca.Release()
12410:         CATCH TO loc_oErro
12411:             MsgErro("Erro no lookup de cor (Fases):" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupCorFas")
12412:         ENDTRY
12413:     ENDPROC
12414: 
12415:     *--------------------------------------------------------------------------
12416:     * TabFases_CodtamsKeyPress - F4 no campo Tamanho (aba Fases) abre lookup
12417:     *--------------------------------------------------------------------------
12418:     PROCEDURE TabFases_CodtamsKeyPress
12419:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12420:         IF par_nKeyCode = 115
12421:             THIS.AbrirLookupTamanhoFas()
12422:         ENDIF
12423:     ENDPROC
12424: 
12425:     *--------------------------------------------------------------------------
12426:     * TabFases_CodtamsLostFocus - LostFocus valida tamanho na aba Fases
12427:     *--------------------------------------------------------------------------
12428:     PROCEDURE TabFases_CodtamsLostFocus()
12429:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12430:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12431:         IF !PEMSTATUS(loc_oPg, "txt_4c_CodtamsFas", 5)
12432:             RETURN
12433:         ENDIF
12434:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodtamsFas.Value)
12435:         IF EMPTY(loc_cCod)
12436:             RETURN
12437:         ENDIF
12438:         TRY
12439:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12440:                 SELECT TOP 1 Cods FROM SigCdTam WHERE Cods = <<EscaparSQL(loc_cCod)>>
12441:             ENDTEXT
12442:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VTamFas")
12443:             IF loc_nR <= 0 OR EOF("cursor_4c_VTamFas")
12444:                 THIS.AbrirLookupTamanhoFas()
12445:             ELSE
12446:                 THIS.this_oBusinessObject.this_cCodtams = loc_cCod
12447:             ENDIF
12448:             IF USED("cursor_4c_VTamFas")
12449:                 USE IN cursor_4c_VTamFas
12450:             ENDIF
12451:         CATCH TO loc_oErro
12452:             MsgErro("Erro ao validar tamanho:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodtamsLostFocus")
12453:         ENDTRY
12454:     ENDPROC
12455: 
12456:     *--------------------------------------------------------------------------
12457:     * AbrirLookupTamanhoFas - Lookup Tamanho para a aba Fases
12458:     *--------------------------------------------------------------------------
12459:     PROTECTED PROCEDURE AbrirLookupTamanhoFas()
12460:         LOCAL loc_oBusca, loc_oPg7, loc_oPg1, loc_cVal
12461:         loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12462:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
12463:         loc_cVal = IIF(PEMSTATUS(loc_oPg7, "txt_4c_CodtamsFas", 5), ALLTRIM(loc_oPg7.txt_4c_CodtamsFas.Value), "")
12464: 
12465:         TRY
12466:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", "cursor_4c_TamFas", "Cods", loc_cVal, "Selecionar Tamanho")
12467:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
12468:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
12469:             loc_oBusca.Show()
12470: 
12471:             IF loc_oBusca.this_lSelecionou
12472:                 IF USED("cursor_4c_TamFas")
12473:                     LOCAL loc_cCodSel
12474:                     loc_cCodSel = ALLTRIM(cursor_4c_TamFas.Cods)
12475:                     IF PEMSTATUS(loc_oPg7, "txt_4c_CodtamsFas", 5)
12476:                         loc_oPg7.txt_4c_CodtamsFas.Value = loc_cCodSel
12477:                     ENDIF
12478:                     IF PEMSTATUS(loc_oPg1, "txt_4c_Codtams", 5)
12479:                         loc_oPg1.txt_4c_Codtams.Value = loc_cCodSel
12480:                     ENDIF
12481:                     THIS.this_oBusinessObject.this_cCodtams = loc_cCodSel
12482:                 ENDIF
12483:             ELSE
12484:                 IF PEMSTATUS(loc_oPg7, "txt_4c_CodtamsFas", 5)
12485:                     loc_oPg7.txt_4c_CodtamsFas.Value = ""
12486:                 ENDIF
12487:             ENDIF
12488: 
12489:             IF USED("cursor_4c_TamFas")
12490:                 USE IN cursor_4c_TamFas
12491:             ENDIF
12492:             loc_oBusca.Release()
12493:         CATCH TO loc_oErro
12494:             MsgErro("Erro no lookup de tamanho (Fases):" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupTamanhoFas")
12495:         ENDTRY
12496:     ENDPROC
12497: 
12498:     *--------------------------------------------------------------------------
12499:     * TabFases_CodacbsKeyPress - F4 no campo Acabamento (aba Fases) abre lookup
12500:     *--------------------------------------------------------------------------
12501:     PROCEDURE TabFases_CodacbsKeyPress
12502:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12503:         IF par_nKeyCode = 115
12504:             THIS.AbrirLookupAcabamentoFas()
12505:         ENDIF
12506:     ENDPROC
12507: 
12508:     *--------------------------------------------------------------------------
12509:     * TabFases_CodacbsLostFocus - LostFocus valida acabamento na aba Fases
12510:     *--------------------------------------------------------------------------
12511:     PROCEDURE TabFases_CodacbsLostFocus()
12512:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12513:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12514:         IF !PEMSTATUS(loc_oPg, "txt_4c_CodacbsFas", 5)
12515:             RETURN
12516:         ENDIF
12517:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodacbsFas.Value)
12518:         IF EMPTY(loc_cCod)
12519:             IF PEMSTATUS(loc_oPg, "txt_4c_DacbsFas", 5)
12520:                 loc_oPg.txt_4c_DacbsFas.Value = ""
12521:             ENDIF
12522:             RETURN
12523:         ENDIF
12524:         TRY
12525:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12526:                 SELECT TOP 1 cods, descrs FROM SigCdAca WHERE cods = <<EscaparSQL(loc_cCod)>>
12527:             ENDTEXT
12528:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VAcbFas")
12529:             IF loc_nR > 0 AND !EOF("cursor_4c_VAcbFas")
12530:                 IF PEMSTATUS(loc_oPg, "txt_4c_DacbsFas", 5)
12531:                     loc_oPg.txt_4c_DacbsFas.Value = ALLTRIM(cursor_4c_VAcbFas.descrs)
12532:                 ENDIF
12533:                 THIS.this_oBusinessObject.this_cCodacbs = loc_cCod
12534:             ELSE
12535:                 THIS.AbrirLookupAcabamentoFas()
12536:             ENDIF
12537:             IF USED("cursor_4c_VAcbFas")
12538:                 USE IN cursor_4c_VAcbFas
12539:             ENDIF
12540:         CATCH TO loc_oErro
12541:             MsgErro("Erro ao validar acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodacbsLostFocus")
12542:         ENDTRY
12543:     ENDPROC
12544: 
12545:     *--------------------------------------------------------------------------
12546:     * AbrirLookupAcabamentoFas - Lookup Acabamento para a aba Fases
12547:     *--------------------------------------------------------------------------
12548:     PROTECTED PROCEDURE AbrirLookupAcabamentoFas()
12549:         LOCAL loc_oBusca, loc_oPg7, loc_oPg1, loc_cVal
12550:         loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12551:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
12552:         loc_cVal = IIF(PEMSTATUS(loc_oPg7, "txt_4c_CodacbsFas", 5), ALLTRIM(loc_oPg7.txt_4c_CodacbsFas.Value), "")
12553: 
12554:         TRY
12555:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdAca", "cursor_4c_AcbFas", "cods", loc_cVal, "Selecionar Acabamento")
12556:             loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
12557:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
12558:             loc_oBusca.Show()
12559: 
12560:             IF loc_oBusca.this_lSelecionou
12561:                 IF USED("cursor_4c_AcbFas")
12562:                     LOCAL loc_cCodSel, loc_cDescSel
12563:                     loc_cCodSel  = ALLTRIM(cursor_4c_AcbFas.cods)
12564:                     loc_cDescSel = ALLTRIM(cursor_4c_AcbFas.descrs)
12565:                     IF PEMSTATUS(loc_oPg7, "txt_4c_CodacbsFas", 5)
12566:                         loc_oPg7.txt_4c_CodacbsFas.Value = loc_cCodSel
12567:                     ENDIF
12568:                     IF PEMSTATUS(loc_oPg7, "txt_4c_DacbsFas", 5)
12569:                         loc_oPg7.txt_4c_DacbsFas.Value = loc_cDescSel
12570:                     ENDIF
12571:                     IF PEMSTATUS(loc_oPg1, "txt_4c_Codacbs", 5)
12572:                         loc_oPg1.txt_4c_Codacbs.Value = loc_cCodSel
12573:                     ENDIF
12574:                     IF PEMSTATUS(loc_oPg1, "txt_4c_Dcodacbs", 5)
12575:                         loc_oPg1.txt_4c_Dcodacbs.Value = loc_cDescSel
12576:                     ENDIF
12577:                     THIS.this_oBusinessObject.this_cCodacbs = loc_cCodSel
12578:                 ENDIF
12579:             ELSE
12580:                 IF PEMSTATUS(loc_oPg7, "txt_4c_CodacbsFas", 5)
12581:                     loc_oPg7.txt_4c_CodacbsFas.Value = ""
12582:                 ENDIF
12583:                 IF PEMSTATUS(loc_oPg7, "txt_4c_DacbsFas", 5)
12584:                     loc_oPg7.txt_4c_DacbsFas.Value = ""
12585:                 ENDIF
12586:             ENDIF
12587: 
12588:             IF USED("cursor_4c_AcbFas")
12589:                 USE IN cursor_4c_AcbFas
12590:             ENDIF
12591:             loc_oBusca.Release()
12592:         CATCH TO loc_oErro
12593:             MsgErro("Erro no lookup de acabamento (Fases):" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupAcabamentoFas")
12594:         ENDTRY
12595:     ENDPROC
12596: 
12597:     *--------------------------------------------------------------------------
12598:     * TabFases_ConquilhaKeyPress - F4 no campo Conquilha abre lookup
12599:     *--------------------------------------------------------------------------
12600:     PROCEDURE TabFases_ConquilhaKeyPress
12601:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12602:         IF par_nKeyCode = 115
12603:             THIS.AbrirLookupConquilha()
12604:         ENDIF
12605:     ENDPROC
12606: 
12607:     *--------------------------------------------------------------------------
12608:     * TabFases_ConquilhaLostFocus - LostFocus valida conquilha
12609:     *--------------------------------------------------------------------------
12610:     PROCEDURE TabFases_ConquilhaLostFocus()
12611:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12612:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12613:         IF !PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
12614:             RETURN
12615:         ENDIF
12616:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Conquilhas.Value)
12617:         IF EMPTY(loc_cCod)
12618:             RETURN
12619:         ENDIF
12620:         TRY
12621:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12622:                 SELECT TOP 1 conquilhas FROM SigCdCnq WHERE RTRIM(conquilhas) = RTRIM(<<EscaparSQL(loc_cCod)>>)
12623:             ENDTEXT
12624:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCnq")
12625:             IF loc_nR <= 0 OR EOF("cursor_4c_VCnq")
12626:                 THIS.AbrirLookupConquilha()
12627:             ELSE
12628:                 THIS.this_oBusinessObject.this_cConquilhas = loc_cCod
12629:             ENDIF
12630:             IF USED("cursor_4c_VCnq")
12631:                 USE IN cursor_4c_VCnq
12632:             ENDIF
12633:         CATCH TO loc_oErro
12634:             MsgErro("Erro ao validar conquilha:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_ConquilhaLostFocus")
12635:         ENDTRY
12636:     ENDPROC
12637: 
12638:     *--------------------------------------------------------------------------
12639:     * AbrirLookupConquilha - Lookup para campo Conquilha (SigCdCnq)
12640:     *--------------------------------------------------------------------------
12641:     PROTECTED PROCEDURE AbrirLookupConquilha()
12642:         LOCAL loc_oBusca, loc_oPg, loc_cVal
12643:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12644:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5), ALLTRIM(loc_oPg.txt_4c_Conquilhas.Value), "")
12645: 
12646:         TRY
12647:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCnq", "cursor_4c_Cnq", "conquilhas", loc_cVal, "Selecionar Conquilha")
12648:             loc_oBusca.mAddColuna("conquilhas", "", "Conquilha")
12649:             loc_oBusca.Show()
12650: 
12651:             IF loc_oBusca.this_lSelecionou
12652:                 IF USED("cursor_4c_Cnq")
12653:                     LOCAL loc_cCodSel
12654:                     loc_cCodSel = ALLTRIM(cursor_4c_Cnq.conquilhas)
12655:                     IF PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
12656:                         loc_oPg.txt_4c_Conquilhas.Value = loc_cCodSel
12657:                     ENDIF
12658:                     THIS.this_oBusinessObject.this_cConquilhas = loc_cCodSel
12659:                 ENDIF
12660:             ELSE
12661:                 IF PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
12662:                     loc_oPg.txt_4c_Conquilhas.Value = ""
12663:                 ENDIF
12664:             ENDIF
12665: 
12666:             IF USED("cursor_4c_Cnq")
12667:                 USE IN cursor_4c_Cnq
12668:             ENDIF
12669:             loc_oBusca.Release()
12670:         CATCH TO loc_oErro
12671:             MsgErro("Erro no lookup de conquilha:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupConquilha")
12672:         ENDTRY
12673:     ENDPROC
12674: 
12675:     *--------------------------------------------------------------------------
12676:     * TabFases_GarraKeyPress - F4 no campo Garra abre lookup
12677:     *--------------------------------------------------------------------------
12678:     PROCEDURE TabFases_GarraKeyPress
12679:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12680:         IF par_nKeyCode = 115
12681:             THIS.AbrirLookupGarra()
12682:         ENDIF
12683:     ENDPROC
12684: 
12685:     *--------------------------------------------------------------------------
12686:     * TabFases_GarraLostFocus - LostFocus valida garra
12687:     *--------------------------------------------------------------------------
12688:     PROCEDURE TabFases_GarraLostFocus()
12689:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12690:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12691:         IF !PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)
12692:             RETURN
12693:         ENDIF
12694:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codgarras.Value)
12695:         IF EMPTY(loc_cCod)
12696:             RETURN
12697:         ENDIF
12698:         TRY
12699:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12700:                 SELECT TOP 1 codgarras FROM SigCdGar WHERE RTRIM(codgarras) = RTRIM(<<EscaparSQL(loc_cCod)>>)
12701:             ENDTEXT
12702:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGar")
12703:             IF loc_nR <= 0 OR EOF("cursor_4c_VGar")
12704:                 THIS.AbrirLookupGarra()
12705:             ELSE
12706:                 THIS.this_oBusinessObject.this_cCodgarras = loc_cCod
12707:             ENDIF
12708:             IF USED("cursor_4c_VGar")
12709:                 USE IN cursor_4c_VGar
12710:             ENDIF
12711:         CATCH TO loc_oErro
12712:             MsgErro("Erro ao validar garra:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_GarraLostFocus")
12713:         ENDTRY
12714:     ENDPROC
12715: 
12716:     *--------------------------------------------------------------------------
12717:     * AbrirLookupGarra - Lookup para campo Garra (SigCdGar)
12718:     *--------------------------------------------------------------------------
12719:     PROTECTED PROCEDURE AbrirLookupGarra()
12720:         LOCAL loc_oBusca, loc_oPg, loc_cVal
12721:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12722:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5), ALLTRIM(loc_oPg.txt_4c_Codgarras.Value), "")
12723: 
12724:         TRY
12725:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGar", "cursor_4c_Gar", "codgarras", loc_cVal, "Selecionar Garra")
12726:             loc_oBusca.mAddColuna("codgarras", "", "C" + CHR(243) + "digo")
12727:             loc_oBusca.Show()
12728: 
12729:             IF loc_oBusca.this_lSelecionou
12730:                 IF USED("cursor_4c_Gar")
12731:                     LOCAL loc_cCodSel
12732:                     loc_cCodSel = ALLTRIM(cursor_4c_Gar.codgarras)
12733:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)
12734:                         loc_oPg.txt_4c_Codgarras.Value = loc_cCodSel
12735:                     ENDIF
12736:                     THIS.this_oBusinessObject.this_cCodgarras = loc_cCodSel
12737:                 ENDIF
12738:             ELSE
12739:                 IF PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)
12740:                     loc_oPg.txt_4c_Codgarras.Value = ""
12741:                 ENDIF
12742:             ENDIF
12743: 
12744:             IF USED("cursor_4c_Gar")
12745:                 USE IN cursor_4c_Gar
12746:             ENDIF
12747:             loc_oBusca.Release()
12748:         CATCH TO loc_oErro
12749:             MsgErro("Erro no lookup de garra:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupGarra")
12750:         ENDTRY
12751:     ENDPROC
12752: 
12753:     *--------------------------------------------------------------------------
12754:     * BtnInserirFaseClick - Inserir nova fase de producao em SigCdPrf
12755:     *--------------------------------------------------------------------------
12756:     PROCEDURE BtnInserirFaseClick()
12757:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_nProxOrdem, loc_nMaxOrdem
12758: 
12759:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12760:             MsgAviso("Salve ou edite o produto antes de inserir fases.", "FormProduto")
12761:             RETURN
12762:         ENDIF
12763: 
12764:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12765:         IF EMPTY(loc_cCpros)
12766:             MsgAviso("Produto n" + CHR(227) + "o identificado. Salve o produto primeiro.", "FormProduto")
12767:             RETURN
12768:         ENDIF
12769: 
12770:         TRY
12771:             *-- Calcular proximo numero de ordem
12772:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12773:                 SELECT ISNULL(MAX(ordems), 0) + 1 AS proximo FROM SigCdPrf
12774:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12775:             ENDTEXT
12776:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxOrdem")
12777:             IF loc_nR > 0 AND !EOF("cursor_4c_MaxOrdem")
12778:                 loc_nProxOrdem = NVL(cursor_4c_MaxOrdem.proximo, 1)
12779:             ELSE
12780:                 loc_nProxOrdem = 1
12781:             ENDIF
12782:             IF USED("cursor_4c_MaxOrdem")
12783:                 USE IN cursor_4c_MaxOrdem
12784:             ENDIF
12785: 
12786:             *-- Inserir nova fase
12787:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12788:                 INSERT INTO SigCdPrf (produtos, ordems, grupos, minutos, uniprdts, matprdts)
12789:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<loc_nProxOrdem>>, '', 0, '', '')
12790:             ENDTEXT
12791:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12792:             IF loc_nR > 0
12793:                 THIS.CarregarFases()
12794:                 LOCAL loc_oPg7
12795:                 loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12796:                 IF PEMSTATUS(loc_oPg7, "grd_4c_Fases", 5)
12797:                     loc_oPg7.grd_4c_Fases.SetFocus()
12798:                 ENDIF
12799:             ELSE
12800:                 MsgErro("Erro ao inserir fase.", "FormProduto.BtnInserirFaseClick")
12801:             ENDIF
12802:         CATCH TO loc_oErro
12803:             MsgErro("Erro ao inserir fase:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInserirFaseClick")
12804:         ENDTRY
12805:     ENDPROC
12806: 
12807:     *--------------------------------------------------------------------------
12808:     * BtnExcluirFaseClick - Excluir fase de producao selecionada
12809:     *--------------------------------------------------------------------------
12810:     PROCEDURE BtnExcluirFaseClick()
12811:         LOCAL loc_cCpros, loc_nOrdems, loc_cSQL, loc_nR, loc_lConfirma
12812: 
12813:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12814:             RETURN
12815:         ENDIF
12816: 
12817:         IF NOT USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases") OR BOF("cursor_4c_Fases")
12818:             MsgAviso("Selecione uma fase para excluir.", "FormProduto")
12819:             RETURN
12820:         ENDIF
12821: 
12822:         loc_cCpros  = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12823:         loc_nOrdems = NVL(cursor_4c_Fases.ordems, 0)
12824: 
12825:         IF loc_nOrdems <= 0
12826:             MsgAviso("Selecione uma fase v" + CHR(225) + "lida para excluir.", "FormProduto")
12827:             RETURN
12828:         ENDIF
12829: 
12830:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o da fase " + TRANSFORM(loc_nOrdems) + "?", "FormProduto")
12831:         IF !loc_lConfirma
12832:             RETURN
12833:         ENDIF
12834: 
12835:         TRY
12836:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12837:                 DELETE FROM SigCdPrf
12838:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12839:                 AND ordems = <<loc_nOrdems>>
12840:             ENDTEXT
12841:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12842:             IF loc_nR > 0
12843:                 THIS.CarregarFases()
12844:             ELSE
12845:                 MsgErro("Erro ao excluir fase.", "FormProduto.BtnExcluirFaseClick")
12846:             ENDIF
12847:         CATCH TO loc_oErro
12848:             MsgErro("Erro ao excluir fase:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcluirFaseClick")
12849:         ENDTRY
12850:     ENDPROC
12851: 
12852:     *--------------------------------------------------------------------------
12853:     * BtnAlternativaFaseClick - Inserir fase alternativa (alternativa da fase atual)
12854:     *--------------------------------------------------------------------------
12855:     PROCEDURE BtnAlternativaFaseClick()
12856:         LOCAL loc_cCpros, loc_cGrupoAtual, loc_cSQL, loc_nR, loc_nProxOrdem
12857: 
12858:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12859:             MsgAviso("Salve ou edite o produto antes de inserir alternativas.", "FormProduto")
12860:             RETURN
12861:         ENDIF
12862: 
12863:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12864:         IF EMPTY(loc_cCpros)
12865:             MsgAviso("Produto n" + CHR(227) + "o identificado. Salve o produto primeiro.", "FormProduto")
12866:             RETURN
12867:         ENDIF
12868: 
12869:         IF NOT USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
12870:             MsgAviso("Selecione uma fase base para criar a alternativa.", "FormProduto")
12871:             RETURN
12872:         ENDIF
12873: 
12874:         loc_cGrupoAtual = ALLTRIM(NVL(cursor_4c_Fases.grupos, ""))
12875:         IF EMPTY(loc_cGrupoAtual)
12876:             MsgAviso("A fase selecionada precisa ter um grupo definido.", "FormProduto")
12877:             RETURN
12878:         ENDIF
12879: 
12880:         TRY
12881:             *-- Calcular proximo numero de ordem
12882:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12883:                 SELECT ISNULL(MAX(ordems), 0) + 1 AS proximo FROM SigCdPrf
12884:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12885:             ENDTEXT
12886:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxOrdAlt")
12887:             IF loc_nR > 0 AND !EOF("cursor_4c_MaxOrdAlt")
12888:                 loc_nProxOrdem = NVL(cursor_4c_MaxOrdAlt.proximo, 1)
12889:             ELSE
12890:                 loc_nProxOrdem = 1
12891:             ENDIF
12892:             IF USED("cursor_4c_MaxOrdAlt")
12893:                 USE IN cursor_4c_MaxOrdAlt
12894:             ENDIF
12895: 
12896:             *-- Inserir fase alternativa copiando o grupo da fase atual
12897:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12898:                 INSERT INTO SigCdPrf (produtos, ordems, grupos, minutos, uniprdts, matprdts)
12899:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<loc_nProxOrdem>>, <<EscaparSQL(loc_cGrupoAtual)>>, 0, '', '')
12900:             ENDTEXT
12901:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12902:             IF loc_nR > 0
12903:                 THIS.CarregarFases()
12904:             ELSE
12905:                 MsgErro("Erro ao inserir fase alternativa.", "FormProduto.BtnAlternativaFaseClick")
12906:             ENDIF
12907:         CATCH TO loc_oErro
12908:             MsgErro("Erro ao inserir alternativa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnAlternativaFaseClick")
12909:         ENDTRY
12910:     ENDPROC
12911: 
12912:     *--------------------------------------------------------------------------
12913:     * CmdFichaClick - Imprimir ficha tecnica das fases do produto
12914:     *--------------------------------------------------------------------------
12915:     PROCEDURE CmdFichaClick()
12916:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oBO
12917: 
12918:         loc_oBO    = THIS.this_oBusinessObject
12919:         loc_cCpros = ALLTRIM(loc_oBO.this_cCpros)
12920: 
12921:         IF EMPTY(loc_cCpros)
12922:             MsgAviso("Nenhum produto selecionado.", "FormProduto")
12923:             RETURN
12924:         ENDIF
12925: 
12926:         TRY
12927:             *-- Criar cursor de cabecalho para o relatorio
12928:             IF USED("CsCabecalho")
12929:                 USE IN CsCabecalho
12930:             ENDIF
12931:             CREATE CURSOR CsCabecalho ( ;
12932:                 _NmEmp  C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
12933:                 _cGrus  C(03), _dGrus C(20), _sGrus C(06), _sDesc C(20), ;
12934:                 _cLinh  C(10), _dLinh C(40), _cGVen C(10), _dGVen C(40), ;
12935:                 _nPeso  N(9,2), _DtIni D(08), _DtFin D(08), _TExec C(15), _cMode C(10))
12936: 
12937:             INSERT INTO CsCabecalho ;
12938:                 (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _dGrus, _cMode) ;
12939:                 VALUES( ;
12940:                     go_4c_Sistema.cEmpresa, ;
12941:                     "Ficha T" + CHR(233) + "cnica de Fases", ;
12942:                     loc_cCpros, ;
12943:                     loc_oBO.this_cDpros, ;
12944:                     loc_oBO.this_cCgrus, ;
12945:                     THIS.CarregarDesc("SigCdGrp", "cgrus", loc_oBO.this_cCgrus, "dgrus"), ;
12946:                     THIS.this_cModoAtual)
12947: 
12948:             MsgInfo("Ficha t" + CHR(233) + "cnica gerada. Configure o relat" + CHR(243) + "rio RelFase.frx para impress" + CHR(227) + "o.", "Ficha T" + CHR(233) + "cnica")
12949: 
12950:             IF USED("CsCabecalho")
12951:                 USE IN CsCabecalho
12952:             ENDIF
12953: 
12954:         CATCH TO loc_oErro
12955:             MsgErro("Erro ao gerar ficha:" + CHR(13) + loc_oErro.Message, "FormProduto.CmdFichaClick")
12956:         ENDTRY
12957:     ENDPROC
12958: 
12959:     *--------------------------------------------------------------------------
12960:     * CmdgFiguraClick - Carregar/remover imagem da fase selecionada (FigProcs)
12961:     *--------------------------------------------------------------------------
12962:     PROCEDURE CmdgFiguraClick()
12963:         LOCAL loc_cCpros, loc_nOrdems, loc_cSQL, loc_nR, loc_cArquivo, loc_cFig
12964:         LOCAL loc_oPg, loc_lConfirma
12965: 
12966:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12967:             RETURN
12968:         ENDIF
12969: 
12970:         IF NOT USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
12971:             MsgAviso("Selecione uma fase para carregar a imagem.", "FormProduto")
12972:             RETURN
12973:         ENDIF
12974: 
12975:         loc_cCpros  = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12976:         loc_nOrdems = NVL(cursor_4c_Fases.ordems, 0)
12977: 
12978:         IF loc_nOrdems <= 0
12979:             MsgAviso("Selecione uma fase v" + CHR(225) + "lida.", "FormProduto")
12980:             RETURN
12981:         ENDIF
12982: 
12983:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12984: 
12985:         TRY
12986:             *-- Verificar se ja tem imagem
12987:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12988:                 SELECT TOP 1 CASE WHEN FigProcs IS NULL OR LEN(RTRIM(FigProcs))=0 THEN 0 ELSE 1 END AS temFig
12989:                 FROM SigCdPrf
12990:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
12991:             ENDTEXT
12992:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerFig")
12993:             LOCAL loc_lTemFig
12994:             loc_lTemFig = .F.
12995:             IF loc_nR > 0 AND !EOF("cursor_4c_VerFig")
12996:                 loc_lTemFig = (cursor_4c_VerFig.temFig > 0)
12997:             ENDIF
12998:             IF USED("cursor_4c_VerFig")
12999:                 USE IN cursor_4c_VerFig
13000:             ENDIF
13001: 
13002:             IF loc_lTemFig
13003:                 *-- Oferecer opcoes: substituir ou remover
13004:                 loc_lConfirma = MsgConfirma("Esta fase j" + CHR(225) + " possui imagem. Deseja remov" + CHR(234) + "-la?", "Imagem da Fase")
13005:                 IF loc_lConfirma
13006:                     TEXT TO loc_cSQL TEXTMERGE NOSHOW
13007:                         UPDATE SigCdPrf SET FigProcs = NULL
13008:                         WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
13009:                     ENDTEXT
13010:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13011:                     IF loc_nR > 0
13012:                         IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5)
13013:                             loc_oPg.img_4c_ImgFigJpg.Picture = ""
13014:                             loc_oPg.img_4c_ImgFigJpg.Visible = .F.
13015:                         ENDIF
13016:                         MsgInfo("Imagem removida.", "FormProduto")
13017:                     ENDIF
13018:                     RETURN
13019:                 ENDIF

*-- Linhas 13059 a 13419:
13059:     * CmdgFigCamClick - Carregar/remover imagem de borracha (camera/molde)
13060:     * Equivalente ao cmdgFigCam do legado: camera para imagem da borracha
13061:     *--------------------------------------------------------------------------
13062:     PROCEDURE CmdgFigCamClick()
13063:         LOCAL loc_cCmats, loc_cSQL, loc_nR, loc_cArquivo, loc_cFig, loc_oPg
13064: 
13065:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13066:             RETURN
13067:         ENDIF
13068: 
13069:         IF NOT USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes")
13070:             MsgAviso("Selecione uma matriz para carregar a imagem.", "FormProduto")
13071:             RETURN
13072:         ENDIF
13073: 
13074:         loc_cCmats = ALLTRIM(NVL(cursor_4c_Matrizes.cmats, ""))
13075:         IF EMPTY(loc_cCmats)
13076:             MsgAviso("Selecione uma matriz v" + CHR(225) + "lida.", "FormProduto")
13077:             RETURN
13078:         ENDIF
13079: 
13080:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
13081: 
13082:         TRY
13083:             *-- Selecionar arquivo de imagem
13084:             loc_cFig = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Selecionar Imagem da Borracha:")
13085:             IF EMPTY(loc_cFig) OR !FILE(loc_cFig)
13086:                 RETURN
13087:             ENDIF
13088: 
13089:             *-- Converter para Base64 e salvar em SigCdPro.FigJpgs
13090:             LOCAL loc_cBinImg, loc_cB64
13091:             loc_cBinImg = FILETOSTR(loc_cFig)
13092:             IF EMPTY(loc_cBinImg)
13093:                 MsgErro("Falha ao ler arquivo de imagem.", "FormProduto.CmdgFigCamClick")
13094:                 RETURN
13095:             ENDIF
13096: 
13097:             loc_cB64 = "data:image/jpeg;base64," + STRCONV(loc_cBinImg, 13)
13098: 
13099:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13100:                 UPDATE SigCdPro SET FigJpgs = ?loc_cB64
13101:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCmats)>>)
13102:             ENDTEXT
13103:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13104:             IF loc_nR > 0
13105:                 *-- Exibir imagem
13106:                 loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
13107:                 STRTOFILE(loc_cBinImg, loc_cArquivo)
13108:                 IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) AND FILE(loc_cArquivo)
13109:                     loc_oPg.img_4c_ImgBorracha.Picture = loc_cArquivo
13110:                     loc_oPg.img_4c_ImgBorracha.Visible = .T.
13111:                 ENDIF
13112:             ELSE
13113:                 MsgErro("Erro ao salvar imagem.", "FormProduto.CmdgFigCamClick")
13114:             ENDIF
13115: 
13116:         CATCH TO loc_oErro
13117:             MsgErro("Erro ao carregar imagem de borracha:" + CHR(13) + loc_oErro.Message, "FormProduto.CmdgFigCamClick")
13118:         ENDTRY
13119:     ENDPROC
13120: 
13121:     *--------------------------------------------------------------------------
13122:     * BtnInserirMatrizClick - Inserir nova linha na grade de matrizes (SigPrMtz)
13123:     *--------------------------------------------------------------------------
13124:     PROCEDURE BtnInserirMatrizClick()
13125:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
13126: 
13127:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13128:             MsgAviso("Salve ou edite o produto antes de inserir matrizes.", "FormProduto")
13129:             RETURN
13130:         ENDIF
13131: 
13132:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
13133:         IF EMPTY(loc_cCpros)
13134:             MsgAviso("Produto n" + CHR(227) + "o identificado.", "FormProduto")
13135:             RETURN
13136:         ENDIF
13137: 
13138:         TRY
13139:             *-- Inserir nova linha vazia em SigPrMtz com cIdChaves unico
13140:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13141:                 INSERT INTO SigPrMtz (cpros, cidchaves, cmats, qtds)
13142:                 VALUES (<<EscaparSQL(loc_cCpros)>>, NEWID(), '', 0)
13143:             ENDTEXT
13144:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13145:             IF loc_nR > 0
13146:                 THIS.CarregarMatrizes()
13147:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
13148:                 IF PEMSTATUS(loc_oPg, "grd_4c_Matrizes", 5)
13149:                     loc_oPg.grd_4c_Matrizes.SetFocus()
13150:                 ENDIF
13151:             ELSE
13152:                 MsgErro("Erro ao inserir matriz.", "FormProduto.BtnInserirMatrizClick")
13153:             ENDIF
13154:         CATCH TO loc_oErro
13155:             MsgErro("Erro ao inserir matriz:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInserirMatrizClick")
13156:         ENDTRY
13157:     ENDPROC
13158: 
13159:     *--------------------------------------------------------------------------
13160:     * BtnExcluirMatrizClick - Excluir linha selecionada da grade de matrizes
13161:     *--------------------------------------------------------------------------
13162:     PROCEDURE BtnExcluirMatrizClick()
13163:         LOCAL loc_cCpros, loc_cCidChaves, loc_cSQL, loc_nR, loc_lConfirma
13164: 
13165:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13166:             RETURN
13167:         ENDIF
13168: 
13169:         IF NOT USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes") OR BOF("cursor_4c_Matrizes")
13170:             MsgAviso("Selecione uma matriz para excluir.", "FormProduto")
13171:             RETURN
13172:         ENDIF
13173: 
13174:         loc_cCpros     = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
13175:         loc_cCidChaves = ALLTRIM(NVL(cursor_4c_Matrizes.cidchaves, ""))
13176: 
13177:         IF EMPTY(loc_cCidChaves)
13178:             MsgAviso("Selecione uma linha v" + CHR(225) + "lida para excluir.", "FormProduto")
13179:             RETURN
13180:         ENDIF
13181: 
13182:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o desta matriz?", "FormProduto")
13183:         IF !loc_lConfirma
13184:             RETURN
13185:         ENDIF
13186: 
13187:         TRY
13188:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13189:                 DELETE FROM SigPrMtz
13190:                 WHERE RTRIM(cidchaves) = RTRIM(<<EscaparSQL(loc_cCidChaves)>>)
13191:             ENDTEXT
13192:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13193:             IF loc_nR > 0
13194:                 THIS.CarregarMatrizes()
13195:             ELSE
13196:                 MsgErro("Erro ao excluir matriz.", "FormProduto.BtnExcluirMatrizClick")
13197:             ENDIF
13198:         CATCH TO loc_oErro
13199:             MsgErro("Erro ao excluir matriz:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcluirMatrizClick")
13200:         ENDTRY
13201:     ENDPROC
13202: 
13203:     *--------------------------------------------------------------------------
13204:     * DesignerGrd_AfterRowColChange - Grid tarefas: ao navegar linha/coluna
13205:     * Atualiza txt_4c_ObsTarefas com descricao da tarefa da linha atual
13206:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
13207:     *--------------------------------------------------------------------------
13208:     PROCEDURE DesignerGrd_AfterRowColChange(par_nColIndex)
13209:         LOCAL loc_oPg, loc_cCodTarefa, loc_cDesTarefa
13210:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
13211: 
13212:         TRY
13213:             IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13214:                 loc_cCodTarefa = ALLTRIM(NVL(cursor_4c_Designer.tarefas, ""))
13215:                 loc_cDesTarefa = ""
13216: 
13217:                 *-- Buscar descricao no cursor de tarefas
13218:                 IF USED("cursor_4c_Tarefas") AND !EOF("cursor_4c_Tarefas") AND !EMPTY(loc_cCodTarefa)
13219:                     SELECT cursor_4c_Tarefas
13220:                     LOCATE FOR ALLTRIM(CodCads) = loc_cCodTarefa
13221:                     IF !EOF("cursor_4c_Tarefas")
13222:                         loc_cDesTarefa = ALLTRIM(NVL(cursor_4c_Tarefas.DesCads, ""))
13223:                     ENDIF
13224:                 ENDIF
13225: 
13226:                 IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13227:                     loc_oPg.txt_4c_ObsTarefas.Value = loc_cDesTarefa
13228:                     loc_oPg.txt_4c_ObsTarefas.Refresh()
13229:                 ENDIF
13230:             ENDIF
13231:         CATCH TO loc_oErro
13232:             MsgErro(loc_oErro.Message, "FormProduto.DesignerGrd_AfterRowColChange")
13233:         ENDTRY
13234:     ENDPROC
13235: 
13236:     *--------------------------------------------------------------------------
13237:     * ArquivosGrd_AfterRowColChange - Grid arquivos: ao navegar linha/coluna
13238:     * Exibe preview de imagem em img_4c_ImgArqJpg se arquivo for JPG/ICO/BMP/JPEG
13239:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
13240:     *--------------------------------------------------------------------------
13241:     PROCEDURE ArquivosGrd_AfterRowColChange(par_nColIndex)
13242:         LOCAL loc_oPg, loc_cArq, loc_cExt
13243:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
13244: 
13245:         TRY
13246:             IF !PEMSTATUS(loc_oPg, "img_4c_ImgArqJpg", 5)
13247:                 RETURN
13248:             ENDIF
13249: 
13250:             *-- Limpar preview
13251:             CLEAR RESOURCES
13252:             loc_oPg.img_4c_ImgArqJpg.Picture = ""
13253:             loc_oPg.img_4c_ImgArqJpg.Visible = .F.
13254: 
13255:             IF USED("cursor_4c_Arquivos") AND !EOF("cursor_4c_Arquivos")
13256:                 loc_cArq = ALLTRIM(NVL(cursor_4c_Arquivos.arquivos, ""))
13257: 
13258:                 IF !EMPTY(loc_cArq)
13259:                     loc_cExt = ALLTRIM(UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq), 5)))
13260: 
13261:                     IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
13262:                         loc_oPg.img_4c_ImgArqJpg.Picture = loc_cArq
13263:                         loc_oPg.img_4c_ImgArqJpg.Visible = .T.
13264:                     ENDIF
13265:                 ENDIF
13266:             ENDIF
13267:         CATCH TO loc_oErro
13268:             MsgErro(loc_oErro.Message, "FormProduto.ArquivosGrd_AfterRowColChange")
13269:         ENDTRY
13270:     ENDPROC
13271: 
13272:     *--------------------------------------------------------------------------
13273:     * GrdDesignerColReadOnlyWhen - Colunas 1/2/3 do grd_4c_Designer: sempre somente leitura
13274:     * Retorna .F. para bloquear edicao (original: Return .f.)
13275:     *--------------------------------------------------------------------------
13276:     PROCEDURE GrdDesignerColReadOnlyWhen()
13277:         RETURN .F.
13278:     ENDPROC
13279: 
13280:     *--------------------------------------------------------------------------
13281:     * GrdDesignerCol4When - Column4 do grd_4c_Designer (Tarefa): editavel condicionalmente
13282:     * Editavel apenas em INSERIR/ALTERAR, para o usuario atual, sem DtFims
13283:     * Original: Return InList(pcEscolha, INSERIR, ALTERAR) And Usuars=Usuar And IsEmpty(DtFims)
13284:     *--------------------------------------------------------------------------
13285:     PROCEDURE GrdDesignerCol4When()
13286:         LOCAL loc_lEditavel, loc_cUsuars, loc_cDtFims
13287: 
13288:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13289:             RETURN .F.
13290:         ENDIF
13291: 
13292:         IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13293:             loc_cUsuars = ALLTRIM(NVL(cursor_4c_Designer.usuars, ""))
13294:             loc_cDtFims = NVL(cursor_4c_Designer.dtfims, {})
13295: 
13296:             IF loc_cUsuars <> ALLTRIM(gc_4c_UsuarioLogado)
13297:                 RETURN .F.
13298:             ENDIF
13299: 
13300:             IF !EMPTY(loc_cDtFims)
13301:                 RETURN .F.
13302:             ENDIF
13303: 
13304:             RETURN .T.
13305:         ENDIF
13306: 
13307:         RETURN .F.
13308:     ENDPROC
13309: 
13310:     *--------------------------------------------------------------------------
13311:     * GrdDesignerCol4Valid - Column4 do grd_4c_Designer: valida/lookup de tarefa
13312:     * Se cursor_4c_Tarefas tem dados: valida codigo; se nao encontrado, limpa campo
13313:     * Se cursor_4c_Tarefas vazio (tabela SigPrTrf inexistente): aceita qualquer valor
13314:     * Original: fwBuscaInt em crTarefas (CodCads/DesCads)
13315:     *--------------------------------------------------------------------------
13316:     PROCEDURE GrdDesignerCol4Valid()
13317:         LOCAL loc_oPg, loc_cValor, loc_cCodTarefa, loc_cDesTarefa, loc_lEncontrou
13318:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
13319: 
13320:         TRY
13321:             *-- Obter valor atual da celula via cursor_4c_Designer
13322:             loc_cValor = ""
13323:             IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13324:                 loc_cValor = ALLTRIM(NVL(cursor_4c_Designer.tarefas, ""))
13325:             ENDIF
13326: 
13327:             IF EMPTY(loc_cValor)
13328:                 loc_lResultado = .T.
13329:             ENDIF
13330: 
13331:             *-- Cursor de tarefas vazio: tabela mestre nao disponivel, aceitar qualquer valor
13332:             IF !USED("cursor_4c_Tarefas") OR RECCOUNT("cursor_4c_Tarefas") = 0
13333:                 loc_lResultado = .T.
13334:             ENDIF
13335: 
13336:             *-- Verificar se codigo existe no cursor de tarefas
13337:             loc_lEncontrou = .F.
13338:             loc_cCodTarefa = ""
13339:             loc_cDesTarefa = ""
13340: 
13341:             SELECT cursor_4c_Tarefas
13342:             LOCATE FOR ALLTRIM(CodCads) = loc_cValor
13343:             IF !EOF("cursor_4c_Tarefas")
13344:                 loc_lEncontrou = .T.
13345:                 loc_cCodTarefa = ALLTRIM(cursor_4c_Tarefas.CodCads)
13346:                 loc_cDesTarefa = ALLTRIM(NVL(cursor_4c_Tarefas.DesCads, ""))
13347:             ENDIF
13348: 
13349:             *-- Atualizar descricao se encontrou; limpar se nao encontrou
13350:             IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13351:                 IF loc_lEncontrou
13352:                     IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13353:                         loc_oPg.txt_4c_ObsTarefas.Value = loc_cDesTarefa
13354:                     ENDIF
13355:                 ELSE
13356:                     MsgAviso("C" + CHR(243) + "digo de tarefa n" + CHR(227) + "o encontrado.", "Tarefa Designer")
13357:                     REPLACE cursor_4c_Designer.tarefas WITH ""
13358:                     IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13359:                         loc_oPg.txt_4c_ObsTarefas.Value = ""
13360:                     ENDIF
13361:                 ENDIF
13362:             ENDIF
13363: 
13364:         CATCH TO loc_oErro
13365:             MsgErro(loc_oErro.Message, "FormProduto.GrdDesignerCol4Valid")
13366:         ENDTRY
13367: 
13368:         RETURN .T.
13369:     ENDPROC
13370: 
13371:     *--------------------------------------------------------------------------
13372:     * GrdDesignerCol4LostFocus - Column4 perde foco: navega para txt_4c_ObsTarefas ao Enter
13373:     * Original: If Not Empty(This.Value) And (Lastkey()=13) -> getObsTarefas.SetFocus
13374:     *--------------------------------------------------------------------------
13375:     PROCEDURE GrdDesignerCol4LostFocus()
13376:         LOCAL loc_oPg
13377:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
13378: 
13379:         TRY
13380:             IF LASTKEY() = 13
13381:                 IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13382:                     IF !EMPTY(ALLTRIM(NVL(cursor_4c_Designer.tarefas, "")))
13383:                         IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13384:                             loc_oPg.txt_4c_ObsTarefas.SetFocus()
13385:                         ENDIF
13386:                     ENDIF
13387:                 ENDIF
13388:             ENDIF
13389:         CATCH TO loc_oErro
13390:             MsgErro(loc_oErro.Message, "FormProduto.GrdDesignerCol4LostFocus")
13391:         ENDTRY
13392:     ENDPROC
13393: 
13394:     *--------------------------------------------------------------------------
13395:     * GrdArquivosCol1When - Column1 do grd_4c_Arquivos: editavel em INCLUIR/ALTERAR
13396:     * Original: Return InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])
13397:     *--------------------------------------------------------------------------
13398:     PROCEDURE GrdArquivosCol1When()
13399:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13400:     ENDPROC
13401: 
13402:     *--------------------------------------------------------------------------
13403:     * ImgArqJpgClick - Clique na imagem: exibe caminho do arquivo
13404:     * Original: Do Form SigOpZom (zoom view) - forma simplificada: exibe path
13405:     *--------------------------------------------------------------------------
13406:     PROCEDURE ImgArqJpgClick()
13407:         LOCAL loc_cArq
13408:         loc_cArq = ""
13409: 
13410:         IF USED("cursor_4c_Arquivos") AND !EOF("cursor_4c_Arquivos")
13411:             loc_cArq = ALLTRIM(NVL(cursor_4c_Arquivos.arquivos, ""))
13412:         ENDIF
13413: 
13414:         IF !EMPTY(loc_cArq)
13415:             MsgAviso(loc_cArq, "Arquivo Selecionado")
13416:         ENDIF
13417:     ENDPROC
13418: 
13419: ENDDEFINE

