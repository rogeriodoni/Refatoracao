# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 4289: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoppro.prg) - TRECHOS RELEVANTES PARA PASS GRID (6402 linhas total):

*-- Linhas 161 a 179:
161:                 *-- AfterRowColChange: handler DECLARA par_nColIndex porque o
162:                 *-- evento passa o argumento (regra #3). Uso de LINHA corrente
163:                 *-- (carregar o detalhe), nunca validacao de celula (regra #46).
164:                 BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, ;
165:                           "GradeAfterRowColChange")
166: 
167:                 THIS.TornarControlesVisiveis(THIS)
168:                 THIS.ReaplicarVisibilidadeInicial()
169:                 THIS.AplicarModoNaGrade()
170:                 THIS.AjustarBotoesPorModo()
171:                 THIS.HabilitarCampos(INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR"))
172: 
173:                 THIS.pgf_4c_Paginas.Visible    = .T.
174:                 THIS.pgf_4c_Paginas.ActivePage = 1
175: 
176:                 *-- Carga da grade: pulada em validacao de UI/modo teste (sem
177:                 *-- gnConnHandle a consulta nao tem como rodar).
178:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
179:                     IF TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste

*-- Linhas 806 a 835:
806: 
807:     *==========================================================================
808:     * CriarCursorItens - Cursor de trabalho (espelha crTpmMvItn do legado),
809:     * compartilhado pela grade grd_4c_Dados e pelo sigopproBO.CarregarDoCursor.
810:     * Mantido num unico CREATE CURSOR para que as paginas de Dados/Fiscal/
811:     * Precificacao (fases seguintes) liguem campos nele sem recriar a
812:     * estrutura (regra #41 - Column.ControlSource exige o cursor ja existir).
813:     *==========================================================================
814:     PROTECTED PROCEDURE CriarCursorItens()
815:         IF USED("cursor_4c_Itens")
816:             USE IN cursor_4c_Itens
817:         ENDIF
818: 
819:         SET NULL ON
820:         CREATE CURSOR cursor_4c_Itens ( ;
821:             cidchaves C(20), citens N(10,0), cpros C(14), dpros C(65), ;
822:             codbarras N(14,0), cunis C(3), cunips C(3), fators N(8,3), ;
823:             opers C(1), qtds N(9,3), pesos N(9,3), units N(15,6), ;
824:             moedas C(3), totas N(11,2), tpesos N(11,2), abrevis C(3), ;
825:             locals C(10), localos C(10), compris N(6,2), qtreservas N(9,3), ;
826:             ckpresente N(1,0), codcors C(4), codtams C(4), servicos N(1,0), ;
827:             aqtds N(9,3), datatrans T NULL, descvals N(7,2), dopes C(20), ;
828:             emps C(3), etiesps L, fatvals N(15,6), fvals L, iconfs L, ;
829:             moefats C(3), moevals N(15,6), notas C(6), nrcons C(10), ;
830:             ntrans N(6,0), numes N(6,0), numolds N(6,0), obs M NULL, ;
831:             qtbaixas N(9,3), qtbxprods N(9,3), qtprods N(9,3), ;
832:             unitembs N(11,4), univals N(15,6), vcoms N(8,2), aliqs N(4,2), ;
833:             sitribs C(2), tpipis C(1), valipis N(11,2), aliqicms N(5,2), ;
834:             valdescs N(9,2), empos C(3), moevs C(3), utilizas N(4,0), ;
835:             ncodigos N(10,0), nlotes N(10,0), dtalts T NULL, empdopnums C(29), ;

*-- Linhas 851 a 1138:
851:             gravacao C(20), ifors C(10), propriedades C(40) NULL, ;
852:             unidade1 C(15) NULL, resultado1 C(15) NULL, valorMinimo C(15) NULL, ;
853:             valorMaximo C(15) NULL, metodoReferencia1 C(15) NULL)
854:         SET NULL OFF
855: 
856:         INDEX ON citens TAG citens
857: 
858:         *-- SET DELETED eh escopado por DATA SESSION e este form eh
859:         *-- DataSession = 2: na sessao privada ele volta ao default OFF, e com
860:         *-- OFF a linha excluida do cursor CONTINUA aparecendo na grade (que
861:         *-- tem DeleteMark = .F., entao nem a marca de exclusao denuncia) e
862:         *-- ainda eh contada por COUNT/SCAN. A exclusao de linha e a
863:         *-- renumeracao dos itens dependem disso.
864:         SET DELETED ON
865:     ENDPROC
866: 
867:     *==========================================================================
868:     * ConfigurarGridDados - grd_4c_Dados (fwGrade do legado): grade principal
869:     * de itens da movimentacao, 22 colunas na mesma ordem/largura do dump.
870:     *==========================================================================
871:     PROTECTED PROCEDURE ConfigurarGridDados()
872:         THIS.AddObject("grd_4c_Dados", "Grid")
873:         WITH THIS.grd_4c_Dados
874:             .Top               = 122
875:             .Left              = 7
876:             .Width             = 1035
877:             .Height            = 233
878:             .ColumnCount       = 22
879:             .RecordSource      = "cursor_4c_Itens"
880:             .FontName          = "Courier New"
881:             .FontSize          = 9
882:             .HeaderHeight      = 16
883:             .RowHeight         = 16
884:             .AllowHeaderSizing = .F.
885:             .DeleteMark        = .F.
886:             .RecordMark        = .F.
887:             .ScrollBars        = 3
888:             .GridLineColor     = RGB(238, 238, 238)
889:             .ToolTipText       = "Grade de Produtos"
890:         ENDWITH
891: 
892:         *-- Column1: PRODUTO (estilo link - sublinhado/azul, igual ao legado)
893:         WITH THIS.grd_4c_Dados.Column1
894:             .ControlSource     = "cursor_4c_Itens.cpros"
895:             .Width             = 108
896:             .FontBold          = .T.
897:             .FontName          = "Courier New"
898:             .FontSize          = 9
899:             .FontUnderline     = .T.
900:             .ForeColor         = RGB(0, 0, 255)
901:             .Format            = "K!"
902:             .InputMask         = REPLICATE("!", 14)
903:             .Header1.FontBold  = .T.
904:             .Header1.FontName  = "Arial"
905:             .Header1.FontSize  = 8
906:             .Header1.Alignment = 2
907:             .Header1.Caption   = "Produto"
908:         ENDWITH
909: 
910:         *-- Column2: FATOR
911:         WITH THIS.grd_4c_Dados.Column2
912:             .ControlSource     = "cursor_4c_Itens.fators"
913:             .Width             = 50
914:             .InputMask         = "99999.999"
915:             .Header1.Alignment = 2
916:             .Header1.Caption   = "Fator"
917:         ENDWITH
918: 
919:         *-- Column3: OPERACAO (Format=M -> InputMask eh a LISTA, regra #24)
920:         WITH THIS.grd_4c_Dados.Column3
921:             .ControlSource     = "cursor_4c_Itens.opers"
922:             .Width             = 14
923:             .Format            = "M"
924:             .InputMask         = "E,S"
925:             .Header1.Caption   = "Op"
926:         ENDWITH
927: 
928:         *-- Column4: QTD
929:         WITH THIS.grd_4c_Dados.Column4
930:             .ControlSource     = "cursor_4c_Itens.qtds"
931:             .Width             = 64
932:             .InputMask         = "99999.999"
933:             .Header1.Alignment = 2
934:             .Header1.Caption   = "Qtd."
935:         ENDWITH
936: 
937:         *-- Column5: PESO
938:         WITH THIS.grd_4c_Dados.Column5
939:             .ControlSource     = "cursor_4c_Itens.pesos"
940:             .Width             = 60
941:             .InputMask         = "99999.999"
942:             .Header1.Alignment = 2
943:             .Header1.Caption   = "Peso"
944:         ENDWITH
945: 
946:         *-- Column6: VALOR
947:         WITH THIS.grd_4c_Dados.Column6
948:             .ControlSource     = "cursor_4c_Itens.units"
949:             .Width             = 90
950:             .InputMask         = "99999999.99"
951:             .Header1.Alignment = 2
952:             .Header1.Caption   = "Valor"
953:         ENDWITH
954: 
955:         *-- Column7: MOEDA
956:         WITH THIS.grd_4c_Dados.Column7
957:             .ControlSource     = "cursor_4c_Itens.moedas"
958:             .Width             = 24
959:             .Header1.Alignment = 2
960:             .Header1.Caption   = "Moe"
961:         ENDWITH
962: 
963:         *-- Column8: TOTAL
964:         WITH THIS.grd_4c_Dados.Column8
965:             .ControlSource     = "cursor_4c_Itens.totas"
966:             .Width             = 107
967:             .InputMask         = "9999999999.99"
968:             .Header1.Alignment = 2
969:             .Header1.Caption   = "Total"
970:         ENDWITH
971: 
972:         *-- Column9: pesotot
973:         WITH THIS.grd_4c_Dados.Column9
974:             .ControlSource     = "cursor_4c_Itens.tpesos"
975:             .Width             = 64
976:             .InputMask         = "9999999.99"
977:             .Header1.Alignment = 2
978:             .Header1.Caption   = "Total Peso"
979:         ENDWITH
980: 
981:         *-- Column10: item (numero sequencial, sem legenda no legado)
982:         WITH THIS.grd_4c_Dados.Column10
983:             .ControlSource     = "cursor_4c_Itens.citens"
984:             .Width             = 31
985:             .InputMask         = "9999"
986:             .Header1.Caption   = ""
987:         ENDWITH
988: 
989:         *-- Column11: UNIDADE
990:         WITH THIS.grd_4c_Dados.Column11
991:             .ControlSource     = "cursor_4c_Itens.cunis"
992:             .Width             = 30
993:             .Header1.Alignment = 2
994:             .Header1.Caption   = "Uni"
995:         ENDWITH
996: 
997:         *-- Column12: UNIPESO (desabilitada, igual ao legado)
998:         WITH THIS.grd_4c_Dados.Column12
999:             .ControlSource     = "cursor_4c_Itens.cunips"
1000:             .Width             = 31
1001:             .Enabled           = .F.
1002:             .Header1.Alignment = 2
1003:             .Header1.Caption   = "Uni"
1004:         ENDWITH
1005: 
1006:         *-- Column13: PEDIDO
1007:         WITH THIS.grd_4c_Dados.Column13
1008:             .ControlSource     = "cursor_4c_Itens.abrevis"
1009:             .Width             = 40
1010:             .Header1.Alignment = 2
1011:             .Header1.Caption   = "Ped"
1012:         ENDWITH
1013: 
1014:         *-- Column14: DESCRS
1015:         WITH THIS.grd_4c_Dados.Column14
1016:             .ControlSource     = "cursor_4c_Itens.dpros"
1017:             .Width             = 290
1018:             .Header1.Alignment = 2
1019:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1020:         ENDWITH
1021: 
1022:         *-- Column15: cor
1023:         WITH THIS.grd_4c_Dados.Column15
1024:             .ControlSource     = "cursor_4c_Itens.codcors"
1025:             .Width             = 24
1026:             .Header1.Alignment = 2
1027:             .Header1.Caption   = "Cor"
1028:         ENDWITH
1029: 
1030:         *-- Column16: Local
1031:         WITH THIS.grd_4c_Dados.Column16
1032:             .ControlSource     = "cursor_4c_Itens.locals"
1033:             .Width             = 80
1034:             .Header1.Alignment = 2
1035:             .Header1.Caption   = "Local"
1036:         ENDWITH
1037: 
1038:         *-- Column17: Comprimento
1039:         WITH THIS.grd_4c_Dados.Column17
1040:             .ControlSource     = "cursor_4c_Itens.compris"
1041:             .Width             = 50
1042:             .InputMask         = "9999.99"
1043:             .Header1.Alignment = 2
1044:             .Header1.Caption   = "Compr."
1045:         ENDWITH
1046: 
1047:         *-- Column18: LocalO
1048:         WITH THIS.grd_4c_Dados.Column18
1049:             .ControlSource     = "cursor_4c_Itens.localos"
1050:             .Width             = 80
1051:             .Header1.Alignment = 2
1052:             .Header1.Caption   = "Local Ori"
1053:         ENDWITH
1054: 
1055:         *-- Column19: Tamanho
1056:         WITH THIS.grd_4c_Dados.Column19
1057:             .ControlSource     = "cursor_4c_Itens.codtams"
1058:             .Width             = 35
1059:             .Header1.Alignment = 2
1060:             .Header1.Caption   = "Tam."
1061:         ENDWITH
1062: 
1063:         *-- Column20: Reserva (ReadOnly, igual ao legado)
1064:         WITH THIS.grd_4c_Dados.Column20
1065:             .ControlSource     = "cursor_4c_Itens.qtreservas"
1066:             .Width             = 64
1067:             .ReadOnly          = .T.
1068:             .InputMask         = "999999.999"
1069:             .Header1.Alignment = 2
1070:             .Header1.Caption   = "Reserva"
1071:         ENDWITH
1072: 
1073:         *-- Column21 (Presente) e Column22 (O.S.): CheckBox de coluna.
1074:         *-- Aqui so o BIND e a largura/header. O AddObject do CheckBox roda
1075:         *-- DEPOIS, em InstalarCheckBoxesGrade(), porque Column.AddObject de
1076:         *-- CheckBox ESTOURA enquanto a coluna estiver ligada (pelo auto-bind
1077:         *-- do RecordSource) a um campo de outro tipo: com ColumnCount = 22 o
1078:         *-- VFP liga Column22 ao 22o campo do cursor, que eh codcors C(4), e
1079:         *-- adicionar um controle numerico ali da
1080:         *-- "Error with CHK_4C_SERVICO - Value : Data type mismatch."
1081:         *-- A falha eh TOTAL e MUDA: cai no TRY do InicializarForm, que
1082:         *-- devolve .F., CREATEOBJECT devolve o logico .F. e a tela
1083:         *-- simplesmente nao abre - sem erro na tela e sem log.
1084:         WITH THIS.grd_4c_Dados.Column21
1085:             .ControlSource     = "cursor_4c_Itens.ckpresente"
1086:             .Width             = 50
1087:             .Header1.Alignment = 2
1088:             .Header1.Caption   = "Presente"
1089:         ENDWITH
1090: 
1091:         WITH THIS.grd_4c_Dados.Column22
1092:             .ControlSource     = "cursor_4c_Itens.servicos"
1093:             .Width             = 50
1094:             .Header1.Alignment = 2
1095:             .Header1.Caption   = "O.S."
1096:         ENDWITH
1097: 
1098:         *-- Todas as colunas ja estao bindadas: agora os CheckBox.
1099:         THIS.InstalarCheckBoxesGrade()
1100:     ENDPROC
1101: 
1102:     *==========================================================================
1103:     * InstalarCheckBoxesGrade - Instala os CheckBox das colunas Presente e
1104:     * O.S. na ordem que o VFP9 exige (medido): ColumnCount -> RecordSource ->
1105:     * ControlSource de TODAS as colunas -> Column.AddObject + Value ->
1106:     * Sparse + CurrentControl. Invertido, o AddObject estoura por causa do
1107:     * auto-bind do RecordSource (ver comentario em ConfigurarGridDados).
1108:     *
1109:     * IDEMPOTENTE e vive no funil: reatribuir RecordSource/ColumnCount ou
1110:     * fechar o alias destroi os objetos postos na Column, entao a instalacao
1111:     * tem de poder rodar de novo sem duplicar o AddObject.
1112:     *==========================================================================
1113:     PROTECTED PROCEDURE InstalarCheckBoxesGrade()
1114:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1115:             RETURN
1116:         ENDIF
1117: 
1118:         IF THIS.grd_4c_Dados.ColumnCount < 22
1119:             RETURN
1120:         ENDIF
1121: 
1122:         THIS.InstalarCheckBoxColuna(THIS.grd_4c_Dados.Column21, "chk_4c_Presente")
1123:         THIS.InstalarCheckBoxColuna(THIS.grd_4c_Dados.Column22, "chk_4c_Servico")
1124:     ENDPROC
1125: 
1126:     *==========================================================================
1127:     * InstalarCheckBoxColuna - Poe UM CheckBox numa Column. Propriedades: so
1128:     * as que o VFP9 de fato aplica em controle de Column criado em runtime
1129:     * (Caption/Alignment/ReadOnly/Visible/FontName/FontSize/Value). Top/Left/
1130:     * Width/Height sao DESCARTADAS nesse contexto - escrever a geometria do
1131:     * dump aqui eh codigo morto que sugere area clicavel calibrada.
1132:     *==========================================================================
1133:     PROTECTED PROCEDURE InstalarCheckBoxColuna(par_oColuna, par_cNomeChk)
1134:         IF VARTYPE(par_oColuna) <> "O" OR VARTYPE(par_cNomeChk) <> "C"
1135:             RETURN
1136:         ENDIF
1137: 
1138:         IF !PEMSTATUS(par_oColuna, par_cNomeChk, 5)

*-- Linhas 1719 a 1737:
1719:         *-- Page4 (pgPrecos): a grade de precificacao nasce oculta no legado.
1720:         *-- Mesmo nome do grid principal (eh o que o mapeamento do form manda),
1721:         *-- mas outro PAI - o caminho completo nao deixa ambiguidade.
1722:         THIS.pgf_4c_Paginas.Page4.grd_4c_Dados.Visible = .F.
1723:     ENDPROC
1724: 
1725:     *==========================================================================
1726:     * AjustarBotoesPorModo - Espelha os guards When do legado (InList sobre
1727:     * Op_Escolha + linha corrente na grade). Chamado no fim de InicializarForm
1728:     * e deve ser repetido apos qualquer troca de modo/linha (regra #40).
1729:     * PUBLIC: o TesteAutomatico chama THIS.oForm.AjustarBotoesPorModo() de
1730:     * FORA da classe, e PEMSTATUS(...,5) devolve .T. mesmo para PROTECTED
1731:     * (so testa existencia, nao escopo) - entao o harness entraria no branch
1732:     * e a chamada estouraria em runtime (regra #3).
1733:     *==========================================================================
1734:     PROCEDURE AjustarBotoesPorModo()
1735:         LOCAL loc_lEdicao, loc_lTemLinha
1736: 
1737:         loc_lEdicao   = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")

*-- Linhas 1806 a 1824:
1806:     *
1807:     * O BO le para um cursor TEMPORARIO e aqui o alias da grade eh recarregado
1808:     * com SELECT/ZAP/APPEND FROM DBF(): SQLEXEC direto sobre o alias ligado ao
1809:     * Grid o FECHA e RECRIA, zerando o ColumnCount - a grade viraria um
1810:     * retangulo branco sem cabecalho, sem erro e sem log.
1811:     *==========================================================================
1812:     PROCEDURE CarregarDados()
1813:         LOCAL loc_lSucesso, loc_cChave, loc_oErro
1814: 
1815:         loc_lSucesso = .F.
1816: 
1817:         IF !USED("cursor_4c_Itens")
1818:             THIS.CriarCursorItens()
1819:         ENDIF
1820: 
1821:         loc_cChave = THIS.ObterChaveMovimentacao()
1822: 
1823:         IF EMPTY(loc_cChave)
1824:             *-- Sem movimentacao selecionada a grade abre VAZIA, como no legado

*-- Linhas 1912 a 1950:
1912:         SELECT cursor_4c_Itens
1913:         GO TOP
1914: 
1915:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1916:             *-- Reinstala os CheckBox de coluna antes de repintar: se algo
1917:             *-- tiver reatribuido RecordSource/ColumnCount ou fechado o
1918:             *-- alias, os objetos postos nas Columns foram destruidos. A
1919:             *-- instalacao eh idempotente.
1920:             THIS.InstalarCheckBoxesGrade()
1921:             THIS.grd_4c_Dados.Refresh()
1922:         ENDIF
1923:     ENDPROC
1924: 
1925:     *==========================================================================
1926:     * ZaparCursorItens - ZAP guardado por SAFETY. SET SAFETY eh escopado por
1927:     * DATA SESSION: este form eh DataSession = 2, e na sessao privada SAFETY
1928:     * vale ON mesmo com o SET SAFETY OFF do main.prg. Com SAFETY ON o ZAP
1929:     * abre o dialogo modal "Zap ... Are you sure?" e CONGELA a tela,
1930:     * esperando um clique que ninguem ve (nao eh erro: em teste headless
1931:     * aparece como timeout sem resultado).
1932:     *
1933:     * ZAP eh a escolha CERTA aqui (o legado faz "Zap In <cursor>"): preserva
1934:     * a estrutura e o binding do Grid. Fechar e recriar o alias derrubaria
1935:     * RecordSource/ControlSource e a grade ficaria vazia com o cursor cheio.
1936:     *==========================================================================
1937:     PROTECTED PROCEDURE ZaparCursorItens()
1938:         LOCAL loc_cSafety
1939: 
1940:         IF !USED("cursor_4c_Itens")
1941:             RETURN
1942:         ENDIF
1943: 
1944:         loc_cSafety = SET("SAFETY")
1945:         SET SAFETY OFF
1946: 
1947:         SELECT cursor_4c_Itens
1948:         ZAP
1949: 
1950:         IF loc_cSafety = "ON"

*-- Linhas 1969 a 1993:
1969:     PROCEDURE AplicarModoNaGrade()
1970:         LOCAL loc_lEditavel
1971: 
1972:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1973:             RETURN
1974:         ENDIF
1975: 
1976:         loc_lEditavel = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
1977: 
1978:         WITH THIS.grd_4c_Dados
1979:             .ReadOnly = !loc_lEditavel
1980:             .Enabled  = .T.
1981:             *-- Reserva eh ReadOnly tambem na grade editavel (legado:
1982:             *-- fwGrade.Column20.ReadOnly = .T.)
1983:             .Column20.ReadOnly = .T.
1984:         ENDWITH
1985:     ENDPROC
1986: 
1987:     *==========================================================================
1988:     * ObterChaveMovimentacao - empdopnums char(29) da movimentacao corrente.
1989:     * Vem do form pai de Movimentacao (TprMvCab no legado); enquanto a
1990:     * integracao com o pai nao esta conectada, cai na property do proprio
1991:     * form, que o chamador preenche antes do Show.
1992:     *==========================================================================
1993:     PROTECTED FUNCTION ObterChaveMovimentacao()

*-- Linhas 2382 a 2401:
2382:             loc_lOk = .F.
2383:             MsgAviso(loc_cMsg, loc_cTitulo)
2384: 
2385:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Visible
2386:                 THIS.grd_4c_Dados.SetFocus()
2387:             ENDIF
2388:         ENDIF
2389: 
2390:         RETURN loc_lOk
2391:     ENDPROC
2392: 
2393:     *==========================================================================
2394:     * BtnEncerrarClick - "Retornar" ao form pai (OK.btnSair do legado, que eh
2395:     * Cancel = .T. - ESC cai aqui). O legado valida os itens primeiro e, so
2396:     * passando, reabilita o pai e fecha:
2397:     *
2398:     *   ... validacoes ... If Not IsEmpty(lcMsg) / Messagebox / SetFocus / Return
2399:     *   If llOk / With Thisform.ParentForm / .Enabled = .T. / ... / Endwith / Endif
2400:     *   Thisform.Release
2401:     *

*-- Linhas 2448 a 2466:
2448:         ENDTRY
2449:         IF VARTYPE(loc_oForm) = "O"
2450:             loc_oForm.Show()
2451:             THIS.grd_4c_Dados.Refresh()
2452:         ENDIF
2453:     ENDPROC
2454: 
2455:     *-- "Alterar Impostos": habilita a pagina Fiscal e navega para ela
2456:     PROCEDURE BtnAltImpsClick()
2457:         IF !THIS.TemProdutoSelecionado()
2458:             MsgAviso("Selecione um Produto Na Grade para alterar impostos.", "Aten" + CHR(231) + CHR(227) + "o")
2459:             RETURN
2460:         ENDIF
2461:         THIS.pgf_4c_Paginas.Page3.Enabled = .T.
2462:         THIS.AlternarPagina(3)
2463:     ENDPROC
2464: 
2465:     *-- "Visualizar Impostos": toggle que leva a pagina Fiscal
2466:     PROCEDURE BtnVerImpsClick()

*-- Linhas 2505 a 2539:
2505:         ENDTRY
2506:         IF VARTYPE(loc_oForm) = "O"
2507:             loc_oForm.Show()
2508:             THIS.grd_4c_Dados.SetFocus()
2509:         ENDIF
2510:     ENDPROC
2511: 
2512:     *-- "Itens Subnivel": Do Form sigoppei With ThisForm, DataSessionId
2513:     PROCEDURE BtnIteSubClick()
2514:         LOCAL loc_oForm, loc_oErro
2515:         loc_oForm = .NULL.
2516:         TRY
2517:             loc_oForm = CREATEOBJECT("FormSigOpPei", THIS, THIS.DataSessionId)
2518:         CATCH TO loc_oErro
2519:             MostrarErro("Erro ao abrir Itens Subn" + CHR(237) + "vel:" + CHR(13) + loc_oErro.Message, "Erro")
2520:             loc_oForm = .NULL.
2521:         ENDTRY
2522:         IF VARTYPE(loc_oForm) = "O"
2523:             loc_oForm.Show()
2524:             THIS.grd_4c_Dados.Refresh()
2525:         ENDIF
2526:     ENDPROC
2527: 
2528:     *-- "Importar XML": zera a grade de itens e aciona a importacao
2529:     PROCEDURE CmdXmlClick()
2530:         IF !MsgConfirma("Importar XML ir" + CHR(225) + " substituir todos os itens da grade atual. Continuar?", "Confirmar")
2531:             RETURN
2532:         ENDIF
2533:         THIS.ZaparCursorItens()
2534:         THIS.RepintarGradeItens()
2535:         THIS.AjustarBotoesPorModo()
2536:     ENDPROC
2537: 
2538:     *-- "Carrega Cadastro": zera a grade de itens antes de carregar um lote
2539:     PROCEDURE BtncarregarClick()

*-- Linhas 2557 a 2597:
2557:         CATCH TO loc_oErro
2558:             MostrarErro("Erro ao retornar b" + CHR(244) + "nus:" + CHR(13) + loc_oErro.Message, "Erro")
2559:         ENDTRY
2560:         THIS.grd_4c_Dados.Refresh()
2561:     ENDPROC
2562: 
2563:     *==========================================================================
2564:     * Handlers dos botoes de cnt_4c_BotoesAcao (toolbar inferior, Top=359)
2565:     *==========================================================================
2566: 
2567:     *-- "Cadastro de Produtos": Do Form SigOpCgp (cadastro rapido na operacao)
2568:     PROCEDURE BtnCadProClick()
2569:         LOCAL loc_oForm, loc_oErro
2570:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") OR !THIS.TemProdutoSelecionado()
2571:             RETURN
2572:         ENDIF
2573:         loc_oForm = .NULL.
2574:         TRY
2575:             loc_oForm = CREATEOBJECT("FormSigOpCgp", THIS)
2576:         CATCH TO loc_oErro
2577:             MostrarErro("Erro ao abrir Cadastro de Produtos:" + CHR(13) + loc_oErro.Message, "Erro")
2578:             loc_oForm = .NULL.
2579:         ENDTRY
2580:         IF VARTYPE(loc_oForm) = "O"
2581:             loc_oForm.Show()
2582:             THIS.grd_4c_Dados.Refresh()
2583:         ENDIF
2584:     ENDPROC
2585: 
2586:     *-- "Exclusao de Produtos": remove a linha corrente da grade.
2587:     *-- Legado (btnPApaga.Click): guard de EOF -> DeletarItem() -> garante uma
2588:     *-- linha na grade -> renumera os itens (e as referencias de composicao)
2589:     *-- -> CItem = Cont -> Go Top -> fwGrade.Refresh + Produto.SetFocus.
2590:     *-- O legado NAO pede confirmacao: a exclusao eh de LINHA do cursor da
2591:     *-- grade, e a gravacao em SigMvItn so acontece quando o form pai confirma
2592:     *-- a movimentacao.
2593:     PROCEDURE BtnPApagaClick()
2594:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
2595:             MsgAviso("Posicione no Produto que Deseja Excluir ... ", "Nada a Fazer")
2596:             RETURN
2597:         ENDIF

*-- Linhas 2609 a 2688:
2609:         THIS.RepintarGradeItens()
2610:         THIS.AjustarBotoesPorModo()
2611: 
2612:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Visible
2613:             THIS.grd_4c_Dados.SetFocus()
2614:         ENDIF
2615:     ENDPROC
2616: 
2617:     *-- "Carregar Composicao": Do Form SigSubCp (composicao do produto)
2618:     PROCEDURE BtnComposClick()
2619:         LOCAL loc_oForm, loc_oErro
2620:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") OR !THIS.TemProdutoSelecionado()
2621:             RETURN
2622:         ENDIF
2623:         loc_oForm = .NULL.
2624:         TRY
2625:             loc_oForm = CREATEOBJECT("FormSigSubCp", THIS, ALLTRIM(cursor_4c_Itens.cpros), ;
2626:                                       cursor_4c_Itens.citens, THIS.DataSessionId)
2627:         CATCH TO loc_oErro
2628:             MostrarErro("Erro ao abrir Composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
2629:             loc_oForm = .NULL.
2630:         ENDTRY
2631:         IF VARTYPE(loc_oForm) = "O"
2632:             loc_oForm.Show()
2633:             THIS.grd_4c_Dados.Refresh()
2634:         ENDIF
2635:     ENDPROC
2636: 
2637:     *-- "Alteracao de Precos": libera o foco na coluna Valor da grade
2638:     PROCEDURE BtnAltPrecosClick()
2639:         IF !THIS.TemProdutoSelecionado()
2640:             MsgAviso("Selecione um Produto para Ter o Pre" + CHR(231) + "o Alterado.", "Aten" + CHR(231) + CHR(227) + "o")
2641:             RETURN
2642:         ENDIF
2643:         THIS.grd_4c_Dados.SetFocus()
2644:         THIS.grd_4c_Dados.ActiveColumn = 6
2645:     ENDPROC
2646: 
2647:     *-- "Procura de Produtos": abre o lookup de produto quando a linha
2648:     *-- corrente ainda nao tem codigo preenchido (igual ao legado)
2649:     PROCEDURE BtnPBuscasClick()
2650:         LOCAL loc_oBusca
2651: 
2652:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens") AND !EMPTY(cursor_4c_Itens.cpros)
2653:             MsgAviso("O c" + CHR(243) + "digo do Produto tem que estar vazio para acionar procura!!!", "Aten" + CHR(231) + CHR(227) + "o")
2654:             RETURN
2655:         ENDIF
2656: 
2657:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2658:                                    "cursor_4c_BuscaPro", "Cpros", "", "Produtos", .F., .T., "")
2659: 
2660:         IF VARTYPE(loc_oBusca) = "O"
2661:             IF !loc_oBusca.this_lAchouRegistro
2662:                 loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
2663:                 loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
2664:                 loc_oBusca.Show()
2665:             ENDIF
2666: 
2667:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro") AND USED("cursor_4c_Itens") ;
2668:                AND !EOF("cursor_4c_Itens")
2669:                 SELECT cursor_4c_BuscaPro
2670:                 SELECT cursor_4c_Itens
2671:                 REPLACE cpros WITH ALLTRIM(cursor_4c_BuscaPro.Cpros), ;
2672:                         dpros WITH ALLTRIM(cursor_4c_BuscaPro.Dpros)
2673:                 THIS.grd_4c_Dados.Refresh()
2674:             ENDIF
2675: 
2676:             loc_oBusca.Release()
2677:         ENDIF
2678: 
2679:         IF USED("cursor_4c_BuscaPro")
2680:             USE IN cursor_4c_BuscaPro
2681:         ENDIF
2682:     ENDPROC
2683: 
2684:     *-- "Informar Pedido": Do Form SigOpPed With ThisForm, DataSessionId
2685:     PROCEDURE BtnPedidoClick()
2686:         LOCAL loc_oForm, loc_oErro
2687:         IF !THIS.TemProdutoSelecionado()
2688:             MsgAviso("" + CHR(201) + " necess" + CHR(225) + "rio Posicionar no Produto para Localizar!!!", "Aviso")

*-- Linhas 2697 a 2738:
2697:         ENDTRY
2698:         IF VARTYPE(loc_oForm) = "O"
2699:             loc_oForm.Show()
2700:             THIS.grd_4c_Dados.Refresh()
2701:         ENDIF
2702:     ENDPROC
2703: 
2704:     *-- "Substituir Composicao": Do Form SigSubCp With ThisForm, Cpros,
2705:     *-- Citens, DataSessionId, CodTams (igual ao legado)
2706:     PROCEDURE BtnsubcpClick()
2707:         LOCAL loc_oForm, loc_oErro
2708:         IF !THIS.TemProdutoSelecionado()
2709:             MsgAviso("Selecione Um Produto Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o")
2710:             RETURN
2711:         ENDIF
2712:         loc_oForm = .NULL.
2713:         TRY
2714:             loc_oForm = CREATEOBJECT("FormSigSubCp", THIS, ALLTRIM(cursor_4c_Itens.cpros), ;
2715:                                       cursor_4c_Itens.citens, THIS.DataSessionId, ;
2716:                                       cursor_4c_Itens.codtams)
2717:         CATCH TO loc_oErro
2718:             MostrarErro("Erro ao abrir Substituir Composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
2719:             loc_oForm = .NULL.
2720:         ENDTRY
2721:         IF VARTYPE(loc_oForm) = "O"
2722:             loc_oForm.Show()
2723:             THIS.grd_4c_Dados.Refresh()
2724:         ENDIF
2725:     ENDPROC
2726: 
2727:     *-- "Detalhes": Do Form SigOpDet With ParentForm.PoDataMgr, Op_Escolha,
2728:     *-- TprMvCab.Dopes, Cpros, TprMvCab.EmpDopNums
2729:     PROCEDURE BtnDetClick()
2730:         LOCAL loc_oForm, loc_oErro
2731:         IF !THIS.TemProdutoSelecionado()
2732:             MsgAviso("Selecione Um Produto Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o")
2733:             RETURN
2734:         ENDIF
2735:         loc_oForm = .NULL.
2736:         TRY
2737:             loc_oForm = CREATEOBJECT("FormSigOpDet", THIS.this_oParentForm, THIS.this_cOpEscolha, ;
2738:                                       "", ALLTRIM(cursor_4c_Itens.cpros), "")

*-- Linhas 2780 a 2798:
2780:         ENDTRY
2781:         IF VARTYPE(loc_oForm) = "O"
2782:             loc_oForm.Show()
2783:             THIS.grd_4c_Dados.Refresh()
2784:         ENDIF
2785:     ENDPROC
2786: 
2787:     *-- "Local. Destino": Do Form SigOpLcl/SigOpLcZ With ..., 'DESTINO'
2788:     PROCEDURE BtnLocDesClick()
2789:         LOCAL loc_oForm, loc_oErro
2790:         IF !THIS.TemProdutoSelecionado()
2791:             MsgAviso("" + CHR(201) + " Necess" + CHR(225) + "rio Posicionar no Produto para Localizar!!!", "Aviso")
2792:             RETURN
2793:         ENDIF
2794:         loc_oForm = .NULL.
2795:         TRY
2796:             loc_oForm = CREATEOBJECT("FormSigOpLcl", THIS.this_oParentForm, THIS.this_cOpEscolha, "DESTINO")
2797:         CATCH TO loc_oErro
2798:             MostrarErro("Erro ao abrir Localiza" + CHR(231) + CHR(227) + "o de Destino:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 4249 a 4349:
4249:             USE IN cursor_4c_Precos
4250:         ENDIF
4251: 
4252:         SET NULL ON
4253:         CREATE CURSOR cursor_4c_Precos ( ;
4254:             lprecos C(30), tabds C(20), units N(11,2), moedas C(3))
4255:         SET NULL OFF
4256:     ENDPROC
4257: 
4258:     *==========================================================================
4259:     * ConfigurarPaginaPrecos - Page4 (pgPrecos no legado) "Precificacao".
4260:     *
4261:     * Grade grdPrecos: lista as precificacoes disponiveis para o produto do
4262:     * item corrente. Nasce Visible = .F. e ReadOnly = .T. no SCX legado (o
4263:     * proprio legado so a mostra quando a operacao trabalha com lista de
4264:     * precos), e por isso entra na lista de excecao de
4265:     * TornarControlesVisiveis / ReaplicarVisibilidadeInicial.
4266:     *
4267:     * Ordem de configuracao obrigatoria (regra #41 / Problema 48):
4268:     * ColumnCount -> RecordSource -> ControlSource -> Width -> Header.Caption.
4269:     *==========================================================================
4270:     PROTECTED PROCEDURE ConfigurarPaginaPrecos()
4271:         LOCAL loc_oPag, loc_oGrd
4272:         loc_oPag = THIS.pgf_4c_Paginas.Page4
4273: 
4274:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
4275:         loc_oGrd = loc_oPag.grd_4c_Dados
4276: 
4277:         WITH loc_oGrd
4278:             .Top                = 9
4279:             .Left               = 7
4280:             .Width              = 416
4281:             .Height             = 131
4282:             .ColumnCount        = 4
4283:             .DeleteMark         = .F.
4284:             .RecordMark         = .F.
4285:             .ScrollBars         = 2
4286:             .ReadOnly           = .T.
4287:             .AllowHeaderSizing  = .F.
4288:             .GridLineColor      = RGB(238, 238, 238)
4289:             .RecordSource       = "cursor_4c_Precos"
4290:             .Visible            = .F.
4291:         ENDWITH
4292: 
4293:         WITH loc_oGrd.Column1
4294:             .ControlSource   = "cursor_4c_Precos.lprecos"
4295:             .Width           = 210
4296:             .Movable         = .F.
4297:             .Resizable       = .F.
4298:             .ReadOnly        = .T.
4299:             .FontName        = "Courier New"
4300:             .Header1.Caption = "Lista de Precifica" + CHR(231) + CHR(227) + "o"
4301:             .Visible         = .T.
4302:         ENDWITH
4303: 
4304:         WITH loc_oGrd.Column2
4305:             .ControlSource   = "cursor_4c_Precos.tabds"
4306:             .Width           = 80
4307:             .Movable         = .F.
4308:             .Resizable       = .F.
4309:             .ReadOnly        = .T.
4310:             .FontName        = "Courier New"
4311:             .Header1.Caption = "Tab.Varia" + CHR(231) + CHR(227) + "o"
4312:             .Visible         = .T.
4313:         ENDWITH
4314: 
4315:         WITH loc_oGrd.Column3
4316:             .ControlSource   = "cursor_4c_Precos.units"
4317:             .Width           = 70
4318:             .Movable         = .F.
4319:             .Resizable       = .F.
4320:             .ReadOnly        = .T.
4321:             .FontName        = "Courier New"
4322:             .InputMask       = "9999,999.99"
4323:             .Header1.Caption = "Unit" + CHR(225) + "rio"
4324:             .Visible         = .T.
4325:         ENDWITH
4326: 
4327:         WITH loc_oGrd.Column4
4328:             .ControlSource   = "cursor_4c_Precos.moedas"
4329:             .Width           = 30
4330:             .Movable         = .F.
4331:             .Resizable       = .F.
4332:             .ReadOnly        = .T.
4333:             .FontName        = "Courier New"
4334:             .Header1.Caption = "Moe"
4335:             .Visible         = .T.
4336:         ENDWITH
4337: 
4338:         WITH loc_oGrd
4339:             .FontName = "Courier New"
4340:             .FontSize = 8
4341:             .HeaderHeight = 16
4342:             .RowHeight    = 16
4343:         ENDWITH
4344:     ENDPROC
4345: 
4346:     *==========================================================================
4347:     * CarregarPrecos - Recebe do form PAI as linhas da lista de precificacao e
4348:     * as entrega a grade de Page4.
4349:     *

*-- Linhas 4380 a 4409:
4380: 
4381:         TRY
4382:             *-- ZAP (nao fechar/recriar): fechar o alias derrubaria o
4383:             *-- RecordSource da grade e ela viraria um retangulo branco.
4384:             SELECT cursor_4c_Precos
4385:             THIS.ZaparCursor("cursor_4c_Precos")
4386: 
4387:             *-- APPEND FROM DBF casa os campos por NOME: o alias do pai tem de
4388:             *-- trazer lprecos/tabds/units/moedas.
4389:             SELECT cursor_4c_Precos
4390:             APPEND FROM DBF(ALLTRIM(par_cCursorOrigem))
4391: 
4392:             GO TOP IN cursor_4c_Precos
4393: 
4394:             WITH THIS.pgf_4c_Paginas.Page4.grd_4c_Dados
4395:                 .Visible = (RECCOUNT("cursor_4c_Precos") > 0)
4396:                 .Refresh()
4397:             ENDWITH
4398: 
4399:             loc_lSucesso = .T.
4400: 
4401:         CATCH TO loc_oErro
4402:             THIS.this_cMensagemErro = loc_oErro.Message
4403:             MsgErro("Erro ao carregar a lista de precifica" + CHR(231) + CHR(227) + ;
4404:                     "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
4405:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4406:                     "Proc: " + loc_oErro.Procedure, "Erro CarregarPrecos")
4407:         ENDTRY
4408: 
4409:         RETURN loc_lSucesso

*-- Linhas 4437 a 4455:
4437:     ENDPROC
4438: 
4439:     *==========================================================================
4440:     * GradeAfterRowColChange - Handler de AfterRowColChange de grd_4c_Dados.
4441:     *
4442:     * Declara par_nColIndex porque o evento passa esse argumento e handler sem
4443:     * o parametro estoura a cada troca de celula (regra #3). O uso aqui eh o
4444:     * MESMO do legado: carregar o detalhe da LINHA corrente, sem filtrar por
4445:     * coluna - validacao de celula NAO entra aqui (regra #46), ela mora no
4446:     * Valid do TextBox da coluna.
4447:     *
4448:     * PUBLIC: eh alvo de BINDEVENT e tambem do harness de teste.
4449:     *==========================================================================
4450:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
4451:         THIS.AtualizarPainelProduto()
4452:         THIS.AjustarBotoesPorModo()
4453:     ENDPROC
4454: 
4455:     *==========================================================================

*-- Linhas 4870 a 4888:
4870:             THIS.RepintarGradeItens()
4871:             SELECT cursor_4c_Itens
4872:             GO loc_nRecno
4873:             THIS.grd_4c_Dados.Refresh()
4874:         ELSE
4875:             MsgAviso("Item n" + CHR(227) + "o encontrado na grade.", "Procurar")
4876:         ENDIF
4877: 
4878:         THIS.this_lProcuraCB = .F.
4879: 
4880:         RETURN (loc_nRecno > 0)
4881:     ENDPROC
4882: 
4883:     *==========================================================================
4884:     * TxtProdLostFocus - Conferencia por codigo (get_prod do legado).
4885:     *
4886:     * O legado resolve o valor digitado nesta ordem (get_prod.Valid):
4887:     *   1. codigo de barras que JA esta numa linha da grade (Seek em
4888:     *      crTpmMvItn por codbarras) - marca ThisForm.Barra e usa o produto

