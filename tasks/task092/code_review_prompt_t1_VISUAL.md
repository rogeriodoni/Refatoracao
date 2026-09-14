# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGREETP): Top original=161 vs migrado 'lbl_4c_Label2' Top=214 (diff=53px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGREETP): Left original=27 vs migrado 'lbl_4c_Label2' Left=322 (diff=295px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigReEtp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (801 linhas total):

*-- Linhas 72 a 139:
72:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
73:         ENDIF
74: 
75:         THIS.Caption = "Impress" + CHR(227) + "o de Etiquetas de Opera" + CHR(231) + CHR(245) + "es"
76: 
77:         THIS.AddObject("cnt_4c_Sombra", "Container")
78:         WITH THIS.cnt_4c_Sombra
79:             .Top         = 0
80:             .Left        = 0
81:             .Width       = THIS.Width
82:             .Height      = 80
83:             .BackStyle   = 1
84:             .BackColor   = RGB(100,100,100)
85:             .BorderWidth = 0
86:             .Visible     = .T.
87:         ENDWITH
88: 
89:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
90:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
91:             .Top       = 18
92:             .Left      = 10
93:             .Width     = 769
94:             .Height    = 40
95:             .FontName  = "Tahoma"
96:             .FontSize  = 18
97:             .FontBold  = .T.
98:             .BackStyle = 0
99:             .ForeColor = RGB(0,0,0)
100:             .WordWrap  = .T.
101:             .Caption   = "Impress" + CHR(227) + "o de Etiquetas de Opera" + CHR(231) + CHR(245) + "es"
102:         ENDWITH
103: 
104:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
105:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
106:             .Top       = 17
107:             .Left      = 10
108:             .Width     = 769
109:             .Height    = 46
110:             .FontName  = "Tahoma"
111:             .FontSize  = 18
112:             .FontBold  = .T.
113:             .BackStyle = 0
114:             .ForeColor = RGB(255,255,255)
115:             .WordWrap  = .T.
116:             .Caption   = "Impress" + CHR(227) + "o de Etiquetas de Opera" + CHR(231) + CHR(245) + "es"
117:         ENDWITH
118: 
119:         THIS.AddObject("shp_4c_ShpNotas", "Shape")
120:         WITH THIS.shp_4c_ShpNotas
121:             .Top           = 92
122:             .Left          = 26
123:             .Height        = 67
124:             .Width         = 271
125:             .BackStyle     = 0
126:             .Curvature     = 0
127:             .SpecialEffect = 1
128:             .BorderColor   = RGB(90,90,90)
129:         ENDWITH
130: 
131:         THIS.AddObject("shp_4c_Shape1", "Shape")
132:         WITH THIS.shp_4c_Shape1
133:             .Top           = 174
134:             .Left          = 301
135:             .Height        = 96
136:             .Width         = 138
137:             .BackStyle     = 0
138:             .Curvature     = 0
139:             .SpecialEffect = 1

*-- Linhas 180 a 263:
180:         LOCAL loc_oErro
181: 
182:         TRY
183:             THIS.AddObject("lbl_4c_Label1", "Label")
184:             WITH THIS.lbl_4c_Label1
185:                 .FontName  = "Tahoma"
186:                 .FontSize  = 8
187:                 .BackStyle = 0
188:                 .Caption   = "Densidade :"
189:                 .Left      = 320
190:                 .Top       = 186
191:                 .ForeColor = RGB(90,90,90)
192:             ENDWITH
193: 
194:             THIS.AddObject("obj_4c_SpnDensidade", "Spinner")
195:             WITH THIS.obj_4c_SpnDensidade
196:                 .FontName          = "Tahoma"
197:                 .FontSize          = 8
198:                 .Height            = 26
199:                 .KeyboardHighValue = 20
200:                 .KeyboardLowValue  = 10
201:                 .Left              = 381
202:                 .SpinnerHighValue  = 20
203:                 .SpinnerLowValue   = 0
204:                 .Top               = 181
205:                 .Width             = 56
206:                 .ForeColor         = RGB(0,0,0)
207:                 .Value             = 20
208:             ENDWITH
209: 
210:             THIS.AddObject("lbl_4c_Label2", "Label")
211:             WITH THIS.lbl_4c_Label2
212:                 .FontName  = "Tahoma"
213:                 .FontSize  = 8
214:                 .BackStyle = 0
215:                 .Caption   = "Horizontal :"
216:                 .Left      = 322
217:                 .Top       = 214
218:                 .ForeColor = RGB(90,90,90)
219:             ENDWITH
220: 
221:             THIS.AddObject("obj_4c_SpnHorizontal", "Spinner")
222:             WITH THIS.obj_4c_SpnHorizontal
223:                 .FontName          = "Tahoma"
224:                 .FontSize          = 8
225:                 .Height            = 26
226:                 .KeyboardHighValue = 999
227:                 .KeyboardLowValue  = 0
228:                 .Left              = 381
229:                 .SpinnerHighValue  = 999
230:                 .SpinnerLowValue   = 0
231:                 .Top               = 209
232:                 .Width             = 56
233:                 .ForeColor         = RGB(0,0,0)
234:                 .Value             = 0
235:             ENDWITH
236: 
237:             THIS.AddObject("lbl_4c_Label5", "Label")
238:             WITH THIS.lbl_4c_Label5
239:                 .FontName  = "Tahoma"
240:                 .FontSize  = 8
241:                 .BackStyle = 0
242:                 .Caption   = "Vertical :"
243:                 .Left      = 335
244:                 .Top       = 242
245:                 .ForeColor = RGB(90,90,90)
246:             ENDWITH
247: 
248:             THIS.AddObject("obj_4c_SpnVertical", "Spinner")
249:             WITH THIS.obj_4c_SpnVertical
250:                 .FontName          = "Tahoma"
251:                 .FontSize          = 8
252:                 .Height            = 26
253:                 .KeyboardHighValue = 999
254:                 .KeyboardLowValue  = 0
255:                 .Left              = 381
256:                 .SpinnerHighValue  = 999
257:                 .SpinnerLowValue   = 0
258:                 .Top               = 237
259:                 .Width             = 56
260:                 .ForeColor         = RGB(0,0,0)
261:                 .Value             = 0
262:             ENDWITH
263: 

*-- Linhas 269 a 310:
269:                 .BorderStyle   = 0
270:                 .Value         = 1
271:                 .Height        = 85
272:                 .Left          = 311
273:                 .SpecialEffect = 1
274:                 .Top           = -2
275:                 .Width         = 160
276:                 .BorderColor   = RGB(136,189,188)
277:                 .Themes        = .F.
278:             ENDWITH
279: 
280:             WITH THIS.obj_4c_CmdBtnForm.Buttons(1)
281:                 .Top        = 5
282:                 .Left       = 5
283:                 .Height     = 75
284:                 .Width      = 75
285:                 .FontBold   = .T.
286:                 .FontItalic = .T.
287:                 .FontName   = "Tahoma"
288:                 .FontSize   = 8
289:                 .Caption    = "\<Imprimir"
290:                 .ForeColor  = RGB(90,90,90)
291:                 .BackColor  = RGB(255,255,255)
292:                 .Themes     = .F.
293:                 .Picture    = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
294:             ENDWITH
295: 
296:             WITH THIS.obj_4c_CmdBtnForm.Buttons(2)
297:                 .Top        = 5
298:                 .Left       = 80
299:                 .Height     = 75
300:                 .Width      = 75
301:                 .FontBold   = .T.
302:                 .FontItalic = .T.
303:                 .FontName   = "Tahoma"
304:                 .FontSize   = 8
305:                 .Caption    = "Encerrar"
306:                 .ForeColor  = RGB(90,90,90)
307:                 .BackColor  = RGB(255,255,255)
308:                 .Themes     = .F.
309:                 .Cancel     = .T.
310:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 333 a 428:
333:         LOCAL loc_oErro
334: 
335:         TRY
336:             THIS.AddObject("lbl_4c_Label3", "Label")
337:             WITH THIS.lbl_4c_Label3
338:                 .AutoSize  = .T.
339:                 .FontName  = "Tahoma"
340:                 .FontSize  = 8
341:                 .BackStyle = 0
342:                 .Caption   = "Quantidade :"
343:                 .Left      = 44
344:                 .Top       = 103
345:                 .ForeColor = RGB(90,90,90)
346:             ENDWITH
347: 
348:             THIS.AddObject("txt_4c_Qtde", "TextBox")
349:             WITH THIS.txt_4c_Qtde
350:                 .FontName  = "Tahoma"
351:                 .FontSize  = 8
352:                 .Alignment = 3
353:                 .Value     = 1
354:                 .Height    = 25
355:                 .InputMask = "9999"
356:                 .Left      = 111
357:                 .Top       = 99
358:                 .Width     = 38
359:                 .ForeColor = RGB(0,0,0)
360:             ENDWITH
361: 
362:             THIS.AddObject("lbl_4c_Label4", "Label")
363:             WITH THIS.lbl_4c_Label4
364:                 .AutoSize  = .T.
365:                 .FontName  = "Tahoma"
366:                 .FontSize  = 8
367:                 .BackStyle = 0
368:                 .Caption   = "Tipo :"
369:                 .Left      = 41
370:                 .Top       = 132
371:                 .ForeColor = RGB(90,90,90)
372:             ENDWITH
373: 
374:             THIS.AddObject("cbo_4c_CmbTipos", "ComboBox")
375:             WITH THIS.cbo_4c_CmbTipos
376:                 .FontName  = "Tahoma"
377:                 .FontSize  = 8
378:                 .Height    = 25
379:                 .Left      = 72
380:                 .Style     = 2
381:                 .Top       = 128
382:                 .Width     = 220
383:                 .ForeColor = RGB(0,0,0)
384:             ENDWITH
385: 
386:             THIS.AddObject("lbl_4c_LblImpressora", "Label")
387:             WITH THIS.lbl_4c_LblImpressora
388:                 .AutoSize  = .T.
389:                 .FontName  = "Tahoma"
390:                 .FontSize  = 8
391:                 .BackStyle = 0
392:                 .Caption   = " Selecione Impressora"
393:                 .Height    = 15
394:                 .Left      = 27
395:                 .Top       = 161
396:                 .Width     = 107
397:                 .ForeColor = RGB(90,90,90)
398:             ENDWITH
399: 
400:             THIS.AddObject("obj_4c_OptImpressora", "OptionGroup")
401:             WITH THIS.obj_4c_OptImpressora
402:                 .AutoSize      = .F.
403:                 .ButtonCount   = 1
404:                 .BackStyle     = 0
405:                 .Value         = 1
406:                 .Height        = 156
407:                 .Left          = 27
408:                 .SpecialEffect = 1
409:                 .Top           = 174
410:                 .Width         = 276
411:                 .BorderColor   = RGB(90,90,90)
412:             ENDWITH
413: 
414:             WITH THIS.obj_4c_OptImpressora.Buttons(1)
415:                 .FontName  = "Tahoma"
416:                 .FontSize  = 8
417:                 .BackStyle = 0
418:                 .Caption   = "\<1. Gen" + CHR(233) + "rico/Somente Texto"
419:                 .Value     = 1
420:                 .Height    = 17
421:                 .Left      = 4
422:                 .Style     = 0
423:                 .Top       = 10
424:                 .Width     = 262
425:                 .ForeColor = RGB(90,90,90)
426:             ENDWITH
427: 
428:             BINDEVENT(THIS.obj_4c_OptImpressora, "InteractiveChange", THIS, "OptImpressoraInteractiveChange")

*-- Linhas 467 a 481:
467:                             loc_cNomeImp = ALLTRIM(NVL(cursor_4c_Impressoras.NomeImp, ""))
468:                             WITH THIS.obj_4c_OptImpressora.Buttons(loc_nI)
469:                                 .AutoSize  = .F.
470:                                 .Caption   = " \<" + TRANSFORM(loc_nI) + ". " + loc_cNomeImp
471:                                 .FontSize  = 8
472:                                 .FontName  = "Tahoma"
473:                                 .BackStyle = 0
474:                                 .ForeColor = RGB(90,90,90)
475:                                 .Tag       = UPPER(loc_cNomeImp)
476:                                 .Top       = loc_nTop
477:                                 .Width     = 180
478:                                 .Height    = 17
479:                             ENDWITH
480:                             SKIP IN cursor_4c_Impressoras
481:                             loc_nTop    = loc_nTop + 20

*-- Linhas 492 a 506:
492:                 ELSE
493:                     THIS.obj_4c_OptImpressora.ButtonCount = 1
494:                     WITH THIS.obj_4c_OptImpressora.Buttons(1)
495:                         .Caption   = " \<0. Gen" + CHR(233) + "rico/Somente Texto"
496:                         .FontName  = "Tahoma"
497:                         .FontSize  = 8
498:                         .BackStyle = 0
499:                         .ForeColor = RGB(90,90,90)
500:                         .Tag       = "GEN" + CHR(201) + "RICO/SOMENTE TEXTO"
501:                         .Top       = 10
502:                         .Width     = 180
503:                         .Height    = 17
504:                     ENDWITH
505:                     THIS.obj_4c_OptImpressora.Height  = 35
506:                     THIS.obj_4c_OptImpressora.Enabled = .F.


### BO (C:\4c\projeto\app\classes\SigReEtpBO.prg):
*===============================================================================
* SigReEtpBO.prg - Business Object para Impressao de Etiquetas de Operacoes
* Entidade: SigReEtp (OPERACIONAL - sem CRUD de entidade propria)
* Tabelas: SigCdOpe (operacao), SigCdPam (parametros), SigCdmp/SigSyImp (impressoras)
*===============================================================================
DEFINE CLASS SigReEtpBO AS BusinessBase

    *-- Operacao de referencia (parametro recebido pelo form)
    this_cDopes      = ""   && codigo da operacao (SigCdOpe.dopes char 20)
    this_nNDopes     = 0    && contador atual (SigCdOpe.ndopes numeric 4,0)

    *-- Parametros carregados de SigCdPam
    this_nMaxTpEtis  = 0    && maximo tipos etiqueta permitidos
    this_nTpEtiPads  = 0    && tipo etiqueta padrao (numeric 3,0)
    this_nMaxImpEti  = 0    && maximo de impressoras para etiqueta (numeric 1,0)
    this_nImpEtis    = 0    && flag impressao etiqueta (numeric 1,0)
    this_nAjVerts    = 0    && ajuste vertical padrao (numeric 2,0)
    this_nAjHorzs    = 0    && ajuste horizontal padrao (numeric 3,0)

    *-- Configuracao de impressao em execucao (equivalente ao loObj do legado)
    this_nQtd        = 0    && quantidade de etiquetas a imprimir
    this_nDen        = 0    && densidade da impressora (spnDensidade)
    this_nHor        = 0    && ajuste horizontal aplicado (spnHorizontal)
    this_nVer        = 0    && ajuste vertical aplicado (spnVertical)
    this_cImp        = ""   && nome da impressora selecionada (tag do option)
    this_cTip        = ""   && tipo de etiqueta: "01" "02" ou "03" (padl de listindex)
    this_cIni        = ""   && prefixo de 4 digitos (PADL(NDopes, 4, '0'))

    *---------------------------------------------------------------------------
    * Init - Inicializa o BO operacional. Persistencia ocorre em SigCdOpe (NDopes)
    *---------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdOpe"
        THIS.this_cCampoChave = "dopes"
    ENDPROC

    *---------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o codigo da operacao como identificador
    *---------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes)
    ENDFUNC

    *---------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor SigCdOpe
    * par_cAliasCursor: alias do cursor com colunas dopes, ndopes
    *---------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cDopes  = ALLTRIM(TratarNulo(dopes, "C"))
            THIS.this_nNDopes = TratarNulo(ndopes, "N")
            THIS.this_cIni    = PADL(THIS.this_nNDopes, 4, "0")
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarDados - Carrega parametros de SigCdPam e NDopes de SigCdOpe
    * par_cDopes: codigo da operacao (Dopes padded 20 chars)
    * Retorna .T. se carregou com sucesso
    *---------------------------------------------------------------------------
    FUNCTION CarregarDados(par_cDopes)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Parametros de SigCdPam (unico registro global)
            loc_cSQL = "SELECT nmaxtpetis, tpetipads, nmaximpeti, impetis, " + ;
                       "ajverts, ajhorzs " + ;
                       "FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param") > 0
                IF USED("cursor_4c_Param") AND !EOF("cursor_4c_Param")
                    SELECT cursor_4c_Param
                    THIS.this_nMaxTpEtis = NVL(nmaxtpetis, 0)
                    THIS.this_nTpEtiPads  = NVL(tpetipads, 0)
                    THIS.this_nMaxImpEti  = NVL(nmaximpeti, 0)
                    THIS.this_nImpEtis    = NVL(impetis, 0)
                    THIS.this_nAjVerts    = NVL(ajverts, 0)
                    THIS.this_nAjHorzs    = NVL(ajhorzs, 0)
                ENDIF
                IF USED("cursor_4c_Param")
                    USE IN cursor_4c_Param
                ENDIF
            ENDIF

            *-- NDopes atual de SigCdOpe para prefixo das etiquetas
            loc_cSQL = "SELECT ndopes FROM SigCdOpe WHERE dopes = " + EscaparSQL(ALLTRIM(par_cDopes))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope") > 0
                IF USED("cursor_4c_Ope") AND !EOF("cursor_4c_Ope")
                    SELECT cursor_4c_Ope
                    THIS.this_nNDopes = NVL(ndopes, 0)
                    THIS.this_cDopes  = ALLTRIM(par_cDopes)
                    THIS.this_cIni    = PADL(THIS.this_nNDopes, 4, "0")
                ENDIF
                IF USED("cursor_4c_Ope")
                    USE IN cursor_4c_Ope
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *---------------------------------------------------------------------------
    * CarregarImpressoras - Carrega impressoras de etiqueta permitidas ao usuario
    * Popula cursor_4c_Impressoras (NomeImp C(255), NtpImpres N(3,0))
    * Retorna numero de impressoras encontradas, ou -1 em caso de erro
    *---------------------------------------------------------------------------
    FUNCTION CarregarImpressoras()
        LOCAL loc_nResult, loc_cSQL, loc_oErro
        LOCAL loc_nPrinters, loc_nI, loc_nOk, loc_nImpres, loc_lContinuar
        LOCAL ARRAY loc_aPrinters(1), loc_aImpOk(1)

        loc_nResult   = -1
        loc_nImpres   = 0
        loc_lContinuar = .T.

        TRY
            *-- Cria cursor resultado vazio
            IF USED("cursor_4c_Impressoras")
                USE IN cursor_4c_Impressoras
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Impressoras (NomeImp C(254) NULL, NtpImpres N(3,0) NULL)
            SET NULL OFF

            *-- Obtem impressoras instaladas no sistema
            loc_nPrinters = APRINTERS(loc_aPrinters)
            IF loc_nPrinters = 0
                MsgAviso("N" + CHR(227) + "o foi encontrada nenhuma impressora instalada.", ;
                         "Impress" + CHR(227) + "o")
                loc_nResult    = 0
                loc_lContinuar = .F.
            ENDIF

            *-- Normaliza nomes para comparacao (uppercase)
            IF loc_lContinuar
                FOR loc_nI = 1 TO loc_nPrinters
                    loc_aPrinters(loc_nI, 1) = UPPER(loc_aPrinters(loc_nI, 1))
                ENDFOR
                ASORT(loc_aPrinters)
            ENDIF

            *-- Consulta impressoras autorizadas para o usuario (acesso direto + por grupo)
            IF loc_lContinuar
                loc_cSQL = "SELECT b.Impres, b.NtpImpres " + ;
                           "FROM SigSyImp a, SigCdmp b " + ;
                           "WHERE a.UsuAcess = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
                           " AND a.Cimps = b.Impres " + ;
                           "UNION ALL " + ;
                           "SELECT c.Impres, c.NtpImpres " + ;
                           "FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
                           "WHERE a.Usuarios = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
                           " AND a.Grupos = b.GrAcess AND b.Cimps = c.Impres"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCimp") < 1
                    MsgErro("Falha ao consultar impressoras do usu" + CHR(225) + "rio.", "Erro")
                    loc_nResult    = -1
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Agrupa por impressora eliminando duplicados
            IF loc_lContinuar
                IF USED("cursor_4c_TmpCimp") AND RECCOUNT("cursor_4c_TmpCimp") > 0
                    SELECT Impres, NtpImpres ;
                      FROM cursor_4c_TmpCimp ;
                     GROUP BY Impres, NtpImpres ;
                      INTO CURSOR cursor_4c_CImpAgg READWRITE
                ENDIF

                IF USED("cursor_4c_TmpCimp")
                    USE IN cursor_4c_TmpCimp
                ENDIF

                *-- Filtra impressoras tipo 2 (etiqueta) que estejam instaladas no sistema
                DIMENSION loc_aImpOk(loc_nPrinters + 1)
                loc_nImpres = 0

                IF USED("cursor_4c_CImpAgg")
                    SELECT cursor_4c_CImpAgg
                    SCAN FOR NtpImpres = 2
                        loc_nOk = ASCAN(loc_aPrinters, ALLTRIM(UPPER(Impres)))
                        IF loc_nOk <> 0
                            loc_nImpres = loc_nImpres + 1
                            loc_aImpOk(loc_nImpres) = loc_aPrinters(loc_nOk)
                        ENDIF
                    ENDSCAN
                    USE IN cursor_4c_CImpAgg
                ENDIF

                *-- Fallback: generica/somente texto se nenhuma de etiqueta encontrada
                IF loc_nImpres = 0
                    loc_nOk = ASCAN(loc_aPrinters, "GEN" + CHR(201) + "RICO/SOMENTE TEXTO")
                    IF loc_nOk = 0
                        loc_nOk = ASCAN(loc_aPrinters, "GEN" + CHR(233) + "RICO/SOMENTE TEXTO")
                    ENDIF
                    IF loc_nOk <> 0
                        loc_nImpres = 1
                        loc_aImpOk(1) = loc_aPrinters(loc_nOk)
                    ENDIF
                ENDIF

                *-- Popula cursor resultado com impressoras encontradas
                SELECT cursor_4c_Impressoras
                FOR loc_nI = 1 TO loc_nImpres
                    INSERT INTO cursor_4c_Impressoras (NomeImp, NtpImpres) ;
                        VALUES (loc_aImpOk(loc_nI), 2)
                ENDFOR

                loc_nResult = loc_nImpres
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nResult
    ENDFUNC

    *---------------------------------------------------------------------------
    * Imprimir - Valida configuracao e despacha para o metodo de impressao
    * par_cDopes: codigo da operacao
    * Retorna .T. se impressao concluida com sucesso
    *---------------------------------------------------------------------------
    FUNCTION Imprimir(par_cDopes)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_lValidado

        loc_lSucesso  = .F.
        loc_lValidado = .T.

        TRY
            *-- Valida quantidade
            IF THIS.this_nQtd < 1
                MsgAviso("Quantidade para impress" + CHR(227) + "o inv" + CHR(225) + "lida!", ;
                         "Dados Inv" + CHR(225) + "lidos")
                loc_lValidado = .F.
            ENDIF

            *-- Valida tipo de etiqueta selecionado
            IF loc_lValidado AND (EMPTY(ALLTRIM(THIS.this_cTip)) OR ALLTRIM(THIS.this_cTip) = "00")
                MsgAviso("Selecione o tipo de etiqueta.", "Impress" + CHR(227) + "o")
                loc_lValidado = .F.
            ENDIF

            IF loc_lValidado
                *-- Recarrega NDopes atual para prefixo correto desta impressao
                loc_cSQL = "SELECT ndopes FROM SigCdOpe WHERE dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeAtual") > 0
                    IF USED("cursor_4c_OpeAtual") AND !EOF("cursor_4c_OpeAtual")
                        SELECT cursor_4c_OpeAtual
                        THIS.this_nNDopes = NVL(ndopes, 0)
                        THIS.this_cIni    = PADL(THIS.this_nNDopes, 4, "0")
                    ENDIF
                    IF USED("cursor_4c_OpeAtual")
                        USE IN cursor_4c_OpeAtual
                    ENDIF
                ENDIF

                *-- Despacha para o metodo correto conforme tipo
                DO CASE
                    CASE ALLTRIM(THIS.this_cTip) = "01"
                        loc_lSucesso = THIS.ImprimirEtiqueta01(par_cDopes)

                    CASE ALLTRIM(THIS.this_cTip) = "02"
                        loc_lSucesso = THIS.ImprimirEtiqueta02(par_cDopes)

                    CASE ALLTRIM(THIS.this_cTip) = "03"
                        loc_lSucesso = THIS.ImprimirEtiqueta03(par_cDopes)

                    OTHERWISE
                        MsgAviso("Tipo de etiqueta inv" + CHR(225) + "lido: " + ALLTRIM(THIS.this_cTip), ;
                                 "Impress" + CHR(227) + "o")
                ENDCASE

                IF loc_lSucesso
                    MsgInfo("A impress" + CHR(227) + "o das etiquetas foi conclu" + CHR(237) + "da!", ;
                            "Impress" + CHR(227) + "o")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *---------------------------------------------------------------------------
    * ImprimirEtiqueta01 - 4 Colunas Vertical Simples
    * Imprime this_nQtd etiquetas, agrupando 4 por pagina fisica.
    * Cada etiqueta gera um codigo de barras unico: Ini(4) + sequencial(6).
    * par_cDopes: codigo da operacao (para contexto do lote)
    *---------------------------------------------------------------------------
    PROTECTED FUNCTION ImprimirEtiqueta01(par_cDopes)
        LOCAL loc_lcBar, loc_lcLin, loc_lcCol, loc_lnCnt, loc_lnI, loc_lnInc
        LOCAL loc_lnSeq, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_lnCnt    = 0
        loc_lnSeq    = 0

        TRY
            FOR loc_lnI = 1 TO THIS.this_nQtd
                loc_lnCnt = loc_lnCnt + 1
                IF loc_lnCnt > 4
                    loc_lnCnt = 1
                ENDIF

                *-- Inicializa pagina a cada 4 etiquetas
                IF loc_lnCnt = 1
                    SET PRINTER TO NAME (THIS.this_cImp)
                    SET DEVICE TO PRINTER
                    ??? CHR(02) + "L" + CHR(13)
                    ??? "H" + ALLTRIM(STR(THIS.this_nDen)) + CHR(13)
                    ??? "D11" + CHR(13)
                ENDIF

                *-- Gera codigo de barras unico para esta etiqueta (Ini + sequencial 6 digitos)
                loc_lnSeq = loc_lnSeq + 1
                loc_lcBar = THIS.this_cIni + PADL(loc_lnSeq, 6, "0")

                loc_lnInc = (107 * (loc_lnCnt - 1))

                *-- Posicao superior
                loc_lcLin = 018 + THIS.this_nHor
                loc_lcCol = 030 + THIS.this_nVer + loc_lnInc
                ??? "4e63031" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + "C" + loc_lcBar + CHR(13)

                loc_lcLin = 050 + THIS.this_nHor
                loc_lcCol = 043 + THIS.this_nVer + loc_lnInc
                ??? "4911002" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + loc_lcBar + CHR(13)

                *-- Posicao inferior
                loc_lcLin = 018 + THIS.this_nHor
                loc_lcCol = 080 + THIS.this_nVer + loc_lnInc
                ??? "4e63031" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + "C" + loc_lcBar + CHR(13)

                loc_lcLin = 050 + THIS.this_nHor
                loc_lcCol = 092 + THIS.this_nVer + loc_lnInc
                ??? "4911002" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + loc_lcBar + CHR(13)

                *-- Finaliza pagina ao atingir 4 etiquetas ou na ultima
                IF loc_lnI = THIS.this_nQtd OR loc_lnCnt = 4
                    ??? "Q0001" + CHR(13)
                    ??? "E" + CHR(13)
                    SET PRINTER TO DEFAULT
                    SET DEVICE TO SCREEN
                ENDIF
            ENDFOR

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            SET DEVICE TO SCREEN
            SET PRINTER TO DEFAULT
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *---------------------------------------------------------------------------
    * ImprimirEtiqueta02 - 4 Colunas Vertical Dupla
    * Agrupa pares de etiquetas: colunas 1+2 compartilham o mesmo codigo,
    * colunas 3+4 compartilham outro codigo. Itera de 2 em 2 (pares).
    * par_cDopes: codigo da operacao
    *---------------------------------------------------------------------------
    PROTECTED FUNCTION ImprimirEtiqueta02(par_cDopes)
        LOCAL loc_lcBar, loc_lcLin, loc_lcCol
        LOCAL loc_lnI, loc_lnSeq, loc_lnQtdPar, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_lnSeq    = 0
        loc_lnQtdPar = THIS.this_nQtd + MOD(THIS.this_nQtd, 2)

        TRY
            FOR loc_lnI = 1 TO loc_lnQtdPar STEP 2
                SET PRINTER TO NAME (THIS.this_cImp)
                SET DEVICE TO PRINTER

                *-- Inicializa etiqueta
                ??? CHR(02) + "L" + CHR(13)
                ??? "H" + ALLTRIM(STR(THIS.this_nDen)) + CHR(13)
                ??? "D11" + CHR(13)

                *-- Codigo de barras para colunas 1 e 2 (par esquerdo)
                loc_lnSeq = loc_lnSeq + 1
                loc_lcBar = THIS.this_cIni + PADL(loc_lnSeq, 6, "0")

                *-- Etiqueta 1 (coluna 030/080) - Superior
                loc_lcLin = 018 + THIS.this_nHor
                loc_lcCol = 030 + THIS.this_nVer
                ??? "4e63031" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + "C" + loc_lcBar + CHR(13)

                loc_lcLin = 050 + THIS.this_nHor
                loc_lcCol = 043 + THIS.this_nVer
                ??? "4911002" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + loc_lcBar + CHR(13)

                *-- Etiqueta 1 - Inferior
                loc_lcLin = 018 + THIS.this_nHor
                loc_lcCol = 080 + THIS.this_nVer
                ??? "4e63031" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + "C" + loc_lcBar + CHR(13)

                loc_lcLin = 050 + THIS.this_nHor
                loc_lcCol = 092 + THIS.this_nVer
                ??? "4911002" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + loc_lcBar + CHR(13)

                *-- Etiqueta 2 (coluna 137/185) com mesmo codigo - Superior
                loc_lcLin = 018 + THIS.this_nHor
                loc_lcCol = 137 + THIS.this_nVer
                ??? "4e63031" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + "C" + loc_lcBar + CHR(13)

                loc_lcLin = 050 + THIS.this_nHor
                loc_lcCol = 149 + THIS.this_nVer
                ??? "4911002" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + loc_lcBar + CHR(13)

                *-- Etiqueta 2 - Inferior
                loc_lcLin = 018 + THIS.this_nHor
                loc_lcCol = 185 + THIS.this_nVer
                ??? "4e63031" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + "C" + loc_lcBar + CHR(13)

                loc_lcLin = 050 + THIS.this_nHor
                loc_lcCol = 197 + THIS.this_nVer
                ??? "4911002" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + loc_lcBar + CHR(13)

                *-- Par direito (colunas 3 e 4) somente se nao eh o ultimo item
                IF loc_lnI <> THIS.this_nQtd
                    *-- Novo codigo de barras para colunas 3 e 4
                    loc_lnSeq = loc_lnSeq + 1
                    loc_lcBar = THIS.this_cIni + PADL(loc_lnSeq, 6, "0")

                    *-- Etiqueta 3 (coluna 243/292) - Superior
                    loc_lcLin = 018 + THIS.this_nHor
                    loc_lcCol = 243 + THIS.this_nVer
                    ??? "4e63031" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + "C" + loc_lcBar + CHR(13)

                    loc_lcLin = 050 + THIS.this_nHor
                    loc_lcCol = 255 + THIS.this_nVer
                    ??? "4911002" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + loc_lcBar + CHR(13)

                    *-- Etiqueta 3 - Inferior
                    loc_lcLin = 018 + THIS.this_nHor
                    loc_lcCol = 292 + THIS.this_nVer
                    ??? "4e63031" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + "C" + loc_lcBar + CHR(13)

                    loc_lcLin = 050 + THIS.this_nHor
                    loc_lcCol = 304 + THIS.this_nVer
                    ??? "4911002" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + loc_lcBar + CHR(13)

                    *-- Etiqueta 4 (coluna 349/399) com mesmo codigo - Superior
                    loc_lcLin = 018 + THIS.this_nHor
                    loc_lcCol = 349 + THIS.this_nVer
                    ??? "4e63031" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + "C" + loc_lcBar + CHR(13)

                    loc_lcLin = 050 + THIS.this_nHor
                    loc_lcCol = 361 + THIS.this_nVer
                    ??? "4911002" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + loc_lcBar + CHR(13)

                    *-- Etiqueta 4 - Inferior
                    loc_lcLin = 018 + THIS.this_nHor
                    loc_lcCol = 399 + THIS.this_nVer
                    ??? "4e63031" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + "C" + loc_lcBar + CHR(13)

                    loc_lcLin = 050 + THIS.this_nHor
                    loc_lcCol = 411 + THIS.this_nVer
                    ??? "4911002" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + loc_lcBar + CHR(13)
                ENDIF

                *-- Finaliza pagina
                ??? "Q0001" + CHR(13)
                ??? "E" + CHR(13)
                SET PRINTER TO DEFAULT
                SET DEVICE TO SCREEN
            ENDFOR

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            SET DEVICE TO SCREEN
            SET PRINTER TO DEFAULT
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *---------------------------------------------------------------------------
    * ImprimirEtiqueta03 - 2 Colunas Horizontal
    * Imprime this_nQtd etiquetas, cada uma em 2 colunas horizontais (esq + dir).
    * par_cDopes: codigo da operacao
    *---------------------------------------------------------------------------
    PROTECTED FUNCTION ImprimirEtiqueta03(par_cDopes)
        LOCAL loc_lcBar, loc_lcLin, loc_lcCol
        LOCAL loc_lnI, loc_lnSeq, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_lnSeq    = 0

        TRY
            FOR loc_lnI = 1 TO THIS.this_nQtd
                SET PRINTER TO NAME (THIS.this_cImp)
                SET DEVICE TO PRINTER

                *-- Gera codigo de barras unico para esta etiqueta
                loc_lnSeq = loc_lnSeq + 1
                loc_lcBar = THIS.this_cIni + PADL(loc_lnSeq, 6, "0")

                *-- Inicializa etiqueta
                ??? CHR(02) + "L" + CHR(13)
                ??? "H" + ALLTRIM(STR(THIS.this_nDen)) + CHR(13)
                ??? "D11" + CHR(13)

                *-- Coluna da esquerda
                loc_lcLin = 030 + THIS.this_nHor
                loc_lcCol = 037 + THIS.this_nVer
                ??? "1e63040" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + "C" + loc_lcBar + CHR(13)

                loc_lcLin = 012 + THIS.this_nHor
                loc_lcCol = 066 + THIS.this_nVer
                ??? "1911003" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + loc_lcBar + CHR(13)

                *-- Coluna da direita (mesmo codigo)
                loc_lcLin = 030 + THIS.this_nHor
                loc_lcCol = 230 + THIS.this_nVer
                ??? "1e63040" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + "C" + loc_lcBar + CHR(13)

                loc_lcLin = 012 + THIS.this_nHor
                loc_lcCol = 260 + THIS.this_nVer
                ??? "1911003" + PADL(loc_lcLin, 4, "0") + PADL(loc_lcCol, 4, "0") + loc_lcBar + CHR(13)

                *-- Finaliza etiqueta
                ??? "Q0001" + CHR(13)
                ??? "E" + CHR(13)
                SET PRINTER TO DEFAULT
                SET DEVICE TO SCREEN
            ENDFOR

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            SET DEVICE TO SCREEN
            SET PRINTER TO DEFAULT
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *---------------------------------------------------------------------------
    * RegistrarBatchImpresso - Avanca o contador SigCdOpe.ndopes em this_nQtd
    * Operacao real de persistencia do form: apos imprimir um lote de etiquetas,
    * o contador da operacao DEVE ser incrementado para garantir que o proximo
    * lote utilize codigos de barras (Ini + sequencial) unicos. Sem este avanco,
    * lotes subsequentes gerariam codigos de barras duplicados.
    *---------------------------------------------------------------------------
    PROTECTED FUNCTION RegistrarBatchImpresso()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cDopes)) OR THIS.this_nQtd < 1
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdOpe SET ndopes = ISNULL(ndopes, 0) + " + ;
                       FormatarNumeroSQL(THIS.this_nQtd) + ;
                       " WHERE dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                THIS.this_nNDopes = THIS.this_nNDopes + THIS.this_nQtd
                THIS.this_cIni    = PADL(THIS.this_nNDopes, 4, "0")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro RegistrarBatchImpresso")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *---------------------------------------------------------------------------
    * Inserir - Operacao CRUD (form OPERACIONAL): registra batch impresso
    * Form SIGREETP nao possui INSERT tradicional de entidade. A operacao de
    * persistencia equivalente eh o avanco do contador SigCdOpe.ndopes apos a
    * impressao bem sucedida de um lote inicial de etiquetas. Delega para
    * RegistrarBatchImpresso() e registra auditoria.
    *---------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.RegistrarBatchImpresso()
        IF loc_lSucesso
            THIS.RegistrarAuditoria("INSERT")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - Operacao CRUD (form OPERACIONAL): avanca contador apos reprint
    * Em re-impressoes ou ajustes de quantidade, o contador da operacao precisa
    * ser atualizado pelo mesmo fluxo transacional. Delega para
    * RegistrarBatchImpresso() e registra auditoria.
    *---------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.RegistrarBatchImpresso()
        IF loc_lSucesso
            THIS.RegistrarAuditoria("UPDATE")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

