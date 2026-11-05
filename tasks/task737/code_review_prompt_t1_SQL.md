# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, NTIPOS, ICL, CGRUS, SGRUS, GRUCARTITS, NRESPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, NTIPOS, ICL, CGRUS, SGRUS, GRUCARTITS, NRESPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, NTIPOS, ICL, CGRUS, SGRUS, GRUCARTITS, NRESPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, NTIPOS, ICL, CGRUS, SGRUS, GRUCARTITS, NRESPS

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
	Select crTmpFicha
		lcQuery = [Select Distinct a.Dopes, a.TitOpes, b.CGrus as TemDados ] + ;
		   			[From SigCdOpe a ] + ;
		   			[Left Join SigCdFtc b ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'cnSigCdOpe') < 1)
		Select cnSigCdOpe
			Select &lcArea
	Select &lcArea
	Select crTmpFicha
	Select crTmpFicha
			Select crSigCdCeT
				Insert Into crSigCdCeT (IClis, CCars, CTits, Resps, CliCarTits, cIdChaves) ;
		lcQuery = [Select a.CCars, a.CTits, a.CLins, a.COrds, a.Maxs, a.Mins, a.nChkCxas, a.cSelecaos, a.cTpDados, b.Resps, c.Descrs ] + ;   
					[From SigCdFtc a ] + ;  
				    [Left Join SigOpFtc b On '] + lcDopes + [' + a.CCars + a.CTits = b.DopCarTits ] + ;  
				    [Left Join SigPrCpP c on a.CTits = c.Codigos ] + ;  
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpFicha') < 1)
	Select crTmpFicha
			lcQryResp = [Select nResps from SigCdFtr where GruCarTits = ']+lcDopes + crTmpFicha.CCars + crTmpFicha.CTits+[']
			If ThisForm.poDataMgr.SQLExecute(lcQryResp,[crResp]) < 1
Select &lcArea
	Select crTmpFicha

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopftc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1992 linhas total):

*-- Linhas 30 a 54:
30: *     transcritos do dump) e os BINDEVENT de Click; BtnCancelarClick (que a
31: *     Fase 4 chamou BtnSairClick - ver Fase 8, nomear pela ACAO) e
32: *     BtnConfirmarClick (os dois Click do legado); GravarFichaTecnica e
33: *     CarregarRespostasGravadas (gravafichatecnica legado -> INSERT em
34: *     SigCdCet via sigopftcBO)
35: *
36: * ESTE FORM NAO TEM GRID NEM BOTOES CRUD - e nao deve ter. O SCX legado tem
37: * EXATAMENTE 4 objetos visuais (cntSombra + lblSombra + lblTitulo + cntBotoes):
38: * zero objeto de BaseClass grid/pageframe, zero controle de entrada de dados e
39: * zero AddCursor/pColuna/RecordSource/ControlSource. A estrutura Lista/Dados
40: * com 6 botoes CRUD do frmcadastro teria de ser INVENTADA (viola o PILAR 1), e
41: * os campos da ficha nao sao desenhados no SCX: o legado os cria em RUNTIME no
42: * MontaFichaTecnica (fases 5-6). O que a Fase 4 acrescenta aqui sao os botoes
43: * de acao que o legado realmente tem - Confirmar e Cancelar - com a logica de
44: * gravacao do btnConfirmar.
45: *
46: * MIGRADO (Fase 7/8) - eventos PRINCIPAIS do dialogo. Os quatro nomes de
47: * convencao Btn<Incluir|Alterar|Visualizar|Excluir> + Click NAO existem
48: * aqui e nao devem existir: o SCX legado tem DOIS botoes (Confirmar/Cancelar,
49: * ja na Fase 4) e ZERO superficie CRUD - inventa-los violaria o PILAR 1 e
50: * criar metodo vazio e proibido pela regra de completude. Os eventos
51: * principais deste form sao os metodos do PROPRIO SCX, chamados pelo form PAI
52: * de movimentacao, todos PUBLIC por isso (regra #51):
53: *   - ChecarFichaTecnica(par_cTipo)  (checarfichatecnica - "GRUPO_OP"/
54: *     "MOSTRARFORM"; o gatilho central, que decide montar ou nao a ficha)

*-- Linhas 89 a 107:
89: *     THIS.oForm.CarregarLista() de FORA da classe).
90: *   - FormParaBO()           - le a linha corrente de cursor_4c_Ficha MAIS o
91: *     valor do campo mem_4c_Ficha<COrds> da tela para as properties do BO.
92: *     Eh o "lcVal = loObjForm1.&lcObj..Value" + o "Insert Into crSigCdCeT (...)
93: *     Values (<campos>)" do gravafichatecnica legado, que estava inline em
94: *     GravarFichaTecnica.
95: *   - BOParaForm()           - o inverso: joga this_cResps do BO no campo da
96: *     tela respeitando this_cTpDados. Eh o corpo do carregafichatecnica legado
97: *     ("loObjForm1.&lcObj..Value = lcVal / .Refresh").
98: *   - BtnCancelarClick()     - renomeado de BtnSairClick. O objeto legado
99: *     chama-se btnSair, mas o Caption que o usuario le eh "\<Cancelar": o
100: *     handler migrado tem de levar o nome da ACAO, nunca o Name do objeto
101: *     legado (PILAR 3). O corpo continua o "ThisForm.Release" do legado.
102: * e os tres auxiliares que esses quatro compartilham:
103: *   - ObterControleResposta(par_nCords) - monta o nome mem_4c_Ficha<COrds> e
104: *     devolve a REFERENCIA do controle (ou .NULL.). Fonte unica dos cinco sites
105: *     que antes repetiam o par PEMSTATUS + EVALUATE (regras #15/#34).
106: *   - LerRespostaDaTela(par_nCords, par_cTpDados) - valor do campo JA
107: *     normalizado para char, com o "lcVal = Dtoc(lcVal)" do legado aplicado

*-- Linhas 522 a 548:
522:     *     If llOks
523:     *         If Not Empty(ThisForm.Operacao)
524:     *             <query SigCdOpe + SigCdFtc -> cnSigCdOpe>
525:     *             If (SqlExecute(...) < 1) / MessageBox('Favor Reinicializar o
526:     *                 Processo!!!') / Return .f.
527:     *             Select cnSigCdOpe / Go Top
528:     *             If Not This.MontaFichaTecnica(ThisForm.Operacao)
529:     *                 Select &lcArea / Return 0
530:     *             EndIf
531:     *         EndIf
532:     *     EndIf
533:     *     If !Empty(lcArea) / Select &lcArea / Endif
534:     *
535:     * par_cTipo eh o pTip legado - o TAG de texto que identifica QUEM chamou:
536:     * "GRUPO_OP" quando o disparo vem da barra de acao do form PAI e
537:     * "MOSTRARFORM" quando vem do proprio MostrarForm. NAO eh objeto nenhum:
538:     * eh literal comparado com "=", por isso nao implica superficie CRUD neste
539:     * form (o SCX tem 4 objetos visuais e dois botoes - Confirmar/Cancelar).
540:     *
541:     * PUBLIC: o form PAI chama este metodo de fora (no legado,
542:     * "ThisForm.ChecarFichaTecnica([GRUPO_OP])") - metodo PROTECTED alcancado
543:     * de fora estoura "Property CHECARFICHATECNICA is not found" (regra #51).
544:     *==========================================================================
545:     PROCEDURE ChecarFichaTecnica(par_cTipo)
546:         LOCAL loc_lSucesso, loc_lOks, loc_cTipo, loc_cArea, loc_oErro
547: 
548:         loc_lSucesso = .T.

*-- Linhas 581 a 601:
581:                     "Erro em Formsigopftc.ChecarFichaTecnica")
582:         ENDTRY
583: 
584:         *-- Legado: If !Empty(lcArea) / Select &lcArea
585:         IF !EMPTY(loc_cArea) AND USED(loc_cArea)
586:             SELECT (loc_cArea)
587:         ENDIF
588: 
589:         RETURN loc_lSucesso
590:     ENDPROC
591: 
592:     *==========================================================================
593:     * MostrarForm - Exibe a ficha tecnica (mostrarform legado)
594:     *
595:     * Legado:
596:     *     If ThisForm.CriouForm
597:     *         ThisForm.ChecarFichaTecnica([MOSTRARFORM])
598:     *         ThisForm.Top = This.Top + 60
599:     *         ThisForm.ZOrder(1)
600:     *         ThisForm.Refresh
601:     *     EndIf

*-- Linhas 712 a 730:
712: 
713:                     THIS.this_lMontouCampos = .T.
714: 
715:                     SELECT cursor_4c_Ficha
716:                     GO TOP IN cursor_4c_Ficha
717:                     SCAN
718:                         *-- Troca de caracteristica: titulo + linha separadora
719:                         IF loc_cCar != NVL(cursor_4c_Ficha.ccars, "")
720:                             loc_cCar = NVL(cursor_4c_Ficha.ccars, "")
721:                             loc_nTop = loc_nTop + 1
722: 
723:                             loc_cObj = "lbl_4c_CarFicha" + ALLTRIM(STR(NVL(cursor_4c_Ficha.cords, 0), 3))
724:                             loc_oArea.AddObject(loc_cObj, "Label")
725:                             loc_oCtrl = EVALUATE("THIS.cnt_4c_AreaFicha." + loc_cObj)
726:                             WITH loc_oCtrl
727:                                 .AutoSize  = .F.
728:                                 .Top       = loc_nTop
729:                                 .Left      = 1
730:                                 .Width     = loc_nWid

*-- Linhas 853 a 871:
853: 
854:                         *-- Volta a area do SCAN antes do SKIP implicito: o
855:                         *-- RespostaEhFixa acima roda SQL e troca a work area
856:                         SELECT cursor_4c_Ficha
857:                     ENDSCAN
858: 
859:                     *-- Legado: fecho da lista (shpFichaFim). O sayFichaFim do
860:                     *-- legado eh um Label de UM PONTO pintado na cor do fundo
861:                     *-- 100px abaixo, cujo unico proposito eh dar altura extra
862:                     *-- ao ScrollSlide para a barra de rolagem - sem frmbarcta
863:                     *-- portado ele nao tem funcao e seria um controle invisivel
864:                     *-- a mais na tela.
865:                     IF RECCOUNT("cursor_4c_Ficha") > 0
866:                         loc_oArea.AddObject("shp_4c_FichaFim", "Shape")
867:                         WITH THIS.cnt_4c_AreaFicha.shp_4c_FichaFim
868:                             .Top           = loc_nTop
869:                             .Left          = 1
870:                             .Width         = loc_nWid + 9
871:                             .Height        = 2

*-- Linhas 903 a 985:
903:         ENDTRY
904: 
905:         IF !EMPTY(loc_cArea) AND USED(loc_cArea)
906:             SELECT (loc_cArea)
907:         ENDIF
908: 
909:         RETURN loc_lSucesso
910:     ENDPROC
911: 
912:     *==========================================================================
913:     * CarregarFichaTecnica - Joga as respostas do cursor nos campos montados
914:     * (carregafichatecnica legado)
915:     *
916:     * Legado:
917:     *     If ThisForm.CriouForm
918:     *         Select crTmpFicha
919:     *         Scan
920:     *             If( crTmpFicha.cTpDados <> [D] )
921:     *                 lcVal = Nvl(crTmpFicha.Resps, [])
922:     *             Else
923:     *                 lcVal = Nvl(Ctod(crTmpFicha.Resps),Ctod(''))
924:     *             Endif
925:     *             lcObj = [memFicha] + Alltrim(Str(crTmpFicha.COrds))
926:     *             loObjForm1.&lcObj..Value = lcVal
927:     *             loObjForm1.&lcObj..Refresh
928:     *         EndScan
929:     *     EndIf
930:     *
931:     * A resposta vem de SigOpFtc (o Left Join de CarregarCaracteristicas): eh
932:     * a resposta JA cadastrada para a OPERACAO, nao a do cliente - a do cliente
933:     * mora em SigCdCet e eh o que GravarFichaTecnica grava.
934:     *
935:     * O par "le a linha do cursor / escreve na tela" eh exatamente o par
936:     * CarregarLinhaFichaNoBO + BOParaForm da Fase 8: o SCAN abaixo so percorre
937:     * e delega, para a escrita na tela ter UM lugar so (o mesmo que o form pai
938:     * usa se precisar repintar um campo isolado).
939:     *==========================================================================
940:     PROCEDURE CarregarFichaTecnica()
941:         LOCAL loc_cArea, loc_oErro
942: 
943:         loc_cArea = ALIAS()
944: 
945:         TRY
946:             IF THIS.this_lCriouForm AND USED("cursor_4c_Ficha")
947:                 SELECT cursor_4c_Ficha
948:                 GO TOP IN cursor_4c_Ficha
949:                 SCAN
950:                     THIS.CarregarLinhaFichaNoBO()
951:                     THIS.BOParaForm()
952: 
953:                     *-- Volta a area do SCAN antes do SKIP implicito: os dois
954:                     *-- metodos acima nao trocam de work area hoje, mas
955:                     *-- reafirmar o alias eh o que impede que uma mudanca neles
956:                     *-- quebre o laco em silencio
957:                     SELECT cursor_4c_Ficha
958:                 ENDSCAN
959:             ENDIF
960: 
961:         CATCH TO loc_oErro
962:             THIS.this_cMensagemErro = loc_oErro.Message
963:             MsgErro(loc_oErro.Message + CHR(13) + ;
964:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
965:                     "Procedure: " + loc_oErro.Procedure, ;
966:                     "Erro em Formsigopftc.CarregarFichaTecnica")
967:         ENDTRY
968: 
969:         IF !EMPTY(loc_cArea) AND USED(loc_cArea)
970:             SELECT (loc_cArea)
971:         ENDIF
972:     ENDPROC
973: 
974:     *==========================================================================
975:     * DesmontarFichaTecnica - Remove os campos montados (desmontafichatecnica)
976:     *
977:     * Legado:
978:     *     If ThisForm.CriouForm And Used('crTmpFicha') And
979:     *        (ThisForm.pcEscolha <> [PROCURAR]) And ThisForm.MontouCampos
980:     *         ... RemoveObject de sayFicha/shpFicha (por caracteristica),
981:     *             lblFicha e memFicha (por linha) ...
982:     *         If (Reccount('crTmpFicha') > 0)
983:     *             RemoveObject shpFichaFim / sayFichaFim
984:     *         EndIf
985:     *         ThisForm.MontouCampos = .f.

*-- Linhas 1000 a 1018:
1000: 
1001:                 loc_cCar = ""
1002: 
1003:                 SELECT cursor_4c_Ficha
1004:                 GO TOP IN cursor_4c_Ficha
1005:                 SCAN
1006:                     loc_cOrd = ALLTRIM(STR(NVL(cursor_4c_Ficha.cords, 0), 3))
1007: 
1008:                     IF loc_cCar != NVL(cursor_4c_Ficha.ccars, "")
1009:                         loc_cCar = NVL(cursor_4c_Ficha.ccars, "")
1010: 
1011:                         loc_cObj = "lbl_4c_CarFicha" + loc_cOrd
1012:                         IF PEMSTATUS(THIS.cnt_4c_AreaFicha, loc_cObj, 5)
1013:                             THIS.cnt_4c_AreaFicha.RemoveObject(loc_cObj)
1014:                         ENDIF
1015: 
1016:                         loc_cObj = "shp_4c_CarFicha" + loc_cOrd
1017:                         IF PEMSTATUS(THIS.cnt_4c_AreaFicha, loc_cObj, 5)
1018:                             THIS.cnt_4c_AreaFicha.RemoveObject(loc_cObj)

*-- Linhas 1048 a 1066:
1048:         ENDTRY
1049: 
1050:         IF !EMPTY(loc_cArea) AND USED(loc_cArea)
1051:             SELECT (loc_cArea)
1052:         ENDIF
1053:     ENDPROC
1054: 
1055:     *==========================================================================
1056:     * ValidarFichaTecnica - Exige o tamanho MINIMO de cada resposta
1057:     * (validafichatecnica legado)
1058:     *
1059:     * Legado:
1060:     *     If Len(Alltrim(lcVal)) < crTmpFicha.Mins
1061:     *         lcMsgs = 'O Titulo ' + Alltrim(CTits) +
1062:     *                  ' da Caracteristica ' + Alltrim(CCars) + CRLF +
1063:     *                  'deve conter no minimo ' + Alltrim(Str(Mins)) +
1064:     *                  ' caracteres.'
1065:     *         MessageBox(lcMsgs,16,'')
1066:     *         Return(.f.)

*-- Linhas 1081 a 1147:
1081: 
1082:         TRY
1083:             IF USED("cursor_4c_Ficha")
1084:                 SELECT cursor_4c_Ficha
1085:                 GO TOP IN cursor_4c_Ficha
1086:                 SCAN WHILE loc_lValido
1087:                     *-- Mesmo leitor usado por GravarFichaTecnica/FormParaBO:
1088:                     *-- validar com uma conversao e gravar com outra eh como se
1089:                     *-- aprova o que depois nao entra
1090:                     loc_cVal = THIS.LerRespostaDaTela(NVL(cursor_4c_Ficha.cords, 0), ;
1091:                                                       NVL(cursor_4c_Ficha.ctpdados, ""))
1092: 
1093:                     IF LEN(ALLTRIM(loc_cVal)) < NVL(cursor_4c_Ficha.mins, 0)
1094:                         loc_cMsg = "O Titulo " + ALLTRIM(NVL(cursor_4c_Ficha.ctits, "")) + ;
1095:                                    " da Caracteristica " + ALLTRIM(NVL(cursor_4c_Ficha.ccars, "")) + ;
1096:                                    CHR(13) + CHR(10) + ;
1097:                                    "deve conter no minimo " + ;
1098:                                    ALLTRIM(STR(NVL(cursor_4c_Ficha.mins, 0), 3)) + ;
1099:                                    " caracteres."
1100:                         MsgAviso(loc_cMsg, "Aten" + CHR(231) + CHR(227) + "o")
1101:                         loc_lValido = .F.
1102:                     ENDIF
1103: 
1104:                     *-- Reafirma a area antes do SKIP implicito, igual aos
1105:                     *-- outros lacos do form
1106:                     SELECT cursor_4c_Ficha
1107:                 ENDSCAN
1108:             ENDIF
1109: 
1110:         CATCH TO loc_oErro
1111:             loc_lValido = .F.
1112:             THIS.this_cMensagemErro = loc_oErro.Message
1113:             MsgErro(loc_oErro.Message + CHR(13) + ;
1114:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1115:                     "Procedure: " + loc_oErro.Procedure, ;
1116:                     "Erro em Formsigopftc.ValidarFichaTecnica")
1117:         ENDTRY
1118: 
1119:         IF !EMPTY(loc_cArea) AND USED(loc_cArea)
1120:             SELECT (loc_cArea)
1121:         ENDIF
1122: 
1123:         RETURN loc_lValido
1124:     ENDPROC
1125: 
1126:     *==========================================================================
1127:     * CarregarOperacaoComFicha - cursor_4c_Operacao (cnSigCdOpe legado)
1128:     *
1129:     * Legado (checarfichatecnica):
1130:     *     Select Distinct a.Dopes, a.TitOpes, b.CGrus as TemDados
1131:     *       From SigCdOpe a
1132:     *       Left Join SigCdFtc b On a.Dopes = b.CGrus
1133:     *      Where a.Dopes = '<Padr(Operacao,20)>' And b.nTipos = 2
1134:     *      Order By a.Dopes
1135:     *
1136:     * Colunas conferidas em docs/schema.sql (UTF-16, lido com Get-Content -Raw
1137:     * - regra #14): SigCdOpe.dopes char(20), SigCdOpe.titopes char(30),
1138:     * SigCdFtc.cgrus char(20), SigCdFtc.ntipos numeric(1,0).
1139:     *
1140:     * A comparacao usa PADR(...,20) sem ALLTRIM no meio: Dopes eh char(20) e a
1141:     * chave eh POSICIONAL (regra #42).
1142:     *==========================================================================
1143:     PROTECTED PROCEDURE CarregarOperacaoComFicha(par_cOperacao)
1144:         LOCAL loc_lSucesso, loc_cSQL, loc_cDopes, loc_nResultado, loc_oErro
1145: 
1146:         loc_lSucesso = .F.
1147: 

*-- Linhas 1159 a 1184:
1159:                     USE IN cursor_4c_Operacao
1160:                 ENDIF
1161: 
1162:                 loc_cSQL = "SELECT DISTINCT a.dopes, a.titopes, b.cgrus AS temdados" + ;
1163:                            "  FROM SigCdOpe a" + ;
1164:                            "  LEFT JOIN SigCdFtc b ON a.dopes = b.cgrus" + ;
1165:                            " WHERE a.dopes = " + EscaparSQL(loc_cDopes) + ;
1166:                            "   AND b.ntipos = 2" + ;
1167:                            " ORDER BY a.dopes"
1168: 
1169:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacao")
1170: 
1171:                 IF loc_nResultado >= 0
1172:                     loc_lSucesso = .T.
1173:                 ELSE
1174:                     *-- Mesma mensagem do legado para falha de consulta
1175:                     MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
1176:                             CapturarErroSQL(), ;
1177:                             "Falha na Conex" + CHR(227) + "o (cursor_4c_Operacao)")
1178:                 ENDIF
1179:             ENDIF
1180: 
1181:         CATCH TO loc_oErro
1182:             loc_lSucesso = .F.
1183:             THIS.this_cMensagemErro = loc_oErro.Message
1184:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 1194 a 1223:
1194:     * CarregarCaracteristicas - cursor_4c_Ficha (crTmpFicha legado)
1195:     *
1196:     * Legado (montafichatecnica):
1197:     *     Select a.CCars, a.CTits, a.CLins, a.COrds, a.Maxs, a.Mins,
1198:     *            a.nChkCxas, a.cSelecaos, a.cTpDados, b.Resps, c.Descrs
1199:     *       From SigCdFtc a
1200:     *       Left Join SigOpFtc b On '<lcDopes>' + a.CCars + a.CTits = b.DopCarTits
1201:     *       Left Join SigPrCpP c on a.CTits = c.Codigos
1202:     *      Where a.CGrus = '<lcDopes>'
1203:     *        And a.SGrus = Space(6) And a.nTipos = 2
1204:     *      Order By a.COrds
1205:     *
1206:     * DopCarTits eh char(60) = dopes(20) + ccars(20) + ctits(20): chave
1207:     * POSICIONAL montada com PADR e sem ALLTRIM nas partes (regra #42) - o
1208:     * ALLTRIM no meio encurtaria a chave, o JOIN nao casaria e a resposta ja
1209:     * cadastrada da Operacao desapareceria SEM erro nenhum.
1210:     *
1211:     * O cursor sai READWRITE porque GravarFichaTecnica/CarregarFichaTecnica/
1212:     * ValidarFichaTecnica percorrem o alias - cursor de pass-through nasce
1213:     * somente-leitura. O nome e as colunas (cords, ctpdados, ccars, ctits) sao
1214:     * o CONTRATO que a Fase 4 ja documentou em GravarFichaTecnica.
1215:     *==========================================================================
1216:     PROTECTED PROCEDURE CarregarCaracteristicas(par_cOperacao)
1217:         LOCAL loc_lSucesso, loc_cSQL, loc_cDopes, loc_nResultado, loc_oErro
1218: 
1219:         loc_lSucesso = .F.
1220: 
1221:         TRY
1222:             IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1223:                 MsgErro("Favor Reinicializar o Processo!!!", ;

*-- Linhas 1232 a 1266:
1232:                     USE IN cursor_4c_Ficha
1233:                 ENDIF
1234: 
1235:                 loc_cSQL = "SELECT a.ccars, a.ctits, a.clins, a.cords, a.maxs," + ;
1236:                            "       a.mins, a.nchkcxas, a.cselecaos, a.ctpdados," + ;
1237:                            "       b.resps, c.descrs" + ;
1238:                            "  FROM SigCdFtc a" + ;
1239:                            "  LEFT JOIN SigOpFtc b" + ;
1240:                            "    ON " + EscaparSQL(loc_cDopes) + " + a.ccars + a.ctits = b.dopcartits" + ;
1241:                            "  LEFT JOIN SigPrCpP c" + ;
1242:                            "    ON a.ctits = c.codigos" + ;
1243:                            " WHERE a.cgrus = " + EscaparSQL(loc_cDopes) + ;
1244:                            "   AND a.sgrus = SPACE(6)" + ;
1245:                            "   AND a.ntipos = 2" + ;
1246:                            " ORDER BY a.cords"
1247: 
1248:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FichaTmp")
1249: 
1250:                 IF loc_nResultado >= 0
1251:                     SELECT * FROM cursor_4c_FichaTmp ;
1252:                         INTO CURSOR cursor_4c_Ficha READWRITE
1253: 
1254:                     IF USED("cursor_4c_FichaTmp")
1255:                         USE IN cursor_4c_FichaTmp
1256:                     ENDIF
1257: 
1258:                     loc_lSucesso = .T.
1259:                 ELSE
1260:                     MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
1261:                             CapturarErroSQL(), ;
1262:                             "Falha na Conex" + CHR(227) + "o (cursor_4c_Ficha)")
1263:                 ENDIF
1264:             ENDIF
1265: 
1266:         CATCH TO loc_oErro

*-- Linhas 1279 a 1299:
1279:     * RespostaEhFixa - .T. quando a pergunta tem resposta FIXA cadastrada
1280:     *
1281:     * Legado (montafichatecnica):
1282:     *     lcQryResp = [Select nResps from SigCdFtr where GruCarTits = ']
1283:     *                 + lcDopes + crTmpFicha.CCars + crTmpFicha.CTits + [']
1284:     *     If ThisForm.poDataMgr.SQLExecute(lcQryResp,[crResp]) < 1
1285:     *         MessageBox('Favor Reinicializar o Processo!!!') / Return .f.
1286:     *     EndIf
1287:     *     If !Eof([crResp]) and crResp.nResps == 1
1288:     *         llRespFixa = .T.
1289:     *     Endif
1290:     *
1291:     * SigCdFtr.grucartits eh char(66) e a comparacao do legado monta 60
1292:     * caracteres (dopes 20 + ccars 20 + ctits 20) - o SQL Server completa com
1293:     * branco na comparacao de char. Transcrito LITERALMENTE, com PADR em cada
1294:     * parte e sem ALLTRIM no meio (regra #42): acrescentar ou tirar padding
1295:     * mudaria o conjunto de linhas casadas.
1296:     *
1297:     * Falha de consulta devolve .F. (resposta editavel, como o legado deixaria
1298:     * llRespFixa) e ja exibiu a mensagem - nunca silencioso (regra #9).
1299:     *==========================================================================

*-- Linhas 1316 a 1341:
1316:                     USE IN cursor_4c_RespFixa
1317:                 ENDIF
1318: 
1319:                 loc_cSQL = "SELECT nresps FROM SigCdFtr" + ;
1320:                            " WHERE grucartits = " + EscaparSQL(loc_cChave)
1321: 
1322:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RespFixa")
1323: 
1324:                 IF loc_nResultado >= 0
1325:                     IF USED("cursor_4c_RespFixa")
1326:                         SELECT cursor_4c_RespFixa
1327:                         GO TOP IN cursor_4c_RespFixa
1328:                         IF !EOF("cursor_4c_RespFixa")
1329:                             *-- nresps eh numeric(1,0) e chega NUMERICO; coluna
1330:                             *-- de marcacao pode chegar Logica conforme o driver
1331:                             *-- - testar VARTYPE antes de comparar (regra #13).
1332:                             *-- Ordem "L" primeiro, com o NVL no ELSE: eh a
1333:                             *-- forma canonica que o pattern NVL_BIT_FIELD do
1334:                             *-- CorretorAutomatico reconhece como JA corrigida.
1335:                             *-- Com o teste de "N" na frente, o guard de
1336:                             *-- idempotencia dele nao casa e ele reinjeta um
1337:                             *-- IF VARTYPE = "L" ANINHADO dentro do ramo que ja
1338:                             *-- provou ser "N" - codigo morto a cada sweep
1339:                             *-- (regra #44, item 5). Medido rodando o corretor
1340:                             *-- numa copia deste .prg.
1341:                             IF VARTYPE(cursor_4c_RespFixa.nresps) = "L"

*-- Linhas 1362 a 1548:
1362:         ENDTRY
1363: 
1364:         IF !EMPTY(loc_cArea) AND USED(loc_cArea)
1365:             SELECT (loc_cArea)
1366:         ENDIF
1367: 
1368:         RETURN loc_lFixa
1369:     ENDFUNC
1370: 
1371:     *==========================================================================
1372:     * GravarFichaTecnica - Grava as respostas da ficha tecnica em SigCdCet
1373:     *
1374:     * Transcricao de SIGOPFTC.gravafichatecnica (task737). Trecho legado:
1375:     *     If ThisForm.CriouForm And Used("crTmpFicha")
1376:     *         loObjForm1 = ThisForm.poWindowOpe.ScrollBarContainer.ScrollSlide
1377:     *         Zap in crSigCdCeT
1378:     *         Select crTmpFicha
1379:     *         Scan
1380:     *             lcObj = [memFicha] + Alltrim(Str(crTmpFicha.COrds))
1381:     *             lcVal = loObjForm1.&lcObj..Value
1382:     *             If( crTmpFicha.cTpDados == [D] )
1383:     *                 lcVal = Dtoc(lcVal)
1384:     *             Endif
1385:     *             If Not Empty(lcVal)
1386:     *                 Select crSigCdCeT
1387:     *                 Go Top In crSigCdCeT
1388:     *                 Locate For IClis + CCars + CTits = <cliente> + CCars + CTits
1389:     *                 If Eof([crSigCdCeT])
1390:     *                     Insert Into crSigCdCeT (...) Values (..., NewIdChave())
1391:     *                 EndIf
1392:     *             EndIf
1393:     *         EndScan
1394:     *     EndIf
1395:     *     Return(.t.)
1396:     *
1397:     * Equivalencias (CONTRATO que a fase 5 tem de respeitar ao montar a ficha):
1398:     *   crTmpFicha        -> cursor_4c_Ficha, montado por MontarFichaTecnica;
1399:     *                        colunas usadas aqui: cords, ctpdados, ccars, ctits
1400:     *   memFicha<COrds>   -> mem_4c_Ficha<COrds>, filho de cnt_4c_AreaFicha,
1401:     *                        lido por EVALUATE porque o nome eh montado em
1402:     *                        runtime (regras #15 e #34: Controls(<nome>) nao
1403:     *                        funciona e EVALUATE eh a forma correta de LEITURA)
1404:     *   crSigCdCeT        -> cursor_4c_Respostas, respostas JA gravadas do
1405:     *                        cliente (CarregarRespostasGravadas)
1406:     *   crSigCdCli.IClis  -> THIS.this_cIclis, recebido no Init
1407:     *   Insert Into ...   -> sigopftcBO.NovoRegistro() + Salvar(), que faz o
1408:     *                        INSERT real em SigCdCet (NewIdChave -> fUniqueIds,
1409:     *                        regra #22). Inserir() eh PROTECTED no BO, por isso
1410:     *                        a chamada externa vai pelo par PUBLIC NovoRegistro/
1411:     *                        Salvar da BusinessBase (regra #51).
1412:     *
1413:     * DIVERGENCIA DELIBERADA, registrada: o "Zap in crSigCdCeT" do legado
1414:     * esvazia o CURSOR local de respostas antes do SCAN; a propagacao disso
1415:     * para a base depende do buffering do AddCursor Fortyus e nao ha evidencia
1416:     * de que o legado apague respostas ja gravadas. Aqui a gravacao eh direta
1417:     * em SigCdCet e so INCLUI a resposta que ainda NAO existe para o par
1418:     * Caracteristica/Titulo - o mesmo criterio do "If Eof([crSigCdCeT])" e o
1419:     * ja documentado em sigopftcBO.Inserir. Nenhuma resposta existente eh
1420:     * apagada nem sobrescrita (PILAR 2).
1421:     *
1422:     * Retorna .T. como o legado (Return(.t.) incondicional); so devolve .F. se
1423:     * a carga das respostas existentes falhar ou se um INSERT recusar - e nesses
1424:     * casos a mensagem ja foi exibida (CarregarRespostasGravadas / regra #20).
1425:     *==========================================================================
1426:     PROCEDURE GravarFichaTecnica()
1427:         LOCAL loc_lSucesso, loc_cArea, loc_cVal
1428:         LOCAL loc_cCar, loc_cTit, loc_cCarCmp, loc_cTitCmp, loc_oErro
1429: 
1430:         loc_lSucesso = .T.
1431:         loc_cArea    = ALIAS()
1432: 
1433:         TRY
1434:             IF THIS.this_lCriouForm AND USED("cursor_4c_Ficha")
1435:                 IF THIS.CarregarRespostasGravadas()
1436: 
1437:                     SELECT cursor_4c_Ficha
1438:                     GO TOP IN cursor_4c_Ficha
1439:                     SCAN
1440:                         loc_cCar = NVL(cursor_4c_Ficha.ccars, "")
1441:                         loc_cTit = NVL(cursor_4c_Ficha.ctits, "")
1442: 
1443:                         *-- Legado: lcVal = loObjForm1.&lcObj..Value, com
1444:                         *-- Dtoc() quando cTpDados = "D". LerRespostaDaTela eh
1445:                         *-- a fonte unica dessa leitura (a MESMA que
1446:                         *-- ValidarFichaTecnica e FormParaBO usam).
1447:                         loc_cVal = THIS.LerRespostaDaTela(NVL(cursor_4c_Ficha.cords, 0), ;
1448:                                                           NVL(cursor_4c_Ficha.ctpdados, ""))
1449: 
1450:                         IF !EMPTY(loc_cVal)
1451:                             loc_cCarCmp = UPPER(ALLTRIM(loc_cCar))
1452:                             loc_cTitCmp = UPPER(ALLTRIM(loc_cTit))
1453: 
1454:                             SELECT cursor_4c_Respostas
1455:                             GO TOP IN cursor_4c_Respostas
1456:                             LOCATE FOR UPPER(ALLTRIM(NVL(cursor_4c_Respostas.ccars, ""))) == loc_cCarCmp ;
1457:                                    AND UPPER(ALLTRIM(NVL(cursor_4c_Respostas.ctits, ""))) == loc_cTitCmp
1458: 
1459:                             IF EOF("cursor_4c_Respostas")
1460:                                 *-- Volta ao cursor da ficha ANTES do
1461:                                 *-- FormParaBO: ele le a linha CORRENTE de
1462:                                 *-- cursor_4c_Ficha, e o LOCATE acima deixou a
1463:                                 *-- area em cursor_4c_Respostas
1464:                                 SELECT cursor_4c_Ficha
1465: 
1466:                                 *-- NovoRegistro() PRIMEIRO: ele chama
1467:                                 *-- LimparDados/InicializarValoresPadrao e
1468:                                 *-- liga this_lEmEdicao, sem o qual
1469:                                 *-- BusinessBase.Salvar() recusa a gravacao.
1470:                                 *-- Invertido, FormParaBO seria desfeito.
1471:                                 THIS.this_oBusinessObject.NovoRegistro()
1472: 
1473:                                 IF THIS.FormParaBO()
1474:                                     IF THIS.this_oBusinessObject.Salvar()
1475:                                         *-- Equivale ao "Insert Into
1476:                                         *-- crSigCdCeT" do legado: a resposta
1477:                                         *-- recem-gravada passa a constar como
1478:                                         *-- existente, para a mesma
1479:                                         *-- Caracteristica/Titulo nao ser
1480:                                         *-- inserida duas vezes no mesmo SCAN.
1481:                                         INSERT INTO cursor_4c_Respostas (iclis, ccars, ctits) ;
1482:                                                VALUES (THIS.this_cIclis, loc_cCar, loc_cTit)
1483:                                     ELSE
1484:                                         *-- BusinessBase.Salvar ja exibiu a
1485:                                         *-- falha (regra #20) - nao repetir
1486:                                         loc_lSucesso = .F.
1487:                                     ENDIF
1488:                                 ELSE
1489:                                     *-- FormParaBO so devolve .F. quando o
1490:                                     *-- campo da tela esta vazio, e o
1491:                                     *-- !EMPTY acima ja garantiu que nao esta:
1492:                                     *-- chegar aqui significa que o controle
1493:                                     *-- da linha nao existe na tela, e nao ha
1494:                                     *-- resposta para gravar
1495:                                     loc_lSucesso = .F.
1496:                                 ENDIF
1497:                             ENDIF
1498:                         ENDIF
1499: 
1500:                         *-- Volta a area do SCAN antes do SKIP implicito
1501:                         SELECT cursor_4c_Ficha
1502:                     ENDSCAN
1503:                 ELSE
1504:                     loc_lSucesso = .F.
1505:                 ENDIF
1506:             ENDIF
1507: 
1508:         CATCH TO loc_oErro
1509:             loc_lSucesso = .F.
1510:             THIS.this_cMensagemErro = loc_oErro.Message
1511:             MsgErro(loc_oErro.Message + CHR(13) + ;
1512:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1513:                     "Procedure: " + loc_oErro.Procedure, ;
1514:                     "Erro em Formsigopftc.GravarFichaTecnica")
1515:         ENDTRY
1516: 
1517:         IF !EMPTY(loc_cArea) AND USED(loc_cArea)
1518:             SELECT (loc_cArea)
1519:         ENDIF
1520: 
1521:         RETURN loc_lSucesso
1522:     ENDPROC
1523: 
1524:     *==========================================================================
1525:     * CarregarRespostasGravadas - Monta cursor_4c_Respostas com as respostas
1526:     * JA gravadas em SigCdCet para o cliente corrente.
1527:     *
1528:     * Equivale ao cursor crSigCdCeT que o form pai legado mantinha aberto e que
1529:     * gravafichatecnica consulta com Locate antes de inserir. Precisa ser
1530:     * READWRITE porque GravarFichaTecnica acrescenta nele cada resposta que
1531:     * acabou de gravar, reproduzindo o "Insert Into crSigCdCeT" do legado - por
1532:     * isso o SQLEXEC vai num alias TEMPORARIO e o cursor final sai de
1533:     * SELECT ... INTO CURSOR ... READWRITE (cursor de pass-through nasce
1534:     * somente-leitura). O TABLEREVERT do fechamento vem guardado por
1535:     * CURSORGETPROP("Buffering"), senao estoura erro 1586 em cursor sem
1536:     * buffering (regra #52).
1537:     *==========================================================================
1538:     PROTECTED PROCEDURE CarregarRespostasGravadas()
1539:         LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
1540: 
1541:         loc_lSucesso = .F.
1542: 
1543:         TRY
1544:             IF EMPTY(ALLTRIM(THIS.this_cIclis))
1545:                 MsgAviso("Cliente n" + CHR(227) + "o informado - n" + CHR(227) + ;
1546:                          "o h" + CHR(225) + " como gravar a ficha t" + CHR(233) + "cnica.", ;
1547:                          "Aten" + CHR(231) + CHR(227) + "o")
1548:             ELSE

*-- Linhas 1557 a 1581:
1557:                         USE IN cursor_4c_Respostas
1558:                     ENDIF
1559: 
1560:                     loc_cSQL = "SELECT iclis, ccars, ctits FROM SigCdCet" + ;
1561:                                " WHERE iclis = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIclis), 10))
1562: 
1563:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RespostasTmp")
1564: 
1565:                     IF loc_nResultado >= 0
1566:                         SELECT * FROM cursor_4c_RespostasTmp ;
1567:                             INTO CURSOR cursor_4c_Respostas READWRITE
1568: 
1569:                         IF USED("cursor_4c_RespostasTmp")
1570:                             USE IN cursor_4c_RespostasTmp
1571:                         ENDIF
1572: 
1573:                         loc_lSucesso = .T.
1574:                     ELSE
1575:                         MsgErro("Erro ao carregar as respostas j" + CHR(225) + ;
1576:                                 " gravadas da ficha t" + CHR(233) + "cnica:" + CHR(13) + ;
1577:                                 CapturarErroSQL(), "Erro SQL")
1578:                     ENDIF
1579:                 ENDIF
1580:             ENDIF
1581: 

*-- Linhas 1599 a 1617:
1599:     * Eh o bloco "If llOks / If Not Empty(ThisForm.Operacao)" do
1600:     * checarfichatecnica legado, extraido para ter ponto de recarga:
1601:     *     <query cnSigCdOpe>  -> CarregarOperacaoComFicha
1602:     *     Select cnSigCdOpe / Go Top
1603:     *     If Not This.MontaFichaTecnica(ThisForm.Operacao) / Return 0
1604:     *
1605:     * A "lista" deste dialogo eh a relacao de caracteristicas (cursor_4c_Ficha,
1606:     * o crTmpFicha legado), que o legado nao exibe em Grid e sim como uma pilha
1607:     * de pares pergunta/resposta - montada em runtime por MontarFichaTecnica.
1608:     * Nao ha Grid algum no SCX (4 objetos visuais, zero BaseClass grid), entao
1609:     * repintar aqui eh Refresh do container que hospeda a pilha, e nao
1610:     * GO TOP + Grid.Refresh de grade; o GO TOP no cursor fica, porque o
1611:     * MontarFichaTecnica e os metodos de gravacao/validacao percorrem o alias
1612:     * do inicio (regra #21a).
1613:     *
1614:     * DesmontarFichaTecnica PRIMEIRO, e por dois motivos: (a) remontar sobre
1615:     * controle que ja existe estoura "Object ... is already defined" e mata o
1616:     * dialogo - o legado deixa esse caminho aberto quando chamado com
1617:     * [GRUPO_OP] e pcEscolha <> INSERIR (divergencia declarada no cabecalho);

*-- Linhas 1641 a 1687:
1641: 
1642:                 IF THIS.CarregarOperacaoComFicha(THIS.this_cOperacao)
1643:                     IF USED("cursor_4c_Operacao")
1644:                         SELECT cursor_4c_Operacao
1645:                         GO TOP IN cursor_4c_Operacao
1646:                     ENDIF
1647: 
1648:                     loc_lSucesso = THIS.MontarFichaTecnica(THIS.this_cOperacao)
1649: 
1650:                     *-- Popular cursor NAO repinta o que esta na tela
1651:                     *-- (regra #21a). Aqui o equivalente ao Grid.Refresh eh o
1652:                     *-- Refresh do container que hospeda a pilha de campos.
1653:                     IF USED("cursor_4c_Ficha")
1654:                         SELECT cursor_4c_Ficha
1655:                         GO TOP IN cursor_4c_Ficha
1656:                     ENDIF
1657: 
1658:                     THIS.cnt_4c_AreaFicha.Refresh()
1659:                 ENDIF
1660:             ENDIF
1661: 
1662:         CATCH TO loc_oErro
1663:             loc_lSucesso = .F.
1664:             THIS.this_cMensagemErro = loc_oErro.Message
1665:             MsgErro(loc_oErro.Message + CHR(13) + ;
1666:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1667:                     "Procedure: " + loc_oErro.Procedure, ;
1668:                     "Erro em Formsigopftc.CarregarLista")
1669:         ENDTRY
1670: 
1671:         IF !EMPTY(loc_cArea) AND USED(loc_cArea)
1672:             SELECT (loc_cArea)
1673:         ENDIF
1674: 
1675:         RETURN loc_lSucesso
1676:     ENDPROC
1677: 
1678:     *==========================================================================
1679:     * HabilitarCampos - Liga/desliga em bloco a edicao dos campos da ficha
1680:     *
1681:     * Legado (montafichatecnica, por controle, na criacao):
1682:     *     .ReadOnly = Not InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])
1683:     * e, no ramo de texto, a resposta FIXA cadastrada tambem entra travada:
1684:     *     If !Eof([crResp]) and crResp.nResps == 1 / llRespFixa = .T.
1685:     *
1686:     * Aqui num passe UNICO sobre os campos montados, chamado no fim de
1687:     * MontarFichaTecnica. Resposta FIXA fica travada em QUALQUER modo: a marca

*-- Linhas 1705 a 1750:
1705: 
1706:         TRY
1707:             IF THIS.this_lCriouForm AND USED("cursor_4c_Ficha")
1708:                 SELECT cursor_4c_Ficha
1709:                 GO TOP IN cursor_4c_Ficha
1710:                 SCAN
1711:                     loc_oCtrl = THIS.ObterControleResposta(NVL(cursor_4c_Ficha.cords, 0))
1712: 
1713:                     IF VARTYPE(loc_oCtrl) = "O"
1714:                         *-- Campo com resposta FIXA nunca destrava
1715:                         IF UPPER(ALLTRIM(NVL(loc_oCtrl.Tag, ""))) == "FIXA"
1716:                             loc_oCtrl.ReadOnly = .T.
1717:                         ELSE
1718:                             loc_oCtrl.ReadOnly = !loc_lHabilitar
1719:                         ENDIF
1720:                     ENDIF
1721: 
1722:                     SELECT cursor_4c_Ficha
1723:                 ENDSCAN
1724:             ENDIF
1725: 
1726:         CATCH TO loc_oErro
1727:             THIS.this_cMensagemErro = loc_oErro.Message
1728:             MsgErro(loc_oErro.Message + CHR(13) + ;
1729:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1730:                     "Procedure: " + loc_oErro.Procedure, ;
1731:                     "Erro em Formsigopftc.HabilitarCampos")
1732:         ENDTRY
1733: 
1734:         IF !EMPTY(loc_cArea) AND USED(loc_cArea)
1735:             SELECT (loc_cArea)
1736:         ENDIF
1737:     ENDPROC
1738: 
1739:     *==========================================================================
1740:     * ObterControleResposta - Devolve o campo de resposta mem_4c_Ficha<COrds>
1741:     * (ou .NULL. quando a linha nao tem controle montado na tela)
1742:     *
1743:     * Fonte UNICA da montagem desse nome em runtime. Antes da Fase 8 o par
1744:     * PEMSTATUS + EVALUATE estava repetido em cinco metodos, e qualquer
1745:     * divergencia na forma de montar o sufixo (NVL, STR com largura diferente,
1746:     * ALLTRIM) faria um deles procurar um nome que outro nunca criou - defeito
1747:     * silencioso, porque PEMSTATUS apenas devolveria .F. e o campo seria
1748:     * ignorado.
1749:     *
1750:     * EVALUATE eh a forma correta de alcancar membro por NOME: Controls(<nome>)

*-- Linhas 1825 a 1843:
1825:     *
1826:     * this_cSgrus recebe SPACE(6) porque eh exatamente o valor que
1827:     * CarregarCaracteristicas usa no filtro (a.sgrus = SPACE(6)) e a coluna nao
1828:     * vem no SELECT - ler do cursor estouraria.
1829:     *
1830:     * NAO toca this_cIclis/this_cTipoAcao/this_cOperacao: esses tres sao o
1831:     * contexto recebido no Init, nao variam por linha, e FormParaBO os repoe
1832:     * depois do NovoRegistro().
1833:     *==========================================================================
1834:     PROTECTED PROCEDURE CarregarLinhaFichaNoBO()
1835:         IF !USED("cursor_4c_Ficha") OR EOF("cursor_4c_Ficha")
1836:             *-- Sem linha corrente nao ha o que transferir. Guarda por IF e
1837:             *-- nao por RETURN de saida antecipada (regra #1): este metodo eh
1838:             *-- chamado de dentro do TRY de CarregarFichaTecnica e do TRY de
1839:             *-- GravarFichaTecnica (via FormParaBO)
1840:         ELSE
1841:             WITH THIS.this_oBusinessObject
1842:                 .this_cCcars    = TratarNulo(cursor_4c_Ficha.ccars,     "")
1843:                 .this_cCtits    = TratarNulo(cursor_4c_Ficha.ctits,     "")

*-- Linhas 1851 a 1882:
1851:                 .this_cDescrs   = TratarNulo(cursor_4c_Ficha.descrs,    "")
1852:                 .this_cResps    = TratarNulo(cursor_4c_Ficha.resps,     "")
1853: 
1854:                 *-- Nao vem no SELECT: eh o valor fixo do filtro de
1855:                 *-- CarregarCaracteristicas (a.sgrus = SPACE(6))
1856:                 .this_cSgrus    = SPACE(6)
1857:             ENDWITH
1858:         ENDIF
1859:     ENDPROC
1860: 
1861:     *==========================================================================
1862:     * FormParaBO - Campos da TELA + linha corrente da ficha -> properties do BO
1863:     *
1864:     * Reune, para a linha CORRENTE de cursor_4c_Ficha, o que o
1865:     * gravafichatecnica legado monta antes do Insert:
1866:     *     lcVal = loObjForm1.&lcObj..Value   (+ Dtoc se cTpDados = "D")
1867:     *     Insert Into crSigCdCeT (IClis, CCars, CTits, Resps, ...)
1868:     *            Values (crSigCdCli.IClis, crTmpFicha.CCars,
1869:     *                    crTmpFicha.CTits, lcVal, ..., NewIdChave())
1870:     * O IClis vem de THIS.this_cIclis (recebido no Init, equivalente ao cursor
1871:     * global crSigCdCli do form pai) e o cidchaves eh gerado por
1872:     * sigopftcBO.Inserir com fUniqueIds() (regra #22).
1873:     *
1874:     * Chamado DEPOIS de NovoRegistro(): aquele limpa as properties e liga
1875:     * this_lEmEdicao (sem o qual BusinessBase.Salvar() recusa a gravacao), logo
1876:     * a ordem inversa desfaria esta transferencia.
1877:     *
1878:     * Retorna .F. - e NAO transfere - quando a resposta da tela esta vazia:
1879:     * eh o "If Not Empty(lcVal)" do legado, que nunca grava resposta em branco
1880:     * (e as cinco colunas de SigCdCet sao NOT NULL). Em vez de gravar vazio em
1881:     * silencio, quem chama decide; GravarFichaTecnica ja filtra antes, entao
1882:     * este retorno eh a segunda barreira, nao a primeira.


### BO (C:\4c\projeto\app\classes\sigopftcBO.prg):
*==============================================================================
* sigopftcBO.prg
*
* Business Object para sigopftc (Ficha de Complementos da Movimentacao)
* Dialogo filho MODAL, aberto por um form de movimentacao/pedido para
* coletar as respostas da "ficha tecnica" (caracteristicas) associadas a
* uma Operacao (SigCdOpe.Dopes), para o cliente corrente (crSigCdCli).
*
* O legado monta dinamicamente um campo por caracteristica cadastrada em
* SigCdFtc para a Operacao informada (join com SigOpFtc para a resposta
* padrao da operacao e com SigPrCpP para a descricao da pergunta), exibe
* esses campos num container com scroll (frmbarcta) e, ao confirmar, grava
* a resposta de cada caracteristica em SIGCDCET (chave: cidchaves; chave de
* negocio: IClis+CCars+CTits) num SCAN com Locate + Insert condicional -
* nao ha Update nem Delete no fluxo legado (MontaFichaTecnica/
* GravarFichaTecnica no Formsigopftc.prg).
*
* Nao ha, portanto, um unico registro "principal" no sentido de
* BusinessBase.Inserir()/Atualizar(): a persistencia real percorre o
* cursor de caracteristicas linha a linha. this_cTabela/this_cCampoChave
* abaixo documentam o alvo efetivo da gravacao (SIGCDCET/cidchaves), que
* e usado pelo metodo de gravacao em lote Formsigopftc.GravarFichaTecnica,
* que para cada linha chama NovoRegistro() + FormParaBO() + Salvar().
*==============================================================================

DEFINE CLASS sigopftcBO AS BusinessBase

    *-- Contexto recebido do form pai (Init legado: Lparameters pCnx, pcTipo,
    *-- pcDopes). pCnx (poDataMgr) nao e replicado aqui - o BO usa o handle
    *-- global gnConnHandle, como toda a nova arquitetura.
    this_cTipoAcao      = ""    && char - pcEscolha herdado do form pai (INSERIR/ALTERAR/CONSULTAR/PROCURAR)
    this_cOperacao      = ""    && char(20) - Dopes: codigo da Operacao (SigCdOpe.Dopes) cujas caracteristicas sao exibidas

    *-- Cliente ao qual a ficha pertence (equivalente a crSigCdCli no legado,
    *-- cursor global do form pai - aqui replicado como property porque o BO
    *-- precisa dele para montar a chave de SIGCDCET)
    this_cIclis         = ""    && char(10) - codigo do cliente (SigCdCli.IClis)

    *-- Linha corrente da caracteristica sendo exibida/respondida, espelhando
    *-- o cursor crTmpFicha (SigCdFtc + SigOpFtc + SigPrCpP) montado em
    *-- MontaFichaTecnica no legado
    this_cCcars         = ""    && char(20) - codigo da caracteristica (SigCdFtc.CCars)
    this_cCtits         = ""    && char(20) - codigo do titulo/pergunta (SigCdFtc.CTits)
    this_nClins         = 0     && numeric(2,0) - numero de linhas do campo de resposta (SigCdFtc.CLins)
    this_nCords         = 0     && numeric(3,0) - ordem de exibicao da caracteristica (SigCdFtc.COrds)
    this_nMaxs          = 0     && numeric(3,0) - tamanho maximo aceito na resposta (SigCdFtc.Maxs)
    this_nMins          = 0     && numeric(3,0) - tamanho minimo obrigatorio da resposta (SigCdFtc.Mins)
    this_cSgrus         = ""    && char(6)  - subgrupo da caracteristica (SigCdFtc.SGrus)
    this_cSelecaos      = ""    && char(1)  - "S" = pergunta com opcoes fixas de selecao (SigCdFtc.cSelecaos)
    this_nChkCxas       = 0     && numeric(1,0) - tipo de caixa de selecao da pergunta (SigCdFtc.nChkCxas)
    this_cTpDados       = ""    && char(1)  - tipo de dado da resposta: "D" = data, outro = texto (SigCdFtc.cTpDados)
    this_cDescrs        = ""    && char(40) - descricao da pergunta (SigPrCpP.Descrs, quando cadastrada)

    *-- Resposta da caracteristica corrente: SIGCDCET guarda a resposta do
    *-- cliente (gravada por GravaFichaTecnica), SigOpFtc guarda a resposta
    *-- padrao/ja existente da Operacao (lida no Join de MontaFichaTecnica)
    this_cResps         = ""    && memo/char - resposta digitada pelo usuario (SIGCDCET.Resps / SigOpFtc.Resps)
    this_cClicartits    = ""    && char(50) - chave concatenada IClis+CCars+CTits (SIGCDCET.CliCarTits)
    this_cCidchaves     = ""    && char(20) - chave unica do registro de resposta (SIGCDCET.cIdChaves), gerada por fUniqueIds() na gravacao

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        *-- Alvo real da gravacao em lote (Formsigopftc.GravarFichaTecnica).
        *-- Nao existe Inserir()/Atualizar() de registro unico neste BO: a
        *-- gravacao percorre o cursor de caracteristicas e insere em
        *-- SIGCDCET apenas as respostas nao vazias ainda nao cadastradas
        *-- para o cliente (mesmo criterio do legado Gravafichatecnica()).
        THIS.this_cTabela     = "SigCdCet"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria da resposta corrente (SIGCDCET.cidchaves)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarClicartits - Monta a chave POSICIONAL CliCarTits (IClis+CCars+CTits)
    *
    * SIGCDCET.clicartits char(50) = iclis char(10) + ccars char(20) +
    * ctits char(20). O legado concatena os valores das COLUNAS da tabela
    * (ja padded pelo SQL Server), nunca ALLTRIM das partes - regra da chave
    * posicional: ALLTRIM no meio da concatenacao quebra o casamento contra
    * o que esta gravado (ver CLAUDE.md regra #42 / MontarChaveEmpDopNums).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarClicartits()
        THIS.this_cClicartits = PADR(ALLTRIM(THIS.this_cIclis), 10) + ;
                                 PADR(ALLTRIM(THIS.this_cCcars), 20) + ;
                                 PADR(ALLTRIM(THIS.this_cCtits), 20)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades da resposta a partir de um
    * cursor SELECT * FROM SigCdCet (uma resposta JA gravada do cliente).
    * NAO serve para cursor_4c_Ficha, que nao tem cidchaves/clicartits - a
    * leitura daquele cursor eh Formsigopftc.CarregarLinhaFichaNoBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidchaves  = TratarNulo(cidchaves,  "")
                THIS.this_cIclis      = TratarNulo(iclis,      "")
                THIS.this_cCcars      = TratarNulo(ccars,      "")
                THIS.this_cCtits      = TratarNulo(ctits,      "")
                THIS.this_cClicartits = TratarNulo(clicartits, "")
                THIS.this_cResps      = TratarNulo(resps,      "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar resposta da ficha t" + CHR(233) + "cnica:" + CHR(13) + loc_oErro.Message, "sigopftcBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de uma resposta de caracteristica em SIGCDCET
    *
    * Equivalente ao "Insert Into crSigCdCeT (...)" de GravaFichaTecnica no
    * legado (Formsigopftc.GravarFichaTecnica chama via Salvar(), uma vez por caracteristica
    * respondida, so quando a LOCATE por IClis+CCars+CTits nao achou linha -
    * o legado NUNCA sobrescreve uma resposta ja gravada, so inclui a que
    * falta). cidchaves gerado por fUniqueIds() (regra #22 - chave Fortyus,
    * nunca string vazia) no lugar do NewIdChave() legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            THIS.MontarClicartits()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCet (iclis, ccars, ctits, resps, clicartits, cidchaves)
                VALUES (
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cIclis), 10))>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cCcars), 20))>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cCtits), 20))>>,
                    <<EscaparSQL(THIS.this_cResps)>>,
                    <<EscaparSQL(THIS.this_cClicartits)>>,
                    <<EscaparSQL(THIS.this_cCidchaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir resposta da ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir resposta da ficha t" + CHR(233) + "cnica:" + CHR(13) + loc_oErro.Message, "sigopftcBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE da resposta em SIGCDCET, identificada por cidchaves
    *
    * O fluxo legado (GravaFichaTecnica) NUNCA atualiza uma resposta ja
    * gravada - a LOCATE por IClis+CCars+CTits so insere quando nao acha.
    * Este metodo existe pela convencao de BusinessBase (toda subclasse
    * expoe Inserir/Atualizar) e fica disponivel para uma correcao pontual
    * de resposta via cidchaves, sem alterar a chave de negocio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCet
                SET resps      = <<EscaparSQL(THIS.this_cResps)>>,
                    iclis      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cIclis), 10))>>,
                    ccars      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cCcars), 20))>>,
                    ctits      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cCtits), 20))>>,
                    clicartits = <<EscaparSQL(THIS.this_cClicartits)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidchaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar resposta da ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar resposta da ficha t" + CHR(233) + "cnica:" + CHR(13) + loc_oErro.Message, "sigopftcBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

