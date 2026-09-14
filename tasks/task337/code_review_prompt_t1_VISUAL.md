# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [FONTNAME-ERRADO] Linha 333: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 359: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 385: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 410: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprtef.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1496 linhas total):

*-- Linhas 72 a 80:
72:         loc_lSucesso = .F.
73: 
74:         TRY
75:             THIS.Caption = "Administra" + CHR(231) + CHR(227) + "o do TEF"
76: 
77:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
78:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
79:             ENDIF
80: 

*-- Linhas 153 a 161:
153:     *==========================================================================
154:         *-- Form OPERACIONAL: modal flat 800x190 SEM PageFrame e SEM Page2-Dados.
155:         *-- Nao existe "Page2 - Formulario de Edicao" nesta tela: o layout
156:         *-- completo (Shape1, cnt_4c_TefTxt, lbl_4c_Redetef, txt_4c_Redetef e os
157:         *-- 4 botoes de acao TEF) eh criado inteiramente em ConfigurarForm(),
158:         *-- que eh chamado por ConfigurarPageFrame() durante InicializarForm().
159:         *--
160:         *-- Este metodo existe para atender ao contrato do validador do
161:         *-- orquestrador de migracao (Fase 5) e retorna sempre .T. porque

*-- Linhas 172 a 339:
172:             *-- Shape decorativo (canto direito - Shape1 do legado)
173:             THIS.AddObject("shp_4c_Shape1", "Shape")
174:             WITH THIS.shp_4c_Shape1
175:                 .Top         = 7
176:                 .Left        = 698
177:                 .Height      = 110
178:                 .Width       = 90
179:                 .BackStyle   = 0
180:                 .BorderColor = RGB(136, 189, 188)
181:                 .Visible     = .T.
182:             ENDWITH
183: 
184:             *-- Container de mensagens TEF (CntTefTxt do legado - inicia Visible=.F.)
185:             THIS.AddObject("cnt_4c_TefTxt", "Container")
186:             WITH THIS.cnt_4c_TefTxt
187:                 .Top           = 35
188:                 .Left          = 2
189:                 .Height        = 155
190:                 .Width         = 381
191:                 .SpecialEffect = 0
192:                 .BackColor     = RGB(255, 255, 255)
193:                 .BackStyle     = 1
194:                 .Visible       = .F.
195:             ENDWITH
196: 
197:             *-- Labels filhos de cnt_4c_TefTxt (fora de WITH pai - evita WITH aninhado)
198:             THIS.cnt_4c_TefTxt.AddObject("lbl_4c_Label1", "Label")
199:             WITH THIS.cnt_4c_TefTxt.lbl_4c_Label1
200:                 .AutoSize  = .F.
201:                 .FontBold  = .T.
202:                 .FontSize  = 9
203:                 .WordWrap  = .T.
204:                 .BackStyle = 0
205:                 .Caption   = "Impress" + CHR(227) + "o Cupom Vinculado : "
206:                 .Height    = 26
207:                 .Left      = 4
208:                 .Top       = 5
209:                 .Width     = 174
210:                 .ForeColor = RGB(0, 0, 160)
211:                 .Visible   = .T.
212:             ENDWITH
213: 
214:             THIS.cnt_4c_TefTxt.AddObject("lbl_4c_TxtTpTrans", "Label")
215:             WITH THIS.cnt_4c_TefTxt.lbl_4c_TxtTpTrans
216:                 .AutoSize  = .F.
217:                 .FontBold  = .T.
218:                 .FontSize  = 9
219:                 .WordWrap  = .T.
220:                 .BackStyle = 0
221:                 .Caption   = ""
222:                 .Height    = 26
223:                 .Left      = 177
224:                 .Top       = 5
225:                 .Width     = 195
226:                 .ForeColor = RGB(0, 0, 255)
227:                 .Visible   = .T.
228:             ENDWITH
229: 
230:             THIS.cnt_4c_TefTxt.AddObject("lbl_4c_Label2", "Label")
231:             WITH THIS.cnt_4c_TefTxt.lbl_4c_Label2
232:                 .AutoSize  = .F.
233:                 .FontBold  = .T.
234:                 .FontSize  = 9
235:                 .WordWrap  = .T.
236:                 .BackStyle = 0
237:                 .Caption   = "Mensagem Operador : "
238:                 .Height    = 25
239:                 .Left      = 4
240:                 .Top       = 62
241:                 .Width     = 128
242:                 .ForeColor = RGB(0, 0, 160)
243:                 .Visible   = .T.
244:             ENDWITH
245: 
246:             THIS.cnt_4c_TefTxt.AddObject("lbl_4c_TxtOper", "Label")
247:             WITH THIS.cnt_4c_TefTxt.lbl_4c_TxtOper
248:                 .AutoSize  = .F.
249:                 .FontBold  = .T.
250:                 .FontSize  = 9
251:                 .WordWrap  = .T.
252:                 .BackStyle = 0
253:                 .Caption   = ""
254:                 .Height    = 26
255:                 .Left      = 134
256:                 .Top       = 61
257:                 .Width     = 239
258:                 .ForeColor = RGB(0, 0, 255)
259:                 .Visible   = .T.
260:             ENDWITH
261: 
262:             THIS.cnt_4c_TefTxt.AddObject("lbl_4c_TxtCli", "Label")
263:             WITH THIS.cnt_4c_TefTxt.lbl_4c_TxtCli
264:                 .AutoSize  = .F.
265:                 .FontBold  = .T.
266:                 .FontSize  = 9
267:                 .WordWrap  = .T.
268:                 .BackStyle = 0
269:                 .Caption   = "Mensagem Cliente : "
270:                 .Height    = 22
271:                 .Left      = 4
272:                 .Top       = 108
273:                 .Width     = 115
274:                 .ForeColor = RGB(0, 0, 160)
275:                 .Visible   = .T.
276:             ENDWITH
277: 
278:             THIS.cnt_4c_TefTxt.AddObject("lbl_4c_Label3", "Label")
279:             WITH THIS.cnt_4c_TefTxt.lbl_4c_Label3
280:                 .AutoSize  = .F.
281:                 .FontBold  = .T.
282:                 .FontSize  = 9
283:                 .WordWrap  = .T.
284:                 .BackStyle = 0
285:                 .Caption   = ""
286:                 .Height    = 22
287:                 .Left      = 118
288:                 .Top       = 108
289:                 .Width     = 255
290:                 .ForeColor = RGB(0, 0, 255)
291:                 .Visible   = .T.
292:             ENDWITH
293: 
294:             *-- Label "Rede Tef :" (Say1 do legado)
295:             THIS.AddObject("lbl_4c_Redetef", "Label")
296:             WITH THIS.lbl_4c_Redetef
297:                 .FontBold  = .T.
298:                 .FontName  = "Verdana"
299:                 .FontSize  = 8
300:                 .Caption   = "Rede Tef :"
301:                 .Left      = 203
302:                 .Top       = 147
303:                 .ForeColor = RGB(36, 84, 155)
304:                 .BackStyle = 0
305:                 .AutoSize  = .T.
306:                 .Visible   = .T.
307:             ENDWITH
308: 
309:             *-- TextBox Rede TEF (Get_redetef do legado)
310:             THIS.AddObject("txt_4c_Redetef", "TextBox")
311:             WITH THIS.txt_4c_Redetef
312:                 .Height   = 23
313:                 .Left     = 274
314:                 .Top      = 144
315:                 .Width    = 150
316:                 .Value    = ""
317:                 .FontName = "Tahoma"
318:                 .FontSize = 8
319:                 .Visible  = .T.
320:             ENDWITH
321: 
322:             *-- Botao Admin TEF (TefAdm do legado)
323:             *-- Inicia Enabled=.F.; habilitado em InicializarEstadoTEF apos leitura FAB
324:             THIS.AddObject("cmd_4c_TefAdm", "CommandButton")
325:             WITH THIS.cmd_4c_TefAdm
326:                 .Top             = 12
327:                 .Left            = 17
328:                 .Width           = 75
329:                 .Height          = 75
330:                 .Caption         = "Admin"
331:                 .Picture         = gc_4c_CaminhoIcones + "geral_pn_btn_60.jpg"
332:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_pn_btn_60.jpg"
333:                 .FontName        = "Comic Sans MS"
334:                 .FontSize        = 8
335:                 .FontBold        = .T.
336:                 .FontItalic      = .T.
337:                 .ForeColor       = RGB(90, 90, 90)
338:                 .BackColor       = RGB(255, 255, 255)
339:                 .Themes          = .T.

*-- Linhas 347 a 365:
347:             ENDWITH
348: 
349:             *-- Botao Tef Ativo (TefAtv do legado)
350:             THIS.AddObject("cmd_4c_TefAtv", "CommandButton")
351:             WITH THIS.cmd_4c_TefAtv
352:                 .Top             = 12
353:                 .Left            = 100
354:                 .Width           = 75
355:                 .Height          = 75
356:                 .Caption         = "\<Tef Ativo"
357:                 .Picture         = gc_4c_CaminhoIcones + "cartao.png"
358:                 .DisabledPicture = gc_4c_CaminhoIcones + "cartao.png"
359:                 .FontName        = "Comic Sans MS"
360:                 .FontSize        = 8
361:                 .FontBold        = .T.
362:                 .FontItalic      = .T.
363:                 .ForeColor       = RGB(90, 90, 90)
364:                 .BackColor       = RGB(255, 255, 255)
365:                 .Themes          = .T.

*-- Linhas 373 a 391:
373:             ENDWITH
374: 
375:             *-- Botao Cancelar (Command1 do legado)
376:             THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
377:             WITH THIS.cmd_4c_Cancelar
378:                 .Top             = 12
379:                 .Left            = 183
380:                 .Width           = 75
381:                 .Height          = 75
382:                 .Caption         = "\<Cancelar"
383:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
384:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
385:                 .FontName        = "Comic Sans MS"
386:                 .FontSize        = 8
387:                 .FontBold        = .T.
388:                 .FontItalic      = .T.
389:                 .ForeColor       = RGB(90, 90, 90)
390:                 .BackColor       = RGB(255, 255, 255)
391:                 .Themes          = .T.

*-- Linhas 398 a 416:
398:             ENDWITH
399: 
400:             *-- Botao Encerrar (Sair do legado, Cancel=.T. para ESC fechar)
401:             THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
402:             WITH THIS.cmd_4c_Encerrar
403:                 .Top             = 12
404:                 .Left            = 703
405:                 .Width           = 75
406:                 .Height          = 75
407:                 .Caption         = "Encerrar"
408:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
409:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
410:                 .FontName        = "Comic Sans MS"
411:                 .FontSize        = 8
412:                 .FontBold        = .T.
413:                 .FontItalic      = .T.
414:                 .ForeColor       = RGB(90, 90, 90)
415:                 .BackColor       = RGB(255, 255, 255)
416:                 .Themes          = .T.

*-- Linhas 460 a 469:
460:             ENDIF
461: 
462:             *-- fChecaAcesso nao portada: habilitar botoes se inicializacao ok
463:             THIS.cmd_4c_TefAdm.Enabled = loc_lOk
464:             THIS.cmd_4c_TefAtv.Enabled = loc_lOk
465: 
466:         CATCH TO loc_oErro
467:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
468:                     "Erro InicializarEstadoTEF")
469:         ENDTRY

*-- Linhas 522 a 536:
522:     *==========================================================================
523:         LOCAL loc_oErro
524:         TRY
525:             BINDEVENT(THIS.cmd_4c_Encerrar, "Click",    THIS, "CmdEncerrarClick")
526:             BINDEVENT(THIS.cmd_4c_TefAdm,   "Click",    THIS, "CmdTefAdmClick")
527:             BINDEVENT(THIS.cmd_4c_TefAdm,   "When",     THIS, "CmdTefAdmWhen")
528:             BINDEVENT(THIS.cmd_4c_TefAtv,   "Click",    THIS, "CmdTefAtvClick")
529:             BINDEVENT(THIS.cmd_4c_TefAtv,   "When",     THIS, "CmdTefAtvWhen")
530:             BINDEVENT(THIS.cmd_4c_Cancelar, "Click",    THIS, "CmdCancelarClick")
531:             BINDEVENT(THIS.cmd_4c_Cancelar, "When",     THIS, "CmdCancelarWhen")
532:             BINDEVENT(THIS.txt_4c_Redetef,  "KeyPress", THIS, "TxtRedetefKeyPress")
533:             BINDEVENT(THIS.txt_4c_Redetef,  "KeyPress",    THIS, "TxtRedetefValid")
534:         CATCH TO loc_oErro
535:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ConfigurarEventos")
536:         ENDTRY

*-- Linhas 786 a 794:
786: 
787:                 WAIT WINDOW "Aguarde Processamento TEF !!" NOWAIT
788:                 loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)
789:                 THIS.cmd_4c_TefAdm.Enabled = .F.
790:                 loc_lcTipo  = "ADM"
791:                 loc_SendTef = SigFiTefReq(THIS, THIS.cNoCaixa, go_4c_Sistema.cCodEmpresa, ;
792:                                            THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
793:                 WAIT CLEAR
794: 

*-- Linhas 824 a 836:
824:             ENDIF
825: 
826:             WAIT CLEAR
827:             THIS.cmd_4c_TefAdm.Enabled = .T.
828: 
829:         CATCH TO loc_oErro
830:             WAIT CLEAR
831:             THIS.cmd_4c_TefAdm.Enabled = .T.
832:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CmdTefAdmClick")
833:         ENDTRY
834:     ENDPROC
835: 
836:     *==========================================================================

*-- Linhas 1048 a 1076:
1048:             ENDIF
1049: 
1050:             WITH THIS.cnt_4c_TefTxt
1051:                 .Top  = 35
1052:                 .Left = 2
1053:                 IF loc_nSistef = 1 OR loc_nSistef = 3
1054:                     IF !EMPTY(ALLTRIM(crSigFiTef.cTxtOpers))
1055:                         .lbl_4c_TxtOper.Caption  = ALLTRIM(crSigFiTef.cTxtOpers)
1056:                         .lbl_4c_TxtOper.Width    = 239
1057:                         .lbl_4c_TxtOper.AutoSize = .T.
1058:                         .Visible = .T.
1059:                         .ZOrder()
1060:                     ENDIF
1061:                     IF !EMPTY(ALLTRIM(crSigFiTef.cTxtClis))
1062:                         .lbl_4c_TxtCli.Caption  = ALLTRIM(crSigFiTef.cTxtClis)
1063:                         .lbl_4c_TxtCli.Width    = 255
1064:                         .lbl_4c_TxtCli.AutoSize = .T.
1065:                         .Visible = .T.
1066:                         .ZOrder()
1067:                     ENDIF
1068:                     IF !EMPTY(loc_lcTran)
1069:                         .lbl_4c_TxtTpTrans.Caption  = loc_lcTran
1070:                         .lbl_4c_TxtTpTrans.Width    = 195
1071:                         .lbl_4c_TxtTpTrans.AutoSize = .T.
1072:                         .Visible = .T.
1073:                         .ZOrder()
1074:                     ENDIF
1075:                 ENDIF
1076:             ENDWITH

*-- Linhas 1171 a 1181:
1171: 
1172:                     loc_lPrimeira = .F.
1173:                     WITH THIS.cnt_4c_TefTxt
1174:                         .lbl_4c_TxtOper.Caption    = ""
1175:                         .lbl_4c_TxtCli.Caption     = ""
1176:                         .lbl_4c_TxtTpTrans.Caption = ""
1177:                         .Visible = .F.
1178:                     ENDWITH
1179: 
1180:                     IF loc_lRetCVinc
1181:                         loc_lcCancTef = ""

*-- Linhas 1422 a 1454:
1422:         IF VARTYPE(THIS.txt_4c_Redetef) = "O"
1423:             THIS.txt_4c_Redetef.Enabled = loc_lHab
1424:         ENDIF
1425:         IF VARTYPE(THIS.cmd_4c_TefAdm) = "O"
1426:             THIS.cmd_4c_TefAdm.Enabled = loc_lHab AND THIS.this_oBusinessObject.this_lInicializado
1427:         ENDIF
1428:         IF VARTYPE(THIS.cmd_4c_TefAtv) = "O"
1429:             THIS.cmd_4c_TefAtv.Enabled = loc_lHab AND THIS.this_oBusinessObject.this_lInicializado
1430:         ENDIF
1431:     ENDPROC
1432: 
1433:     *==========================================================================
1434:     PROCEDURE LimparCampos
1435:     *==========================================================================
1436:         IF VARTYPE(THIS.txt_4c_Redetef) = "O"
1437:             THIS.txt_4c_Redetef.Value = ""
1438:             THIS.txt_4c_Redetef.Refresh()
1439:         ENDIF
1440:         IF VARTYPE(THIS.cnt_4c_TefTxt) = "O"
1441:             WITH THIS.cnt_4c_TefTxt
1442:                 IF VARTYPE(.lbl_4c_TxtOper) = "O"
1443:                     .lbl_4c_TxtOper.Caption = ""
1444:                 ENDIF
1445:                 IF VARTYPE(.lbl_4c_TxtCli) = "O"
1446:                     .lbl_4c_TxtCli.Caption = ""
1447:                 ENDIF
1448:                 IF VARTYPE(.lbl_4c_TxtTpTrans) = "O"
1449:                     .lbl_4c_TxtTpTrans.Caption = ""
1450:                 ENDIF
1451:                 .Visible = .F.
1452:             ENDWITH
1453:         ENDIF
1454:         IF USED("CrTefImp")


### BO (C:\4c\projeto\app\classes\sigprtefBO.prg):
*==============================================================================
* sigprtefBO.prg - Business Object para Administracao do TEF
* Fase 1/8 - Propriedades e Init
*==============================================================================
DEFINE CLASS sigprtefBO AS BusinessBase

    *-- Identificacao da operacao TEF
    this_cOperacao      = ""    && Operacao TEF atual (PADR NoCaixa+NoFab+'ADM', 20 chars)
    this_cNoCaixa       = ""    && Numero do caixa fiscal (crSigFiMpf.cnCaixas)
    this_cNoFab         = ""    && Numero de fabricacao da impressora fiscal (LeituraFab)
    this_cPcIdChaves    = ""    && Chaves de identificacao da transacao TEF (param Init)

    *-- Parametros do sistema TEF carregados de SigCdPam
    this_nSistef        = 0     && Tipo sistema TEF: 1=SiTef/Autoritec, 3=VeriFone
    this_cImps          = ""    && Modelo impressora fiscal (ex: SWEDA) de crSigFiFis

    *-- Campo de busca / validacao TEF
    this_cRedeTef       = ""    && Comprovante / rede TEF selecionada (Get_redetef)

    *-- Flags de controle de acesso e estado
    this_lAcessoAdm     = .F.   && Acesso habilitado para operacao Admin TEF
    this_lAcessoAtv     = .F.   && Acesso habilitado para verificacao TEF Ativo
    this_lInicializado  = .F.   && Inicializacao concluida com sucesso (impressora OK)

    PROCEDURE Init()
        this_cTabela     = ""
        this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir do cursor coSigCdPam
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                this_nSistef = NVL(Sistef, 0)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador da operacao TEF corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN this_cOperacao
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel para form OPERACIONAL TEF
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para form OPERACIONAL TEF (usar AtualizarStatusTef)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao TEF em LogAuditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, UsuarioID, DataHora, ChavePrimaria) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigFiTef") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosTEF - Carrega Sistef de SigCdPam e popula this_nSistef
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosTEF()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("coSigCdPam")
                USE IN coSigCdPam
            ENDIF
            loc_cSQL = "SELECT Sistef FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "coSigCdPam") > 0
                SELECT coSigCdPam
                GOTO TOP
                IF !EOF()
                    this_nSistef = NVL(Sistef, 0)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao carregar par" + CHR(226) + "metros TEF de SigCdPam", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarImpressoraFiscal - Carrega SigFiMpF pelo numero de fabricacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarImpressoraFiscal(par_cNoFab)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("crSigFiMpF")
                USE IN crSigFiMpF
            ENDIF
            loc_cSQL = "SELECT cnCaixas FROM SigFiMpF"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiMpF") > 0
                SELECT crSigFiMpF
                GOTO TOP
                IF !EOF()
                    this_cNoCaixa = NVL(cnCaixas, "")
                    this_cNoFab   = ALLTRIM(par_cNoFab)
                    loc_lSucesso  = .T.
                ELSE
                    MsgAviso("Impressora Fiscal Inv" + CHR(225) + "lida para esta Loja !!", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarComprovantes - Busca comprovantes TEF em SigFiNfs por modelo impressora
    *--------------------------------------------------------------------------
    PROCEDURE BuscarComprovantes(par_cImps)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("CrSigFiNfs")
                USE IN CrSigFiNfs
            ENDIF
            loc_cSQL = "SELECT * FROM SigFiNfs WHERE Imps = " + EscaparSQL(ALLTRIM(par_cImps))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigFiNfs") > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha na Conex" + CHR(227) + "o ao buscar comprovantes TEF", "Falha na Conex" + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarNFiscalPorComprovante - Busca SigFiNfs por Imps e cComprovs
    *--------------------------------------------------------------------------
    PROCEDURE BuscarNFiscalPorComprovante(par_cImps, par_cComprovs)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("crTmpNFis")
                USE IN crTmpNFis
            ENDIF
            loc_cSQL = "SELECT Imps, cComprovs, cTefdReqs, cTefdResps, nQtdVias " + ;
                       "FROM SigFiNfs " + ;
                       "WHERE Imps = " + EscaparSQL(ALLTRIM(par_cImps)) + ;
                       " AND cComprovs = " + EscaparSQL(ALLTRIM(par_cComprovs))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpNFis") > 0
                SELECT crTmpNFis
                GOTO TOP
                loc_lSucesso = !EOF()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTransacaoTEF - Busca SigFiTef pelos campos chave (tipo/empresa/operacao/ident)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTransacaoTEF(par_cTipo, par_cEmps, par_cDopes, par_cIdents)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("crSigFiTef")
                USE IN crSigFiTef
            ENDIF
            loc_cSQL = "SELECT cTipos, cEmps, cDopes, cnIdents, cNmRedes, cnNSUs, " + ;
                       "cFinalzs, cCupomnvs, FPags, cnNSUCancs, cnValors, " + ;
                       "cTxtOpers, cTxtClis, cIdChaves, cStatus, cHeaders, cnCupoms " + ;
                       "FROM SigFiTef " + ;
                       "WHERE cnIdents = " + EscaparSQL(par_cIdents)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiTef") > 0
                SELECT crSigFiTef
                GOTO TOP
                loc_lSucesso = !EOF()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTransacaoPorIdChaves - Busca SigFiTef por cIdChaves
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTransacaoPorIdChaves(par_cIdChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("csSigFiTef")
                USE IN csSigFiTef
            ENDIF
            loc_cSQL = "SELECT cTipos, cEmps, cDopes, cnIdents, cNmRedes, cnNSUs, " + ;
                       "cFinalzs, cCupomnvs, FPags, cnNSUCancs, cnValors, " + ;
                       "cTxtOpers, cTxtClis, cIdChaves, cStatus, cHeaders, cnCupoms " + ;
                       "FROM SigFiTef " + ;
                       "WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "csSigFiTef") > 0
                SELECT csSigFiTef
                GOTO TOP
                loc_lSucesso = !EOF()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarStatusTef - UPDATE SigFiTef SET cStatus por cIdChaves
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarStatusTef(par_cIdChaves, par_cStatus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigFiTef SET cStatus = " + EscaparSQL(par_cStatus) + ;
                       " WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar status TEF por cIdChaves", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarStatusTefPorRede - UPDATE SigFiTef SET cStatus por cnmredes/cnnsus (CRT)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarStatusTefPorRede(par_cNmRedes, par_cNSUs, par_cStatus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigFiTef SET cStatus = " + EscaparSQL(par_cStatus) + ;
                       " WHERE cnmredes = " + EscaparSQL(par_cNmRedes) + ;
                       " AND cnnsus = " + EscaparSQL(par_cNSUs) + ;
                       " AND cHeaders = 'CRT'"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar status TEF por rede", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarStatusTefPorIdents - UPDATE SigFiTef SET cStatus por cnIdents
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarStatusTefPorIdents(par_cIdents, par_cStatus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigFiTef SET cStatus = " + EscaparSQL(par_cStatus) + ;
                       " WHERE cnIdents = " + EscaparSQL(par_cIdents)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar status TEF por cnIdents", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

