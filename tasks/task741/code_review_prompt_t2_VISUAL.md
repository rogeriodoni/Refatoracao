# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopfin.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3702 linhas total):

*-- Linhas 21 a 41:
21: * o legado tambem declara DataSession=1, nao 2, entao nao ha necessidade do
22: * fix SET DATE/CENTURY da regra CLAUDE.md #9.4).
23: *
24: * Montagem (migracao multi-fase):
25: *   Fase 3          - DEFINE CLASS, Init/Destroy/InicializarForm, cabecalho
26: *                     cnt_4c_Sombra, TornarControlesVisiveis.
27: *   Fase 4          - cursor_4c_GrdValores (equivalente a crGrdValores do
28: *                     Load legado), grd_4c_Dados (grid de 1 coluna ligado
29: *                     a ele), cmd_4c_BtnSetaUp/cmd_4c_BtnSetaDn/
30: *                     cmd_4c_BtnExcluiGrd e a carga da grade:
31: *                     CarregarDados() (trecho do Init legado) +
32: *                     MontaGrade() (montagrades legado) +
33: *                     AjustarBotoesGrade().
34: *   Fase 5 parte 1  - campos de Grupo/Conta Debito/Credito das linhas
35: *                     Emissor e Portador (8 TextBox) + cabecalhos de
36: *                     coluna Debito/Credito/Grupo/Conta (uma unica vez,
37: *                     acima das 4 linhas).
38: *   Fase 6 (esta)   - parte 2 dos campos de detalhe, complementar a Fase 5
39: *                     (linhas Centro de Custo/Agente Cobrador - 8 TextBox -
40: *                     e txt_4c_CMoes/TitBans/Tipos/MovTits), mais
41: *                     obj_4c_GetNotas/obj_4c_GetComandos (EditBox memo) e

*-- Linhas 62 a 70:
62: *                     This.Value, ConfigurarEventosDirtyTracking()) que o
63: *                     legado usa para marcar plAlterou (aqui
64: *                     this_lAlterou), consumido no Click de Sair da Fase 8.
65: *   Fase 8 (esta)   - cmd_4c_Sair (equivalente ao botao Sair/OK do legado,
66: *                     dump linhas 465-475: Picture=cadastro_salvar_60.jpg,
67: *                     Cancel=.T., Caption="\<OK" - fecha-o grava, por isso o
68: *                     icone eh de salvar e nao de saida) e o Click dele
69: *                     (BtnSairClick), que reproduz literalmente o
70: *                     SIGOPFIN.Sair.Click do legado (dump linhas 1606-1732):

*-- Linhas 78 a 86:
78: *                     linha, renumerando Ordem) e
79: *                     AtualizarConfigFinanceiraOperacao() (equivalente ao
80: *                     "Replace CfgFinancs ... In crSigCdOpe" do fim do
81: *                     gravardados legado - grava os 2 CheckBox nos 2
82: *                     primeiros caracteres da coluna SigCdOpe.cfgfinancs
83: *                     char(20), preservando os 18 restantes). Consolidacao
84: *                     final do form.
85: *
86: * Nomes de objeto conforme tasks/task741/mapeamento.json.

*-- Linhas 130 a 138:
130:     *--------------------------------------------------------------------------
131:     * Sinaliza se o usuario alterou a grade de configuracoes - equivalente a
132:     * ThisForm.plAlterou do legado. Consultado no Fase 8 (Click de
133:     * cmd_4c_Sair) para decidir se valida a grade antes de encerrar.
134:     *--------------------------------------------------------------------------
135:     this_lAlterou = .F.
136: 
137:     *--------------------------------------------------------------------------
138:     * Guarda de reentrancia dos lookups. Os pickers sao MODAIS: abrir um a

*-- Linhas 181 a 189:
181:                     THIS.this_cModoAtual = par_oFormPai.this_cModoAtual
182:                 ENDIF
183: 
184:                 THIS.Caption = ALLTRIM(THIS.Caption) + " - " + ALLTRIM(par_cDopes)
185: 
186:                 THIS.this_oBusinessObject = CREATEOBJECT("sigopfinBO")
187: 
188:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
189:                     loc_lSucesso = DODEFAULT()

*-- Linhas 226 a 234:
226:     *--------------------------------------------------------------------------
227:     * InicializarForm - monta a tela via ConfigurarPageFrame(): fundo,
228:     * cabecalho e grade+botoes de reordenacao nesta fase; campos/memos/
229:     * checkboxes nas fases seguintes.
230:     *--------------------------------------------------------------------------
231:     PROTECTED PROCEDURE InicializarForm()
232:         LOCAL loc_lSucesso, loc_oErro, loc_cPicture
233:         loc_lSucesso = .F.
234: 

*-- Linhas 268 a 333:
268:     *--------------------------------------------------------------------------
269:     * ConfigurarPageFrame - Orquestrador de montagem visual. SIGOPFIN nao
270:     * tem PageFrame no legado (layout flat: cntSombra + grid + campos +
271:     * memos + checkboxes + botoes direto no form) - o nome do metodo e
272:     * mantido apenas como ponto de entrada arquitetural padrao (mesmo papel
273:     * em FormSigPrIbb/FormSigPrGst/FormSigPrGmi).
274:     *
275:     * Fase 3          - ConfigurarCabecalho() (cnt_4c_Sombra).
276:     * Fase 4          - ConfigurarGrid() (grd_4c_Dados + cmd_4c_BtnSetaUp/
277:     *                   BtnSetaDn/BtnExcluiGrd).
278:     * Fase 5 parte 1  - ConfigurarCamposGrupoContaEmissorPortador() (linhas
279:     *                   Emissor/Portador).
280:     * Fase 6 (esta)   - ConfigurarCamposCentroCustoAgenteCobrador() (parte 2
281:     *                   complementar a Fase 5: linhas Centro de Custo/Agente
282:     *                   Cobrador) + ConfigurarCamposComplementares()
283:     *                   (txt_4c_CMoes/TitBans/Tipos/MovTits) +
284:     *                   ConfigurarMemosEcheckboxes() (obj_4c_GetNotas/
285:     *                   obj_4c_GetComandos e os 2 CheckBox) +
286:     *                   ConfigurarEventosLookup() (BINDEVENT dos 19 campos
287:     *                   com lookup). A celula de lookup da grade e instalada
288:     *                   por InstalarCelulaOrigem(), chamado de
289:     *                   ConfigurarGrid() e de MontaGrade().
290:     * Fase 7          - eventos dos botoes de manutencao da grade,
291:     *                   AfterRowColChange e dirty-tracking (plAlterou).
292:     * Fase 8 (esta)   - ConfigurarSaida() (cmd_4c_Sair); o BINDEVENT do Click
293:     *                   dele entra em ConfigurarEventosBotoesGrade(), junto
294:     *                   com os outros 3 botoes de botao-unico do form.
295:     *--------------------------------------------------------------------------
296:     PROTECTED PROCEDURE ConfigurarPageFrame()
297:         THIS.ConfigurarCabecalho()
298:         THIS.ConfigurarGrid()
299:         THIS.ConfigurarCamposGrupoContaEmissorPortador()
300:         THIS.ConfigurarCamposCentroCustoAgenteCobrador()
301:         THIS.ConfigurarCamposComplementares()
302:         THIS.ConfigurarMemosEcheckboxes()
303:         THIS.ConfigurarSaida()
304:         THIS.ConfigurarEventosLookup()
305:         THIS.ConfigurarEventosBotoesGrade()
306:         THIS.ConfigurarEventosDirtyTracking()
307:     ENDPROC
308: 
309:     *--------------------------------------------------------------------------
310:     * ConfigurarSaida - cmd_4c_Sair, equivalente ao SIGOPFIN.Sair do legado
311:     * (dump linhas 465-475). O icone eh o de SALVAR (cadastro_salvar_60.jpg),
312:     * nao o de sair - fiel ao legado: o Click deste botao grava a grade antes
313:     * de fechar o dialogo (regra CLAUDE.md #25 - FormBAL "Fecha" usa o mesmo
314:     * icone de salvar pelo mesmo motivo). Width/Height=75 (canonico do
315:     * projeto para CommandButton com Picture) nao constam do dump; Left=925
316:     * do dump + Width=75 fecha exatamente nos 1000px do form.
317:     *--------------------------------------------------------------------------
318:     PROTECTED PROCEDURE ConfigurarSaida()
319:         LOCAL loc_oErro
320: 
321:         TRY
322:             THIS.AddObject("cmd_4c_Sair", "CommandButton")
323:             WITH THIS.cmd_4c_Sair
324:                 .Top             = 3
325:                 .Left            = 925
326:                 .Width           = 75
327:                 .Height          = 75
328:                 .Caption         = "\<OK"
329:                 .Cancel          = .T.
330:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
331:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
332:                 .Themes          = .T.
333:                 .SpecialEffect   = 0

*-- Linhas 359 a 411:
359:     *--------------------------------------------------------------------------
360:     PROTECTED PROCEDURE ConfigurarCabecalho()
361:         LOCAL loc_oCnt, loc_oErro
362: 
363:         TRY
364:             THIS.AddObject("cnt_4c_Sombra", "Container")
365:             loc_oCnt = THIS.cnt_4c_Sombra
366:             WITH loc_oCnt
367:                 .Top         = 0
368:                 .Left        = 0
369:                 .Width       = THIS.Width
370:                 .Height      = 80
371:                 .BorderWidth = 0
372:                 .BackColor   = RGB(100, 100, 100)
373:                 .Visible     = .T.
374:             ENDWITH
375: 
376:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
377:             WITH loc_oCnt.lbl_4c_LblSombra
378:                 .FontBold  = .T.
379:                 .FontName  = "Tahoma"
380:                 .FontSize  = 18
381:                 .WordWrap  = .T.
382:                 .Alignment = 0
383:                 .BackStyle = 0
384:                 .AutoSize  = .F.
385:                 .Caption   = THIS.Caption
386:                 .Height    = 40
387:                 .Left      = 10
388:                 .Top       = 18
389:                 .Width     = 769
390:                 .ForeColor = RGB(0, 0, 0)
391:                 .Visible   = .T.
392:             ENDWITH
393: 
394:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
395:             WITH loc_oCnt.lbl_4c_LblTitulo
396:                 .FontBold  = .T.
397:                 .FontName  = "Tahoma"
398:                 .FontSize  = 18
399:                 .WordWrap  = .T.
400:                 .Alignment = 0
401:                 .BackStyle = 0
402:                 .AutoSize  = .F.
403:                 .Caption   = THIS.Caption
404:                 .Height    = 46
405:                 .Left      = 10
406:                 .Top       = 17
407:                 .Width     = 769
408:                 .ForeColor = RGB(255, 255, 255)
409:                 .Visible   = .T.
410:             ENDWITH
411:         CATCH TO loc_oErro

*-- Linhas 444 a 452:
444: 
445:     *--------------------------------------------------------------------------
446:     * ConfigurarGrid - grd_4c_Dados (equivalente a grdValores, dump linhas
447:     * 999-1023: ColumnCount=1, Column1.Width=700, Header1.Caption = titulo da
448:     * grade) + os 3 botoes de navegacao/exclusao de linha (btnSetaUp/
449:     * btnSetaDn/btnExcluiGrd, dump linhas 1277-1309 - mesmo Left=739, Top
450:     * escalonado de 40 em 40). O Click dos botoes fica para a
451:     * Fase 7; aqui a montagem visual, o grid ja ligado ao
452:     * cursor_4c_GrdValores criado em CriarCursorGrdValores(), e a celula de

*-- Linhas 460 a 469:
460:             loc_oGrd = THIS.grd_4c_Dados
461: 
462:             WITH loc_oGrd
463:                 .Top               = 90
464:                 .Left              = 12
465:                 .Width             = 721
466:                 .Height            = 198
467:                 .FontName          = "Tahoma"
468:                 .FontSize          = 8
469:                 .AllowHeaderSizing = .F.

*-- Linhas 482 a 490:
482:                 .Column1.Width             = 700
483:                 .Column1.FontName          = "Tahoma"
484:                 .Column1.FontSize          = 8
485:                 .Column1.Header1.Caption   = "Origem dos Valores a Serem Lan" + ;
486:                     CHR(231) + "ados na Movimenta" + CHR(231) + CHR(227) + "o Financeira"
487:                 .Column1.Header1.Alignment = 2
488:                 .Column1.Header1.FontBold  = .F.
489: 
490:                 .Visible = .T.

*-- Linhas 496 a 542:
496:             *-- controle instalado aqui.
497:             THIS.InstalarCelulaOrigem()
498: 
499:             THIS.AddObject("cmd_4c_BtnSetaUp", "CommandButton")
500:             WITH THIS.cmd_4c_BtnSetaUp
501:                 .Caption         = ""
502:                 .Top             = 90
503:                 .Left            = 739
504:                 .Width           = 40
505:                 .Height          = 40
506:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_seta_cima_20.jpg"
507:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_seta_cima_20.jpg"
508:                 .Themes          = .T.
509:                 .SpecialEffect   = 0
510:                 .MousePointer    = 15
511:                 .TabIndex        = 2
512:                 .ToolTipText     = "Mover Linha da Grade Uma Posi" + CHR(231) + CHR(227) + "o Para Cima"
513:                 .Visible         = .T.
514:             ENDWITH
515: 
516:             THIS.AddObject("cmd_4c_BtnSetaDn", "CommandButton")
517:             WITH THIS.cmd_4c_BtnSetaDn
518:                 .Caption         = ""
519:                 .Top             = 130
520:                 .Left            = 739
521:                 .Width           = 40
522:                 .Height          = 40
523:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_seta_baixo_20.jpg"
524:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_seta_baixo_20.jpg"
525:                 .Themes          = .T.
526:                 .SpecialEffect   = 0
527:                 .MousePointer    = 15
528:                 .TabIndex        = 3
529:                 .ToolTipText     = "Mover Linha da Grade Uma Posi" + CHR(231) + CHR(227) + "o Para Baixo"
530:                 .Visible         = .T.
531:             ENDWITH
532: 
533:             THIS.AddObject("cmd_4c_BtnExcluiGrd", "CommandButton")
534:             WITH THIS.cmd_4c_BtnExcluiGrd
535:                 .Caption         = ""
536:                 .Top             = 170
537:                 .Left            = 739
538:                 .Width           = 40
539:                 .Height          = 40
540:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
541:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
542:                 .Themes          = .T.

*-- Linhas 556 a 583:
556:     *--------------------------------------------------------------------------
557:     * ConfigurarEventosBotoesGrade - BINDEVENT dos 3 botoes de manutencao da
558:     * grade (Click), do AfterRowColChange do proprio grid (Fase 7) e do
559:     * cmd_4c_Sair (Fase 8 - equivalente ao SIGOPFIN.Sair.Click do legado).
560:     *--------------------------------------------------------------------------
561:     PROTECTED PROCEDURE ConfigurarEventosBotoesGrade()
562:         LOCAL loc_oErro
563: 
564:         TRY
565:             IF PEMSTATUS(THIS, "cmd_4c_BtnSetaUp", 5)
566:                 BINDEVENT(THIS.cmd_4c_BtnSetaUp, "Click", THIS, "BtnSetaUpClick")
567:             ENDIF
568:             IF PEMSTATUS(THIS, "cmd_4c_BtnSetaDn", 5)
569:                 BINDEVENT(THIS.cmd_4c_BtnSetaDn, "Click", THIS, "BtnSetaDnClick")
570:             ENDIF
571:             IF PEMSTATUS(THIS, "cmd_4c_BtnExcluiGrd", 5)
572:                 BINDEVENT(THIS.cmd_4c_BtnExcluiGrd, "Click", THIS, "BtnExcluiGrdClick")
573:             ENDIF
574:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
575:                 BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "AfterRowColChange")
576:             ENDIF
577:             IF PEMSTATUS(THIS, "cmd_4c_Sair", 5)
578:                 BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
579:             ENDIF
580:         CATCH TO loc_oErro
581:             MsgErro(loc_oErro.Message + CHR(13) + ;
582:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
583:                 "Procedure: " + loc_oErro.Procedure, ;

*-- Linhas 919 a 1109:
919: 
920:         TRY
921:             *-- Cabecalhos de coluna - uma unica vez, acima das 4 linhas.
922:             THIS.AddObject("lbl_4c_Label14", "Label")
923:             WITH THIS.lbl_4c_Label14
924:                 .FontName  = "Tahoma"
925:                 .FontSize  = 8
926:                 .FontBold  = .T.
927:                 .BackStyle = 0
928:                 .Alignment = 0
929:                 .AutoSize  = .F.
930:                 .Top       = 454
931:                 .Left      = 184
932:                 .Width     = 60
933:                 .Height    = 17
934:                 .ForeColor = RGB(90, 90, 90)
935:                 .Caption   = "D" + CHR(233) + "bito [D]"
936:                 .Visible   = .T.
937:             ENDWITH
938: 
939:             THIS.AddObject("lbl_4c_Label15", "Label")
940:             WITH THIS.lbl_4c_Label15
941:                 .FontName  = "Tahoma"
942:                 .FontSize  = 8
943:                 .FontBold  = .T.
944:                 .BackStyle = 0
945:                 .Alignment = 0
946:                 .AutoSize  = .F.
947:                 .Top       = 454
948:                 .Left      = 362
949:                 .Width     = 63
950:                 .Height    = 17
951:                 .ForeColor = RGB(90, 90, 90)
952:                 .Caption   = "Cr" + CHR(233) + "dito [C]"
953:                 .Visible   = .T.
954:             ENDWITH
955: 
956:             THIS.AddObject("lbl_4c_Label5", "Label")
957:             WITH THIS.lbl_4c_Label5
958:                 .FontName  = "Tahoma"
959:                 .FontSize  = 8
960:                 .BackStyle = 0
961:                 .Alignment = 0
962:                 .AutoSize  = .F.
963:                 .Top       = 473
964:                 .Left      = 158
965:                 .Width     = 36
966:                 .Height    = 17
967:                 .ForeColor = RGB(90, 90, 90)
968:                 .Caption   = "Grupo"
969:                 .Visible   = .T.
970:             ENDWITH
971: 
972:             THIS.AddObject("lbl_4c_Label6", "Label")
973:             WITH THIS.lbl_4c_Label6
974:                 .FontName  = "Tahoma"
975:                 .FontSize  = 8
976:                 .BackStyle = 0
977:                 .Alignment = 0
978:                 .AutoSize  = .F.
979:                 .Top       = 473
980:                 .Left      = 239
981:                 .Width     = 35
982:                 .Height    = 17
983:                 .ForeColor = RGB(90, 90, 90)
984:                 .Caption   = "Conta"
985:                 .Visible   = .T.
986:             ENDWITH
987: 
988:             THIS.AddObject("lbl_4c_Label7", "Label")
989:             WITH THIS.lbl_4c_Label7
990:                 .FontName  = "Tahoma"
991:                 .FontSize  = 8
992:                 .BackStyle = 0
993:                 .Alignment = 0
994:                 .AutoSize  = .F.
995:                 .Top       = 473
996:                 .Left      = 329
997:                 .Width     = 36
998:                 .Height    = 17
999:                 .ForeColor = RGB(90, 90, 90)
1000:                 .Caption   = "Grupo"
1001:                 .Visible   = .T.
1002:             ENDWITH
1003: 
1004:             THIS.AddObject("lbl_4c_Label8", "Label")
1005:             WITH THIS.lbl_4c_Label8
1006:                 .FontName  = "Tahoma"
1007:                 .FontSize  = 8
1008:                 .BackStyle = 0
1009:                 .Alignment = 0
1010:                 .AutoSize  = .F.
1011:                 .Top       = 473
1012:                 .Left      = 410
1013:                 .Width     = 35
1014:                 .Height    = 17
1015:                 .ForeColor = RGB(90, 90, 90)
1016:                 .Caption   = "Conta"
1017:                 .Visible   = .T.
1018:             ENDWITH
1019: 
1020:             *-- Rotulos de linha (dump: Say4 "\<Emissor", Say9 "Portador" -
1021:             *-- o marcador \< de atalho do legado nao se aplica a Label no
1022:             *-- VFP9, so o texto e transcrito).
1023:             THIS.AddObject("lbl_4c_Label4", "Label")
1024:             WITH THIS.lbl_4c_Label4
1025:                 .FontName  = "Tahoma"
1026:                 .FontSize  = 8
1027:                 .BackStyle = 0
1028:                 .Alignment = 0
1029:                 .AutoSize  = .F.
1030:                 .Top       = 492
1031:                 .Left      = 75
1032:                 .Width     = 46
1033:                 .Height    = 17
1034:                 .ForeColor = RGB(90, 90, 90)
1035:                 .Caption   = "Emissor"
1036:                 .Visible   = .T.
1037:             ENDWITH
1038: 
1039:             THIS.AddObject("lbl_4c_Label9", "Label")
1040:             WITH THIS.lbl_4c_Label9
1041:                 .FontName  = "Tahoma"
1042:                 .FontSize  = 8
1043:                 .BackStyle = 0
1044:                 .Alignment = 0
1045:                 .AutoSize  = .F.
1046:                 .Top       = 517
1047:                 .Left      = 70
1048:                 .Width     = 52
1049:                 .Height    = 17
1050:                 .ForeColor = RGB(90, 90, 90)
1051:                 .Caption   = "Portador"
1052:                 .Visible   = .T.
1053:             ENDWITH
1054: 
1055:             *-- Linha Emissor (dump: getGrupoEDs/getContaEDs/getGrupoECs/
1056:             *-- getContaECs, Top=488).
1057:             THIS.AddObject("txt_4c_GrupoEDs", "TextBox")
1058:             WITH THIS.txt_4c_GrupoEDs
1059:                 .FontName      = "Tahoma"
1060:                 .FontSize      = 8
1061:                 .Top           = 488
1062:                 .Left          = 139
1063:                 .Width         = 77
1064:                 .Height        = 23
1065:                 .MaxLength     = 11
1066:                 .TabIndex      = 5
1067:                 .ControlSource = "cursor_4c_GrdValores.GrupoEDs"
1068:                 .Visible       = .T.
1069:             ENDWITH
1070: 
1071:             THIS.AddObject("txt_4c_ContaEDs", "TextBox")
1072:             WITH THIS.txt_4c_ContaEDs
1073:                 .FontName      = "Tahoma"
1074:                 .FontSize      = 8
1075:                 .Top           = 488
1076:                 .Left          = 220
1077:                 .Width         = 77
1078:                 .Height        = 23
1079:                 .MaxLength     = 11
1080:                 .TabIndex      = 6
1081:                 .ControlSource = "cursor_4c_GrdValores.ContaEDs"
1082:                 .Visible       = .T.
1083:             ENDWITH
1084: 
1085:             THIS.AddObject("txt_4c_GrupoECs", "TextBox")
1086:             WITH THIS.txt_4c_GrupoECs
1087:                 .FontName      = "Tahoma"
1088:                 .FontSize      = 8
1089:                 .Top           = 488
1090:                 .Left          = 310
1091:                 .Width         = 77
1092:                 .Height        = 23
1093:                 .MaxLength     = 11
1094:                 .TabIndex      = 7
1095:                 .ControlSource = "cursor_4c_GrdValores.GrupoECs"
1096:                 .Visible       = .T.
1097:             ENDWITH
1098: 
1099:             THIS.AddObject("txt_4c_ContaECs", "TextBox")
1100:             WITH THIS.txt_4c_ContaECs
1101:                 .FontName      = "Tahoma"
1102:                 .FontSize      = 8
1103:                 .Top           = 488
1104:                 .Left          = 391
1105:                 .Width         = 77
1106:                 .Height        = 23
1107:                 .MaxLength     = 11
1108:                 .TabIndex      = 8
1109:                 .ControlSource = "cursor_4c_GrdValores.ContaECs"

*-- Linhas 1116 a 1167:
1116:             WITH THIS.txt_4c_GrupoPDs
1117:                 .FontName      = "Tahoma"
1118:                 .FontSize      = 8
1119:                 .Top           = 513
1120:                 .Left          = 139
1121:                 .Width         = 77
1122:                 .Height        = 23
1123:                 .MaxLength     = 11
1124:                 .TabIndex      = 9
1125:                 .ControlSource = "cursor_4c_GrdValores.GrupoPDs"
1126:                 .Visible       = .T.
1127:             ENDWITH
1128: 
1129:             THIS.AddObject("txt_4c_ContaPDs", "TextBox")
1130:             WITH THIS.txt_4c_ContaPDs
1131:                 .FontName      = "Tahoma"
1132:                 .FontSize      = 8
1133:                 .Top           = 513
1134:                 .Left          = 220
1135:                 .Width         = 77
1136:                 .Height        = 23
1137:                 .MaxLength     = 11
1138:                 .TabIndex      = 10
1139:                 .ControlSource = "cursor_4c_GrdValores.ContaPDs"
1140:                 .Visible       = .T.
1141:             ENDWITH
1142: 
1143:             THIS.AddObject("txt_4c_GrupoPCs", "TextBox")
1144:             WITH THIS.txt_4c_GrupoPCs
1145:                 .FontName      = "Tahoma"
1146:                 .FontSize      = 8
1147:                 .Top           = 513
1148:                 .Left          = 310
1149:                 .Width         = 77
1150:                 .Height        = 23
1151:                 .MaxLength     = 11
1152:                 .TabIndex      = 11
1153:                 .ControlSource = "cursor_4c_GrdValores.GrupoPCs"
1154:                 .Visible       = .T.
1155:             ENDWITH
1156: 
1157:             THIS.AddObject("txt_4c_ContaPCs", "TextBox")
1158:             WITH THIS.txt_4c_ContaPCs
1159:                 .FontName      = "Tahoma"
1160:                 .FontSize      = 8
1161:                 .Top           = 513
1162:                 .Left          = 391
1163:                 .Width         = 77
1164:                 .Height        = 23
1165:                 .MaxLength     = 11
1166:                 .TabIndex      = 12
1167:                 .ControlSource = "cursor_4c_GrdValores.ContaPCs"

*-- Linhas 1191 a 1280:
1191:         LOCAL loc_oErro
1192: 
1193:         TRY
1194:             THIS.AddObject("lbl_4c_Label10", "Label")
1195:             WITH THIS.lbl_4c_Label10
1196:                 .FontName  = "Tahoma"
1197:                 .FontSize  = 8
1198:                 .BackStyle = 0
1199:                 .Alignment = 0
1200:                 .AutoSize  = .F.
1201:                 .Top       = 542
1202:                 .Left      = 24
1203:                 .Width     = 92
1204:                 .Height    = 17
1205:                 .ForeColor = RGB(90, 90, 90)
1206:                 .Caption   = "Centro de Custo"
1207:                 .Visible   = .T.
1208:             ENDWITH
1209: 
1210:             THIS.AddObject("lbl_4c_Label11", "Label")
1211:             WITH THIS.lbl_4c_Label11
1212:                 .FontName  = "Tahoma"
1213:                 .FontSize  = 8
1214:                 .BackStyle = 0
1215:                 .Alignment = 0
1216:                 .AutoSize  = .F.
1217:                 .Top       = 567
1218:                 .Left      = 17
1219:                 .Width     = 98
1220:                 .Height    = 17
1221:                 .ForeColor = RGB(90, 90, 90)
1222:                 .Caption   = "Agente Cobrador"
1223:                 .Visible   = .T.
1224:             ENDWITH
1225: 
1226:             *-- Linha Centro de Custo (dump: getGrupoCDs/getContaCDs/
1227:             *-- getGrupoCCs/getContaCCs, Top=538).
1228:             THIS.AddObject("txt_4c_GrupoCDs", "TextBox")
1229:             WITH THIS.txt_4c_GrupoCDs
1230:                 .FontName      = "Tahoma"
1231:                 .FontSize      = 8
1232:                 .Top           = 538
1233:                 .Left          = 139
1234:                 .Width         = 77
1235:                 .Height        = 23
1236:                 .MaxLength     = 11
1237:                 .TabIndex      = 13
1238:                 .ControlSource = "cursor_4c_GrdValores.GrupoCDs"
1239:                 .Visible       = .T.
1240:             ENDWITH
1241: 
1242:             THIS.AddObject("txt_4c_ContaCDs", "TextBox")
1243:             WITH THIS.txt_4c_ContaCDs
1244:                 .FontName      = "Tahoma"
1245:                 .FontSize      = 8
1246:                 .Top           = 538
1247:                 .Left          = 220
1248:                 .Width         = 77
1249:                 .Height        = 23
1250:                 .MaxLength     = 11
1251:                 .TabIndex      = 14
1252:                 .ControlSource = "cursor_4c_GrdValores.ContaCDs"
1253:                 .Visible       = .T.
1254:             ENDWITH
1255: 
1256:             THIS.AddObject("txt_4c_GrupoCCs", "TextBox")
1257:             WITH THIS.txt_4c_GrupoCCs
1258:                 .FontName      = "Tahoma"
1259:                 .FontSize      = 8
1260:                 .Top           = 538
1261:                 .Left          = 310
1262:                 .Width         = 77
1263:                 .Height        = 23
1264:                 .MaxLength     = 11
1265:                 .TabIndex      = 15
1266:                 .ControlSource = "cursor_4c_GrdValores.GrupoCCs"
1267:                 .Visible       = .T.
1268:             ENDWITH
1269: 
1270:             THIS.AddObject("txt_4c_ContaCCs", "TextBox")
1271:             WITH THIS.txt_4c_ContaCCs
1272:                 .FontName      = "Tahoma"
1273:                 .FontSize      = 8
1274:                 .Top           = 538
1275:                 .Left          = 391
1276:                 .Width         = 77
1277:                 .Height        = 23
1278:                 .MaxLength     = 11
1279:                 .TabIndex      = 16
1280:                 .ControlSource = "cursor_4c_GrdValores.ContaCCs"

*-- Linhas 1287 a 1338:
1287:             WITH THIS.txt_4c_GrupoADs
1288:                 .FontName      = "Tahoma"
1289:                 .FontSize      = 8
1290:                 .Top           = 563
1291:                 .Left          = 139
1292:                 .Width         = 77
1293:                 .Height        = 23
1294:                 .MaxLength     = 11
1295:                 .TabIndex      = 17
1296:                 .ControlSource = "cursor_4c_GrdValores.GrupoADs"
1297:                 .Visible       = .T.
1298:             ENDWITH
1299: 
1300:             THIS.AddObject("txt_4c_ContaADs", "TextBox")
1301:             WITH THIS.txt_4c_ContaADs
1302:                 .FontName      = "Tahoma"
1303:                 .FontSize      = 8
1304:                 .Top           = 563
1305:                 .Left          = 220
1306:                 .Width         = 77
1307:                 .Height        = 23
1308:                 .MaxLength     = 11
1309:                 .TabIndex      = 18
1310:                 .ControlSource = "cursor_4c_GrdValores.ContaADs"
1311:                 .Visible       = .T.
1312:             ENDWITH
1313: 
1314:             THIS.AddObject("txt_4c_GrupoACs", "TextBox")
1315:             WITH THIS.txt_4c_GrupoACs
1316:                 .FontName      = "Tahoma"
1317:                 .FontSize      = 8
1318:                 .Top           = 563
1319:                 .Left          = 310
1320:                 .Width         = 77
1321:                 .Height        = 23
1322:                 .MaxLength     = 11
1323:                 .TabIndex      = 19
1324:                 .ControlSource = "cursor_4c_GrdValores.GrupoACs"
1325:                 .Visible       = .T.
1326:             ENDWITH
1327: 
1328:             THIS.AddObject("txt_4c_ContaACs", "TextBox")
1329:             WITH THIS.txt_4c_ContaACs
1330:                 .FontName      = "Tahoma"
1331:                 .FontSize      = 8
1332:                 .Top           = 563
1333:                 .Left          = 391
1334:                 .Width         = 77
1335:                 .Height        = 23
1336:                 .MaxLength     = 11
1337:                 .TabIndex      = 20
1338:                 .ControlSource = "cursor_4c_GrdValores.ContaACs"

*-- Linhas 1358 a 1493:
1358:         LOCAL loc_oErro
1359: 
1360:         TRY
1361:             THIS.AddObject("lbl_4c_Label12", "Label")
1362:             WITH THIS.lbl_4c_Label12
1363:                 .FontName  = "Tahoma"
1364:                 .FontSize  = 8
1365:                 .BackStyle = 0
1366:                 .Alignment = 0
1367:                 .AutoSize  = .F.
1368:                 .Top       = 238
1369:                 .Left      = 744
1370:                 .Width     = 160
1371:                 .Height    = 17
1372:                 .ForeColor = RGB(90, 90, 90)
1373:                 .Caption   = "Inibir Lan" + CHR(231) + "amentos de:"
1374:                 .Visible   = .T.
1375:             ENDWITH
1376: 
1377:             THIS.AddObject("lbl_4c_Label3", "Label")
1378:             WITH THIS.lbl_4c_Label3
1379:                 .FontName  = "Tahoma"
1380:                 .FontSize  = 8
1381:                 .BackStyle = 0
1382:                 .Alignment = 0
1383:                 .AutoSize  = .F.
1384:                 .Top       = 309
1385:                 .Left      = 744
1386:                 .Width     = 140
1387:                 .Height    = 17
1388:                 .ForeColor = RGB(90, 90, 90)
1389:                 .Caption   = "Moeda de Convers" + CHR(227) + "o"
1390:                 .Visible   = .T.
1391:             ENDWITH
1392: 
1393:             THIS.AddObject("txt_4c_CMoes", "TextBox")
1394:             WITH THIS.txt_4c_CMoes
1395:                 .FontName      = "Tahoma"
1396:                 .FontSize      = 8
1397:                 .Top           = 325
1398:                 .Left          = 744
1399:                 .Width         = 31
1400:                 .Height        = 23
1401:                 .MaxLength     = 3
1402:                 .TabIndex      = 21
1403:                 .ControlSource = "cursor_4c_GrdValores.Moedas"
1404:                 .Visible       = .T.
1405:             ENDWITH
1406: 
1407:             THIS.AddObject("lbl_4c_Label13", "Label")
1408:             WITH THIS.lbl_4c_Label13
1409:                 .FontName  = "Tahoma"
1410:                 .FontSize  = 8
1411:                 .BackStyle = 0
1412:                 .Alignment = 0
1413:                 .AutoSize  = .F.
1414:                 .Top       = 355
1415:                 .Left      = 744
1416:                 .Width     = 57
1417:                 .Height    = 17
1418:                 .ForeColor = RGB(90, 90, 90)
1419:                 .Caption   = "Tit. Banco"
1420:                 .Visible   = .T.
1421:             ENDWITH
1422: 
1423:             THIS.AddObject("lbl_4c_Label16", "Label")
1424:             WITH THIS.lbl_4c_Label16
1425:                 .FontName  = "Tahoma"
1426:                 .FontSize  = 8
1427:                 .BackStyle = 0
1428:                 .Alignment = 0
1429:                 .AutoSize  = .F.
1430:                 .Top       = 354
1431:                 .Left      = 853
1432:                 .Width     = 26
1433:                 .Height    = 17
1434:                 .ForeColor = RGB(90, 90, 90)
1435:                 .Caption   = "Tipo"
1436:                 .Visible   = .T.
1437:             ENDWITH
1438: 
1439:             THIS.AddObject("txt_4c_TitBans", "TextBox")
1440:             WITH THIS.txt_4c_TitBans
1441:                 .FontName      = "Tahoma"
1442:                 .FontSize      = 8
1443:                 .Top           = 371
1444:                 .Left          = 744
1445:                 .Width         = 94
1446:                 .Height        = 23
1447:                 .MaxLength     = 12
1448:                 .TabIndex      = 22
1449:                 .ControlSource = "cursor_4c_GrdValores.TitBans"
1450:                 .Visible       = .T.
1451:             ENDWITH
1452: 
1453:             THIS.AddObject("txt_4c_Tipos", "TextBox")
1454:             WITH THIS.txt_4c_Tipos
1455:                 .FontName      = "Tahoma"
1456:                 .FontSize      = 8
1457:                 .Top           = 370
1458:                 .Left          = 853
1459:                 .Width         = 17
1460:                 .Height        = 23
1461:                 .MaxLength     = 1
1462:                 .TabIndex      = 23
1463:                 .ControlSource = "cursor_4c_GrdValores.Tipos"
1464:                 .Visible       = .T.
1465:             ENDWITH
1466: 
1467:             THIS.AddObject("lbl_4c_Label17", "Label")
1468:             WITH THIS.lbl_4c_Label17
1469:                 .FontName  = "Tahoma"
1470:                 .FontSize  = 8
1471:                 .BackStyle = 0
1472:                 .Alignment = 0
1473:                 .AutoSize  = .F.
1474:                 .Top       = 404
1475:                 .Left      = 744
1476:                 .Width     = 144
1477:                 .Height    = 17
1478:                 .ForeColor = RGB(90, 90, 90)
1479:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o de T" + CHR(237) + "tulos"
1480:                 .Visible   = .T.
1481:             ENDWITH
1482: 
1483:             THIS.AddObject("txt_4c_MovTits", "TextBox")
1484:             WITH THIS.txt_4c_MovTits
1485:                 .FontName      = "Tahoma"
1486:                 .FontSize      = 8
1487:                 .Top           = 419
1488:                 .Left          = 744
1489:                 .Width         = 150
1490:                 .Height        = 23
1491:                 .MaxLength     = 20
1492:                 .TabIndex      = 24
1493:                 .ControlSource = "cursor_4c_GrdValores.MovTits"

*-- Linhas 1502 a 1626:
1502:     ENDPROC
1503: 
1504:     *--------------------------------------------------------------------------
1505:     * ConfigurarMemosEcheckboxes - obj_4c_GetNotas/obj_4c_GetComandos
1506:     * (EditBox memo, equivalentes a getNotas/getComandos, ligados a
1507:     * cursor_4c_GrdValores.Notas/Comandos no mesmo padrao mestre-detalhe dos
1508:     * demais campos de linha) e os 2 CheckBox do bloco "Inibir Lancamentos
1509:     * de:" (chk_4c_Chk_P1_CMVS/chk_4c_Chk_P2_MOBS).
1510:     *
1511:     * chk_P1_CMVS/chk_P2_MOBS NAO tem ControlSource no dump (layout.json so
1512:     * declara Value="0" literal) e NAO ha coluna correspondente nem em
1513:     * SigOpFin (CREATE CURSOR crGrdValores do legado nao as lista) nem em
1514:     * SigOpOpe (conferido no schema.sql - nenhuma coluna *cmv*/*mob*
1515:     * corresponde) - ficam como estado de tela, sem ControlSource inventado
1516:     * (regra "NUNCA inventar tabela/coluna de lookup"). O GotFocus/LostFocus
1517:     * de dirty-tracking (This.Tag <-> This.Value, que so seta
1518:     * this_lAlterou) fica para a Fase 7, junto com os demais BINDEVENT.
1519:     *--------------------------------------------------------------------------
1520:     PROTECTED PROCEDURE ConfigurarMemosEcheckboxes()
1521:         LOCAL loc_oErro
1522: 
1523:         TRY
1524:             THIS.AddObject("lbl_4c_Label1", "Label")
1525:             WITH THIS.lbl_4c_Label1
1526:                 .FontName  = "Tahoma"
1527:                 .FontSize  = 8
1528:                 .BackStyle = 0
1529:                 .Alignment = 0
1530:                 .AutoSize  = .F.
1531:                 .Top       = 294
1532:                 .Left      = 12
1533:                 .Width     = 900
1534:                 .Height    = 17
1535:                 .ForeColor = RGB(90, 90, 90)
1536:                 .Caption   = "Notas Sobre a Configura" + CHR(231) + CHR(227) + ;
1537:                     "o (obrigat" + CHR(243) + "rio descrever o m" + CHR(225) + ;
1538:                     "ximo poss" + CHR(237) + "vel a finalidade do lan" + CHR(231) + "amento)"
1539:                 .Visible   = .T.
1540:             ENDWITH
1541: 
1542:             THIS.AddObject("obj_4c_GetNotas", "EditBox")
1543:             WITH THIS.obj_4c_GetNotas
1544:                 .FontName      = "Tahoma"
1545:                 .FontSize      = 8
1546:                 .Top           = 311
1547:                 .Left          = 12
1548:                 .Width         = 721
1549:                 .Height        = 131
1550:                 .ScrollBars    = 2
1551:                 .TabIndex      = 25
1552:                 .ControlSource = "cursor_4c_GrdValores.Notas"
1553:                 .Visible       = .T.
1554:             ENDWITH
1555: 
1556:             THIS.AddObject("lbl_4c_Label2", "Label")
1557:             WITH THIS.lbl_4c_Label2
1558:                 .FontName  = "Tahoma"
1559:                 .FontSize  = 8
1560:                 .BackStyle = 0
1561:                 .Alignment = 0
1562:                 .AutoSize  = .F.
1563:                 .Top       = 455
1564:                 .Left      = 485
1565:                 .Width     = 157
1566:                 .Height    = 15
1567:                 .ForeColor = RGB(90, 90, 90)
1568:                 .Caption   = "Comandos de Programa" + CHR(231) + CHR(227) + "o"
1569:                 .Visible   = .T.
1570:             ENDWITH
1571: 
1572:             THIS.AddObject("obj_4c_GetComandos", "EditBox")
1573:             WITH THIS.obj_4c_GetComandos
1574:                 .FontName      = "Tahoma"
1575:                 .FontSize      = 8
1576:                 .Top           = 471
1577:                 .Left          = 485
1578:                 .Width         = 508
1579:                 .Height        = 121
1580:                 .ScrollBars    = 2
1581:                 .TabIndex      = 26
1582:                 .ControlSource = "cursor_4c_GrdValores.Comandos"
1583:                 .Visible       = .T.
1584:             ENDWITH
1585: 
1586:             THIS.AddObject("chk_4c_Chk_P1_CMVS", "CheckBox")
1587:             WITH THIS.chk_4c_Chk_P1_CMVS
1588:                 .FontName  = "Tahoma"
1589:                 .FontSize  = 8
1590:                 .BackStyle = 0
1591:                 .Top       = 256
1592:                 .Left      = 744
1593:                 .Width     = 220
1594:                 .Height    = 17
1595:                 .ForeColor = RGB(90, 90, 90)
1596:                 .Caption   = "CMV de Grupos de Produtos"
1597:                 .Value     = 0
1598:                 .TabIndex  = 27
1599:                 .Visible   = .T.
1600:             ENDWITH
1601: 
1602:             THIS.AddObject("chk_4c_Chk_P2_MOBS", "CheckBox")
1603:             WITH THIS.chk_4c_Chk_P2_MOBS
1604:                 .FontName  = "Tahoma"
1605:                 .FontSize  = 8
1606:                 .BackStyle = 0
1607:                 .Top       = 273
1608:                 .Left      = 744
1609:                 .Width     = 240
1610:                 .Height    = 17
1611:                 .ForeColor = RGB(90, 90, 90)
1612:                 .Caption   = "M" + CHR(227) + "o de Obra da Movimenta" + CHR(231) + CHR(227) + "o"
1613:                 .Value     = 0
1614:                 .TabIndex  = 28
1615:                 .Visible   = .T.
1616:             ENDWITH
1617:         CATCH TO loc_oErro
1618:             MsgErro(loc_oErro.Message + CHR(13) + ;
1619:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1620:                 "Procedure: " + loc_oErro.Procedure, ;
1621:                 "Erro em ConfigurarMemosEcheckboxes")
1622:         ENDTRY
1623:     ENDPROC
1624: 
1625:     *--------------------------------------------------------------------------
1626:     * ConfigurarEventosLookup - liga por BINDEVENT os campos que tem lookup no

*-- Linhas 2344 a 2352:
2344: 
2345:     *--------------------------------------------------------------------------
2346:     * AplicarValorLookup - grava no campo o codigo escolhido e a descricao no
2347:     * ToolTipText (o legado faz This.Value = ... / This.ToolTipText = Descrs),
2348:     * marcando a tela como alterada (plAlterou do legado).
2349:     *
2350:     * Todos esses TextBox tem ControlSource em cursor_4c_GrdValores: atribuir
2351:     * .Value grava na linha corrente do cursor, que e exatamente o que o
2352:     * legado faz. Sem linha corrente nao ha onde gravar - dai a guarda.

*-- Linhas 2414 a 2422:
2414:         IF VARTYPE(loc_oBusca) = "O"
2415:             loc_oBusca.this_cCursorDestino = par_cCursor
2416:             loc_oBusca.this_cTitulo        = par_cTitulo
2417:             loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = par_cTitulo
2418: 
2419:             loc_oBusca.mAddColuna(par_cCampoCod,  "", par_cCampoCod)
2420:             loc_oBusca.mAddColuna(par_cCampoDesc, "", par_cCampoDesc)
2421:             loc_oBusca.Show()
2422: 

*-- Linhas 2728 a 2736:
2728:                     .Column1.Width             = 700
2729:                     .Column1.FontName          = "Tahoma"
2730:                     .Column1.FontSize          = 8
2731:                     .Column1.Header1.Caption   = "Origem dos Valores a Serem Lan" + ;
2732:                         CHR(231) + "ados na Movimenta" + CHR(231) + CHR(227) + ;
2733:                         "o Financeira"
2734:                     .Column1.Header1.Alignment = 2
2735:                     .Column1.Header1.FontBold  = .F.
2736: 

*-- Linhas 2774 a 2782:
2774:             *-- (Centro de Custo/Agente Cobrador - ConfigurarCamposCentro-
2775:             *-- CustoAgenteCobrador - e CMoes/TitBans/Tipos/MovTits/Notas/
2776:             *-- Comandos - ConfigurarCamposComplementares/
2777:             *-- ConfigurarMemosEcheckboxes). Mesmo guard por PEMSTATUS da
2778:             *-- Fase 5 parte 1, mesma razao.
2779:             IF PEMSTATUS(THIS, "txt_4c_GrupoCDs", 5)
2780:                 THIS.txt_4c_GrupoCDs.ControlSource = "cursor_4c_GrdValores.GrupoCDs"
2781:                 THIS.txt_4c_ContaCDs.ControlSource = "cursor_4c_GrdValores.ContaCDs"
2782:                 THIS.txt_4c_GrupoCCs.ControlSource = "cursor_4c_GrdValores.GrupoCCs"

*-- Linhas 2844 a 2859:
2844:         TRY
2845:             loc_lEditando = THIS.EmModoEdicao()
2846: 
2847:             IF PEMSTATUS(THIS, "cmd_4c_BtnSetaUp", 5)
2848:                 THIS.cmd_4c_BtnSetaUp.Visible = loc_lEditando
2849:             ENDIF
2850:             IF PEMSTATUS(THIS, "cmd_4c_BtnSetaDn", 5)
2851:                 THIS.cmd_4c_BtnSetaDn.Visible = loc_lEditando
2852:             ENDIF
2853:             IF PEMSTATUS(THIS, "cmd_4c_BtnExcluiGrd", 5)
2854:                 THIS.cmd_4c_BtnExcluiGrd.Visible = loc_lEditando
2855:             ENDIF
2856:         CATCH TO loc_oErro
2857:             MsgErro(loc_oErro.Message + CHR(13) + ;
2858:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2859:                 "Procedure: " + loc_oErro.Procedure, ;

*-- Linhas 2968 a 2976:
2968:     * tracking (legado: "This.Tag = This.Value" no GotFocus e "If (This.Tag
2969:     * <> This.Value) ThisForm.plAlterou = .t. EndIf" no LostFocus, repetido
2970:     * em ~20 controles do dump). TRANSFORM() normaliza C/N (TextBox guarda
2971:     * char, CheckBox guarda numerico 0/1 - Str(Value,1) do legado e
2972:     * TRANSFORM(Value) aqui dao o mesmo "0"/"1").
2973:     *--------------------------------------------------------------------------
2974:     PROTECTED PROCEDURE SalvarTagCampo(par_cCampo)
2975:         LOCAL loc_oCtrl
2976: 

*-- Linhas 3017 a 3025:
3017:     * ConfigurarEventosDirtyTracking - BINDEVENT de GotFocus/LostFocus para
3018:     * dirty-tracking (this_lAlterou) em todos os controles de detalhe da
3019:     * linha corrente que o dump declara com esse par (16 Grupo/Conta +
3020:     * CMoes/TitBans/Tipos/MovTits + getNotas/getComandos + os 2 CheckBox).
3021:     * Fase 7. O LostFocus dos campos com lookup (Grupo/Conta/CMoes/TitBans/
3022:     * MovTits) ja esta ligado a *Lookup (Fase 6, equivalente ao Valid do
3023:     * legado) - o BIND aqui e um SEGUNDO handler no MESMO evento, que o VFP9
3024:     * encadeia na ordem de ligacao (Lookup primeiro, dirty-check depois),
3025:     * reproduzindo a ordem real do legado (Valid roda antes de LostFocus).

*-- Linhas 3565 a 3573:
3565:     * legado). crSigCdOpe no legado e o registro da operacao (SigCdOpe, PK
3566:     * dopes) ja aberto pelo form PAI - aqui le-se e grava-se via SQL direto,
3567:     * ja que este dialogo nao tem esse cursor. "S"/"N" (convencao Fortyus de
3568:     * flag char) no lugar do valor logico do CheckBox legado - this_cDopes
3569:     * ja vem com o padding de 20 (PADR no Init), EscaparSQL compara com
3570:     * blank-padding ANSI do SQL Server.
3571:     *
3572:     * Sem registro de SigCdOpe para este Dopes: devolve .T. em silencio (nao
3573:     * ha o que atualizar, e nao deve bloquear o fechamento do dialogo por uma


### BO (C:\4c\projeto\app\classes\sigopfinBO.prg):
*====================================================================
* sigopfinBO.prg
*
* Business Object para Configuracao de Lancamentos Financeiros
* Tabela: sigopfin
* Herda de: BusinessBase
*
* Cada registro de sigopfin eh uma LINHA de configuracao (origem dos
* valores a serem lancados) associada a uma movimentacao (dopes, FK
* para SigOpOpe.Dopes). A tela (Formsigopfin) exibe/edita varias
* linhas simultaneamente num grid; este BO trata uma linha por vez.
*====================================================================

DEFINE CLASS sigopfinBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela sigopfin)
    this_cCidChaves = ""    && cidchaves char(20) - PK (Fortyus)
    this_cCodigos   = ""    && codigos   char(10) - FK para origem (crTabOpFin.Codigos)
    this_cComandos  = ""    && comandos  text     - memo de comandos de programacao
    this_cContaAcs  = ""    && contaacs  char(11)
    this_cContaAds  = ""    && contaads  char(11)
    this_cContaCcs  = ""    && contaccs  char(11)
    this_cContaCds  = ""    && contacds  char(11)
    this_cContaEcs  = ""    && contaecs  char(11)
    this_cContaEds  = ""    && contaeds  char(11)
    this_cContaPcs  = ""    && contapcs  char(11)
    this_cContaPds  = ""    && contapds  char(11)
    this_dDatAlts   = {}    && datalts   datetime
    this_dDatIncs   = {}    && datincs   datetime
    this_cDopes     = ""    && dopes     char(20) - FK para SigOpOpe.Dopes (movimentacao)
    this_cGrupoAcs  = ""    && grupoacs  char(11)
    this_cGrupoAds  = ""    && grupoads  char(11)
    this_cGrupoCcs  = ""    && grupoccs  char(11)
    this_cGrupoCds  = ""    && grupocds  char(11)
    this_cGrupoEcs  = ""    && grupoecs  char(11)
    this_cGrupoEds  = ""    && grupoeds  char(11)
    this_cGrupoPcs  = ""    && grupopcs  char(11)
    this_cGrupoPds  = ""    && grupopds  char(11)
    this_cMoedas    = ""    && moedas    char(3)
    this_cMovTits   = ""    && movtits   char(20)
    this_cNotas     = ""    && notas     text     - memo de notas sobre a configuracao
    this_nOrdem     = 0     && ordem     numeric(3,0)
    this_cTipos     = ""    && tipos     char(1)
    this_cTitBans   = ""    && titbans   char(12)
    this_cUsuAlts   = ""    && usualts   char(10)
    this_cUsuIncs   = ""    && usuincs   char(10)
    this_nChkEmpds  = 0     && chkempds  numeric(1,0)

    *-- Propriedade NAO persistida: descricao exibida no grid (origem do
    *-- lookup contra crTabOpFin.Descrs, casada por this_cCodigos). Nao
    *-- existe coluna "descrs" em sigopfin - eh so exibicao.
    this_cDescricao = ""

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "sigopfin"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigopfinBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    * (usada por RegistrarAuditoria)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia os campos do cursor para as propriedades
    * da linha de configuracao (sigopfin). par_cAliasCursor eh o alias do
    * cursor posicionado no registro a carregar (ex.: resultado de um
    * SQLEXEC pela chave cidchaves, ou a linha corrente de crGrdValores).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "")
            THIS.this_cCodigos   = TratarNulo(codigos,   "")
            THIS.this_cComandos  = TratarNulo(comandos,  "")
            THIS.this_cContaAcs  = TratarNulo(contaacs,  "")
            THIS.this_cContaAds  = TratarNulo(contaads,  "")
            THIS.this_cContaCcs  = TratarNulo(contaccs,  "")
            THIS.this_cContaCds  = TratarNulo(contacds,  "")
            THIS.this_cContaEcs  = TratarNulo(contaecs,  "")
            THIS.this_cContaEds  = TratarNulo(contaeds,  "")
            THIS.this_cContaPcs  = TratarNulo(contapcs,  "")
            THIS.this_cContaPds  = TratarNulo(contapds,  "")
            THIS.this_dDatAlts   = TratarNulo(datalts,   {})
            THIS.this_dDatIncs   = TratarNulo(datincs,   {})
            THIS.this_cDopes     = TratarNulo(dopes,     "")
            THIS.this_cGrupoAcs  = TratarNulo(grupoacs,  "")
            THIS.this_cGrupoAds  = TratarNulo(grupoads,  "")
            THIS.this_cGrupoCcs  = TratarNulo(grupoccs,  "")
            THIS.this_cGrupoCds  = TratarNulo(grupocds,  "")
            THIS.this_cGrupoEcs  = TratarNulo(grupoecs,  "")
            THIS.this_cGrupoEds  = TratarNulo(grupoeds,  "")
            THIS.this_cGrupoPcs  = TratarNulo(grupopcs,  "")
            THIS.this_cGrupoPds  = TratarNulo(grupopds,  "")
            THIS.this_cMoedas    = TratarNulo(moedas,    "")
            THIS.this_cMovTits   = TratarNulo(movtits,   "")
            THIS.this_cNotas     = TratarNulo(notas,     "")
            THIS.this_nOrdem     = TratarNulo(ordem,     0)
            THIS.this_cTipos     = TratarNulo(tipos,     "")
            THIS.this_cTitBans   = TratarNulo(titbans,   "")
            THIS.this_cUsuAlts   = TratarNulo(usualts,   "")
            THIS.this_cUsuIncs   = TratarNulo(usuincs,   "")
            THIS.this_nChkEmpds  = TratarNulo(chkempds,  0)

            *-- descrs nao eh coluna de sigopfin: so chega quando o cursor de
            *-- origem for montado com JOIN contra crTabOpFin/SigOpOpe (lookup
            *-- da descricao exibida na grade). Mapear so quando presente.
            IF TYPE(par_cAliasCursor + ".descrs") != "U"
                THIS.this_cDescricao = TratarNulo(descrs, "")
            ELSE
                THIS.this_cDescricao = ""
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT de uma linha de configuracao na tabela sigopfin
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            THIS.this_cUsuIncs   = gc_4c_UsuarioLogado

            loc_cSQL = "INSERT INTO sigopfin (cidchaves, codigos, comandos, contaacs," + ;
                       " contaads, contaccs, contacds, contaecs, contaeds, contapcs," + ;
                       " contapds, datalts, datincs, dopes, grupoacs, grupoads," + ;
                       " grupoccs, grupocds, grupoecs, grupoeds, grupopcs, grupopds," + ;
                       " moedas, movtits, notas, ordem, tipos, titbans, usualts," + ;
                       " usuincs, chkempds)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cCodigos)   + "," + ;
                       EscaparSQL(THIS.this_cComandos)  + "," + ;
                       EscaparSQL(THIS.this_cContaAcs)  + "," + ;
                       EscaparSQL(THIS.this_cContaAds)  + "," + ;
                       EscaparSQL(THIS.this_cContaCcs)  + "," + ;
                       EscaparSQL(THIS.this_cContaCds)  + "," + ;
                       EscaparSQL(THIS.this_cContaEcs)  + "," + ;
                       EscaparSQL(THIS.this_cContaEds)  + "," + ;
                       EscaparSQL(THIS.this_cContaPcs)  + "," + ;
                       EscaparSQL(THIS.this_cContaPds)  + "," + ;
                       "NULL," + ;
                       "GETDATE()," + ;
                       EscaparSQL(THIS.this_cDopes)     + "," + ;
                       EscaparSQL(THIS.this_cGrupoAcs)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoAds)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoCcs)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoCds)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoEcs)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoEds)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoPcs)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoPds)  + "," + ;
                       EscaparSQL(THIS.this_cMoedas)    + "," + ;
                       EscaparSQL(THIS.this_cMovTits)   + "," + ;
                       EscaparSQL(THIS.this_cNotas)     + "," + ;
                       FormatarNumeroSQL(THIS.this_nOrdem, 0) + "," + ;
                       EscaparSQL(THIS.this_cTipos)     + "," + ;
                       EscaparSQL(THIS.this_cTitBans)   + "," + ;
                       EscaparSQL(THIS.this_cUsuAlts)   + "," + ;
                       EscaparSQL(THIS.this_cUsuIncs)   + "," + ;
                       FormatarNumeroSQL(THIS.this_nChkEmpds, 0) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o financeira:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o financeira:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE de uma linha de configuracao na tabela sigopfin
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cUsuAlts = gc_4c_UsuarioLogado

            loc_cSQL = "UPDATE sigopfin SET" + ;
                       " codigos   = " + EscaparSQL(THIS.this_cCodigos)   + "," + ;
                       " comandos  = " + EscaparSQL(THIS.this_cComandos)  + "," + ;
                       " contaacs  = " + EscaparSQL(THIS.this_cContaAcs)  + "," + ;
                       " contaads  = " + EscaparSQL(THIS.this_cContaAds)  + "," + ;
                       " contaccs  = " + EscaparSQL(THIS.this_cContaCcs)  + "," + ;
                       " contacds  = " + EscaparSQL(THIS.this_cContaCds)  + "," + ;
                       " contaecs  = " + EscaparSQL(THIS.this_cContaEcs)  + "," + ;
                       " contaeds  = " + EscaparSQL(THIS.this_cContaEds)  + "," + ;
                       " contapcs  = " + EscaparSQL(THIS.this_cContaPcs)  + "," + ;
                       " contapds  = " + EscaparSQL(THIS.this_cContaPds)  + "," + ;
                       " datalts   = GETDATE()," + ;
                       " dopes     = " + EscaparSQL(THIS.this_cDopes)     + "," + ;
                       " grupoacs  = " + EscaparSQL(THIS.this_cGrupoAcs)  + "," + ;
                       " grupoads  = " + EscaparSQL(THIS.this_cGrupoAds)  + "," + ;
                       " grupoccs  = " + EscaparSQL(THIS.this_cGrupoCcs)  + "," + ;
                       " grupocds  = " + EscaparSQL(THIS.this_cGrupoCds)  + "," + ;
                       " grupoecs  = " + EscaparSQL(THIS.this_cGrupoEcs)  + "," + ;
                       " grupoeds  = " + EscaparSQL(THIS.this_cGrupoEds)  + "," + ;
                       " grupopcs  = " + EscaparSQL(THIS.this_cGrupoPcs)  + "," + ;
                       " grupopds  = " + EscaparSQL(THIS.this_cGrupoPds)  + "," + ;
                       " moedas    = " + EscaparSQL(THIS.this_cMoedas)    + "," + ;
                       " movtits   = " + EscaparSQL(THIS.this_cMovTits)   + "," + ;
                       " notas     = " + EscaparSQL(THIS.this_cNotas)     + "," + ;
                       " ordem     = " + FormatarNumeroSQL(THIS.this_nOrdem, 0) + "," + ;
                       " tipos     = " + EscaparSQL(THIS.this_cTipos)     + "," + ;
                       " titbans   = " + EscaparSQL(THIS.this_cTitBans)   + "," + ;
                       " usualts   = " + EscaparSQL(THIS.this_cUsuAlts)   + "," + ;
                       " chkempds  = " + FormatarNumeroSQL(THIS.this_nChkEmpds, 0) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o financeira:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o financeira:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

