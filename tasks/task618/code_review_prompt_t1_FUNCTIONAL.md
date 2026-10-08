# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (61)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_CONTAINER5. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.this_lPermiteAjustarPrioridade()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TmpSaldg' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TmpFabr' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TmpSaldo' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH loc_oPag1.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oPag1.grd_4c_Dados.RecordSource).
- [GRID-WITH] Bloco WITH loc_oCnt.grd_4c_DispGrupo define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oCnt.grd_4c_DispGrupo.RecordSource).
- [GRID-WITH] Bloco WITH loc_oCnt.grd_4c_DispFase define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oCnt.grd_4c_DispFase.RecordSource).
- [GRID-WITH] Bloco WITH loc_oPag2.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oPag2.grd_4c_Dados.RecordSource).
- [GRID-WITH] Bloco WITH loc_oPag3.grd_4c_Linhas define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oPag3.grd_4c_Linhas.RecordSource).
- [GRID-WITH] Bloco WITH loc_oPag4.grd_4c_DispEstoque define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oPag4.grd_4c_DispEstoque.RecordSource).
- [GRID-WITH] Bloco WITH loc_oPag5.grd_4c_DispTamanho define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oPag5.grd_4c_DispTamanho.RecordSource).
- [GRID-WITH] Bloco WITH loc_oPag6.grd_4c_Pedra define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oPag6.grd_4c_Pedra.RecordSource).
- [GRID-WITH] Bloco WITH ENDFOR define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDFOR.RecordSource).
- [GRID-WITH] Bloco WITH 0 define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: 0.RecordSource).
- [GRID-HEADER] Header Caption 'Saldo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Atual, Utilizado, Disponível, Prior, Fase, Disponivel, Nop, Produto, Qtde Pedido, Produzir, Produzir Estq, Qtd Produção, , Número, Cor, Tam, Qtd Estoque, Quantidade, Obs, Estoque, Operação, Produção, Linha, Utilizar, Descrição, Uni, Qtde. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Reservado' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Atual, Utilizado, Disponível, Prior, Fase, Disponivel, Nop, Produto, Qtde Pedido, Produzir, Produzir Estq, Qtd Produção, , Número, Cor, Tam, Qtd Estoque, Quantidade, Obs, Estoque, Operação, Produção, Linha, Utilizar, Descrição, Uni, Qtde. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1.Container3): Top original=1 vs migrado 'lbl_4c_Label1' Top=168 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1.Container3): Left original=0 vs migrado 'lbl_4c_Label1' Left=132 (diff=132px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page1.Container3): Top original=163 vs migrado 'lbl_4c_label23' Top=18 (diff=145px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page1.Container3): Left original=128 vs migrado 'lbl_4c_label23' Left=448 (diff=320px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLX.PageDados.Page1.Container3): Top original=161 vs migrado 'txt_4c_tot_qtd2' Top=113 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLX.PageDados.Page1.Container3): Top original=161 vs migrado 'txt_4c_tot_est2' Top=113 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Prz' (parent: SIGPRGLX.PageDados.Page1.Container3): Top original=161 vs migrado 'txt_4c_Tot_Prz' Top=370 (diff=209px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Prz' (parent: SIGPRGLX.PageDados.Page1.Container3): Left original=292 vs migrado 'txt_4c_Tot_Prz' Left=648 (diff=356px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1.Container5): Top original=18 vs migrado 'lbl_4c_Label1' Top=168 (diff=150px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1.Container5): Left original=269 vs migrado 'lbl_4c_Label1' Left=132 (diff=137px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1.Container1): Top original=1 vs migrado 'lbl_4c_Label1' Top=168 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1.Container1): Left original=1 vs migrado 'lbl_4c_Label1' Left=132 (diff=131px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page1.Container1): Top original=115 vs migrado 'lbl_4c_label23' Top=18 (diff=97px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page1.Container1): Left original=102 vs migrado 'lbl_4c_label23' Left=448 (diff=346px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1): Top original=348 vs migrado 'lbl_4c_Label1' Top=168 (diff=180px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1): Left original=224 vs migrado 'lbl_4c_Label1' Left=132 (diff=92px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLX.PageDados.Page1): Top original=346 vs migrado 'txt_4c_tot_qtd2' Top=113 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLX.PageDados.Page1): Left original=271 vs migrado 'txt_4c_tot_qtd2' Left=145 (diff=126px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLX.PageDados.Page1): Top original=346 vs migrado 'txt_4c_tot_est2' Top=113 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLX.PageDados.Page1): Left original=407 vs migrado 'txt_4c_tot_est2' Left=207 (diff=200px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Prz' (parent: SIGPRGLX.PageDados.Page1): Left original=476 vs migrado 'txt_4c_Tot_Prz' Left=648 (diff=172px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page2): Top original=372 vs migrado 'lbl_4c_Label1' Top=168 (diff=204px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page2): Left original=403 vs migrado 'lbl_4c_Label1' Left=132 (diff=271px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLX.PageDados.Page2): Top original=370 vs migrado 'txt_4c_tot_qtd2' Top=113 (diff=257px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLX.PageDados.Page2): Left original=449 vs migrado 'txt_4c_tot_qtd2' Left=145 (diff=304px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLX.PageDados.Page2): Top original=370 vs migrado 'txt_4c_tot_est2' Top=113 (diff=257px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLX.PageDados.Page2): Left original=516 vs migrado 'txt_4c_tot_est2' Left=207 (diff=309px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page2): Top original=164 vs migrado 'lbl_4c_label23' Top=18 (diff=146px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page2): Left original=383 vs migrado 'lbl_4c_label23' Left=448 (diff=65px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page3): Top original=147 vs migrado 'lbl_4c_label23' Top=18 (diff=129px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page3): Left original=173 vs migrado 'lbl_4c_label23' Left=448 (diff=275px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page4): Top original=418 vs migrado 'lbl_4c_label23' Top=18 (diff=400px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page4): Left original=220 vs migrado 'lbl_4c_label23' Left=448 (diff=228px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGPRGLX.PageDados.Page4): Left original=192 vs migrado 'lbl_4c_Label3' Left=261 (diff=69px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Qt_pedida' (parent: SIGPRGLX.PageDados.Page4): Left original=312 vs migrado 'txt_4c_Qt_pedida' Left=379 (diff=67px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Qt_Selec' (parent: SIGPRGLX.PageDados.Page4): Left original=312 vs migrado 'txt_4c_Qt_Selec' Left=379 (diff=67px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page4): Left original=197 vs migrado 'lbl_4c_Label1' Left=132 (diff=65px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page5): Top original=415 vs migrado 'lbl_4c_label23' Top=18 (diff=397px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page5): Left original=289 vs migrado 'lbl_4c_label23' Left=448 (diff=159px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page5): Left original=246 vs migrado 'lbl_4c_Label1' Left=132 (diff=114px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.Aguarde): Top original=18 vs migrado 'lbl_4c_Label1' Top=168 (diff=150px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.Aguarde): Left original=208 vs migrado 'lbl_4c_Label1' Left=132 (diff=76px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.Aguarde): Top original=52 vs migrado 'lbl_4c_label23' Top=18 (diff=34px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.Aguarde): Left original=137 vs migrado 'lbl_4c_label23' Left=448 (diff=311px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlx.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4114 linhas total):

*-- Linhas 14 a 141:
14: * principal, selecao de linha/estoque/disponivel/requisicao), navegadas
15: * por botao (Tabs=.F.), nao por cadastro.
16: *
17: * Estrutura ja entregue: DEFINE CLASS, Init, InicializarForm,
18: * ConfigurarPageFrame (PageFrame com as 6 paginas do legado + cabecalho da
19: * Page1) e Destroy (Fase 3); grade principal e botoes de acao da Page1
20: * (Fase 4); grade de selecao, totais, imagem e observacao da Page2
21: * (Fases 5-6); e, nesta Fase 6, as sub-paginas restantes - Page3 (Totais
22: * por Linha), Page4 (Selecionar Estoque), Page5 (Disponivel/Tamanho) e
23: * Page6 (Requisicao Manual de Material), esta ultima com os DOIS unicos
24: * lookups do form (Column1/Column5 de GradePedra -> SigCdPro, via
25: * FormBuscaAuxiliar). Os handlers de Click/navegacao e o processamento
26: * entram nas Fases 7-8.
27: *==============================================================================
28: 
29: DEFINE CLASS FormSigPrGlx AS FormBase
30: 
31:     Height       = 600
32:     Width        = 800
33:     AutoCenter   = .T.
34:     BorderStyle  = 2
35:     ShowWindow   = 0
36:     DataSession  = 2
37:     ShowWindow = 1
38:     MaxButton    = .F.
39:     MinButton    = .F.
40:     FontName     = "Tahoma"
41:     FontSize     = 8
42:     *-- WindowType = 0 na classe (evita timeout em VFP9 -T/harness de teste);
43:     *-- producao promove para modal (1) no Init, como FormICD/FormHOR/FormGps.
44:     WindowType   = 0
45: 
46:     *--------------------------------------------------------------------------
47:     * Parametros recebidos de quem abre a previa - equivalentes ao
48:     * Lparameters _ParentForm, _Data, _ReservaAuto, _nGerEmphPdr, _Autom,
49:     * _numeroOp, _PorDestino do Init legado. Repassados para o BO em
50:     * InicializarForm (SigPrGlxBO.this_lReserva/this_nEmphPdr/
51:     * this_lAutomatico/this_cNumeroDaOp/this_lPorDestino).
52:     *--------------------------------------------------------------------------
53:     this_oFormPai      = .NULL.    && thisform.ParentForm (_ParentForm) - de fato FormSigPrGl2 (CREATEOBJECT("FormSigPrGlx", THIS, ...) em FormSigPrGl2.BtnProcessarClick)
54:     this_dDataAnalise  = {}        && thisform.Data        (_Data) - vestigial: o real 2o parametro enviado por FormSigPrGl2 eh this_nDataSessionId (NUMERICO), nao uma data
55:     this_lReservaAuto  = .F.       && thisform.Reserva     (_ReservaAuto)
56:     this_nGerEmphPdr   = 0         && thisform.EmphPdr      (_nGerEmphPdr)
57:     this_lAutomatico   = .F.       && thisform.Automatico   (_Autom)
58:     this_nNumeroDaOp   = 0         && thisform.Numerodaop   (_numeroOp) - NUMERICO: FormSigPrGl2.BtnProcessarClick envia VAL(this_cNumeroDaOp)
59:     this_lPorDestino   = .F.       && thisform.PorDestino   (_PorDestino)
60: 
61:     *-- Guarda de reentrancia dos lookups de produto da Page6: o Show() do
62:     *-- picker bloqueia, o foco sai e volta da celula da grade e o proprio
63:     *-- gatilho pode disparar de novo, empilhando um segundo picker.
64:     this_lLookupEmCurso = .F.
65: 
66:     *-- ThisForm.OldValue do legado - valor da celula ANTES da edicao, usado
67:     *-- pelos Valid das colunas digitaveis (Page1 e Page2, Column7/Column10)
68:     *-- para restaurar o conteudo quando a validacao recusa.
69:     *--
70:     *-- Tem de ser property do FORM, como no legado: medido no VFP9 em
71:     *-- 2026-10-06 que NEM Column, NEM Column.Text1, NEM TextBox possuem
72:     *-- OldValue (PEMSTATUS = .F. nos tres; ler estoura "Property OLDVALUE
73:     *-- is not found"). O legado captura em "ThisForm.OldValue = This.Value"
74:     *-- no When de cada coluna; aqui a captura vai no GotFocus das mesmas
75:     *-- colunas, porque BINDEVENT em "When" nao dispara de forma confiavel
76:     *-- (regra #3 do CLAUDE.md) e GotFocus tem o mesmo gatilho util: o
77:     *-- usuario entrou na celula e ainda nao digitou.
78:     this_nOldValue = 0
79: 
80:     *-- ThisForm.Liberado do legado - gate de UMA edicao da coluna
81:     *-- "Produzir Estq" (Column8/GradeItens Page1) apos autorizacao de
82:     *-- BtnAlteraqtdClick (DO FORM SigOpSen). Consumido e desarmado no
83:     *-- LostFocus da propria coluna.
84:     this_lLiberadoAlteracao = .F.
85: 
86:     *--------------------------------------------------------------------------
87:     * Init - recebe os parametros do chamador (equivalente ao Lparameters do
88:     * legado) e delega o resto para FormBase.Init() (que chama
89:     * InicializarForm()). Promove WindowType/ShowWindow para modal fora do
90:     * modo de teste, igual ao padrao FormICD/FormHOR/FormGps.
91:     *--------------------------------------------------------------------------
92:     PROCEDURE Init()
93:         LPARAMETERS par_oFormPai, par_dData, par_lReservaAuto, par_nGerEmphPdr, ;
94:                     par_lAutomatico, par_cNumeroOp, par_lPorDestino
95: 
96:         IF PCOUNT() >= 1
97:             IF VARTYPE(par_oFormPai) = "O"
98:                 THIS.this_oFormPai = par_oFormPai
99: 
100:                 *-- CRITICO: assume a DataSessionId do pai ANTES do DODEFAULT()
101:                 *-- (que chama InicializarForm()) - sem isto este form abre
102:                 *-- numa sessao privada NOVA e TmpFinal/TmpFinalg (criados por
103:                 *-- FormSigPrGl2BO.ExecutarProcessamento na sessao do PAI)
104:                 *-- ficam invisiveis: a grade principal abriria sempre vazia.
105:                 *-- Mesmo padrao ja adotado em FormSigPrGlp.Init.
106:                 IF PEMSTATUS(par_oFormPai, "DataSessionId", 5)
107:                     THIS.DataSessionId = par_oFormPai.DataSessionId
108:                 ENDIF
109:             ENDIF
110:         ENDIF
111: 
112:         *-- par_dData (2o parametro) eh vestigial - o chamador real
113:         *-- (FormSigPrGl2.BtnProcessarClick) envia this_nDataSessionId
114:         *-- (NUMERICO), que o Init legado tambem nunca lia. Guardado so
115:         *-- quando vier DATE/DATETIME de fato (chamada manual/teste).
116:         IF PCOUNT() >= 2
117:             IF INLIST(VARTYPE(par_dData), "D", "T")
118:                 THIS.this_dDataAnalise = par_dData
119:             ENDIF
120:         ENDIF
121: 
122:         IF PCOUNT() >= 3
123:             IF VARTYPE(par_lReservaAuto) = "L"
124:                 THIS.this_lReservaAuto = par_lReservaAuto
125:             ENDIF
126:         ENDIF
127: 
128:         IF PCOUNT() >= 4
129:             IF VARTYPE(par_nGerEmphPdr) = "N"
130:                 THIS.this_nGerEmphPdr = par_nGerEmphPdr
131:             ENDIF
132:         ENDIF
133: 
134:         IF PCOUNT() >= 5
135:             IF VARTYPE(par_lAutomatico) = "L"
136:                 THIS.this_lAutomatico = par_lAutomatico
137:             ENDIF
138:         ENDIF
139: 
140:         *-- par_cNumeroOp eh NUMERICO no chamador real (VAL(this_cNumeroDaOp))
141:         IF PCOUNT() >= 6

*-- Linhas 162 a 299:
162:     ENDPROC
163: 
164:     *--------------------------------------------------------------------------
165:     * InicializarForm - cria o Business Object, repassa os parametros
166:     * recebidos no Init e monta a estrutura visual base (PageFrame + as 6
167:     * paginas do legado + cabecalho da Page1).
168:     *--------------------------------------------------------------------------
169:     *
170:     * NAO LIGAR "SET EXACT ON" NESTA TELA. Este form tem DataSession = 2,
171:     * logo nasce com os SETs no default do VFP (EXACT OFF) - e eh disso que
172:     * TODA a navegacao por item depende. Medido no VFP9 em 2026-10-06, com
173:     * chave de 22 chars (CPros+CodCors+CodTams) sobre indice de 34:
174:     *
175:     *   SET EXACT OFF -> SEEK prefixo = .T.   | SET KEY prefixo -> 1 linha
176:     *   SET EXACT ON  -> SEEK prefixo = .F.   | SET KEY prefixo -> 0 linhas
177:     *
178:     * Com EXACT ON as grades de resumo (cursor_4c_TmpSaldg/cursor_4c_TmpFabr,
179:     * cujos indices tem Priors/Grupos/Estos/Emps/Nops DEPOIS da chave do
180:     * item) ficariam PERMANENTEMENTE VAZIAS e os Valid das colunas
181:     * digitaveis deixariam de achar o saldo - sem erro e sem log. O
182:     * config.prg liga EXACT ON na sessao 1; esta sessao privada nao herda, e
183:     * eh justamente o que faz o codigo funcionar igual ao legado.
184:     *--------------------------------------------------------------------------
185:     PROTECTED PROCEDURE InicializarForm()
186:         LOCAL loc_lSucesso, loc_lProsseguir, loc_oErro
187:         loc_lSucesso = .F.
188: 
189:         THIS.Caption = IIF(THIS.this_lReservaAuto, ;
190:             "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica", ;
191:             "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o")
192:         THIS.this_cTituloForm = THIS.Caption
193: 
194:         TRY
195:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGlxBO")
196:             loc_lProsseguir = (VARTYPE(THIS.this_oBusinessObject) = "O")
197: 
198:             IF !loc_lProsseguir
199:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrGlxBO.", ;
200:                         "Erro em InicializarForm")
201:             ENDIF
202: 
203:             IF loc_lProsseguir
204:                 THIS.this_oBusinessObject.this_lReserva    = THIS.this_lReservaAuto
205:                 THIS.this_oBusinessObject.this_nEmphPdr     = THIS.this_nGerEmphPdr
206:                 THIS.this_oBusinessObject.this_lAutomatico  = THIS.this_lAutomatico
207:                 THIS.this_oBusinessObject.this_nNumeroDaOp  = THIS.this_nNumeroDaOp
208:                 THIS.this_oBusinessObject.this_lPorDestino  = THIS.this_lPorDestino
209: 
210:                 THIS.ConfigurarPageFrame()
211:                 THIS.ConfigurarPaginaLista()
212:                 THIS.ConfigurarPaginaDados()
213:                 THIS.ConfigurarPaginaTotaisLinha()
214:                 THIS.ConfigurarPaginaEstoque()
215:                 THIS.ConfigurarPaginaTamanhos()
216:                 THIS.ConfigurarPaginaRequisicao()
217: 
218:                 THIS.TornarControlesVisiveis(THIS)
219: 
220:                 *-- BOParaForm DEPOIS de TornarControlesVisiveis: este ultimo
221:                 *-- forca Visible = .T. em todo controle que nao esteja na
222:                 *-- sua lista de excecao, e eh BOParaForm quem decide a
223:                 *-- visibilidade REAL de Pedras/SelEstoque/Disponivel a
224:                 *-- partir de crSigCdPam/fChecaAcesso - rodar antes faria a
225:                 *-- decisao ser sobrescrita se a lista mudar. Tambem repoe o
226:                 *-- titulo e o rotulo "Periodo: NN meses".
227:                 THIS.BOParaForm()
228: 
229:                 *-- Carga da grade principal + filtros relacionais + totais
230:                 *-- (bloco final do Init legado). Em modo de teste/validacao
231:                 *-- de UI nao ha dados do form pai - pular evita o aviso
232:                 *-- "sem dados de globalizacao" num contexto sem usuario.
233:                 IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
234:                      (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
235:                     THIS.CarregarLista()
236:                 ENDIF
237: 
238:                 THIS.pgf_4c_1.ActivePage = 1
239: 
240:                 loc_lSucesso = .T.
241:             ENDIF
242:         CATCH TO loc_oErro
243:             MsgErro(loc_oErro.Message + CHR(13) + ;
244:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
245:                     "Procedure: " + loc_oErro.Procedure, ;
246:                     "Erro em InicializarForm")
247:             loc_lSucesso = .F.
248:         ENDTRY
249: 
250:         RETURN loc_lSucesso
251:     ENDPROC
252: 
253:     *--------------------------------------------------------------------------
254:     * ConfigurarPageFrame - cria o pgf_4c_1 (SIGPRGLX.PageDados no legado)
255:     * com as 6 paginas originais (Tabs=.F. - navegacao por botao, nao por
256:     * aba nativa) e o cabecalho (cntSombra do legado), que so existe na
257:     * Page1. Grid/totais/botoes de cada pagina entram nas proximas fases.
258:     *--------------------------------------------------------------------------
259:     PROTECTED PROCEDURE ConfigurarPageFrame()
260:         LOCAL loc_oPag1, loc_oCab
261: 
262:         THIS.AddObject("pgf_4c_1", "PageFrame")
263: 
264:         WITH THIS.pgf_4c_1
265:             .Top       = -27
266:             .Left      = -1
267:             .Width     = 804
268:             .Height    = 635
269:             .PageCount = 6
270:             .Tabs      = .F.
271:         ENDWITH
272: 
273:         *-- Page1: cabecalho (cntSombra legado) - unico container de titulo
274:         *-- do form; as demais paginas sao sub-telas de selecao/detalhe e nao
275:         *-- repetem a faixa.
276:         loc_oPag1 = THIS.pgf_4c_1.Page1
277: 
278:         loc_oPag1.AddObject("cnt_4c_Sombra", "Container")
279:         loc_oCab = loc_oPag1.cnt_4c_Sombra
280: 
281:         WITH loc_oCab
282:             .Top         = -1
283:             .Left        = 0
284:             .Width       = THIS.Width
285:             .Height      = 80
286:             .BackColor   = RGB(100, 100, 100)
287:             .BackStyle   = 1
288:             .BorderWidth = 0
289:             .SpecialEffect = 0
290:         ENDWITH
291: 
292:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
293:         WITH loc_oCab.lbl_4c_LblSombra
294:             .AutoSize  = .F.
295:             .Top       = 18
296:             .Left      = 10
297:             .Width     = 769
298:             .Height    = 40
299:             .FontName  = "Tahoma"

*-- Linhas 324 a 413:
324:         ENDWITH
325:     ENDPROC
326: 
327:     *--------------------------------------------------------------------------
328:     * ConfigurarPaginaLista - completa a Page1 (SIGPRGLX.PageDados.Page1 no
329:     * legado) com a grade principal (GradeItens -> grd_4c_Dados), os 3
330:     * paineis de resumo (Container3 "Estoque Disponivel"/grupo-conta,
331:     * Container1 "Estoque Em Producao"/fase, Container5 "Periodo/Referencia
332:     * Analisada"), a imagem do produto (ImgFigJpg) e os totais gerais da
333:     * pagina (Tot_Qtd/Tot_Est/Tot_Prz/Tot_prdc/Tot_prze), alem dos botoes de
334:     * acao/navegacao - todos filhos DIRETOS da Page1 (mapeamento.json:
335:     * SIGPRGLX.PageDados.Page1.<X>). Posicoes/Top/Left copiadas de
336:     * tasks/task618/layout.json SEM a compensacao +27 do PageFrame, mesmo
337:     * padrao ja usado no cnt_4c_Sombra (Fase 3).
338:     *
339:     * grd_4c_Dados liga DIRETO em TmpFinalg - cursor da MESMA DataSession
340:     * privada que FormSigPrGl2BO.ExecutarProcessamento deixa aberto (nome
341:     * LITERAL, nao cursor_4c_ - regra documentada em
342:     * FormSigPrGl2.BtnProcessarClick), por isso o Init assume
343:     * THIS.DataSessionId = par_oFormPai.DataSessionId. Em modo de teste de
344:     * UI (gb_4c_ValidandoUI), TmpFinalg nao existe - cria-se aqui um
345:     * cursor de apoio com a MESMA estrutura so para a tela abrir sem erro.
346:     * cursor_4c_TmpSaldg/cursor_4c_TmpFabr (Container3/Container1) sao os
347:     * equivalentes migrados de TmpSaldG/TmpFabr - mesma origem compartilhada.
348:     *--------------------------------------------------------------------------
349:     *--------------------------------------------------------------------------
350:     * this_lPermiteAjustarPrioridade - "If fChecaAcesso('SIGPRGLO',
351:     * 'PRIORIDADE')" do legado (Init, Container1/Container3.GradeDisp):
352:     * controla se a coluna Prior das grades de resumo eh editavel e se
353:     * cmd_4c_SelEstoque fica visivel.
354:     *--------------------------------------------------------------------------
355:     PROTECTED FUNCTION this_lPermiteAjustarPrioridade()
356:         RETURN fChecaAcesso("SIGPRGLO", "PRIORIDADE")
357:     ENDFUNC
358: 
359:     PROTECTED PROCEDURE ConfigurarPaginaLista()
360:         LOCAL loc_oPag1, loc_oCnt, loc_nCol
361: 
362:         loc_oPag1 = THIS.pgf_4c_1.Page1
363: 
364:         IF !USED("TmpFinalg")
365:             CREATE CURSOR TmpFinalg (Flag C(1), CPros C(14), CodCors C(4), CodTams C(4), ;
366:                 Linhas C(10), Qtds N(10,3), Saldo N(10,3), Estoque N(10,3), Produzir N(10,3), ;
367:                 Fabrs N(10,3), Produzir2 N(10,3), TotVenda N(10,3), QtdMins N(10,3), ;
368:                 KeySelM L, KeySelMP L, UsuLibs C(10))
369:             INDEX ON Cpros + CodCors + CodTams TAG Cpros
370:         ENDIF
371:         IF !USED("cursor_4c_TmpSaldg")
372:             CREATE CURSOR cursor_4c_TmpSaldg (Emps C(3), Grupos C(10), Estos C(10), CPros C(14), ;
373:                 CodCors C(4), CodTams C(4), Saldo N(12,3), Disps N(12,3), Priors N(2), Reservs N(12,3))
374:             INDEX ON CPros + CodCors + CodTams + STR(Priors, 2) + Grupos + Estos + Emps TAG CPros
375:             INDEX ON Emps + Grupos + Estos + CPros + CodCors + CodTams TAG GruEstPro
376:         ENDIF
377:         IF !USED("cursor_4c_TmpFabr")
378:             CREATE CURSOR cursor_4c_TmpFabr (Priors N(2), Nops N(10), Fases C(10), Cpros C(14), ;
379:                 CodCors C(4), CodTams C(4), Qtds N(12,3), Disps N(12,3), Reservs N(12,3))
380:             INDEX ON Cpros + CodCors + CodTams + STR(Priors, 2) + STR(Nops, 10) TAG Cpros
381:         ENDIF
382:         IF !USED("cursor_4c_TmpSaldo")
383:             CREATE CURSOR cursor_4c_TmpSaldo (CPros C(14), CodCors C(4), CodTams C(4), ;
384:                 Saldo N(12,3), Disps N(12,3), Fabrs N(12,3), DispFs N(12,3))
385:             INDEX ON CPros + CodCors + CodTams TAG CPros
386:         ENDIF
387:         *-- TmpSaldU (Init legado): marca "produto com selecao manual" por
388:         *-- item (KeySelm/KeySelmp), consultado/alterado pelos Valid das
389:         *-- colunas editaveis (Column7 aqui, Column10 na Page2)
390:         IF !USED("TmpSaldU")
391:             CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L, KeySelmp L)
392:             INDEX ON Cpros TAG Cpros
393:         ENDIF
394: 
395:         *-- Grade principal (TmpFinalg) -----------------------------------
396:         loc_oPag1.AddObject("grd_4c_Dados", "Grid")
397: 
398:         WITH loc_oPag1.grd_4c_Dados
399:             .Top         = 173
400:             .Left        = 52
401:             .Width       = 586
402:             .Height      = 173
403:             .RecordSource = ""
404:             .ColumnCount  = 10
405:             .RecordSource = "TmpFinalg"
406:             .RecordMark   = .F.
407:             .DeleteMark   = .F.
408:             .ReadOnly     = .F.
409: 
410:             .Column1.ControlSource = "TmpFinalg.Cpros"
411:             .Column1.Header1.Caption = "Produto"
412:             .Column1.Width = 90
413:             .Column1.ReadOnly = .T.

*-- Linhas 460 a 591:
460:         ENDWITH
461: 
462:         *-- GotFocus -> Column7.SetFocus SO nas colunas que o legado redireciona
463:         *-- (Column1/2/5/6/9 - dump: ver lista de PROCEDURE por coluna). NUNCA
464:         *-- no laco inteiro de 1 a 10: Column7 (Qtd Producao), Column8
465:         *-- (Produzir Estq, liberada por BtnAlteraqtdClick) e Column10 (Qtd
466:         *-- Estoque) sao JUSTAMENTE as digitaveis - redirecionar o foco delas
467:         *-- torna as tres inalcancaveis e o usuario nao consegue digitar nada.
468:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
469:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
470:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column5.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
471:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column6.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
472:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column9.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
473:         loc_oPag1.grd_4c_Dados.Column3.Text1.ReadOnly = .T.
474:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column3.Text1, "DblClick", THIS, "GradeItensPage1Column3DblClick")
475:         *-- Captura do "ThisForm.OldValue = This.Value" do When (as duas
476:         *-- colunas digitaveis) - sem isto o Valid nao tem com que comparar
477:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column7.Text1, "GotFocus", THIS, "CapturarOldValuePage1Col7")
478:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column10.Text1, "GotFocus", THIS, "CapturarOldValuePage1Col10")
479:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column7.Text1, "Valid", THIS, "GradeItensPage1Column7Valid")
480:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column7.Text1, "KeyPress", THIS, "GradeItensPage1LostFocus")
481:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column8.Text1, "KeyPress", THIS, "GradeItensPage1Column8LostFocus")
482:         *-- Column10 (Qtd Estoque) eh a SEGUNDA coluna digitavel do legado -
483:         *-- mesmo par Valid/LostFocus de Column7 (dump 7046-7146)
484:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column10.Text1, "Valid", THIS, "GradeItensPage1Column10Valid")
485:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column10.Text1, "KeyPress", THIS, "GradeItensPage1LostFocus")
486:         BINDEVENT(loc_oPag1.grd_4c_Dados, "AfterRowColChange", THIS, "GradeItensPage1AfterRowColChange")
487: 
488:         *-- Container3 "Estoque Disponivel" (grupo/conta, TmpSaldG) --------
489:         loc_oPag1.AddObject("cnt_4c_Container3", "Container")
490:         loc_oCnt = loc_oPag1.cnt_4c_Container3
491:         WITH loc_oCnt
492:             .Top = 371
493:             .Left = 50
494:             .Width = 363
495:             .Height = 186
496:             .BackStyle = 0
497:             .BorderWidth = 0
498:         ENDWITH
499: 
500:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
501:         WITH loc_oCnt.lbl_4c_Label1
502:             .AutoSize = .F.
503:             .Top = 1
504:             .Left = 0
505:             .Width = 363
506:             .Height = 16
507:             .FontBold = .T.
508:             .BackStyle = 0
509:             .ForeColor = RGB(90, 90, 90)
510:             .Caption = "Estoque Dispon" + CHR(237) + "vel"
511:         ENDWITH
512: 
513:         loc_oCnt.AddObject("grd_4c_DispGrupo", "Grid")
514:         WITH loc_oCnt.grd_4c_DispGrupo
515:             .Top = 15
516:             .Left = 3
517:             .Width = 358
518:             .Height = 147
519:             .RecordSource = ""
520:             .ColumnCount = 6
521:             .RecordSource = "cursor_4c_TmpSaldg"
522:             .RecordMark = .F.
523:             .DeleteMark = .F.
524:             .ReadOnly = .T.
525: 
526:             .Column1.ControlSource = "cursor_4c_TmpSaldg.Grupos"
527:             .Column1.Header1.Caption = "Grupo"
528:             .Column2.ControlSource = "cursor_4c_TmpSaldg.Estos"
529:             .Column2.Header1.Caption = "Conta"
530:             .Column3.ControlSource = "cursor_4c_TmpSaldg.Saldo"
531:             .Column3.Header1.Caption = "Saldo"
532:             .Column4.ControlSource = "cursor_4c_TmpSaldg.Saldo - cursor_4c_TmpSaldg.Disps"
533:             .Column4.Header1.Caption = "Reservado"
534:             .Column5.ControlSource = "cursor_4c_TmpSaldg.Disps"
535:             .Column5.Header1.Caption = "Disponivel"
536:             .Column6.ControlSource = "cursor_4c_TmpSaldg.Priors"
537:             .Column6.Header1.Caption = "Prior"
538:             .Column6.ReadOnly = !THIS.this_lPermiteAjustarPrioridade()
539:         ENDWITH
540:         BINDEVENT(loc_oCnt.grd_4c_DispGrupo.Column6.Text1, "KeyPress", THIS, "GradeDispGrupoColumn6LostFocus")
541: 
542:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
543:         WITH loc_oCnt.lbl_4c_Label2
544:             .AutoSize = .F.
545:             .Top = 163
546:             .Left = 128
547:             .Width = 42
548:             .Height = 17
549:             .FontBold = .T.
550:             .BackStyle = 0
551:             .ForeColor = RGB(90, 90, 90)
552:             .Caption = "Totais :"
553:         ENDWITH
554: 
555:         loc_oCnt.AddObject("txt_4c_Tot_Qtd", "TextBox")
556:         WITH loc_oCnt.txt_4c_Tot_Qtd
557:             .Top = 161
558:             .Left = 174
559:             .Width = 58
560:             .Height = 19
561:             .InputMask = "999,999.99"
562:             .ReadOnly = .T.
563:             .Value = 0
564:         ENDWITH
565:         loc_oCnt.AddObject("txt_4c_Tot_Est", "TextBox")
566:         WITH loc_oCnt.txt_4c_Tot_Est
567:             .Top = 161
568:             .Left = 234
569:             .Width = 58
570:             .Height = 19
571:             .InputMask = "999,999.99"
572:             .ReadOnly = .T.
573:             .Value = 0
574:         ENDWITH
575:         loc_oCnt.AddObject("txt_4c_Tot_Prz", "TextBox")
576:         WITH loc_oCnt.txt_4c_Tot_Prz
577:             .Top = 161
578:             .Left = 292
579:             .Width = 58
580:             .Height = 19
581:             .InputMask = "999,999.99"
582:             .ReadOnly = .T.
583:             .Value = 0
584:         ENDWITH
585: 
586:         *-- Container1 "Estoque Em Producao" (fase, TmpFabr) ---------------
587:         loc_oPag1.AddObject("cnt_4c_Container1", "Container")
588:         loc_oCnt = loc_oPag1.cnt_4c_Container1
589:         WITH loc_oCnt
590:             .Top = 371
591:             .Left = 418

*-- Linhas 606 a 679:
606:             .BackStyle = 0
607:             .ForeColor = RGB(90, 90, 90)
608:             .Caption = "Estoque Em Produ" + CHR(231) + CHR(227) + "o"
609:         ENDWITH
610: 
611:         loc_oCnt.AddObject("grd_4c_DispFase", "Grid")
612:         WITH loc_oCnt.grd_4c_DispFase
613:             .Top = 15
614:             .Left = 2
615:             .Width = 303
616:             .Height = 99
617:             .RecordSource = ""
618:             .ColumnCount = 6
619:             .RecordSource = "cursor_4c_TmpFabr"
620:             .RecordMark = .F.
621:             .DeleteMark = .F.
622:             .ReadOnly = .T.
623: 
624:             .Column1.ControlSource = "cursor_4c_TmpFabr.Fases"
625:             .Column1.Header1.Caption = "Fase"
626:             .Column2.ControlSource = "cursor_4c_TmpFabr.Qtds"
627:             .Column2.Header1.Caption = "Quantidade"
628:             .Column3.ControlSource = "cursor_4c_TmpFabr.Disps"
629:             .Column3.Header1.Caption = "Disponivel"
630:             .Column4.ControlSource = "cursor_4c_TmpFabr.Priors"
631:             .Column4.Header1.Caption = "Prior"
632:             .Column4.ReadOnly = !THIS.this_lPermiteAjustarPrioridade()
633:             .Column5.ControlSource = ""
634:             .Column5.Header1.Caption = ""
635:             .Column6.ControlSource = "cursor_4c_TmpFabr.Nops"
636:             .Column6.Header1.Caption = "Nop"
637:             .Column6.Visible = .F.
638:         ENDWITH
639:         BINDEVENT(loc_oCnt.grd_4c_DispFase.Column4.Text1, "KeyPress", THIS, "GradeDispFaseColumn4LostFocus")
640: 
641:         loc_oCnt.AddObject("lbl_4c_label22", "Label")
642:         WITH loc_oCnt.lbl_4c_label22
643:             .AutoSize = .F.
644:             .Top = 115
645:             .Left = 102
646:             .Width = 42
647:             .Height = 17
648:             .FontBold = .T.
649:             .BackStyle = 0
650:             .ForeColor = RGB(90, 90, 90)
651:             .Caption = "Totais :"
652:         ENDWITH
653:         loc_oCnt.AddObject("txt_4c_tot_qtd2", "TextBox")
654:         WITH loc_oCnt.txt_4c_tot_qtd2
655:             .Top = 113
656:             .Left = 145
657:             .Width = 61
658:             .Height = 19
659:             .InputMask = "999,999.99"
660:             .ReadOnly = .T.
661:             .Value = 0
662:         ENDWITH
663:         loc_oCnt.AddObject("txt_4c_tot_est2", "TextBox")
664:         WITH loc_oCnt.txt_4c_tot_est2
665:             .Top = 113
666:             .Left = 207
667:             .Width = 61
668:             .Height = 19
669:             .InputMask = "999,999.99"
670:             .ReadOnly = .T.
671:             .Value = 0
672:         ENDWITH
673: 
674:         *-- Container5 "Periodo/Referencia Analisada" ----------------------
675:         loc_oPag1.AddObject("cnt_4c_Container5", "Container")
676:         loc_oCnt = loc_oPag1.cnt_4c_Container5
677:         WITH loc_oCnt
678:             .Top = 129
679:             .Left = 36

*-- Linhas 767 a 841:
767:             .Stretch = 1
768:             .Visible = .F.
769:         ENDWITH
770:         BINDEVENT(loc_oPag1.img_4c_FigJpg, "DblClick", THIS, "ImgFigJpgPage1DblClick")
771: 
772:         *-- Totais gerais da pagina (soma de TmpFinalg) --------------------
773:         loc_oPag1.AddObject("lbl_4c_Label1", "Label")
774:         WITH loc_oPag1.lbl_4c_Label1
775:             .AutoSize = .F.
776:             .Top = 348
777:             .Left = 224
778:             .Width = 42
779:             .Height = 17
780:             .FontBold = .T.
781:             .BackStyle = 0
782:             .ForeColor = RGB(90, 90, 90)
783:             .Caption = "Totais :"
784:         ENDWITH
785:         loc_oPag1.AddObject("txt_4c_Tot_Qtd", "TextBox")
786:         WITH loc_oPag1.txt_4c_Tot_Qtd
787:             .Top = 346
788:             .Left = 271
789:             .Width = 67
790:             .Height = 19
791:             .InputMask = "999,999.99"
792:             .ReadOnly = .T.
793:             .Value = 0
794:         ENDWITH
795:         loc_oPag1.AddObject("txt_4c_Tot_prdc", "TextBox")
796:         WITH loc_oPag1.txt_4c_Tot_prdc
797:             .Top = 346
798:             .Left = 339
799:             .Width = 67
800:             .Height = 19
801:             .InputMask = "999,999.99"
802:             .ReadOnly = .T.
803:             .Value = 0
804:         ENDWITH
805:         loc_oPag1.AddObject("txt_4c_Tot_Est", "TextBox")
806:         WITH loc_oPag1.txt_4c_Tot_Est
807:             .Top = 346
808:             .Left = 407
809:             .Width = 68
810:             .Height = 19
811:             .InputMask = "999,999.99"
812:             .ReadOnly = .T.
813:             .Value = 0
814:         ENDWITH
815:         loc_oPag1.AddObject("txt_4c_Tot_Prz", "TextBox")
816:         WITH loc_oPag1.txt_4c_Tot_Prz
817:             .Top = 346
818:             .Left = 476
819:             .Width = 67
820:             .Height = 19
821:             .InputMask = "999,999.99"
822:             .ReadOnly = .T.
823:             .Value = 0
824:         ENDWITH
825:         loc_oPag1.AddObject("txt_4c_Tot_prze", "TextBox")
826:         WITH loc_oPag1.txt_4c_Tot_prze
827:             .Top = 346
828:             .Left = 543
829:             .Width = 75
830:             .Height = 19
831:             .InputMask = "999,999.99"
832:             .ReadOnly = .T.
833:             .Value = 0
834:         ENDWITH
835: 
836:         *-- Botoes de navegacao/acao - filhos diretos da Page1, posicoes do
837:         *-- legado (tasks/task618/layout.json). Pedras/SelEstoque/Disponivel
838:         *-- nascem ocultos (Visible=.F. no SCX original); a logica que os
839:         *-- exibe por tipo de estoque (TipoEstos) e o restante dos Click
840:         *-- (Processar/TotLinha/Alteraqtd/Pedras/Cancelar) entra na fase de
841:         *-- eventos/handlers.

*-- Linhas 848 a 989:
848:             .Caption = "\<Requisi" + CHR(231) + CHR(245) + "es"
849:             .Visible = .F.
850:         ENDWITH
851:         BINDEVENT(loc_oPag1.cmd_4c_Pedras, "Click", THIS, "BtnPedrasClick")
852: 
853:         loc_oPag1.AddObject("cmd_4c_SelEstoque", "CommandButton")
854:         WITH loc_oPag1.cmd_4c_SelEstoque
855:             .Top     = 2
856:             .Left    = 423
857:             .Width   = 75
858:             .Height  = 75
859:             .Caption = "\<Estoques"
860:             .Visible = THIS.this_lPermiteAjustarPrioridade()
861:         ENDWITH
862:         BINDEVENT(loc_oPag1.cmd_4c_SelEstoque, "Click", THIS, "BtnSelEstoqueClick")
863: 
864:         loc_oPag1.AddObject("cmd_4c_Disponivel", "CommandButton")
865:         WITH loc_oPag1.cmd_4c_Disponivel
866:             .Top     = 2
867:             .Left    = 498
868:             .Width   = 75
869:             .Height  = 75
870:             .Caption = "\<Disponiveis"
871:             .Visible = .F.
872:         ENDWITH
873:         BINDEVENT(loc_oPag1.cmd_4c_Disponivel, "Click", THIS, "BtnDisponivelClick")
874: 
875:         loc_oPag1.AddObject("cmd_4c_TotLinha", "CommandButton")
876:         WITH loc_oPag1.cmd_4c_TotLinha
877:             .Top     = 2
878:             .Left    = 573
879:             .Width   = 75
880:             .Height  = 75
881:             .Caption = "\<Total/Linhas"
882:         ENDWITH
883:         BINDEVENT(loc_oPag1.cmd_4c_TotLinha, "Click", THIS, "BtnTotLinhaClick")
884: 
885:         loc_oPag1.AddObject("cmd_4c_Processar", "CommandButton")
886:         WITH loc_oPag1.cmd_4c_Processar
887:             .Top     = 2
888:             .Left    = 648
889:             .Width   = 75
890:             .Height  = 75
891:             .Caption = "\<Processar"
892:         ENDWITH
893:         BINDEVENT(loc_oPag1.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
894: 
895:         loc_oPag1.AddObject("cmd_4c_Cancelar", "CommandButton")
896:         WITH loc_oPag1.cmd_4c_Cancelar
897:             .Top     = 2
898:             .Left    = 723
899:             .Width   = 75
900:             .Height  = 75
901:             .Caption = "Encerrar"
902:         ENDWITH
903:         BINDEVENT(loc_oPag1.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
904: 
905:         loc_oPag1.AddObject("cmd_4c_Alteraqtd", "CommandButton")
906:         WITH loc_oPag1.cmd_4c_Alteraqtd
907:             .Top     = 189
908:             .Left    = 687
909:             .Width   = 40
910:             .Height  = 40
911:             .Caption = ""
912:         ENDWITH
913:         BINDEVENT(loc_oPag1.cmd_4c_Alteraqtd, "Click", THIS, "BtnAlteraqtdClick")
914:     ENDPROC
915: 
916:     *--------------------------------------------------------------------------
917:     * ConfigurarPaginaDados - completa a Page2 (SIGPRGLX.PageDados.Page2 no
918:     * legado) com a grade de selecao de linha (GradeItens -> grd_4c_Dados,
919:     * ligada ao cursor TmpFinal do legado), os totais GERAL (Label1 "Totais :"
920:     * + Tot_Qtd/Tot_Est/Tot_Prz/Tot_prc, azul) e SELECIONADO (Label2 "Qtd
921:     * Selecionada :" + Tot_sEst/Tot_sPrc, vermelho), a imagem do produto
922:     * corrente (img_4c_FigJpg), a observacao do item (obj_4c_ObsItens +
923:     * lbl_4c_Txt_ObsItens) e o botao Cancelar/Voltar - ver
924:     * tasks/task618/SigPrGlx_form_codigo_fonte.txt linhas 2386-2924.
925:     *
926:     * Page2 NAO tem nenhum campo de lookup (F4/fwBuscaExt) no legado - todas
927:     * as colunas da grade sao ReadOnly (dados ja resolvidos na Page1) ou
928:     * quantidade editavel validada por faixa (Column7/Column10.Valid, fase
929:     * de eventos). O unico lookup de todo o form (fwBuscaExt sobre SigCdPro,
930:     * por Cpros) fica em Page6.GradePedra (Requisicao Manual de Material),
931:     * montada em ConfigurarPaginaRequisicao(), com os dois lookups da
932:     * Column1/Column5 completamente implementados.
933:     *
934:     * A grade do legado foi desenhada com colunas RENOMEADAS (Column.Name)
935:     * fora da ordem fisica de criacao - o que importa para a fidelidade
936:     * visual eh a ORDEM mostrada (ColumnOrder) e nao a ordem de criacao.
937:     * Aqui os 10 Column1..Column10 ja nascem na ORDEM VISUAL final do
938:     * legado (Produto/Cor/Tam/Opera??o/N?mero/Quantidade/Estoque/Produzir/
939:     * Obs/Produ??o), evitando reproduzir o artefato de renomeacao do SCX.
940:     * Estoque (editavel, fundo amarelo) e Produ??o (editavel, fundo
941:     * amarelo) sao as 2 colunas que o usuario preenche manualmente - as
942:     * demais ficam ReadOnly, como no legado.
943:     *
944:     * TmpFinal (literal, nao cursor_4c_) eh o cursor de apoio desta grade -
945:     * a populacao real entra em fase posterior; a estrutura aqui tem de
946:     * bater exatamente com o que for populado depois (mesma regra do
947:     * cursor de apoio usada em ConfigurarPaginaLista).
948:     *--------------------------------------------------------------------------
949:     PROTECTED PROCEDURE ConfigurarPaginaDados()
950:         LOCAL loc_oPag2, loc_nCol
951: 
952:         loc_oPag2 = THIS.pgf_4c_1.Page2
953: 
954:         *-- TmpFinal (literal, nao cursor_4c_) - cursor compartilhado criado
955:         *-- por FormSigPrGl2BO.ExecutarProcessamento na MESMA DataSession
956:         *-- (THIS.DataSessionId assumida do pai em Init - ver regra na
957:         *-- cabeca de ConfigurarPaginaLista). Cursor de apoio so para modo
958:         *-- de teste de UI, com a MESMA estrutura exportada pelo pai.
959:         IF !USED("TmpFinal")
960:             CREATE CURSOR TmpFinal (Emps C(3), Dopes C(20), Numes N(6), CPros C(14), Qtds N(10,3), ;
961:                 Peso N(9,3), Saldo N(10,3), Estoque N(10,3), Produzir N(10,3), Obs M NULL, ;
962:                 Obsps M NULL, Datas D NULL, Entregas D NULL, CodCors C(4), CodTams C(4), ;
963:                 Linhas C(10), Citens N(10), Reffs C(40), Notas C(6), Dpros C(40), GrupoDs C(10), ;
964:                 ContaDs C(10), KeySelM L, Fabrs N(10,3), KeyPdes L, Jobs C(10))
965:             INDEX ON Cpros + CodCors + CodTams TAG Cpros
966:         ENDIF
967: 
968:         *-- Grade de selecao de linha (GradeItens / TmpFinal). ControlSource
969:         *-- remapeado conforme SIGPRGLX.Init (dump 4279-4291) - NAO pela
970:         *-- ordem fisica de Column no SCX (ver nota do cabecalho do metodo).
971:         loc_oPag2.AddObject("grd_4c_Dados", "Grid")
972: 
973:         WITH loc_oPag2.grd_4c_Dados
974:             .Top          = 181
975:             .Left         = 53
976:             .Width        = 703
977:             .Height       = 189
978:             .FontName     = "Tahoma"
979:             .FontSize     = 8
980:             .RecordSource = ""
981:             .ColumnCount  = 10
982:             .RecordSource = "TmpFinal"
983:             .AllowHeaderSizing = .F.
984:             .AllowRowSizing    = .F.
985:             .RowHeight    = 17
986:             .GridLineColor = RGB(238, 238, 238)
987:             .RecordMark   = .F.
988:             .DeleteMark   = .F.
989:             .ReadOnly     = .F.

*-- Linhas 1046 a 1112:
1046:         ENDWITH
1047: 
1048:         *-- Cabecalhos: Tahoma 8, alinhado ao centro, azul - igual ao legado
1049:         *-- em todas as 10 colunas.
1050:         FOR loc_nCol = 1 TO 10
1051:             WITH EVALUATE("loc_oPag2.grd_4c_Dados.Column" + TRANSFORM(loc_nCol) + ".Header1")
1052:                 .FontName   = "Tahoma"
1053:                 .FontSize   = 8
1054:                 .Alignment  = 2
1055:                 .ForeColor  = RGB(36, 84, 155)
1056:             ENDWITH
1057:         ENDFOR
1058: 
1059:         FOR loc_nCol = 1 TO 10
1060:             IF !INLIST(loc_nCol, 7, 10)
1061:                 BINDEVENT(loc_oPag2.grd_4c_Dados.Columns(loc_nCol).Text1, "GotFocus", THIS, "GradeItensPage2GotFocus")
1062:             ENDIF
1063:         ENDFOR
1064:         *-- Captura do "ThisForm.OldValue = This.Value" do When (as duas
1065:         *-- colunas digitaveis) - sem isto o Valid nao tem com que comparar
1066:         BINDEVENT(loc_oPag2.grd_4c_Dados.Column7.Text1, "GotFocus", THIS, "CapturarOldValuePage2Col7")
1067:         BINDEVENT(loc_oPag2.grd_4c_Dados.Column10.Text1, "GotFocus", THIS, "CapturarOldValuePage2Col10")
1068:         BINDEVENT(loc_oPag2.grd_4c_Dados.Column7.Text1, "Valid", THIS, "GradeItensPage2Column7Valid")
1069:         BINDEVENT(loc_oPag2.grd_4c_Dados.Column7.Text1, "KeyPress", THIS, "GradeItensPage2LostFocus")
1070:         BINDEVENT(loc_oPag2.grd_4c_Dados.Column10.Text1, "Valid", THIS, "GradeItensPage2Column10Valid")
1071:         BINDEVENT(loc_oPag2.grd_4c_Dados.Column10.Text1, "KeyPress", THIS, "GradeItensPage2LostFocus")
1072:         BINDEVENT(loc_oPag2.grd_4c_Dados, "AfterRowColChange", THIS, "GradeItensPage2AfterRowColChange")
1073: 
1074:         *-- Totais (parte 1 de 2 - Label1 + Tot_Qtd/Tot_Est/Tot_Prz/Tot_prc,
1075:         *-- total GERAL em azul). Parte 2 (Label2/Tot_sEst/Tot_sPrc = total
1076:         *-- SELECIONADO em vermelho, ImgFigJpg, ObsItens, Txt_ObsItens e o
1077:         *-- botao Cancelar) vem a seguir.
1078:         loc_oPag2.AddObject("lbl_4c_Label1", "Label")
1079:         WITH loc_oPag2.lbl_4c_Label1
1080:             .AutoSize  = .F.
1081:             .Top       = 372
1082:             .Left      = 403
1083:             .Width     = 42
1084:             .Height    = 17
1085:             .FontName  = "Tahoma"
1086:             .FontSize  = 8
1087:             .FontBold  = .T.
1088:             .BackStyle = 0
1089:             .ForeColor = RGB(90, 90, 90)
1090:             .Caption   = "Totais :"
1091:         ENDWITH
1092: 
1093:         loc_oPag2.AddObject("txt_4c_Tot_Qtd", "TextBox")
1094:         WITH loc_oPag2.txt_4c_Tot_Qtd
1095:             .Top       = 370
1096:             .Left      = 449
1097:             .Width     = 68
1098:             .Height    = 19
1099:             .FontBold  = .T.
1100:             .InputMask = "999,999.99"
1101:             .Margin    = 0
1102:             .ReadOnly  = .T.
1103:             .ForeColor = RGB(0, 0, 255)
1104:             .Value     = 0
1105:         ENDWITH
1106: 
1107:         loc_oPag2.AddObject("txt_4c_Tot_Est", "TextBox")
1108:         WITH loc_oPag2.txt_4c_Tot_Est
1109:             .Top       = 370
1110:             .Left      = 516
1111:             .Width     = 67
1112:             .Height    = 19

*-- Linhas 1130 a 1151:
1130:             .ReadOnly  = .T.
1131:             .ForeColor = RGB(0, 0, 255)
1132:             .Value     = 0
1133:         ENDWITH
1134: 
1135:         loc_oPag2.AddObject("txt_4c_Tot_Prz", "TextBox")
1136:         WITH loc_oPag2.txt_4c_Tot_Prz
1137:             .Top       = 370
1138:             .Left      = 648
1139:             .Width     = 67
1140:             .Height    = 19
1141:             .FontBold  = .T.
1142:             .InputMask = "999,999.99"
1143:             .Margin    = 0
1144:             .ReadOnly  = .T.
1145:             .ForeColor = RGB(0, 0, 255)
1146:             .Value     = 0
1147:         ENDWITH
1148: 
1149:         *-- Totais (parte 2 de 2) -----------------------------------------
1150:         *-- Label2/Tot_sEst/Tot_sPrc = "Qtd Selecionada" (Estoque/Producao
1151:         *-- somados pelo usuario nas sub-paginas 4/5/6), em VERMELHO para

*-- Linhas 1192 a 1212:
1192:             .ForeColor = RGB(255, 0, 0)
1193:             .Value     = 0
1194:         ENDWITH
1195: 
1196:         *-- Imagem do produto da linha corrente (TmpPro.FigJpgs, carregada no
1197:         *-- AfterRowColChange de grd_4c_Dados - fase de eventos). Nasce oculta
1198:         *-- como no legado (Visible=.F.) - so aparece quando ha figura.
1199:         loc_oPag2.AddObject("img_4c_FigJpg", "Image")
1200:         WITH loc_oPag2.img_4c_FigJpg
1201:             .Top         = 394
1202:             .Left        = 73
1203:             .Width       = 135
1204:             .Height      = 92
1205:             .Stretch     = 1
1206:             .Visible     = .F.
1207:             .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
1208:         ENDWITH
1209: 
1210:         *-- Observacao do item corrente (TmpFinal.Obsps) - EditBox somente
1211:         *-- leitura, com label de titulo que a fase de eventos atualiza com
1212:         *-- o codigo do produto (Txt_ObsItens.Caption, no AfterRowColChange).

*-- Linhas 1257 a 1344:
1257:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1258:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1259:         ENDWITH
1260:         BINDEVENT(loc_oPag2.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarPage2Click")
1261:     ENDPROC
1262: 
1263: 
1264:     *--------------------------------------------------------------------------
1265:     * ConfigurarPaginaTotaisLinha - Page3 (SIGPRGLX.PageDados.Page3): grade
1266:     * de totais consolidados por linha de produto (GradeLinhas -> TmpLinha no
1267:     * legado, alimentada pelo Click de cmd_4c_TotLinha). Toda a grade eh
1268:     * somente-leitura no legado (Grid.ReadOnly = .T.), portanto NAO tem
1269:     * lookup - nao ha onde digitar codigo para o picker resolver.
1270:     *
1271:     * Posicoes/Top/Left transcritas da secao "PROPRIEDADES DE:
1272:     * SIGPRGLX.PageDados.Page3.*" do dump legado, SEM compensacao de
1273:     * PageFrame (mesmo criterio das Fases 3-5 deste form, cujo
1274:     * pgf_4c_1.Top = -27 veio cru do SCX).
1275:     *
1276:     * cursor_4c_Linhas eh o cursor de apoio desta grade (TmpLinha no legado) -
1277:     * a estrutura aqui tem de bater EXATAMENTE com a do SELECT que a popula
1278:     * depois (regra do cursor de apoio / APPEND FROM casa por NOME).
1279:     *--------------------------------------------------------------------------
1280:     PROTECTED PROCEDURE ConfigurarPaginaTotaisLinha()
1281:         LOCAL loc_oPag3, loc_nCol
1282: 
1283:         loc_oPag3 = THIS.pgf_4c_1.Page3
1284: 
1285:         WITH loc_oPag3
1286:             .Caption   = "Totais por Linha"
1287:             .FontBold  = .T.
1288:             .ForeColor = RGB(0, 128, 192)
1289:             .Enabled   = .F.
1290:         ENDWITH
1291: 
1292:         SET NULL ON
1293:         IF !USED("cursor_4c_Linhas")
1294:             CREATE CURSOR cursor_4c_Linhas ;
1295:                 (Linhas C(10) NULL, Ordem N(1) NULL, Saldo N(12,3) NULL, ;
1296:                  Estoque N(12,3) NULL, Produzir N(12,3) NULL, Fabrs N(12,3) NULL)
1297:         ENDIF
1298:         SET NULL OFF
1299: 
1300:         *-- Titulo da sub-tela (Label2 + Shape4 no legado) ------------------
1301:         loc_oPag3.AddObject("lbl_4c_Label2", "Label")
1302:         WITH loc_oPag3.lbl_4c_Label2
1303:             .AutoSize   = .F.
1304:             .Top        = 147
1305:             .Left       = 173
1306:             .Width      = 157
1307:             .Height     = 25
1308:             .FontName   = "Tahoma"
1309:             .FontSize   = 14
1310:             .FontBold   = .T.
1311:             .FontItalic = .T.
1312:             .BackStyle  = 0
1313:             .ForeColor  = RGB(90, 90, 90)
1314:             .Caption    = "Totais por Linha"
1315:         ENDWITH
1316: 
1317:         loc_oPag3.AddObject("shp_4c_Shape4", "Shape")
1318:         WITH loc_oPag3.shp_4c_Shape4
1319:             .Top         = 169
1320:             .Left        = 168
1321:             .Width       = 437
1322:             .Height      = 2
1323:             .BorderWidth = 1
1324:         ENDWITH
1325: 
1326:         *-- Grade de totais por linha (GradeLinhas / TmpLinha) --------------
1327:         loc_oPag3.AddObject("grd_4c_Linhas", "Grid")
1328: 
1329:         WITH loc_oPag3.grd_4c_Linhas
1330:             .Top          = 181
1331:             .Left         = 167
1332:             .Width        = 438
1333:             .Height       = 292
1334:             .FontName     = "Tahoma"
1335:             .FontSize     = 8
1336:             .AllowHeaderSizing = .F.
1337:             .AllowRowSizing    = .F.
1338:             .RowHeight    = 16
1339:             .ScrollBars   = 2
1340:             .GridLineColor = RGB(238, 238, 238)
1341:             .DeleteMark   = .F.
1342:             .RecordMark   = .T.
1343:             .RecordSource = ""
1344:             .ColumnCount  = 5

*-- Linhas 1395 a 1415:
1395:             .Column5.Text1.InputMask = "999,999.99"
1396:             .Column5.Text1.MaxLength = 10
1397:         ENDWITH
1398: 
1399:         FOR loc_nCol = 1 TO 5
1400:             WITH EVALUATE("loc_oPag3.grd_4c_Linhas.Column" + TRANSFORM(loc_nCol) + ".Header1")
1401:                 .FontName  = "Tahoma"
1402:                 .FontSize  = 8
1403:                 .Alignment = 2
1404:                 .ForeColor = RGB(36, 84, 155)
1405:             ENDWITH
1406:         ENDFOR
1407: 
1408:         *-- Voltar (CancelaLin) --------------------------------------------
1409:         loc_oPag3.AddObject("cmd_4c_CancelaLin", "CommandButton")
1410:         WITH loc_oPag3.cmd_4c_CancelaLin
1411:             .Top         = 12
1412:             .Left        = 704
1413:             .Width       = 75
1414:             .Height      = 75
1415:             .FontName    = "Comic Sans MS"

*-- Linhas 1425 a 1531:
1425:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1426:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1427:         ENDWITH
1428:         BINDEVENT(loc_oPag3.cmd_4c_CancelaLin, "Click", THIS, "BtnCancelaLinClick")
1429:     ENDPROC
1430: 
1431:     *--------------------------------------------------------------------------
1432:     * ConfigurarPaginaEstoque - Page4 (SIGPRGLX.PageDados.Page4, "Selecionar
1433:     * Estoque"): grade de saldo disponivel POR GRUPO/CONTA (GradeDisp ->
1434:     * TmpDisp no legado, montado pelo Click de cmd_4c_SelEstoque a partir de
1435:     * TmpSaldG) mais os totalizadores Qtde Pedida / Qtde Selecionada.
1436:     *
1437:     * No legado as Pages 4 e 5 compartilham o MESMO alias TmpDisp, recriado
1438:     * com estruturas DIFERENTES a cada clique (Page4 traz Grupo/Conta/Prior,
1439:     * Page5 traz Produto/Cor/Tam). Aqui cada grade recebe o SEU cursor
1440:     * (cursor_4c_DispEstoque / cursor_4c_DispTamanho): manter o alias
1441:     * compartilhado obrigaria a derrubar o alias ligado a outra grade, o que
1442:     * zera o ColumnCount dela e a deixa morta pelo resto da vida do form.
1443:     * Divergencia de CODIGO (PILAR 3) - o que o usuario ve eh identico.
1444:     *
1445:     * Unica coluna editavel: "Utilizar" (Column5) - quantidade que o usuario
1446:     * tira daquele grupo/conta. As outras quatro sao ReadOnly no legado,
1447:     * portanto esta pagina nao tem campo de lookup.
1448:     *--------------------------------------------------------------------------
1449:     PROTECTED PROCEDURE ConfigurarPaginaEstoque()
1450:         LOCAL loc_oPag4, loc_nCol
1451: 
1452:         loc_oPag4 = THIS.pgf_4c_1.Page4
1453: 
1454:         WITH loc_oPag4
1455:             .Caption    = "Selecionar Estoque"
1456:             .FontBold   = .T.
1457:             .FontItalic = .T.
1458:             .ForeColor  = RGB(0, 128, 192)
1459:             .Enabled    = .F.
1460:         ENDWITH
1461: 
1462:         SET NULL ON
1463:         IF !USED("cursor_4c_DispEstoque")
1464:             CREATE CURSOR cursor_4c_DispEstoque ;
1465:                 (Priors N(2) NULL, Grupos C(10) NULL, Estos C(10) NULL, ;
1466:                  Cpros C(14) NULL, CodCors C(10) NULL, CodTams C(10) NULL, ;
1467:                  Disps N(12,3) NULL, Utilizar N(12,3) NULL)
1468:         ENDIF
1469:         SET NULL OFF
1470: 
1471:         *-- Titulo da sub-tela (Label1 + Shape4) ----------------------------
1472:         loc_oPag4.AddObject("lbl_4c_Label1", "Label")
1473:         WITH loc_oPag4.lbl_4c_Label1
1474:             .AutoSize   = .F.
1475:             .Top        = 138
1476:             .Left       = 197
1477:             .Width      = 184
1478:             .Height     = 25
1479:             .FontName   = "Tahoma"
1480:             .FontSize   = 14
1481:             .FontBold   = .T.
1482:             .FontItalic = .T.
1483:             .BackStyle  = 0
1484:             .ForeColor  = RGB(90, 90, 90)
1485:             .Caption    = "Selecionar Estoque"
1486:         ENDWITH
1487: 
1488:         loc_oPag4.AddObject("shp_4c_Shape4", "Shape")
1489:         WITH loc_oPag4.shp_4c_Shape4
1490:             .Top         = 159
1491:             .Left        = 191
1492:             .Width       = 370
1493:             .Height      = 2
1494:             .BorderWidth = 1
1495:         ENDWITH
1496: 
1497:         *-- Produto da linha corrente da grade principal (TmpFinalg.Cpros -
1498:         *-- mesmo cursor literal usado em grd_4c_Dados.RecordSource da Page1,
1499:         *-- NAO o cursor_4c_Dados renomeado que nunca chegou a existir aqui).
1500:         loc_oPag4.AddObject("txt_4c_Cpros", "TextBox")
1501:         WITH loc_oPag4.txt_4c_Cpros
1502:             .Top           = 138
1503:             .Left          = 479
1504:             .Width         = 80
1505:             .Height        = 19
1506:             .FontBold      = .T.
1507:             .Margin        = 0
1508:             .ReadOnly      = .T.
1509:             .ForeColor     = RGB(0, 0, 255)
1510:             .ControlSource = "TmpFinalg.Cpros"
1511:         ENDWITH
1512: 
1513:         *-- Grade de disponivel por grupo/conta (GradeDisp / TmpSaldG) ------
1514:         loc_oPag4.AddObject("grd_4c_DispEstoque", "Grid")
1515: 
1516:         WITH loc_oPag4.grd_4c_DispEstoque
1517:             .Top          = 169
1518:             .Left         = 191
1519:             .Width        = 370
1520:             .Height       = 244
1521:             .FontSize     = 8
1522:             .AllowHeaderSizing = .F.
1523:             .AllowRowSizing    = .F.
1524:             .RowHeight    = 16
1525:             .ScrollBars   = 2
1526:             .GridLineColor = RGB(238, 238, 238)
1527:             .DeleteMark   = .F.
1528:             .RecordMark   = .T.
1529:             .Panel        = 1
1530:             .RecordSource = ""
1531:             .ColumnCount  = 5

*-- Linhas 1568 a 1641:
1568:             .Column5.Movable   = .F.
1569:             .Column5.Resizable = .F.
1570:             .Column5.ReadOnly  = .F.
1571:             .Column5.Text1.FontBold = .T.
1572:         ENDWITH
1573:         BINDEVENT(loc_oPag4.grd_4c_DispEstoque.Column5.Text1, "Valid", THIS, "GradeDispEstoqueColumn5Valid")
1574:         BINDEVENT(loc_oPag4.grd_4c_DispEstoque.Column5.Text1, "KeyPress", THIS, "GradeDispColumn5LostFocus")
1575: 
1576:         FOR loc_nCol = 1 TO 5
1577:             WITH EVALUATE("loc_oPag4.grd_4c_DispEstoque.Column" + TRANSFORM(loc_nCol) + ".Header1")
1578:                 .FontName  = "Verdana"
1579:                 .FontSize  = 8
1580:                 .Alignment = 2
1581:                 .ForeColor = RGB(36, 84, 155)
1582:             ENDWITH
1583:         ENDFOR
1584: 
1585:         *-- Totalizadores da selecao ----------------------------------------
1586:         loc_oPag4.AddObject("lbl_4c_Label2", "Label")
1587:         WITH loc_oPag4.lbl_4c_Label2
1588:             .AutoSize  = .F.
1589:             .Top       = 418
1590:             .Left      = 220
1591:             .Width     = 82
1592:             .Height    = 16
1593:             .FontName  = "Tahoma"
1594:             .FontSize  = 8
1595:             .BackStyle = 0
1596:             .ForeColor = RGB(90, 90, 90)
1597:             .Caption   = "Qtde Pedida : "
1598:         ENDWITH
1599: 
1600:         loc_oPag4.AddObject("lbl_4c_Label3", "Label")
1601:         WITH loc_oPag4.lbl_4c_Label3
1602:             .AutoSize  = .F.
1603:             .Top       = 437
1604:             .Left      = 192
1605:             .Width     = 110
1606:             .Height    = 16
1607:             .FontName  = "Tahoma"
1608:             .FontSize  = 8
1609:             .BackStyle = 0
1610:             .ForeColor = RGB(90, 90, 90)
1611:             .Caption   = "Qtde Selecionada : "
1612:         ENDWITH
1613: 
1614:         loc_oPag4.AddObject("txt_4c_Qt_pedida", "TextBox")
1615:         WITH loc_oPag4.txt_4c_Qt_pedida
1616:             .Top       = 413
1617:             .Left      = 312
1618:             .Width     = 67
1619:             .Height    = 23
1620:             .InputMask = "9,999.99"
1621:             .ReadOnly  = .T.
1622:             .Value     = 0
1623:         ENDWITH
1624: 
1625:         loc_oPag4.AddObject("txt_4c_Qt_Selec", "TextBox")
1626:         WITH loc_oPag4.txt_4c_Qt_Selec
1627:             .Top       = 436
1628:             .Left      = 312
1629:             .Width     = 67
1630:             .Height    = 23
1631:             .Alignment = 3
1632:             .InputMask = "9,999.99"
1633:             .ReadOnly  = .T.
1634:             .Value     = 0
1635:         ENDWITH
1636: 
1637:         *-- Voltar (CancelaDisp) --------------------------------------------
1638:         loc_oPag4.AddObject("cmd_4c_CancelaDisp", "CommandButton")
1639:         WITH loc_oPag4.cmd_4c_CancelaDisp
1640:             .Top         = 12
1641:             .Left        = 704

*-- Linhas 1654 a 1711:
1654:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1655:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1656:         ENDWITH
1657:         BINDEVENT(loc_oPag4.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDispPage4Click")
1658:     ENDPROC
1659: 
1660:     *--------------------------------------------------------------------------
1661:     * ConfigurarPaginaTamanhos - Page5 (SIGPRGLX.PageDados.Page5,
1662:     * "Disponivel/Tamanho"): grade do saldo disponivel QUEBRADO POR TAMANHO
1663:     * (GradeDisp -> TmpDisp no legado, montado pelo Click de
1664:     * cmd_4c_Disponivel a partir de TmpSaldo) mais os mesmos totalizadores
1665:     * Qtde Pedida / Qtde Selecionada da Page4.
1666:     *
1667:     * Cursor proprio (cursor_4c_DispTamanho) pelo motivo explicado em
1668:     * ConfigurarPaginaEstoque. Unica coluna editavel: "Utilizar" (Column5) -
1669:     * as demais sao ReadOnly, portanto esta pagina nao tem lookup.
1670:     *--------------------------------------------------------------------------
1671:     PROTECTED PROCEDURE ConfigurarPaginaTamanhos()
1672:         LOCAL loc_oPag5, loc_nCol
1673: 
1674:         loc_oPag5 = THIS.pgf_4c_1.Page5
1675: 
1676:         WITH loc_oPag5
1677:             .Caption   = "Disponivel/Tamanho"
1678:             .FontBold  = .T.
1679:             .ForeColor = RGB(0, 128, 192)
1680:             .Enabled   = .F.
1681:         ENDWITH
1682: 
1683:         SET NULL ON
1684:         IF !USED("cursor_4c_DispTamanho")
1685:             CREATE CURSOR cursor_4c_DispTamanho ;
1686:                 (Cpros C(14) NULL, CodCors C(10) NULL, CodTams C(10) NULL, ;
1687:                  Disps N(12,3) NULL, Utilizar N(12,3) NULL)
1688:         ENDIF
1689:         SET NULL OFF
1690: 
1691:         loc_oPag5.AddObject("lbl_4c_Label1", "Label")
1692:         WITH loc_oPag5.lbl_4c_Label1
1693:             .AutoSize   = .F.
1694:             .Top        = 150
1695:             .Left       = 246
1696:             .Width      = 205
1697:             .Height     = 25
1698:             .FontName   = "Tahoma"
1699:             .FontSize   = 14
1700:             .FontBold   = .T.
1701:             .FontItalic = .T.
1702:             .BackStyle  = 0
1703:             .ForeColor  = RGB(90, 90, 90)
1704:             .Caption    = "Selecionar Tamanhos"
1705:         ENDWITH
1706: 
1707:         loc_oPag5.AddObject("shp_4c_Shape4", "Shape")
1708:         WITH loc_oPag5.shp_4c_Shape4
1709:             .Top         = 171
1710:             .Left        = 240
1711:             .Width       = 328

*-- Linhas 1724 a 1746:
1724:             .ReadOnly      = .T.
1725:             .ForeColor     = RGB(0, 0, 255)
1726:             .ControlSource = "TmpFinalg.Cpros"
1727:         ENDWITH
1728: 
1729:         loc_oPag5.AddObject("grd_4c_DispTamanho", "Grid")
1730: 
1731:         WITH loc_oPag5.grd_4c_DispTamanho
1732:             .Top          = 181
1733:             .Left         = 239
1734:             .Width        = 327
1735:             .Height       = 228
1736:             .FontName     = "Tahoma"
1737:             .FontSize     = 8
1738:             .AllowHeaderSizing = .F.
1739:             .AllowRowSizing    = .F.
1740:             .RowHeight    = 16
1741:             .ScrollBars   = 2
1742:             .GridLineColor = RGB(238, 238, 238)
1743:             .DeleteMark   = .F.
1744:             .RecordMark   = .T.
1745:             .Panel        = 1
1746:             .RecordSource = ""

*-- Linhas 1784 a 1856:
1784:             .Column5.Movable   = .F.
1785:             .Column5.Resizable = .F.
1786:             .Column5.ReadOnly  = .F.
1787:             .Column5.Text1.FontBold = .T.
1788:         ENDWITH
1789:         BINDEVENT(loc_oPag5.grd_4c_DispTamanho.Column5.Text1, "Valid", THIS, "GradeDispTamanhoColumn5Valid")
1790:         BINDEVENT(loc_oPag5.grd_4c_DispTamanho.Column5.Text1, "KeyPress", THIS, "GradeDispColumn5LostFocus")
1791: 
1792:         FOR loc_nCol = 1 TO 5
1793:             WITH EVALUATE("loc_oPag5.grd_4c_DispTamanho.Column" + TRANSFORM(loc_nCol) + ".Header1")
1794:                 .FontName  = "Verdana"
1795:                 .FontSize  = 8
1796:                 .Alignment = 2
1797:                 .ForeColor = RGB(36, 84, 155)
1798:             ENDWITH
1799:         ENDFOR
1800: 
1801:         loc_oPag5.AddObject("lbl_4c_Label2", "Label")
1802:         WITH loc_oPag5.lbl_4c_Label2
1803:             .AutoSize  = .F.
1804:             .Top       = 415
1805:             .Left      = 289
1806:             .Width     = 82
1807:             .Height    = 16
1808:             .FontName  = "Tahoma"
1809:             .FontSize  = 8
1810:             .BackStyle = 0
1811:             .ForeColor = RGB(90, 90, 90)
1812:             .Caption   = "Qtde Pedida : "
1813:         ENDWITH
1814: 
1815:         loc_oPag5.AddObject("lbl_4c_Label3", "Label")
1816:         WITH loc_oPag5.lbl_4c_Label3
1817:             .AutoSize  = .F.
1818:             .Top       = 434
1819:             .Left      = 261
1820:             .Width     = 110
1821:             .Height    = 16
1822:             .FontName  = "Tahoma"
1823:             .FontSize  = 8
1824:             .BackStyle = 0
1825:             .ForeColor = RGB(90, 90, 90)
1826:             .Caption   = "Qtde Selecionada : "
1827:         ENDWITH
1828: 
1829:         loc_oPag5.AddObject("txt_4c_Qt_pedida", "TextBox")
1830:         WITH loc_oPag5.txt_4c_Qt_pedida
1831:             .Top       = 410
1832:             .Left      = 379
1833:             .Width     = 67
1834:             .Height    = 23
1835:             .InputMask = "9,999.99"
1836:             .ReadOnly  = .T.
1837:             .Value     = 0
1838:         ENDWITH
1839: 
1840:         loc_oPag5.AddObject("txt_4c_Qt_Selec", "TextBox")
1841:         WITH loc_oPag5.txt_4c_Qt_Selec
1842:             .Top       = 433
1843:             .Left      = 379
1844:             .Width     = 67
1845:             .Height    = 23
1846:             .Alignment = 3
1847:             .InputMask = "9,999.99"
1848:             .ReadOnly  = .T.
1849:             .Value     = 0
1850:         ENDWITH
1851: 
1852:         loc_oPag5.AddObject("cmd_4c_CancelaDisp", "CommandButton")
1853:         WITH loc_oPag5.cmd_4c_CancelaDisp
1854:             .Top         = 12
1855:             .Left        = 704
1856:             .Width       = 75

*-- Linhas 1868 a 1939:
1868:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1869:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1870:         ENDWITH
1871:         BINDEVENT(loc_oPag5.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDispPage5Click")
1872:     ENDPROC
1873: 
1874:     *--------------------------------------------------------------------------
1875:     * ConfigurarPaginaRequisicao - Page6 (SIGPRGLX.PageDados.Page6,
1876:     * "Requisicao"): "Requisicao Manual de Material" (GradePedra -> SelPedra
1877:     * no legado, aberta pelo Click de cmd_4c_Pedras). Esta eh a UNICA pagina
1878:     * do form que tem campo de lookup - as duas colunas de produto
1879:     * (Column1 "Produto" = material requisitado e Column5 "Produto" =
1880:     * material substituto) tem Valid que abre o picker de SigCdPro:
1881:     *
1882:     *   SIGPRGLX.PageDados.Page6.GradePedra.Column1.Text1.Valid (linha 8093)
1883:     *   SIGPRGLX.PageDados.Page6.GradePedra.Column5.Text1.Valid (linha 8176)
1884:     *   CreateObject('fwBuscaExt', ..., 'SigCdPro', 'crListaRemota',
1885:     *                'CPros', This.Value, 'Selecao', 1000)
1886:     *     -> mAddColuna('CPros','','Codigo') / mAddColuna('DPros','','Descricao')
1887:     *
1888:     * Column2 (Descricao) e Column3 (Uni) sao preenchidas pelo proprio
1889:     * lookup da Column1 (o Replace SelPedra.Dpros/Cunis do legado) e tem
1890:     * When -> Return .f. (nao digitaveis). Column4 (Qtde) e Column5 so
1891:     * aceitam digitacao com a Column1 preenchida - o When do legado eh
1892:     * Return (Not EMPTY(Column1.Text1.Value)), reproduzido como guarda no
1893:     * inicio dos handlers.
1894:     *
1895:     * cursor_4c_Requisicao eh o cursor de apoio de SelPedra; o legado garante
1896:     * ao menos UMA linha em branco (Init: "If Reccount('SelPedra') = 0 /
1897:     * Append Blank"), que eh onde o usuario digita o primeiro material.
1898:     *--------------------------------------------------------------------------
1899:     PROTECTED PROCEDURE ConfigurarPaginaRequisicao()
1900:         LOCAL loc_oPag6, loc_nCol
1901: 
1902:         loc_oPag6 = THIS.pgf_4c_1.Page6
1903: 
1904:         WITH loc_oPag6
1905:             .Caption   = "Requisi" + CHR(231) + CHR(227) + "o"
1906:             .FontBold  = .T.
1907:             .ForeColor = RGB(0, 128, 192)
1908:             .Enabled   = .F.
1909:         ENDWITH
1910: 
1911:         SET NULL ON
1912:         IF !USED("cursor_4c_Requisicao")
1913:             CREATE CURSOR cursor_4c_Requisicao ;
1914:                 (Cpros C(14) NULL, Dpros C(65) NULL, Cunis C(3) NULL, ;
1915:                  Qtds N(12,3) NULL, Cpro2s C(14) NULL)
1916:         ENDIF
1917:         SET NULL OFF
1918: 
1919:         *-- Linha em branco inicial (Init legado: If Reccount('SelPedra') = 0
1920:         *-- / Append Blank) - sem ela a grade abre sem nenhuma celula onde
1921:         *-- digitar o primeiro material.
1922:         IF USED("cursor_4c_Requisicao")
1923:             IF RECCOUNT("cursor_4c_Requisicao") = 0
1924:                 SELECT cursor_4c_Requisicao
1925:                 APPEND BLANK
1926:                 REPLACE Cpros WITH "", Dpros WITH "", Cunis WITH "", ;
1927:                         Qtds  WITH 0,  Cpro2s WITH "" IN cursor_4c_Requisicao
1928:                 GO TOP IN cursor_4c_Requisicao
1929:             ENDIF
1930:         ENDIF
1931: 
1932:         *-- Titulo da sub-tela (Label1 + Shape4) ----------------------------
1933:         loc_oPag6.AddObject("lbl_4c_Label1", "Label")
1934:         WITH loc_oPag6.lbl_4c_Label1
1935:             .AutoSize   = .F.
1936:             .Top        = 168
1937:             .Left       = 132
1938:             .Width      = 294
1939:             .Height     = 25

*-- Linhas 1968 a 1990:
1968:             .ForeColor     = RGB(0, 0, 255)
1969:             .ControlSource = "TmpFinalg.Cpros"
1970:         ENDWITH
1971: 
1972:         *-- Grade de requisicao manual (GradePedra / SelPedra) --------------
1973:         loc_oPag6.AddObject("grd_4c_Pedra", "Grid")
1974: 
1975:         WITH loc_oPag6.grd_4c_Pedra
1976:             .Top          = 197
1977:             .Left         = 119
1978:             .Width        = 500
1979:             .Height       = 261
1980:             .FontSize     = 8
1981:             .RowHeight    = 16
1982:             .ScrollBars   = 2
1983:             .GridLineColor = RGB(238, 238, 238)
1984:             .DeleteMark   = .F.
1985:             .RecordMark   = .T.
1986:             .RecordSource = ""
1987:             .ColumnCount  = 5
1988:             .RecordSource = "cursor_4c_Requisicao"
1989:             *-- Grid.ReadOnly ANTES das colunas: propaga e sobrescreveria o
1990:             *-- ReadOnly = .F. das colunas digitaveis (1, 4 e 5).

*-- Linhas 2053 a 2842:
2053:             .Column5.Text1.BackColor   = RGB(255, 255, 255)
2054:             .Column5.Text1.ToolTipText = "F4 ou duplo clique: buscar produto substituto"
2055:         ENDWITH
2056: 
2057:         FOR loc_nCol = 1 TO 5
2058:             WITH EVALUATE("loc_oPag6.grd_4c_Pedra.Column" + TRANSFORM(loc_nCol) + ".Header1")
2059:                 .FontName  = "Verdana"
2060:                 .FontSize  = 8
2061:                 .Alignment = 2
2062:                 .ForeColor = RGB(36, 84, 155)
2063:             ENDWITH
2064:         ENDFOR
2065: 
2066:         *-- LOOKUPS -------------------------------------------------------
2067:         *-- Column1.Text1 e Column5.Text1 do legado tem Valid com
2068:         *-- fwBuscaExt sobre SigCdPro. BINDEVENT "Valid" NAO dispara de
2069:         *-- forma confiavel em TextBox (regra #3), entao o gatilho vai no
2070:         *-- KeyPress (ENTER/TAB/F4 - o equivalente a "sair do campo") e no
2071:         *-- DblClick, que eh o atalho canonico de lookup do sistema novo.
2072:         BINDEVENT(loc_oPag6.grd_4c_Pedra.Column1.Text1, "KeyPress", THIS, "GrdPedraProdutoKeyPress")
2073:         BINDEVENT(loc_oPag6.grd_4c_Pedra.Column1.Text1, "DblClick", THIS, "GrdPedraProdutoDblClick")
2074: 
2075:         BINDEVENT(loc_oPag6.grd_4c_Pedra.Column5.Text1, "KeyPress", THIS, "GrdPedraSubstitutoKeyPress")
2076:         BINDEVENT(loc_oPag6.grd_4c_Pedra.Column5.Text1, "DblClick", THIS, "GrdPedraSubstitutoDblClick")
2077: 
2078:         *-- Voltar (CancelaDisp) --------------------------------------------
2079:         loc_oPag6.AddObject("cmd_4c_CancelaDisp", "CommandButton")
2080:         WITH loc_oPag6.cmd_4c_CancelaDisp
2081:             .Top         = 12
2082:             .Left        = 704
2083:             .Width       = 75
2084:             .Height      = 75
2085:             .FontName    = "Comic Sans MS"
2086:             .FontSize    = 8
2087:             .FontBold    = .T.
2088:             .FontItalic  = .T.
2089:             .WordWrap    = .T.
2090:             .Cancel      = .T.
2091:             .Caption     = "Voltar"
2092:             .ForeColor   = RGB(90, 90, 90)
2093:             .BackColor   = RGB(255, 255, 255)
2094:             .Themes      = .T.
2095:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
2096:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
2097:         ENDWITH
2098:         BINDEVENT(loc_oPag6.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDispPage6Click")
2099:     ENDPROC
2100: 
2101:     *--------------------------------------------------------------------------
2102:     * GrdPedraProdutoKeyPress / GrdPedraProdutoDblClick - gatilhos do lookup
2103:     * do MATERIAL REQUISITADO (GradePedra.Column1.Text1.Valid no legado).
2104:     * PUBLIC (sem PROTECTED): BINDEVENT so enxerga metodo publico.
2105:     * LPARAMETERS obrigatorio - sem ele o primeiro keystroke estoura
2106:     * "No PARAMETER statement is found".
2107:     *--------------------------------------------------------------------------
2108:     PROCEDURE GrdPedraProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2109: 
2110:         *-- Guarda obrigatoria: sem ela o picker abriria a CADA tecla
2111:         *-- digitada e o usuario nao conseguiria terminar o codigo.
2112:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2113:             RETURN
2114:         ENDIF
2115: 
2116:         THIS.AbrirLookupProdutoRequisicao()
2117:     ENDPROC
2118: 
2119:     PROCEDURE GrdPedraProdutoDblClick()
2120:         THIS.AbrirLookupProdutoRequisicao()
2121:     ENDPROC
2122: 
2123:     *--------------------------------------------------------------------------
2124:     * AbrirLookupProdutoRequisicao - lookup do material requisitado
2125:     * (Column1 "Produto"), transcrito de
2126:     * SIGPRGLX.PageDados.Page6.GradePedra.Column1.Text1.Valid:
2127:     *
2128:     *   If Not Empty(This.Value)
2129:     *       loLista = CreateObject('fwBuscaExt', ..., 'SigCdPro',
2130:     *                              'crListaRemota', 'CPros', This.Value, 'Selecao', 1000)
2131:     *       If Not loLista.plAchouRegistro
2132:     *           loLista.mAddColuna('CPros','','Codigo')
2133:     *           loLista.mAddColuna('DPros','','Descricao')
2134:     *           loLista.Show()
2135:     *       EndIf
2136:     *       This.Value = CrListaRemota.Cpros
2137:     *       Replace SelPedra.Dpros WITH CrListaRemota.Dpros,
2138:     *               SelPedra.Cunis WITH CrListaRemota.Cunis IN SelPedra
2139:     *       Use In crListaRemota
2140:     *       ThisForm.PageDados.Page6.GradePedra.Refresh
2141:     *   EndIf
2142:     *
2143:     * O Replace de Dpros/Cunis eh o que preenche as colunas Descricao e Uni,
2144:     * que sao ReadOnly e nao tem outra origem - sem ele a linha fica so com
2145:     * o codigo. Cunis vem junto do mesmo SELECT (por isso o lookup consulta
2146:     * CPros/DPros/Cunis, mesmo exibindo so as duas primeiras no picker,
2147:     * exatamente como o legado, cujo fwBuscaExt traz a linha inteira).
2148:     *--------------------------------------------------------------------------
2149:     PROCEDURE AbrirLookupProdutoRequisicao()
2150:         LOCAL loc_oBusca, loc_cValor, loc_oErro
2151:         LOCAL loc_oGrade, loc_oCampo
2152: 
2153:         IF THIS.this_lLookupEmCurso
2154:             RETURN
2155:         ENDIF
2156:         THIS.this_lLookupEmCurso = .T.
2157: 
2158:         TRY
2159:             loc_oGrade = THIS.pgf_4c_1.Page6.grd_4c_Pedra
2160:             loc_oCampo = loc_oGrade.Column1.Text1
2161: 
2162:             *-- Legado: "If Not Empty(This.Value)" - campo vazio nao consulta.
2163:             IF !EMPTY(loc_oCampo.Value) AND !loc_oCampo.ReadOnly
2164:                 loc_cValor = ALLTRIM(loc_oCampo.Value)
2165: 
2166:                 IF USED("cursor_4c_BuscaProduto")
2167:                     USE IN cursor_4c_BuscaProduto
2168:                 ENDIF
2169: 
2170:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2171:                     "SigCdPro", ;
2172:                     "cursor_4c_BuscaProduto", ;
2173:                     "CPros", ;
2174:                     loc_cValor, ;
2175:                     "Sele" + CHR(231) + CHR(227) + "o")
2176: 
2177:                 IF VARTYPE(loc_oBusca) = "O"
2178:                     *-- this_lAchouRegistro: o Init ja resolveu o match exato
2179:                     *-- (1 registro) - nesse caso o picker NAO deve aparecer.
2180:                     IF !loc_oBusca.this_lAchouRegistro
2181:                         loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2182:                         loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2183:                         loc_oBusca.Show()
2184:                     ENDIF
2185: 
2186:                     *-- Atribuicao SO sob a guarda de selecao: fora dela, o
2187:                     *-- usuario que desiste do picker teria o campo ZERADO.
2188:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
2189:                         IF !EOF("cursor_4c_BuscaProduto")
2190:                             loc_oCampo.Value = ALLTRIM(cursor_4c_BuscaProduto.CPros)
2191: 
2192:                             IF USED("cursor_4c_Requisicao") AND !EOF("cursor_4c_Requisicao")
2193:                                 REPLACE Cpros WITH ALLTRIM(cursor_4c_BuscaProduto.CPros), ;
2194:                                         Dpros WITH TratarNulo(cursor_4c_BuscaProduto.DPros, ""), ;
2195:                                         Cunis WITH TratarNulo(cursor_4c_BuscaProduto.Cunis, "") ;
2196:                                    IN cursor_4c_Requisicao
2197:                             ENDIF
2198:                         ENDIF
2199:                     ENDIF
2200: 
2201:                     IF USED("cursor_4c_BuscaProduto")
2202:                         USE IN cursor_4c_BuscaProduto
2203:                     ENDIF
2204: 
2205:                     loc_oBusca.Release()
2206:                     loc_oBusca = .NULL.
2207:                 ENDIF
2208: 
2209:                 loc_oGrade.Refresh()
2210:             ENDIF
2211:         CATCH TO loc_oErro
2212:             MsgErro(loc_oErro.Message + CHR(13) + ;
2213:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2214:                     "Procedure: " + loc_oErro.Procedure, ;
2215:                     "Erro ao buscar Produto")
2216:         ENDTRY
2217: 
2218:         *-- Liberado DEPOIS do ENDTRY para valer tambem quando o CATCH dispara.
2219:         THIS.this_lLookupEmCurso = .F.
2220:     ENDPROC
2221: 
2222:     *--------------------------------------------------------------------------
2223:     * GrdPedraSubstitutoKeyPress / GrdPedraSubstitutoDblClick - gatilhos do
2224:     * lookup do MATERIAL SUBSTITUTO (GradePedra.Column5.Text1.Valid).
2225:     *--------------------------------------------------------------------------
2226:     PROCEDURE GrdPedraSubstitutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2227: 
2228:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2229:             RETURN
2230:         ENDIF
2231: 
2232:         THIS.AbrirLookupProdutoSubstituto()
2233:     ENDPROC
2234: 
2235:     PROCEDURE GrdPedraSubstitutoDblClick()
2236:         THIS.AbrirLookupProdutoSubstituto()
2237:     ENDPROC
2238: 
2239:     *--------------------------------------------------------------------------
2240:     * AbrirLookupProdutoSubstituto - lookup do material substituto
2241:     * (Column5 "Produto"), transcrito de
2242:     * SIGPRGLX.PageDados.Page6.GradePedra.Column5.Text1.Valid. Igual ao da
2243:     * Column1, SEM o Replace de Dpros/Cunis - o legado so devolve o codigo
2244:     * aqui, porque Descricao/Uni da linha pertencem ao material PRINCIPAL.
2245:     *
2246:     * A guarda inicial reproduz o When do legado
2247:     * (Return (Not EMPTY(...Column1.Text1.Value))): sem material principal
2248:     * digitado, a coluna do substituto nao aceita entrada e, portanto, nao
2249:     * abre o picker.
2250:     *--------------------------------------------------------------------------
2251:     PROCEDURE AbrirLookupProdutoSubstituto()
2252:         LOCAL loc_oBusca, loc_cValor, loc_oErro
2253:         LOCAL loc_oGrade, loc_oCampo
2254: 
2255:         IF THIS.this_lLookupEmCurso
2256:             RETURN
2257:         ENDIF
2258:         THIS.this_lLookupEmCurso = .T.
2259: 
2260:         TRY
2261:             loc_oGrade = THIS.pgf_4c_1.Page6.grd_4c_Pedra
2262:             loc_oCampo = loc_oGrade.Column5.Text1
2263: 
2264:             *-- When do legado: so ha substituto se ha material principal.
2265:             IF EMPTY(loc_oGrade.Column1.Text1.Value)
2266:                 MsgAviso("Informe primeiro o Produto da requisi" + CHR(231) + ;
2267:                          CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
2268:             ELSE
2269:                 IF !EMPTY(loc_oCampo.Value) AND !loc_oCampo.ReadOnly
2270:                     loc_cValor = ALLTRIM(loc_oCampo.Value)
2271: 
2272:                     IF USED("cursor_4c_BuscaProduto")
2273:                         USE IN cursor_4c_BuscaProduto
2274:                     ENDIF
2275: 
2276:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2277:                         "SigCdPro", ;
2278:                         "cursor_4c_BuscaProduto", ;
2279:                         "CPros", ;
2280:                         loc_cValor, ;
2281:                         "Sele" + CHR(231) + CHR(227) + "o")
2282: 
2283:                     IF VARTYPE(loc_oBusca) = "O"
2284:                         IF !loc_oBusca.this_lAchouRegistro
2285:                             loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2286:                             loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2287:                             loc_oBusca.Show()
2288:                         ENDIF
2289: 
2290:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
2291:                             IF !EOF("cursor_4c_BuscaProduto")
2292:                                 loc_oCampo.Value = ALLTRIM(cursor_4c_BuscaProduto.CPros)
2293: 
2294:                                 IF USED("cursor_4c_Requisicao") AND !EOF("cursor_4c_Requisicao")
2295:                                     REPLACE Cpro2s WITH ALLTRIM(cursor_4c_BuscaProduto.CPros) ;
2296:                                        IN cursor_4c_Requisicao
2297:                                 ENDIF
2298:                             ENDIF
2299:                         ENDIF
2300: 
2301:                         IF USED("cursor_4c_BuscaProduto")
2302:                             USE IN cursor_4c_BuscaProduto
2303:                         ENDIF
2304: 
2305:                         loc_oBusca.Release()
2306:                         loc_oBusca = .NULL.
2307:                     ENDIF
2308: 
2309:                     *-- LostFocus do legado: garante sempre UMA linha em branco
2310:                     *-- no fim, para o usuario digitar o proximo material.
2311:                     THIS.GarantirLinhaLivreRequisicao()
2312: 
2313:                     loc_oGrade.Refresh()
2314:                 ENDIF
2315:             ENDIF
2316:         CATCH TO loc_oErro
2317:             MsgErro(loc_oErro.Message + CHR(13) + ;
2318:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2319:                     "Procedure: " + loc_oErro.Procedure, ;
2320:                     "Erro ao buscar Produto")
2321:         ENDTRY
2322: 
2323:         THIS.this_lLookupEmCurso = .F.
2324:     ENDPROC
2325: 
2326:     *--------------------------------------------------------------------------
2327:     * GarantirLinhaLivreRequisicao - transcricao do LostFocus de
2328:     * SIGPRGLX.PageDados.Page6.GradePedra.Column5.Text1:
2329:     *
2330:     *   SELECT SelPedra
2331:     *   xPosicao = RECNO()
2332:     *   Locate For Empty(Cpros)
2333:     *   If Eof()
2334:     *       Append Blank
2335:     *   EndIf
2336:     *   Locate for Recno() = xPosicao
2337:     *
2338:     * Mantem sempre ao menos uma linha em branco disponivel na grade e
2339:     * devolve o ponteiro para onde o usuario estava. O KEYBOARD '{DNARROW}'
2340:     * do legado (que empurra o cursor para a linha de baixo) nao eh
2341:     * reproduzido aqui: la ele vinha do LostFocus real da celula; neste
2342:     * ponto o foco ja voltou do picker e o salto adicional tiraria o
2343:     * usuario da linha que ele acabou de preencher.
2344:     *--------------------------------------------------------------------------
2345:     PROTECTED PROCEDURE GarantirLinhaLivreRequisicao()
2346:         LOCAL loc_nPosicao
2347: 
2348:         IF !USED("cursor_4c_Requisicao")
2349:             RETURN
2350:         ENDIF
2351: 
2352:         SELECT cursor_4c_Requisicao
2353:         loc_nPosicao = RECNO()
2354: 
2355:         LOCATE FOR EMPTY(cursor_4c_Requisicao.Cpros)
2356:         IF EOF("cursor_4c_Requisicao")
2357:             APPEND BLANK
2358:             REPLACE Cpros WITH "", Dpros WITH "", Cunis WITH "", ;
2359:                     Qtds  WITH 0,  Cpro2s WITH "" IN cursor_4c_Requisicao
2360:         ENDIF
2361: 
2362:         IF loc_nPosicao > 0 AND loc_nPosicao <= RECCOUNT("cursor_4c_Requisicao")
2363:             GOTO loc_nPosicao IN cursor_4c_Requisicao
2364:         ENDIF
2365:     ENDPROC
2366: 
2367:     *--------------------------------------------------------------------------
2368:     * GradeItensPage1GotFocus - "GotFocus -> Column7.Text1.SetFocus" das
2369:     * colunas 1/2/4/5/6/9/10 do legado (dump 6730-6793): a grade so tem UMA
2370:     * coluna de entrada de verdade (Fabrs); clicar em qualquer outra
2371:     * redireciona o foco para ela.
2372:     *--------------------------------------------------------------------------
2373:     PROCEDURE GradeItensPage1GotFocus()
2374:         THIS.pgf_4c_1.Page1.grd_4c_Dados.Column7.Text1.SetFocus()
2375:     ENDPROC
2376: 
2377:     *--------------------------------------------------------------------------
2378:     * CapturarOldValuePage1 / CapturarOldValuePage2 - "ThisForm.OldValue =
2379:     * This.Value" do When das colunas digitaveis (Page1 e Page2,
2380:     * Column7/Column10). Guardam o valor ANTES da edicao para que o Valid
2381:     * possa restaura-lo quando recusar a entrada.
2382:     *
2383:     * Ligados ao GotFocus (nao ao When): BINDEVENT em "When" de TextBox de
2384:     * Grid nao dispara de forma confiavel (regra #3 do CLAUDE.md), e
2385:     * GotFocus cobre o mesmo instante - a celula acabou de receber o foco e
2386:     * o usuario ainda nao digitou.
2387:     *
2388:     * par_nColuna: 7 ou 10 (a coluna que ganhou o foco).
2389:     *--------------------------------------------------------------------------
2390:     PROCEDURE CapturarOldValuePage1()
2391:         LPARAMETERS par_nColuna
2392: 
2393:         DO CASE
2394:             CASE par_nColuna = 10
2395:                 THIS.this_nOldValue = THIS.pgf_4c_1.Page1.grd_4c_Dados.Column10.Text1.Value
2396:             OTHERWISE
2397:                 THIS.this_nOldValue = THIS.pgf_4c_1.Page1.grd_4c_Dados.Column7.Text1.Value
2398:         ENDCASE
2399:     ENDPROC
2400: 
2401:     PROCEDURE CapturarOldValuePage1Col7()
2402:         THIS.CapturarOldValuePage1(7)
2403:     ENDPROC
2404: 
2405:     PROCEDURE CapturarOldValuePage1Col10()
2406:         THIS.CapturarOldValuePage1(10)
2407:     ENDPROC
2408: 
2409:     PROCEDURE CapturarOldValuePage2Col7()
2410:         THIS.this_nOldValue = THIS.pgf_4c_1.Page2.grd_4c_Dados.Column7.Text1.Value
2411:     ENDPROC
2412: 
2413:     PROCEDURE CapturarOldValuePage2Col10()
2414:         THIS.this_nOldValue = THIS.pgf_4c_1.Page2.grd_4c_Dados.Column10.Text1.Value
2415:     ENDPROC
2416: 
2417:     *--------------------------------------------------------------------------
2418:     * GradeItensPage1Column3DblClick - Column3 (Flag) DblClick/Click do
2419:     * legado (dump 6946-6961): atalho para a pagina de selecao de linha.
2420:     *--------------------------------------------------------------------------
2421:     PROCEDURE GradeItensPage1Column3DblClick()
2422:         THIS.AlternarPagina(2)
2423:         THIS.pgf_4c_1.Page2.grd_4c_Dados.SetFocus()
2424:     ENDPROC
2425: 
2426:     *--------------------------------------------------------------------------
2427:     * GradeItensPage1Column7Valid - transcricao de GradeItens.Column7.Text1.
2428:     * Valid (dump 6833-6913): valida a quantidade de Fabrs (producao em
2429:     * fase) reservada manualmente para o item corrente e redistribui o
2430:     * saldo em cursor_4c_TmpSaldo/cursor_4c_TmpFabr/TmpFinal.
2431:     *--------------------------------------------------------------------------
2432:     PROCEDURE GradeItensPage1Column7Valid()
2433:         LOCAL loc_oCampo, loc_nValorNovo, loc_nXBaixa, loc_lOk
2434: 
2435:         loc_oCampo    = THIS.pgf_4c_1.Page1.grd_4c_Dados.Column7.Text1
2436:         loc_nValorNovo = loc_oCampo.Value
2437: 
2438:         IF !USED("TmpFinalg") OR EOF("TmpFinalg")
2439:             RETURN
2440:         ENDIF
2441: 
2442:         IF !SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
2443:             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2444:         ENDIF
2445:         IF loc_nValorNovo != THIS.this_nOldValue AND TmpSaldU.KeySelmp
2446:             IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de OP." + CHR(13) + ;
2447:                     "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", ;
2448:                     "Confirmar")
2449:                 loc_oCampo.Value = THIS.this_nOldValue
2450:                 RETURN
2451:             ENDIF
2452:         ENDIF
2453: 
2454:         loc_lOk = .T.
2455:         DO CASE
2456:             CASE loc_nValorNovo = THIS.this_nOldValue
2457:                 * nada a fazer
2458:             CASE loc_nValorNovo < 0
2459:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo...", "Aten" + CHR(231) + CHR(227) + "o")
2460:                 loc_lOk = .F.
2461:             CASE loc_nValorNovo > TmpFinalg.Saldo
2462:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
2463:                 loc_lOk = .F.
2464:             CASE loc_nValorNovo > (TmpFinalg.Saldo - TmpFinalg.Estoque)
2465:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
2466:                 loc_lOk = .F.
2467:             CASE !SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, ;
2468:                     "cursor_4c_TmpSaldo", "CPros") AND TmpFinalg.Produzir != TmpFinalg.Saldo
2469:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto Em " + ;
2470:                     "Produ" + CHR(231) + CHR(227) + "o para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
2471:                 loc_lOk = .F.
2472:             OTHERWISE
2473:                 IF cursor_4c_TmpSaldo.Fabrs >= loc_nValorNovo
2474:                     REPLACE DispFs WITH Fabrs - loc_nValorNovo IN cursor_4c_TmpSaldo
2475:                     REPLACE Produzir WITH Saldo - Estoque - loc_nValorNovo IN TmpFinalg
2476: 
2477:                     SELECT TmpFinalg
2478:                     REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
2479:                             QtdMins - Produzir, 0), ;
2480:                             UsuLibs WITH " " IN TmpFinalg
2481: 
2482:                     REPLACE KeySelmp WITH .F. IN TmpSaldU
2483: 
2484:                     SELECT cursor_4c_TmpSaldo
2485:                     loc_nXBaixa = Fabrs - DispFs
2486:                     SELECT cursor_4c_TmpFabr
2487:                     SET ORDER TO Cpros
2488:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2489:                     REPLACE Disps WITH 0 WHILE cursor_4c_TmpFabr.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2490:                             cursor_4c_TmpFabr.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2491:                             cursor_4c_TmpFabr.CodTams = cursor_4c_TmpSaldo.CodTams
2492:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2493:                     SCAN WHILE cursor_4c_TmpFabr.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2494:                             cursor_4c_TmpFabr.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2495:                             cursor_4c_TmpFabr.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
2496:                         IF (cursor_4c_TmpFabr.Qtds - cursor_4c_TmpFabr.Disps) >= loc_nXBaixa
2497:                             REPLACE cursor_4c_TmpFabr.Disps WITH cursor_4c_TmpFabr.Disps + loc_nXBaixa
2498:                             loc_nXBaixa = 0
2499:                         ELSE
2500:                             loc_nXBaixa = loc_nXBaixa - (cursor_4c_TmpFabr.Qtds - cursor_4c_TmpFabr.Disps)
2501:                             REPLACE cursor_4c_TmpFabr.Disps WITH cursor_4c_TmpFabr.Qtds
2502:                         ENDIF
2503:                         SELECT cursor_4c_TmpFabr
2504:                     ENDSCAN
2505: 
2506:                     loc_nXBaixa = loc_nValorNovo
2507:                     SELECT TmpFinal
2508:                     SET ORDER TO
2509:                     SET ORDER TO Cpros
2510:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2511:                     REPLACE Fabrs WITH 0 WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2512:                             TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams
2513:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2514:                     SCAN WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors ;
2515:                             AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa >= 0
2516:                         IF (TmpFinal.Saldo - TmpFinal.Estoque) >= loc_nXBaixa
2517:                             REPLACE TmpFinal.Fabrs WITH TmpFinal.Fabrs + loc_nXBaixa
2518:                             loc_nXBaixa = 0
2519:                         ELSE
2520:                             loc_nXBaixa = loc_nXBaixa - (TmpFinal.Saldo - TmpFinal.Estoque)
2521:                             REPLACE TmpFinal.Fabrs WITH (TmpFinal.Saldo - TmpFinal.Estoque)
2522:                         ENDIF
2523:                         REPLACE Produzir WITH Saldo - Estoque - Fabrs IN TmpFinal
2524:                         SELECT TmpFinal
2525:                     ENDSCAN
2526:                 ELSE
2527:                     MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto Em " + ;
2528:                         "Produ" + CHR(231) + CHR(227) + "o para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
2529:                     loc_lOk = .F.
2530:                 ENDIF
2531:         ENDCASE
2532: 
2533:         IF !loc_lOk
2534:             loc_oCampo.Value = THIS.this_nOldValue
2535:         ENDIF
2536:     ENDPROC
2537: 
2538:     *--------------------------------------------------------------------------
2539:     * GradeItensPage1Column10Valid - transcricao de GradeItens.Column10.Text1.
2540:     * Valid (dump 7046-7128): irma exata da Column7 acima, mas para a
2541:     * quantidade de ESTOQUE (TmpFinalg.Estoque). Redistribui o saldo em
2542:     * cursor_4c_TmpSaldo (Disps) -> cursor_4c_TmpSaldg (Disps por
2543:     * grupo/conta) -> TmpFinal (Estoque linha a linha).
2544:     *
2545:     * Duas diferencas de verbo em relacao a Column7, que vem do legado e NAO
2546:     * sao simetria quebrada por descuido:
2547:     *   - o teto eh (Saldo - Fabrs), nao (Saldo - Estoque);
2548:     *   - no cursor_4c_TmpSaldg o legado SATURA primeiro (Replace Disps With
2549:     *     Saldo While ...) e so depois DESCONTA xBaixa no Scan, enquanto na
2550:     *     Column7 ele ZERA (Replace Disps With 0) e depois SOMA. Transcrito
2551:     *     literalmente (regra #17 do CLAUDE.md).
2552:     *
2553:     * UNICA divergencia consciente: no 5o Case o legado escreve
2554:     * "This.Value = This.Value = Thisform.OldValue" - um typo que avalia a
2555:     * comparacao e grava um LOGICO num campo numerico. Aqui restaura o valor
2556:     * anterior (que eh o que os outros quatro Case fazem e o que o typo
2557:     * claramente pretendia); transcrever o typo gravaria .T./.F. em
2558:     * TmpFinalg.Estoque e estouraria "Data type mismatch".
2559:     *--------------------------------------------------------------------------
2560:     PROCEDURE GradeItensPage1Column10Valid()
2561:         LOCAL loc_oCampo, loc_nValorNovo, loc_nXBaixa, loc_lOk
2562: 
2563:         loc_oCampo     = THIS.pgf_4c_1.Page1.grd_4c_Dados.Column10.Text1
2564:         loc_nValorNovo = loc_oCampo.Value
2565: 
2566:         IF !USED("TmpFinalg") OR EOF("TmpFinalg")
2567:             RETURN
2568:         ENDIF
2569: 
2570:         IF !SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
2571:             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2572:         ENDIF
2573:         IF loc_nValorNovo != THIS.this_nOldValue AND TmpSaldU.KeySelm
2574:             IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque." + CHR(13) + ;
2575:                     "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", ;
2576:                     "Confirmar")
2577:                 loc_oCampo.Value = THIS.this_nOldValue
2578:                 RETURN
2579:             ENDIF
2580:         ENDIF
2581: 
2582:         loc_lOk = .T.
2583:         DO CASE
2584:             CASE loc_nValorNovo = THIS.this_nOldValue
2585:                 * nada a fazer
2586:             CASE loc_nValorNovo < 0
2587:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo...", "Aten" + CHR(231) + CHR(227) + "o")
2588:                 loc_lOk = .F.
2589:             CASE loc_nValorNovo > TmpFinalg.Saldo
2590:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
2591:                 loc_lOk = .F.
2592:             CASE loc_nValorNovo > (TmpFinalg.Saldo - TmpFinalg.Fabrs)
2593:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
2594:                 loc_lOk = .F.
2595:             CASE !SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, ;
2596:                     "cursor_4c_TmpSaldo", "CPros") AND TmpFinalg.Produzir != TmpFinalg.Saldo
2597:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto no " + ;
2598:                     "estoque para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
2599:                 loc_lOk = .F.
2600:             OTHERWISE
2601:                 IF cursor_4c_TmpSaldo.Saldo >= loc_nValorNovo
2602:                     REPLACE Disps WITH Saldo - loc_nValorNovo IN cursor_4c_TmpSaldo
2603:                     REPLACE Produzir WITH Saldo - Fabrs - loc_nValorNovo IN TmpFinalg
2604: 
2605:                     SELECT TmpFinalg
2606:                     REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
2607:                             QtdMins - Produzir, 0), ;
2608:                             UsuLibs WITH " " IN TmpFinalg
2609: 
2610:                     REPLACE KeySelm WITH .F. IN TmpSaldU
2611: 
2612:                     SELECT cursor_4c_TmpSaldo
2613:                     loc_nXBaixa = Saldo - Disps
2614: 
2615:                     SELECT cursor_4c_TmpSaldg
2616:                     SET ORDER TO CPros
2617:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2618:                     REPLACE Disps WITH Saldo WHILE cursor_4c_TmpSaldg.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2619:                             cursor_4c_TmpSaldg.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2620:                             cursor_4c_TmpSaldg.CodTams = cursor_4c_TmpSaldo.CodTams
2621:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2622:                     SCAN WHILE cursor_4c_TmpSaldg.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2623:                             cursor_4c_TmpSaldg.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2624:                             cursor_4c_TmpSaldg.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
2625:                         IF cursor_4c_TmpSaldg.Disps >= loc_nXBaixa
2626:                             REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldg.Disps - loc_nXBaixa
2627:                             loc_nXBaixa = 0
2628:                         ELSE
2629:                             loc_nXBaixa = loc_nXBaixa - cursor_4c_TmpSaldg.Disps
2630:                             REPLACE cursor_4c_TmpSaldg.Disps WITH 0
2631:                         ENDIF
2632:                         SELECT cursor_4c_TmpSaldg
2633:                     ENDSCAN
2634: 
2635:                     loc_nXBaixa = loc_nValorNovo
2636:                     SELECT TmpFinal
2637:                     SET ORDER TO
2638:                     SET ORDER TO Cpros
2639:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2640:                     REPLACE Estoque WITH 0 WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2641:                             TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2642:                             TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams
2643:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2644:                     SCAN WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2645:                             TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2646:                             TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
2647:                         IF (TmpFinal.Saldo - TmpFinal.Fabrs) >= loc_nXBaixa
2648:                             REPLACE TmpFinal.Estoque WITH TmpFinal.Estoque + loc_nXBaixa IN TmpFinal
2649:                             loc_nXBaixa = 0
2650:                         ELSE
2651:                             loc_nXBaixa = loc_nXBaixa - (TmpFinal.Saldo - TmpFinal.Fabrs)
2652:                             REPLACE TmpFinal.Estoque WITH (TmpFinal.Saldo - TmpFinal.Fabrs) IN TmpFinal
2653:                         ENDIF
2654:                         REPLACE Produzir WITH Saldo - Estoque - Fabrs IN TmpFinal
2655:                         SELECT TmpFinal
2656:                     ENDSCAN
2657:                 ELSE
2658:                     MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto no " + ;
2659:                         "estoque para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
2660:                     loc_lOk = .F.
2661:                 ENDIF
2662:         ENDCASE
2663: 
2664:         IF !loc_lOk
2665:             loc_oCampo.Value = THIS.this_nOldValue
2666:         ENDIF
2667: 
2668:         SELECT TmpFinalg
2669:     ENDPROC
2670: 
2671:     *--------------------------------------------------------------------------
2672:     * AtualizarVisibilidadeDisponivel - "When" de GradeItens.Column10.Text1
2673:     * (Page1, dump 7029-7043): o botao "Disponiveis" so aparece quando o
2674:     * form esta em modo RESERVA, o item corrente ainda nao tem estoque
2675:     * reservado e o GRUPO do produto eh de tipo de estoque 3 ou 4.
2676:     *
2677:     *   ThisForm.PageDados.Page1.Disponivel.Visible = .f.
2678:     *   If ThisForm.Reserva And TmpFinalg.Estoque = 0
2679:     *       ... CursorQuery SigCdPro -> Cgrus -> SigCdGrp -> TipoEstos
2680:     *       If InList(CrSigCdGrp.TipoEstos,3,4) -> Visible = .t.
2681:     *
2682:     * Vive num metodo proprio, chamado de AfterRowColChange (troca de item)
2683:     * e de CarregarLista (primeira linha), porque BINDEVENT em "When" de
2684:     * TextBox de Grid nao dispara de forma confiavel (regra #3 do
2685:     * CLAUDE.md) - AfterRowColChange cobre exatamente o mesmo gatilho util,
2686:     * que eh "o item corrente mudou".
2687:     *--------------------------------------------------------------------------
2688:     PROTECTED PROCEDURE AtualizarVisibilidadeDisponivel()
2689:         LOCAL loc_nTipoEsto
2690: 
2691:         THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .F.
2692: 
2693:         IF !THIS.this_lReservaAuto
2694:             RETURN
2695:         ENDIF
2696:         IF !USED("TmpFinalg") OR EOF("TmpFinalg")
2697:             RETURN
2698:         ENDIF
2699:         IF TmpFinalg.Estoque != 0
2700:             RETURN
2701:         ENDIF
2702:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2703:             RETURN
2704:         ENDIF
2705: 
2706:         loc_nTipoEsto = THIS.this_oBusinessObject.ObterTipoEstoqueProduto(ALLTRIM(TmpFinalg.Cpros))
2707: 
2708:         IF INLIST(loc_nTipoEsto, 3, 4)
2709:             THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .T.
2710:         ENDIF
2711:     ENDPROC
2712: 
2713:     *--------------------------------------------------------------------------
2714:     * GradeItensPage1Column8LostFocus - desarma o gate de liberacao manual
2715:     * (ThisForm.Liberado = .f. do legado) apos UMA edicao de Column8.
2716:     *--------------------------------------------------------------------------
2717:     PROCEDURE GradeItensPage1Column8LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2718:         THIS.this_lLiberadoAlteracao = .F.
2719:         THIS.pgf_4c_1.Page1.grd_4c_Dados.Column8.ReadOnly = .T.
2720:     ENDPROC
2721: 
2722:     *--------------------------------------------------------------------------
2723:     * GradeItensPage1LostFocus - recalcula os totais gerais da Page1
2724:     * (Tot_Qtd/Tot_Est/Tot_prdc/Tot_Prz/Tot_prze), igual ao LostFocus de
2725:     * Column7 no legado (dump 6918-6933) - RECNO salvo/restaurado porque
2726:     * SUM percorre o cursor e deixa o ponteiro em EOF.
2727:     *--------------------------------------------------------------------------
2728:     PROCEDURE GradeItensPage1LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2729:         THIS.AtualizarTotaisPage1()
2730:     ENDPROC
2731: 
2732:     PROTECTED PROCEDURE AtualizarTotaisPage1()
2733:         LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
2734: 
2735:         IF !USED("TmpFinalg")
2736:             RETURN
2737:         ENDIF
2738: 
2739:         SELECT TmpFinalg
2740:         loc_nRecno = RECNO()
2741:         SUM Saldo, Estoque, Produzir, Fabrs, Produzir2 TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
2742:         IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("TmpFinalg")
2743:             GOTO loc_nRecno
2744:         ENDIF
2745: 
2746:         WITH THIS.pgf_4c_1.Page1
2747:             .txt_4c_Tot_Qtd.Value  = loc_nSal
2748:             .txt_4c_Tot_Est.Value  = loc_nEst
2749:             .txt_4c_Tot_prdc.Value = loc_nPrc
2750:             .txt_4c_Tot_Prz.Value  = loc_nPrz
2751:             .txt_4c_Tot_prze.Value = loc_nPrze
2752:             .txt_4c_Tot_Qtd.Refresh()
2753:             .txt_4c_Tot_Est.Refresh()
2754:             .txt_4c_Tot_prdc.Refresh()
2755:             .txt_4c_Tot_Prz.Refresh()
2756:             .txt_4c_Tot_prze.Refresh()
2757:         ENDWITH
2758:     ENDPROC
2759: 
2760:     *--------------------------------------------------------------------------
2761:     * GradeItensPage1AfterRowColChange - transcricao de GradeItens.
2762:     * AfterRowColChange (dump 6666-6726): ao trocar de linha na grade
2763:     * principal, reposiciona cursor_4c_TmpSaldg/cursor_4c_TmpFabr no
2764:     * produto/cor/tamanho corrente, atualiza os totais dos paineis
2765:     * Container3/Container1 e carrega a imagem do produto.
2766:     *--------------------------------------------------------------------------
2767:     PROCEDURE GradeItensPage1AfterRowColChange(par_nColIndex)
2768:         LOCAL loc_cChave, loc_cFiltro, loc_cArquivo, loc_oPag1
2769: 
2770:         IF !USED("TmpFinalg") OR EOF("TmpFinalg")
2771:             RETURN
2772:         ENDIF
2773: 
2774:         loc_oPag1 = THIS.pgf_4c_1.Page1
2775:         *-- Chave POSICIONAL: o padding faz parte dela (CPros C(14) +
2776:         *-- CodCors C(4) + CodTams C(4) = 22). ALLTRIM nas partes encurta a
2777:         *-- chave e ela nunca casa (regra #42 do CLAUDE.md).
2778:         loc_cChave = TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams
2779: 
2780:         = SEEK(loc_cChave, "cursor_4c_TmpSaldo", "CPros")
2781: 
2782:         *-- As duas grades de resumo tem de mostrar SO as linhas do item
2783:         *-- corrente - o legado faz isso com "Set Key To TmpFinalg.Cpros +
2784:         *-- CodCors + CodTams", REEMITIDO aqui a cada troca de linha (medido
2785:         *-- no VFP9 em 2026-10-06: SET KEY TO <expr> eh ESTATICO, congela a
2786:         *-- faixa no valor do momento e nao reavalia). SEEK no lugar dele
2787:         *-- posicionaria o ponteiro mas deixaria a grade exibindo TODOS os
2788:         *-- produtos.
2789:         *--
2790:         *-- Aqui, porem, NAO se usa SET KEY e sim SET FILTER com "==" e o
2791:         *-- valor EMBUTIDO por macro: a faixa do SET KEY eh parcial (22 chars
2792:         *-- contra indices de 34/47) e faixa parcial fica VAZIA sob
2793:         *-- SET EXACT ON - e a faixa eh avaliada na NAVEGACAO, inclusive no
2794:         *-- desenho do Grid, entao nao ha bloco onde salvar/restaurar o SET.
2795:         *-- Hoje esta sessao nasce com EXACT OFF (DataSession = 2) e SET KEY
2796:         *-- funcionaria, mas seria uma mina: ligar EXACT ON por qualquer
2797:         *-- outro motivo apagaria as duas grades em silencio. "==" eh imune
2798:         *-- ao SET EXACT. Mesmo remedio ja adotado no irmao FormSigPrGlp.
2799:         loc_cFiltro = "Cpros + CodCors + CodTams == [" + loc_cChave + "]"
2800: 
2801:         SELECT cursor_4c_TmpSaldg
2802:         SET ORDER TO CPros
2803:         SET KEY TO
2804:         SET FILTER TO &loc_cFiltro
2805:         GO TOP
2806: 
2807:         WITH loc_oPag1.cnt_4c_Container3
2808:             .txt_4c_Tot_Qtd.Value = TratarNulo(cursor_4c_TmpSaldo.Saldo, 0)
2809:             .txt_4c_Tot_Est.Value = TratarNulo(cursor_4c_TmpSaldo.Saldo, 0) - TratarNulo(cursor_4c_TmpSaldo.Disps, 0)
2810:             .txt_4c_Tot_Prz.Value = TratarNulo(cursor_4c_TmpSaldo.Disps, 0)
2811:             .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel " + ALLTRIM(TmpFinalg.Cpros) + ;
2812:                 IIF(!EMPTY(TmpFinalg.CodCors), " Cor:" + ALLTRIM(TmpFinalg.CodCors), "") + ;
2813:                 IIF(!EMPTY(TmpFinalg.CodTams), " Tam:" + ALLTRIM(TmpFinalg.CodTams), "")
2814:             .grd_4c_DispGrupo.Refresh()
2815:             .Visible     = .T.
2816:         ENDWITH
2817: 
2818:         SELECT cursor_4c_TmpFabr
2819:         SET ORDER TO Cpros
2820:         SET KEY TO
2821:         SET FILTER TO &loc_cFiltro
2822:         GO TOP
2823: 
2824:         WITH loc_oPag1.cnt_4c_Container1
2825:             .txt_4c_Tot_Qtd.Value = TratarNulo(cursor_4c_TmpSaldo.Fabrs, 0)
2826:             .txt_4c_Tot_Est.Value = TratarNulo(cursor_4c_TmpSaldo.Fabrs, 0) - TratarNulo(cursor_4c_TmpSaldo.DispFs, 0)
2827:             .grd_4c_DispFase.Refresh()
2828:             .Visible     = .T.
2829:         ENDWITH
2830: 
2831:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2832:             loc_cArquivo = ADDBS(SYS(2023)) + "TempGlb_" + SYS(3) + ".jpg"
2833:             loc_oPag1.img_4c_FigJpg.Picture = ""
2834:             loc_oPag1.img_4c_FigJpg.Visible = .F.
2835:             IF THIS.this_oBusinessObject.CarregarFotoProduto(ALLTRIM(TmpFinalg.Cpros), loc_cArquivo)
2836:                 loc_oPag1.img_4c_FigJpg.Picture = loc_cArquivo
2837:                 loc_oPag1.img_4c_FigJpg.Visible = .T.
2838:             ENDIF
2839:         ENDIF
2840: 
2841:         *-- "Disponiveis" eh decidido POR ITEM (When de Column10 no legado)
2842:         THIS.AtualizarVisibilidadeDisponivel()

*-- Linhas 2848 a 3264:
2848:     * GradeDispGrupoColumn6LostFocus / GradeDispFaseColumn4LostFocus -
2849:     * "Skip / Skip -1 / Grid.Refresh" do legado (dump 4439-4444, 6625-6630,
2850:     * 6647-6654): forca a grade a repintar apos editar a coluna Prior.
2851:     *--------------------------------------------------------------------------
2852:     PROCEDURE GradeDispGrupoColumn6LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2853:         THIS.pgf_4c_1.Page1.cnt_4c_Container3.grd_4c_DispGrupo.Refresh()
2854:     ENDPROC
2855: 
2856:     PROCEDURE GradeDispFaseColumn4LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2857:         THIS.pgf_4c_1.Page1.cnt_4c_Container1.grd_4c_DispFase.Refresh()
2858:     ENDPROC
2859: 
2860:     *--------------------------------------------------------------------------
2861:     * ImgFigJpgPage1DblClick - "Do Form SigOpZom" do legado (zoom da
2862:     * imagem). SigOpZom nao foi migrado - ausencia reportada via MsgAviso
2863:     * (regra #27 do CLAUDE.md: ausencia visivel, nunca mascarada), em vez
2864:     * de silenciosamente nao fazer nada.
2865:     *--------------------------------------------------------------------------
2866:     PROCEDURE ImgFigJpgPage1DblClick()
2867:         MsgAviso("Visualiza" + CHR(231) + CHR(227) + "o ampliada da imagem (SigOpZom) " + ;
2868:             "ainda n" + CHR(227) + "o foi portada para o novo sistema.", "Aten" + CHR(231) + CHR(227) + "o")
2869:     ENDPROC
2870: 
2871:     *--------------------------------------------------------------------------
2872:     * AlternarPagina - troca a pagina ativa do pgf_4c_1 (equivalente a
2873:     * ThisForm.PageDados.ActivePage = N do legado, usado por todos os botoes
2874:     * de navegacao entre a grade principal e as sub-paginas de selecao:
2875:     * Disponivel/SelEstoque/Pedras abrem uma pagina de detalhe, Cancela*
2876:     * volta para a Page1). PUBLIC (nao PROTECTED) porque o harness de teste
2877:     * automatizado chama THIS.oForm.AlternarPagina(N) direto de fora da
2878:     * classe (mesma regra de BtnIncluirClick/CarregarLista).
2879:     *--------------------------------------------------------------------------
2880:     PROCEDURE AlternarPagina()
2881:         LPARAMETERS par_nPagina
2882: 
2883:         IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 ;
2884:                 AND par_nPagina <= THIS.pgf_4c_1.PageCount
2885:             THIS.pgf_4c_1.ActivePage = par_nPagina
2886:         ENDIF
2887:     ENDPROC
2888: 
2889:     *--------------------------------------------------------------------------
2890:     * GradeItensPage2GotFocus - idem GradeItensPage1GotFocus, mas para a
2891:     * grade de selecao de linha (Page2): toda coluna que nao seja a 7
2892:     * (Estoque) ou a 10 (Produ" + "cao") redireciona para a Column7.
2893:     *--------------------------------------------------------------------------
2894:     PROCEDURE GradeItensPage2GotFocus()
2895:         THIS.pgf_4c_1.Page2.grd_4c_Dados.Column7.Text1.SetFocus()
2896:     ENDPROC
2897: 
2898:     *--------------------------------------------------------------------------
2899:     * GradeItensPage2Column7Valid / Column10Valid - transcricao de
2900:     * GradeItens.Column7/Column10.Text1.Valid da Page2 (dump 7357-7379,
2901:     * 7477-7499): validacao PURA de faixa (sem redistribuicao - o
2902:     * ControlSource do Grid ja grava o valor em TmpFinal.Estoque/Fabrs).
2903:     *--------------------------------------------------------------------------
2904:     PROCEDURE GradeItensPage2Column7Valid()
2905:         LOCAL loc_oCampo, loc_nPSaldo
2906: 
2907:         loc_oCampo = THIS.pgf_4c_1.Page2.grd_4c_Dados.Column7.Text1
2908:         loc_nPSaldo = THIS.pgf_4c_1.Page2.txt_4c_Tot_sEst.Value
2909: 
2910:         IF !USED("TmpFinal") OR EOF("TmpFinal") OR loc_oCampo.Value = THIS.this_nOldValue
2911:             RETURN
2912:         ENDIF
2913: 
2914:         DO CASE
2915:             CASE loc_oCampo.Value < 0
2916:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo...", "Aten" + CHR(231) + CHR(227) + "o")
2917:                 loc_oCampo.Value = THIS.this_nOldValue
2918:             CASE loc_oCampo.Value > TmpFinal.Saldo
2919:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
2920:                 loc_oCampo.Value = THIS.this_nOldValue
2921:             CASE loc_oCampo.Value > loc_nPSaldo
2922:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade Selecionada...", "Aten" + CHR(231) + CHR(227) + "o")
2923:                 loc_oCampo.Value = THIS.this_nOldValue
2924:             CASE loc_oCampo.Value > (TmpFinal.Saldo - TmpFinal.Fabrs)
2925:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade Dispon" + CHR(237) + "vel...", "Aten" + CHR(231) + CHR(227) + "o")
2926:                 loc_oCampo.Value = THIS.this_nOldValue
2927:         ENDCASE
2928:     ENDPROC
2929: 
2930:     PROCEDURE GradeItensPage2Column10Valid()
2931:         LOCAL loc_oCampo, loc_nPSaldo
2932: 
2933:         loc_oCampo = THIS.pgf_4c_1.Page2.grd_4c_Dados.Column10.Text1
2934:         loc_nPSaldo = THIS.pgf_4c_1.Page2.txt_4c_Tot_sPrc.Value
2935: 
2936:         IF !USED("TmpFinal") OR EOF("TmpFinal") OR loc_oCampo.Value = THIS.this_nOldValue
2937:             RETURN
2938:         ENDIF
2939: 
2940:         DO CASE
2941:             CASE loc_oCampo.Value < 0
2942:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo...", "Aten" + CHR(231) + CHR(227) + "o")
2943:                 loc_oCampo.Value = THIS.this_nOldValue
2944:             CASE loc_oCampo.Value > TmpFinal.Saldo
2945:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
2946:                 loc_oCampo.Value = THIS.this_nOldValue
2947:             CASE loc_oCampo.Value > loc_nPSaldo
2948:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade Selecionada...", "Aten" + CHR(231) + CHR(227) + "o")
2949:                 loc_oCampo.Value = THIS.this_nOldValue
2950:             CASE loc_oCampo.Value > (TmpFinal.Saldo - TmpFinal.Estoque)
2951:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade Dispon" + CHR(237) + "vel...", "Aten" + CHR(231) + CHR(227) + "o")
2952:                 loc_oCampo.Value = THIS.this_nOldValue
2953:         ENDCASE
2954:     ENDPROC
2955: 
2956:     *--------------------------------------------------------------------------
2957:     * GradeItensPage2LostFocus - recalcula Tot_Qtd/Tot_Est/Tot_prc/Tot_Prz
2958:     * da Page2 (dump 7384-7398 / 7504-7517, identicos nas duas colunas).
2959:     *--------------------------------------------------------------------------
2960:     PROCEDURE GradeItensPage2LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2961:         LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
2962: 
2963:         IF !USED("TmpFinal")
2964:             RETURN
2965:         ENDIF
2966: 
2967:         SELECT TmpFinal
2968:         loc_nRecno = RECNO()
2969:         SUM Saldo, Estoque, Produzir, Fabrs TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
2970:         IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("TmpFinal")
2971:             GOTO loc_nRecno
2972:         ENDIF
2973: 
2974:         WITH THIS.pgf_4c_1.Page2
2975:             .txt_4c_Tot_Qtd.Value = loc_nSal
2976:             .txt_4c_Tot_Est.Value = loc_nEst
2977:             .txt_4c_Tot_prc.Value = loc_nPrc
2978:             .txt_4c_Tot_Prz.Value = loc_nPrz
2979:             .txt_4c_Tot_Qtd.Refresh()
2980:             .txt_4c_Tot_Est.Refresh()
2981:             .txt_4c_Tot_prc.Refresh()
2982:             .txt_4c_Tot_Prz.Refresh()
2983:         ENDWITH
2984:     ENDPROC
2985: 
2986:     *--------------------------------------------------------------------------
2987:     * GradeItensPage2AfterRowColChange - transcricao de GradeItens.
2988:     * AfterRowColChange da Page2 (dump 7251-7279): atualiza o rotulo e a
2989:     * imagem do produto da linha corrente. Usa o MESMO
2990:     * CarregarFotoProduto() do BO ja usado na Page1 (que decodifica o
2991:     * base64 corretamente) em vez do StrToFile direto do legado - o dump da
2992:     * Page2 grava o campo cru, sem o Strconv/Strtran que a Page1 faz, o que
2993:     * geraria um arquivo .jpg invalido.
2994:     *--------------------------------------------------------------------------
2995:     PROCEDURE GradeItensPage2AfterRowColChange(par_nColIndex)
2996:         LOCAL loc_cArquivo, loc_oPag2
2997: 
2998:         IF !USED("TmpFinal") OR EOF("TmpFinal")
2999:             RETURN
3000:         ENDIF
3001: 
3002:         loc_oPag2 = THIS.pgf_4c_1.Page2
3003:         loc_oPag2.obj_4c_ObsItens.Refresh()
3004:         loc_oPag2.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ALLTRIM(TmpFinal.CPros)
3005: 
3006:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3007:             loc_cArquivo = ADDBS(SYS(2023)) + "TempGlb6_" + SYS(3) + ".jpg"
3008:             loc_oPag2.img_4c_FigJpg.Picture = ""
3009:             loc_oPag2.img_4c_FigJpg.Visible = .F.
3010:             IF THIS.this_oBusinessObject.CarregarFotoProduto(ALLTRIM(TmpFinal.Cpros), loc_cArquivo)
3011:                 loc_oPag2.img_4c_FigJpg.Picture = loc_cArquivo
3012:                 loc_oPag2.img_4c_FigJpg.Visible = .T.
3013:             ENDIF
3014:         ENDIF
3015: 
3016:         SELECT TmpFinal
3017:     ENDPROC
3018: 
3019:     *--------------------------------------------------------------------------
3020:     * GradeDispEstoqueColumn5Valid / GradeDispTamanhoColumn5Valid -
3021:     * transcricao de Page4/Page5.GradeDisp.Column5.Text1.Valid (dump
3022:     * 7754-7785, 8030-8057): valida a quantidade "Utilizar" contra o
3023:     * disponivel da linha e contra o saldo total ainda nao atendido
3024:     * (Qt_pedida), e atualiza Qt_Selec com a soma de Utilizar da grade.
3025:     *--------------------------------------------------------------------------
3026:     PROCEDURE GradeDispEstoqueColumn5Valid()
3027:         LOCAL loc_oCampo, loc_nPSaldo, loc_nQtdUti, loc_nRecno
3028: 
3029:         loc_oCampo = THIS.pgf_4c_1.Page4.grd_4c_DispEstoque.Column5.Text1
3030: 
3031:         IF !USED("TmpFinalg") OR EOF("TmpFinalg") OR !USED("cursor_4c_DispEstoque")
3032:             RETURN
3033:         ENDIF
3034: 
3035:         loc_nPSaldo = TmpFinalg.Saldo - TmpFinalg.Estoque - TmpFinalg.Fabrs
3036: 
3037:         IF loc_oCampo.Value > cursor_4c_DispEstoque.Disps
3038:             MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde Dispon" + CHR(237) + "vel...", "Aten" + CHR(231) + CHR(227) + "o")
3039:             loc_oCampo.Value = 0
3040:             loc_oCampo.Refresh()
3041:             RETURN
3042:         ENDIF
3043:         IF loc_oCampo.Value < 0
3044:             MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser menor que zero...", "Aten" + CHR(231) + CHR(227) + "o")
3045:             loc_oCampo.Value = 0
3046:             loc_oCampo.Refresh()
3047:             RETURN
3048:         ENDIF
3049: 
3050:         loc_nRecno = RECNO("cursor_4c_DispEstoque")
3051:         SELECT cursor_4c_DispEstoque
3052:         SUM Utilizar TO loc_nQtdUti
3053:         IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("cursor_4c_DispEstoque")
3054:             GOTO loc_nRecno
3055:         ENDIF
3056: 
3057:         IF loc_nQtdUti > loc_nPSaldo
3058:             MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Solicitada...", "Aten" + CHR(231) + CHR(227) + "o")
3059:             loc_oCampo.Value = 0
3060:             loc_oCampo.Refresh()
3061:             RETURN
3062:         ENDIF
3063: 
3064:         THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Value = loc_nQtdUti
3065:         THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Refresh()
3066:     ENDPROC
3067: 
3068:     PROCEDURE GradeDispTamanhoColumn5Valid()
3069:         LOCAL loc_oCampo, loc_nPSaldo, loc_nQtdUti, loc_nRecno
3070: 
3071:         loc_oCampo = THIS.pgf_4c_1.Page5.grd_4c_DispTamanho.Column5.Text1
3072: 
3073:         IF !USED("cursor_4c_DispTamanho")
3074:             RETURN
3075:         ENDIF
3076: 
3077:         loc_nPSaldo = THIS.pgf_4c_1.Page5.txt_4c_Qt_pedida.Value
3078: 
3079:         IF loc_oCampo.Value > cursor_4c_DispTamanho.Disps
3080:             MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde Dispon" + CHR(237) + "vel...", "Aten" + CHR(231) + CHR(227) + "o")
3081:             loc_oCampo.Value = 0
3082:             loc_oCampo.Refresh()
3083:             RETURN
3084:         ENDIF
3085: 
3086:         loc_nRecno = RECNO("cursor_4c_DispTamanho")
3087:         SELECT cursor_4c_DispTamanho
3088:         SUM Utilizar TO loc_nQtdUti
3089:         IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("cursor_4c_DispTamanho")
3090:             GOTO loc_nRecno
3091:         ENDIF
3092: 
3093:         IF loc_nQtdUti > loc_nPSaldo
3094:             MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Pedida...", "Aten" + CHR(231) + CHR(227) + "o")
3095:             loc_oCampo.Value = 0
3096:             loc_oCampo.Refresh()
3097:             RETURN
3098:         ENDIF
3099: 
3100:         THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Value = loc_nQtdUti
3101:         THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Refresh()
3102:     ENDPROC
3103: 
3104:     *--------------------------------------------------------------------------
3105:     * GradeDispColumn5LostFocus - "If Lastkey()=13 / Keyboard DNARROW" +
3106:     * Refresh do legado (dump 7790-7795, 8058-7? identico nas duas
3107:     * paginas). O avanco automatico de linha via KEYBOARD nao eh
3108:     * reproduzido (regra geral do projeto contra simular teclado); o
3109:     * Refresh, que corrige o redraw da celula, permanece. BINDEVENT em
3110:     * "LostFocus" nao repassa o controle de origem como parametro -
3111:     * refresca as duas colunas (Page4 e Page5), ambas inofensivas se a
3112:     * pagina correspondente nao estiver ativa.
3113:     *--------------------------------------------------------------------------
3114:     PROCEDURE GradeDispColumn5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
3115:         IF PEMSTATUS(THIS.pgf_4c_1.Page4, "grd_4c_DispEstoque", 5)
3116:             THIS.pgf_4c_1.Page4.grd_4c_DispEstoque.Column5.Text1.Refresh()
3117:         ENDIF
3118:         IF PEMSTATUS(THIS.pgf_4c_1.Page5, "grd_4c_DispTamanho", 5)
3119:             THIS.pgf_4c_1.Page5.grd_4c_DispTamanho.Column5.Text1.Refresh()
3120:         ENDIF
3121:     ENDPROC
3122: 
3123:     *--------------------------------------------------------------------------
3124:     * TornarControlesVisiveis - torna visiveis todos os controles criados via
3125:     * AddObject (que nascem com Visible=.F.), percorrendo Pages de PageFrame e
3126:     * Controls de Container recursivamente. cmd_4c_Pedras/SelEstoque/
3127:     * Disponivel nascem Visible=.F. no SCX legado (so aparecem conforme o
3128:     * TipoEstos do produto corrente - logica da fase de eventos) e por isso
3129:     * sao filtrados aqui, senao esta rotina reabre os tres incondicionalmente.
3130:     *--------------------------------------------------------------------------
3131:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3132:         LOCAL loc_nI, loc_oObjeto, loc_nP
3133: 
3134:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3135:             loc_oObjeto = par_oContainer.Controls(loc_nI)
3136: 
3137:             IF VARTYPE(loc_oObjeto) = "O"
3138:                 IF INLIST(UPPER(loc_oObjeto.Name), "CMD_4C_PEDRAS", ;
3139:                         "CMD_4C_SELESTOQUE", "CMD_4C_DISPONIVEL", "IMG_4C_FIGJPG")
3140:                     LOOP
3141:                 ENDIF
3142: 
3143:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
3144:                     loc_oObjeto.Visible = .T.
3145:                 ENDIF
3146: 
3147:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
3148:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
3149:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
3150:                     ENDFOR
3151:                 ENDIF
3152: 
3153:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
3154:                     IF loc_oObjeto.ControlCount > 0
3155:                         THIS.TornarControlesVisiveis(loc_oObjeto)
3156:                     ENDIF
3157:                 ENDIF
3158:             ENDIF
3159:         ENDFOR
3160:     ENDPROC
3161: 
3162:     *--------------------------------------------------------------------------
3163:     * BtnCancelarClick - "Cancelar" da Page1 (Encerrar). Fecha a tela;
3164:     * Destroy() ja reabilita o form pai (THIS.this_oFormPai).
3165:     *--------------------------------------------------------------------------
3166:     PROCEDURE BtnCancelarClick()
3167:         THIS.Release()
3168:     ENDPROC
3169: 
3170:     *--------------------------------------------------------------------------
3171:     * BtnCancelarPage2Click - transcricao de Page2.Cancelar.Click (dump
3172:     * 7530-7550): so volta para a Page1 se o total de Estoque/Fabrs
3173:     * distribuido na grade de selecao (TmpFinal) bater com o que
3174:     * TmpFinalg espera para o item corrente.
3175:     *--------------------------------------------------------------------------
3176:     PROCEDURE BtnCancelarPage2Click()
3177:         LOCAL loc_nEstoque, loc_nFabrica, loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
3178: 
3179:         IF !USED("TmpFinalg") OR !USED("TmpFinal")
3180:             THIS.AlternarPagina(1)
3181:             RETURN
3182:         ENDIF
3183: 
3184:         loc_nEstoque = TmpFinalg.Estoque
3185:         loc_nFabrica = TmpFinalg.Fabrs
3186: 
3187:         SELECT TmpFinal
3188:         SUM Saldo, Estoque, Produzir, Fabrs TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
3189:         GO TOP
3190: 
3191:         IF loc_nEst != loc_nEstoque
3192:             MsgAviso("A quantidade de Estoque n" + CHR(227) + "o confere com a Quantidade Selecionada!!!", "Aten" + CHR(231) + CHR(227) + "o")
3193:             RETURN
3194:         ENDIF
3195:         IF loc_nPrc != loc_nFabrica
3196:             MsgAviso("A quantidade de Produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o confere com a Quantidade Selecionada!!!", "Aten" + CHR(231) + CHR(227) + "o")
3197:             RETURN
3198:         ENDIF
3199: 
3200:         THIS.pgf_4c_1.Page1.Enabled = .T.
3201:         THIS.AlternarPagina(1)
3202:         THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3203:     ENDPROC
3204: 
3205:     *--------------------------------------------------------------------------
3206:     * BtnCancelaLinClick - transcricao de Page3.CancelaLin.Click (dump
3207:     * 7562-7572): volta para a Page1.
3208:     *--------------------------------------------------------------------------
3209:     PROCEDURE BtnCancelaLinClick()
3210:         THIS.pgf_4c_1.Page1.Enabled = .T.
3211:         THIS.pgf_4c_1.Page2.Enabled = .T.
3212:         THIS.pgf_4c_1.Page3.Enabled = .F.
3213:         THIS.pgf_4c_1.Page4.Enabled = .F.
3214:         THIS.pgf_4c_1.Page5.Enabled = .F.
3215:         THIS.AlternarPagina(1)
3216:         THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3217:     ENDPROC
3218: 
3219:     *--------------------------------------------------------------------------
3220:     * BtnTotLinhaClick - transcricao de Page1.TotLinha.Click (dump
3221:     * 6478-6512): monta TmpLinha (totais por Linha + linha "TOTAIS") a
3222:     * partir de TmpFinalg e liga a grade da Page3.
3223:     *--------------------------------------------------------------------------
3224:     PROCEDURE BtnTotLinhaClick()
3225:         LOCAL loc_oGrid, loc_nCol
3226: 
3227:         IF !USED("TmpFinalg")
3228:             RETURN
3229:         ENDIF
3230: 
3231:         IF USED("TmpLinha")
3232:             USE IN TmpLinha
3233:         ENDIF
3234: 
3235:         SELECT Linhas, 0 AS Ordem, SUM(saldo) AS saldo, SUM(estoque) AS estoque, ;
3236:                 SUM(produzir) AS produzir, SUM(Fabrs) AS Fabrs ;
3237:             FROM TmpFinalg GROUP BY 1 ;
3238:             UNION ALL ;
3239:             SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS ordem, SUM(saldo) AS saldo, SUM(estoque) AS estoque, ;
3240:                 SUM(produzir) AS produzir, SUM(Fabrs) AS Fabrs ;
3241:             FROM TmpFinalg GROUP BY 1 ;
3242:             INTO CURSOR TmpLinha ORDER BY 2, 1
3243: 
3244:         loc_oGrid = THIS.pgf_4c_1.Page3.grd_4c_Linhas
3245:         loc_oGrid.RecordSource = ""
3246:         loc_oGrid.ColumnCount  = 5
3247:         loc_oGrid.RecordSource = "TmpLinha"
3248:         loc_oGrid.Column1.ControlSource = "TmpLinha.Linhas"
3249:         loc_oGrid.Column2.ControlSource = "TmpLinha.Saldo"
3250:         loc_oGrid.Column3.ControlSource = "TmpLinha.Estoque"
3251:         loc_oGrid.Column4.ControlSource = "TmpLinha.Fabrs"
3252:         loc_oGrid.Column5.ControlSource = "TmpLinha.Produzir"
3253: 
3254:         *-- ColumnCount reatribuido RESETA Header1.Caption/Width/ReadOnly/
3255:         *-- Movable/Resizable/Sparse de TODAS as colunas (medido no VFP9 -
3256:         *-- regra do Problema 48/Pattern #180) - reconfigurar na mesma
3257:         *-- ordem de ConfigurarPaginaTotaisLinha.
3258:         loc_oGrid.Column1.Header1.Caption = "Linha"
3259:         loc_oGrid.Column1.Width     = 84
3260:         loc_oGrid.Column1.Movable   = .F.
3261:         loc_oGrid.Column1.Resizable = .F.
3262:         loc_oGrid.Column1.Sparse    = .F.
3263:         loc_oGrid.Column1.ReadOnly  = .T.
3264:         loc_oGrid.Column1.ForeColor = RGB(36, 84, 155)

*-- Linhas 3321 a 3650:
3321:     ENDPROC
3322: 
3323:     *--------------------------------------------------------------------------
3324:     * BtnSelEstoqueClick - transcricao de Page1.SelEstoque.Click (dump
3325:     * 6524-6583): lista o saldo priorizado por grupo/conta do item
3326:     * corrente (cursor_4c_TmpSaldg) na Page4, para o usuario redistribuir a
3327:     * prioridade/uso manualmente.
3328:     *--------------------------------------------------------------------------
3329:     PROCEDURE BtnSelEstoqueClick()
3330:         LOCAL loc_cCpro, loc_cCor, loc_cTam, loc_oGrid
3331: 
3332:         IF !USED("TmpFinalg") OR EOF("TmpFinalg")
3333:             RETURN
3334:         ENDIF
3335: 
3336:         loc_cCpro = TmpFinalg.Cpros
3337:         loc_cCor  = TmpFinalg.CodCors
3338:         loc_cTam  = TmpFinalg.CodTams
3339: 
3340:         IF USED("cursor_4c_DispEstoque")
3341:             THIS.pgf_4c_1.Page4.grd_4c_DispEstoque.RecordSource = ""
3342:             USE IN cursor_4c_DispEstoque
3343:         ENDIF
3344: 
3345:         SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, 0 AS Utilizar ;
3346:             FROM cursor_4c_TmpSaldg ;
3347:             WHERE Cpros = loc_cCpro AND CodCors = loc_cCor AND CodTams = loc_cTam AND Disps > 0 ;
3348:             ORDER BY 1, 2, 3, 4 ;
3349:             INTO CURSOR cursor_4c_DispEstoque READWRITE
3350: 
3351:         IF RECCOUNT("cursor_4c_DispEstoque") = 0
3352:             MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel !!!", "Aten" + CHR(231) + CHR(227) + "o")
3353:             THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3354:             RETURN
3355:         ENDIF
3356: 
3357:         loc_oGrid = THIS.pgf_4c_1.Page4.grd_4c_DispEstoque
3358:         loc_oGrid.ColumnCount = 5
3359:         loc_oGrid.RecordSource = "cursor_4c_DispEstoque"
3360:         loc_oGrid.Column1.ControlSource = "cursor_4c_DispEstoque.Grupos"
3361:         loc_oGrid.Column2.ControlSource = "cursor_4c_DispEstoque.Estos"
3362:         loc_oGrid.Column3.ControlSource = "cursor_4c_DispEstoque.Priors"
3363:         loc_oGrid.Column4.ControlSource = "cursor_4c_DispEstoque.Disps"
3364:         loc_oGrid.Column5.ControlSource = "cursor_4c_DispEstoque.Utilizar"
3365: 
3366:         *-- RecordSource reatribuido RESETA Header1.Caption/Width/ReadOnly de
3367:         *-- TODAS as colunas (medido no VFP9 - regra do Problema 48/Pattern
3368:         *-- #180) - reconfigurar na mesma ordem de ConfigurarPaginaEstoque.
3369:         loc_oGrid.Column1.Header1.Caption = "Grupo"
3370:         loc_oGrid.Column1.Width     = 80
3371:         loc_oGrid.Column1.ReadOnly  = .T.
3372:         loc_oGrid.Column2.Header1.Caption = "Conta"
3373:         loc_oGrid.Column2.Width     = 80
3374:         loc_oGrid.Column2.ReadOnly  = .T.
3375:         loc_oGrid.Column3.Header1.Caption = "Prior"
3376:         loc_oGrid.Column3.Width     = 24
3377:         loc_oGrid.Column3.ReadOnly  = .T.
3378:         loc_oGrid.Column4.Header1.Caption = "Disponivel"
3379:         loc_oGrid.Column4.Width     = 75
3380:         loc_oGrid.Column4.ReadOnly  = .T.
3381:         loc_oGrid.Column5.Header1.Caption = "Utilizar"
3382:         loc_oGrid.Column5.Width     = 75
3383:         loc_oGrid.Column5.ReadOnly  = .F.
3384:         loc_oGrid.Column5.Text1.FontBold = .T.
3385: 
3386:         WITH THIS.pgf_4c_1.Page4
3387:             .txt_4c_Qt_pedida.Value = TmpFinalg.Saldo - TmpFinalg.Estoque - TmpFinalg.Fabrs
3388:             .txt_4c_Qt_Selec.Value  = 0
3389:         ENDWITH
3390:         loc_oGrid.Refresh()
3391: 
3392:         THIS.pgf_4c_1.Page1.Enabled = .F.
3393:         THIS.pgf_4c_1.Page2.Enabled = .F.
3394:         THIS.pgf_4c_1.Page3.Enabled = .F.
3395:         THIS.pgf_4c_1.Page5.Enabled = .F.
3396:         THIS.pgf_4c_1.Page4.Enabled = .T.
3397:         THIS.AlternarPagina(4)
3398:         loc_oGrid.SetFocus()
3399:     ENDPROC
3400: 
3401:     *--------------------------------------------------------------------------
3402:     * BtnDisponivelClick - transcricao de Page1.Disponivel.Click (dump
3403:     * 4487-4550): lista o saldo disponivel do produto/cor corrente
3404:     * QUEBRADO POR TAMANHO (cursor_4c_TmpSaldo) na Page5.
3405:     *--------------------------------------------------------------------------
3406:     PROCEDURE BtnDisponivelClick()
3407:         LOCAL loc_cCpro, loc_cCor, loc_oGrid
3408: 
3409:         IF !USED("TmpFinalg") OR EOF("TmpFinalg")
3410:             RETURN
3411:         ENDIF
3412: 
3413:         IF TmpFinalg.Estoque != 0 OR TmpFinalg.Fabrs != 0
3414:             MsgAviso("Quantidade de Estoque e Produ" + CHR(231) + CHR(227) + "o tem estar Zero antes deste Processo!!!", ;
3415:                 "Aten" + CHR(231) + CHR(227) + "o")
3416:             THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3417:             RETURN
3418:         ENDIF
3419: 
3420:         loc_cCpro = TmpFinalg.Cpros
3421:         loc_cCor  = TmpFinalg.CodCors
3422: 
3423:         IF USED("cursor_4c_DispTamanho")
3424:             THIS.pgf_4c_1.Page5.grd_4c_DispTamanho.RecordSource = ""
3425:             USE IN cursor_4c_DispTamanho
3426:         ENDIF
3427: 
3428:         SELECT Cpros, CodCors, CodTams, Disps, 0 AS Utilizar ;
3429:             FROM cursor_4c_TmpSaldo ;
3430:             WHERE Cpros = loc_cCpro AND CodCors = loc_cCor AND Disps > 0 ;
3431:             ORDER BY 1, 2, 3 ;
3432:             INTO CURSOR cursor_4c_DispTamanho READWRITE
3433: 
3434:         IF RECCOUNT("cursor_4c_DispTamanho") = 0
3435:             MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel em Nenhum Tamanho!!!", "Aten" + CHR(231) + CHR(227) + "o")
3436:             THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3437:             RETURN
3438:         ENDIF
3439: 
3440:         loc_oGrid = THIS.pgf_4c_1.Page5.grd_4c_DispTamanho
3441:         loc_oGrid.ColumnCount = 5
3442:         loc_oGrid.RecordSource = "cursor_4c_DispTamanho"
3443:         loc_oGrid.Column1.ControlSource = "cursor_4c_DispTamanho.Cpros"
3444:         loc_oGrid.Column2.ControlSource = "cursor_4c_DispTamanho.CodCors"
3445:         loc_oGrid.Column3.ControlSource = "cursor_4c_DispTamanho.CodTams"
3446:         loc_oGrid.Column4.ControlSource = "cursor_4c_DispTamanho.Disps"
3447:         loc_oGrid.Column5.ControlSource = "cursor_4c_DispTamanho.Utilizar"
3448: 
3449:         *-- RecordSource reatribuido RESETA Header1.Caption/Width/ReadOnly de
3450:         *-- TODAS as colunas (medido no VFP9 - regra do Problema 48/Pattern
3451:         *-- #180) - reconfigurar na mesma ordem de ConfigurarPaginaTamanhos.
3452:         loc_oGrid.Column1.Header1.Caption = "Produto"
3453:         loc_oGrid.Column1.Width     = 80
3454:         loc_oGrid.Column1.ReadOnly  = .T.
3455:         loc_oGrid.Column2.Header1.Caption = "Cor"
3456:         loc_oGrid.Column2.Width     = 38
3457:         loc_oGrid.Column2.ReadOnly  = .T.
3458:         loc_oGrid.Column2.Text1.FontBold = .T.
3459:         loc_oGrid.Column3.Header1.Caption = "Tam"
3460:         loc_oGrid.Column3.Width     = 24
3461:         loc_oGrid.Column3.ReadOnly  = .T.
3462:         loc_oGrid.Column3.Text1.FontBold = .T.
3463:         loc_oGrid.Column4.Header1.Caption = "Disponivel"
3464:         loc_oGrid.Column4.Width     = 75
3465:         loc_oGrid.Column4.ReadOnly  = .T.
3466:         loc_oGrid.Column5.Header1.Caption = "Utilizar"
3467:         loc_oGrid.Column5.Width     = 75
3468:         loc_oGrid.Column5.ReadOnly  = .F.
3469:         loc_oGrid.Column5.Text1.FontBold = .T.
3470: 
3471:         WITH THIS.pgf_4c_1.Page5
3472:             .txt_4c_Qt_pedida.Value = TmpFinalg.Saldo - TmpFinalg.Estoque - TmpFinalg.Fabrs
3473:             .txt_4c_Qt_Selec.Value  = 0
3474:         ENDWITH
3475:         loc_oGrid.Refresh()
3476: 
3477:         THIS.pgf_4c_1.Page1.Enabled = .F.
3478:         THIS.pgf_4c_1.Page2.Enabled = .F.
3479:         THIS.pgf_4c_1.Page3.Enabled = .F.
3480:         THIS.pgf_4c_1.Page4.Enabled = .F.
3481:         THIS.pgf_4c_1.Page5.Enabled = .T.
3482:         THIS.AlternarPagina(5)
3483:         loc_oGrid.SetFocus()
3484:     ENDPROC
3485: 
3486:     *--------------------------------------------------------------------------
3487:     * BtnCancelaDispPage4Click - transcricao de Page4.CancelaDisp.Click
3488:     * (dump 7584-7666): devolve o "Utilizar" marcado na grade de
3489:     * grupo/conta para TmpFinalg/cursor_4c_TmpSaldo/cursor_4c_TmpSaldg e
3490:     * TmpFinal, e volta para a Page1.
3491:     *--------------------------------------------------------------------------
3492:     PROCEDURE BtnCancelaDispPage4Click()
3493:         LOCAL loc_nQtdUti, loc_nLnQtUtil, loc_nXBaixa
3494: 
3495:         IF USED("cursor_4c_DispEstoque") AND RECCOUNT("cursor_4c_DispEstoque") > 0
3496:             SELECT cursor_4c_DispEstoque
3497:             SUM Utilizar TO loc_nQtdUti
3498: 
3499:             IF loc_nQtdUti > 0
3500:                 SELECT cursor_4c_DispEstoque
3501:                 SCAN
3502:                     IF cursor_4c_DispEstoque.Utilizar = 0
3503:                         LOOP
3504:                     ENDIF
3505:                     loc_nLnQtUtil = cursor_4c_DispEstoque.Utilizar
3506: 
3507:                     = SEEK(cursor_4c_DispEstoque.CPros + cursor_4c_DispEstoque.CodCors + cursor_4c_DispEstoque.CodTams, ;
3508:                         "cursor_4c_TmpSaldo", "CPros")
3509: 
3510:                     SELECT TmpFinalg
3511:                     REPLACE Produzir WITH Produzir - loc_nLnQtUtil, ;
3512:                             Estoque  WITH Estoque + loc_nLnQtUtil, ;
3513:                             UsuLibs  WITH " " IN TmpFinalg
3514: 
3515:                     SELECT cursor_4c_TmpSaldo
3516:                     REPLACE Disps WITH Disps - loc_nLnQtUtil IN cursor_4c_TmpSaldo
3517: 
3518:                     IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
3519:                         INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
3520:                     ENDIF
3521:                     REPLACE keySelm WITH .T. IN TmpSaldU
3522: 
3523:                     SELECT cursor_4c_TmpSaldg
3524:                     SET ORDER TO CPros
3525:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams + ;
3526:                         STR(cursor_4c_DispEstoque.Priors, 2) + cursor_4c_DispEstoque.Grupos + cursor_4c_DispEstoque.Estos)
3527:                     REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldg.Disps - loc_nLnQtUtil
3528:                     SELECT cursor_4c_DispEstoque
3529:                 ENDSCAN
3530: 
3531:                 = SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, "cursor_4c_TmpSaldo", "CPros")
3532: 
3533:                 loc_nXBaixa = TmpFinalg.Estoque
3534:                 SELECT TmpFinal
3535:                 SET ORDER TO
3536:                 SET ORDER TO Cpros
3537:                 = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
3538:                 REPLACE Estoque WITH 0 WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
3539:                         TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams
3540:                 = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
3541:                 SCAN WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors ;
3542:                         AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
3543:                     IF (TmpFinal.Saldo - TmpFinal.Fabrs) >= loc_nXBaixa
3544:                         REPLACE TmpFinal.Estoque WITH TmpFinal.Estoque + loc_nXBaixa
3545:                         loc_nXBaixa = 0
3546:                     ELSE
3547:                         loc_nXBaixa = loc_nXBaixa - (TmpFinal.Saldo - TmpFinal.Fabrs)
3548:                         REPLACE TmpFinal.Estoque WITH (TmpFinal.Saldo - TmpFinal.Fabrs)
3549:                     ENDIF
3550:                     REPLACE Produzir WITH Saldo - Estoque - Fabrs IN TmpFinal
3551:                     SELECT TmpFinal
3552:                 ENDSCAN
3553:             ENDIF
3554:         ENDIF
3555: 
3556:         THIS.AtualizarTotaisPage1()
3557: 
3558:         THIS.pgf_4c_1.Page1.Enabled = .T.
3559:         THIS.pgf_4c_1.Page2.Enabled = .T.
3560:         THIS.pgf_4c_1.Page3.Enabled = .F.
3561:         THIS.pgf_4c_1.Page4.Enabled = .F.
3562:         THIS.pgf_4c_1.Page5.Enabled = .F.
3563:         THIS.AlternarPagina(1)
3564:         THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3565:     ENDPROC
3566: 
3567:     *--------------------------------------------------------------------------
3568:     * BtnCancelaDispPage5Click - transcricao de Page5.CancelaDisp.Click
3569:     * (dump 7835-7959): quebra a linha de TmpFinal/TmpFinalg do
3570:     * produto/cor corrente por TAMANHO, de acordo com o "Utilizar" marcado
3571:     * em cursor_4c_DispTamanho, e reflete a quebra em SigMvIts (tabela
3572:     * real - a linha de origem, sem tamanho definido, eh dividida numa
3573:     * nova linha com o tamanho escolhido).
3574:     *--------------------------------------------------------------------------
3575:     PROCEDURE BtnCancelaDispPage5Click()
3576:         LOCAL loc_nQtdUti, loc_nRegFinal, loc_nLnQtUtil, loc_cEdn, loc_cQuery
3577: 
3578:         IF !USED("TmpFinal") OR !USED("cursor_4c_DispTamanho")
3579:             THIS.AlternarPagina(1)
3580:             RETURN
3581:         ENDIF
3582: 
3583:         SELECT TmpFinal
3584:         SET ORDER TO
3585:         loc_nRegFinal = RECNO()
3586: 
3587:         SELECT cursor_4c_DispTamanho
3588:         SUM Utilizar TO loc_nQtdUti
3589: 
3590:         IF loc_nQtdUti > 0
3591:             IF USED("Temporario")
3592:                 USE IN Temporario
3593:             ENDIF
3594:             SELECT * FROM TmpFinal WHERE .F. INTO CURSOR Temporario READWRITE
3595: 
3596:             SELECT cursor_4c_DispTamanho
3597:             SCAN
3598:                 IF cursor_4c_DispTamanho.Utilizar = 0
3599:                     LOOP
3600:                 ENDIF
3601:                 loc_nLnQtUtil = cursor_4c_DispTamanho.Utilizar
3602: 
3603:                 = SEEK(cursor_4c_DispTamanho.CPros + cursor_4c_DispTamanho.CodCors + cursor_4c_DispTamanho.CodTams, ;
3604:                     "cursor_4c_TmpSaldo", "CPros")
3605: 
3606:                 SELECT TmpFinal
3607:                 SCATTER MEMVAR
3608:                 SELECT Temporario
3609:                 APPEND BLANK
3610:                 GATHER MEMVAR
3611:                 REPLACE Temporario.Saldo WITH loc_nLnQtUtil, ;
3612:                         Temporario.codTams WITH cursor_4c_DispTamanho.CodTams, ;
3613:                         Temporario.Estoque WITH loc_nLnQtUtil, ;
3614:                         Temporario.Produzir WITH 0
3615: 
3616:                 SELECT TmpFinal
3617:                 REPLACE TmpFinal.Saldo WITH TmpFinal.Saldo - loc_nLnQtUtil, ;
3618:                         TmpFinal.Produzir WITH TmpFinal.Produzir - loc_nLnQtUtil
3619: 
3620:                 REPLACE Saldo WITH Saldo - loc_nLnQtUtil, Produzir WITH Produzir - loc_nLnQtUtil IN TmpFinalg
3621: 
3622:                 SELECT TmpFinalg
3623:                 REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
3624:                     QtdMins - Produzir, 0) IN TmpFinalg
3625: 
3626:                 SELECT cursor_4c_TmpSaldo
3627:                 REPLACE cursor_4c_TmpSaldo.Disps WITH cursor_4c_TmpSaldo.Disps - loc_nLnQtUtil
3628: 
3629:                 SELECT cursor_4c_TmpSaldg
3630:                 SET ORDER TO CPros
3631:                 = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
3632:                 REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldo.Saldo ;
3633:                     WHILE cursor_4c_TmpSaldg.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
3634:                           cursor_4c_TmpSaldg.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
3635:                           cursor_4c_TmpSaldg.CodTams = cursor_4c_TmpSaldo.CodTams
3636: 
3637:                 *-- Divide a linha SEM tamanho de SigMvIts (tabela real) em
3638:                 *-- duas: a original com a quantidade restante e uma nova
3639:                 *-- com o tamanho escolhido e loc_nLnQtUtil (dump 7896-7916)
3640:                 loc_cEdn = TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)
3641:                 loc_cQuery = "SELECT * FROM SigMvIts WHERE EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
3642:                     " AND Citens = " + FormatarNumeroSQL(TmpFinal.Citens, 0) + ;
3643:                     " AND CodCors = " + EscaparSQL(ALLTRIM(TmpFinal.CodCors)) + ;
3644:                     " AND CodTams = " + EscaparSQL(SPACE(4))
3645:                 IF USED("cursor_4c_MvItsOrig")
3646:                     USE IN cursor_4c_MvItsOrig
3647:                 ENDIF
3648:                 IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_MvItsOrig") >= 0 AND ;
3649:                         USED("cursor_4c_MvItsOrig") AND !EOF("cursor_4c_MvItsOrig")
3650: 

*-- Linhas 3689 a 3933:
3689:             SELECT TmpFinalg
3690:             IF TmpFinalg.Saldo = 0
3691:                 DELETE
3692:             ENDIF
3693: 
3694:             = SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, "cursor_4c_TmpSaldo", "CPros")
3695:         ENDIF
3696: 
3697:         THIS.AtualizarTotaisPage1()
3698: 
3699:         THIS.pgf_4c_1.Page1.Enabled = .T.
3700:         THIS.pgf_4c_1.Page2.Enabled = .T.
3701:         THIS.pgf_4c_1.Page3.Enabled = .F.
3702:         THIS.pgf_4c_1.Page4.Enabled = .F.
3703:         THIS.pgf_4c_1.Page5.Enabled = .F.
3704:         THIS.AlternarPagina(1)
3705:         THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3706:     ENDPROC
3707: 
3708:     *--------------------------------------------------------------------------
3709:     * BtnCancelaDispPage6Click - "Voltar" da Page6 (Requisicao Manual).
3710:     * NAO existe no legado original (a pagina de requisicao do dump nao
3711:     * tem Cancelar) - segue o mesmo padrao de retorno das outras
3712:     * sub-paginas, canonico do projeto.
3713:     *--------------------------------------------------------------------------
3714:     PROCEDURE BtnCancelaDispPage6Click()
3715:         THIS.pgf_4c_1.Page1.Enabled = .T.
3716:         THIS.pgf_4c_1.Page2.Enabled = .T.
3717:         THIS.pgf_4c_1.Page6.Enabled = .F.
3718:         THIS.AlternarPagina(1)
3719:         THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3720:     ENDPROC
3721: 
3722:     *--------------------------------------------------------------------------
3723:     * BtnPedrasClick - transcricao de Page1.Pedras.Click (dump 7216-7239):
3724:     * liga a grade de requisicao manual (SelPedra/cursor_4c_Requisicao) e
3725:     * vai para a Page6.
3726:     *--------------------------------------------------------------------------
3727:     PROCEDURE BtnPedrasClick()
3728:         LOCAL loc_oGrid
3729: 
3730:         loc_oGrid = THIS.pgf_4c_1.Page6.grd_4c_Pedra
3731:         loc_oGrid.RecordSource = ""
3732:         loc_oGrid.ColumnCount  = 5
3733:         loc_oGrid.RecordSource = "cursor_4c_Requisicao"
3734:         loc_oGrid.Column1.ControlSource = "cursor_4c_Requisicao.Cpros"
3735:         loc_oGrid.Column2.ControlSource = "cursor_4c_Requisicao.Dpros"
3736:         loc_oGrid.Column3.ControlSource = "cursor_4c_Requisicao.Cunis"
3737:         loc_oGrid.Column4.ControlSource = "cursor_4c_Requisicao.Qtds"
3738:         loc_oGrid.Column5.ControlSource = "cursor_4c_Requisicao.Cpro2s"
3739: 
3740:         THIS.pgf_4c_1.Page1.Enabled = .F.
3741:         THIS.pgf_4c_1.Page2.Enabled = .F.
3742:         THIS.pgf_4c_1.Page3.Enabled = .F.
3743:         THIS.pgf_4c_1.Page4.Enabled = .F.
3744:         THIS.pgf_4c_1.Page5.Enabled = .F.
3745:         THIS.pgf_4c_1.Page6.Enabled = .T.
3746:         THIS.AlternarPagina(6)
3747:         loc_oGrid.SetFocus()
3748:     ENDPROC
3749: 
3750:     *--------------------------------------------------------------------------
3751:     * BtnAlteraqtdClick - transcricao de Page1.Alteraqtd.Click (dump
3752:     * 7180-7204): autoriza UMA edicao da coluna "Produzir Estq" via dialogo
3753:     * de senha de risco (SigOpSen, "PRDZRISCO"). SigOpSen NAO foi migrado
3754:     * (ver feedback_sigopsen_ausente_gate_autorizacao) - gate de
3755:     * AUTORIZACAO tratado FAIL-CLOSED: dialogo indisponivel = NAO
3756:     * autorizado, nunca MsgConfirma/skip.
3757:     *--------------------------------------------------------------------------
3758:     PROCEDURE BtnAlteraqtdClick()
3759:         LOCAL loc_cString, loc_cRetorno, loc_lOk, loc_oErro
3760: 
3761:         IF !USED("TmpFinalg") OR EOF("TmpFinalg") OR TmpFinalg.Produzir2 = 0
3762:             MsgAviso("Refer" + CHR(234) + "ncia Sem Quantidade a Produzir para Estoque!!!", "Aten" + CHR(231) + CHR(227) + "o")
3763:             THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3764:             RETURN
3765:         ENDIF
3766: 
3767:         loc_cString = ALLTRIM(TmpFinalg.Cpros) + " Qt.Min:" + ALLTRIM(TRANSFORM(TmpFinalg.QtdMins, "@Z 99999.999")) + ;
3768:             " Qt.Est:" + ALLTRIM(TRANSFORM(TmpFinalg.Produzir2, "@Z 99999.999"))
3769: 
3770:         loc_cRetorno = ""
3771:         loc_lOk = .F.
3772:         TRY
3773:             DO FORM SigOpSen WITH "PRDZRISCO", loc_cString, "" TO loc_cRetorno
3774:             loc_lOk = (LEFT(TratarNulo(loc_cRetorno, ""), 1) = "*")
3775:         CATCH TO loc_oErro
3776:             MsgErro("Dialogo de autoriza" + CHR(231) + CHR(227) + "o (SigOpSen) indispon" + CHR(237) + "vel - " + ;
3777:                 "altera" + CHR(231) + CHR(227) + "o N" + CHR(195) + "O autorizada." + CHR(13) + loc_oErro.Message, ;
3778:                 "Erro de Autoriza" + CHR(231) + CHR(227) + "o")
3779:             loc_lOk = .F.
3780:         ENDTRY
3781: 
3782:         IF !loc_lOk
3783:             MsgAviso("Altera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o autorizada!!!", "Aten" + CHR(231) + CHR(227) + "o")
3784:         ELSE
3785:             REPLACE TmpFinalg.UsuLibs WITH PADR(SUBSTR(loc_cRetorno, 2), 10) IN TmpFinalg
3786:             THIS.this_lLiberadoAlteracao = .T.
3787:             THIS.pgf_4c_1.Page1.grd_4c_Dados.Column8.ReadOnly = .F.
3788:         ENDIF
3789:         THIS.pgf_4c_1.Page1.grd_4c_Dados.Column8.SetFocus()
3790:     ENDPROC
3791: 
3792:     *--------------------------------------------------------------------------
3793:     * BOParaForm - leva para a tela o que o Init legado lia dos cursores de
3794:     * parametro do sistema (crSigCdPam/CrSigCdPac), hoje carregados uma
3795:     * unica vez em SigPrGlxBO.Init:
3796:     *
3797:     *   Thisform.SigKey = CrSigCdPac.sigKeys                 -> BO.this_cSigKey
3798:     *   lab_periodo.Caption = 'Periodo: '+Alltrim(Str(
3799:     *       CrSigCdPac.nMeses,2))+' meses'                   -> BO.this_nPacNMeses
3800:     *   Pedras.Visible = .f.                                 -> BO.this_cPamDop*
3801:     *   If Not Empty(crSigCdPam.DopEmphs) And Not Empty(DopReqcs)
3802:     *      And Not Empty(DopPedcs) And Not Empty(DopComps)
3803:     *      And Not ThisForm.Reserva -> Pedras.Visible = .t.
3804:     *   SelEstoque.Visible (fChecaAcesso SIGPRGLO/PRIORIDADE)
3805:     *   Caption / lblSombra / lblTitulo (modo Reserva x Globalizacao)
3806:     *
3807:     * PROTECTED EXPLICITO: FormBase ja declara BOParaForm como PROTECTED e
3808:     * o VFP9 nao deixa a subclasse ALARGAR o escopo - omitir o modificador
3809:     * mentiria para quem le, porque o metodo continua protegido.
3810:     *--------------------------------------------------------------------------
3811:     PROTECTED PROCEDURE BOParaForm()
3812:         LOCAL loc_oBO, loc_oPag1, loc_lTemPedras, loc_oErro
3813: 
3814:         TRY
3815:             loc_oBO   = THIS.this_oBusinessObject
3816:             loc_oPag1 = THIS.pgf_4c_1.Page1
3817: 
3818:             *-- Titulo da tela e os dois labels da faixa do cabecalho
3819:             THIS.Caption = IIF(THIS.this_lReservaAuto, ;
3820:                 "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica", ;
3821:                 "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o")
3822:             THIS.this_cTituloForm = THIS.Caption
3823:             loc_oPag1.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
3824:             loc_oPag1.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
3825: 
3826:             IF VARTYPE(loc_oBO) = "O"
3827:                 *-- "Periodo: NN meses" (SigCdPac.nmeses). O legado monta o
3828:                 *-- rotulo INTEIRO aqui; o Caption posto em
3829:                 *-- ConfigurarPaginaLista eh so o texto base de projeto.
3830:                 loc_oPag1.cnt_4c_Container5.lbl_4c_LabPeriodo.Caption = ;
3831:                     "Per" + CHR(237) + "odo: " + ALLTRIM(STR(loc_oBO.this_nPacNMeses, 2)) + " meses"
3832: 
3833:                 *-- "Requisicoes" (cmd_4c_Pedras): so com as QUATRO operacoes
3834:                 *-- de requisicao configuradas em SigCdPam e fora do modo
3835:                 *-- Reserva.
3836:                 loc_lTemPedras = !EMPTY(loc_oBO.this_cPamDopEmphs) AND ;
3837:                                  !EMPTY(loc_oBO.this_cPamDopReqcs) AND ;
3838:                                  !EMPTY(loc_oBO.this_cPamDopPedcs) AND ;
3839:                                  !EMPTY(loc_oBO.this_cPamDopComps) AND ;
3840:                                  !THIS.this_lReservaAuto
3841:                 loc_oPag1.cmd_4c_Pedras.Visible = loc_lTemPedras
3842:             ELSE
3843:                 loc_oPag1.cmd_4c_Pedras.Visible = .F.
3844:             ENDIF
3845: 
3846:             *-- "Estoques" (cmd_4c_SelEstoque): mesma condicao de acesso que
3847:             *-- libera a coluna Prior das grades de resumo.
3848:             loc_oPag1.cmd_4c_SelEstoque.Visible = THIS.this_lPermiteAjustarPrioridade()
3849: 
3850:             *-- "Disponiveis" (cmd_4c_Disponivel) nasce oculto e eh decidido
3851:             *-- por item em AtualizarVisibilidadeDisponivel().
3852:             loc_oPag1.cmd_4c_Disponivel.Visible = .F.
3853:         CATCH TO loc_oErro
3854:             MsgErro(loc_oErro.Message + CHR(13) + ;
3855:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3856:                 "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
3857:         ENDTRY
3858:     ENDPROC
3859: 
3860:     *--------------------------------------------------------------------------
3861:     * CarregarLista - (re)liga a grade principal da Page1 ao cursor
3862:     * TmpFinalg e deixa a tela no estado em que o Init legado a entregava:
3863:     *
3864:     *   With ThisForm.PageDados.page1.GradeItens -> RecordSource/ControlSource
3865:     *   Select TmpSaldG / Set Order To Cpros / Set Key To TmpFinalg.Cpros+
3866:     *       CodCors+CodTams / Go Top          (filtro relacional por item)
3867:     *   Select TmpFabr  / idem
3868:     *   Select TmpFinalg / Sum ... / Tot_* .Value / .Refresh
3869:     *   ThisForm.pageDados.Page1.GradeItens.Setfocus
3870:     *
3871:     * Por que REBIND e nao so Refresh: TmpFinalg/TmpFinal/TmpSaldG/TmpFabr
3872:     * sao criados por FormSigPrGl2BO.ExecutarProcessamento na data session
3873:     * do form PAI (assumida no Init). Quando o pai reprocessa, o alias eh
3874:     * fisicamente RECRIADO e o Grid perde RecordSource/ControlSource,
3875:     * Header1.Caption, Width e ReadOnly (regra #43.1 do CLAUDE.md) - a
3876:     * grade viraria "Column1/Column2" generica e editavel. Por isso a
3877:     * reconfiguracao completa, na ordem ColumnCount -> RecordSource ->
3878:     * ControlSource -> Width -> Header1.Caption -> ReadOnly (regra #41).
3879:     *
3880:     * Fecha com GO TOP + Refresh (regra #21a: popular/religar cursor NAO
3881:     * repinta a grade sozinho).
3882:     *
3883:     * PUBLIC (nao PROTECTED): CarregarLista nao existe em FormBase e o
3884:     * harness de teste automatizado chama THIS.oForm.CarregarLista() direto
3885:     * de fora da classe (regra #3 do CLAUDE.md).
3886:     *--------------------------------------------------------------------------
3887:     PROCEDURE CarregarLista()
3888:         LOCAL loc_lSucesso, loc_oGrid, loc_oErro
3889:         loc_lSucesso = .F.
3890: 
3891:         TRY
3892:             IF !USED("TmpFinalg")
3893:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados de globaliza" + CHR(231) + CHR(227) + ;
3894:                     "o para exibir - reprocesse a gera" + CHR(231) + CHR(227) + "o de O.P.", ;
3895:                     "Aten" + CHR(231) + CHR(227) + "o")
3896:             ELSE
3897:                 loc_oGrid = THIS.pgf_4c_1.Page1.grd_4c_Dados
3898: 
3899:                 WITH loc_oGrid
3900:                     .RecordSource = ""
3901:                     .ColumnCount  = 10
3902:                     .RecordSource = "TmpFinalg"
3903: 
3904:                     .Column1.ControlSource  = "TmpFinalg.Cpros"
3905:                     .Column2.ControlSource  = "TmpFinalg.CodCors"
3906:                     .Column3.ControlSource  = "TmpFinalg.Flag"
3907:                     .Column4.ControlSource  = "TmpFinalg.Qtds"
3908:                     .Column5.ControlSource  = "TmpFinalg.Saldo"
3909:                     .Column6.ControlSource  = "TmpFinalg.Produzir"
3910:                     .Column7.ControlSource  = "TmpFinalg.Fabrs"
3911:                     .Column8.ControlSource  = "TmpFinalg.Produzir2"
3912:                     .Column9.ControlSource  = "TmpFinalg.CodTams"
3913:                     .Column10.ControlSource = "TmpFinalg.Estoque"
3914: 
3915:                     *-- Width DEPOIS do RecordSource/ControlSource: reatribuir
3916:                     *-- a fonte do Grid recalcula toda largura para o default.
3917:                     .Column1.Width  = 90
3918:                     .Column2.Width  = 50
3919:                     .Column3.Width  = 30
3920:                     .Column4.Width  = 60
3921:                     .Column5.Width  = 70
3922:                     .Column6.Width  = 70
3923:                     .Column7.Width  = 80
3924:                     .Column8.Width  = 80
3925:                     .Column9.Width  = 40
3926:                     .Column10.Width = 76
3927: 
3928:                     .Column1.Header1.Caption  = "Produto"
3929:                     .Column2.Header1.Caption  = "Cor"
3930:                     .Column3.Header1.Caption  = ""
3931:                     .Column4.Header1.Caption  = "N" + CHR(250) + "mero"
3932:                     .Column5.Header1.Caption  = "Qtde Pedido"
3933:                     .Column6.Header1.Caption  = "Produzir"

*-- Linhas 3962 a 4114:
3962:                 *-- Ordem das grades de resumo (Set Order To Cpros do Init
3963:                 *-- legado). O FILTRO por item corrente NAO vem aqui: eh
3964:                 *-- GradeItensPage1AfterRowColChange quem o aplica, e ele eh
3965:                 *-- chamado no fim deste metodo para a primeira linha - uma
3966:                 *-- fonte unica, em vez de duas copias para divergirem.
3967:                 IF USED("cursor_4c_TmpSaldg")
3968:                     SELECT cursor_4c_TmpSaldg
3969:                     SET ORDER TO CPros
3970:                 ENDIF
3971:                 IF USED("cursor_4c_TmpFabr")
3972:                     SELECT cursor_4c_TmpFabr
3973:                     SET ORDER TO Cpros
3974:                 ENDIF
3975: 
3976:                 SELECT TmpFinalg
3977:                 GO TOP
3978:                 loc_oGrid.Refresh()
3979: 
3980:                 *-- Totais gerais e paineis/imagem do primeiro item
3981:                 THIS.AtualizarTotaisPage1()
3982:                 THIS.AtualizarVisibilidadeDisponivel()
3983:                 IF !EOF("TmpFinalg")
3984:                     THIS.GradeItensPage1AfterRowColChange(1)
3985:                 ENDIF
3986: 
3987:                 SELECT TmpFinalg
3988:                 loc_lSucesso = .T.
3989:             ENDIF
3990:         CATCH TO loc_oErro
3991:             MsgErro(loc_oErro.Message + CHR(13) + ;
3992:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3993:                 "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
3994:             loc_lSucesso = .F.
3995:         ENDTRY
3996: 
3997:         RETURN loc_lSucesso
3998:     ENDPROC
3999: 
4000:     *--------------------------------------------------------------------------
4001:     * FormParaBO - repassa a Processar() os dois campos que o Init legado
4002:     * lia do form AVO (_Prev/_DtGera = ThisForm.ParentForm.ParentForm.
4003:     * Cnt_Previsao.GetPrevisao/GetGeracao). THIS.this_oFormPai eh o
4004:     * FormSigPrGl2 (pai direto); THIS.this_oFormPai.this_oParentForm eh o
4005:     * FormSigPrGlo (avo, "Processamento de O.P."). Mesmo padrao ja adotado
4006:     * em FormSigPrGlp.FormParaBO.
4007:     *--------------------------------------------------------------------------
4008:     PROTECTED FUNCTION FormParaBO()
4009:         LOCAL loc_lSucesso, loc_oGlo, loc_oErro
4010:         loc_lSucesso = .F.
4011: 
4012:         TRY
4013:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
4014:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
4015:             ELSE
4016:                 loc_oGlo = .NULL.
4017:                 IF VARTYPE(THIS.this_oFormPai) = "O" AND PEMSTATUS(THIS.this_oFormPai, "this_oParentForm", 5)
4018:                     IF VARTYPE(THIS.this_oFormPai.this_oParentForm) = "O"
4019:                         loc_oGlo = THIS.this_oFormPai.this_oParentForm
4020:                     ENDIF
4021:                 ENDIF
4022: 
4023:                 IF VARTYPE(loc_oGlo) = "O" AND PEMSTATUS(loc_oGlo, "cnt_4c_Previsao", 5)
4024:                     THIS.this_oBusinessObject.this_dPrevisao    = ;
4025:                         ConverterParaData(loc_oGlo.cnt_4c_Previsao.txt_4c_Previsao.Value)
4026:                     THIS.this_oBusinessObject.this_dDataGeracao = ;
4027:                         ConverterParaData(loc_oGlo.cnt_4c_Previsao.txt_4c_Geracao.Value)
4028:                 ELSE
4029:                     *-- Sem o form avo (ex.: teste direto desta tela), usa a
4030:                     *-- data de hoje para ambos - nunca deixa {} (gravaria
4031:                     *-- a O.P. com data em branco)
4032:                     THIS.this_oBusinessObject.this_dPrevisao    = DATE()
4033:                     THIS.this_oBusinessObject.this_dDataGeracao = DATE()
4034:                 ENDIF
4035: 
4036:                 loc_lSucesso = .T.
4037:             ENDIF
4038:         CATCH TO loc_oErro
4039:             MsgErro(loc_oErro.Message + CHR(13) + ;
4040:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4041:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
4042:         ENDTRY
4043: 
4044:         RETURN loc_lSucesso
4045:     ENDFUNC
4046: 
4047:     *--------------------------------------------------------------------------
4048:     * BtnProcessarClick - "Processar" da Page1 (dump 4562-6466). So
4049:     * ORQUESTRA: repassa ao BO os parametros que o Init legado lia do form
4050:     * avo (FormParaBO) e delega toda a gravacao a SigPrGlxBO.Processar().
4051:     * "Do Form SigReGli" do fecho legado NAO foi migrado - mostra o numero
4052:     * da O.P. via MsgInfo e fecha esta tela, mesmo padrao de
4053:     * FormSigPrGlp.BtnProcessarClick.
4054:     *--------------------------------------------------------------------------
4055:     PROCEDURE BtnProcessarClick()
4056:         LOCAL loc_lSucesso, loc_lFechar, loc_oErro
4057:         loc_lFechar = .F.
4058: 
4059:         TRY
4060:             IF !USED("TmpFinalg") OR RECCOUNT("TmpFinalg") = 0
4061:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens para processar.", "Aten" + CHR(231) + CHR(227) + "o")
4062:             ELSE
4063:                 IF THIS.FormParaBO()
4064:                     THIS.pgf_4c_1.Page1.cmd_4c_Processar.Enabled    = .F.
4065:                     THIS.pgf_4c_1.Page1.cmd_4c_SelEstoque.Enabled   = .F.
4066:                     THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Enabled   = .F.
4067:                     THIS.pgf_4c_1.Page1.cmd_4c_TotLinha.Enabled     = .F.
4068: 
4069:                     loc_lSucesso = THIS.this_oBusinessObject.Processar()
4070: 
4071:                     IF loc_lSucesso
4072:                         MsgInfo("Processamento efetuado com sucesso!" + CHR(13) + ;
4073:                             "O.P. " + TRANSFORM(THIS.this_oBusinessObject.this_nNumeroOpGerada) + ;
4074:                             " gerada.", "Confirmar")
4075:                         loc_lFechar = .T.
4076:                     ELSE
4077:                         THIS.pgf_4c_1.Page1.cmd_4c_Processar.Enabled  = .T.
4078:                         THIS.pgf_4c_1.Page1.cmd_4c_SelEstoque.Enabled = THIS.this_lPermiteAjustarPrioridade()
4079:                         THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Enabled = .T.
4080:                         THIS.pgf_4c_1.Page1.cmd_4c_TotLinha.Enabled   = .T.
4081: 
4082:                         IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
4083:                             MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Processar")
4084:                         ENDIF
4085:                     ENDIF
4086:                 ENDIF
4087:             ENDIF
4088:         CATCH TO loc_oErro
4089:             MsgErro(loc_oErro.Message + CHR(13) + ;
4090:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4091:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
4092:         ENDTRY
4093: 
4094:         IF loc_lFechar
4095:             THIS.Release()
4096:         ENDIF
4097:     ENDPROC
4098: 
4099:     *--------------------------------------------------------------------------
4100:     * Destroy - reabilita o form pai (padrao do Cancelar.Click legado: a
4101:     * previa eh modeless-sobre-pai, nao modal de verdade, entao quem fecha
4102:     * precisa devolver o Enabled do pai manualmente).
4103:     *--------------------------------------------------------------------------
4104:     PROCEDURE Destroy()
4105:         IF VARTYPE(THIS.this_oFormPai) = "O"
4106:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
4107:                 THIS.this_oFormPai.Enabled = .T.
4108:             ENDIF
4109:         ENDIF
4110: 
4111:         DODEFAULT()
4112:     ENDPROC
4113: 
4114: ENDDEFINE

