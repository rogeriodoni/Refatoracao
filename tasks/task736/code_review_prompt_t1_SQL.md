# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DATAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IF, LNI, _RECANT, WBANCO, WAGENC, WNUNCH, BANCOS, AGENCIAS, NCHEQUES, TIPOS, OP_ESCOLHA, ALTCOTS, LEITURA, NCONTAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VALUE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IF, LNI, _RECANT, WBANCO, WAGENC, WNUNCH, BANCOS, AGENCIAS, NCHEQUES, TIPOS, OP_ESCOLHA, ALTCOTS, LEITURA, NCONTAS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  ControlSource = "xpar.nocreditos"
  ControlSource = "xpar.cartaos"
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crSigChLcq.ValTots"
  ControlSource = "xPar.Obs"
  ControlSource = ""
  ControlSource = ""
  ControlSource = "xpar.nocreditos"
  ControlSource = "xpar.cartaos"
  ControlSource = "xpar.ncarnes"
  ControlSource = "xpar.outros"
  ControlSource = "xpar.numeros"
  ControlSource = "xpar.contas"
  ControlSource = "xpar.agencias"
  ControlSource = "xpar.bancos"
  ControlSource = ""
Select CrSigOpFp
select xpar
		select xpar
	lcwhere = [Select * From SigChe Where Bancos=?lcBanco And Agencias=?lcAGenc And ]+;
	lnErro = ThisForm.Parentform.PoDataMgr.SqlExecute(lcwhere,'CrCheque')
		Select CrCheque
	     	select xpar
	     	If Not Seek(wbanco+wagenc+wconta+wnunch,'TempChq','Cheque')
select xpar
	.fpagto.controlsource='xPar.FPags'
	.Valor.controlsource='xPar.Valos'
	.venc.controlsource='xPar.vencs'
	.moeda.controlsource='xPar.moefpgs'
	.cotfpg.controlsource='xPar.cotfpgs'
=Seek( Padr( Alltrim( Usuar ), 10 ), 'crUsuario', 'Usuarios' )
ThisForm.AlteraCotacao.Visible = ( ( !Seek( crUsuario.Ccargs, 'crSigCdCrg', 'Ccargs' ) Or crSigCdCrg.AltCots # 'S' ) And ;
Select xPar
	=Seek( FPags, 'crSigOpFp', 'FPags' )
Select * From crSigSyCom Where Tipos = 'Leitora Cheques' Into Cursor CrCfcom
Select CrCfCom
	Select CrCfCom
Select * From crSigOpFp Where &vCond. Into Cursor csSigOpFp
Select xPar
		If !Seek( This.Value, 'csSigOpFp', 'FPagsGru' )
				=Seek( This.Value, 'CrSigOpFp', 'FPags' )
			=Seek( This.Value, 'crSigOpFp', 'FPags' )
			=Seek( CrSigOpFp.Moefpgs, 'crSigCdMoe', 'CMoes' )
			=Seek( Padr( Alltrim( Usuar ), 10 ), 'crUsuario', 'Usuarios' )
			llCota = ( ( !Seek( CrUsuario.Ccargs, 'crSigCdCrg', 'Ccargs' ) Or crSigCdCrg.AltCots # 'S' ) And Inlist( ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR' ) And crSigCdMoe.Cotas )
	Select xPar
		=Seek( xPar.FPags, 'CrSigOpFp', 'FPags' )
	Select xPar
=Seek( ThisForm.Get_fpg.Value, 'CrSigOpFp', 'FPags' )
Select xPar
	Select crSigCdFer
	Select xPar
 			Select xPar
	 		Select xPar
Select xPar
=Seek( Padr( Alltrim( Usuar ), 10 ), 'crUsuario', 'Usuarios' )
=Seek( CrSigOpFp.Moefpgs, 'crSigCdMoe', 'CMoes' )
Return( Seek( crUsuario.Ccargs, 'crSigCdCrg', 'Ccargs' ) And crSigCdCrg.AltCots = 'S' And Inlist( ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR' ) And crSigCdMoe.Cotas )
Select xPar
Select xPar
	Select xPar
	Select xPar

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpFpg.prg) - TRECHOS RELEVANTES PARA PASS SQL (4750 linhas total):

*-- Linhas 37 a 67:
37: * ficam em Top=3, dentro da faixa de Top=0..80). Os demais campos de xPar
38: * (bancos/agencias/contas/numeros/cartaos/nocreditos/ncarnes/outros/obs), que
39: * so os paineis flutuantes da Fase 6 usam, entram quando essa fase ampliar a
40: * mesma CREATE CURSOR (nao criar um segundo cursor_4c_Dados em outro lugar -
41: * regra de forms OPERACIONAIS: mesmo cursor, mesma ordem de campos sempre).
42: *
43: * Junto com a grade vem o FUNIL de carga/repintura - CarregarDados() - que
44: * transcreve o que o Init legado faz com a grade:
45: *
46: *   With ThisForm.Grade                     -> VincularGrade()
47: *       .RecordSource='xPar'
48: *       .fpagto.controlsource='xPar.FPags'
49: *       ... (5 colunas)
50: *       .refresh
51: *   EndWith
52: *   Select xPar / Go Top                    -> SELECT (cursor) + GO TOP
53: *
54: * O vinculo fica num metodo PROPRIO (VincularGrade) porque CarregarDados tem
55: * de poder REFAZE-LO: re-atribuir RecordSource reseta Column.Width,
56: * Column.Header1.Caption e a fonte das colunas (Problema 48 / regra #41), e
57: * cada caminho que popula o cursor precisa fechar com GO TOP + Refresh, senao
58: * a grade fica visualmente vazia com o cursor cheio (regra #21). Os pontos que
59: * alteram xPar no legado (Apaga.Click com Zap, Valor.Valid, fweditdata_Venc.
60: * Valid que gera as parcelas) chamam este mesmo funil nas fases de eventos.
61: *
62: * AjustarBotoesPorModo() reproduz a ULTIMA linha de botao do Init legado -
63: * `ThisForm.Apaga.Visible = Inlist(Op_Escolha,'INSERIR','ALTERAR')` - e roda
64: * DEPOIS de TornarControlesVisiveis, que forca Visible=.T. em tudo e apagaria
65: * a regra. O bloco que mexia em Ok.Left/Ok.Cancel/Cancela por llAltDireta esta
66: * COMENTADO (`*!*`) no SCX legado e por isso nao eh transcrito.
67: *

*-- Linhas 118 a 148:
118: * uma transcrita do dump:
119: *
120: *   PROCEDURE mostraobs    -> MostrarObservacao (+ CarregarInfoFormaPagamento,
121: *                             que substitui o `Seek` em CrSigOpFp por SELECT
122: *                             em SigOpFp - este dialogo tem DataSession = 2 e
123: *                             nao alcanca os cursores da sessao do pai)
124: *   PROCEDURE mcartaocred  -> CartaoCredito
125: *   PROCEDURE return       -> FecharDialogo (fonte unica dos dois caminhos de
126: *                             saida, com this_lConfirmado dizendo ao form pai
127: *                             se o usuario confirmou ou cancelou)
128: *
129: * FASE 8/8 (ESTA FASE): eventos dos CAMPOS e a transferencia com o form pai -
130: * calculo de parcelas/encargo e o bloco de cotacao/cambio do Valid de
131: * Get_vpar/GetPorc/fweditdata_venc (CarregarCambio/MoedaPermiteCotacao/
132: * CargoTemAltCots substituem crSigCdMoe/crUsuario/crSigCdCrg - cursores
133: * globais do login legado, inexistentes aqui, por SQLEXEC direto), o leitor
134: * serial de cheques (InChequeSerial/VerificaCheque/LimpaChe - ReadComm OLE
135: * nao existe nesta arquitetura, degrada para digitacao manual, mesmo padrao
136: * de Formsigopcim.PrepararLeitoraParaFoco), DefinirDadosTitulo (API publica
137: * para o form pai informar data de entrada/valor total/empresa do titulo -
138: * substitui a leitura direta de crSigChLcq, que este dialogo com DataSession
139: * propria nao alcanca) e as validacoes de venc < data de entrada, digitos do
140: * cheque e numero do cartao de credito. As celulas de Valor/Vencimento da
141: * grade (Column2/Column3) ganharam classes TextBox proprias (regra #46 -
142: * TextBoxCelulaValorFpg/TextBoxCelulaVencFpg, declaradas antes desta
143: * DEFINE CLASS) porque a validacao delas mora no Valid da CELULA, nao em
144: * AfterRowColChange nem em BINDEVENT de Valid.
145: *
146: * Herda de: FormBase
147: *==============================================================================
148: 

*-- Linhas 344 a 368:
344:         *-- FASE 8/8: leitora de cheques (SigSyCom) + campos dependentes do
345:         *-- estado "sem forma de pagamento escolhida" (comeca assim) +
346:         *-- Credito espelho (this_lCarAuts comeca .F.) - tudo ANTES do
347:         *-- `Select xPar / Go Top` final, igual ao Init legado.
348:         THIS.ResolverTipoLeitora()
349:         THIS.ResolverMoedaOperacao()
350:         THIS.AtualizarCamposPorFormaPagamento()
351:         THIS.AtualizarEnabledCreditoFp()
352: 
353:         *-- `Select xPar / Go Top` do fim do Init legado + o `.refresh` da
354:         *-- grade. Depois do TornarControlesVisiveis de proposito: Refresh em
355:         *-- controle ainda invisivel nao pinta (regra #21).
356:         THIS.CarregarDados()
357:     ENDPROC
358: 
359:     *--------------------------------------------------------------------------
360:     * ConfigurarCabecalho - Faixa cinza do topo (cntSombra no legado)
361:     *--------------------------------------------------------------------------
362:     PROTECTED PROCEDURE ConfigurarCabecalho()
363:         THIS.AddObject("cnt_4c_Sombra", "Container")
364:         WITH THIS.cnt_4c_Sombra
365:             .Top         = 0
366:             .Left        = 0
367:             .Width       = THIS.Width
368:             .Height      = 80

*-- Linhas 459 a 477:
459:     * (Base: textbox): o que o dump nao declara vem do default Tahoma 8,
460:     * Alignment = 3 (automatico) exceto onde o dump marca Alignment = 3
461:     * explicito (os campos monetarios) ou nao marca nada (Get_fpg/Get_npar,
462:     * que ficam no default 0/esquerda do TextBox). ControlSource fica VAZIO
463:     * (igual ao dump) - o trafego de valores destes campos com a grade/cursor
464:     * e com os cursores do form pai (CrSigOpFp/crSigChLcq/crSigCdPam) eh
465:     * assunto das Fases 7/8 (eventos), nao desta fase de puro layout.
466:     *
467:     * Get_MoeOcr e Get_npar OCUPAM O MESMO Left/Top no dump (181,148) - nao eh
468:     * erro de transcricao: Get_MoeOcr.When sempre retorna .F. (campo nunca
469:     * recebe foco, soh exibicao) e o legado alterna qual dos dois aparece
470:     * conforme a forma de pagamento escolhida (Cheque mostra moeda no lugar de
471:     * parcelas). A alternancia de Visible fica para a Fase 8 - aqui os dois
472:     * sao criados nas coordenadas exatas do SCX.
473:     *
474:     * Get_COTACAO/cmd_4c_Alteracotacao e GetObs/lbl_4c_Obs nascem Visible=.F.
475:     * (dump) - permanecem assim: TornarControlesVisiveis so forca Visible=.T.
476:     * em controles que ja estao .T., preservando os .F. explicitos aplicados
477:     * DEPOIS dele (igual ao padrao de AjustarBotoesPorModo/cmd_4c_Apaga).

*-- Linhas 959 a 980:
959:     * ConfigurarGrade - Grade de formas de pagamento (Grade/xPar do legado).
960:     * cursor_4c_Dados eh o equivalente local a xPar - cursor PRIVADO desta
961:     * datasession (THIS.DataSession = 2), nunca compartilhado com o form pai.
962:     * Campos na mesma ordem/tipo usados nos ControlSource do SCX legado
963:     * (.fpagto.controlsource='xPar.FPags' / .Valor.controlsource='xPar.Valos'
964:     * / .venc.controlsource='xPar.vencs' / .moeda.controlsource=
965:     * 'xPar.moefpgs' / .cotfpg.controlsource='xPar.cotfpgs').
966:     *
967:     * Aqui ficam apenas as propriedades do GRID que nao dependem de dado
968:     * (geometria, marcas, scroll, TabIndex). O vinculo ao cursor e tudo o que
969:     * mora nas Columns sai em VincularGrade(), porque CarregarDados() tem de
970:     * poder refazer o vinculo e re-atribuir RecordSource reseta Width, fonte e
971:     * Header1.Caption das colunas (Problema 48 / regra #41).
972:     *
973:     * .ReadOnly = .F. do GRID fica ANTES da chamada a VincularGrade: o ReadOnly
974:     * do grid propaga para as colunas e sobrescreveria o Column1.ReadOnly = .T.
975:     * do legado se viesse depois (regra #18).
976:     *--------------------------------------------------------------------------
977:     PROTECTED PROCEDURE ConfigurarGrade()
978:         THIS.GarantirCursorDados()
979: 
980:         THIS.AddObject("grd_4c_Dados", "Grid")

*-- Linhas 990 a 1031:
990:             *-- estabelece quando todos os controles do form existirem.
991:             .TabIndex   = 10
992:             .ReadOnly   = .F.
993:             .DeleteMark = .F.
994:             .RecordMark = .F.
995:             .ScrollBars = 2
996:         ENDWITH
997: 
998:         THIS.VincularGrade()
999: 
1000:         *-- SIGOPFPG.Grade.AfterRowColChange do legado: `Thisform.mostraobs` +
1001:         *-- `ThisForm.GetObs.Refresh` a cada troca de linha/coluna - alterna os
1002:         *-- paineis flutuantes para a forma de pagamento da linha corrente
1003:         *-- (regra #46: AfterRowColChange SEM filtro de coluna, carregando o
1004:         *-- detalhe da linha, eh o uso CORRETO deste evento).
1005:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")
1006: 
1007:         THIS.grd_4c_Dados.Visible = .T.
1008:     ENDPROC
1009: 
1010:     *--------------------------------------------------------------------------
1011:     * GarantirCursorDados - Cria o cursor das linhas da grade (equivalente a
1012:     * xPar do legado) se ele ainda nao existir. UNICO ponto do form com a
1013:     * CREATE CURSOR, para que a lista e a ORDEM dos campos sejam sempre as
1014:     * mesmas (regra de forms OPERACIONAIS). Cursor PRIVADO desta datasession
1015:     * (THIS.DataSession = 2), populado pelos proprios eventos do dialogo - nao
1016:     * vem de SQLEXEC, por isso nao precisa de SET NULL ON.
1017:     *
1018:     * Os 5 campos sao exatamente os que o SCX legado liga as colunas
1019:     * (.fpagto='xPar.FPags' / .Valor='xPar.Valos' / .venc='xPar.vencs' /
1020:     * .moeda='xPar.moefpgs' / .cotfpg='xPar.cotfpgs'). Os campos de xPar que
1021:     * so os paineis flutuantes usam (bancos/agencias/contas/numeros/cartaos/
1022:     * nocreditos/ncarnes/outros/obs) sao acrescentados NESTA MESMA CREATE
1023:     * CURSOR quando esses paineis entrarem.
1024:     *--------------------------------------------------------------------------
1025:     PROTECTED PROCEDURE GarantirCursorDados()
1026:         LOCAL loc_cCursor
1027:         loc_cCursor = THIS.this_cCursorGrade
1028: 
1029:         IF !USED(loc_cCursor)
1030:             *-- Os 5 primeiros campos sao os que a grade usa (Fase 4). Os
1031:             *-- demais (Fase 6) sao de xPar usados so pelos paineis

*-- Linhas 1042 a 1073:
1042:             *-- grava em CADA linha, alem das 5 que a grade exibe - sao o
1043:             *-- contrato que este dialogo devolve ao form pai (Dcarts
1044:             *-- char(30) espelha SigOpFp.dcarts).
1045:             CREATE CURSOR (loc_cCursor) ;
1046:                 (FPags C(12), Valos N(14,2), Vencs D, MoeFpgs C(3), CotFpgs N(11,6), ;
1047:                  Bancos C(3), Agencias C(4), Contas C(10), Numeros C(6), ;
1048:                  Cartaos C(20), Nocreditos C(10), Ncarnes C(12), Outros C(60), ;
1049:                  Parcs N(3,0), Emps C(3), Datas D, Dcarts C(30), Cotusus C(20))
1050:         ENDIF
1051:     ENDPROC
1052: 
1053:     *--------------------------------------------------------------------------
1054:     * VincularGrade - Transcricao do bloco `With ThisForm.Grade ... EndWith` do
1055:     * Init legado: liga a grade ao cursor e configura as 5 colunas.
1056:     *
1057:     * Ordem obrigatoria (regra #41): ColumnCount -> RecordSource ->
1058:     * ControlSource -> fonte/InputMask/Width/ColumnOrder -> Header1.Caption.
1059:     * Largura e caption depois do RecordSource porque ele as reseta para o
1060:     * default; por isso este metodo eh reexecutavel e eh chamado tambem por
1061:     * CarregarDados.
1062:     *
1063:     * ColumnCount so eh reatribuido se estiver diferente de 5: qualquer
1064:     * atribuicao recria os objetos Column e destruiria controles postos por
1065:     * Column.AddObject (o TextBox de celula com lookup entra numa fase
1066:     * seguinte, e o rebind nao pode mata-lo).
1067:     *
1068:     * Larguras/ColumnOrder/InputMask/ReadOnly transcritos do dump do SCX
1069:     * (SIGOPFPG.Grade.Column1..5): a ordem VISUAL (ColumnOrder) difere da ordem
1070:     * interna das Columns - Vencimento (Column3) desenha por ULTIMO, depois de
1071:     * Moe/Cotacao (Column4/5) - por isso .ColumnOrder eh setado explicitamente
1072:     * nas colunas 3/4/5, igual ao legado. Text1 de cada coluna recebe
1073:     * BorderStyle/Margin/ForeColor/BackColor do dump.

*-- Linhas 1085 a 1108:
1085: 
1086:             .RecordSource = loc_cCursor
1087: 
1088:             *-- ControlSource das 5 colunas (bloco With ThisForm.Grade legado)
1089:             .Column1.ControlSource = loc_cCursor + ".FPags"
1090:             .Column2.ControlSource = loc_cCursor + ".Valos"
1091:             .Column3.ControlSource = loc_cCursor + ".Vencs"
1092:             .Column4.ControlSource = loc_cCursor + ".MoeFpgs"
1093:             .Column5.ControlSource = loc_cCursor + ".CotFpgs"
1094: 
1095:             *-- Fonte das colunas e do Text1 de cada celula
1096:             .Column1.FontName = "Courier New"
1097:             .Column2.FontName = "Courier New"
1098:             .Column3.FontName = "Courier New"
1099:             .Column4.FontName = "Courier New"
1100:             .Column5.FontName = "Courier New"
1101: 
1102:             *-- Mascaras de digitacao (Column2/Column5 no dump)
1103:             .Column2.InputMask = "999,999,999.99"
1104:             .Column5.InputMask = "999.9999"
1105: 
1106:             *-- Larguras DEPOIS do RecordSource (ele as reseta para o default)
1107:             .Column1.Width = 94
1108:             .Column2.Width = 108

*-- Linhas 1242 a 1285:
1242: 
1243:     *--------------------------------------------------------------------------
1244:     * CarregarDados - FUNIL de carga/repintura da grade de formas de pagamento.
1245:     * Transcreve o `.refresh` do bloco With ThisForm.Grade e o `Select xPar /
1246:     * Go Top` com que o Init legado termina.
1247:     *
1248:     * Metodo UNICO chamado por TODO caminho que mexe nas linhas da grade: a
1249:     * montagem inicial (ConfigurarEstruturaBase), e nas fases de eventos o
1250:     * Apaga (Select xPar / Zap), o Valor.Valid e o fweditdata_Venc.Valid que
1251:     * gera as parcelas. Sem o GO TOP + Refresh a grade fica visualmente vazia
1252:     * com o cursor cheio e o sintoma parece falha de consulta (regra #21).
1253:     *
1254:     * Metodo PUBLIC: eh chamado de fora da classe pelo harness de teste
1255:     * automatico (regra #3) e pelos handlers das fases seguintes.
1256:     *
1257:     * RETURN unico, FORA do TRY/CATCH, com flag (regra #1).
1258:     *--------------------------------------------------------------------------
1259:     PROCEDURE CarregarDados()
1260:         LOCAL loc_lSucesso, loc_cCursor, loc_oErro
1261:         loc_lSucesso = .F.
1262:         loc_cCursor  = THIS.this_cCursorGrade
1263: 
1264:         TRY
1265:             *-- Garante cursor + vinculo: o rebind reaplica largura, fonte e
1266:             *-- caption, que o RecordSource reseta
1267:             THIS.VincularGrade()
1268: 
1269:             *-- `Select xPar / Go Top` do fim do Init legado
1270:             SELECT (loc_cCursor)
1271:             GO TOP
1272: 
1273:             *-- `.refresh` do bloco With ThisForm.Grade legado
1274:             THIS.grd_4c_Dados.Refresh()
1275: 
1276:             loc_lSucesso = .T.
1277:         CATCH TO loc_oErro
1278:             MsgErro(loc_oErro.Message + CHR(13) + ;
1279:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1280:                 "Procedure: " + loc_oErro.Procedure, ;
1281:                 "Erro ao carregar formas de pagamento")
1282:             loc_lSucesso = .F.
1283:         ENDTRY
1284: 
1285:         RETURN loc_lSucesso

*-- Linhas 1420 a 1439:
1420:     * TornarControlesVisiveis() (lista de nomes CNT_4C_*).
1421:     *
1422:     * Propriedades e posicoes (Top/Left/Width/Height, fontes, InputMask,
1423:     * ControlSource de xPar) transcritas do dump do SCX (SIGOPFPG.CntCCred /
1424:     * CntCCredFP / CntCarneFP / CntOutrosFP / CntChequeFP). ControlSource
1425:     * fica VAZIO aqui (igual as demais fases de puro layout) - o trafego com
1426:     * cursor_4c_Dados (equivalente a xPar) eh assunto da Fase 8.
1427:     *
1428:     * CntCCred e CntCCredFP tem os MESMOS dois campos (cartao/credito) -
1429:     * CntCCred eh o painel visivel ao usuario (mCartaoCred alterna Visible +
1430:     * desabilita o resto do form) e CntCCredFP eh o espelho que o legado
1431:     * mantem sempre presente para o SQL/replace de xPar (mLeDados/Ok.Click
1432:     * leem de CntCCredFP, nao de CntCCred - ver comportamento.json). Nomes
1433:     * de objeto distintos por painel (nunca reusar o mesmo AddObject em dois
1434:     * containers - regra de colisao de nomes).
1435:     *--------------------------------------------------------------------------
1436:     PROTECTED PROCEDURE ConfigurarPaineisFlutuantes()
1437: 
1438:         *-- CntCCred - cartao de credito (painel que o usuario VE) ----------
1439:         THIS.AddObject("cnt_4c_CCred", "Container")

*-- Linhas 1583 a 1605:
1583: 
1584:         THIS.cnt_4c_CCredFP.AddObject("txt_4c_CartaoFp", "TextBox")
1585:         WITH THIS.cnt_4c_CCredFP.txt_4c_CartaoFp
1586:             *-- Espelho de xPar.cartaos - ControlSource acompanha a linha
1587:             *-- corrente da grade, igual ao .refresh do legado depois de
1588:             *-- `Replace cartaos With ...` (regra: so funciona porque o
1589:             *-- controle esta LIGADO ao cursor, nao ao valor solto)
1590:             .ControlSource = THIS.this_cCursorGrade + ".Cartaos"
1591:             .FontName  = "Tahoma"
1592:             .InputMask = "99999999999999999999"
1593:             .Left      = 47
1594:             .Top       = 8
1595:             .Width     = 150
1596:             .Height    = 23
1597:             .ForeColor = RGB(0, 0, 0)
1598:             .TabIndex  = 17
1599:             *-- Get_cartao.When legado: INLIST(op_escolha,...) AND
1600:             *-- carauts#'S' - refinado por AtualizarEnabledCreditoFp quando a
1601:             *-- forma de pagamento eh escolhida
1602:             .Enabled   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
1603:             .Visible   = .T.
1604:         ENDWITH
1605: 

*-- Linhas 1622 a 1640:
1622:         THIS.cnt_4c_CCredFP.AddObject("txt_4c_CredFp", "TextBox")
1623:         WITH THIS.cnt_4c_CCredFP.txt_4c_CredFp
1624:             *-- Espelho de xPar.nocreditos (ver comentario de txt_4c_CartaoFp)
1625:             .ControlSource = THIS.this_cCursorGrade + ".Nocreditos"
1626:             .FontName  = "Tahoma"
1627:             .InputMask = "XXXXXXXXXX"
1628:             .Left      = 253
1629:             .Top       = 8
1630:             .Width     = 80
1631:             .Height    = 23
1632:             .ForeColor = RGB(0, 0, 0)
1633:             .TabIndex  = 18
1634:             *-- Get_cred.When legado: vazio se Cartao vazio, senao igual ao
1635:             *-- Get_cartao.When - comeca .F. (Cartao nasce vazio)
1636:             .Enabled   = .F.
1637:             .Visible   = .T.
1638:         ENDWITH
1639: 
1640:         *-- CntCarneFP - numero do carne ------------------------------------

*-- Linhas 1671 a 1689:
1671:             *-- Espelho de xPar.ncarnes, gerado por TxtFweditdataVencLostFocus
1672:             *-- (fGerUniqueKey) - Get_carne.When legado = Return(.F.), nunca
1673:             *-- digitado pelo usuario
1674:             .ControlSource = THIS.this_cCursorGrade + ".Ncarnes"
1675:             .FontName  = "Tahoma"
1676:             .Left      = 46
1677:             .Top       = 6
1678:             .Width     = 100
1679:             .Height    = 23
1680:             .ForeColor = RGB(0, 0, 0)
1681:             .TabIndex  = 20
1682:             .Enabled   = .F.
1683:             .Visible   = .T.
1684:         ENDWITH
1685: 
1686:         *-- CntOutrosFP - observacao livre ----------------------------------
1687:         THIS.AddObject("cnt_4c_OutrosFP", "Container")
1688:         WITH THIS.cnt_4c_OutrosFP
1689:             .Top           = 510

*-- Linhas 1715 a 1733:
1715:         THIS.cnt_4c_OutrosFP.AddObject("txt_4c_Outros", "TextBox")
1716:         WITH THIS.cnt_4c_OutrosFP.txt_4c_Outros
1717:             *-- Espelho de xPar.outros (observacao livre da forma "Outros")
1718:             .ControlSource = THIS.this_cCursorGrade + ".Outros"
1719:             .FontName  = "Tahoma"
1720:             .Left      = 73
1721:             .Top       = 7
1722:             .Width     = 150
1723:             .Height    = 23
1724:             .ForeColor = RGB(0, 0, 0)
1725:             .TabIndex  = 22
1726:             *-- Get_OBS.When legado: desabilitado so em CONSULTAR/EXCLUIR -
1727:             *-- mode fixo durante a vida do dialogo (resolvido uma vez aqui)
1728:             .Enabled   = !INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "CONSULTAR", "EXCLUIR")
1729:             .Visible   = .T.
1730:         ENDWITH
1731: 
1732:         *-- CntChequeFP - dados do cheque (Banco/Agencia/Conta/Numero) ------
1733:         THIS.AddObject("cnt_4c_ChequeFP", "Container")

*-- Linhas 1760 a 1780:
1760: 
1761:         THIS.cnt_4c_ChequeFP.AddObject("txt_4c_Bco", "TextBox")
1762:         WITH THIS.cnt_4c_ChequeFP.txt_4c_Bco
1763:             *-- Espelho de xPar.bancos - ControlSource acompanha a linha
1764:             *-- corrente da grade (ver comentario de txt_4c_CartaoFp)
1765:             .ControlSource = THIS.this_cCursorGrade + ".Bancos"
1766:             .FontName  = "Tahoma"
1767:             .MaxLength = 3
1768:             .Left      = 8
1769:             .Top       = 13
1770:             .Width     = 36
1771:             .Height    = 23
1772:             .ForeColor = RGB(0, 0, 0)
1773:             .TabIndex  = 24
1774:             *-- Get_bco.When legado: INLIST(op_escolha,'INSERIR','ALTERAR') -
1775:             *-- a ramificacao de leitora serial dentro do When eh so efeito
1776:             *-- colateral (aviso), replicado em TxtBcoGotFocus
1777:             .Enabled   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
1778:             .Visible   = .T.
1779:         ENDWITH
1780: 

*-- Linhas 1797 a 1815:
1797:         THIS.cnt_4c_ChequeFP.AddObject("txt_4c_Age", "TextBox")
1798:         WITH THIS.cnt_4c_ChequeFP.txt_4c_Age
1799:             *-- Espelho de xPar.agencias (ver comentario de txt_4c_Bco)
1800:             .ControlSource = THIS.this_cCursorGrade + ".Agencias"
1801:             .FontName  = "Tahoma"
1802:             .MaxLength = 4
1803:             .Left      = 45
1804:             .Top       = 13
1805:             .Width     = 38
1806:             .Height    = 23
1807:             .ForeColor = RGB(0, 0, 0)
1808:             .TabIndex  = 25
1809:             .Enabled   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
1810:             .Visible   = .T.
1811:         ENDWITH
1812: 
1813:         THIS.cnt_4c_ChequeFP.AddObject("lbl_4c_LabelConta", "Label")
1814:         WITH THIS.cnt_4c_ChequeFP.lbl_4c_LabelConta
1815:             .FontName  = "Tahoma"

*-- Linhas 1829 a 1847:
1829:         THIS.cnt_4c_ChequeFP.AddObject("txt_4c_Conta", "TextBox")
1830:         WITH THIS.cnt_4c_ChequeFP.txt_4c_Conta
1831:             *-- Espelho de xPar.contas (ver comentario de txt_4c_Bco)
1832:             .ControlSource = THIS.this_cCursorGrade + ".Contas"
1833:             .FontName  = "Tahoma"
1834:             .MaxLength = 10
1835:             .Left      = 85
1836:             .Top       = 13
1837:             .Width     = 80
1838:             .Height    = 23
1839:             .ForeColor = RGB(0, 0, 0)
1840:             .TabIndex  = 26
1841:             .Enabled   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
1842:             .Visible   = .T.
1843:         ENDWITH
1844: 
1845:         THIS.cnt_4c_ChequeFP.AddObject("lbl_4c_LabelNumero", "Label")
1846:         WITH THIS.cnt_4c_ChequeFP.lbl_4c_LabelNumero
1847:             .FontName  = "Tahoma"

*-- Linhas 1861 a 1879:
1861:         THIS.cnt_4c_ChequeFP.AddObject("txt_4c_Num", "TextBox")
1862:         WITH THIS.cnt_4c_ChequeFP.txt_4c_Num
1863:             *-- Espelho de xPar.numeros (ver comentario de txt_4c_Bco)
1864:             .ControlSource = THIS.this_cCursorGrade + ".Numeros"
1865:             .FontName  = "Tahoma"
1866:             .MaxLength = 6
1867:             .Left      = 166
1868:             .Top       = 13
1869:             .Width     = 52
1870:             .Height    = 23
1871:             .ForeColor = RGB(0, 0, 0)
1872:             .TabIndex  = 27
1873:             .Enabled   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
1874:             .Visible   = .T.
1875:         ENDWITH
1876:     ENDPROC
1877: 
1878:     *==========================================================================
1879:     *  LOOKUP DA FORMA DE PAGAMENTO (Get_fpg do legado)

*-- Linhas 1909 a 1927:
1909:     *
1910:     *  Dois universos DIFERENTES, transcritos como dois metodos:
1911:     *
1912:     *    csSigOpFp (existencia + browse) - `Select * From crSigOpFp Where
1913:     *      Inlist(crSigOpFp.Situas,"A"," ","R")` + indice FILTRADO
1914:     *      `Index On Fpags Tag FPagsGru For !IsEmpty(grupods) .and.
1915:     *      !IsEmpty(contads)` -> ObterFiltroFormasValidas() /
1916:     *      ExisteFormaPagamentoValida().
1917:     *    crSigOpFp (leitura do registro escolhido) - cursor SEM filtro
1918:     *      nenhum -> AplicarFormaPagamento(), que por isso NAO repete o
1919:     *      filtro do browse.
1920:     *
1921:     *  crSigOpFp eh um cursor GLOBAL do Fortyus que nao existe na arquitetura
1922:     *  nova (o startup legado o pre-carregava no login), por isso os dois
1923:     *  metodos consultam a tabela SigOpFp direto no SQL Server. O filtro
1924:     *  transcrito eh EXATAMENTE o do dump - SigOpFp tem coluna `emps`, mas o
1925:     *  legado NAO filtra por empresa aqui e inventar esse filtro esconderia
1926:     *  formas de pagamento validas.
1927:     *==========================================================================

*-- Linhas 2141 a 2186:
2141:             IF CURSORGETPROP("Buffering", "cursor_4c_BuscaFpg") > 1
2142:                 TABLEREVERT(.T., "cursor_4c_BuscaFpg")
2143:             ENDIF
2144:             USE IN SELECT("cursor_4c_BuscaFpg")
2145:         ENDIF
2146: 
2147:         IF !EMPTY(loc_cCodigo)
2148:             THIS.AplicarFormaPagamento(loc_cCodigo)
2149:         ELSE
2150:             IF loc_lPickerMostrado
2151:                 *-- Legado: This.Value = Iif( Lastkey() == 27, '', ... ) - o
2152:                 *-- CANCELAMENTO EXPLICITO do browse limpa o campo (unico caso
2153:                 *-- em que o legado apaga o digitado - regra #50). Quando o
2154:                 *-- picker nem chegou a ser mostrado (erro de consulta), o que
2155:                 *-- o usuario digitou eh PRESERVADO.
2156:                 THIS.LimparFormaPagamento()
2157:             ENDIF
2158:         ENDIF
2159:     ENDPROC
2160: 
2161:     *--------------------------------------------------------------------------
2162:     * ObterFiltroFormasValidas - Fragmento WHERE que reproduz o universo do
2163:     * browse legado (csSigOpFp): `Inlist(crSigOpFp.Situas,"A"," ","R")` do
2164:     * SELECT mais o indice FILTRADO `For !IsEmpty(grupods) .and.
2165:     * !IsEmpty(contads)`, que no legado restringe o que o Seek/browse alcanca.
2166:     *
2167:     * FONTE UNICA do filtro: ExisteFormaPagamentoValida e AbrirLookupFpg leem
2168:     * daqui para o universo do teste de existencia e o do browse nunca
2169:     * divergirem (digitar um codigo que o browse nao lista, ou vice-versa).
2170:     * Sem prefixo de alias - o FormBuscaAuxiliar concatena este fragmento num
2171:     * SELECT sobre SigOpFp sem alias.
2172:     *--------------------------------------------------------------------------
2173:     FUNCTION ObterFiltroFormasValidas()
2174:         RETURN "situas IN ('A', ' ', 'R')" + ;
2175:                " AND RTRIM(grupods) <> ''" + ;
2176:                " AND RTRIM(contads) <> ''"
2177:     ENDFUNC
2178: 
2179:     *--------------------------------------------------------------------------
2180:     * ExisteFormaPagamentoValida - Equivalente a
2181:     * `Seek( This.Value, 'csSigOpFp', 'FPagsGru' )`: diz se o codigo digitado
2182:     * esta no universo do browse. NAO aplica nada - quem le o registro eh
2183:     * AplicarFormaPagamento, sobre o cursor SEM filtro (crSigOpFp).
2184:     *
2185:     * Falha de consulta deixa a mensagem em this_cMensagemErro para o chamador
2186:     * nao abrir o picker em seguida e repetir o mesmo erro.

*-- Linhas 2203 a 2251:
2203:                 IF CURSORGETPROP("Buffering", "cursor_4c_ChkFpg") > 1
2204:                     TABLEREVERT(.T., "cursor_4c_ChkFpg")
2205:                 ENDIF
2206:                 USE IN SELECT("cursor_4c_ChkFpg")
2207:             ENDIF
2208: 
2209:             loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigOpFp" + ;
2210:                        " WHERE RTRIM(fpags) = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
2211:                        " AND " + THIS.ObterFiltroFormasValidas()
2212: 
2213:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkFpg")
2214: 
2215:             IF loc_nResultado < 0
2216:                 THIS.this_cMensagemErro = CapturarErroSQL()
2217:                 MsgErro("Erro ao consultar a forma de pagamento." + CHR(13) + ;
2218:                     THIS.this_cMensagemErro, "Erro SQL")
2219:             ELSE
2220:                 IF USED("cursor_4c_ChkFpg")
2221:                     SELECT cursor_4c_ChkFpg
2222:                     IF !EOF("cursor_4c_ChkFpg")
2223:                         loc_lExiste = (NVL(cursor_4c_ChkFpg.nExiste, 0) > 0)
2224:                     ENDIF
2225:                 ENDIF
2226:             ENDIF
2227:         CATCH TO loc_oErro
2228:             THIS.this_cMensagemErro = loc_oErro.Message
2229:             MsgErro(loc_oErro.Message + CHR(13) + ;
2230:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2231:                 "Procedure: " + loc_oErro.Procedure, ;
2232:                 "Erro ao consultar Forma de Pagamento")
2233:         ENDTRY
2234: 
2235:         IF USED("cursor_4c_ChkFpg")
2236:             USE IN SELECT("cursor_4c_ChkFpg")
2237:         ENDIF
2238: 
2239:         RETURN loc_lExiste
2240:     ENDFUNC
2241: 
2242:     *--------------------------------------------------------------------------
2243:     * AplicarFormaPagamento - Transcricao do bloco que o Valid legado executa
2244:     * depois de resolver o codigo:
2245:     *
2246:     *     =Seek( This.Value, 'crSigOpFp', 'FPags' )
2247:     *     ThisForm.Get_Fpg.Value      = CrSigOpFp.FPags
2248:     *     ThisForm.Get_NPar.Value     = CrSigOpFp.FParcs
2249:     *     ThisForm.Digpar             = IsEmpty( CrSigOpFp.FParcs )
2250:     *     ThisForm.Get_PEncargo.Value = CrSigOpFp.Encargos
2251:     *

*-- Linhas 2280 a 2315:
2280:                 IF CURSORGETPROP("Buffering", "cursor_4c_FpgSel") > 1
2281:                     TABLEREVERT(.T., "cursor_4c_FpgSel")
2282:                 ENDIF
2283:                 USE IN SELECT("cursor_4c_FpgSel")
2284:             ENDIF
2285: 
2286:             loc_cSQL = "SELECT fpags, fparcs, encargos, moefpgs," + ;
2287:                        " descrs, infos, obs, carauts, trocos," + ;
2288:                        " entradas, dias, tvens, dcarts" + ;
2289:                        " FROM SigOpFp" + ;
2290:                        " WHERE RTRIM(fpags) = " + EscaparSQL(ALLTRIM(par_cCodigo))
2291: 
2292:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpgSel")
2293: 
2294:             IF loc_nResultado < 0
2295:                 THIS.this_cMensagemErro = CapturarErroSQL()
2296:                 MsgErro("Erro ao carregar a forma de pagamento." + CHR(13) + ;
2297:                     THIS.this_cMensagemErro, "Erro SQL")
2298:             ELSE
2299:                 IF USED("cursor_4c_FpgSel")
2300:                     SELECT cursor_4c_FpgSel
2301:                     IF !EOF("cursor_4c_FpgSel")
2302:                         *-- numeric(2,0): chega SEMPRE numerico. IsEmpty(0) do
2303:                         *-- legado eh .T., logo Digpar = (parcelas = 0) -
2304:                         *-- "nao tem numero fixo de parcelas, o usuario digita".
2305:                         loc_nParcelas = NVL(cursor_4c_FpgSel.fparcs, 0)
2306: 
2307:                         THIS.txt_4c_Fpg.Value      = ALLTRIM(NVL(cursor_4c_FpgSel.fpags, ""))
2308:                         THIS.txt_4c_Npar.Value     = loc_nParcelas
2309:                         THIS.txt_4c_PEncargo.Value = NVL(cursor_4c_FpgSel.encargos, 0)
2310:                         THIS.this_lDigpar          = (loc_nParcelas = 0)
2311: 
2312:                         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2313:                             THIS.this_oBusinessObject.this_cFPags    = ALLTRIM(NVL(cursor_4c_FpgSel.fpags, ""))
2314:                             THIS.this_oBusinessObject.this_nNPar     = loc_nParcelas
2315:                             THIS.this_oBusinessObject.this_nPEncargo = NVL(cursor_4c_FpgSel.encargos, 0)

*-- Linhas 2381 a 2399:
2381:         ENDTRY
2382: 
2383:         IF USED("cursor_4c_FpgSel")
2384:             USE IN SELECT("cursor_4c_FpgSel")
2385:         ENDIF
2386: 
2387:         RETURN loc_lSucesso
2388:     ENDFUNC
2389: 
2390:     *--------------------------------------------------------------------------
2391:     * LimparFormaPagamento - Estado "sem forma de pagamento escolhida".
2392:     * Legado: `Thisform.get_npar.Value = 0` nos dois ramos Else do Valid, e
2393:     * `This.Value = ''` quando o browse eh cancelado com ESC. Metodo UNICO
2394:     * para os tres caminhos nao divergirem.
2395:     *--------------------------------------------------------------------------
2396:     PROTECTED PROCEDURE LimparFormaPagamento()
2397:         THIS.txt_4c_Fpg.Value  = ""
2398:         THIS.txt_4c_Npar.Value = 0
2399:         THIS.this_lDigpar      = .F.

*-- Linhas 2441 a 2507:
2441:     * CmdApagaClick - SIGOPFPG.Apaga.Click do legado:
2442:     *
2443:     *     If Inlist( ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR' )
2444:     *         Select xPar
2445:     *         Zap
2446:     *         With Thisform
2447:     *             .Get_TotForma.Value = 0
2448:     *             .Get_Fpg.Value = ''
2449:     *             .Get_NPar.Value = 0
2450:     *             .Get_VPar.Value = 0
2451:     *             .fweditdata_Venc.Value = {}
2452:     *             .Get_PEncargo.Value = 0
2453:     *             .Get_VEncargo.Value = 0
2454:     *             .Get_Cotacao.Value = 0
2455:     *         Endwith
2456:     *         ThisForm.MostraObs
2457:     *         ThisForm.Refresh
2458:     *         ThisForm.Grade.Refresh
2459:     *         ThisForm.Get_Fpg.SetFocus
2460:     *     Endif
2461:     *
2462:     * A guarda de modo eh a MESMA que AjustarBotoesPorModo usa para esconder o
2463:     * botao, e eh repetida aqui de proposito - o legado tambem a repete, porque
2464:     * ela vale para a ACAO e nao so para o visual (o modo do form pai pode ter
2465:     * mudado entre a abertura do dialogo e o clique).
2466:     *
2467:     * ZAP, nao USE IN + CREATE CURSOR: o ZAP apaga as linhas PRESERVANDO a
2468:     * estrutura e, com ela, o RecordSource/ControlSource da grade - fechar e
2469:     * recriar o alias deixaria a grade permanentemente vazia, sem erro e sem
2470:     * log. E SET SAFETY eh ESCOPADO POR DATA SESSION: dentro da sessao privada
2471:     * deste form (DataSession = 2) ele vale ON mesmo com o SET SAFETY OFF do
2472:     * main.prg, e sem desligar aqui o ZAP abre o dialogo "Zap ... Are you
2473:     * sure?" e CONGELA a tela (medido no VFP9).
2474:     *
2475:     * RETURN de guarda FORA do TRY (regra #1) e flag unica para o retorno.
2476:     *--------------------------------------------------------------------------
2477:     PROCEDURE CmdApagaClick()
2478:         LOCAL loc_cCursor, loc_cSafety, loc_lSucesso, loc_oErro
2479: 
2480:         *-- Guarda de modo do proprio Click legado
2481:         IF !INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
2482:             RETURN .F.
2483:         ENDIF
2484: 
2485:         loc_cCursor  = THIS.this_cCursorGrade
2486:         loc_lSucesso = .F.
2487: 
2488:         TRY
2489:             THIS.GarantirCursorDados()
2490: 
2491:             *-- `Select xPar / Zap`
2492:             SELECT (loc_cCursor)
2493:             loc_cSafety = SET("SAFETY")
2494:             SET SAFETY OFF
2495:             ZAP
2496:             IF loc_cSafety = "ON"
2497:                 SET SAFETY ON
2498:             ENDIF
2499: 
2500:             *-- Bloco `With Thisform ... EndWith`
2501:             THIS.txt_4c_TotForma.Value        = 0
2502:             THIS.txt_4c_Vpar.Value            = 0
2503:             THIS.txt_4c_Fweditdata_venc.Value = {}
2504:             THIS.txt_4c_PEncargo.Value        = 0
2505:             THIS.txt_4c_VEncargo.Value        = 0
2506:             THIS.txt_4c_COTACAO.Value         = 0
2507: 

*-- Linhas 2560 a 2593:
2560:     *
2561:     *     If Inlist( Thisform.op_escolha, 'INSERIR', 'ALTERAR' )
2562:     *         ** verifica se existe valor ou vencs em branco
2563:     *         Select xPar
2564:     *         Scan
2565:     *             If !IsEmpty(xPar.FPags) And IsEmpty(xPar.vencs)
2566:     *                 Messagebox( 'Vencimento Invalido !', 48, '' )
2567:     *                 Thisform.Grade.Venc.Setfocus
2568:     *                 Return 0
2569:     *             Endif
2570:     *         Endscan
2571:     *     Endif
2572:     *     ThisForm.Return
2573:     *
2574:     * A validacao SO roda em INSERIR/ALTERAR - em CONSULTAR/EXCLUIR o legado
2575:     * fecha direto, porque nada foi digitado.
2576:     *
2577:     * O `Return 0` do legado aborta o clique: o dialogo NAO fecha e o foco vai
2578:     * para a coluna Vencimento, que aqui eh a Column3 da grade (ControlSource
2579:     * <cursor>.Vencs - a ordem VISUAL dela eh a 5a, mas o objeto eh Column3).
2580:     * Por isso o registro corrente NAO eh restaurado quando a validacao recusa:
2581:     * o SCAN para na linha ofensora e eh exatamente essa linha que o usuario
2582:     * tem de corrigir. Passando a validacao, o registro de antes eh devolvido
2583:     * (o SCAN termina em EOF).
2584:     *
2585:     * O fechamento (`ThisForm.Return`) fica FORA do TRY: ele esconde o form, e
2586:     * dentro do bloco um erro posterior saltaria para o CATCH com o dialogo ja
2587:     * fechado (regra #29).
2588:     *--------------------------------------------------------------------------
2589:     PROCEDURE CmdOkClick()
2590:         LOCAL loc_cCursor, loc_nRecno, loc_lVencOk, loc_lFechar, loc_oErro
2591: 
2592:         loc_cCursor = THIS.this_cCursorGrade
2593:         loc_lVencOk = .T.

*-- Linhas 2601 a 2619:
2601:                         loc_nRecno = RECNO(loc_cCursor)
2602:                     ENDIF
2603: 
2604:                     SELECT (loc_cCursor)
2605:                     SCAN
2606:                         IF !EMPTY(EVALUATE(loc_cCursor + ".FPags")) AND ;
2607:                                 EMPTY(EVALUATE(loc_cCursor + ".Vencs"))
2608:                             loc_lVencOk = .F.
2609:                             EXIT
2610:                         ENDIF
2611:                     ENDSCAN
2612: 
2613:                     IF loc_lVencOk AND loc_nRecno > 0 AND ;
2614:                             loc_nRecno <= RECCOUNT(loc_cCursor)
2615:                         GO (loc_nRecno) IN (loc_cCursor)
2616:                     ENDIF
2617:                 ENDIF
2618:             ENDIF
2619: 

*-- Linhas 2678 a 2712:
2678:     * Fecha o painel de cartao de credito - que roda "modal sobre o form":
2679:     * enquanto esta aberto, todo o resto do dialogo fica Enabled = .F. - e
2680:     * devolve o foco a celula Valor da grade, que aqui eh a Column2
2681:     * (ControlSource <cursor>.Valos).
2682:     *--------------------------------------------------------------------------
2683:     PROCEDURE CmdConfirmaCartaoClick()
2684:         LOCAL loc_cCursor, loc_lSucesso, loc_oErro
2685: 
2686:         loc_cCursor  = THIS.this_cCursorGrade
2687:         loc_lSucesso = .F.
2688: 
2689:         TRY
2690:             *-- O painel CntCCredFP (sempre oculto ao usuario) eh o espelho que
2691:             *-- fweditdata_venc.Valid le para gravar Cartaos/Nocreditos na
2692:             *-- parcela (regra: CntCCred eh o que o usuario digita, CntCCredFP
2693:             *-- eh a copia que o gerador de parcelas consome - mesmo padrao do
2694:             *-- par Get_PVenda/Get_PVen do FormProduto, memoria
2695:             *-- "ParCtrlSrccompa"). Copiar ANTES de ocultar o painel - SO com
2696:             *-- linha corrente no cursor, pois os dois campos sao
2697:             *-- ControlSource da linha (sem registro, a atribuicao estoura).
2698:             IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0 AND !EOF(loc_cCursor)
2699:                 THIS.cnt_4c_CCredFP.txt_4c_CartaoFp.Value = THIS.cnt_4c_CCred.txt_4c_Cartao.Value
2700:                 THIS.cnt_4c_CCredFP.txt_4c_CredFp.Value   = THIS.cnt_4c_CCred.txt_4c_Cred.Value
2701:             ENDIF
2702: 
2703:             *-- `ThisForm.mCartaoCred( .F. )`
2704:             THIS.CartaoCredito(.F.)
2705: 
2706:             *-- `ThisForm.Grade.Valor.Text1.SetFocus`. Sem linha na grade nao
2707:             *-- ha celula para receber o foco, e SetFocus ali dispara erro
2708:             IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled ;
2709:                     AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
2710:                 THIS.grd_4c_Dados.Column2.SetFocus()
2711:             ENDIF
2712: 

*-- Linhas 2915 a 2975:
2915:     * CORRENTE da grade:
2916:     *
2917:     *     lcFPag = xPar.FPags
2918:     *     Select CrSigOpFp / Set Order To FPags / Seek lcFpag
2919:     *     lcInfo = CrSigOpFp.Infos
2920:     *     ThisForm.GetObs.Visible = ( CrSigOpFp.Obs = 1 )
2921:     *     ThisForm.SayObs.Visible = ( CrSigOpFp.Obs = 1 )
2922:     *     With Thisform.CntChequeFP
2923:     *         .Visible = (lcInfo == 'C')
2924:     *         If .Visible / .Get_Bco.Refresh / ... / EndIf
2925:     *     EndWith
2926:     *     Thisform.CntCarneFP.Visible  = (lcInfo == 'N')
2927:     *     Thisform.CntOutrosFP.Visible = (lcInfo == 'O')
2928:     *     With ThisForm.CntCCredFP
2929:     *         .Visible  = (lcInfo == 'T')
2930:     *         If .Visible / .Get_Cartao.Refresh / .Get_Cred.Refresh / EndIf
2931:     *     EndWith
2932:     *
2933:     * O codigo lido eh o da LINHA CORRENTE do cursor da grade (xPar.FPags), NAO
2934:     * o do campo Cond. Pagto do cabecalho: o usuario pode distribuir o titulo
2935:     * em varias formas e cada linha tem a sua, entao o painel que aparece eh o
2936:     * da linha onde ele esta.
2937:     *
2938:     * `Seek lcFpag` em CrSigOpFp vira CarregarInfoFormaPagamento (SELECT em
2939:     * SigOpFp): este dialogo tem DataSession = 2 e nao alcanca os cursores da
2940:     * sessao do form pai.
2941:     *
2942:     * Metodo PUBLIC: chamado pelos handlers de botao desta fase e alcancado de
2943:     * fora pelo harness de teste automatico (regra #3).
2944:     *--------------------------------------------------------------------------
2945:     PROCEDURE MostrarObservacao()
2946:         LOCAL loc_cCursor, loc_cFPag, loc_cInfo, loc_lObs
2947: 
2948:         loc_cCursor = THIS.this_cCursorGrade
2949:         loc_cFPag   = ""
2950: 
2951:         *-- `lcFPag = xPar.FPags` (linha corrente). Cursor vazio ou em EOF nao
2952:         *-- tem campo para ler - no legado isso equivale ao Seek que nao casa, e
2953:         *-- o efeito eh o mesmo: nenhum painel aparece
2954:         IF USED(loc_cCursor)
2955:             IF RECCOUNT(loc_cCursor) > 0 AND !EOF(loc_cCursor)
2956:                 loc_cFPag = ALLTRIM(NVL(EVALUATE(loc_cCursor + ".FPags"), ""))
2957:             ENDIF
2958:         ENDIF
2959: 
2960:         *-- `Select CrSigOpFp / Seek lcFpag / lcInfo = CrSigOpFp.Infos`
2961:         THIS.CarregarInfoFormaPagamento(loc_cFPag)
2962: 
2963:         loc_cInfo = ALLTRIM(UPPER(THIS.this_cInfoForma))
2964:         loc_lObs  = THIS.this_lObsForma
2965: 
2966:         *-- `ThisForm.GetObs.Visible = ( CrSigOpFp.Obs = 1 )` e o SayObs
2967:         THIS.obj_4c_GetObs.Visible = loc_lObs
2968:         THIS.lbl_4c_Obs.Visible    = loc_lObs
2969: 
2970:         *-- Cheque
2971:         THIS.cnt_4c_ChequeFP.Visible = (loc_cInfo == "C")
2972:         IF THIS.cnt_4c_ChequeFP.Visible
2973:             THIS.cnt_4c_ChequeFP.txt_4c_Bco.Refresh()
2974:             THIS.cnt_4c_ChequeFP.txt_4c_Age.Refresh()
2975:             THIS.cnt_4c_ChequeFP.txt_4c_Conta.Refresh()

*-- Linhas 2992 a 3010:
2992:     ENDPROC
2993: 
2994:     *--------------------------------------------------------------------------
2995:     * CarregarInfoFormaPagamento - `Select CrSigOpFp / Set Order To FPags /
2996:     * Seek lcFpag` do mostraobs legado: resolve as duas colunas de SigOpFp que
2997:     * decidem o que aparece na tela - `infos` (char(1): C = cheque, N = carne,
2998:     * O = outros, T = cartao de credito) e `obs` (numeric(1,0): 1 = a forma de
2999:     * pagamento pede observacao).
3000:     *
3001:     * Guarda o resultado em this_cInfoForma/this_lObsForma, as duas UNICAS
3002:     * fontes que MostrarObservacao consulta.
3003:     *
3004:     * Codigo vazio (grade sem linha) limpa as duas properties e devolve .F.,
3005:     * exatamente como o Seek que nao casa no legado.
3006:     *
3007:     * `obs` eh numeric(1,0) no schema, mas o mesmo valor pode chegar Logico ou
3008:     * Caractere conforme o driver ODBC - por isso o VARTYPE antes de comparar
3009:     * (comparar Logico com 1 estoura "Operator/operand type mismatch",
3010:     * regra #13).

*-- Linhas 3039 a 3071:
3039:                 IF CURSORGETPROP("Buffering", "cursor_4c_InfoFpg") > 1
3040:                     TABLEREVERT(.T., "cursor_4c_InfoFpg")
3041:                 ENDIF
3042:                 USE IN SELECT("cursor_4c_InfoFpg")
3043:             ENDIF
3044: 
3045:             loc_cSQL = "SELECT infos, obs FROM SigOpFp" + ;
3046:                        " WHERE RTRIM(fpags) = " + EscaparSQL(ALLTRIM(par_cCodigo))
3047: 
3048:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InfoFpg")
3049: 
3050:             IF loc_nResultado < 0
3051:                 THIS.this_cMensagemErro = CapturarErroSQL()
3052:                 MsgErro("Erro ao consultar a forma de pagamento." + CHR(13) + ;
3053:                     THIS.this_cMensagemErro, "Erro SQL")
3054:             ELSE
3055:                 IF USED("cursor_4c_InfoFpg")
3056:                     SELECT cursor_4c_InfoFpg
3057:                     IF !EOF("cursor_4c_InfoFpg")
3058:                         THIS.this_cInfoForma = ALLTRIM(NVL(cursor_4c_InfoFpg.infos, ""))
3059: 
3060:                         loc_xObs = NVL(cursor_4c_InfoFpg.obs, 0)
3061: 
3062:                         DO CASE
3063:                         CASE VARTYPE(loc_xObs) = "N"
3064:                             THIS.this_lObsForma = (loc_xObs = 1)
3065:                         CASE VARTYPE(loc_xObs) = "L"
3066:                             THIS.this_lObsForma = loc_xObs
3067:                         CASE VARTYPE(loc_xObs) = "C"
3068:                             THIS.this_lObsForma = INLIST(UPPER(ALLTRIM(loc_xObs)), "S", "1")
3069:                         OTHERWISE
3070:                             THIS.this_lObsForma = .F.
3071:                         ENDCASE

*-- Linhas 3084 a 3102:
3084:         ENDTRY
3085: 
3086:         IF USED("cursor_4c_InfoFpg")
3087:             USE IN SELECT("cursor_4c_InfoFpg")
3088:         ENDIF
3089: 
3090:         RETURN loc_lSucesso
3091:     ENDFUNC
3092: 
3093:     *--------------------------------------------------------------------------
3094:     * CartaoCredito - `PROCEDURE mcartaocred` do legado:
3095:     *
3096:     *     LParameters plVisible
3097:     *     With ThisForm
3098:     *         For lnI = 1 to .ControlCount
3099:     *             .Controls(lnI).Enabled = Iif(.Controls(lnI).Name=='CntCCred', ;
3100:     *                                          plVisible, Not plVisible)
3101:     *         EndFor
3102:     *         .CntCCred.Visible = plVisible

*-- Linhas 3222 a 3240:
3222:     * ResolverTipoLeitora - Transcricao do bloco do Init legado que le a
3223:     * configuracao de leitora de cheques:
3224:     *
3225:     *     Select * From crSigSyCom Where Tipos = 'Leitora Cheques' Into Cursor CrCfcom
3226:     *     TpLeChq = TpLeChqs / If IsEmpty(TpLeChq) / TpLeChq='T' / Endif
3227:     *     Thisform.TipoLeitora = TpLeChq
3228:     *     Thisform.AvisoPortaM/S/T.Visible conforme TpLeChq
3229:     *     If TpLeChq='S' / Thisform.ReadComm.Configura(...) / ... / Endif
3230:     *
3231:     * crSigSyCom era pre-carregado pelo fLerSettings legado; a tabela
3232:     * SigSyCom (mesma do form de configuracao FormSIGOPCPE) eh consultada
3233:     * direto. 'T' (teclado) eh o default do legado quando a configuracao
3234:     * esta vazia/ausente.
3235:     *
3236:     * ReadComm (controle OLE de porta serial) NAO existe nesta arquitetura
3237:     * (nenhuma classe o fornece - grep confirmado em todo o projeto). Com
3238:     * TipoLeitora = 'S' os handlers de Get_bco seguem o MESMO padrao
3239:     * defensivo ja usado em Formsigopcim.prg (PrepararLeitoraParaFoco):
3240:     * testam PEMSTATUS + VARTYPE(...)="O" antes de tocar em ReadComm, e caem

*-- Linhas 3249 a 3289:
3249: 
3250:         TRY
3251:             IF USED("cursor_4c_SyCom")
3252:                 USE IN SELECT("cursor_4c_SyCom")
3253:             ENDIF
3254: 
3255:             loc_cSQL = "SELECT TOP 1 tplechqs FROM SigSyCom WHERE RTRIM(tipos) = " + ;
3256:                 EscaparSQL("Leitora Cheques")
3257: 
3258:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SyCom")
3259: 
3260:             IF loc_nResultado > 0 AND USED("cursor_4c_SyCom")
3261:                 SELECT cursor_4c_SyCom
3262:                 IF !EOF("cursor_4c_SyCom")
3263:                     loc_cTipo = ALLTRIM(NVL(cursor_4c_SyCom.tplechqs, ""))
3264:                     IF EMPTY(loc_cTipo)
3265:                         loc_cTipo = "T"
3266:                     ENDIF
3267:                 ENDIF
3268:             ENDIF
3269:         CATCH TO loc_oErro
3270:             loc_cTipo = "T"
3271:         ENDTRY
3272: 
3273:         IF USED("cursor_4c_SyCom")
3274:             USE IN SELECT("cursor_4c_SyCom")
3275:         ENDIF
3276: 
3277:         THIS.this_cTipoLeitora   = loc_cTipo
3278:         THIS.this_cLeituraSerial = ""
3279: 
3280:         THIS.img_4c_AvisoPortaM.Visible = .F.
3281:         THIS.img_4c_AvisoPortaS.Visible = .F.
3282:         THIS.img_4c_AvisoPortaT.Visible = .F.
3283: 
3284:         IF loc_cTipo == "S"
3285:             *-- `If ReadComm.PortaError` do legado - sem ReadComm nesta
3286:             *-- arquitetura (ver cabecalho do metodo), o aviso correto eh o
3287:             *-- de porta indisponivel.
3288:             THIS.img_4c_AvisoPortaM.Visible = .T.
3289:         ELSE

*-- Linhas 3312 a 3360:
3312: 
3313:         TRY
3314:             IF USED("cursor_4c_PamMoe")
3315:                 USE IN SELECT("cursor_4c_PamMoe")
3316:             ENDIF
3317: 
3318:             loc_cSQL = "SELECT TOP 1 moedacheqs FROM SigCdPam"
3319: 
3320:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PamMoe")
3321: 
3322:             IF loc_nResultado > 0 AND USED("cursor_4c_PamMoe")
3323:                 SELECT cursor_4c_PamMoe
3324:                 IF !EOF("cursor_4c_PamMoe")
3325:                     loc_cMoeda = ALLTRIM(NVL(cursor_4c_PamMoe.moedacheqs, ""))
3326:                 ENDIF
3327:             ENDIF
3328:         CATCH TO loc_oErro
3329:             loc_cMoeda = ""
3330:         ENDTRY
3331: 
3332:         IF USED("cursor_4c_PamMoe")
3333:             USE IN SELECT("cursor_4c_PamMoe")
3334:         ENDIF
3335: 
3336:         THIS.txt_4c_MoeOper.Value = loc_cMoeda
3337:     ENDPROC
3338: 
3339:     *--------------------------------------------------------------------------
3340:     * CarregarCambio - fCarregarCambio() do legado (SIGFUNCS.PRG, nao
3341:     * portado - regra #27/CLAUDE.md). Devolve a cotacao da moeda na data
3342:     * informada: a mais recente registrada em SigCdCot com data <= a
3343:     * informada. Sem cotacao encontrada, devolve 1 (equivalencia direta) -
3344:     * mesmo default dos BOs que ja implementam este padrao (SigReAtmBO/
3345:     * sigopcgcBO), adaptado para SQLEXEC porque este dialogo nao tem
3346:     * crSigCdMoe/crSigCdCot pre-carregados (DataSession propria).
3347:     *
3348:     * Metodo PUBLIC: usado pelas celulas de grade e pelo harness de teste.
3349:     *--------------------------------------------------------------------------
3350:     FUNCTION CarregarCambio(par_cMoeda, par_dData)
3351:         LOCAL loc_cMoeda, loc_dData, loc_nCotacao, loc_cSQL, loc_nResultado, loc_oErro
3352: 
3353:         *-- par_cMoeda pode chegar NULL/nao-char vindo de controle ainda sem
3354:         *-- valor resolvido - VARTYPE antes de ALLTRIM (regra #13/#27)
3355:         loc_cMoeda   = IIF(VARTYPE(par_cMoeda) = "C", ALLTRIM(NVL(par_cMoeda, "")), "")
3356:         loc_dData    = ConverterParaData(par_dData)
3357:         loc_nCotacao = 1
3358: 
3359:         IF EMPTY(loc_cMoeda)
3360:             RETURN 1

*-- Linhas 3366 a 3405:
3366: 
3367:         TRY
3368:             IF USED("cursor_4c_Cambio")
3369:                 USE IN SELECT("cursor_4c_Cambio")
3370:             ENDIF
3371: 
3372:             loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot" + ;
3373:                 " WHERE RTRIM(cmoes) = " + EscaparSQL(loc_cMoeda) + ;
3374:                 " AND datas <= " + FormatarDataSQL(loc_dData) + ;
3375:                 " ORDER BY datas DESC, horas DESC"
3376: 
3377:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cambio")
3378: 
3379:             IF loc_nResultado > 0 AND USED("cursor_4c_Cambio")
3380:                 SELECT cursor_4c_Cambio
3381:                 IF !EOF("cursor_4c_Cambio") AND NVL(cursor_4c_Cambio.valos, 0) != 0
3382:                     loc_nCotacao = cursor_4c_Cambio.valos
3383:                 ENDIF
3384:             ENDIF
3385:         CATCH TO loc_oErro
3386:             loc_nCotacao = 1
3387:         ENDTRY
3388: 
3389:         IF USED("cursor_4c_Cambio")
3390:             USE IN SELECT("cursor_4c_Cambio")
3391:         ENDIF
3392: 
3393:         RETURN loc_nCotacao
3394:     ENDFUNC
3395: 
3396:     *--------------------------------------------------------------------------
3397:     * MoedaPermiteCotacao - `crSigCdMoe.Cotas` do legado (cursor global
3398:     * pre-carregado no login, inexistente nesta arquitetura - mesmo motivo
3399:     * de CarregarCambio). SigCdMoe.cotas eh bit no SQL Server e chega ao
3400:     * VFP ora Logico ora Numerico conforme o driver (regra #13) - testar
3401:     * VARTYPE antes de comparar.
3402:     *--------------------------------------------------------------------------
3403:     FUNCTION MoedaPermiteCotacao(par_cMoeda)
3404:         LOCAL loc_cMoeda, loc_cSQL, loc_nResultado, loc_lCotas, loc_oErro
3405: 

*-- Linhas 3412 a 3453:
3412: 
3413:         TRY
3414:             IF USED("cursor_4c_MoeCk")
3415:                 USE IN SELECT("cursor_4c_MoeCk")
3416:             ENDIF
3417: 
3418:             loc_cSQL = "SELECT TOP 1 cotas FROM SigCdMoe WHERE RTRIM(cmoes) = " + ;
3419:                 EscaparSQL(loc_cMoeda)
3420: 
3421:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeCk")
3422: 
3423:             IF loc_nResultado > 0 AND USED("cursor_4c_MoeCk")
3424:                 SELECT cursor_4c_MoeCk
3425:                 IF !EOF("cursor_4c_MoeCk")
3426:                     IF VARTYPE(cursor_4c_MoeCk.cotas) = "L"
3427:                         loc_lCotas = cursor_4c_MoeCk.cotas
3428:                     ELSE
3429:                         loc_lCotas = (NVL(cursor_4c_MoeCk.cotas, 0) != 0)
3430:                     ENDIF
3431:                 ENDIF
3432:             ENDIF
3433:         CATCH TO loc_oErro
3434:             loc_lCotas = .F.
3435:         ENDTRY
3436: 
3437:         IF USED("cursor_4c_MoeCk")
3438:             USE IN SELECT("cursor_4c_MoeCk")
3439:         ENDIF
3440: 
3441:         RETURN loc_lCotas
3442:     ENDFUNC
3443: 
3444:     *--------------------------------------------------------------------------
3445:     * CargoTemAltCots - `crUsuario`/`crSigCdCrg` do legado (cursores
3446:     * globais pre-carregados no login, mesmo motivo acima):
3447:     *
3448:     *     =Seek( Padr(Alltrim(Usuar),10), 'crUsuario', 'Usuarios' )
3449:     *     Return( Seek(crUsuario.Ccargs,'crSigCdCrg','Ccargs') And
3450:     *             crSigCdCrg.AltCots = 'S' )
3451:     *
3452:     * gc_4c_UsuarioLogado substitui a global legado `Usuar` (memoria
3453:     * "PUBLIC vars legado Fortyus").

*-- Linhas 3463 a 3557:
3463: 
3464:         TRY
3465:             IF USED("cursor_4c_CargoCk")
3466:                 USE IN SELECT("cursor_4c_CargoCk")
3467:             ENDIF
3468: 
3469:             loc_cSQL = "SELECT TOP 1 b.altcots" + ;
3470:                 " FROM SigCdUsu a INNER JOIN SigCdCrg b ON RTRIM(b.ccargs) = RTRIM(a.ccargs)" + ;
3471:                 " WHERE RTRIM(a.usuarios) = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))
3472: 
3473:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CargoCk")
3474: 
3475:             IF loc_nResultado > 0 AND USED("cursor_4c_CargoCk")
3476:                 SELECT cursor_4c_CargoCk
3477:                 IF !EOF("cursor_4c_CargoCk")
3478:                     loc_lAltCots = (UPPER(ALLTRIM(NVL(cursor_4c_CargoCk.altcots, ""))) == "S")
3479:                 ENDIF
3480:             ENDIF
3481:         CATCH TO loc_oErro
3482:             loc_lAltCots = .F.
3483:         ENDTRY
3484: 
3485:         IF USED("cursor_4c_CargoCk")
3486:             USE IN SELECT("cursor_4c_CargoCk")
3487:         ENDIF
3488: 
3489:         RETURN loc_lAltCots
3490:     ENDFUNC
3491: 
3492:     *--------------------------------------------------------------------------
3493:     * ObterTrocosDaForma - `CrSigOpFp.Trocos` da forma de pagamento
3494:     * informada (SigOpFp.trocos: numeric(1,0), 1 = desconta do total em vez
3495:     * de somar - usado por AtualizarTotalFormaPagamento/TxtVparLostFocus/
3496:     * TxtPorcLostFocus).
3497:     *--------------------------------------------------------------------------
3498:     PROTECTED FUNCTION ObterTrocosDaForma(par_cFPags)
3499:         LOCAL loc_cSQL, loc_nResultado, loc_nTrocos, loc_oErro
3500: 
3501:         loc_nTrocos = 0
3502: 
3503:         IF VARTYPE(par_cFPags) != "C" OR EMPTY(ALLTRIM(par_cFPags))
3504:             RETURN 0
3505:         ENDIF
3506: 
3507:         TRY
3508:             IF USED("cursor_4c_TrocosCk")
3509:                 USE IN SELECT("cursor_4c_TrocosCk")
3510:             ENDIF
3511: 
3512:             loc_cSQL = "SELECT TOP 1 trocos FROM SigOpFp WHERE RTRIM(fpags) = " + ;
3513:                 EscaparSQL(ALLTRIM(par_cFPags))
3514: 
3515:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TrocosCk")
3516: 
3517:             IF loc_nResultado > 0 AND USED("cursor_4c_TrocosCk")
3518:                 SELECT cursor_4c_TrocosCk
3519:                 IF !EOF("cursor_4c_TrocosCk")
3520:                     loc_nTrocos = NVL(cursor_4c_TrocosCk.trocos, 0)
3521:                 ENDIF
3522:             ENDIF
3523:         CATCH TO loc_oErro
3524:             loc_nTrocos = 0
3525:         ENDTRY
3526: 
3527:         IF USED("cursor_4c_TrocosCk")
3528:             USE IN SELECT("cursor_4c_TrocosCk")
3529:         ENDIF
3530: 
3531:         RETURN loc_nTrocos
3532:     ENDFUNC
3533: 
3534:     *--------------------------------------------------------------------------
3535:     * AtualizarTotalFormaPagamento - Recalcula Get_TotForma.Value somando
3536:     * (ou subtraindo, se Trocos=1) cada linha da grade convertida para a
3537:     * moeda de operacao (Get_MoeOper), transcricao do bloco final do Init
3538:     * legado E do Valid de Grade.valor.Text1 (sao o MESMO calculo, chamado
3539:     * nos dois pontos - aqui tambem no DefinirDadosTitulo, equivalente ao
3540:     * Init rodar ja com xPar povoado pelo form pai):
3541:     *
3542:     *     ctotal=0 / Select xPar / Scan
3543:     *         =Seek( xPar.FPags, 'CrSigOpFp', 'FPags' )
3544:     *         lnCotOper = fCarregarCambio( Get_MoeOper.Value, crSigChLcq.DtEnts )
3545:     *         ctotal = Round( ctotal +- ( xPar.Valos * xPar.cotfpgs / lnCotOper ), 2 )
3546:     *     Endscan
3547:     *     ThisForm.Get_TotForma.Value = ctotal
3548:     *
3549:     * `CrSigOpFp.Trocos` da linha (nao da forma do cabecalho) - cada linha
3550:     * pode ter uma forma de pagamento diferente, por isso a consulta eh POR
3551:     * LINHA (ObterTrocosDaForma), igual ao Seek do legado.
3552:     *
3553:     * Metodo PUBLIC: chamado pelas celulas de grade e pelo harness de teste.
3554:     *--------------------------------------------------------------------------
3555:     FUNCTION AtualizarTotalFormaPagamento()
3556:         LOCAL loc_cCursor, loc_nCotOper, loc_nCotFpgs, loc_nTotal, loc_cAliasAnt, ;
3557:             loc_nRecnoAnt, loc_nTrocos

*-- Linhas 3568 a 3635:
3568:         loc_nCotOper  = THIS.CarregarCambio(THIS.txt_4c_MoeOper.Value, ;
3569:             THIS.this_oBusinessObject.this_dDtEnts)
3570: 
3571:         SELECT (loc_cCursor)
3572:         loc_nRecnoAnt = IIF(EOF() OR BOF(), 0, RECNO())
3573: 
3574:         *-- Loop manual (nao SCAN) - ObterTrocosDaForma abre outro cursor via
3575:         *-- SQLEXEC e muda o workarea corrente; SCAN...ENDSCAN presume o
3576:         *-- mesmo workarea do inicio do laco em todo SKIP/EOF() implicito,
3577:         *-- entao o avanco e o teste de fim sao feitos aqui explicitamente,
3578:         *-- sempre reselecionando loc_cCursor antes.
3579:         SELECT (loc_cCursor)
3580:         GO TOP
3581:         DO WHILE !EOF(loc_cCursor)
3582:             loc_nTrocos  = THIS.ObterTrocosDaForma(ALLTRIM(NVL(EVALUATE(loc_cCursor + ".FPags"), "")))
3583:             loc_nCotFpgs = NVL(EVALUATE(loc_cCursor + ".CotFpgs"), 0)
3584: 
3585:             IF loc_nCotOper != 0
3586:                 IF loc_nTrocos = 1
3587:                     loc_nTotal = ROUND(loc_nTotal - (EVALUATE(loc_cCursor + ".Valos") * loc_nCotFpgs / loc_nCotOper), 2)
3588:                 ELSE
3589:                     loc_nTotal = ROUND(loc_nTotal + (EVALUATE(loc_cCursor + ".Valos") * loc_nCotFpgs / loc_nCotOper), 2)
3590:                 ENDIF
3591:             ENDIF
3592: 
3593:             SELECT (loc_cCursor)
3594:             SKIP
3595:         ENDDO
3596: 
3597:         IF loc_nRecnoAnt > 0 AND loc_nRecnoAnt <= RECCOUNT(loc_cCursor)
3598:             SELECT (loc_cCursor)
3599:             GOTO loc_nRecnoAnt
3600:         ENDIF
3601: 
3602:         IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
3603:             SELECT (loc_cAliasAnt)
3604:         ENDIF
3605: 
3606:         THIS.txt_4c_TotForma.Value = loc_nTotal
3607:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3608:             THIS.this_oBusinessObject.this_nTotForma = loc_nTotal
3609:         ENDIF
3610: 
3611:         RETURN loc_nTotal
3612:     ENDFUNC
3613: 
3614:     *--------------------------------------------------------------------------
3615:     * ValidarValorLinhaGrade - Valid de SIGOPFPG.Grade.valor.Text1:
3616:     *
3617:     *     If lastkey()=9
3618:     *         Thisform.leitor=.f. / keyboard"{CTRL+TAB}"
3619:     *     Else
3620:     *         ctotal=0 / Select xPar / Scan ... Endscan
3621:     *         ThisForm.Get_TotForma.Value = ctotal
3622:     *     Endif
3623:     *
3624:     * O ramo TAB(9) eh o mesmo escape de navegacao do Grid nativo. Chamado
3625:     * pela CLASSE TextBoxCelulaValorFpg (regra #46).
3626:     *
3627:     * Metodo PUBLIC: alcancado de OUTRO objeto (this_oForm.<metodo>), nao
3628:     * pode ser PROTECTED.
3629:     *--------------------------------------------------------------------------
3630:     FUNCTION ValidarValorLinhaGrade()
3631:         IF LASTKEY() = 9
3632:             THIS.this_lLeitor = .F.
3633:             KEYBOARD "{CTRL+TAB}"
3634:         ELSE
3635:             THIS.AtualizarTotalFormaPagamento()

*-- Linhas 3905 a 3950:
3905:     *--------------------------------------------------------------------------
3906:     * CarregarFeriados - Le SigCdFer uma unica vez para this_cFeriadosCache
3907:     * ("|AAAAMMDD|..."), mesmo padrao de SigPrCfnBO.CarregarFeriados -
3908:     * evita um SELECT por dia dentro do laco do gerador de parcelas.
3909:     *--------------------------------------------------------------------------
3910:     PROTECTED PROCEDURE CarregarFeriados()
3911:         LOCAL loc_cSQL, loc_nResultado, loc_cLista, loc_oErro
3912: 
3913:         IF THIS.this_lFeriadosCarregados
3914:             RETURN .T.
3915:         ENDIF
3916: 
3917:         loc_cLista = "|"
3918: 
3919:         TRY
3920:             IF USED("cursor_4c_FerLoad")
3921:                 USE IN SELECT("cursor_4c_FerLoad")
3922:             ENDIF
3923: 
3924:             loc_cSQL = "SELECT DISTINCT datas FROM SigCdFer WHERE datas IS NOT NULL"
3925: 
3926:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FerLoad")
3927: 
3928:             IF loc_nResultado > 0 AND USED("cursor_4c_FerLoad")
3929:                 SELECT cursor_4c_FerLoad
3930:                 SCAN
3931:                     IF !ISNULL(datas) AND !EMPTY(datas)
3932:                         loc_cLista = loc_cLista + DTOS(ConverterParaData(datas)) + "|"
3933:                     ENDIF
3934:                 ENDSCAN
3935:                 USE IN SELECT("cursor_4c_FerLoad")
3936:             ENDIF
3937: 
3938:             THIS.this_cFeriadosCache      = loc_cLista
3939:             THIS.this_lFeriadosCarregados = .T.
3940:         CATCH TO loc_oErro
3941:             THIS.this_cFeriadosCache = "|"
3942:         ENDTRY
3943: 
3944:         RETURN .T.
3945:     ENDPROC
3946: 
3947:     *--------------------------------------------------------------------------
3948:     * AvancarAlemDosFeriados - Transcricao do laco de feriados do
3949:     * fweditdata_venc.Valid legado:
3950:     *

*-- Linhas 4084 a 4167:
4084:                 *-- (AvancarAlemDosFeriados - ver comentario do metodo)
4085:                 loc_dVenc = THIS.AvancarAlemDosFeriados(loc_dVenc)
4086: 
4087:                 SELECT (loc_cCursor)
4088:                 APPEND BLANK
4089:                 REPLACE Parcs    WITH loc_nParcs, ;
4090:                         Emps     WITH THIS.this_oBusinessObject.this_cEmps, ;
4091:                         Datas    WITH loc_dDtEnts, ;
4092:                         Valos    WITH loc_nValPar, ;
4093:                         MoeFpgs  WITH THIS.this_oBusinessObject.this_cMoedas, ;
4094:                         Vencs    WITH loc_dVenc, ;
4095:                         FPags    WITH THIS.txt_4c_Fpg.Value, ;
4096:                         Dcarts   WITH THIS.this_oBusinessObject.this_cDcarts, ;
4097:                         CotFpgs  WITH loc_nCotacao, ;
4098:                         Cotusus  WITH THIS.this_cCotUsu
4099: 
4100:                 loc_nTotPar = loc_nTotPar + loc_nValPar
4101: 
4102:                 *-- Ultima parcela: absorve a diferenca de arredondamento.
4103:                 *-- REPLACE exige nome de campo LITERAL (nao aceita
4104:                 *-- expressao de alias+campo entre parenteses) - SELECT
4105:                 *-- (loc_cCursor) ja deixou este o workarea corrente.
4106:                 IF loc_nParcelas = 1
4107:                     IF loc_nTotPar != (THIS.txt_4c_Vpar.Value + THIS.txt_4c_VEncargo.Value)
4108:                         SELECT (loc_cCursor)
4109:                         REPLACE Valos WITH Valos + ;
4110:                             ((THIS.txt_4c_Vpar.Value + THIS.txt_4c_VEncargo.Value) - loc_nTotPar)
4111:                     ENDIF
4112:                 ENDIF
4113: 
4114:                 THIS.MostrarObservacao()
4115: 
4116:                 *-- `If fpags='CARNE' / gera Ncarnes via fGerUniqueKey` - codigo
4117:                 *-- literal da forma de pagamento, transcrito do legado.
4118:                 *-- Re-SELECT: MostrarObservacao/CarregarInfoFormaPagamento
4119:                 *-- pode ter mudado o workarea corrente (SQLEXEC em outro
4120:                 *-- cursor).
4121:                 IF UPPER(ALLTRIM(THIS.txt_4c_Fpg.Value)) == "CARNE"
4122:                     IF loc_nCarne = 0
4123:                         loc_nCarne = fGerUniqueKey("CARNE")
4124:                     ENDIF
4125:                     SELECT (loc_cCursor)
4126:                     REPLACE Ncarnes WITH TRANSFORM(loc_nCarne, "@L 999999") + ;
4127:                         "/" + TRANSFORM(loc_nIndiceParcela, "@L 9")
4128:                     THIS.cnt_4c_CarneFP.txt_4c_Carne.Refresh()
4129:                     loc_nIndiceParcela = loc_nIndiceParcela + 1
4130:                 ENDIF
4131: 
4132:                 *-- `If CrSigOpFp.Infos='T'` - cartao de credito: na 1a
4133:                 *-- parcela mostra o painel e le o que o usuario confirmou
4134:                 *-- nele (CmdConfirmaCartaoClick copia para CntCCredFP);
4135:                 *-- nas demais, repete o mesmo cartao/credito
4136:                 IF UPPER(ALLTRIM(THIS.this_cInfoForma)) == "T"
4137:                     IF loc_lPrimeiroCartao
4138:                         THIS.CartaoCredito(.T.)
4139:                         THIS.cnt_4c_CCred.Refresh()
4140: 
4141:                         loc_cCartao    = THIS.cnt_4c_CCredFP.txt_4c_CartaoFp.Value
4142:                         loc_cNoCredito = THIS.cnt_4c_CCredFP.txt_4c_CredFp.Value
4143:                         loc_lPrimeiroCartao = .F.
4144:                     ELSE
4145:                         SELECT (loc_cCursor)
4146:                         REPLACE Cartaos WITH loc_cCartao, Nocreditos WITH loc_cNoCredito
4147:                         THIS.cnt_4c_CCredFP.txt_4c_CartaoFp.Refresh()
4148:                         THIS.cnt_4c_CCredFP.txt_4c_CredFp.Refresh()
4149:                     ENDIF
4150:                 ENDIF
4151: 
4152:                 SELECT (loc_cCursor)
4153: 
4154:                 *-- `If TVen='F' / DVenc = GoMonth(DVenci,_Parcelas) / Else /
4155:                 *--  DVenc = DVenc + NDia / Endif`
4156:                 IF UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cTvens)) == "F"
4157:                     loc_dVenc           = GOMONTH(loc_dVenci, loc_nIndiceParcela)
4158:                 ELSE
4159:                     loc_dVenc           = loc_dVenc + THIS.this_oBusinessObject.this_nDias
4160:                 ENDIF
4161: 
4162:                 loc_nParcelas = loc_nParcelas - 1
4163:                 loc_nParcs    = loc_nParcs + 1
4164: 
4165:                 loc_nTrocos = THIS.ObterTrocosDaForma(THIS.txt_4c_Fpg.Value)
4166:                 IF loc_nTrocos = 1
4167:                     loc_nTotal = ROUND(loc_nTotal - ROUND((EVALUATE(loc_cCursor + ".Valos") * loc_nCotacao / loc_nCotOper), 2), 2)

*-- Linhas 4307 a 4325:
4307:     *     endif
4308:     *
4309:     * + LostFocus (19 linhas) - dispara VerificaCheque com os 4 campos da
4310:     * LINHA CORRENTE (ControlSource, regra do topo deste arquivo).
4311:     *--------------------------------------------------------------------------
4312:     PROCEDURE TxtNumLostFocus()
4313:         LOCAL loc_cCursor
4314:         loc_cCursor = THIS.this_cCursorGrade
4315: 
4316:         IF !EMPTY(THIS.cnt_4c_ChequeFP.txt_4c_Num.Value)
4317:             IF !fChkDigitos(THIS.cnt_4c_ChequeFP.txt_4c_Num.Value)
4318:                 MsgAviso("N" + CHR(250) + "mero Inv" + CHR(225) + "lido !")
4319:                 THIS.cnt_4c_ChequeFP.txt_4c_Num.SetFocus()
4320:                 RETURN .F.
4321:             ENDIF
4322:         ENDIF
4323: 
4324:         THIS.ValidarChequeLinhaCorrente()
4325: 

*-- Linhas 4452 a 4470:
4452:         ENDIF
4453: 
4454:         IF !THIS.VerificaCheque(loc_cBanco, loc_cAgencia, loc_cConta, loc_cNumero)
4455:             SELECT (loc_cCursor)
4456:             REPLACE Bancos WITH "", Agencias WITH "", Contas WITH "", Numeros WITH ""
4457:             THIS.cnt_4c_ChequeFP.txt_4c_Bco.Refresh()
4458:             THIS.cnt_4c_ChequeFP.txt_4c_Age.Refresh()
4459:             THIS.cnt_4c_ChequeFP.txt_4c_Conta.Refresh()
4460:             THIS.cnt_4c_ChequeFP.txt_4c_Num.Refresh()
4461:             THIS.cnt_4c_ChequeFP.txt_4c_Bco.SetFocus()
4462:         ELSE
4463:             THIS.FocarValorDaGrade()
4464:         ENDIF
4465: 
4466:         RETURN .T.
4467:     ENDPROC
4468: 
4469:     *--------------------------------------------------------------------------
4470:     * FocarValorDaGrade - `Thisform.Grade.Valor.Text1.SetFocus`, repetido

*-- Linhas 4491 a 4520:
4491:     *         .Get_Num.Value = Space(6)   / .Get_Num.Refresh
4492:     *     EndWith
4493:     *
4494:     * Os campos sao ControlSource da linha corrente (regra do topo deste
4495:     * arquivo) - REPLACE no cursor, nao atribuicao direta ao .Value.
4496:     *
4497:     * Metodo PUBLIC: harness de teste automatico e handlers de outras fases
4498:     * podem chamar (regra #3).
4499:     *--------------------------------------------------------------------------
4500:     PROCEDURE LimpaChe()
4501:         LOCAL loc_cCursor
4502:         loc_cCursor = THIS.this_cCursorGrade
4503: 
4504:         IF USED(loc_cCursor) AND !EOF(loc_cCursor)
4505:             SELECT (loc_cCursor)
4506:             REPLACE Bancos WITH SPACE(3), Agencias WITH SPACE(4), ;
4507:                     Contas WITH SPACE(10), Numeros WITH SPACE(6)
4508:         ENDIF
4509: 
4510:         THIS.cnt_4c_ChequeFP.txt_4c_Bco.Refresh()
4511:         THIS.cnt_4c_ChequeFP.txt_4c_Age.Refresh()
4512:         THIS.cnt_4c_ChequeFP.txt_4c_Conta.Refresh()
4513:         THIS.cnt_4c_ChequeFP.txt_4c_Num.Refresh()
4514:     ENDPROC
4515: 
4516:     *--------------------------------------------------------------------------
4517:     * InChequeSerial - `PROCEDURE inchequeserial` do legado: completa a
4518:     * leitura da leitora serial (ReadComm.leitura/campo) e dispara a mesma
4519:     * cadeia Get_Bco.Valid + VerificaCheque do fluxo manual. Disparado no
4520:     * legado pelo evento OnComm do controle OLE ReadComm.

*-- Linhas 4576 a 4612:
4576:     *     if !fChkDigitos(banco/agencia/numero/conta) / 'Leitura incorreta' / sd=.f.
4577:     *     if sd / Seek banco+agencia+conta+numero em xPar (outra linha) /
4578:     *             se achou -> 'Cheque ja lancado' / sd=.f.
4579:     *     if sd / Select * From SigChe Where Bancos=... And Agencias=...
4580:     *             And nContas=... And Ncheques=... Into Cursor CrCheque /
4581:     *             se achou -> confere TempChq (mesmo titulo) -> se nao
4582:     *             achou la, 'Cheque ja cadastrado'; se achou, confere Valor
4583:     *     Return sd
4584:     *
4585:     * `TempChq` (cursor das PARCELAS JA GRAVADAS do MESMO titulo, que
4586:     * distingue "este cheque e de uma OUTRA nota" de "este cheque e desta
4587:     * MESMA nota, so que ja fechada antes") nao existe nesta arquitetura:
4588:     * nenhum form pai fornece esse cursor (SigOpFpg ainda nao esta
4589:     * encadeado a Fluxo de Caixa/Baixa de Titulos - grep confirmado,
4590:     * 2026-11-04). Sem ele, a distincao "mesmo titulo" x "outro titulo" eh
4591:     * IMPOSSIVEL de fazer; o SEEK sobre alias inexistente estouraria em
4592:     * runtime. Degrada para o lado CONSERVADOR: cheque ja registrado em
4593:     * SigChe (qualquer titulo) bloqueia como "ja cadastrado" - impede
4594:     * duplicar lancamento de cheque, ao preco de poder bloquear o caso
4595:     * raro de reconfirmar o MESMO titulo (que o usuario resolve veio pelo
4596:     * Cancelar/reabrir). `ThisForm.Parentform.PoDataMgr.SqlExecute` (data
4597:     * manager legado) vira SQLEXEC(gnConnHandle,...) direto.
4598:     *
4599:     * Metodo PUBLIC: chamado pelos LostFocus de Get_bco/Get_num e por
4600:     * InChequeSerial.
4601:     *--------------------------------------------------------------------------
4602:     FUNCTION VerificaCheque(par_cBanco, par_cAgencia, par_cConta, par_cNumero)
4603:         LOCAL loc_cCursor, loc_lDigitosOk, loc_lDuplicadoLocal, loc_lOk, ;
4604:             loc_cSQL, loc_nResultado, loc_cAliasAnt, loc_nRecnoAnt, loc_oErro
4605: 
4606:         loc_cCursor = THIS.this_cCursorGrade
4607:         loc_lOk     = .T.
4608: 
4609:         *-- `if !fChkDigitos(banco/agencia/numero/conta)`
4610:         loc_lDigitosOk = fChkDigitos(par_cBanco) AND fChkDigitos(par_cAgencia) AND ;
4611:             fChkDigitos(par_cNumero) AND fChkDigitos(par_cConta)
4612: 

*-- Linhas 4619 a 4698:
4619:         *-- distribuicao ja usa este cheque)
4620:         IF USED(loc_cCursor)
4621:             loc_cAliasAnt = ALIAS()
4622:             SELECT (loc_cCursor)
4623:             loc_nRecnoAnt = IIF(EOF() OR BOF(), 0, RECNO())
4624: 
4625:             loc_lDuplicadoLocal = .F.
4626:             SCAN FOR ALLTRIM(NVL(Bancos, "")) == ALLTRIM(par_cBanco) AND ;
4627:                      ALLTRIM(NVL(Agencias, "")) == ALLTRIM(par_cAgencia) AND ;
4628:                      ALLTRIM(NVL(Contas, "")) == ALLTRIM(par_cConta) AND ;
4629:                      ALLTRIM(NVL(Numeros, "")) == ALLTRIM(par_cNumero) AND ;
4630:                      RECNO() != loc_nRecnoAnt
4631:                 loc_lDuplicadoLocal = .T.
4632:                 EXIT
4633:             ENDSCAN
4634: 
4635:             IF loc_nRecnoAnt > 0 AND loc_nRecnoAnt <= RECCOUNT(loc_cCursor)
4636:                 SELECT (loc_cCursor)
4637:                 GOTO loc_nRecnoAnt
4638:             ENDIF
4639:             IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
4640:                 SELECT (loc_cAliasAnt)
4641:             ENDIF
4642: 
4643:             IF loc_lDuplicadoLocal
4644:                 MsgAviso("Cheque j" + CHR(225) + " lan" + CHR(231) + "ado!!")
4645:                 RETURN .F.
4646:             ENDIF
4647:         ENDIF
4648: 
4649:         *-- `Select * From SigChe Where Bancos=... And Agencias=... And
4650:         *--  nContas=... And Ncheques=... Into Cursor CrCheque`
4651:         TRY
4652:             IF USED("cursor_4c_CheCk")
4653:                 USE IN SELECT("cursor_4c_CheCk")
4654:             ENDIF
4655: 
4656:             loc_cSQL = "SELECT valors FROM SigChe" + ;
4657:                 " WHERE RTRIM(bancos) = " + EscaparSQL(ALLTRIM(par_cBanco)) + ;
4658:                 " AND RTRIM(agencias) = " + EscaparSQL(ALLTRIM(par_cAgencia)) + ;
4659:                 " AND RTRIM(ncontas) = " + EscaparSQL(ALLTRIM(par_cConta)) + ;
4660:                 " AND RTRIM(ncheques) = " + EscaparSQL(ALLTRIM(par_cNumero))
4661: 
4662:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheCk")
4663: 
4664:             IF loc_nResultado < 0
4665:                 MsgErro("Favor reinicializar o processo." + CHR(13) + CapturarErroSQL(), ;
4666:                     "Falha na Conex" + CHR(227) + "o")
4667:                 loc_lOk = .F.
4668:             ELSE
4669:                 IF USED("cursor_4c_CheCk") AND RECCOUNT("cursor_4c_CheCk") > 0
4670:                     *-- Sem TempChq (ver cabecalho do metodo), qualquer match
4671:                     *-- em SigChe bloqueia como "ja cadastrado" - lado
4672:                     *-- conservador da degradacao.
4673:                     MsgAviso("Cheque j" + CHR(225) + " cadastrado !!")
4674:                     loc_lOk = .F.
4675:                 ENDIF
4676:             ENDIF
4677:         CATCH TO loc_oErro
4678:             MsgErro(loc_oErro.Message, "Erro ao verificar cheque")
4679:             loc_lOk = .F.
4680:         ENDTRY
4681: 
4682:         IF USED("cursor_4c_CheCk")
4683:             USE IN SELECT("cursor_4c_CheCk")
4684:         ENDIF
4685: 
4686:         RETURN loc_lOk
4687:     ENDFUNC
4688: 
4689:     *--------------------------------------------------------------------------
4690:     * TornarControlesVisiveis - Torna visiveis recursivamente os controles
4691:     * criados via AddObject (que nascem Visible=.F.).
4692:     *
4693:     * EXCECAO (FASE 6/8): os 5 paineis flutuantes de forma de pagamento
4694:     * (CntCCred/CntCCredFP/CntCarneFP/CntOutrosFP/CntChequeFP) tem de
4695:     * permanecer Visible=.F. - sao alternados pelo equivalente a MostraObs/
4696:     * mCartaoCred do legado (MostrarObservacao/CartaoCredito, Fase 7).
4697:     * A excecao preserva o Visible=.F. do CONTAINER mas ainda desce a
4698:     * recursao para os filhos (labels/textboxes), que precisam estar


### BO (C:\4c\projeto\app\classes\SigOpFpgBO.prg):
*==============================================================================
* SigOpFpgBO.prg
*
* Business Object para SigOpFpg (Forma de Pagamento)
* Dialogo filho chamado por formularios de movimento (ex.: Fluxo de Caixa /
* Baixa de Titulos) para distribuir o valor de um titulo/cheque em uma ou
* mais formas de pagamento (dinheiro, cartao, carne, cheque, outros).
*
* Nao possui tabela principal propria: a grade de formas de pagamento
* trabalha sobre o cursor local xPar (populado/consumido pelo form) e os
* dados sao devolvidos ao formulario pai, que grava no titulo/movimento
* de origem (SigChLcq e afins).
*
* FASE 1/8: Propriedades e Init. FASE 8/8: propriedades adicionais lidas
* pelo gerador de parcelas (this_cEmps/this_nEntradas/this_nDias/
* this_cTvens/this_cDcarts), populadas pelo FormSigOpFpg em
* AplicarFormaPagamento/DefinirDadosTitulo.
*==============================================================================

DEFINE CLASS SigOpFpgBO AS BusinessBase

    *-- Contexto recebido do formulario pai (Init do form legado:
    *-- Lparameters pForm, DatSes, llAltDireta)
    this_cOpEscolha     = ""    && op_escolha herdado do form pai (INSERIR/ALTERAR/CONSULTAR/EXCLUIR)
    this_lAltDireta     = .F.   && llAltDireta - fluxo de alteracao direta de forma de pagamento

    *-- Dados do titulo/movimento sendo pago (resolvidos a partir do cursor
    *-- do form pai - equivalente a CrSigChLcq no legado)
    this_dDtEnts        = {}    && datetime - data de entrada/movimentacao do titulo
    this_nValTots       = 0     && numeric  - valor total do titulo/cheque a pagar
    this_cEmps          = ""    && char     - empresa do titulo (SigChLcq.Emps), gravada em cada parcela

    *-- Linha corrente da grade de formas de pagamento (xPar), espelhando as
    *-- colunas usadas pelo legado: FPags, Valos, Vencs, Moedas, CotFpgs
    this_cFPags         = ""    && char     - codigo da forma de pagamento (SigCdOpFp.FPags)
    this_nValos         = 0     && numeric  - valor da parcela/linha
    this_dVencs         = {}    && date     - data de vencimento da parcela
    this_cMoedas        = ""    && char     - moeda da parcela
    this_nCotFpgs       = 0     && numeric  - cotacao aplicada na parcela

    *-- Totais e campos de cabecalho do dialogo
    this_cMoeOper       = ""    && char     - moeda de operacao (Get_MoeOper)
    this_nTotForma      = 0     && numeric  - total ja distribuido nas formas de pagamento
    this_nNPar          = 0     && numeric  - numero de parcelas
    this_nVPar          = 0     && numeric  - valor da parcela calculada
    this_nPEncargo      = 0     && numeric  - percentual de encargo financeiro
    this_nVEncargo      = 0     && numeric  - valor de encargo financeiro
    this_nCotacao       = 0     && numeric  - cotacao atual da moeda de operacao
    this_cCotUsu        = ""    && char     - indicador de cotacao alterada manualmente (SigOpAlC)
    this_nValTotChqs    = 0     && numeric  - valor total ja distribuido em cheques
    this_cObs           = ""    && memo     - observacao (forma "Outros")

    *-- Regras de vencimento/parcelamento da forma de pagamento escolhida
    *-- (SigOpFp.entradas/dias/tvens/dcarts), lidas em AplicarFormaPagamento e
    *-- consumidas pelo gerador de parcelas (fweditdata_venc.Valid do legado)
    this_nEntradas      = 0     && numeric - dias da data do titulo at? o 1o vencimento
    this_nDias          = 0     && numeric - intervalo entre parcelas (dias)
    this_cTvens         = ""    && char    - "F"=dias Fixos (GoMonth) / "C"=dias Corridos
    this_cDcarts        = ""    && char    - descricao do cartao, gravada em cada parcela

    *-- Painel Cartao de Credito (CntCCred / CntCCredFP)
    this_cCartao        = ""    && char     - numero do cartao de credito
    this_nCred          = 0     && numeric  - numero de parcelas do credito

    *-- Painel Carne (CntCarneFP)
    this_cCarne         = ""    && char     - codigo do carne

    *-- Painel Cheque (CntChequeFP)
    this_cBco           = ""    && char     - codigo do banco
    this_cAge           = ""    && char     - codigo da agencia
    this_cConta         = ""    && char     - numero da conta
    this_cNum           = ""    && char     - numero do cheque

    *-- Estado de controle (leitora serial de cheques / flags do legado)
    this_lLeitor        = .F.   && leitora serial de cheques habilitada
    this_cLeituraSerial = ""    && buffer com a leitura recebida da porta serial
    this_cTipoLeitora   = ""    && "S" = leitora serial configurada
    this_lDigpar        = .F.   && habilita digitacao manual de numero de parcelas
    this_lCarAuts       = .F.   && SigCdOpFp.CarAuts - cartao de credito sem validacao de digitos

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object. Sem tabela principal (dialogo
    * trabalha sobre cursor local do form pai).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel. Este dialogo nao tem tabela principal
    * (ver cabecalho da classe): a linha corrente da grade de formas de
    * pagamento chega por propriedade (this_cFPags/this_nValos/this_dVencs/
    * this_cMoedas/this_nCotFpgs), preenchida pelo proprio form a partir do
    * cursor local xPar - nao por SELECT (par_cAliasCursor).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel. Este dialogo nao grava em tabela do SQL
    * Server: a gravacao efetiva do titulo/movimento ocorre no formulario
    * pai (SigChLcq e afins), a partir do cursor xPar devolvido no Return.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel, pelo mesmo motivo de Inserir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel: sem tabela nem chave primaria
    * propria neste dialogo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Nao aplicavel: sem gravacao em tabela do SQL
    * Server neste dialogo, nao ha operacao para auditar aqui. O registro
    * de auditoria do titulo/movimento fica a cargo do formulario pai.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN
    ENDPROC

ENDDEFINE

