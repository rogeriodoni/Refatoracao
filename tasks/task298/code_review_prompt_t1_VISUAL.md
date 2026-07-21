# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [FONTNAME-ERRADO] Linha 309: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRIBL.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1273 linhas total):

*-- Linhas 56 a 64:
56:         LOCAL loc_lSucesso, loc_oErro
57:         loc_lSucesso = .F.
58:         TRY
59:             THIS.Caption = "Impress" + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio"
60: 
61:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
62:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
63:             ENDIF
64: 

*-- Linhas 81 a 130:
81:     PROTECTED PROCEDURE ConfigurarCabecalho()
82:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
83:         WITH THIS.cnt_4c_Cabecalho
84:             .Top        = 0
85:             .Left       = 0
86:             .Width      = 1020
87:             .Height     = 80
88:             .BorderWidth = 0
89:             .BackStyle  = 1
90:             .BackColor  = RGB(100, 100, 100)
91: 
92:             .AddObject("lbl_4c_LblSombra", "Label")
93:             WITH .lbl_4c_LblSombra
94:                 .AutoSize      = .F.
95:                 .Top           = 18
96:                 .Left          = 10
97:                 .Width         = THIS.Width
98:                 .Height        = 40
99:                 .FontBold      = .T.
100:                 .FontName      = "Tahoma"
101:                 .FontSize      = 18
102:                 .FontUnderline = .F.
103:                 .WordWrap      = .T.
104:                 .Alignment     = 0
105:                 .BackStyle     = 0
106:                 .ForeColor     = RGB(0, 0, 0)
107:                 .Caption       = "Impress" + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio"
108:             ENDWITH
109: 
110:             .AddObject("lbl_4c_LblTitulo", "Label")
111:             WITH .lbl_4c_LblTitulo
112:                 .AutoSize      = .F.
113:                 .Top           = 17
114:                 .Left          = 10
115:                 .Width         = THIS.Width
116:                 .Height        = 46
117:                 .FontBold      = .T.
118:                 .FontName      = "Tahoma"
119:                 .FontSize      = 18
120:                 .FontUnderline = .F.
121:                 .WordWrap      = .T.
122:                 .Alignment     = 0
123:                 .BackStyle     = 0
124:                 .ForeColor     = RGB(255, 255, 255)
125:                 .Caption       = "Impress" + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio"
126:             ENDWITH
127:         ENDWITH
128:     ENDPROC
129: 
130:     *--------------------------------------------------------------------------

*-- Linhas 143 a 151:
143:     * ConfigurarPaginaDados - Ponto de entrada canonico do pipeline (Fase 5)
144:     * Form OPERACIONAL: nao possui Page2 separada com campos de edicao.
145:     * Todos os controles (txt_4c_FPags, txt_4c_Locals, obj_4c_GetTxtCds,
146:     * lbl_4c_*, obj_4c_CmdGImprimir) ja foram criados em ConfigurarPageFrame().
147:     * Este metodo existe apenas por compatibilidade com o pipeline multi-fase.
148:     *--------------------------------------------------------------------------
149:     PROTECTED PROCEDURE ConfigurarPaginaDados()
150:         THIS.Refresh()
151:     ENDPROC

*-- Linhas 169 a 271:
169:     PROTECTED PROCEDURE ConfigurarPageFrame()
170:         LOCAL loc_oErro
171:         TRY
172:             *-- lbl_4c_Label2: Condicao de Pagamento
173:             THIS.AddObject("lbl_4c_Label2", "Label")
174:             WITH THIS.lbl_4c_Label2
175:                 .AutoSize   = .T.
176:                 .FontName   = "Tahoma"
177:                 .FontSize   = 8
178:                 .BackStyle  = 0
179:                 .Caption    = " Condi" + CHR(231) + CHR(227) + "o de Pagamento "
180:                 .Height     = 15
181:                 .Left       = 82
182:                 .Top        = 93
183:                 .Width      = 124
184:                 .ForeColor  = RGB(90, 90, 90)
185:             ENDWITH
186: 
187:             *-- txt_4c_FPags: TextBox de selecao da condicao de pagamento (lookup SigCnFBl)
188:             THIS.AddObject("txt_4c_FPags", "TextBox")
189:             WITH THIS.txt_4c_FPags
190:                 .FontName   = "Tahoma"
191:                 .Left       = 84
192:                 .MaxLength  = 12
193:                 .Top        = 110
194:                 .Width      = 94
195:                 .ForeColor  = RGB(0, 0, 0)
196:                 .Value      = ""
197:             ENDWITH
198:             BINDEVENT(THIS.txt_4c_FPags, "KeyPress", THIS, "TxtFPagsKeyPress")
199: 
200:             *-- lbl_4c_Label3: Local de Pagamento
201:             THIS.AddObject("lbl_4c_Label3", "Label")
202:             WITH THIS.lbl_4c_Label3
203:                 .AutoSize   = .T.
204:                 .FontName   = "Tahoma"
205:                 .FontSize   = 8
206:                 .BackStyle  = 0
207:                 .Caption    = " Local de Pagamento "
208:                 .Height     = 15
209:                 .Left       = 82
210:                 .Top        = 151
211:                 .Width      = 104
212:                 .ForeColor  = RGB(90, 90, 90)
213:             ENDWITH
214: 
215:             *-- txt_4c_Locals: TextBox de local de pagamento (editavel, multi-linha via Height)
216:             THIS.AddObject("txt_4c_Locals", "TextBox")
217:             WITH THIS.txt_4c_Locals
218:                 .FontName   = "Tahoma"
219:                 .Left       = 84
220:                 .MaxLength  = 100
221:                 .Top        = 168
222:                 .Width      = 798
223:                 .Height     = 69
224:                 .ForeColor  = RGB(0, 0, 0)
225:                 .Value      = ""
226:                 .Enabled    = .F.
227:             ENDWITH
228: 
229:             *-- lbl_4c_Label31: Texto de Responsabilidade do Cedente
230:             THIS.AddObject("lbl_4c_Label31", "Label")
231:             WITH THIS.lbl_4c_Label31
232:                 .AutoSize   = .T.
233:                 .FontName   = "Tahoma"
234:                 .FontSize   = 8
235:                 .BackStyle  = 0
236:                 .Caption    = " Texto de Responsabilidade do Cedente "
237:                 .Height     = 15
238:                 .Left       = 82
239:                 .Top        = 151
240:                 .Width      = 196
241:                 .ForeColor  = RGB(90, 90, 90)
242:             ENDWITH
243: 
244:             *-- obj_4c_GetTxtCds: EditBox de texto do cedente
245:             THIS.AddObject("obj_4c_GetTxtCds", "EditBox")
246:             WITH THIS.obj_4c_GetTxtCds
247:                 .FontName   = "Tahoma"
248:                 .Left       = 84
249:                 .Top        = 268
250:                 .Width      = 798
251:                 .Height     = 69
252:                 .ForeColor  = RGB(0, 0, 0)
253:                 .Value      = ""
254:                 .Enabled    = .F.
255:             ENDWITH
256: 
257:             *-- lbl_4c_LblAviso: aviso quando sem configuracao de boleto
258:             THIS.AddObject("lbl_4c_LblAviso", "Label")
259:             WITH THIS.lbl_4c_LblAviso
260:                 .AutoSize   = .T.
261:                 .FontBold   = .T.
262:                 .FontName   = "Tahoma"
263:                 .BackStyle  = 0
264:                 .Caption    = "N" + CHR(227) + "o Existe Configura" + CHR(231) + CHR(227) + "o de Boleto"
265:                 .Left       = 89
266:                 .Top        = 351
267:                 .Width      = 213
268:                 .ForeColor  = RGB(90, 90, 90)
269:                 .Visible    = .F.
270:             ENDWITH
271: 

*-- Linhas 277 a 316:
277:                 .BorderStyle  = 0
278:                 .Value        = 1
279:                 .Height       = 88
280:                 .Left         = 835
281:                 .SpecialEffect = 1
282:                 .Top          = 2
283:                 .Width        = 173
284:                 .Themes       = .F.
285: 
286:                 WITH .Buttons(1)
287:                     .Top          = 5
288:                     .Left         = 11
289:                     .Height       = 75
290:                     .Width        = 75
291:                     .FontBold     = .T.
292:                     .FontItalic   = .T.
293:                     .Caption      = "\<Imprimir"
294:                     .ToolTipText  = "Imprimir"
295:                     .ForeColor    = RGB(90, 90, 90)
296:                     .BackColor    = RGB(255, 255, 255)
297:                     .Themes       = .F.
298:                     .Picture      = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
299:                     .Enabled      = .F.
300:                 ENDWITH
301: 
302:                 WITH .Buttons(2)
303:                     .Top          = 5
304:                     .Left         = 87
305:                     .Height       = 75
306:                     .Width        = 75
307:                     .FontBold     = .T.
308:                     .FontItalic   = .T.
309:                     .FontName     = "Comic Sans MS"
310:                     .FontSize     = 8
311:                     .Caption      = "Encerrar"
312:                     .ToolTipText  = "[ESC] Sair"
313:                     .ForeColor    = RGB(90, 90, 90)
314:                     .BackColor    = RGB(255, 255, 255)
315:                     .Themes       = .F.
316:                     .Cancel       = .T.

*-- Linhas 422 a 431:
422:                     THIS.obj_4c_GetTxtCds.Value   = NVL(cursor_4c_Config.cTxtCds, "")
423:                     THIS.obj_4c_GetTxtCds.Refresh()
424:                 ENDIF
425:                 IF PEMSTATUS(THIS, "lbl_4c_LblAviso", 5)
426:                     THIS.lbl_4c_LblAviso.Visible = .F.
427:                 ENDIF
428:                 IF PEMSTATUS(THIS, "obj_4c_CmdGImprimir", 5)
429:                     THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled = .T.
430:                     THIS.obj_4c_CmdGImprimir.Refresh()
431:                 ENDIF

*-- Linhas 438 a 447:
438:                     THIS.obj_4c_GetTxtCds.Enabled = .F.
439:                     THIS.obj_4c_GetTxtCds.Refresh()
440:                 ENDIF
441:                 IF PEMSTATUS(THIS, "lbl_4c_LblAviso", 5)
442:                     THIS.lbl_4c_LblAviso.Visible = .T.
443:                 ENDIF
444:                 IF PEMSTATUS(THIS, "obj_4c_CmdGImprimir", 5)
445:                     THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled = .F.
446:                     THIS.obj_4c_CmdGImprimir.Value = 2
447:                     THIS.obj_4c_CmdGImprimir.Refresh()

*-- Linhas 1212 a 1221:
1212:                 THIS.obj_4c_GetTxtCds.Value   = ""
1213:                 THIS.obj_4c_GetTxtCds.Enabled = .F.
1214:             ENDIF
1215:             IF PEMSTATUS(THIS, "lbl_4c_LblAviso", 5)
1216:                 THIS.lbl_4c_LblAviso.Visible = .T.
1217:             ENDIF
1218:             IF PEMSTATUS(THIS, "obj_4c_CmdGImprimir", 5)
1219:                 THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled = .F.
1220:                 THIS.obj_4c_CmdGImprimir.Value = 2
1221:                 THIS.obj_4c_CmdGImprimir.Refresh()

*-- Linhas 1234 a 1243:
1234:         TRY
1235:             loc_lTemConfig = USED("cursor_4c_Config") AND RECCOUNT("cursor_4c_Config") > 0
1236:             THIS.HabilitarCampos(loc_lTemConfig)
1237:             IF PEMSTATUS(THIS, "lbl_4c_LblAviso", 5)
1238:                 THIS.lbl_4c_LblAviso.Visible = !loc_lTemConfig
1239:             ENDIF
1240:         CATCH TO loc_oErro
1241:             MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
1242:         ENDTRY
1243:     ENDPROC


### BO (C:\4c\projeto\app\classes\SIGPRIBLBO.prg):
*------------------------------------------------------------------------------
* SIGPRIBLBO.prg - Business Object para Impressao de Boleto Bancario
* Herda de: BusinessBase
* Tabela principal: SigCnFBl (configuracao de boleto)
*------------------------------------------------------------------------------
DEFINE CLASS SIGPRIBLBO AS BusinessBase

    *-- Identificacao da tabela e chave
    this_cTabela      = "SigCnFBl"
    this_cCampoChave  = "FPags"

    *-- Chave do movimento recebida do form pai (pcchave1)
    this_cChave1      = ""

    *-- Campos da configuracao de boleto (SigCnFBl)
    this_cFPags       = ""
    this_cIdChaves    = ""
    this_cLocals      = ""
    this_cTxtCds      = ""
    this_cNomeImps    = ""
    this_cFontePdrs   = ""
    this_nTamFontes   = 0
    this_cTamFolha    = ""

    *-- Posicoes de impressao: Local de Pagamento
    this_nLnLocals    = 0
    this_nClLocals    = 0

    *-- Posicoes de impressao: Data de Vencimento
    this_nLnDtVencs   = 0
    this_nClDtVencs   = 0

    *-- Posicoes de impressao: Data do Documento
    this_nLnDtDocs    = 0
    this_nClDtDocs    = 0

    *-- Posicoes de impressao: Numero do Documento
    this_nLnNrDocs    = 0
    this_nClNrDocs    = 0

    *-- Posicoes de impressao: Valor do Documento
    this_nLnVlDocs    = 0
    this_nClVlDocs    = 0

    *-- Posicoes de impressao: Razao Social do Cliente
    this_nLnRazClis   = 0
    this_nClRazClis   = 0

    *-- Posicoes de impressao: CPF/CNPJ do Cliente
    this_nLnCgcClis   = 0
    this_nClCgcClis   = 0

    *-- Posicoes de impressao: Endereco de Cobranca
    this_nLnEndCobs   = 0
    this_nClEndCobs   = 0

    *-- Posicoes de impressao: Bairro de Cobranca
    this_nLnBaiCobs   = 0
    this_nClBaiCobs   = 0

    *-- Posicoes de impressao: Cidade de Cobranca
    this_nLnCidCobs   = 0
    this_nClCidCobs   = 0

    *-- Posicoes de impressao: Estado de Cobranca
    this_nLnEstCobs   = 0
    this_nClEstCobs   = 0

    *-- Posicoes de impressao: CEP de Cobranca
    this_nLnCepCobs   = 0
    this_nClCepCobs   = 0

    *-- Posicoes de impressao: Texto do Cedente
    this_nLnTxtCds    = 0
    this_nClTxtCds    = 0

    *-- Fatores de escala para impressao matricial
    this_nNffatorln   = 0
    this_nNffatorcl   = 0

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCnFBl"
        THIS.this_cCampoChave = "FPags"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cFPags)
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarConfiguracao - Carrega configuracao de boleto para FPags informado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarConfiguracao(par_cFPags)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Config")
                USE IN cursor_4c_Config
            ENDIF
            loc_cSQL = "SELECT FPags, cIdChaves, cLocals, cTxtCds, cNomeImps," + ;
                       " cFontePdrs, nTamFontes, cTamFolha," + ;
                       " nLnLocals, nClLocals, nLnDtVencs, nClDtVencs," + ;
                       " nLnDtDocs, nClDtDocs, nLnNrDocs, nClNrDocs," + ;
                       " nLnVlDocs, nClVlDocs, nLnRazClis, nClRazClis," + ;
                       " nLnCgcClis, nClCgcClis, nLnEndCobs, nClEndCobs," + ;
                       " nLnBaiCobs, nClBaiCobs, nLnCidCobs, nClCidCobs," + ;
                       " nLnEstCobs, nClEstCobs, nLnCepCobs, nClCepCobs," + ;
                       " nLnTxtCds, nClTxtCds" + ;
                       " FROM SigCnFBl" + ;
                       " WHERE FPags = " + EscaparSQL(PADR(par_cFPags, 12))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Config")
            IF loc_nRet > 0
                IF RECCOUNT("cursor_4c_Config") > 0
                    SELECT cursor_4c_Config
                    GO TOP
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Config")
                ENDIF
            ELSE
                MsgErro("Erro ao buscar configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades this_*
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAlias)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAlias)
                SELECT (par_cAlias)
                THIS.this_cFPags     = TratarNulo(FPags,      "C")
                THIS.this_cIdChaves  = TratarNulo(cIdChaves,  "C")
                THIS.this_cLocals    = TratarNulo(cLocals,    "C")
                THIS.this_cTxtCds    = TratarNulo(cTxtCds,    "C")
                THIS.this_cNomeImps  = TratarNulo(cNomeImps,  "C")
                THIS.this_cFontePdrs = TratarNulo(cFontePdrs, "C")
                THIS.this_nTamFontes = TratarNulo(nTamFontes, "N")
                THIS.this_cTamFolha  = TratarNulo(cTamFolha,  "C")
                THIS.this_nLnLocals  = TratarNulo(nLnLocals,  "N")
                THIS.this_nClLocals  = TratarNulo(nClLocals,  "N")
                THIS.this_nLnDtVencs = TratarNulo(nLnDtVencs, "N")
                THIS.this_nClDtVencs = TratarNulo(nClDtVencs, "N")
                THIS.this_nLnDtDocs  = TratarNulo(nLnDtDocs,  "N")
                THIS.this_nClDtDocs  = TratarNulo(nClDtDocs,  "N")
                THIS.this_nLnNrDocs  = TratarNulo(nLnNrDocs,  "N")
                THIS.this_nClNrDocs  = TratarNulo(nClNrDocs,  "N")
                THIS.this_nLnVlDocs  = TratarNulo(nLnVlDocs,  "N")
                THIS.this_nClVlDocs  = TratarNulo(nClVlDocs,  "N")
                THIS.this_nLnRazClis = TratarNulo(nLnRazClis, "N")
                THIS.this_nClRazClis = TratarNulo(nClRazClis, "N")
                THIS.this_nLnCgcClis = TratarNulo(nLnCgcClis, "N")
                THIS.this_nClCgcClis = TratarNulo(nClCgcClis, "N")
                THIS.this_nLnEndCobs = TratarNulo(nLnEndCobs, "N")
                THIS.this_nClEndCobs = TratarNulo(nClEndCobs, "N")
                THIS.this_nLnBaiCobs = TratarNulo(nLnBaiCobs, "N")
                THIS.this_nClBaiCobs = TratarNulo(nClBaiCobs, "N")
                THIS.this_nLnCidCobs = TratarNulo(nLnCidCobs, "N")
                THIS.this_nClCidCobs = TratarNulo(nClCidCobs, "N")
                THIS.this_nLnEstCobs = TratarNulo(nLnEstCobs, "N")
                THIS.this_nClEstCobs = TratarNulo(nClEstCobs, "N")
                THIS.this_nLnCepCobs = TratarNulo(nLnCepCobs, "N")
                THIS.this_nClCepCobs = TratarNulo(nClCepCobs, "N")
                THIS.this_nLnTxtCds  = TratarNulo(nLnTxtCds,  "N")
                THIS.this_nClTxtCds  = TratarNulo(nClTxtCds,  "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cFPags))
            THIS.this_cMensagemErro = "Condi" + CHR(231) + CHR(227) + "o de Pagamento obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere nova configuracao de boleto em SigCnFBl
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarDados()
                RETURN
            ENDIF
            loc_cSQL = "INSERT INTO SigCnFBl (" + ;
                       " FPags, cIdChaves, cLocals, cTxtCds, cNomeImps," + ;
                       " cFontePdrs, nTamFontes, cTamFolha," + ;
                       " nLnLocals, nClLocals, nLnDtVencs, nClDtVencs," + ;
                       " nLnDtDocs, nClDtDocs, nLnNrDocs, nClNrDocs," + ;
                       " nLnVlDocs, nClVlDocs, nLnRazClis, nClRazClis," + ;
                       " nLnCgcClis, nClCgcClis, nLnEndCobs, nClEndCobs," + ;
                       " nLnBaiCobs, nClBaiCobs, nLnCidCobs, nClCidCobs," + ;
                       " nLnEstCobs, nClEstCobs, nLnCepCobs, nClCepCobs," + ;
                       " nLnTxtCds, nClTxtCds" + ;
                       ") VALUES (" + ;
                       EscaparSQL(PADR(THIS.this_cFPags, 12)) + ", " + ;
                       EscaparSQL(THIS.this_cIdChaves) + ", " + ;
                       EscaparSQL(THIS.this_cLocals) + ", " + ;
                       EscaparSQL(THIS.this_cTxtCds) + ", " + ;
                       EscaparSQL(THIS.this_cNomeImps) + ", " + ;
                       EscaparSQL(THIS.this_cFontePdrs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTamFontes, 0) + ", " + ;
                       EscaparSQL(THIS.this_cTamFolha) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnLocals, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClLocals, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnDtVencs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClDtVencs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnDtDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClDtDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnNrDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClNrDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnVlDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClVlDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnRazClis, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClRazClis, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnCgcClis, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClCgcClis, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnEndCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClEndCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnBaiCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClBaiCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnCidCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClCidCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnEstCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClEstCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnCepCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClCepCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnTxtCds, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClTxtCds, 2) + ;
                       ")"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Salva campos editaveis (cLocals, cTxtCds) em SigCnFBl
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cFPags))
                MsgAviso("Condi" + CHR(231) + CHR(227) + "o de Pagamento n" + CHR(227) + "o selecionada.", "Aviso")
                RETURN
            ENDIF
            loc_cSQL = "UPDATE SigCnFBl SET" + ;
                       " cLocals = " + EscaparSQL(THIS.this_cLocals) + "," + ;
                       " cTxtCds = " + EscaparSQL(THIS.this_cTxtCds) + ;
                       " WHERE FPags = " + EscaparSQL(PADR(THIS.this_cFPags, 12))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui configuracao de boleto de SigCnFBl
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cFPags))
                MsgAviso("Condi" + CHR(231) + CHR(227) + "o de Pagamento n" + CHR(227) + "o selecionada.", "Aviso")
                RETURN
            ENDIF
            loc_cSQL = "DELETE FROM SigCnFBl WHERE FPags = " + ;
                       EscaparSQL(PADR(THIS.this_cFPags, 12))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

