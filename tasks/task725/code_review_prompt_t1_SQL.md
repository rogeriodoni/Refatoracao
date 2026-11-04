# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNRETORNO, NSHIFTALTCTRL, LLONERRO1, FPAGS, CEMPS, TIPOCAMPO, CODBINS, LNTIPO, LCBANDEIRA, PROXIMOCOMANDO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CNCAIXAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNRETORNO, NSHIFTALTCTRL, LLONERRO1, FPAGS, CEMPS, TIPOCAMPO, CODBINS, LNTIPO, LCBANDEIRA, PROXIMOCOMANDO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ENABLED' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNRETORNO, NSHIFTALTCTRL, LLONERRO1, FPAGS, CEMPS, TIPOCAMPO, CODBINS, LNTIPO, LCBANDEIRA, PROXIMOCOMANDO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TABINDEX' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNRETORNO, NSHIFTALTCTRL, LLONERRO1, FPAGS, CEMPS, TIPOCAMPO, CODBINS, LNTIPO, LCBANDEIRA, PROXIMOCOMANDO

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
  ControlSource = "OPSENHA"
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = "+STR(ltIdent,10))
INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("003-000 = "+lsValPago)
INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("010-000 = "+laCartao[VAL(lsCartao)+1])
INSERT INTO crSiTef (Tef) VALUES ("011-000 = "+lsTipTran)
INSERT INTO crSiTef (Tef) VALUES ("012-000 = "+lsNsu)
INSERT INTO crSiTef (Tef) VALUES ("013-000 = "+lsAutoriza)
INSERT INTO crSiTef (Tef) VALUES ("015-000 = "+SUBSTR(lsDataHora,7,2)+SUBSTR(lsDataHora,5,2)+SUBSTR(lsDataHora,9,6))
INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("018-000 = "+ThisForm.Text1.Value)
INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("022-000 = "+SUBSTR(lsDataHora,7,2)+SUBSTR(lsDataHora,5,2)+SUBSTR(lsDataHora,1,4))
INSERT INTO crSiTef (Tef) VALUES ("023-000 = "+SUBSTR(lsDataHora,9,6))
INSERT INTO crSiTef (Tef) VALUES ("023-000 = "+lsFinaliza)
INSERT INTO crSiTef (Tef) VALUES ("027-000 = "+SUBSTR(lsDataHora,9,6))
	INSERT INTO crSiTef (Tef) VALUES (STRTRAN("029-"+TRANSFORM(lnLinha,"@L 999")+" = "+IIF(lsPos<>0,SUBSTR(lsCupom,1,lsPos-1),lsCupom),CHR(0),' '))
INSERT INTO crSiTef (Tef) VALUES ("028-000 = "+ALLTRIM(STR(lnLinha-2)))
INSERT INTO crSiTef (Tef) VALUES ("030-000 = "+MenRet)
INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
SELECT crSitef 
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = "+STR(ltIdent,10))
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = "+STR(ltIdent,10))
INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("003-000 = "+lsValPago)
INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("030-000 = "+IIF("AGUARDE"$UPPER(lcMensagem),"TRANSACAO CANCELADA",lcMensagem))
INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
SELECT crSitef 
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = "+STR(ltIdent,10))
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
	.poDatamgr.SqlExecute([Select * From SigOpFp Where FPags = ?lcOpers],'crSigOpFp')
	.poDatamgr.SqlExecute([Select * From SigCdEmp Where cEmps = ?_Empr],'crSigCdEmp')
		lcQuery = [Select ChkBins From SigOpFp Where FPags = '] + ThisForm.pcOpers + [']
		ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPag])
			lcQuery = [Select CodBins, DataIs, DataFs From SigOpFpb Where FPags = '] + ThisForm.pcOpers + [' ] + ;
			ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPagb]) 
		lcQuery = [Select ChkBins From SigOpFp Where FPags = '] + ThisForm.pcOpers + [']
		ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPag])
			lcQuery = [Select CodBins, DataIs, DataFs From SigOpFpb Where FPags = '] + ThisForm.pcOpers + [' ] + ;
			ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPagb]) 
				SELECT SigTef
		lcQuery = [Select ChkBins From SigOpFp Where FPags = '] + ThisForm.pcOpers + [']
		ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPag])
			lcQuery = [Select CodBins, DataIs, DataFs From SigOpFpb Where FPags = '] + ThisForm.pcOpers + [' ] + ;
			ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPagb]) 
			lcQuery = [Select ChkBins From SigOpFp Where FPags = '] + ThisForm.pcOpers + [']
			ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPag])
				lcQuery = [Select CodBins, DataIs, DataFs From SigOpFpb Where FPags = '] + ThisForm.pcOpers + [' ] + ;
				ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPagb]) 
		lcQuery = [Select ChkBins From SigOpFp Where FPags = '] + ThisForm.pcOpers + [']
		ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPag])
			lcQuery = [Select CodBins, DataIs, DataFs From SigOpFpb Where FPags = '] + ThisForm.pcOpers + [' ] + ;
			ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPagb]) 

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopdtf.prg) - TRECHOS RELEVANTES PARA PASS SQL (3699 linhas total):

*-- Linhas 56 a 75:
56: * por AST, nunca por dot-source): o gate de conteudo da Fase 5 PASSA pelo
57: * ramo CAPTURA - temListaEstritaF5 = False (zero BaseClass grid|pageframe,
58: * e os helpers estritos ListBoxLigaLista/TokenGradeProprioForm/
59: * AddCursorLigaGrade/ControlSourceLigaLista todos False; a UNICA ocorrencia
60: * de ControlSource no dump eh o "OPSENHA" do CommandGroup SAIDA, vestigio da
61: * classe Grupo_Saida que NAO eh prova de lista), temCampoCaptura = True,
62: * apiNos = False, dialogoExibicao = False, legadoCapturaF5 = True, e do lado
63: * migrado 6 TextBox contra um piso de 3 (metade dos 6 do legado).
64: *
65: * O que FORCOU o retry desta fase nao foi o gate, foi o guard de NO-OP, que
66: * roda ANTES dele e usa o predicado do perfil DESPACHANTE
67: * (Test-LegadoSemCampoNemLista = False aqui, porque este legado TEM campos).
68: * Divergencia guard-x-gate ja registrada na memoria do projeto para a Fase 6
69: * (task699/SIGOPCHP) e para a Fase 4 (task699, task715, task717); esta eh a
70: * primeira ocorrencia medida na Fase 5. Nao se conserta no .prg: as duas
71: * unicas formas de "satisfazer" o guard escrevendo codigo seriam inventar
72: * campos que o legado nao tem (viola o PILAR 1) ou criar um
73: * ConfigurarPaginaDados vazio (stub disfarcado, proibido pela regra de
74: * completude). O fix cabe no guard do orquestrador - e nao foi feito agora
75: * porque ha RunLoop VIVO (PID 20544) e 1062 insercoes nao commitadas no

*-- Linhas 325 a 343:
325: 
326:                 *-- Transfere os parametros recebidos no Init para o BO e monta
327:                 *-- o identificador de terminal (migrado de SIGOPDTF.Init WITH
328:                 *-- Thisform / .poDatamgr.SqlExecute ...). Pulado em modo de
329:                 *-- teste headless (sem gnConnHandle real).
330:                 IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
331:                     THIS.this_oBusinessObject.this_cEndSiTef = THIS.this_cEndSiTef
332:                     THIS.this_oBusinessObject.this_nValPago  = THIS.this_nValPago
333:                     THIS.this_oBusinessObject.this_cCupom    = THIS.this_cCupom
334:                     THIS.this_oBusinessObject.this_cCaixa    = THIS.this_cCaixa
335:                     THIS.this_oBusinessObject.this_cTipPagto = THIS.this_cTipPagto
336:                     THIS.this_oBusinessObject.this_nNumParcs = THIS.this_nNumParcs
337:                     THIS.this_oBusinessObject.this_cIdent    = THIS.this_cIdent
338:                     THIS.this_oBusinessObject.this_cOpers    = THIS.this_cOpers
339: 
340:                     THIS.this_oBusinessObject.CarregarIdentificacaoTerminal()
341: 
342:                     *-- FASE 8/8: le a forma de pagamento (crSigOpFp do Init
343:                     *-- legado). TEM de vir ANTES de ConfigurarValoresIniciais,

*-- Linhas 784 a 802:
784:     *--------------------------------------------------------------------------
785:     * ConfigurarBotaoSaida - CommandGroup obj_4c_SAIDA com o botao Cancelar
786:     * (unico botao do form - dialogo modal de captura, sem CRUD).
787:     * Migrado de: SIGOPDTF.SAIDA (Command1/CANCELA). ControlSource="OPSENHA"
788:     * do dump NAO transcrito - artefato de template do Form Designer sem
789:     * campo correspondente (grupo tem 1 unico botao, nao ha o que refletir).
790:     *--------------------------------------------------------------------------
791:     PROTECTED PROCEDURE ConfigurarBotaoSaida()
792:         THIS.AddObject("obj_4c_SAIDA", "CommandGroup")
793:         WITH THIS.obj_4c_SAIDA
794:             .ButtonCount = 1
795:             .Top         = -2
796:             .Left        = 387
797:             .Width       = 85
798:             .Height      = 85
799:             .BorderStyle = 0
800:             *-- SCX legado: SAIDA.BackStyle = 0 (transparente). CommandGroup TEM
801:             *-- BackStyle - sem esta linha o grupo nasce opaco (default 1) e
802:             *-- pinta um retangulo branco sobre a faixa cinza do cabecalho.

*-- Linhas 1149 a 1167:
1149:     * lnValPago). Monta o cursor local crSiTef (buffer de protocolo) e grava
1150:     * os dois arquivos SDF que o software de retaguarda / PDV le
1151:     * (C:\client\Resp\IntPos.001 e IntPos.STS). Nenhuma tabela do SQL Server
1152:     * eh tocada aqui - o INSERT eh todo em cursor de memoria.
1153:     *
1154:     * A assinatura mantem os DOIS parametros do legado porque os dois call
1155:     * sites passam valores DIFERENTES e isso muda o arquivo gravado:
1156:     * ErroTef passa "0,00" (CARACTERE) e o Click do Cancelar passa o valor
1157:     * numerico da transacao. Medido no VFP9 em 2026-10-31
1158:     * (probe descartavel) que a formula do legado atende os dois tipos
1159:     * sem ramificar, e por isso ela eh transcrita LITERALMENTE:
1160:     *     TRANSFORM("0,00",  "99999999999.99") -> "0,00"    (passa direto)
1161:     *     TRANSFORM(1234.56, "99999999999.99") -> "1234,56" (apos o STRTRAN)
1162:     * O IIF de VARTYPE abaixo NAO eh ramo de formato: eh guarda para o
1163:     * parametro AUSENTE, que chegaria como .F. logico e faria o TRANSFORM
1164:     * estourar. Os dois call sites reais nunca caem nela.
1165:     *
1166:     * "001-000" usa STR(VAL(this_cIdent), 10) porque o legado faz
1167:     * STR(ltIdent, 10) sobre o identificador recebido no Init, que aqui eh

*-- Linhas 1191 a 1230:
1191:             IF USED("crSiTef")
1192:                 USE IN crSiTef
1193:             ENDIF
1194:             CREATE CURSOR crSiTef (tef c(100))
1195: 
1196:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1197:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
1198:             INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
1199:             INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
1200:             INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
1201:             INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
1202:             INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
1203:             INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
1204:             INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + ;
1205:                 IIF("AGUARDE" $ UPPER(loc_cMensagem), "TRANSACAO CANCELADA", loc_cMensagem))
1206:             INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
1207:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1208: 
1209:             SELECT crSiTef
1210:             COPY TO C:\client\Resp\IntPos.001 SDF
1211:             ZAP
1212: 
1213:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1214:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
1215:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1216: 
1217:             COPY TO C:\client\Resp\IntPos.STS SDF
1218: 
1219:             USE IN crSiTef
1220:         CATCH TO loc_oErro
1221:             MsgErro(loc_oErro.Message + CHR(13) + ;
1222:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1223:                     "Procedure: " + loc_oErro.Procedure, ;
1224:                     "Erro ao gravar retorno SiTef")
1225:         ENDTRY
1226:     ENDPROC
1227: 
1228:     *--------------------------------------------------------------------------
1229:     * BtnCancelarClick - migrado de SIGOPDTF.SAIDA.CANCELA.Click, INTEIRO:
1230:     *     lnRetorno=ContinuaFuncaoSiTefInterativo(@ProximoComando, @TipoCampo,

*-- Linhas 3223 a 3290:
3223:             IF USED("crSiTef")
3224:                 USE IN crSiTef
3225:             ENDIF
3226:             CREATE CURSOR crSiTef (tef c(100))
3227: 
3228:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
3229:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
3230:             INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
3231:             INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
3232:             INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
3233:             INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
3234:             INSERT INTO crSiTef (Tef) VALUES ("010-000 = " + loc_aCartao[VAL(loc_cLsCartao) + 1])
3235:             INSERT INTO crSiTef (Tef) VALUES ("011-000 = " + IIF(VARTYPE(par_cTipTran) = "C", par_cTipTran, ""))
3236:             INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + IIF(VARTYPE(par_cNsu) = "C", par_cNsu, ""))
3237:             INSERT INTO crSiTef (Tef) VALUES ("013-000 = " + IIF(VARTYPE(par_cAutoriza) = "C", par_cAutoriza, ""))
3238:             INSERT INTO crSiTef (Tef) VALUES ("015-000 = " + SUBSTR(loc_cDataHora, 7, 2) + ;
3239:                 SUBSTR(loc_cDataHora, 5, 2) + SUBSTR(loc_cDataHora, 9, 6))
3240:             INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
3241:             INSERT INTO crSiTef (Tef) VALUES ("018-000 = " + THIS.txt_4c_Text1.Value)
3242:             INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
3243:             INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
3244:             INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
3245:             INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
3246:             INSERT INTO crSiTef (Tef) VALUES ("022-000 = " + SUBSTR(loc_cDataHora, 7, 2) + ;
3247:                 SUBSTR(loc_cDataHora, 5, 2) + SUBSTR(loc_cDataHora, 1, 4))
3248:             INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + SUBSTR(loc_cDataHora, 9, 6))
3249:             INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + IIF(VARTYPE(par_cFinaliza) = "C", par_cFinaliza, ""))
3250:             INSERT INTO crSiTef (Tef) VALUES ("027-000 = " + SUBSTR(loc_cDataHora, 9, 6))
3251: 
3252:             loc_nPos   = 1
3253:             loc_nLinha = 1
3254:             DO WHILE loc_nPos != 0
3255:                 loc_nPos = AT(CHR(10), loc_cCupom)
3256:                 INSERT INTO crSiTef (Tef) VALUES (STRTRAN("029-" + ;
3257:                     TRANSFORM(loc_nLinha, "@L 999") + " = " + ;
3258:                     IIF(loc_nPos != 0, SUBSTR(loc_cCupom, 1, loc_nPos - 1), loc_cCupom), ;
3259:                     CHR(0), " "))
3260:                 loc_cCupom = SUBSTR(loc_cCupom, loc_nPos + 1)
3261:                 loc_nLinha = loc_nLinha + 1
3262:             ENDDO
3263: 
3264:             INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
3265:             INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + IIF(VARTYPE(par_cMenRet) = "C", par_cMenRet, ""))
3266:             INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
3267:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
3268: 
3269:             SELECT crSiTef
3270:             COPY TO C:\client\Resp\IntPos.001 SDF
3271:             ZAP
3272: 
3273:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
3274:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
3275:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
3276: 
3277:             COPY TO C:\client\Resp\IntPos.STS SDF
3278: 
3279:             USE IN crSiTef
3280:         CATCH TO loc_oErro
3281:             MsgErro(loc_oErro.Message + CHR(13) + ;
3282:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3283:                     "Procedure: " + loc_oErro.Procedure, ;
3284:                     "Erro ao gravar retorno SiTef")
3285:         ENDTRY
3286:     ENDPROC
3287: 
3288:     *--------------------------------------------------------------------------
3289:     * FormParaBO - transfere os campos da tela para as properties do BO.
3290:     *

*-- Linhas 3630 a 3649:
3630:     *   - CarregarLista: nao ha lista. Zero "BaseClass: grid" e zero
3631:     *     "BaseClass: pageframe" na arvore do SCX, e os quatro testes estritos
3632:     *     de lista do pipeline (ListBoxLigaLista, TokenGradeProprioForm,
3633:     *     AddCursorLigaGrade, ControlSourceLigaLista) dao False neste dump. O
3634:     *     unico "ControlSource" que ele tem eh "SAIDA.ControlSource = [OPSENHA]"
3635:     *     num CommandGroup - vestigio da classe Grupo_Saida do Framework, nao
3636:     *     prova de grade.
3637:     *   - AjustarBotoesPorModo: nao ha modo CRUD. Zero "frmcadastro", zero
3638:     *     "Grupo_Op", zero "pcEscolha" no dump; o estado da tela eh a ETAPA do
3639:     *     protocolo, e quem o comanda eh HabilitarCampos + as transicoes
3640:     *     dentro dos lacos.
3641:     *
3642:     * Gerar os cinco como metodos vazios, ou com um aviso de placeholder no
3643:     * lugar do corpo, eh explicitamente proibido pela regra de completude, e
3644:     * exibi-los na tela violaria o PILAR 1. O gate trata exatamente isso pelo ramo
3645:     * PROTOCOLO (dialogo que conversa com dispositivo externo via DLL
3646:     * declarada no SCX), que dispensa CarregarLista e cobra, em vez disso, os
3647:     * hooks FormParaBO/BOParaForm e o handler do unico botao - os tres
3648:     * entregues acima.
3649:     *==========================================================================


### BO (C:\4c\projeto\app\classes\sigopdtfBO.prg):
*============================================================================
* sigopdtfBO.prg - Business Object para Transacao TEF (Terminal de Pagamento)
*
* Nao possui tabela principal propria - encapsula a interacao com a DLL
* CliSiTef32I.DLL (SiTef Interativo) e as consultas de apoio a
* SigCdEmp (empresa) e SigFiMpF (configuracao do caixa/terminal).
* O unico dado persistido pelo fluxo original e um cursor local
* temporario (crSiTef), usado como buffer de protocolo - nao uma
* tabela de negocio.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS sigopdtfBO AS BusinessBase

    *==========================================================================
    * Propriedades de entrada - recebidas do form/chamador (parametros da
    * transacao original: EndSiTef, ValPago, Cupom, Caixa, DebCred,
    * TipPagto, NumParcs, lcIdent, pcOpers)
    *==========================================================================
    this_cEndSiTef = ""    && Endereco do servidor SiTef
    this_nValPago  = 0     && Valor a ser pago na transacao
    this_cCupom    = ""    && Numero do cupom fiscal associado
    this_cCaixa    = ""    && Codigo do caixa (PDV) que originou a venda
    this_lDebCred  = .F.   && .T. = Debito / .F. = Credito
    this_cTipPagto = ""    && Tipo de pagamento informado pelo caixa
    this_nNumParcs = 0     && Numero de parcelas solicitado pelo caixa
    this_cIdent    = ""    && Identificador da transacao (lcIdent)
    this_cOpers    = ""    && Operador responsavel pelo caixa

    *==========================================================================
    * Propriedades de identificacao do terminal - lidas via SQL em
    * SigCdEmp.nEmps e SigFiMpF.Cncaixas (usadas para montar o
    * identificador do terminal exigido pela DLL do SiTef)
    *==========================================================================
    this_nEmpresa     = 0   && SigCdEmp.nEmps da empresa corrente
    this_cCaixaConfig = ""  && SigFiMpF.Cncaixas (numero do caixa configurado)
    this_cIdTerminal  = ""  && Identificador do terminal montado (empresa+caixa)

    *==========================================================================
    * Propriedades de estado/retorno da transacao TEF - preenchidas ao
    * longo do dialogo com a DLL e devolvidas ao chamador ao final
    *==========================================================================
    this_cTipTran        = ""   && Tipo da transacao retornado pelo SiTef
    this_cDataHora       = ""   && Data/hora da transacao retornada pelo SiTef
    this_cCupomRetorno    = ""   && Cupom confirmado pela transacao
    this_cCartao          = ""   && Numero do cartao (mascarado) utilizado
    this_cBandeira        = ""   && Bandeira do cartao identificada
    this_cNsu             = ""   && NSU (Numero Sequencial Unico) da transacao
    this_cAutoriza        = ""   && Codigo de autorizacao retornado
    this_cFinaliza        = ""   && Codigo de finalizacao da transacao
    this_cCodSeg          = ""   && Codigo de seguranca (CSEG) informado
    this_cDigitos         = ""   && Ultimos digitos do cartao informados
    this_cMensagemRetorno = ""   && Mensagem de retorno/erro da DLL SiTef

    *==========================================================================
    * Propriedades de parcelamento/data - espelham Optiongroup1/GetDatas
    * do formulario original (tipo de venda e 1a parcela/vencimento)
    *==========================================================================
    this_nTipoVenda   = 0    && 1 = A Vista / 2 = A Prazo (Optiongroup1.Value)
    this_dDataVencto  = {}   && Data da 1a parcela/vencimento
    this_lParcelado   = .F.  && .T. quando a venda foi parcelada
    this_nParcelas    = 0    && Numero de parcelas efetivamente confirmado

    *==========================================================================
    * Propriedade de controle de cancelamento (pcKeyEsc/Abandona do legado)
    *==========================================================================
    this_lCancelado = .F.   && .T. quando o usuario cancelou a operacao

    *==========================================================================
    * Configuracao da FORMA DE PAGAMENTO (FASE 8/8) - migrado do cursor global
    * crSigOpFp que o SIGOPDTF.Init popula com
    *     .poDatamgr.SqlExecute([Select * From SigOpFp Where FPags = ?lcOpers], 'crSigOpFp')
    * e que TODOS os lacos do protocolo consultam (GetDigitos.Valid/GotFocus,
    * GetDatas.Valid/GotFocus, GetCodSeg.LostFocus). Sem estes valores o
    * protocolo responde ao terminal com o ramo ERRADO em cada pergunta -
    * sem erro na tela, gravando transacao divergente.
    *
    * Tipos conferidos em docs/schema.sql (UTF-16, lido com Get-Content -Raw -
    * regra #14): lcartao/lsaque/tcdc/garantias sao char(1) ("S"/"N"),
    * dias eh numeric(3,0), mesfec eh numeric(1,0), chkbins eh numeric(1,0)
    * e codestabs eh char(8). chkbins eh NUMERIC (nao bit), por isso eh
    * comparado com 1 e nao com .T. (regra #13).
    *==========================================================================
    this_lOpFpCartao     = .F.     && SigOpFp.lcartao   = "S" - forma aceita cartao
    this_lOpFpSaque      = .F.     && SigOpFp.lsaque    = "S" - permite saque
    this_cOpFpTcdc       = "N"     && SigOpFp.tcdc      - indica consulta CDC
    this_lOpFpGarantias  = .F.     && SigOpFp.garantias = "S"
    this_nOpFpDias       = 0       && SigOpFp.dias
    this_nOpFpMesFec     = 0       && SigOpFp.mesfec
    this_nOpFpChkBins    = 0       && SigOpFp.chkbins   - 1 = validar BIN do cartao
    this_cOpFpCodEstabs  = ""      && SigOpFp.codestabs - "lsLoja" do ConfiguraIntSiTefInterativo

    *==========================================================================
    * Estado intermediario do protocolo que o legado guardava em variaveis
    * PUBLIC / properties soltas do Form (FASE 8/8)
    *==========================================================================
    this_lDataConfirmada = .F.      && DCD do legado - .T. apos o terminal confirmar a data
    this_cCartaoAux      = ""       && ThisForm.lsCartao - Left(Buffer, 5) em TipoCampo = 131
    this_cValorSaque     = "0,00"   && lcSaque - valor de saque (sub-dialogo SigCsTef nao portado)

    *==========================================================================
    * Estado do protocolo interativo (migrado das variaveis PUBLIC do legado:
    * ProximoComando, TipoCampo, TamanhoMinimo, TamanhoMaximo, Buffer,
    * lnContinua). Centralizado aqui porque ContinuarSiTef() precisa passar
    * os quatro primeiros POR REFERENCIA para a DLL, e VFP9 nao garante
    * passagem por referencia de property de objeto direto para DLL externa
    * (mesmo criterio de SigOpCtfBO.ContinuarSiTef/sigprdftBO.ContinuarSiTef).
    *==========================================================================
    this_nProximoComando = 0
    this_nTipoCampo      = 0
    this_nTamanhoMinimo  = 0
    this_nTamanhoMaximo  = 0
    this_cBuffer         = SPACE(2000)
    this_nContinua       = 0

    *==========================================================================
    * Init - Inicializa o Business Object
    * sigopdtf nao possui tabela de negocio propria (dialogo de integracao
    * com a DLL do SiTef) - this_cTabela/this_cCampoChave permanecem vazios
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            THIS.DeclararFuncoesSiTef()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * DeclararFuncoesSiTef - DECLARE-DLL das funcoes do protocolo interativo,
    * migrado de SIGOPDTF.Load.
    *
    * CORRIGIDO NA FASE 8/8: eram 3 declaracoes e sao QUATRO. O comentario
    * original afirmava que "este form, ao contrario de SIGPRDFT, NAO declara
    * FinalizaTransacaoSiTefInterativo" - e isso esta errado: a 4a linha do
    * SIGOPDTF.Load eh
    *     DECLARE integer FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL"
    *         Integer lnConfirma, String lsCupom, String lsData, String lsHorario
    * (com "integer" minusculo, o que provavelmente escondeu a linha de quem
    * conferiu). A funcao eh CHAMADA pelo GetDatas.Valid, no ramo em que a
    * senha do supervisor vem em branco - sem este DECLARE aquele caminho
    * estouraria em runtime com "FinalizaTransacaoSiTefInterativo is not
    * found", e o terminal ficaria com a transacao EM ABERTO em vez de
    * finalizada.
    * Redeclarar a mesma assinatura eh inofensivo em VFP9; a falha real (DLL
    * ausente) so aparece quando a funcao eh CHAMADA, nao na declaracao - por
    * isso o TRY aqui eh so para nao derrubar InicializarForm em maquina sem
    * o CliSiTef32I.DLL (mesmo criterio de SigOpCtfBO.DeclararFuncoesSiTef).
    *==========================================================================
    PROTECTED PROCEDURE DeclararFuncoesSiTef()
        LOCAL loc_oErro

        TRY
            DECLARE INTEGER ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
                STRING lsEndereco, STRING lsLoja, STRING lsTerminal, INTEGER lnReservado

            DECLARE INTEGER IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER lnModalidade, STRING lsValor, STRING lsCupom, STRING lsData, ;
                STRING lsHorario, STRING lsOperador, STRING lsRestricao

            DECLARE INTEGER ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER @lnComando, INTEGER @lnTipo, INTEGER @lnMinimo, INTEGER @lnMaximo, ;
                STRING @lsBuffer, INTEGER lnTamanho, INTEGER lnResultado

            DECLARE INTEGER FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER lnConfirma, STRING lsCupom, STRING lsData, STRING lsHorario
        CATCH TO loc_oErro
            *-- DLL nao presente nesta maquina (dev/pipeline sem PIN-pad
            *-- SiTef). CATCH sem MsgErro de proposito: o DECLARE falhando
            *-- aqui nao impede a tela de abrir, e em producao a DLL existe.
            *--
            *-- CORRIGIDO NA FASE 8/8 o que este comentario afirmava antes
            *-- ("a chamada real avisa o usuario via ConectarSiTef"): isso eh
            *-- FALSO e foi medido. Sem o DECLARE, o nome da funcao vira nome
            *-- de .prg para o VFP (regra #13) e a primeira chamada estoura
            *-- "File 'continuafuncaositefinterativo.prg' does not exist" -
            *-- mensagem que nao cita DLL nem SiTef e manda o diagnostico
            *-- para o lado errado. Nao foi acrescentada guarda nova aqui
            *-- porque o legado tambem nao tem (em producao a DLL sempre
            *-- existe) e inventa-la divergiria do PILAR 1; o que se conserta
            *-- eh a afirmacao errada, para o proximo leitor nao confiar nela.
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarIdentificacaoTerminal - Migrado do trecho de SIGOPDTF.GetDigitos.
    * GotFocus que monta o identificador de terminal antes de chamar
    * ConfiguraIntSiTefInterativo:
    *     lcIdTerminal = fConverteStr(CrSigCdEmp.nEmps) + ;
    *         TRANSFORM(VAL(crSigFiMpF.Cncaixas), "@L 999999")
    *
    * crSigCdEmp/crSigFiMpF sao cursores globais do Framework legado, nunca
    * populados em nenhum ponto do dump deste form (mesma categoria de
    * dependencia ausente tratada em SigOpCtfBO.CarregarCaixaSiTef). Em vez
    * de depender de cursor global nao documentado, consulta SigCdEmp/
    * SIGFIMPF diretamente pela empresa corrente (go_4c_Sistema.cCodEmpresa)
    * e, quando este_cCaixa (parametro "Caixa" recebido no Init) bate com
    * algum SIGFIMPF.cncaixas da empresa, usa esse registro; caso contrario,
    * cai no mesmo fallback "melhor esforco" do sibling (1o registro da
    * empresa, ou "000000" se nao achar nenhum).
    *==========================================================================
    FUNCTION CarregarIdentificacaoTerminal()
        LOCAL loc_oErro, loc_cSQLEmpresa, loc_cSQLCaixa

        THIS.this_nEmpresa     = 0
        THIS.this_cCaixaConfig = "000000"

        TRY
            IF USED("cursor_4c_SigCdEmpTef")
                USE IN cursor_4c_SigCdEmpTef
            ENDIF
            loc_cSQLEmpresa = "SELECT nemps FROM SigCdEmp WHERE cemps = " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa)
            SQLEXEC(gnConnHandle, loc_cSQLEmpresa, "cursor_4c_SigCdEmpTef")

            IF USED("cursor_4c_SigCdEmpTef") AND !EOF("cursor_4c_SigCdEmpTef")
                THIS.this_nEmpresa = TratarNulo(cursor_4c_SigCdEmpTef.nemps, 0)
            ENDIF
            IF USED("cursor_4c_SigCdEmpTef")
                USE IN cursor_4c_SigCdEmpTef
            ENDIF

            IF USED("cursor_4c_SigFiMpF")
                USE IN cursor_4c_SigFiMpF
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cCaixa))
                loc_cSQLCaixa = "SELECT cncaixas FROM SIGFIMPF WHERE emps = " + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa) + " AND cncaixas = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cCaixa))
            ELSE
                loc_cSQLCaixa = "SELECT cncaixas FROM SIGFIMPF WHERE emps = " + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa)
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQLCaixa, "cursor_4c_SigFiMpF")

            IF USED("cursor_4c_SigFiMpF") AND !EOF("cursor_4c_SigFiMpF")
                THIS.this_cCaixaConfig = TRANSFORM(VAL(TratarNulo(cursor_4c_SigFiMpF.cncaixas, "0")), "@L 999999")
            ENDIF
            IF USED("cursor_4c_SigFiMpF")
                USE IN cursor_4c_SigFiMpF
            ENDIF
        CATCH TO loc_oErro
            *-- Sem a tabela/registro, segue com os fallbacks acima - mesmo
            *-- desfecho pratico do legado quando os cursores globais estao vazios.
        ENDTRY

        THIS.this_cIdTerminal = fConvertestr(THIS.this_nEmpresa) + THIS.this_cCaixaConfig

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * CarregarConfiguracaoPagamento - FASE 8/8. Migrado de SIGOPDTF.Init:
    *     .poDatamgr.SqlExecute([Select * From SigOpFp Where FPags = ?lcOpers], 'crSigOpFp')
    *     If Empty(crSigOpFp.CodEstabs)
    *         lsIdTerminal = "00000" + _Empr
    *     Else
    *         lsIdTerminal = crSigOpFp.CodEstabs
    *     Endif
    *
    * lcOpers eh o parametro "pcOpers" recebido no Init (this_cOpers) - o
    * codigo da FORMA DE PAGAMENTO escolhida no caixa, nao um operador de
    * usuario, apesar do nome. Seis das colunas lidas aqui decidem o ramo que
    * o protocolo toma em cada pergunta do terminal; a setima (codestabs) eh
    * o argumento "lsLoja" do ConfiguraIntSiTefInterativo.
    *
    * SELECT com a lista EXPLICITA de colunas em vez do "Select *" do legado:
    * sao as unicas 7 que o dump consulta, de uma tabela com 121 colunas.
    *
    * NAO derruba o form quando a consulta falha: os defaults declarados na
    * classe ("N"/0/.F.) sao o mesmo desfecho pratico que o legado tem quando
    * o cursor global vem vazio - mesmo criterio de
    * CarregarIdentificacaoTerminal.
    *==========================================================================
    FUNCTION CarregarConfiguracaoPagamento()
        LOCAL loc_oErro, loc_cSQL, loc_lAchou

        loc_lAchou = .F.

        TRY
            IF USED("cursor_4c_SigOpFp")
                IF CURSORGETPROP("Buffering", "cursor_4c_SigOpFp") > 1
                    TABLEREVERT(.T., "cursor_4c_SigOpFp")
                ENDIF
                USE IN cursor_4c_SigOpFp
            ENDIF

            loc_cSQL = "SELECT lcartao, lsaque, tcdc, garantias, dias, mesfec, " + ;
                       "chkbins, codestabs FROM SigOpFp WHERE fpags = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cOpers))

            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpFp")

            IF USED("cursor_4c_SigOpFp") AND !EOF("cursor_4c_SigOpFp")
                THIS.this_lOpFpCartao    = (UPPER(TratarNulo(cursor_4c_SigOpFp.lcartao, "N")) = "S")
                THIS.this_lOpFpSaque     = (UPPER(TratarNulo(cursor_4c_SigOpFp.lsaque, "N")) = "S")
                THIS.this_cOpFpTcdc      = UPPER(TratarNulo(cursor_4c_SigOpFp.tcdc, "N"))
                THIS.this_lOpFpGarantias = (UPPER(TratarNulo(cursor_4c_SigOpFp.garantias, "N")) = "S")
                THIS.this_nOpFpDias      = TratarNulo(cursor_4c_SigOpFp.dias, 0)
                THIS.this_nOpFpMesFec    = TratarNulo(cursor_4c_SigOpFp.mesfec, 0)
                THIS.this_nOpFpChkBins   = TratarNulo(cursor_4c_SigOpFp.chkbins, 0)
                THIS.this_cOpFpCodEstabs = ALLTRIM(TratarNulo(cursor_4c_SigOpFp.codestabs, ""))
                loc_lAchou = .T.
            ENDIF

            IF USED("cursor_4c_SigOpFp")
                USE IN cursor_4c_SigOpFp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao ler a forma de pagamento")
        ENDTRY

        RETURN loc_lAchou
    ENDFUNC

    *==========================================================================
    * ValidarBinCartao - FASE 8/8. Migrado do bloco "IF TipoCampo = 136" que o
    * legado REPETE LITERALMENTE em quatro lacos (GetDigitos.Valid,
    * GetDigitos.GotFocus, GetDatas.Valid, GetDatas.GotFocus):
    *     lcQuery = [Select ChkBins From SigOpFp Where FPags = '] + ThisForm.pcOpers + [']
    *     If csTmpFPag.ChkBins = 1
    *         lcQuery = [Select CodBins, DataIs, DataFs From SigOpFpb Where FPags = '...'
    *                    And CodBins = '] + Alltrim(Strtran(Buffer, Chr(0), '')) + [']
    *         If Eof() Or Not Between(Dtos(Date()), Dtos(Nvl(csTmpFPagb.Datais, Ctod('01/01/1900'))),
    *                                               Dtos(Nvl(csTmpFPagb.DataFs, Ctod('31/12/9999'))))
    *             -> aborta a transacao ("Cartao Invalido para esta Condicao de Pagamento")
    *         EndIf
    *     Endif
    *
    * Devolve .T. quando o BIN eh ACEITO (inclusive quando a checagem esta
    * desligada, que eh o caminho em que o legado nao faz nada) e .F. quando o
    * cartao nao vale para esta condicao de pagamento. Os quatro call sites
    * consomem a MESMA funcao de proposito: quatro copias divergiriam em
    * silencio na primeira mudanca de regra (CLAUDE.md #44, item 6).
    *
    * O ChkBins NAO eh reconsultado aqui: a coluna ja vem de
    * CarregarConfiguracaoPagamento (mesma tabela, mesma chave fpags) - o
    * legado refazia o SELECT a cada passagem do laco porque nao guardava o
    * valor em lugar nenhum.
    *
    * Janela de validade: datais/datafs sao datetime (schema.sql). Nulo cai nos
    * mesmos sentinelas do legado (01/01/1900 e 31/12/9999), e a comparacao eh
    * por DTOS, como no original - comparar DATE com DATETIME daria erro 11
    * (regra #16), por isso ConverterParaData normaliza os dois lados.
    *==========================================================================
    FUNCTION ValidarBinCartao(par_cBin)
        LOCAL loc_oErro, loc_cSQL, loc_cBin, loc_lValido, loc_dIni, loc_dFim, loc_cHoje

        *-- Checagem desligada na forma de pagamento: o legado nao consulta
        *-- nada e segue a transacao.
        IF THIS.this_nOpFpChkBins != 1
            RETURN .T.
        ENDIF

        loc_cBin    = ALLTRIM(STRTRAN(IIF(VARTYPE(par_cBin) = "C", par_cBin, ""), CHR(0), ""))
        loc_lValido = .F.

        TRY
            IF USED("cursor_4c_SigOpFpb")
                IF CURSORGETPROP("Buffering", "cursor_4c_SigOpFpb") > 1
                    TABLEREVERT(.T., "cursor_4c_SigOpFpb")
                ENDIF
                USE IN cursor_4c_SigOpFpb
            ENDIF

            loc_cSQL = "SELECT codbins, datais, datafs FROM SigOpFpb WHERE fpags = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cOpers)) + " AND codbins = " + ;
                       EscaparSQL(loc_cBin)

            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpFpb")

            IF USED("cursor_4c_SigOpFpb") AND !EOF("cursor_4c_SigOpFpb")
                loc_dIni  = ConverterParaData(TratarNulo(cursor_4c_SigOpFpb.datais, CTOD("01/01/1900")))
                loc_dFim  = ConverterParaData(TratarNulo(cursor_4c_SigOpFpb.datafs, CTOD("31/12/9999")))
                IF EMPTY(loc_dIni)
                    loc_dIni = CTOD("01/01/1900")
                ENDIF
                IF EMPTY(loc_dFim)
                    loc_dFim = CTOD("31/12/9999")
                ENDIF
                loc_cHoje   = DTOS(DATE())
                loc_lValido = BETWEEN(loc_cHoje, DTOS(loc_dIni), DTOS(loc_dFim))
            ENDIF

            IF USED("cursor_4c_SigOpFpb")
                USE IN cursor_4c_SigOpFpb
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao validar o BIN do cart" + CHR(227) + "o")
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * ConectarSiTef - Migrado de SIGOPDTF.GetDigitos.GotFocus:
    *     IF ConfiguraIntSiTefInterativo(lsEndSitef, lsIdTerminal, lcIdTerminal, 0) <> 0
    *
    * CORRIGIDO NA FASE 8/8. A Fase 1 escreveu, com razao para o que tinha em
    * maos, que "lsIdTerminal (2o argumento, lsLoja) nao tem fonte explicita
    * visivel no dump disponivel para esta fase" e usou o parametro "Caixa"
    * como fallback. O dump COMPLETO, lido nesta fase, tem a fonte - esta no
    * SIGOPDTF.Init, longe do GotFocus que faz a chamada:
    *     If Empty(crSigOpFp.CodEstabs)
    *         lsIdTerminal = "00000" + _Empr
    *     Else
    *         lsIdTerminal = crSigOpFp.CodEstabs
    *     Endif
    * Ou seja "lsLoja" eh o CODIGO DE ESTABELECIMENTO da forma de pagamento
    * (SigOpFp.codestabs, char(8)), nao o numero do caixa. Mantido o fallback
    * "00000" + empresa, que eh o do proprio legado.
    *
    * Nao eh detalhe cosmetico: este argumento identifica a LOJA no servidor
    * SiTef. Enviar o numero do caixa no lugar do estabelecimento faz o
    * servidor recusar a conexao (ou credenciar a transacao na loja errada),
    * e o usuario veria so "Sem comunicacao com SiTef".
    *
    * lcIdTerminal (3o argumento, "lsTerminal") eh THIS.this_cIdTerminal,
    * calculado em CarregarIdentificacaoTerminal.
    *==========================================================================
    FUNCTION ConectarSiTef()
        LOCAL loc_cLoja, loc_nRetorno

        IF !EMPTY(ALLTRIM(THIS.this_cOpFpCodEstabs))
            loc_cLoja = ALLTRIM(THIS.this_cOpFpCodEstabs)
        ELSE
            loc_cLoja = "00000" + ALLTRIM(go_4c_Sistema.cCodEmpresa)
        ENDIF

        loc_nRetorno = ConfiguraIntSiTefInterativo(ALLTRIM(THIS.this_cEndSiTef), ;
            loc_cLoja, THIS.this_cIdTerminal, 0)

        RETURN (loc_nRetorno = 0)
    ENDFUNC

    *==========================================================================
    * IniciarSiTef - Migrado de SIGOPDTF.GetDigitos.GotFocus:
    *     lcValpago = Alltrim(Transform(lnValPago,"99999999.99"))
    *     lcValPago = Strtran(lcValPago,".",",")
    *     lcData    = Str(Year(Date()),4) + Substr(Dtoc(Date()),4,2) + Substr(Dtoc(Date()),1,2)
    *     lchora    = Strtran(Time(),":","")
    *     IF IniciaFuncaoSiTefInterativo(0, lcValPago, lsCupom, lcData, lchora, ...) <> 10000
    *
    * Modalidade (0) eh LITERAL no legado. par_cData/par_cHora chegam ja
    * formatados pelo Form (mesmo calculo acima, repetido em todo ponto do
    * dump que inicia a transacao). 6o argumento (lsOperador) segue o mesmo
    * criterio de sigprdftBO.IniciarSiTef - usa THIS.this_cCaixa, unico dado
    * de identificacao do caixa recebido no Init.
    *==========================================================================
    FUNCTION IniciarSiTef(par_cData, par_cHora)
        LOCAL loc_cValPago, loc_nRetorno

        loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(THIS.this_nValPago, "99999999.99")), ".", ",")

        loc_nRetorno = IniciaFuncaoSiTefInterativo(0, loc_cValPago, THIS.this_cCupom, ;
            par_cData, par_cHora, ALLTRIM(THIS.this_cCaixa), "")

        RETURN (loc_nRetorno = 10000)
    ENDFUNC

    *==========================================================================
    * ContinuarSiTef - Migrado das chamadas ContinuaFuncaoSiTefInterativo
    * espalhadas pelo legado (GetDigitos.Valid, GetCodSeg.LostFocus,
    * GetDatas.Valid/GotFocus, Text1.Valid, SAIDA.Click). Centraliza a
    * chamada por referencia (LOCAL -> DLL -> THIS.this_n*/this_cBuffer) -
    * mesmo criterio de SigOpCtfBO.ContinuarSiTef/sigprdftBO.ContinuarSiTef.
    *==========================================================================
    FUNCTION ContinuarSiTef(par_nContinua)
        LOCAL loc_nProximoComando, loc_nTipoCampo, loc_nTamanhoMinimo, ;
              loc_nTamanhoMaximo, loc_cBuffer, loc_nRetorno

        loc_nProximoComando = THIS.this_nProximoComando
        loc_nTipoCampo      = THIS.this_nTipoCampo
        loc_nTamanhoMinimo  = THIS.this_nTamanhoMinimo
        loc_nTamanhoMaximo  = THIS.this_nTamanhoMaximo
        loc_cBuffer         = IIF(EMPTY(THIS.this_cBuffer), SPACE(2000), THIS.this_cBuffer)

        loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nProximoComando, @loc_nTipoCampo, ;
            @loc_nTamanhoMinimo, @loc_nTamanhoMaximo, @loc_cBuffer, LEN(loc_cBuffer), par_nContinua)

        THIS.this_nProximoComando = loc_nProximoComando
        THIS.this_nTipoCampo      = loc_nTipoCampo
        THIS.this_nTamanhoMinimo  = loc_nTamanhoMinimo
        THIS.this_nTamanhoMaximo  = loc_nTamanhoMaximo
        THIS.this_cBuffer         = loc_cBuffer

        RETURN loc_nRetorno
    ENDFUNC

    *==========================================================================
    * FinalizarTransacaoSiTef - FASE 8/8. Encapsula a 4a funcao da DLL,
    * chamada pelo SIGOPDTF.GetDatas.Valid quando a senha do supervisor vem em
    * branco (o operador desistiu):
    *     FinalizaTransacaoSiTefInterativo(0, IIF(EMPTY(SigTef.nCupom),"1",SigTef.nCupom),
    *                                      lcData, lcHora)
    * O 1o argumento (lnConfirma) eh 0 = NAO confirmar, isto eh desfazer a
    * transacao em aberto no terminal. Literal no legado, e o unico call site.
    *
    * par_cCupom chega do Form: o legado o le do DBF SigTef
    * (goSistema.DirTefEcfs + "\SigTef"), arquivo do modulo fiscal que nao faz
    * parte do acervo migrado, caindo em "1" quando vazio - que eh o valor que
    * o Form passa.
    *==========================================================================
    FUNCTION FinalizarTransacaoSiTef(par_nConfirma, par_cCupom, par_cData, par_cHora)
        LOCAL loc_nRetorno

        loc_nRetorno = FinalizaTransacaoSiTefInterativo( ;
            IIF(VARTYPE(par_nConfirma) = "N", par_nConfirma, 0), ;
            IIF(VARTYPE(par_cCupom) = "C" AND !EMPTY(par_cCupom), par_cCupom, "1"), ;
            IIF(VARTYPE(par_cData) = "C", par_cData, ""), ;
            IIF(VARTYPE(par_cHora) = "C", par_cHora, ""))

        RETURN loc_nRetorno
    ENDFUNC

    *==========================================================================
    * MontarBufferSiTef - carrega this_cBuffer com o valor digitado pelo
    * usuario, completado com CHR(0) ate o tamanho que
    * ContinuaFuncaoSiTefInterativo espera. Migrado do padrao repetido em
    * cada LostFocus/Valid do legado (SENHA/GetDigitos/GetCartao/GetCodSeg):
    *     Buffer = Alltrim(This.Value) + Replicate(Chr(0), 2000 - Len(Alltrim(This.Value)))
    *==========================================================================
    FUNCTION MontarBufferSiTef(par_cValor, par_nComplemento)
        LOCAL loc_cValor, loc_nComplemento

        loc_cValor = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), ;
            ALLTRIM(TRANSFORM(par_cValor)))

        IF VARTYPE(par_nComplemento) = "N" AND par_nComplemento > 0
            loc_nComplemento = par_nComplemento
        ELSE
            loc_nComplemento = 2000 - LEN(loc_cValor)
        ENDIF

        IF loc_nComplemento < 0
            loc_nComplemento = 0
        ENDIF

        THIS.this_cBuffer = loc_cValor + REPLICATE(CHR(0), loc_nComplemento)

        RETURN THIS.this_cBuffer
    ENDFUNC

    *==========================================================================
    * NOTA DE ARQUITETURA - SOMENTE INTEGRACAO COM DLL (sem tabela propria)
    *
    * O dump disponivel para esta fase (comportamento.json) nao mostra
    * nenhum INSERT/UPDATE/DELETE/TABLEUPDATE contra o SQL Server em metodo
    * algum de SIGOPDTF - as 5 queries capturadas sao todas
    * "INSERT INTO crSiTef (...)", um CURSOR LOCAL de memoria (CREATE CURSOR
    * crSiTef) usado so como buffer de protocolo para montar a mensagem de
    * falha exibida ao usuario (RetornoFalha), nunca persistido no banco.
    * A tela processa um pagamento em cartao via DLL (CliSiTef32I.DLL) -
    * mesma natureza de SigOpCtfBO (cancelamento) e sigprdftBO (pagamento a
    * debito), ambos ja migrados com este mesmo criterio.
    *
    * Por isso:
    *   - Inserir(), Atualizar() e ExecutarExclusao() NAO sao sobrescritos
    *     aqui - o comportamento herdado de BusinessBase (recusar a operacao
    *     e deixar o motivo em this_cMensagemErro, reportado pelo
    *     ExibirFalha de Salvar()/Excluir()) ja eh o correto. Sobrescrever
    *     exigiria inventar uma tabela/lista de colunas que o legado nunca
    *     grava, o que a regra #22 do CLAUDE.md proibe;
    *   - RegistrarAuditoria() tambem fica herdado e nunca eh chamado por
    *     este BO: sem Inserir()/Atualizar() proprios nao ha operacao de
    *     escrita para auditar;
    *   - CarregarDoCursor() nao se aplica: os dados digitados na tela
    *     (Valor, Digitos, Cartao, TipoVenda, Parcelas, Data) sao atribuidos
    *     diretamente as properties this_n*/this_c*/this_d* pelo proprio Form
    *     (FormParaBO/BOParaForm), e o retorno da transacao TEF vem do
    *     protocolo ContinuaFuncaoSiTefInterativo via DLL, nao de um SELECT -
    *     nao ha cursor de banco a percorrer aqui.
    *==========================================================================

    *==========================================================================
    * ObterChavePrimaria - SIGOPDTF nao grava registro nenhum (integracao com
    * o terminal SiTef via CliSiTef32I.DLL). Nao existe chave primaria porque
    * nao existe tabela; retornar vazio mantem RegistrarAuditoria() inofensivo
    * (ela ja aborta quando a chave vem vazia - ver BusinessBase.RegistrarAuditoria).
    * PROTECTED: nunca chamado de fora (regra #51 do CLAUDE.md).
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

ENDDEFINE

