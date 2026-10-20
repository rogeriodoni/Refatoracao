# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CODTAMS, IF
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CODTAMS, IF
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TRIMADO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CODTAMS, IF

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
  DeleteMark = .F.
  AllowCellSelection = .T.
		lcSql = [Select Dpros, pvens, pcuss From SigCdPro Where Cpros = ']+pcPro+[']
		.PodataMgr.Sqlexecute(lcSql,'LocalPro')
		lcSql = [Select a.*, Space(40) as Descs From SigPrTam a Where a.cPros = ']+pcPro+[']
		.Podatamgr.Sqlexecute(lcSql,'CrSigPrTam')
Select crSigPrTam
	.Column1.ControlSource = [crSigPrTam.CodTams]
	.Column2.ControlSource = [crSigPrTam.Descs]
	.Column3.ControlSource = [crSigPrTam.PesoMs]
	.Column4.ControlSource = [crSigPrTam.Percs]
	.Column5.ControlSource = [crSigPrTam.Valor]
	.Column6.ControlSource = [crSigPrTam.DiasPrz]
			Select a.CodTams ;
			  From crSigPrTam a ;
			Select crAux
			Select crSigPrTam
			Select a.CodTams ;
			  From crSigPrTam a ;
			Select crAux
Select crSigPrTam
	Delete
		Select crSigPrTam
Select crSigPrTam
	Insert Into crSigPrTam (cPros, CidChaves) Values (crSigCdPro.cPros,fUniqueIds())
Select crSigPrTam

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprtam.prg) - TRECHOS RELEVANTES PARA PASS SQL (1798 linhas total):

*-- Linhas 145 a 165:
145:     * NAO foram gravados em SigPrTam (linha em branco, esperando o usuario
146:     * escolher o tamanho). Formato: "|cid1|cid2|". Mesmo papel do
147:     * this_cPksNovos de FormSigPrCar: aqui a gravacao tem de acontecer no
148:     * proprio dialogo (DataSession privada, sem TableUpdate implicito do
149:     * legado), entao esta lista distingue "linha nova ainda sem registro no
150:     * banco" (INSERT) de "linha que veio do CarregarLista" (UPDATE/DELETE).
151:     *--------------------------------------------------------------------------
152:     this_cCidChavesNovos = ""
153: 
154:     *--------------------------------------------------------------------------
155:     * Resultado do picker de tamanhos (AbrirLookupTamanho). Nao pode ser lido
156:     * de volta de Column1.Text1.Value/Column2.Text1.Value: em Grid esses
157:     * controles sao a celula CORRENTE, re-vinculada quando o cursor se move -
158:     * e o picker eh MODAL, entao o ponteiro pode ter mudado quando ele fecha.
159:     *--------------------------------------------------------------------------
160:     this_cLkpCodigo    = ""
161:     this_cLkpDescricao = ""
162: 
163:     *-- Guarda de reentrancia do picker modal (aberto de dentro de um handler
164:     *-- de celula da grade - sem isso o proprio evento pode redisparar e
165:     *-- empilhar um segundo picker)

*-- Linhas 218 a 239:
218: 
219:         TRY
220:             *-- DataSession = 2 nasce com os SETs no DEFAULT do VFP, NAO com os
221:             *-- do config.prg. Sem DELETED ON, o DELETE local do BtnExcluirClick
222:             *-- (linha em branco nunca gravada) marca a linha mas ela CONTINUA
223:             *-- aparecendo na grade - o usuario clica Excluir e nada some.
224:             SET DELETED ON
225:             SET EXACT ON
226: 
227:             *-- Produto ausente eh erro de USO (o dialogo so existe para um
228:             *-- produto), mas NAO em modo validacao/teste - o harness instancia
229:             *-- o form sem argumento nenhum so para montar a UI.
230:             IF EMPTY(THIS.this_cCodProduto) AND !loc_lModoValidacaoOuTeste
231:                 MsgErro("Produto n" + CHR(227) + "o informado para gerenciar " + ;
232:                         "tamanhos.", "Erro Formsigprtam")
233:             ELSE
234:                 THIS.this_oBusinessObject = CREATEOBJECT("sigprtamBO")
235: 
236:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
237:                     MsgErro("Erro ao criar Business Object de Tamanhos do Produto." + CHR(13) + ;
238:                             "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
239:                 ELSE

*-- Linhas 251 a 269:
251:                     THIS.ConfigurarCabecalho()
252: 
253:                     *-- Grade (Column1..Column6) - so estrutura, sem
254:                     *-- ControlSource ainda (cursor_4c_Dados so existe depois
255:                     *-- do CarregarLista - regra #41)
256:                     THIS.ConfigurarGrid()
257: 
258:                     *-- Celulas da grade com When/Valid proprios: lookup de
259:                     *-- Tamanho (Column1/Column2), calculo Percentual<->Valor
260:                     *-- (Column4/Column5) e commit de Peso/Entrega
261:                     *-- (Column3/Column6)
262:                     THIS.InstalarCelulasGrade()
263: 
264:                     *-- Botoes de acao (cmd_4c_Inserir/cmd_4c_Excluir/cmd_4c_Sair)
265:                     *-- - criados DEPOIS do cabecalho para desenhar por cima dele
266:                     *-- (Top=3, dentro da faixa Top=0..80 - regra #11)
267:                     THIS.ConfigurarBotoes()
268: 
269:                     *-- AddObject cria controles com Visible=.F. por padrao

*-- Linhas 395 a 414:
395:             .FontSize           = 8
396:             .AllowHeaderSizing  = .F.
397:             .AllowRowSizing     = .F.
398:             .AllowCellSelection = .T.
399:             .DeleteMark         = .F.
400:             .RecordMark         = .F.
401:             .RowHeight          = 17
402:             .ScrollBars         = 2
403:             .GridLineColor      = RGB(238, 238, 238)
404:             .ColumnCount        = 6
405: 
406:             *-- Column1 = CodTams (SigPrTam.codtams char(4) - FK SigCdTam.cods)
407:             .Column1.FontName          = "Tahoma"
408:             .Column1.FontSize          = 8
409:             .Column1.Width             = 38
410:             .Column1.Movable           = .F.
411:             .Column1.Resizable         = .F.
412:             .Column1.Header1.FontName  = "Tahoma"
413:             .Column1.Header1.FontSize  = 8
414:             .Column1.Header1.Alignment = 2

*-- Linhas 521 a 540:
521:     * CurrentControl + Sparse = .F. (regra #18).
522:     *
523:     * Chamado em ConfigurarGrid (criacao) e DE NOVO no fim de CarregarLista:
524:     * o BO recria cursor_4c_Dados (USE IN + SQLEXEC + INTO CURSOR), e
525:     * re-vincular RecordSource/ControlSource reseta propriedades de Column -
526:     * CurrentControl e Sparse entre elas. O AddObject so acontece na primeira
527:     * vez (PEMSTATUS): repetir AddObject com o mesmo nome estoura "Object is
528:     * already defined".
529:     *--------------------------------------------------------------------------
530:     PROTECTED PROCEDURE InstalarCelulasGrade()
531:         LOCAL loc_oCol, loc_oTxt
532: 
533:         *-- Column1 = CodTams - lookup de tamanho por CODIGO (SigCdTam.cods)
534:         loc_oCol = THIS.grd_4c_Dados.Column1
535:         IF !PEMSTATUS(loc_oCol, "txt_4c_CelCodTam", 5)
536:             loc_oCol.AddObject("txt_4c_CelCodTam", "TextBoxCelulaTamanho_4c")
537:         ENDIF
538:         loc_oTxt = loc_oCol.txt_4c_CelCodTam
539:         WITH loc_oTxt
540:             .this_cPapel = "COD"

*-- Linhas 769 a 787:
769:             RETURN .T.
770:         ENDIF
771: 
772:         SELECT cursor_4c_Dados
773:         loc_cCidChaves = ALLTRIM(cidchaves)
774: 
775:         IF EMPTY(loc_cValorAtual)
776:             *-- Legado: replace CodTams with [], Descs with []
777:             THIS.LimparCampos()
778:             par_oTxt.Value = ""
779:         ELSE
780:             loc_lOk = THIS.ResolverTamanhoSelecionado(loc_cValorAtual, loc_cCidChaves, ;
781:                                                       par_cCampoBusca, par_oTxt)
782:         ENDIF
783: 
784:         par_oTxt.Tag = ALLTRIM(TRANSFORM(par_oTxt.Value))
785: 
786:         THIS.grd_4c_Dados.Refresh()
787: 

*-- Linhas 808 a 826:
808:             RETURN .T.
809:         ENDIF
810: 
811:         SELECT cursor_4c_Dados
812: 
813:         *-- O cursor so recebe o digitado DEPOIS do Valid (regra #46) - e a
814:         *-- gravacao le do cursor, entao a celula vai para la agora
815:         REPLACE percs WITH loc_nValorCelula IN cursor_4c_Dados
816: 
817:         IF loc_nValorCelula != 0
818:             loc_nPerc  = loc_nValorCelula
819:             loc_nValor = THIS.this_nPrecoVenda + (THIS.this_nPrecoVenda * (loc_nPerc / 100))
820:             REPLACE valor WITH loc_nValor IN cursor_4c_Dados
821:         ENDIF
822: 
823:         THIS.this_nValorAnterior = loc_nValorCelula
824: 
825:         THIS.GravarLinhaAtual()
826:         THIS.grd_4c_Dados.Refresh()

*-- Linhas 848 a 866:
848:             RETURN .T.
849:         ENDIF
850: 
851:         SELECT cursor_4c_Dados
852: 
853:         IF loc_nValorCelula != 0
854:             loc_nValor = loc_nValorCelula
855:             loc_nPerc  = 0
856: 
857:             IF EMPTY(THIS.this_nPrecoVenda)
858:                 MsgAviso("Favor Informar o Pre" + CHR(231) + "o de Venda do Produto.", "Aviso")
859:                 loc_nValor     = 0
860:                 par_oTxt.Value = loc_nValor
861:             ENDIF
862: 
863:             IF THIS.this_nPrecoVenda != 0
864:                 loc_nPerc = ((loc_nValor - THIS.this_nPrecoVenda) / THIS.this_nPrecoVenda) * 100
865:             ENDIF
866: 

*-- Linhas 881 a 916:
881:     *--------------------------------------------------------------------------
882:     * GravarCelulaNumericaExec - Valid das celulas Peso Medio (Column3) e
883:     * Entrega (Column6). O legado nao tem Valid nelas: a gravacao vinha do
884:     * TABLEUPDATE do form pai, que compartilhava a DataSession. Aqui a
885:     * DataSession eh PRIVADA, entao a persistencia tem de ser explicita -
886:     * senao o que o usuario digita nessas duas colunas se perde ao encerrar.
887:     * PUBLIC - alvo do despachante (regra #3/#51).
888:     *--------------------------------------------------------------------------
889:     FUNCTION GravarCelulaNumericaExec(par_oTxt, par_cCampo)
890:         LOCAL loc_nValorCelula, loc_nAnterior, loc_lPeso
891: 
892:         loc_lPeso        = (VARTYPE(par_cCampo) = "C" AND UPPER(ALLTRIM(par_cCampo)) == "PESO")
893:         loc_nValorCelula = IIF(VARTYPE(par_oTxt.Value) = "N", par_oTxt.Value, ;
894:                                VAL(TRANSFORM(par_oTxt.Value)))
895:         loc_nAnterior    = IIF(loc_lPeso, THIS.this_nPesoAnterior, THIS.this_nPrazoAnterior)
896: 
897:         IF loc_nValorCelula = loc_nAnterior
898:             RETURN .T.
899:         ENDIF
900: 
901:         SELECT cursor_4c_Dados
902: 
903:         IF loc_lPeso
904:             REPLACE pesoms WITH loc_nValorCelula IN cursor_4c_Dados
905:             THIS.this_nPesoAnterior = loc_nValorCelula
906:         ELSE
907:             REPLACE diasprz WITH loc_nValorCelula IN cursor_4c_Dados
908:             THIS.this_nPrazoAnterior = loc_nValorCelula
909:         ENDIF
910: 
911:         THIS.GravarLinhaAtual()
912: 
913:         RETURN .T.
914:     ENDFUNC
915: 
916:     *--------------------------------------------------------------------------

*-- Linhas 939 a 975:
939:                               UPPER(ALLTRIM(par_cPapel)) == "DESC", "descs", "cods")
940:         loc_cValor      = ALLTRIM(TRANSFORM(par_oTxt.Value))
941: 
942:         SELECT cursor_4c_Dados
943:         loc_cCidChaves = ALLTRIM(cidchaves)
944: 
945:         THIS.ResolverTamanhoSelecionado(loc_cValor, loc_cCidChaves, loc_cCampoBusca, par_oTxt)
946: 
947:         *-- Sincroniza o Tag: o Valid que vem logo a seguir (ao sair da
948:         *-- celula) nao pode reabrir o picker pelo valor que o F4 acabou de
949:         *-- resolver
950:         par_oTxt.Tag = ALLTRIM(TRANSFORM(par_oTxt.Value))
951: 
952:         THIS.grd_4c_Dados.Refresh()
953:     ENDPROC
954: 
955:     *--------------------------------------------------------------------------
956:     * ResolverTamanhoSelecionado - Tenta o match EXATO em SigCdTam (por cods
957:     * ou por descs, conforme par_cCampoBusca); sem match, abre o picker
958:     * (AbrirLookupTamanho). Com o tamanho resolvido, confere duplicidade
959:     * contra as demais linhas do MESMO produto antes de gravar - igual ao
960:     * "Select ... Where a.CodTams = CrListaRemota.Cods And a.cIdChaves <>
961:     * crSigPrTam.cIdChaves" dos dois Valid legado.
962:     *
963:     * Devolve .F. SO no caso de duplicidade, que eh o unico "Return .F." dos
964:     * Valid do legado (o foco fica na celula e a linha nao eh alterada).
965:     *
966:     * As comparacoes de cidchaves/codtams levam ALLTRIM dos DOIS lados: o
967:     * cursor guarda char(20)/char(4) com padding e o config.prg roda com
968:     * SET EXACT ON, onde "valor padded" == "valor trimado" eh sempre .F. -
969:     * sem o ALLTRIM a propria linha corrente contaria como duplicata de si
970:     * mesma e nenhum tamanho poderia ser escolhido.
971:     *--------------------------------------------------------------------------
972:     PROTECTED FUNCTION ResolverTamanhoSelecionado(par_cValor, par_cCidChaves, par_cCampoBusca, par_oTxt)
973:         LOCAL loc_cSQL, loc_nResultado, loc_lAchou, loc_cCodigoSel, loc_cDescrSel
974:         LOCAL loc_lDuplicado, loc_cCampoBusca, loc_lOk
975: 

*-- Linhas 985 a 1006:
985:         ENDIF
986: 
987:         IF !EMPTY(ALLTRIM(par_cValor))
988:             loc_cSQL = "SELECT cods, descs FROM SigCdTam WHERE " + loc_cCampoBusca + " = " + ;
989:                        EscaparSQL(par_cValor)
990: 
991:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpTamExato")
992: 
993:             IF loc_nResultado > 0 AND USED("cursor_4c_LkpTamExato") AND ;
994:                RECCOUNT("cursor_4c_LkpTamExato") = 1
995:                 loc_cCodigoSel = ALLTRIM(cursor_4c_LkpTamExato.cods)
996:                 loc_cDescrSel  = ALLTRIM(cursor_4c_LkpTamExato.descs)
997:                 loc_lAchou     = .T.
998:             ENDIF
999: 
1000:             IF USED("cursor_4c_LkpTamExato")
1001:                 USE IN cursor_4c_LkpTamExato
1002:             ENDIF
1003:         ENDIF
1004: 
1005:         IF !loc_lAchou
1006:             IF THIS.AbrirLookupTamanho(par_cValor, loc_cCampoBusca)

*-- Linhas 1012 a 1069:
1012: 
1013:         *-- O picker eh MODAL e mexe no ponteiro de outras areas - voltar
1014:         *-- para a linha que estava sendo editada ANTES de qualquer REPLACE
1015:         SELECT cursor_4c_Dados
1016:         LOCATE FOR ALLTRIM(cidchaves) == ALLTRIM(par_cCidChaves)
1017: 
1018:         IF !loc_lAchou
1019:             *-- Legado: ESC no picker -> replace CodTams/Descs com vazio
1020:             THIS.LimparCampos()
1021:             IF VARTYPE(par_oTxt) = "O"
1022:                 par_oTxt.Value = ""
1023:             ENDIF
1024:             RETURN .T.
1025:         ENDIF
1026: 
1027:         loc_lDuplicado = .F.
1028:         SELECT cursor_4c_Dados
1029:         SCAN FOR ALLTRIM(codtams) == loc_cCodigoSel AND ;
1030:                  ALLTRIM(cidchaves) <> ALLTRIM(par_cCidChaves)
1031:             loc_lDuplicado = .T.
1032:             EXIT
1033:         ENDSCAN
1034: 
1035:         SELECT cursor_4c_Dados
1036:         LOCATE FOR ALLTRIM(cidchaves) == ALLTRIM(par_cCidChaves)
1037: 
1038:         IF loc_lDuplicado
1039:             MsgAviso("Tamanho j" + CHR(225) + " informado para este produto!", ;
1040:                      "Aten" + CHR(231) + CHR(227) + "o")
1041:             *-- Legado: Return .F. - a linha NAO eh alterada e o foco fica na
1042:             *-- celula para o usuario corrigir
1043:             loc_lOk = .F.
1044:         ELSE
1045:             REPLACE codtams WITH loc_cCodigoSel, descs WITH loc_cDescrSel IN cursor_4c_Dados
1046: 
1047:             *-- O valor resolvido tem de voltar para a CELULA tambem, senao o
1048:             *-- texto digitado sobrescreve o cursor ao fim do Valid (regra #46)
1049:             IF VARTYPE(par_oTxt) = "O"
1050:                 par_oTxt.Value = IIF(loc_cCampoBusca == "descs", loc_cDescrSel, loc_cCodigoSel)
1051:             ENDIF
1052: 
1053:             *-- Grava em SigPrTam na hora (INSERT na linha nova, UPDATE na que
1054:             *-- veio do CarregarLista) - o legado delegava ao TABLEUPDATE do
1055:             *-- form pai; esta DataSession eh propria, entao a gravacao tem de
1056:             *-- ser explicita, senao a escolha do usuario se perde ao encerrar.
1057:             THIS.GravarLinhaAtual()
1058:         ENDIF
1059: 
1060:         RETURN loc_lOk
1061:     ENDFUNC
1062: 
1063:     *--------------------------------------------------------------------------
1064:     * AbrirLookupTamanho - Picker de tamanhos (SigCdTam) - transcricao do
1065:     *   CreateObject('fwbuscaext', <conn>, 'SigCdTam', 'CrListaRemota',
1066:     *                 'Cods'|'Descs', This.Value, 'Selecao', .t.)
1067:     * dos DOIS Valid do legado. Ao contrario do lookup de Caracteristicas
1068:     * (FormSigPrCar), o legado NAO filtra por grupo do produto aqui.
1069:     *--------------------------------------------------------------------------

*-- Linhas 1088 a 1128:
1088: 
1089:         TRY
1090:             IF USED(loc_cCursor)
1091:                 USE IN SELECT(loc_cCursor)
1092:             ENDIF
1093: 
1094:             IF !EMPTY(loc_cValor)
1095:                 loc_cSQL = "SELECT cods AS Cods, descs AS Descs FROM SigCdTam" + ;
1096:                            " WHERE (cods LIKE " + EscaparSQL(loc_cValor + "%") + ;
1097:                            " OR descs LIKE " + EscaparSQL(loc_cValor + "%") + ")" + ;
1098:                            " ORDER BY " + loc_cCampo
1099:             ELSE
1100:                 loc_cSQL = "SELECT cods AS Cods, descs AS Descs FROM SigCdTam" + ;
1101:                            " ORDER BY " + loc_cCampo
1102:             ENDIF
1103: 
1104:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
1105: 
1106:             *-- Fallback SHOW-ALL: o prefixo nao casou nada - mostrar todos os
1107:             *-- tamanhos em vez de abrir o picker vazio
1108:             IF loc_nResultado > 0 AND USED(loc_cCursor) AND ;
1109:                RECCOUNT(loc_cCursor) = 0 AND !EMPTY(loc_cValor)
1110:                 USE IN SELECT(loc_cCursor)
1111:                 loc_cSQL = "SELECT cods AS Cods, descs AS Descs FROM SigCdTam" + ;
1112:                            " ORDER BY " + loc_cCampo
1113:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
1114:             ENDIF
1115: 
1116:             IF loc_nResultado < 0
1117:                 MsgErro("Erro ao consultar tamanhos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1118:             ELSE
1119:                 IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
1120:                     MsgAviso("Nenhum tamanho dispon" + CHR(237) + "vel.", loc_cTitulo)
1121:                 ELSE
1122:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1123: 
1124:                     IF VARTYPE(loc_oBusca) = "O"
1125:                         loc_oBusca.DefinirCursor(loc_cCursor, "Cods", "Descs", loc_cTitulo)
1126: 
1127:                         loc_oBusca.this_nColunas = 0
1128:                         IF loc_cCampo == "descs"

*-- Linhas 1146 a 1221:
1146:             ENDIF
1147: 
1148:             IF USED(loc_cCursor)
1149:                 USE IN SELECT(loc_cCursor)
1150:             ENDIF
1151:         CATCH TO loc_oErro
1152:             MsgErro("Erro ao abrir a busca de tamanhos:" + CHR(13) + ;
1153:                     loc_oErro.Message + CHR(13) + ;
1154:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1155:                     "Procedure: " + loc_oErro.Procedure, "Erro")
1156:             IF USED(loc_cCursor)
1157:                 USE IN SELECT(loc_cCursor)
1158:             ENDIF
1159:         ENDTRY
1160: 
1161:         THIS.this_lLookupAberto = .F.
1162: 
1163:         RETURN loc_lSelecionou
1164:     ENDFUNC
1165: 
1166:     *--------------------------------------------------------------------------
1167:     * FormParaBO - Transfere a LINHA CORRENTE da grade para o BO. Reusa
1168:     * sigprtamBO.CarregarDoCursor (ja faz SELECT (alias) + TratarNulo campo a
1169:     * campo) em vez de duplicar a leitura aqui.
1170:     * PROTECTED por heranca de FormBase (regra #3/#51) - chamado so de dentro
1171:     * da classe (GravarLinhaAtual).
1172:     *--------------------------------------------------------------------------
1173:     PROTECTED PROCEDURE FormParaBO()
1174:         IF !USED("cursor_4c_Dados") OR VARTYPE(THIS.this_oBusinessObject) != "O"
1175:             RETURN .F.
1176:         ENDIF
1177: 
1178:         SELECT cursor_4c_Dados
1179:         IF EOF()
1180:             RETURN .F.
1181:         ENDIF
1182: 
1183:         RETURN THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
1184:     ENDPROC
1185: 
1186:     *--------------------------------------------------------------------------
1187:     * BOParaForm - Sentido inverso: escreve as propriedades do BO na LINHA
1188:     * CORRENTE da grade. Chamado depois de um Salvar() bem-sucedido, para a
1189:     * grade exibir o que o BO efetivamente levou ao banco (em especial o
1190:     * cidchaves, se o BO tiver precisado gera-lo).
1191:     * PROTECTED por heranca de FormBase - chamado so de dentro (GravarLinhaAtual).
1192:     *--------------------------------------------------------------------------
1193:     PROTECTED PROCEDURE BOParaForm()
1194:         IF !USED("cursor_4c_Dados") OR VARTYPE(THIS.this_oBusinessObject) != "O"
1195:             RETURN .F.
1196:         ENDIF
1197: 
1198:         SELECT cursor_4c_Dados
1199:         IF EOF()
1200:             RETURN .F.
1201:         ENDIF
1202: 
1203:         *-- Cobertura: as OITO colunas que ESTA tela pode alterar. As tres
1204:         *-- restantes de SigPrTam (dataalts/datatrans/dtmovs) ficam de fora
1205:         *-- DE PROPOSITO: nao tem controle na tela, o BO as le no
1206:         *-- CarregarDoCursor e as devolve INTACTAS no UPDATE/INSERT, logo
1207:         *-- reescreve-las no cursor seria no-op. Pior, a property e a coluna
1208:         *-- podem divergir de tipo (DATE vazia na linha nascida do APPEND
1209:         *-- BLANK x datetime do cursor), o que so criaria risco de "Data type
1210:         *-- mismatch" sem nada em troca.
1211:         WITH THIS.this_oBusinessObject
1212:             REPLACE cidchaves WITH .this_cCidChaves, ;
1213:                     codtams   WITH .this_cCodTams, ;
1214:                     cpros     WITH .this_cCpros, ;
1215:                     pesoms    WITH .this_nPesoMs, ;
1216:                     percs     WITH .this_nPercs, ;
1217:                     valor     WITH .this_nValor, ;
1218:                     diasprz   WITH .this_nDiasPrz, ;
1219:                     descs     WITH .this_cDescs ;
1220:                  IN cursor_4c_Dados
1221:         ENDWITH

*-- Linhas 1238 a 1299:
1238:             RETURN .F.
1239:         ENDIF
1240: 
1241:         SELECT cursor_4c_Dados
1242:         IF EOF()
1243:             RETURN .F.
1244:         ENDIF
1245: 
1246:         REPLACE codtams WITH "", descs WITH "" IN cursor_4c_Dados
1247: 
1248:         RETURN .T.
1249:     ENDPROC
1250: 
1251:     *--------------------------------------------------------------------------
1252:     * GravarLinhaAtual - Persiste em SigPrTam a LINHA CORRENTE da grade.
1253:     * INSERT quando a linha nasceu nesta sessao (BtnInserirClick), UPDATE
1254:     * quando ja veio do CarregarLista ou ja foi gravada antes. So grava
1255:     * quando CodTams ja foi resolvido (linha ainda em branco nao tem o que
1256:     * persistir - mesma condicao implicita do legado, que so comecava a
1257:     * fazer sentido depois do Tamanho escolhido).
1258:     * PUBLIC - chamado pelos handlers de celula.
1259:     *--------------------------------------------------------------------------
1260:     PROCEDURE GravarLinhaAtual()
1261:         LOCAL loc_cCidChaves, loc_lNovo, loc_lSucesso
1262:         loc_lSucesso = .F.
1263: 
1264:         IF !USED("cursor_4c_Dados") OR VARTYPE(THIS.this_oBusinessObject) != "O"
1265:             RETURN .F.
1266:         ENDIF
1267: 
1268:         SELECT cursor_4c_Dados
1269:         IF EOF() OR EMPTY(ALLTRIM(codtams))
1270:             RETURN .F.
1271:         ENDIF
1272: 
1273:         loc_cCidChaves = ALLTRIM(cidchaves)
1274:         loc_lNovo      = THIS.EhRegistroNovo(loc_cCidChaves)
1275: 
1276:         IF loc_lNovo
1277:             *-- NovoRegistro() chama LimparDados() - preencher DEPOIS dele
1278:             THIS.this_oBusinessObject.NovoRegistro()
1279:         ELSE
1280:             THIS.this_oBusinessObject.this_lNovoRegistro = .F.
1281:             THIS.this_oBusinessObject.EditarRegistro()
1282:         ENDIF
1283: 
1284:         SELECT cursor_4c_Dados
1285:         *-- ALLTRIM dos DOIS lados: medido no VFP9, "<char(20) padded> ==
1286:         *-- <valor trimado>" eh .F. sempre (o == compara o comprimento
1287:         *-- tambem, independente de SET EXACT). Sem isto o LOCATE falha em
1288:         *-- toda chave mais curta que 20 e a gravacao devolve .F. em silencio.
1289:         LOCATE FOR ALLTRIM(cidchaves) == ALLTRIM(loc_cCidChaves)
1290:         IF !FOUND()
1291:             RETURN .F.
1292:         ENDIF
1293: 
1294:         IF !THIS.FormParaBO()
1295:             RETURN .F.
1296:         ENDIF
1297: 
1298:         IF THIS.this_oBusinessObject.Salvar()
1299:             loc_lSucesso = .T.

*-- Linhas 1327 a 1497:
1327:         ENDIF
1328: 
1329:         *-- Cursor recem-lido do banco: toda linha existe em SigPrTam, logo
1330:         *-- nao ha mais pendencia de INSERT
1331:         THIS.this_cCidChavesNovos = ""
1332: 
1333:         IF USED("cursor_4c_Dados")
1334:             SELECT cursor_4c_Dados
1335:             GO TOP
1336: 
1337:             *-- RecordSource com referencia EXPLICITA, FORA de WITH (regra
1338:             *-- #36/#41)
1339:             THIS.grd_4c_Dados.RecordSource = ""
1340: 
1341:             *-- ColumnCount TEM de ser reposto ANTES do RecordSource: o
1342:             *-- Buscar() do BO faz "USE IN cursor_4c_Dados" + recria o alias,
1343:             *-- e derrubar o alias ligado a grade ZERA o ColumnCount. Medido
1344:             *-- no VFP9 (2026-10-19): 6 -> 0 no USE IN e, religando sem
1345:             *-- repor, o VFP auto-expande para as 11 COLUNAS do cursor -
1346:             *-- a grade passa a exibir cidchaves/cpros/dataalts/datatrans/
1347:             *-- dtmovs crus a direita das seis colunas do legado, sem erro e
1348:             *-- sem log. Reatribuir ColumnCount destroi os controles postos
1349:             *-- por AddObject nas Columns, mas InstalarCelulasGrade() logo
1350:             *-- abaixo os reinstala (guarda PEMSTATUS).
1351:             THIS.grd_4c_Dados.ColumnCount  = 6
1352: 
1353:             THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
1354:             THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.codtams"
1355:             THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Dados.descs"
1356:             THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Dados.pesoms"
1357:             THIS.grd_4c_Dados.Column4.ControlSource = "cursor_4c_Dados.percs"
1358:             THIS.grd_4c_Dados.Column5.ControlSource = "cursor_4c_Dados.valor"
1359:             THIS.grd_4c_Dados.Column6.ControlSource = "cursor_4c_Dados.diasprz"
1360: 
1361:             *-- RecordSource/ControlSource resetam Width e Header1.Caption -
1362:             *-- reconfigurar SEMPRE depois de vincular (regra #48)
1363:             THIS.grd_4c_Dados.Column1.Width           = 38
1364:             THIS.grd_4c_Dados.Column1.Header1.Caption = "Tam."
1365:             THIS.grd_4c_Dados.Column2.Width           = 216
1366:             THIS.grd_4c_Dados.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1367:             THIS.grd_4c_Dados.Column3.Width           = 100
1368:             THIS.grd_4c_Dados.Column3.Header1.Caption = "Peso M" + CHR(233) + "dio"
1369:             THIS.grd_4c_Dados.Column4.Width           = 80
1370:             THIS.grd_4c_Dados.Column4.Header1.Caption = "Percentual"
1371:             THIS.grd_4c_Dados.Column5.Width           = 100
1372:             THIS.grd_4c_Dados.Column5.Header1.Caption = "Valor"
1373:             THIS.grd_4c_Dados.Column6.Width           = 60
1374:             THIS.grd_4c_Dados.Column6.Header1.Caption = "Entrega"
1375: 
1376:             *-- Re-vincular RecordSource/ControlSource reseta propriedades de
1377:             *-- Column - CurrentControl e Sparse entre elas. Sem reinstalar,
1378:             *-- a coluna volta a desenhar o Text1 nativo e o When/Valid das
1379:             *-- celulas (lookup de Tamanho, calculo Percentual<->Valor) para
1380:             *-- de rodar, sem erro nenhum na tela.
1381:             THIS.InstalarCelulasGrade()
1382: 
1383:             *-- Column.ReadOnly tambem se perde no rebind - reaplicar o modo
1384:             THIS.HabilitarCampos(INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR"))
1385: 
1386:             THIS.grd_4c_Dados.Refresh()
1387:         ENDIF
1388: 
1389:         RETURN loc_lSucesso
1390:     ENDPROC
1391: 
1392:     *--------------------------------------------------------------------------
1393:     * CarregarDadosProduto - Le SigCdPro.Dpros/PVens/PCuss do produto
1394:     * corrente - equivalente ao "Select Dpros, pvens, pcuss From SigCdPro
1395:     * Where Cpros = ..." do Init legado (pdPro/crSigCdPro.PVens/PCuss),
1396:     * usado pelo calculo Percentual<->Valor das celulas da grade.
1397:     *--------------------------------------------------------------------------
1398:     PROTECTED PROCEDURE CarregarDadosProduto()
1399:         LOCAL loc_cSQL, loc_nResultado, loc_oErro
1400: 
1401:         TRY
1402:             IF USED("cursor_4c_DadosProduto")
1403:                 USE IN cursor_4c_DadosProduto
1404:             ENDIF
1405: 
1406:             loc_cSQL = "SELECT Dpros, PVens, PCuss FROM SigCdPro WHERE Cpros = " + ;
1407:                        EscaparSQL(THIS.this_cCodProduto)
1408: 
1409:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosProduto")
1410: 
1411:             IF loc_nResultado > 0 AND USED("cursor_4c_DadosProduto") AND ;
1412:                RECCOUNT("cursor_4c_DadosProduto") > 0
1413:                 THIS.this_cDescProduto = TratarNulo(cursor_4c_DadosProduto.Dpros, "")
1414:                 THIS.this_nPrecoVenda  = TratarNulo(cursor_4c_DadosProduto.PVens, 0)
1415:                 THIS.this_nPrecoCusto  = TratarNulo(cursor_4c_DadosProduto.PCuss, 0)
1416:             ENDIF
1417: 
1418:             IF USED("cursor_4c_DadosProduto")
1419:                 USE IN cursor_4c_DadosProduto
1420:             ENDIF
1421:         CATCH TO loc_oErro
1422:             MsgErro("Erro ao ler dados do produto: " + loc_oErro.Message, "Erro")
1423:         ENDTRY
1424:     ENDPROC
1425: 
1426:     *--------------------------------------------------------------------------
1427:     * BtnInserirClick - Espelha cmdInserir.Click do legado: garante UMA
1428:     * linha em branco (CodTams vazio) para o usuario preencher via lookup.
1429:     * Legado: Locate For cPros=crSigCdPro.cPros And CodTams=Space(4) / If
1430:     * Eof() / Insert Into crSigPrTam (cPros, CidChaves) Values (...)
1431:     * PUBLIC - alvo de BINDEVENT (regra #3)
1432:     *--------------------------------------------------------------------------
1433:     PROCEDURE BtnInserirClick()
1434:         LOCAL loc_cCidNovo
1435: 
1436:         IF !USED("cursor_4c_Dados")
1437:             RETURN
1438:         ENDIF
1439: 
1440:         THIS.this_lHouveIncl = .T.
1441: 
1442:         SELECT cursor_4c_Dados
1443:         LOCATE FOR ALLTRIM(cpros) == ALLTRIM(THIS.this_cCodProduto) AND EMPTY(codtams)
1444: 
1445:         IF !FOUND()
1446:             loc_cCidNovo = fUniqueIds()
1447: 
1448:             APPEND BLANK
1449:             REPLACE cpros     WITH THIS.this_cCodProduto, ;
1450:                     cidchaves WITH loc_cCidNovo, ;
1451:                     codtams   WITH "", ;
1452:                     descs     WITH "", ;
1453:                     pesoms    WITH 0, ;
1454:                     percs     WITH 0, ;
1455:                     valor     WITH 0, ;
1456:                     diasprz   WITH 0
1457: 
1458:             *-- Linha existe so no cursor local ate o usuario escolher o
1459:             *-- tamanho (GravarLinhaAtual faz o INSERT)
1460:             THIS.RegistrarCidChaveNova(loc_cCidNovo)
1461:         ENDIF
1462: 
1463:         *-- Popular o cursor NAO repinta a grade (regra #21)
1464:         THIS.grd_4c_Dados.Refresh()
1465:         THIS.grd_4c_Dados.Column1.SetFocus()
1466:     ENDPROC
1467: 
1468:     *--------------------------------------------------------------------------
1469:     * BtnExcluirClick - Espelha cmdExcluir.Click do legado. Linha ja
1470:     * persistida (CodTams preenchido, ja gravada) eh excluida de verdade via
1471:     * BO (gravacao nunca eh muda); linha ainda em edicao (CodTams vazio,
1472:     * nunca gravada) eh so removida do cursor local.
1473:     * PUBLIC - alvo de BINDEVENT (regra #3)
1474:     *--------------------------------------------------------------------------
1475:     PROCEDURE BtnExcluirClick()
1476:         LOCAL loc_cCidChaves, loc_lRemover
1477: 
1478:         IF !USED("cursor_4c_Dados")
1479:             RETURN
1480:         ENDIF
1481: 
1482:         SELECT cursor_4c_Dados
1483:         IF EOF()
1484:             RETURN
1485:         ENDIF
1486: 
1487:         *-- Guard do legado: "If Not Eof() And (crSigPrTam.cPros =
1488:         *-- crSigCdPro.cPros)" - so apaga linha do produto corrente
1489:         IF ALLTRIM(cpros) != ALLTRIM(THIS.this_cCodProduto)
1490:             RETURN
1491:         ENDIF
1492: 
1493:         loc_cCidChaves = ALLTRIM(cidchaves)
1494: 
1495:         loc_lRemover = .T.
1496: 
1497:         IF !EMPTY(codtams) AND !THIS.EhRegistroNovo(loc_cCidChaves)

*-- Linhas 1513 a 1555:
1513: 
1514:         IF loc_lRemover
1515:             *-- Remocao LOCAL nos DOIS casos (linha persistida e linha em
1516:             *-- branco), exatamente como o legado: "Delete / Skip / Skip -1"
1517:             *-- do cmdExcluir.Click.
1518:             *--
1519:             *-- NAO recarregar a grade do banco aqui. O SELECT do BO traz
1520:             *-- "SPACE(20) AS descs" - transcricao do "Space(40) as Descs" do
1521:             *-- Init legado, porque a Descricao do tamanho so eh resolvida em
1522:             *-- runtime pelo lookup da celula. Um CarregarLista() no meio do
1523:             *-- dialogo APAGARIA a Descricao ja resolvida em TODAS as outras
1524:             *-- linhas (o usuario apaga uma linha e a coluna Descricao das
1525:             *-- demais fica em branco, sem erro nenhum) e ainda descartaria a
1526:             *-- linha em branco que BtnInserirClick acabou de criar (e que
1527:             *-- ainda nao foi gravada) junto com o cidchaves dela em
1528:             *-- this_cCidChavesNovos.
1529:             *--
1530:             *-- Reposicionar ANTES do DELETE: Excluir() do BO roda SQLEXEC
1531:             *-- (DELETE + INSERT da auditoria), e o DELETE/SKIP abaixo age na
1532:             *-- area de trabalho CORRENTE - sem o SELECT/LOCATE o apagamento
1533:             *-- poderia cair na linha errada.
1534:             SELECT cursor_4c_Dados
1535:             LOCATE FOR ALLTRIM(cidchaves) == ALLTRIM(loc_cCidChaves)
1536: 
1537:             IF FOUND()
1538:                 THIS.RemoverCidChaveNova(loc_cCidChaves)
1539: 
1540:                 DELETE
1541:                 SKIP
1542:                 SKIP -1
1543: 
1544:                 THIS.this_lHouveExcl = .T.
1545: 
1546:                 *-- Popular/alterar o cursor NAO repinta a grade (regra #21)
1547:                 THIS.grd_4c_Dados.Refresh()
1548:             ENDIF
1549:         ENDIF
1550:     ENDPROC
1551: 
1552:     *--------------------------------------------------------------------------
1553:     * BtnSairClick - Espelha cmdSair.Click do legado: em modo INSERIR/ALTERAR,
1554:     * exige que TODA linha tenha CodTams preenchido antes de encerrar (sem
1555:     * limpeza silenciosa - o legado ABORTA o fechamento com aviso e foca a

*-- Linhas 1562 a 1598:
1562:            INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
1563: 
1564:             IF USED("cursor_4c_Dados")
1565:                 SELECT cursor_4c_Dados
1566:                 SCAN
1567:                     IF EMPTY(codtams)
1568:                         MsgAviso("Tamanho n" + CHR(227) + "o informado!", ;
1569:                                   "Aten" + CHR(231) + CHR(227) + "o")
1570:                         THIS.grd_4c_Dados.Column1.SetFocus()
1571:                         RETURN
1572:                     ENDIF
1573:                 ENDSCAN
1574:             ENDIF
1575:         ENDIF
1576: 
1577:         THIS.Release()
1578:     ENDPROC
1579: 
1580:     *--------------------------------------------------------------------------
1581:     * RegistrarCidChaveNova/RemoverCidChaveNova/EhRegistroNovo - Controle das
1582:     * linhas criadas nesta sessao e ainda sem registro em SigPrTam (logo:
1583:     * INSERT ao gravar, exclusao apenas local ao apagar).
1584:     * PUBLIC - usados pelos handlers de botao/celula.
1585:     *--------------------------------------------------------------------------
1586:     PROCEDURE RegistrarCidChaveNova(par_cCidChaves)
1587:         LOCAL loc_cCid
1588:         loc_cCid = IIF(VARTYPE(par_cCidChaves) = "C", ALLTRIM(par_cCidChaves), "")
1589: 
1590:         IF !EMPTY(loc_cCid) AND !THIS.EhRegistroNovo(loc_cCid)
1591:             THIS.this_cCidChavesNovos = THIS.this_cCidChavesNovos + "|" + loc_cCid + "|"
1592:         ENDIF
1593:     ENDPROC
1594: 
1595:     PROCEDURE RemoverCidChaveNova(par_cCidChaves)
1596:         LOCAL loc_cCid
1597:         loc_cCid = IIF(VARTYPE(par_cCidChaves) = "C", ALLTRIM(par_cCidChaves), "")
1598: 


### BO (C:\4c\projeto\app\classes\sigprtamBO.prg):
*==============================================================================
* sigprtamBO.prg - Business Object para Tamanhos do Produto (SIGPRTAM)
* Tabela Principal: SigPrTam (PK: cidchaves)
* Tabela Relacionada: SigCdTam (cadastro de tamanhos - cods/descs/varias)
*
* SIGPRTAM e um dialogo filho chamado pelo cadastro de produtos para
* manter a grade de tamanhos (codigo, descricao, peso medio, percentual,
* valor e prazo de entrega) de UM produto por vez (filtro por cpros).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS sigprtamBO AS BusinessBase

    *-- Propriedades: SigPrTam
    this_cCidChaves  = ""   && cidchaves char(20) NOT NULL - PK
    this_cCodTams    = ""   && codtams   char(4)  NOT NULL - FK SigCdTam.cods
    this_cCpros      = ""   && cpros     char(14) NOT NULL - FK SigCdPro.cPros (produto filtrado)
    this_dDataAlts   = {}   && dataalts  datetime NULL
    this_dDataTrans  = {}   && datatrans datetime NULL
    this_dDtMovs     = {}   && dtmovs    datetime NULL
    this_nPesoMs     = 0    && pesoms    numeric(7,3) NOT NULL - peso medio do tamanho
    this_nPercs      = 0    && percs     numeric(5,2) NOT NULL - percentual sobre o preco de venda
    this_nValor      = 0    && valor     numeric(11,5) NOT NULL - valor calculado a partir do percentual
    this_nDiasPrz    = 0    && diasprz   numeric(2,0) NOT NULL - prazo de entrega em dias

    *-- Propriedade NAO persistida: descricao do tamanho (join com SigCdTam.descs)
    this_cDescs      = ""   && descs char(20) - vem de SigCdTam, exibida na grade

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigPrTam"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades a partir de uma linha do
    * cursor (cursor_4c_Dados, populado pelo Form a partir de SigPrTam)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                THIS.this_cCodTams   = TratarNulo(codtams,   "")
                THIS.this_cCpros     = TratarNulo(cpros,     "")
                THIS.this_dDataAlts  = TratarNulo(dataalts,  {})
                THIS.this_dDataTrans = TratarNulo(datatrans, {})
                THIS.this_dDtMovs    = TratarNulo(dtmovs,    {})
                THIS.this_nPesoMs    = TratarNulo(pesoms,    0)
                THIS.this_nPercs     = TratarNulo(percs,     0)
                THIS.this_nValor     = TratarNulo(valor,     0)
                THIS.this_nDiasPrz   = TratarNulo(diasprz,   0)

                * Descs vem de um JOIN com SigCdTam (nao existe na tabela
                * SigPrTam) - so esta presente quando o SELECT do Form a traz
                IF TYPE("descs") = "C"
                    THIS.this_cDescs = TratarNulo(descs, "")
                ELSE
                    THIS.this_cDescs = ""
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigprtamBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria de SigPrTam (cidchaves)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigPrTam (novo tamanho para o produto filtrado)
    * O legado gera a PK com fUniqueIds() no clique do botao Inserir, antes
    * de o usuario preencher qualquer coluna da grade (regra #22).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTam (cidchaves, codtams, cpros, dataalts, datatrans, dtmovs, pesoms, percs, valor, diasprz)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(THIS.this_cCodTams)>>,
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<FormatarDataSQL(THIS.this_dDataAlts)>>,
                    <<FormatarDataSQL(THIS.this_dDataTrans)>>,
                    <<FormatarDataSQL(THIS.this_dDtMovs)>>,
                    <<FormatarNumeroSQL(THIS.this_nPesoMs, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nPercs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nValor, 5)>>,
                    <<FormatarNumeroSQL(THIS.this_nDiasPrz, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir tamanho do produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "sigprtamBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigPrTam (cpros e cidchaves nao mudam depois do
    * Inserir - sao a chave e o filtro de origem do registro)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTam
                SET codtams   = <<EscaparSQL(THIS.this_cCodTams)>>,
                    dataalts  = <<FormatarDataSQL(THIS.this_dDataAlts)>>,
                    datatrans = <<FormatarDataSQL(THIS.this_dDataTrans)>>,
                    dtmovs    = <<FormatarDataSQL(THIS.this_dDtMovs)>>,
                    pesoms    = <<FormatarNumeroSQL(THIS.this_nPesoMs, 3)>>,
                    percs     = <<FormatarNumeroSQL(THIS.this_nPercs, 2)>>,
                    valor     = <<FormatarNumeroSQL(THIS.this_nValor, 5)>>,
                    diasprz   = <<FormatarNumeroSQL(THIS.this_nDiasPrz, 0)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar tamanho do produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "sigprtamBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigPrTam (equivalente ao Delete do
    * cursor buferizado no cmdExcluir.Click do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrTam WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir tamanho do produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "sigprtamBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca os tamanhos vinculados a um produto (par_cCpros).
    * Retorna cursor_4c_Dados com cidchaves/codtams/cpros/.../descs.
    *
    * NAO faz JOIN com SigCdTam para preencher descs: o legado tambem nao
    * faz (Init: "Select a.*, Space(40) as Descs From SigPrTam a Where
    * a.cPros = ...") - a descricao so e preenchida em runtime pelo lookup
    * da celula de Codigo/Descricao (Column1/Column2.Text1.Valid), nunca
    * pela carga inicial. Transcricao literal (CLAUDE.md regra #17).
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cidchaves, codtams, cpros, dataalts, datatrans, dtmovs,
                       pesoms, percs, valor, diasprz, SPACE(20) AS descs
                FROM SigPrTam
                WHERE cpros = <<EscaparSQL(par_cCpros)>>
            ENDTEXT

            * SQLEXEC cria cursor SOMENTE-LEITURA - a grade precisa inserir
            * (Inserir) e apagar (Excluir) linhas localmente, alem de editar
            * peso/percentual/valor/prazo, entao o resultado eh copiado para
            * um cursor READWRITE (CLAUDE.md: "Grid com coluna EDITAVEL
            * exige cursor READWRITE")
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado >= 0
                SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao buscar tamanhos do produto:" + CHR(13) + ;
                        THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "sigprtamBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

