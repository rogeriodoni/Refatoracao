# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 4298: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoppro.prg) - TRECHOS RELEVANTES PARA PASS GRID (6488 linhas total):

*-- Linhas 168 a 186:
168:                 *-- AfterRowColChange: handler DECLARA par_nColIndex porque o
169:                 *-- evento passa o argumento (regra #3). Uso de LINHA corrente
170:                 *-- (carregar o detalhe), nunca validacao de celula (regra #46).
171:                 BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, ;
172:                           "GradeAfterRowColChange")
173: 
174:                 THIS.TornarControlesVisiveis(THIS)
175:                 THIS.ReaplicarVisibilidadeInicial()
176:                 THIS.AplicarModoNaGrade()
177:                 THIS.AjustarBotoesPorModo()
178:                 THIS.HabilitarCampos(INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR"))
179: 
180:                 THIS.pgf_4c_Paginas.Visible    = .T.
181:                 THIS.pgf_4c_Paginas.ActivePage = 1
182: 
183:                 *-- Carga da grade: pulada em validacao de UI/modo teste (sem
184:                 *-- gnConnHandle a consulta nao tem como rodar).
185:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
186:                     IF TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste

*-- Linhas 815 a 844:
815: 
816:     *==========================================================================
817:     * CriarCursorItens - Cursor de trabalho (espelha crTpmMvItn do legado),
818:     * compartilhado pela grade grd_4c_Dados e pelo sigopproBO.CarregarDoCursor.
819:     * Mantido num unico CREATE CURSOR para que as paginas de Dados/Fiscal/
820:     * Precificacao (fases seguintes) liguem campos nele sem recriar a
821:     * estrutura (regra #41 - Column.ControlSource exige o cursor ja existir).
822:     *==========================================================================
823:     PROTECTED PROCEDURE CriarCursorItens()
824:         IF USED("cursor_4c_Itens")
825:             USE IN cursor_4c_Itens
826:         ENDIF
827: 
828:         SET NULL ON
829:         CREATE CURSOR cursor_4c_Itens ( ;
830:             cidchaves C(20), citens N(10,0), cpros C(14), dpros C(65), ;
831:             codbarras N(14,0), cunis C(3), cunips C(3), fators N(8,3), ;
832:             opers C(1), qtds N(9,3), pesos N(9,3), units N(15,6), ;
833:             moedas C(3), totas N(11,2), tpesos N(11,2), abrevis C(3), ;
834:             locals C(10), localos C(10), compris N(6,2), qtreservas N(9,3), ;
835:             ckpresente N(1,0), codcors C(4), codtams C(4), servicos N(1,0), ;
836:             aqtds N(9,3), datatrans T NULL, descvals N(7,2), dopes C(20), ;
837:             emps C(3), etiesps L, fatvals N(15,6), fvals L, iconfs L, ;
838:             moefats C(3), moevals N(15,6), notas C(6), nrcons C(10), ;
839:             ntrans N(6,0), numes N(6,0), numolds N(6,0), obs M NULL, ;
840:             qtbaixas N(9,3), qtbxprods N(9,3), qtprods N(9,3), ;
841:             unitembs N(11,4), univals N(15,6), vcoms N(8,2), aliqs N(4,2), ;
842:             sitribs C(2), tpipis C(1), valipis N(11,2), aliqicms N(5,2), ;
843:             valdescs N(9,2), empos C(3), moevs C(3), utilizas N(4,0), ;
844:             ncodigos N(10,0), nlotes N(10,0), dtalts T NULL, empdopnums C(29), ;

*-- Linhas 860 a 1147:
860:             gravacao C(20), ifors C(10), propriedades C(40) NULL, ;
861:             unidade1 C(15) NULL, resultado1 C(15) NULL, valorMinimo C(15) NULL, ;
862:             valorMaximo C(15) NULL, metodoReferencia1 C(15) NULL)
863:         SET NULL OFF
864: 
865:         INDEX ON citens TAG citens
866: 
867:         *-- SET DELETED eh escopado por DATA SESSION e este form eh
868:         *-- DataSession = 2: na sessao privada ele volta ao default OFF, e com
869:         *-- OFF a linha excluida do cursor CONTINUA aparecendo na grade (que
870:         *-- tem DeleteMark = .F., entao nem a marca de exclusao denuncia) e
871:         *-- ainda eh contada por COUNT/SCAN. A exclusao de linha e a
872:         *-- renumeracao dos itens dependem disso.
873:         SET DELETED ON
874:     ENDPROC
875: 
876:     *==========================================================================
877:     * ConfigurarGridDados - grd_4c_Dados (fwGrade do legado): grade principal
878:     * de itens da movimentacao, 22 colunas na mesma ordem/largura do dump.
879:     *==========================================================================
880:     PROTECTED PROCEDURE ConfigurarGridDados()
881:         THIS.AddObject("grd_4c_Dados", "Grid")
882:         WITH THIS.grd_4c_Dados
883:             .Top               = 122
884:             .Left              = 7
885:             .Width             = 1035
886:             .Height            = 233
887:             .ColumnCount       = 22
888:             .RecordSource      = "cursor_4c_Itens"
889:             .FontName          = "Courier New"
890:             .FontSize          = 9
891:             .HeaderHeight      = 16
892:             .RowHeight         = 16
893:             .AllowHeaderSizing = .F.
894:             .DeleteMark        = .F.
895:             .RecordMark        = .F.
896:             .ScrollBars        = 3
897:             .GridLineColor     = RGB(238, 238, 238)
898:             .ToolTipText       = "Grade de Produtos"
899:         ENDWITH
900: 
901:         *-- Column1: PRODUTO (estilo link - sublinhado/azul, igual ao legado)
902:         WITH THIS.grd_4c_Dados.Column1
903:             .ControlSource     = "cursor_4c_Itens.cpros"
904:             .Width             = 108
905:             .FontBold          = .T.
906:             .FontName          = "Courier New"
907:             .FontSize          = 9
908:             .FontUnderline     = .T.
909:             .ForeColor         = RGB(0, 0, 255)
910:             .Format            = "K!"
911:             .InputMask         = REPLICATE("!", 14)
912:             .Header1.FontBold  = .T.
913:             .Header1.FontName  = "Arial"
914:             .Header1.FontSize  = 8
915:             .Header1.Alignment = 2
916:             .Header1.Caption   = "Produto"
917:         ENDWITH
918: 
919:         *-- Column2: FATOR
920:         WITH THIS.grd_4c_Dados.Column2
921:             .ControlSource     = "cursor_4c_Itens.fators"
922:             .Width             = 50
923:             .InputMask         = "99999.999"
924:             .Header1.Alignment = 2
925:             .Header1.Caption   = "Fator"
926:         ENDWITH
927: 
928:         *-- Column3: OPERACAO (Format=M -> InputMask eh a LISTA, regra #24)
929:         WITH THIS.grd_4c_Dados.Column3
930:             .ControlSource     = "cursor_4c_Itens.opers"
931:             .Width             = 14
932:             .Format            = "M"
933:             .InputMask         = "E,S"
934:             .Header1.Caption   = "Op"
935:         ENDWITH
936: 
937:         *-- Column4: QTD
938:         WITH THIS.grd_4c_Dados.Column4
939:             .ControlSource     = "cursor_4c_Itens.qtds"
940:             .Width             = 64
941:             .InputMask         = "99999.999"
942:             .Header1.Alignment = 2
943:             .Header1.Caption   = "Qtd."
944:         ENDWITH
945: 
946:         *-- Column5: PESO
947:         WITH THIS.grd_4c_Dados.Column5
948:             .ControlSource     = "cursor_4c_Itens.pesos"
949:             .Width             = 60
950:             .InputMask         = "99999.999"
951:             .Header1.Alignment = 2
952:             .Header1.Caption   = "Peso"
953:         ENDWITH
954: 
955:         *-- Column6: VALOR
956:         WITH THIS.grd_4c_Dados.Column6
957:             .ControlSource     = "cursor_4c_Itens.units"
958:             .Width             = 90
959:             .InputMask         = "99999999.99"
960:             .Header1.Alignment = 2
961:             .Header1.Caption   = "Valor"
962:         ENDWITH
963: 
964:         *-- Column7: MOEDA
965:         WITH THIS.grd_4c_Dados.Column7
966:             .ControlSource     = "cursor_4c_Itens.moedas"
967:             .Width             = 24
968:             .Header1.Alignment = 2
969:             .Header1.Caption   = "Moe"
970:         ENDWITH
971: 
972:         *-- Column8: TOTAL
973:         WITH THIS.grd_4c_Dados.Column8
974:             .ControlSource     = "cursor_4c_Itens.totas"
975:             .Width             = 107
976:             .InputMask         = "9999999999.99"
977:             .Header1.Alignment = 2
978:             .Header1.Caption   = "Total"
979:         ENDWITH
980: 
981:         *-- Column9: pesotot
982:         WITH THIS.grd_4c_Dados.Column9
983:             .ControlSource     = "cursor_4c_Itens.tpesos"
984:             .Width             = 64
985:             .InputMask         = "9999999.99"
986:             .Header1.Alignment = 2
987:             .Header1.Caption   = "Total Peso"
988:         ENDWITH
989: 
990:         *-- Column10: item (numero sequencial, sem legenda no legado)
991:         WITH THIS.grd_4c_Dados.Column10
992:             .ControlSource     = "cursor_4c_Itens.citens"
993:             .Width             = 31
994:             .InputMask         = "9999"
995:             .Header1.Caption   = ""
996:         ENDWITH
997: 
998:         *-- Column11: UNIDADE
999:         WITH THIS.grd_4c_Dados.Column11
1000:             .ControlSource     = "cursor_4c_Itens.cunis"
1001:             .Width             = 30
1002:             .Header1.Alignment = 2
1003:             .Header1.Caption   = "Uni"
1004:         ENDWITH
1005: 
1006:         *-- Column12: UNIPESO (desabilitada, igual ao legado)
1007:         WITH THIS.grd_4c_Dados.Column12
1008:             .ControlSource     = "cursor_4c_Itens.cunips"
1009:             .Width             = 31
1010:             .Enabled           = .F.
1011:             .Header1.Alignment = 2
1012:             .Header1.Caption   = "Uni"
1013:         ENDWITH
1014: 
1015:         *-- Column13: PEDIDO
1016:         WITH THIS.grd_4c_Dados.Column13
1017:             .ControlSource     = "cursor_4c_Itens.abrevis"
1018:             .Width             = 40
1019:             .Header1.Alignment = 2
1020:             .Header1.Caption   = "Ped"
1021:         ENDWITH
1022: 
1023:         *-- Column14: DESCRS
1024:         WITH THIS.grd_4c_Dados.Column14
1025:             .ControlSource     = "cursor_4c_Itens.dpros"
1026:             .Width             = 290
1027:             .Header1.Alignment = 2
1028:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1029:         ENDWITH
1030: 
1031:         *-- Column15: cor
1032:         WITH THIS.grd_4c_Dados.Column15
1033:             .ControlSource     = "cursor_4c_Itens.codcors"
1034:             .Width             = 24
1035:             .Header1.Alignment = 2
1036:             .Header1.Caption   = "Cor"
1037:         ENDWITH
1038: 
1039:         *-- Column16: Local
1040:         WITH THIS.grd_4c_Dados.Column16
1041:             .ControlSource     = "cursor_4c_Itens.locals"
1042:             .Width             = 80
1043:             .Header1.Alignment = 2
1044:             .Header1.Caption   = "Local"
1045:         ENDWITH
1046: 
1047:         *-- Column17: Comprimento
1048:         WITH THIS.grd_4c_Dados.Column17
1049:             .ControlSource     = "cursor_4c_Itens.compris"
1050:             .Width             = 50
1051:             .InputMask         = "9999.99"
1052:             .Header1.Alignment = 2
1053:             .Header1.Caption   = "Compr."
1054:         ENDWITH
1055: 
1056:         *-- Column18: LocalO
1057:         WITH THIS.grd_4c_Dados.Column18
1058:             .ControlSource     = "cursor_4c_Itens.localos"
1059:             .Width             = 80
1060:             .Header1.Alignment = 2
1061:             .Header1.Caption   = "Local Ori"
1062:         ENDWITH
1063: 
1064:         *-- Column19: Tamanho
1065:         WITH THIS.grd_4c_Dados.Column19
1066:             .ControlSource     = "cursor_4c_Itens.codtams"
1067:             .Width             = 35
1068:             .Header1.Alignment = 2
1069:             .Header1.Caption   = "Tam."
1070:         ENDWITH
1071: 
1072:         *-- Column20: Reserva (ReadOnly, igual ao legado)
1073:         WITH THIS.grd_4c_Dados.Column20
1074:             .ControlSource     = "cursor_4c_Itens.qtreservas"
1075:             .Width             = 64
1076:             .ReadOnly          = .T.
1077:             .InputMask         = "999999.999"
1078:             .Header1.Alignment = 2
1079:             .Header1.Caption   = "Reserva"
1080:         ENDWITH
1081: 
1082:         *-- Column21 (Presente) e Column22 (O.S.): CheckBox de coluna.
1083:         *-- Aqui so o BIND e a largura/header. O AddObject do CheckBox roda
1084:         *-- DEPOIS, em InstalarCheckBoxesGrade(), porque Column.AddObject de
1085:         *-- CheckBox ESTOURA enquanto a coluna estiver ligada (pelo auto-bind
1086:         *-- do RecordSource) a um campo de outro tipo: com ColumnCount = 22 o
1087:         *-- VFP liga Column22 ao 22o campo do cursor, que eh codcors C(4), e
1088:         *-- adicionar um controle numerico ali da
1089:         *-- "Error with CHK_4C_SERVICO - Value : Data type mismatch."
1090:         *-- A falha eh TOTAL e MUDA: cai no TRY do InicializarForm, que
1091:         *-- devolve .F., CREATEOBJECT devolve o logico .F. e a tela
1092:         *-- simplesmente nao abre - sem erro na tela e sem log.
1093:         WITH THIS.grd_4c_Dados.Column21
1094:             .ControlSource     = "cursor_4c_Itens.ckpresente"
1095:             .Width             = 50
1096:             .Header1.Alignment = 2
1097:             .Header1.Caption   = "Presente"
1098:         ENDWITH
1099: 
1100:         WITH THIS.grd_4c_Dados.Column22
1101:             .ControlSource     = "cursor_4c_Itens.servicos"
1102:             .Width             = 50
1103:             .Header1.Alignment = 2
1104:             .Header1.Caption   = "O.S."
1105:         ENDWITH
1106: 
1107:         *-- Todas as colunas ja estao bindadas: agora os CheckBox.
1108:         THIS.InstalarCheckBoxesGrade()
1109:     ENDPROC
1110: 
1111:     *==========================================================================
1112:     * InstalarCheckBoxesGrade - Instala os CheckBox das colunas Presente e
1113:     * O.S. na ordem que o VFP9 exige (medido): ColumnCount -> RecordSource ->
1114:     * ControlSource de TODAS as colunas -> Column.AddObject + Value ->
1115:     * Sparse + CurrentControl. Invertido, o AddObject estoura por causa do
1116:     * auto-bind do RecordSource (ver comentario em ConfigurarGridDados).
1117:     *
1118:     * IDEMPOTENTE e vive no funil: reatribuir RecordSource/ColumnCount ou
1119:     * fechar o alias destroi os objetos postos na Column, entao a instalacao
1120:     * tem de poder rodar de novo sem duplicar o AddObject.
1121:     *==========================================================================
1122:     PROTECTED PROCEDURE InstalarCheckBoxesGrade()
1123:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1124:             RETURN
1125:         ENDIF
1126: 
1127:         IF THIS.grd_4c_Dados.ColumnCount < 22
1128:             RETURN
1129:         ENDIF
1130: 
1131:         THIS.InstalarCheckBoxColuna(THIS.grd_4c_Dados.Column21, "chk_4c_Presente")
1132:         THIS.InstalarCheckBoxColuna(THIS.grd_4c_Dados.Column22, "chk_4c_Servico")
1133:     ENDPROC
1134: 
1135:     *==========================================================================
1136:     * InstalarCheckBoxColuna - Poe UM CheckBox numa Column. Propriedades: so
1137:     * as que o VFP9 de fato aplica em controle de Column criado em runtime
1138:     * (Caption/Alignment/ReadOnly/Visible/FontName/FontSize/Value). Top/Left/
1139:     * Width/Height sao DESCARTADAS nesse contexto - escrever a geometria do
1140:     * dump aqui eh codigo morto que sugere area clicavel calibrada.
1141:     *==========================================================================
1142:     PROTECTED PROCEDURE InstalarCheckBoxColuna(par_oColuna, par_cNomeChk)
1143:         IF VARTYPE(par_oColuna) <> "O" OR VARTYPE(par_cNomeChk) <> "C"
1144:             RETURN
1145:         ENDIF
1146: 
1147:         IF !PEMSTATUS(par_oColuna, par_cNomeChk, 5)

*-- Linhas 1728 a 1746:
1728:         *-- Page4 (pgPrecos): a grade de precificacao nasce oculta no legado.
1729:         *-- Mesmo nome do grid principal (eh o que o mapeamento do form manda),
1730:         *-- mas outro PAI - o caminho completo nao deixa ambiguidade.
1731:         THIS.pgf_4c_Paginas.Page4.grd_4c_Dados.Visible = .F.
1732:     ENDPROC
1733: 
1734:     *==========================================================================
1735:     * AjustarBotoesPorModo - Espelha os guards When do legado (InList sobre
1736:     * Op_Escolha + linha corrente na grade). Chamado no fim de InicializarForm
1737:     * e deve ser repetido apos qualquer troca de modo/linha (regra #40).
1738:     * PUBLIC: o TesteAutomatico chama THIS.oForm.AjustarBotoesPorModo() de
1739:     * FORA da classe, e PEMSTATUS(...,5) devolve .T. mesmo para PROTECTED
1740:     * (so testa existencia, nao escopo) - entao o harness entraria no branch
1741:     * e a chamada estouraria em runtime (regra #3).
1742:     *==========================================================================
1743:     PROCEDURE AjustarBotoesPorModo()
1744:         LOCAL loc_lEdicao, loc_lTemLinha
1745: 
1746:         loc_lEdicao   = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")

*-- Linhas 1815 a 1833:
1815:     *
1816:     * O BO le para um cursor TEMPORARIO e aqui o alias da grade eh recarregado
1817:     * com SELECT/ZAP/APPEND FROM DBF(): SQLEXEC direto sobre o alias ligado ao
1818:     * Grid o FECHA e RECRIA, zerando o ColumnCount - a grade viraria um
1819:     * retangulo branco sem cabecalho, sem erro e sem log.
1820:     *==========================================================================
1821:     PROCEDURE CarregarDados()
1822:         LOCAL loc_lSucesso, loc_cChave, loc_oErro
1823: 
1824:         loc_lSucesso = .F.
1825: 
1826:         IF !USED("cursor_4c_Itens")
1827:             THIS.CriarCursorItens()
1828:         ENDIF
1829: 
1830:         loc_cChave = THIS.ObterChaveMovimentacao()
1831: 
1832:         IF EMPTY(loc_cChave)
1833:             *-- Sem movimentacao selecionada a grade abre VAZIA, como no legado

*-- Linhas 1921 a 1959:
1921:         SELECT cursor_4c_Itens
1922:         GO TOP
1923: 
1924:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1925:             *-- Reinstala os CheckBox de coluna antes de repintar: se algo
1926:             *-- tiver reatribuido RecordSource/ColumnCount ou fechado o
1927:             *-- alias, os objetos postos nas Columns foram destruidos. A
1928:             *-- instalacao eh idempotente.
1929:             THIS.InstalarCheckBoxesGrade()
1930:             THIS.grd_4c_Dados.Refresh()
1931:         ENDIF
1932:     ENDPROC
1933: 
1934:     *==========================================================================
1935:     * ZaparCursorItens - ZAP guardado por SAFETY. SET SAFETY eh escopado por
1936:     * DATA SESSION: este form eh DataSession = 2, e na sessao privada SAFETY
1937:     * vale ON mesmo com o SET SAFETY OFF do main.prg. Com SAFETY ON o ZAP
1938:     * abre o dialogo modal "Zap ... Are you sure?" e CONGELA a tela,
1939:     * esperando um clique que ninguem ve (nao eh erro: em teste headless
1940:     * aparece como timeout sem resultado).
1941:     *
1942:     * ZAP eh a escolha CERTA aqui (o legado faz "Zap In <cursor>"): preserva
1943:     * a estrutura e o binding do Grid. Fechar e recriar o alias derrubaria
1944:     * RecordSource/ControlSource e a grade ficaria vazia com o cursor cheio.
1945:     *==========================================================================
1946:     PROTECTED PROCEDURE ZaparCursorItens()
1947:         LOCAL loc_cSafety
1948: 
1949:         IF !USED("cursor_4c_Itens")
1950:             RETURN
1951:         ENDIF
1952: 
1953:         loc_cSafety = SET("SAFETY")
1954:         SET SAFETY OFF
1955: 
1956:         SELECT cursor_4c_Itens
1957:         ZAP
1958: 
1959:         IF loc_cSafety = "ON"

*-- Linhas 1978 a 2002:
1978:     PROCEDURE AplicarModoNaGrade()
1979:         LOCAL loc_lEditavel
1980: 
1981:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1982:             RETURN
1983:         ENDIF
1984: 
1985:         loc_lEditavel = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
1986: 
1987:         WITH THIS.grd_4c_Dados
1988:             .ReadOnly = !loc_lEditavel
1989:             .Enabled  = .T.
1990:             *-- Reserva eh ReadOnly tambem na grade editavel (legado:
1991:             *-- fwGrade.Column20.ReadOnly = .T.)
1992:             .Column20.ReadOnly = .T.
1993:         ENDWITH
1994:     ENDPROC
1995: 
1996:     *==========================================================================
1997:     * ObterChaveMovimentacao - empdopnums char(29) da movimentacao corrente.
1998:     * Vem do form pai de Movimentacao (TprMvCab no legado); enquanto a
1999:     * integracao com o pai nao esta conectada, cai na property do proprio
2000:     * form, que o chamador preenche antes do Show.
2001:     *==========================================================================
2002:     PROTECTED FUNCTION ObterChaveMovimentacao()

*-- Linhas 2391 a 2410:
2391:             loc_lOk = .F.
2392:             MsgAviso(loc_cMsg, loc_cTitulo)
2393: 
2394:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Visible
2395:                 THIS.grd_4c_Dados.SetFocus()
2396:             ENDIF
2397:         ENDIF
2398: 
2399:         RETURN loc_lOk
2400:     ENDPROC
2401: 
2402:     *==========================================================================
2403:     * BtnEncerrarClick - "Retornar" ao form pai (OK.btnSair do legado, que eh
2404:     * Cancel = .T. - ESC cai aqui). O legado valida os itens primeiro e, so
2405:     * passando, reabilita o pai e fecha:
2406:     *
2407:     *   ... validacoes ... If Not IsEmpty(lcMsg) / Messagebox / SetFocus / Return
2408:     *   If llOk / With Thisform.ParentForm / .Enabled = .T. / ... / Endwith / Endif
2409:     *   Thisform.Release
2410:     *

*-- Linhas 2457 a 2475:
2457:         ENDTRY
2458:         IF VARTYPE(loc_oForm) = "O"
2459:             loc_oForm.Show()
2460:             THIS.grd_4c_Dados.Refresh()
2461:         ENDIF
2462:     ENDPROC
2463: 
2464:     *-- "Alterar Impostos": habilita a pagina Fiscal e navega para ela
2465:     PROCEDURE BtnAltImpsClick()
2466:         IF !THIS.TemProdutoSelecionado()
2467:             MsgAviso("Selecione um Produto Na Grade para alterar impostos.", "Aten" + CHR(231) + CHR(227) + "o")
2468:             RETURN
2469:         ENDIF
2470:         THIS.pgf_4c_Paginas.Page3.Enabled = .T.
2471:         THIS.AlternarPagina(3)
2472:     ENDPROC
2473: 
2474:     *-- "Visualizar Impostos": toggle que leva a pagina Fiscal
2475:     PROCEDURE BtnVerImpsClick()

*-- Linhas 2514 a 2548:
2514:         ENDTRY
2515:         IF VARTYPE(loc_oForm) = "O"
2516:             loc_oForm.Show()
2517:             THIS.grd_4c_Dados.SetFocus()
2518:         ENDIF
2519:     ENDPROC
2520: 
2521:     *-- "Itens Subnivel": Do Form sigoppei With ThisForm, DataSessionId
2522:     PROCEDURE BtnIteSubClick()
2523:         LOCAL loc_oForm, loc_oErro
2524:         loc_oForm = .NULL.
2525:         TRY
2526:             loc_oForm = CREATEOBJECT("FormSigOpPei", THIS, THIS.DataSessionId)
2527:         CATCH TO loc_oErro
2528:             MostrarErro("Erro ao abrir Itens Subn" + CHR(237) + "vel:" + CHR(13) + loc_oErro.Message, "Erro")
2529:             loc_oForm = .NULL.
2530:         ENDTRY
2531:         IF VARTYPE(loc_oForm) = "O"
2532:             loc_oForm.Show()
2533:             THIS.grd_4c_Dados.Refresh()
2534:         ENDIF
2535:     ENDPROC
2536: 
2537:     *-- "Importar XML": zera a grade de itens e aciona a importacao
2538:     PROCEDURE CmdXmlClick()
2539:         IF !MsgConfirma("Importar XML ir" + CHR(225) + " substituir todos os itens da grade atual. Continuar?", "Confirmar")
2540:             RETURN
2541:         ENDIF
2542:         THIS.ZaparCursorItens()
2543:         THIS.RepintarGradeItens()
2544:         THIS.AjustarBotoesPorModo()
2545:     ENDPROC
2546: 
2547:     *-- "Carrega Cadastro": zera a grade de itens antes de carregar um lote
2548:     PROCEDURE BtncarregarClick()

*-- Linhas 2566 a 2606:
2566:         CATCH TO loc_oErro
2567:             MostrarErro("Erro ao retornar b" + CHR(244) + "nus:" + CHR(13) + loc_oErro.Message, "Erro")
2568:         ENDTRY
2569:         THIS.grd_4c_Dados.Refresh()
2570:     ENDPROC
2571: 
2572:     *==========================================================================
2573:     * Handlers dos botoes de cnt_4c_BotoesAcao (toolbar inferior, Top=359)
2574:     *==========================================================================
2575: 
2576:     *-- "Cadastro de Produtos": Do Form SigOpCgp (cadastro rapido na operacao)
2577:     PROCEDURE BtnCadProClick()
2578:         LOCAL loc_oForm, loc_oErro
2579:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") OR !THIS.TemProdutoSelecionado()
2580:             RETURN
2581:         ENDIF
2582:         loc_oForm = .NULL.
2583:         TRY
2584:             loc_oForm = CREATEOBJECT("FormSigOpCgp", THIS)
2585:         CATCH TO loc_oErro
2586:             MostrarErro("Erro ao abrir Cadastro de Produtos:" + CHR(13) + loc_oErro.Message, "Erro")
2587:             loc_oForm = .NULL.
2588:         ENDTRY
2589:         IF VARTYPE(loc_oForm) = "O"
2590:             loc_oForm.Show()
2591:             THIS.grd_4c_Dados.Refresh()
2592:         ENDIF
2593:     ENDPROC
2594: 
2595:     *-- "Exclusao de Produtos": remove a linha corrente da grade.
2596:     *-- Legado (btnPApaga.Click): guard de EOF -> DeletarItem() -> garante uma
2597:     *-- linha na grade -> renumera os itens (e as referencias de composicao)
2598:     *-- -> CItem = Cont -> Go Top -> fwGrade.Refresh + Produto.SetFocus.
2599:     *-- O legado NAO pede confirmacao: a exclusao eh de LINHA do cursor da
2600:     *-- grade, e a gravacao em SigMvItn so acontece quando o form pai confirma
2601:     *-- a movimentacao.
2602:     PROCEDURE BtnPApagaClick()
2603:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
2604:             MsgAviso("Posicione no Produto que Deseja Excluir ... ", "Nada a Fazer")
2605:             RETURN
2606:         ENDIF

*-- Linhas 2618 a 2697:
2618:         THIS.RepintarGradeItens()
2619:         THIS.AjustarBotoesPorModo()
2620: 
2621:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Visible
2622:             THIS.grd_4c_Dados.SetFocus()
2623:         ENDIF
2624:     ENDPROC
2625: 
2626:     *-- "Carregar Composicao": Do Form SigSubCp (composicao do produto)
2627:     PROCEDURE BtnComposClick()
2628:         LOCAL loc_oForm, loc_oErro
2629:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") OR !THIS.TemProdutoSelecionado()
2630:             RETURN
2631:         ENDIF
2632:         loc_oForm = .NULL.
2633:         TRY
2634:             loc_oForm = CREATEOBJECT("FormSigSubCp", THIS, ALLTRIM(cursor_4c_Itens.cpros), ;
2635:                                       cursor_4c_Itens.citens, THIS.DataSessionId)
2636:         CATCH TO loc_oErro
2637:             MostrarErro("Erro ao abrir Composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
2638:             loc_oForm = .NULL.
2639:         ENDTRY
2640:         IF VARTYPE(loc_oForm) = "O"
2641:             loc_oForm.Show()
2642:             THIS.grd_4c_Dados.Refresh()
2643:         ENDIF
2644:     ENDPROC
2645: 
2646:     *-- "Alteracao de Precos": libera o foco na coluna Valor da grade
2647:     PROCEDURE BtnAltPrecosClick()
2648:         IF !THIS.TemProdutoSelecionado()
2649:             MsgAviso("Selecione um Produto para Ter o Pre" + CHR(231) + "o Alterado.", "Aten" + CHR(231) + CHR(227) + "o")
2650:             RETURN
2651:         ENDIF
2652:         THIS.grd_4c_Dados.SetFocus()
2653:         THIS.grd_4c_Dados.ActiveColumn = 6
2654:     ENDPROC
2655: 
2656:     *-- "Procura de Produtos": abre o lookup de produto quando a linha
2657:     *-- corrente ainda nao tem codigo preenchido (igual ao legado)
2658:     PROCEDURE BtnPBuscasClick()
2659:         LOCAL loc_oBusca
2660: 
2661:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens") AND !EMPTY(cursor_4c_Itens.cpros)
2662:             MsgAviso("O c" + CHR(243) + "digo do Produto tem que estar vazio para acionar procura!!!", "Aten" + CHR(231) + CHR(227) + "o")
2663:             RETURN
2664:         ENDIF
2665: 
2666:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2667:                                    "cursor_4c_BuscaPro", "Cpros", "", "Produtos", .F., .T., "")
2668: 
2669:         IF VARTYPE(loc_oBusca) = "O"
2670:             IF !loc_oBusca.this_lAchouRegistro
2671:                 loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
2672:                 loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
2673:                 loc_oBusca.Show()
2674:             ENDIF
2675: 
2676:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro") AND USED("cursor_4c_Itens") ;
2677:                AND !EOF("cursor_4c_Itens")
2678:                 SELECT cursor_4c_BuscaPro
2679:                 SELECT cursor_4c_Itens
2680:                 REPLACE cpros WITH ALLTRIM(cursor_4c_BuscaPro.Cpros), ;
2681:                         dpros WITH ALLTRIM(cursor_4c_BuscaPro.Dpros)
2682:                 THIS.grd_4c_Dados.Refresh()
2683:             ENDIF
2684: 
2685:             loc_oBusca.Release()
2686:         ENDIF
2687: 
2688:         IF USED("cursor_4c_BuscaPro")
2689:             USE IN cursor_4c_BuscaPro
2690:         ENDIF
2691:     ENDPROC
2692: 
2693:     *-- "Informar Pedido": Do Form SigOpPed With ThisForm, DataSessionId
2694:     PROCEDURE BtnPedidoClick()
2695:         LOCAL loc_oForm, loc_oErro
2696:         IF !THIS.TemProdutoSelecionado()
2697:             MsgAviso("" + CHR(201) + " necess" + CHR(225) + "rio Posicionar no Produto para Localizar!!!", "Aviso")

*-- Linhas 2706 a 2747:
2706:         ENDTRY
2707:         IF VARTYPE(loc_oForm) = "O"
2708:             loc_oForm.Show()
2709:             THIS.grd_4c_Dados.Refresh()
2710:         ENDIF
2711:     ENDPROC
2712: 
2713:     *-- "Substituir Composicao": Do Form SigSubCp With ThisForm, Cpros,
2714:     *-- Citens, DataSessionId, CodTams (igual ao legado)
2715:     PROCEDURE BtnsubcpClick()
2716:         LOCAL loc_oForm, loc_oErro
2717:         IF !THIS.TemProdutoSelecionado()
2718:             MsgAviso("Selecione Um Produto Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o")
2719:             RETURN
2720:         ENDIF
2721:         loc_oForm = .NULL.
2722:         TRY
2723:             loc_oForm = CREATEOBJECT("FormSigSubCp", THIS, ALLTRIM(cursor_4c_Itens.cpros), ;
2724:                                       cursor_4c_Itens.citens, THIS.DataSessionId, ;
2725:                                       cursor_4c_Itens.codtams)
2726:         CATCH TO loc_oErro
2727:             MostrarErro("Erro ao abrir Substituir Composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
2728:             loc_oForm = .NULL.
2729:         ENDTRY
2730:         IF VARTYPE(loc_oForm) = "O"
2731:             loc_oForm.Show()
2732:             THIS.grd_4c_Dados.Refresh()
2733:         ENDIF
2734:     ENDPROC
2735: 
2736:     *-- "Detalhes": Do Form SigOpDet With ParentForm.PoDataMgr, Op_Escolha,
2737:     *-- TprMvCab.Dopes, Cpros, TprMvCab.EmpDopNums
2738:     PROCEDURE BtnDetClick()
2739:         LOCAL loc_oForm, loc_oErro
2740:         IF !THIS.TemProdutoSelecionado()
2741:             MsgAviso("Selecione Um Produto Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o")
2742:             RETURN
2743:         ENDIF
2744:         loc_oForm = .NULL.
2745:         TRY
2746:             loc_oForm = CREATEOBJECT("FormSigOpDet", THIS.this_oParentForm, THIS.this_cOpEscolha, ;
2747:                                       "", ALLTRIM(cursor_4c_Itens.cpros), "")

*-- Linhas 2789 a 2807:
2789:         ENDTRY
2790:         IF VARTYPE(loc_oForm) = "O"
2791:             loc_oForm.Show()
2792:             THIS.grd_4c_Dados.Refresh()
2793:         ENDIF
2794:     ENDPROC
2795: 
2796:     *-- "Local. Destino": Do Form SigOpLcl/SigOpLcZ With ..., 'DESTINO'
2797:     PROCEDURE BtnLocDesClick()
2798:         LOCAL loc_oForm, loc_oErro
2799:         IF !THIS.TemProdutoSelecionado()
2800:             MsgAviso("" + CHR(201) + " Necess" + CHR(225) + "rio Posicionar no Produto para Localizar!!!", "Aviso")
2801:             RETURN
2802:         ENDIF
2803:         loc_oForm = .NULL.
2804:         TRY
2805:             loc_oForm = CREATEOBJECT("FormSigOpLcl", THIS.this_oParentForm, THIS.this_cOpEscolha, "DESTINO")
2806:         CATCH TO loc_oErro
2807:             MostrarErro("Erro ao abrir Localiza" + CHR(231) + CHR(227) + "o de Destino:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 4258 a 4358:
4258:             USE IN cursor_4c_Precos
4259:         ENDIF
4260: 
4261:         SET NULL ON
4262:         CREATE CURSOR cursor_4c_Precos ( ;
4263:             lprecos C(30), tabds C(20), units N(11,2), moedas C(3))
4264:         SET NULL OFF
4265:     ENDPROC
4266: 
4267:     *==========================================================================
4268:     * ConfigurarPaginaPrecos - Page4 (pgPrecos no legado) "Precificacao".
4269:     *
4270:     * Grade grdPrecos: lista as precificacoes disponiveis para o produto do
4271:     * item corrente. Nasce Visible = .F. e ReadOnly = .T. no SCX legado (o
4272:     * proprio legado so a mostra quando a operacao trabalha com lista de
4273:     * precos), e por isso entra na lista de excecao de
4274:     * TornarControlesVisiveis / ReaplicarVisibilidadeInicial.
4275:     *
4276:     * Ordem de configuracao obrigatoria (regra #41 / Problema 48):
4277:     * ColumnCount -> RecordSource -> ControlSource -> Width -> Header.Caption.
4278:     *==========================================================================
4279:     PROTECTED PROCEDURE ConfigurarPaginaPrecos()
4280:         LOCAL loc_oPag, loc_oGrd
4281:         loc_oPag = THIS.pgf_4c_Paginas.Page4
4282: 
4283:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
4284:         loc_oGrd = loc_oPag.grd_4c_Dados
4285: 
4286:         WITH loc_oGrd
4287:             .Top                = 9
4288:             .Left               = 7
4289:             .Width              = 416
4290:             .Height             = 131
4291:             .ColumnCount        = 4
4292:             .DeleteMark         = .F.
4293:             .RecordMark         = .F.
4294:             .ScrollBars         = 2
4295:             .ReadOnly           = .T.
4296:             .AllowHeaderSizing  = .F.
4297:             .GridLineColor      = RGB(238, 238, 238)
4298:             .RecordSource       = "cursor_4c_Precos"
4299:             .Visible            = .F.
4300:         ENDWITH
4301: 
4302:         WITH loc_oGrd.Column1
4303:             .ControlSource   = "cursor_4c_Precos.lprecos"
4304:             .Width           = 210
4305:             .Movable         = .F.
4306:             .Resizable       = .F.
4307:             .ReadOnly        = .T.
4308:             .FontName        = "Courier New"
4309:             .Header1.Caption = "Lista de Precifica" + CHR(231) + CHR(227) + "o"
4310:             .Visible         = .T.
4311:         ENDWITH
4312: 
4313:         WITH loc_oGrd.Column2
4314:             .ControlSource   = "cursor_4c_Precos.tabds"
4315:             .Width           = 80
4316:             .Movable         = .F.
4317:             .Resizable       = .F.
4318:             .ReadOnly        = .T.
4319:             .FontName        = "Courier New"
4320:             .Header1.Caption = "Tab.Varia" + CHR(231) + CHR(227) + "o"
4321:             .Visible         = .T.
4322:         ENDWITH
4323: 
4324:         WITH loc_oGrd.Column3
4325:             .ControlSource   = "cursor_4c_Precos.units"
4326:             .Width           = 70
4327:             .Movable         = .F.
4328:             .Resizable       = .F.
4329:             .ReadOnly        = .T.
4330:             .FontName        = "Courier New"
4331:             .InputMask       = "9999,999.99"
4332:             .Header1.Caption = "Unit" + CHR(225) + "rio"
4333:             .Visible         = .T.
4334:         ENDWITH
4335: 
4336:         WITH loc_oGrd.Column4
4337:             .ControlSource   = "cursor_4c_Precos.moedas"
4338:             .Width           = 30
4339:             .Movable         = .F.
4340:             .Resizable       = .F.
4341:             .ReadOnly        = .T.
4342:             .FontName        = "Courier New"
4343:             .Header1.Caption = "Moe"
4344:             .Visible         = .T.
4345:         ENDWITH
4346: 
4347:         WITH loc_oGrd
4348:             .FontName = "Courier New"
4349:             .FontSize = 8
4350:             .HeaderHeight = 16
4351:             .RowHeight    = 16
4352:         ENDWITH
4353:     ENDPROC
4354: 
4355:     *==========================================================================
4356:     * CarregarPrecos - Recebe do form PAI as linhas da lista de precificacao e
4357:     * as entrega a grade de Page4.
4358:     *

*-- Linhas 4389 a 4418:
4389: 
4390:         TRY
4391:             *-- ZAP (nao fechar/recriar): fechar o alias derrubaria o
4392:             *-- RecordSource da grade e ela viraria um retangulo branco.
4393:             SELECT cursor_4c_Precos
4394:             THIS.ZaparCursor("cursor_4c_Precos")
4395: 
4396:             *-- APPEND FROM DBF casa os campos por NOME: o alias do pai tem de
4397:             *-- trazer lprecos/tabds/units/moedas.
4398:             SELECT cursor_4c_Precos
4399:             APPEND FROM DBF(ALLTRIM(par_cCursorOrigem))
4400: 
4401:             GO TOP IN cursor_4c_Precos
4402: 
4403:             WITH THIS.pgf_4c_Paginas.Page4.grd_4c_Dados
4404:                 .Visible = (RECCOUNT("cursor_4c_Precos") > 0)
4405:                 .Refresh()
4406:             ENDWITH
4407: 
4408:             loc_lSucesso = .T.
4409: 
4410:         CATCH TO loc_oErro
4411:             THIS.this_cMensagemErro = loc_oErro.Message
4412:             MsgErro("Erro ao carregar a lista de precifica" + CHR(231) + CHR(227) + ;
4413:                     "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
4414:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4415:                     "Proc: " + loc_oErro.Procedure, "Erro CarregarPrecos")
4416:         ENDTRY
4417: 
4418:         RETURN loc_lSucesso

*-- Linhas 4446 a 4464:
4446:     ENDPROC
4447: 
4448:     *==========================================================================
4449:     * GradeAfterRowColChange - Handler de AfterRowColChange de grd_4c_Dados.
4450:     *
4451:     * Declara par_nColIndex porque o evento passa esse argumento e handler sem
4452:     * o parametro estoura a cada troca de celula (regra #3). O uso aqui eh o
4453:     * MESMO do legado: carregar o detalhe da LINHA corrente, sem filtrar por
4454:     * coluna - validacao de celula NAO entra aqui (regra #46), ela mora no
4455:     * Valid do TextBox da coluna.
4456:     *
4457:     * PUBLIC: eh alvo de BINDEVENT e tambem do harness de teste.
4458:     *==========================================================================
4459:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
4460:         THIS.AtualizarPainelProduto()
4461:         THIS.AjustarBotoesPorModo()
4462:     ENDPROC
4463: 
4464:     *==========================================================================

*-- Linhas 4879 a 4897:
4879:             THIS.RepintarGradeItens()
4880:             SELECT cursor_4c_Itens
4881:             GO loc_nRecno
4882:             THIS.grd_4c_Dados.Refresh()
4883:         ELSE
4884:             MsgAviso("Item n" + CHR(227) + "o encontrado na grade.", "Procurar")
4885:         ENDIF
4886: 
4887:         THIS.this_lProcuraCB = .F.
4888: 
4889:         RETURN (loc_nRecno > 0)
4890:     ENDPROC
4891: 
4892:     *==========================================================================
4893:     * TxtProdLostFocus - Conferencia por codigo (get_prod do legado).
4894:     *
4895:     * O legado resolve o valor digitado nesta ordem (get_prod.Valid):
4896:     *   1. codigo de barras que JA esta numa linha da grade (Seek em
4897:     *      crTpmMvItn por codbarras) - marca ThisForm.Barra e usa o produto

*-- Linhas 5333 a 5352:
5333: 
5334:         IF VARTYPE(loc_oBusca) = "O"
5335:             IF !loc_oBusca.this_lAchouRegistro
5336:                 loc_oBusca.mAddColuna(par_cCampoCodigo, "", "C" + CHR(243) + "digo")
5337:                 loc_oBusca.mAddColuna(par_cCampoDescricao, "", "Descri" + CHR(231) + CHR(227) + "o")
5338:                 loc_oBusca.Show()
5339:             ENDIF
5340: 
5341:             IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
5342:                 SELECT (loc_cCursor)
5343:                 par_oControleCodigo.Value = ALLTRIM(EVALUATE(loc_cCursor + "." + par_cCampoCodigo))
5344: 
5345:                 IF VARTYPE(par_oControleDescricao) = "O"
5346:                     par_oControleDescricao.Value = ALLTRIM(EVALUATE(loc_cCursor + "." + par_cCampoDescricao))
5347:                 ENDIF
5348:             ENDIF
5349: 
5350:             loc_oBusca.Release()
5351:         ENDIF
5352: 

