# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [LAYOUT-POSITION] Controle 'GetSenha' (parent: SIGPROER): Top original=103 vs migrado 'txt_4c_GetSenha' Top=21 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGPROER): Top original=108 vs migrado 'lbl_4c_Label3' Top=26 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'SENHA' (parent: SIGPROER): Top original=103 vs migrado 'txt_4c_GetSenha' Top=21 (diff=82px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigproer.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (993 linhas total):

*-- Linhas 91 a 100:
91:                     IF THIS.this_oBusinessObject.CarregarDadosEmpresa()
92:                         IF THIS.this_oBusinessObject.IniciarProtocolo()
93:                             THIS.ConfigurarPageFrame()
94:                             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
95:                             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
96:                             loc_lSucesso = .T.
97:                         ENDIF
98:                     ENDIF
99:                 ELSE
100:                     MsgAviso("Endere" + CHR(231) + "o do servidor SiTef n" + CHR(227) + "o informado.", ;

*-- Linhas 143 a 187:
143:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
144:         loc_oCab = THIS.cnt_4c_Cabecalho
145:         WITH loc_oCab
146:             .Top         = 1
147:             .Left        = 0
148:             .Width       = THIS.Width
149:             .Height      = 80
150:             .BackStyle   = 1
151:             .BackColor   = RGB(100, 100, 100)
152:             .BorderWidth = 0
153:             .Visible     = .T.
154:         ENDWITH
155:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
156:         WITH loc_oCab.lbl_4c_Sombra
157:             .AutoSize  = .F.
158:             .FontBold  = .T.
159:             .FontName  = "Tahoma"
160:             .FontSize  = 18
161:             .WordWrap  = .T.
162:             .BackStyle = 0
163:             .Caption   = "Reimpress" + CHR(227) + "o do SiTef"
164:             .Height    = 40
165:             .Left      = 10
166:             .Top       = 18
167:             .Width     = loc_oCab.Width
168:             .ForeColor = RGB(0, 0, 0)
169:             .Visible   = .T.
170:         ENDWITH
171:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
172:         WITH loc_oCab.lbl_4c_Titulo
173:             .AutoSize  = .F.
174:             .FontBold  = .T.
175:             .FontName  = "Tahoma"
176:             .FontSize  = 18
177:             .WordWrap  = .T.
178:             .BackStyle = 0
179:             .Caption   = "Reimpress" + CHR(227) + "o do SiTef"
180:             .Height    = 46
181:             .Left      = 10
182:             .Top       = 17
183:             .Width     = loc_oCab.Width
184:             .ForeColor = RGB(255, 255, 255)
185:             .Visible   = .T.
186:         ENDWITH
187:     ENDPROC

*-- Linhas 196 a 329:
196:         THIS.AddObject("cnt_4c_Area", "Container")
197:         loc_oArea = THIS.cnt_4c_Area
198:         WITH loc_oArea
199:             .Top         = 82
200:             .Left        = 0
201:             .Width       = THIS.Width - 90
202:             .Height      = THIS.Height - 82
203:             .BackStyle   = 0
204:             .BorderWidth = 0
205:             .Visible     = .T.
206:         ENDWITH
207: 
208:         *-- Shape visual ao redor da area de entrada (Shape1: Top=94 -> rel=12)
209:         loc_oArea.AddObject("shp_4c_Borda", "Shape")
210:         WITH loc_oArea.shp_4c_Borda
211:             .Top         = 12
212:             .Left        = 76
213:             .Width       = 247
214:             .Height      = 42
215:             .BackStyle   = 0
216:             .BorderColor = RGB(100, 100, 100)
217:             .Visible     = .T.
218:         ENDWITH
219: 
220:         *-- Label "Senha do Supervisor :" (Label3: Top=108 -> rel=26)
221:         loc_oArea.AddObject("lbl_4c_Label3", "Label")
222:         WITH loc_oArea.lbl_4c_Label3
223:             .AutoSize  = .F.
224:             .Top       = 26
225:             .Left      = 90
226:             .Width     = 108
227:             .Height    = 15
228:             .FontName  = "Tahoma"
229:             .FontSize  = 8
230:             .BackStyle = 0
231:             .ForeColor = RGB(90, 90, 90)
232:             .Caption   = "Senha do Supervisor :"
233:             .Visible   = .T.
234:         ENDWITH
235: 
236:         *-- TextBox GetSenha para leitura de cartao (Top=103 -> rel=21)
237:         *-- PasswordChar="*" oculta dados sensiveis do cartao
238:         loc_oArea.AddObject("txt_4c_GetSenha", "TextBox")
239:         WITH loc_oArea.txt_4c_GetSenha
240:             .Top          = 21
241:             .Left         = 214
242:             .Width        = 100
243:             .Height       = 23
244:             .FontName     = "Tahoma"
245:             .FontSize     = 8
246:             .Value        = ""
247:             .PasswordChar = "*"
248:             .Visible      = .T.
249:         ENDWITH
250:         BINDEVENT(loc_oArea.txt_4c_GetSenha, "GotFocus",  THIS, "TxtGetSenhaGotFocus")
251:         BINDEVENT(loc_oArea.txt_4c_GetSenha, "KeyPress", THIS, "TxtGetSenhaLostFocus")
252:         BINDEVENT(loc_oArea.txt_4c_GetSenha, "When",      THIS, "TxtGetSenhaWhen")
253: 
254:         *-- TextBox SENHA do supervisor - mesma posicao que GetSenha
255:         *-- Protocolo SiTef alterna foco via When (so foca quando o outro ja esta preenchido)
256:         loc_oArea.AddObject("txt_4c_Senha", "TextBox")
257:         WITH loc_oArea.txt_4c_Senha
258:             .Top          = 21
259:             .Left         = 214
260:             .Width        = 100
261:             .Height       = 23
262:             .FontName     = "Tahoma"
263:             .FontSize     = 8
264:             .Value        = ""
265:             .PasswordChar = "*"
266:             .Visible      = .T.
267:         ENDWITH
268:         BINDEVENT(loc_oArea.txt_4c_Senha, "GotFocus",  THIS, "TxtSenhaGotFocus")
269:         BINDEVENT(loc_oArea.txt_4c_Senha, "KeyPress", THIS, "TxtSenhaLostFocus")
270:         BINDEVENT(loc_oArea.txt_4c_Senha, "When",      THIS, "TxtSenhaWhen")
271: 
272:         *-- Container instrucao equivale ao Container1 (Top=141 -> rel=59, W=171, H=56)
273:         loc_oArea.AddObject("cnt_4c_Instrucao", "Container")
274:         WITH loc_oArea.cnt_4c_Instrucao
275:             .Top         = 59
276:             .Left        = 114
277:             .Width       = 171
278:             .Height      = 56
279:             .BackStyle   = 0
280:             .BorderWidth = 0
281:             .Visible     = .T.
282:         ENDWITH
283:         loc_oArea.cnt_4c_Instrucao.AddObject("lbl_4c_Instrucao", "Label")
284:         WITH loc_oArea.cnt_4c_Instrucao.lbl_4c_Instrucao
285:             .AutoSize  = .F.
286:             .Top       = 17
287:             .Left      = 9
288:             .Width     = 157
289:             .Height    = 25
290:             .FontName  = "Tahoma"
291:             .FontSize  = 10
292:             .FontBold  = .T.
293:             .Alignment = 2
294:             .BackStyle = 0
295:             .ForeColor = RGB(90, 90, 90)
296:             .WordWrap  = .T.
297:             .Caption   = "Insira ou Passe o Cart" + CHR(227) + "o"
298:             .Visible   = .T.
299:         ENDWITH
300:     ENDPROC
301: 
302:     *--------------------------------------------------------------------------
303:     * ConfigurarSaida - Botao Cancelar (equivale ao SAIDA CommandGroup do legado)
304:     *--------------------------------------------------------------------------
305:     PROTECTED PROCEDURE ConfigurarSaida()
306:         LOCAL loc_oSaida
307:         THIS.AddObject("cnt_4c_Saida", "Container")
308:         loc_oSaida = THIS.cnt_4c_Saida
309:         WITH loc_oSaida
310:             .Top         = 82
311:             .Left        = 917
312:             .Width       = 90
313:             .Height      = 85
314:             .BackStyle   = 0
315:             .BorderWidth = 0
316:             .Visible     = .T.
317:         ENDWITH
318:         loc_oSaida.AddObject("cmd_4c_Cancelar", "CommandButton")
319:         WITH loc_oSaida.cmd_4c_Cancelar
320:             .Top             = 5
321:             .Left            = 5
322:             .Width           = 75
323:             .Height          = 75
324:             .Caption         = "Encerrar"
325:             .FontName        = "Tahoma"
326:             .FontBold        = .T.
327:             .FontItalic      = .T.
328:             .FontSize        = 8
329:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 337 a 363:
337:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
338:             .Visible         = .T.
339:         ENDWITH
340:         BINDEVENT(loc_oSaida.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
341:     ENDPROC
342: 
343:     *--------------------------------------------------------------------------
344:     * TxtGetSenhaWhen - Permite foco em GetSenha apenas quando vazio
345:     * Equivale ao GetSenha.When: Return(EMPTY(This.Value)) do legado
346:     *--------------------------------------------------------------------------
347:     PROCEDURE TxtGetSenhaWhen()
348:         RETURN EMPTY(THIS.cnt_4c_Area.txt_4c_GetSenha.Value)
349:     ENDPROC
350: 
351:     *--------------------------------------------------------------------------
352:     * TxtGetSenhaGotFocus - Loop protocolo SiTef ate TipoCampo=500 (aguarda cartao)
353:     * Equivale ao GetSenha.GotFocus do legado (41 linhas)
354:     *--------------------------------------------------------------------------
355:     PROCEDURE TxtGetSenhaGotFocus()
356:         THIS.this_nProximoComando  = 0
357:         THIS.this_nTipoCampo       = 0
358:         THIS.this_nTamanhoMinimo   = 0
359:         THIS.this_nTamanhoMaximo   = 0
360:         THIS.this_cBuffer          = REPLICATE(CHR(0), 2000)
361:         THIS.this_nContinua        = 0
362:         THIS.this_cMensagem        = ""
363:         THIS.ExecutarLoopContinua(1)

*-- Linhas 370 a 394:
370:     *--------------------------------------------------------------------------
371:     PROCEDURE TxtGetSenhaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
372:         LOCAL loc_nRetorno, loc_cBuf, loc_cCupom, loc_lFalhou
373:         LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax
374: 
375:         IF EMPTY(THIS.cnt_4c_Area.txt_4c_GetSenha.Value)
376:             RETURN
377:         ENDIF
378: 
379:         loc_cBuf = ALLTRIM(THIS.cnt_4c_Area.txt_4c_GetSenha.Value)
380:         loc_cBuf = loc_cBuf + REPLICATE(CHR(0), 2000 - LEN(loc_cBuf))
381:         THIS.this_cBuffer   = loc_cBuf
382:         THIS.this_nContinua = 1000
383:         THIS.this_cMensagem = ""
384:         loc_cCupom          = ""
385:         loc_lFalhou         = .F.
386: 
387:         loc_nCmd  = THIS.this_nProximoComando
388:         loc_nTipo = THIS.this_nTipoCampo
389:         loc_nMin  = THIS.this_nTamanhoMinimo
390:         loc_nMax  = THIS.this_nTamanhoMaximo
391:         loc_cBuf  = THIS.this_cBuffer
392: 
393:         loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nCmd, @loc_nTipo, @loc_nMin, ;
394:             @loc_nMax, @loc_cBuf, LEN(loc_cBuf), THIS.this_nContinua)

*-- Linhas 466 a 474:
466:     * Equivale ao SENHA.GotFocus do legado (42 linhas)
467:     *--------------------------------------------------------------------------
468:     PROCEDURE TxtSenhaGotFocus()
469:         THIS.cnt_4c_Area.cnt_4c_Instrucao.lbl_4c_Instrucao.Caption = ;
470:             "Digite a Senha" + CHR(13) + "do Supervisor"
471: 
472:         THIS.this_nProximoComando  = 0
473:         THIS.this_nTipoCampo       = 0
474:         THIS.this_nTamanhoMinimo   = 0

*-- Linhas 678 a 746:
678:             THIS.this_cBuffer         = REPLICATE(CHR(0), 2000)
679:             THIS.this_nContinua       = 0
680:             THIS.this_cMensagem       = ""
681:             THIS.this_lIdent          = .F.
682: 
683:             THIS.cnt_4c_Area.txt_4c_GetSenha.Value = ""
684:             THIS.cnt_4c_Area.txt_4c_Senha.Value    = ""
685: 
686:             THIS.AlternarPagina(1)
687: 
688:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
689:                 THIS.this_oBusinessObject.IniciarProtocolo()
690:             ENDIF
691: 
692:             THIS.cnt_4c_Area.txt_4c_GetSenha.SetFocus()
693:         CATCH TO loc_oErro
694:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
695:                     " PROC=" + loc_oErro.Procedure, "Erro")
696:         ENDTRY
697:     ENDPROC
698: 
699:     *--------------------------------------------------------------------------
700:     * BtnAlterarClick - Reenvia senha do supervisor (equivalente F3/Editar)
701:     * Limpa apenas o campo de senha e retorna o foco para nova digitacao,
702:     * mantendo o estado do protocolo SiTef ate o comando 30/senha.
703:     *--------------------------------------------------------------------------
704:     PROCEDURE BtnAlterarClick()
705:         LOCAL loc_oErro
706:         TRY
707:             IF EMPTY(THIS.cnt_4c_Area.txt_4c_GetSenha.Value)
708:                 MsgAviso("Passe o cart" + CHR(227) + "o antes de reenviar a senha.", ;
709:                         "Reimpress" + CHR(227) + "o SiTef")
710:                 THIS.cnt_4c_Area.txt_4c_GetSenha.SetFocus()
711:             ELSE
712:                 THIS.cnt_4c_Area.txt_4c_Senha.Value = ""
713:                 THIS.AlternarPagina(2)
714:                 THIS.cnt_4c_Area.txt_4c_Senha.SetFocus()
715:             ENDIF
716:         CATCH TO loc_oErro
717:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
718:                     " PROC=" + loc_oErro.Procedure, "Erro")
719:         ENDTRY
720:     ENDPROC
721: 
722:     *--------------------------------------------------------------------------
723:     * BtnVisualizarClick - Direciona o usuario para o inicio do fluxo de
724:     * reimpressao (equivalente F5/Visualizar). Foca o campo de leitura do
725:     * cartao e apresenta a instrucao "Insira ou Passe o Cartao".
726:     *--------------------------------------------------------------------------
727:     PROCEDURE BtnVisualizarClick()
728:         LOCAL loc_oErro
729:         TRY
730:             THIS.AlternarPagina(1)
731:             THIS.cnt_4c_Area.txt_4c_GetSenha.SetFocus()
732:         CATCH TO loc_oErro
733:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
734:                     " PROC=" + loc_oErro.Procedure, "Erro")
735:         ENDTRY
736:     ENDPROC
737: 
738:     *--------------------------------------------------------------------------
739:     * BtnExcluirClick - Cancela a operacao SiTef em andamento (equivalente
740:     * F4/Excluir). Delega ao mesmo fluxo do botao Cancelar apos confirmacao.
741:     *--------------------------------------------------------------------------
742:     PROCEDURE BtnExcluirClick()
743:         LOCAL loc_lConfirma, loc_oErro
744:         TRY
745:             loc_lConfirma = MsgConfirma("Cancelar a opera" + CHR(231) + CHR(227) + "o SiTef em andamento?", ;
746:                                        "Confirma" + CHR(231) + CHR(227) + "o")

*-- Linhas 771 a 783:
771:     *--------------------------------------------------------------------------
772:     PROCEDURE AlternarPagina(par_nModo)
773:         LOCAL loc_oLabel
774:         loc_oLabel = THIS.cnt_4c_Area.cnt_4c_Instrucao.lbl_4c_Instrucao
775:         IF par_nModo = 2
776:             loc_oLabel.Caption = "Digite a Senha" + CHR(13) + "do Supervisor"
777:         ELSE
778:             loc_oLabel.Caption = "Insira ou Passe o Cart" + CHR(227) + "o"
779:         ENDIF
780:     ENDPROC
781: 
782:     *--------------------------------------------------------------------------
783:     * ConfigurarPaginaLista - Compatibilidade com pipeline (dialogo sem lista/grid)

*-- Linhas 828 a 837:
828:         LOCAL loc_oErro
829:         TRY
830:             IF VARTYPE(THIS.cnt_4c_Saida) = "O"
831:                 IF PEMSTATUS(THIS.cnt_4c_Saida, "cmd_4c_Cancelar", 5)
832:                     THIS.cnt_4c_Saida.cmd_4c_Cancelar.Enabled = .T.
833:                 ENDIF
834:             ENDIF
835:         CATCH TO loc_oErro
836:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
837:                     " PROC=" + loc_oErro.Procedure, "Erro")

*-- Linhas 845 a 886:
845:     PROCEDURE HabilitarCampos(par_lHabilitar)
846:         LOCAL loc_lHabilitar, loc_oErro
847:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
848:         TRY
849:             IF VARTYPE(THIS.cnt_4c_Area) = "O"
850:                 IF PEMSTATUS(THIS.cnt_4c_Area, "txt_4c_GetSenha", 5)
851:                     THIS.cnt_4c_Area.txt_4c_GetSenha.Enabled = loc_lHabilitar
852:                 ENDIF
853:                 IF PEMSTATUS(THIS.cnt_4c_Area, "txt_4c_Senha", 5)
854:                     THIS.cnt_4c_Area.txt_4c_Senha.Enabled = loc_lHabilitar
855:                 ENDIF
856:             ENDIF
857:         CATCH TO loc_oErro
858:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
859:                     " PROC=" + loc_oErro.Procedure, "Erro")
860:         ENDTRY
861:     ENDPROC
862: 
863:     *--------------------------------------------------------------------------
864:     * LimparCampos - Limpa os campos de entrada do dialogo SiTef
865:     *--------------------------------------------------------------------------
866:     PROCEDURE LimparCampos()
867:         LOCAL loc_oErro
868:         TRY
869:             IF VARTYPE(THIS.cnt_4c_Area) = "O"
870:                 IF PEMSTATUS(THIS.cnt_4c_Area, "txt_4c_GetSenha", 5)
871:                     THIS.cnt_4c_Area.txt_4c_GetSenha.Value = ""
872:                 ENDIF
873:                 IF PEMSTATUS(THIS.cnt_4c_Area, "txt_4c_Senha", 5)
874:                     THIS.cnt_4c_Area.txt_4c_Senha.Value = ""
875:                 ENDIF
876:             ENDIF
877:         CATCH TO loc_oErro
878:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
879:                     " PROC=" + loc_oErro.Procedure, "Erro")
880:         ENDTRY
881:     ENDPROC
882: 
883:     *--------------------------------------------------------------------------
884:     * FormParaBO - Atualiza BO com estado corrente do form
885:     *--------------------------------------------------------------------------
886:     PROCEDURE FormParaBO()

*-- Linhas 940 a 960:
940:     *--------------------------------------------------------------------------
941:     PROCEDURE BtnBuscarClick()
942:         LOCAL loc_oErro
943:         TRY
944:             THIS.AlternarPagina(1)
945:             THIS.cnt_4c_Area.txt_4c_GetSenha.SetFocus()
946:         CATCH TO loc_oErro
947:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
948:                     " PROC=" + loc_oErro.Procedure, "Erro")
949:         ENDTRY
950:     ENDPROC
951: 
952:     *--------------------------------------------------------------------------
953:     * BtnEncerrarClick - Cancela operacao e encerra o dialogo SiTef com confirmacao
954:     *--------------------------------------------------------------------------
955:     PROCEDURE BtnEncerrarClick()
956:         LOCAL loc_lConfirma, loc_oErro
957:         TRY
958:             loc_lConfirma = MsgConfirma("Encerrar a reimpress" + CHR(227) + "o SiTef?", ;
959:                                        "Confirma" + CHR(231) + CHR(227) + "o")
960:             IF loc_lConfirma

*-- Linhas 976 a 993:
976:         LOCAL loc_oErro
977:         TRY
978:             IF !EMPTY(THIS.cnt_4c_Area.txt_4c_Senha.Value)
979:                 THIS.TxtSenhaLostFocus()
980:             ELSE
981:                 IF !EMPTY(THIS.cnt_4c_Area.txt_4c_GetSenha.Value)
982:                 THIS.TxtGetSenhaLostFocus()
983:             ELSE
984:                 THIS.cnt_4c_Area.txt_4c_GetSenha.SetFocus()
985:                 ENDIF
986:             ENDIF
987:         CATCH TO loc_oErro
988:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
989:                     " PROC=" + loc_oErro.Procedure, "Erro")
990:         ENDTRY
991:     ENDPROC
992: 
993: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigproerBO.prg):
*==============================================================================
* sigproerBO.prg - Business Object para Reimpressao SiTef
* Form original: SIGPROER.SCX
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS sigproerBO AS BusinessBase

    *-- Parametros recebidos na abertura do form
    this_cEndSitef   = ""   && Endereco servidor SiTef
    this_cCaixa      = ""   && Identificador do caixa
    this_cNSU        = ""   && Numero Sequencial Unico
    this_cData       = ""   && Data da transacao original
    this_cHora       = ""   && Hora da transacao original
    this_cValor      = ""   && Valor da transacao (string formatada para DLL)
    this_cCodEstabs  = ""   && Codigo do estabelecimento

    *-- Dados da empresa carregados de SigCdEmp
    this_cEmpresa    = ""   && Cemps char(3)
    this_cIdTerminal = ""   && Identificador do terminal composto (Empresa+Caixa)

    *-- Estado do protocolo SiTef (equivalente as PUBLICs do legado)
    this_nProximoComando = 0    && ProximoComando
    this_nTipoCampo      = 0    && TipoCampo
    this_nTamanhoMinimo  = 0    && TamanhoMinimo
    this_nTamanhoMaximo  = 0    && TamanhoMaximo
    this_cBuffer         = ""   && Buffer 2000 bytes (preenchido com Chr(0))
    this_nContinua       = 0    && lnContinua (flag de continuacao da DLL)
    this_lIdentificado   = .F.  && ltIdent

    *-- Acumula linhas do cupom durante protocolo (tipos 121/122)
    this_cCupom      = ""

    *-- Ultima mensagem recebida do SiTef (tipo <> 30)
    this_cMensagem   = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave composta: NSU + Caixa + Data
    * (SIGPROER nao persiste entidade CRUD; chave usada apenas para auditoria)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cNSU) + "|" + ;
                     ALLTRIM(THIS.this_cCaixa) + "|" + ;
                     ALLTRIM(THIS.this_cData)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida parametros recebidos antes do protocolo SiTef
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.
        IF EMPTY(THIS.this_cEndSitef)
            MsgAviso("Endere" + CHR(231) + "o do servidor SiTef n" + CHR(227) + "o informado.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND EMPTY(THIS.this_cCaixa)
            MsgAviso("Identificador do caixa n" + CHR(227) + "o informado.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Restaura estado do BO a partir de cursor de parametros
    * (SIGPROER nao tem tabela persistente; este metodo hidrata os parametros
    *  quando recebidos via cursor em vez de parametros diretos do Init)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                loc_lSucesso = .F.
            ENDIF
            SELECT (par_cAliasCursor)
            IF RECCOUNT(par_cAliasCursor) = 0
                loc_lSucesso = .F.
            ENDIF
            *-- Mapeia colunas do cursor para propriedades
            IF TYPE(par_cAliasCursor + ".EndSitef") != "U"
                THIS.this_cEndSitef = ALLTRIM(NVL(EndSitef, ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".Caixa") != "U"
                THIS.this_cCaixa = ALLTRIM(NVL(Caixa, ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".NSU") != "U"
                THIS.this_cNSU = ALLTRIM(NVL(NSU, ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".Data") != "U"
                THIS.this_cData = ALLTRIM(NVL(Data, ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".Hora") != "U"
                THIS.this_cHora = ALLTRIM(NVL(Hora, ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".Valor") != "U"
                THIS.this_cValor = ALLTRIM(NVL(Valor, ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".CodEstabs") != "U"
                THIS.this_cCodEstabs = ALLTRIM(NVL(CodEstabs, ""))
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Executa reimpressao via protocolo SiTef
    * Em SIGPROER, "inserir" significa executar o ciclo completo de reimpressao
    * (SIGPROER nao grava em tabela do banco; a "persistencia" sao os arquivos
    *  IntPos.001 e IntPos.STS gravados por MontaRetorno/RetornoFalha)
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.CarregarDadosEmpresa()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.IniciarProtocolo()
                loc_lSucesso = .F.
            ENDIF
            *-- Auditoria da operacao de reimpressao
            THIS.RegistrarAuditoria("REIMPRESSAO")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa reimpressao (executa nova tentativa do ciclo SiTef)
    * (SIGPROER nao possui entidade persistente para atualizar; reaproveita
    *  o ciclo de Inserir com registro de auditoria diferente)
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.CarregarDadosEmpresa()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.IniciarProtocolo()
                loc_lSucesso = .F.
            ENDIF
            THIS.RegistrarAuditoria("REPROCESSAMENTO")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava operacao de reimpressao SiTef em LogAuditoria
    *--------------------------------------------------------------------------
    FUNCTION RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_cEmpresa, loc_oErro
        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF
            loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)
            IF EMPTY(loc_cEmpresa) AND TYPE("go_4c_Sistema") = "O"
                loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Empresa, Tabela, ChavePrimaria, Operacao, Detalhes) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(LEFT(loc_cUsuario, 20)) + ", " + ;
                       EscaparSQL(LEFT(loc_cEmpresa, 3)) + ", " + ;
                       EscaparSQL("SIGPROER") + ", " + ;
                       EscaparSQL(LEFT(loc_cChave, 50)) + ", " + ;
                       EscaparSQL(LEFT(par_cOperacao, 20)) + ", " + ;
                       EscaparSQL(LEFT("NSU=" + ALLTRIM(THIS.this_cNSU) + ;
                                       " Caixa=" + ALLTRIM(THIS.this_cCaixa) + ;
                                       " Data=" + ALLTRIM(THIS.this_cData), 200)) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Auditoria nao pode bloquear operacao principal; apenas registra erro
            IF TYPE("loc_oErro") = "O"
                MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Auditoria")
            ENDIF
        ENDTRY
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION CarregarDadosEmpresa()
        *-- Carrega codigo empresa de SigCdEmp e monta IdTerminal
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT Cemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0 AND ;
               USED("cursor_4c_Emp") AND RECCOUNT("cursor_4c_Emp") > 0
                SELECT cursor_4c_Emp
                THIS.this_cEmpresa = ALLTRIM(NVL(Cemps, ""))
            ELSE
                THIS.this_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF
            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF
            *-- ID loja: pcCodEstabs se informado, senao "00000" + empresa
            IF EMPTY(THIS.this_cCodEstabs)
                THIS.this_cIdTerminal = "00000" + THIS.this_cEmpresa
            ELSE
                THIS.this_cIdTerminal = THIS.this_cCodEstabs
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION IniciarProtocolo()
        *-- Chama ConfiguraIntSiTefInterativo e IniciaFuncaoSiTefInterativo
        LOCAL loc_lSucesso, loc_cValores, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- ID terminal = empresa + caixa (6 digitos)
            LOCAL loc_cIdTerminal
            loc_cIdTerminal = ALLTRIM(THIS.this_cEmpresa) + ;
                              TRANSFORM(VAL(THIS.this_cCaixa), "@L 999999")

            IF ConfiguraIntSiTefInterativo(THIS.this_cEndSitef, THIS.this_cIdTerminal, loc_cIdTerminal, 0) <> 0
                THIS.RetornoFalha("Sem comunicacao com SiTef")
                loc_lSucesso = .F.
            ENDIF
            IF !EMPTY(THIS.this_cValor)
                loc_cValores = STRTRAN(ALLTRIM(TRANSFORM(VAL(THIS.this_cValor), "999999999999.99")), ".", ",")
            ELSE
                loc_cValores = ""
            ENDIF
            IF IniciaFuncaoSiTefInterativo(IIF(EMPTY(THIS.this_cData), 114, 113), loc_cValores, "1", "", "", "", "") <> 10000
                THIS.RetornoFalha("Sem comunicacao com SiTef")
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ExecutarCicloSiTef()
        *-- Loop ContinuaFuncaoSiTefInterativo ate TipoCampo=500 (aguarda cartao/senha)
        *-- Retorna o ultimo lnRetorno da DLL (0=ok, <0=falha, 10000=continua)
        LOCAL loc_nProxCmd, loc_nTipoCampo, loc_nTamMin, loc_nTamMax
        LOCAL loc_cBuffer, loc_nContinua, loc_nRetorno, loc_nTipo

        loc_nTipo      = 1
        loc_nProxCmd   = 0
        loc_nTipoCampo = 0
        loc_nTamMin    = 0
        loc_nTamMax    = 0
        loc_cBuffer    = REPLICATE(CHR(0), 2000)
        loc_nContinua  = 0
        loc_nRetorno   = 0
        THIS.this_cMensagem = ""

        DO WHILE loc_nTipoCampo <> 500
            loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                @loc_nProxCmd, @loc_nTipoCampo, @loc_nTamMin, @loc_nTamMax, ;
                @loc_cBuffer, LEN(loc_cBuffer), loc_nContinua)

            THIS.this_nProximoComando = loc_nProxCmd
            THIS.this_nTipoCampo      = loc_nTipoCampo
            THIS.this_nTamanhoMinimo  = loc_nTamMin
            THIS.this_nTamanhoMaximo  = loc_nTamMax
            THIS.this_cBuffer         = loc_cBuffer

            IF loc_nRetorno < 0
                THIS.this_cMensagem = loc_cBuffer
                RETURN loc_nRetorno
            ENDIF

            IF loc_nProxCmd = 30 AND !EMPTY(THIS.this_cNSU)
                IF loc_nTipo = 1
                    loc_cBuffer = TRANSFORM(VAL(THIS.this_cNSU), "@L 999999999")
                    loc_cBuffer = loc_cBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_cBuffer))
                    loc_nContinua = 1000
                    loc_nTipo = 2
                    LOOP
                ENDIF
                IF loc_nTipo = 2
                    loc_cBuffer = THIS.this_cData + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cData))
                    loc_nContinua = 1000
                    loc_nTipo = 3
                    LOOP
                ENDIF
            ENDIF

            IF loc_nProxCmd <> 30
                THIS.this_cMensagem = loc_cBuffer
                loc_cBuffer   = REPLICATE(CHR(0), 2000)
                loc_nContinua = 0
            ENDIF
        ENDDO

        RETURN loc_nRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ProcessarRespostaGetSenha(par_cValor)
        *-- Processa resposta apos leitura do cartao (equivale a GetSenha.LostFocus)
        LOCAL loc_nProxCmd, loc_nTipoCampo, loc_nTamMin, loc_nTamMax
        LOCAL loc_cBuffer, loc_nContinua, loc_nRetorno, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cCupom    = ""
            THIS.this_cMensagem = ""
            loc_cBuffer   = ALLTRIM(par_cValor) + REPLICATE(CHR(0), 2000 - LEN(ALLTRIM(par_cValor)))
            loc_nContinua = 1000
            loc_nProxCmd  = THIS.this_nProximoComando
            loc_nTipoCampo = THIS.this_nTipoCampo
            loc_nTamMin   = THIS.this_nTamanhoMinimo
            loc_nTamMax   = THIS.this_nTamanhoMaximo

            loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                @loc_nProxCmd, @loc_nTipoCampo, @loc_nTamMin, @loc_nTamMax, ;
                @loc_cBuffer, LEN(loc_cBuffer), loc_nContinua)
            loc_nContinua = 0

            DO WHILE loc_nRetorno = 10000
                loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                    @loc_nProxCmd, @loc_nTipoCampo, @loc_nTamMin, @loc_nTamMax, ;
                    @loc_cBuffer, LEN(loc_cBuffer), loc_nContinua)

                IF loc_nRetorno < 0
                    THIS.RetornoFalha(THIS.this_cMensagem)
                    loc_lSucesso = .F.
                ENDIF
                IF UPPER(ALLTRIM(loc_cBuffer)) = "DOC INEXISTENTE"
                    THIS.RetornoFalha("DOC INEXISTENTE")
                    loc_lSucesso = .F.
                ENDIF
                IF loc_nTipoCampo = 121 AND EMPTY(THIS.this_cCupom)
                    THIS.this_cCupom = loc_cBuffer + loc_cBuffer
                ENDIF
                IF loc_nTipoCampo = 122
                    THIS.this_cCupom = THIS.this_cCupom + loc_cBuffer
                ENDIF
                IF loc_nProxCmd = 20
                    loc_cBuffer   = "0" + REPLICATE(CHR(0), 1999)
                    loc_nContinua = 1000
                    LOOP
                ELSE
                    THIS.this_cMensagem = loc_cBuffer
                    loc_cBuffer   = REPLICATE(CHR(0), 2000)
                    loc_nContinua = 0
                ENDIF
            ENDDO

            IF loc_nRetorno = 0
                THIS.MontaRetorno(THIS.this_cCupom)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ProcessarRespostaSenha(par_cValor)
        *-- Processa resposta apos digitacao da senha (equivale a SENHA.LostFocus)
        LOCAL loc_nProxCmd, loc_nTipoCampo, loc_nTamMin, loc_nTamMax
        LOCAL loc_cBuffer, loc_nContinua, loc_nRetorno, loc_lSucesso, loc_lVias, loc_oErro
        loc_lSucesso = .F.
        loc_lVias    = .F.
        TRY
            THIS.this_cCupom    = ""
            THIS.this_cMensagem = ""
            loc_cBuffer   = ALLTRIM(par_cValor) + REPLICATE(CHR(0), 2000 - LEN(ALLTRIM(par_cValor)))
            loc_nContinua = 1000
            loc_nProxCmd  = THIS.this_nProximoComando
            loc_nTipoCampo = THIS.this_nTipoCampo
            loc_nTamMin   = THIS.this_nTamanhoMinimo
            loc_nTamMax   = THIS.this_nTamanhoMaximo

            loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                @loc_nProxCmd, @loc_nTipoCampo, @loc_nTamMin, @loc_nTamMax, ;
                @loc_cBuffer, LEN(loc_cBuffer), loc_nContinua)
            loc_nContinua = 0

            DO WHILE loc_nRetorno = 10000
                loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                    @loc_nProxCmd, @loc_nTipoCampo, @loc_nTamMin, @loc_nTamMax, ;
                    @loc_cBuffer, LEN(loc_cBuffer), loc_nContinua)

                IF loc_nRetorno < 0
                    THIS.RetornoFalha(THIS.this_cMensagem)
                    loc_lSucesso = .F.
                ENDIF
                IF UPPER(ALLTRIM(loc_cBuffer)) = "DOC INEXISTENTE"
                    THIS.RetornoFalha("DOC INEXISTENTE")
                    loc_lSucesso = .F.
                ENDIF
                IF loc_nProxCmd = 30 AND loc_nTipoCampo = 515
                    loc_cBuffer = THIS.this_cData + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cData))
                    LOOP
                ENDIF
                IF loc_nProxCmd = 30 AND loc_nTipoCampo = 516
                    IF !EMPTY(THIS.this_cValor)
                        loc_cBuffer = TRANSFORM(VAL(THIS.this_cNSU), "@L 999999")
                    ELSE
                        loc_cBuffer = TRANSFORM(VAL(THIS.this_cNSU), "@L 999999999")
                    ENDIF
                    loc_cBuffer = loc_cBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_cBuffer))
                    LOOP
                ENDIF
                IF loc_nTipoCampo = 121 AND EMPTY(THIS.this_cCupom)
                    THIS.this_cCupom = loc_cBuffer + loc_cBuffer
                ENDIF
                IF loc_nTipoCampo = 122
                    THIS.this_cCupom = THIS.this_cCupom + loc_cBuffer
                ENDIF
                IF loc_lVias
                    loc_cBuffer   = "3" + REPLICATE(CHR(0), 1999)
                    loc_lVias     = .F.
                    LOOP
                ENDIF
                IF UPPER(ALLTRIM(loc_cBuffer)) = "VIA A SER REIMPRESSA"
                    loc_lVias = .T.
                ENDIF
                IF loc_nProxCmd = 20
                    loc_cBuffer   = "0" + REPLICATE(CHR(0), 1999)
                    loc_nContinua = 1000
                    LOOP
                ELSE
                    THIS.this_cMensagem = loc_cBuffer
                    loc_cBuffer   = REPLICATE(CHR(0), 2000)
                    loc_nContinua = 0
                ENDIF
            ENDDO

            IF loc_nRetorno = 0
                THIS.MontaRetorno(THIS.this_cCupom)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION MontaRetorno(par_cCupom)
        *-- Grava arquivos IntPos.001 e IntPos.STS com resposta de sucesso
        LOCAL loc_cCupom, loc_lPos, loc_nLinha, loc_oErro
        TRY
            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (tef c(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("011-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + ALLTRIM(THIS.this_cNSU))
            INSERT INTO crSiTef (Tef) VALUES ("013-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("015-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("022-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("027-000 = ")

            loc_cCupom  = par_cCupom
            loc_lPos    = 1
            loc_nLinha  = 1
            DO WHILE loc_lPos <> 0
                loc_lPos = AT(CHR(10), loc_cCupom)
                INSERT INTO crSiTef (Tef) VALUES ("029-" + TRANSFORM(loc_nLinha, "@L 999") + ;
                    " = " + IIF(loc_lPos <> 0, SUBSTR(loc_cCupom, 1, loc_lPos - 1), loc_cCupom))
                loc_cCupom = SUBSTR(loc_cCupom, loc_lPos + 1)
                loc_nLinha = loc_nLinha + 1
            ENDDO

            INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = Transacao OK")
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF
            USE IN crSiTef
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION RetornoFalha(par_cMensagem)
        *-- Grava arquivos IntPos.001 e IntPos.STS com resposta de falha
        LOCAL loc_oErro
        TRY
            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (tef c(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + par_cMensagem)
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF
            USE IN crSiTef
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

