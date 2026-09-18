*-- ExtratoReduzidoSimples.prg
*-- Versao simplificada para reducao de arquivos grandes
*-- Apenas remove secao 3 (metodos) parcialmente, mantendo as outras secoes intactas
*--

LPARAMETERS par_cArquivoOrigem, par_nLimiteKB

LOCAL loc_cArquivoSlim, loc_cConteudo
LOCAL loc_nPosSecao3, loc_nPosSecao4
LOCAL loc_cAntes, loc_cSecao3, loc_cDepois
LOCAL loc_cSecao3Reduzida
LOCAL loc_aArquivo[1,5], loc_nTamanhoKB

*-- Validar parametros
IF EMPTY(par_cArquivoOrigem) OR !FILE(par_cArquivoOrigem)
    ? "ERRO: Arquivo nao encontrado"
    RETURN ""
ENDIF

IF EMPTY(par_nLimiteKB)
    par_nLimiteKB = 400
ENDIF

*-- Verificar tamanho
ADIR(loc_aArquivo, par_cArquivoOrigem)
loc_nTamanhoKB = loc_aArquivo[1,2] / 1024

? "ExtratoReduzidoSimples"
? "  Arquivo: " + par_cArquivoOrigem
? "  Tamanho: " + TRANSFORM(INT(loc_nTamanhoKB)) + " KB"

IF loc_nTamanhoKB <= par_nLimiteKB
    ? "  Arquivo abaixo do limite, nao precisa reduzir"
    RETURN par_cArquivoOrigem
ENDIF

*-- Ler arquivo
? "  Lendo arquivo..."
loc_cConteudo = FILETOSTR(par_cArquivoOrigem)

IF EMPTY(loc_cConteudo)
    ? "  ERRO: Arquivo vazio ou erro de leitura"
    RETURN ""
ENDIF

? "  Conteudo lido: " + TRANSFORM(LEN(loc_cConteudo)) + " bytes"

*-- Encontrar posicao da SECAO 3 e SECAO 4
loc_nPosSecao3 = ATC("* SECAO 3:", loc_cConteudo)
loc_nPosSecao4 = ATC("* SECAO 4:", loc_cConteudo)

? "  Pos SECAO 3: " + TRANSFORM(loc_nPosSecao3)
? "  Pos SECAO 4: " + TRANSFORM(loc_nPosSecao4)

IF loc_nPosSecao3 = 0 OR loc_nPosSecao4 = 0
    ? "  ERRO: Secoes nao encontradas"
    RETURN ""
ENDIF

*-- Separar em partes
loc_cAntes = LEFT(loc_cConteudo, loc_nPosSecao3 - 1)
loc_cSecao3 = SUBSTR(loc_cConteudo, loc_nPosSecao3, loc_nPosSecao4 - loc_nPosSecao3)
loc_cDepois = SUBSTR(loc_cConteudo, loc_nPosSecao4)

? "  Tamanho ANTES (SECAO 1+2): " + TRANSFORM(LEN(loc_cAntes)) + " bytes"
? "  Tamanho SECAO 3: " + TRANSFORM(LEN(loc_cSecao3)) + " bytes"
? "  Tamanho DEPOIS (SECAO 4): " + TRANSFORM(LEN(loc_cDepois)) + " bytes"

*-- Reduzir SECAO 3 - manter apenas cabecalho e aviso
loc_cSecao3Reduzida = ""
loc_cSecao3Reduzida = loc_cSecao3Reduzida + "=================================================================================" + CHR(13) + CHR(10)
loc_cSecao3Reduzida = loc_cSecao3Reduzida + "* SECAO 3: METODOS (REDUZIDA - ver arquivo original para codigo completo)" + CHR(13) + CHR(10)
loc_cSecao3Reduzida = loc_cSecao3Reduzida + "=================================================================================" + CHR(13) + CHR(10)
loc_cSecao3Reduzida = loc_cSecao3Reduzida + CHR(13) + CHR(10)
loc_cSecao3Reduzida = loc_cSecao3Reduzida + "*-- SECAO REDUZIDA PARA EVITAR 'Prompt is too long'" + CHR(13) + CHR(10)
loc_cSecao3Reduzida = loc_cSecao3Reduzida + "*-- O arquivo mapeamento.json contem informacoes sobre os objetos" + CHR(13) + CHR(10)
loc_cSecao3Reduzida = loc_cSecao3Reduzida + "*-- Use as SECAO 1 e 2 para estrutura e propriedades" + CHR(13) + CHR(10)
loc_cSecao3Reduzida = loc_cSecao3Reduzida + CHR(13) + CHR(10)

? "  Tamanho SECAO 3 reduzida: " + TRANSFORM(LEN(loc_cSecao3Reduzida)) + " bytes"

*-- Recombinar
loc_cConteudo = loc_cAntes + loc_cSecao3Reduzida + loc_cDepois

? "  Tamanho final: " + TRANSFORM(LEN(loc_cConteudo)) + " bytes"

*-- Gerar nome do arquivo de saida
loc_cArquivoSlim = STRTRAN(par_cArquivoOrigem, ".txt", "_slim.txt")

*-- Salvar
? "  Salvando: " + loc_cArquivoSlim
STRTOFILE(loc_cConteudo, loc_cArquivoSlim)

IF FILE(loc_cArquivoSlim)
    ADIR(loc_aArquivo, loc_cArquivoSlim)
    ? "  SUCESSO! Tamanho: " + TRANSFORM(INT(loc_aArquivo[1,2]/1024)) + " KB"
ELSE
    ? "  ERRO: Arquivo nao foi criado"
ENDIF

RETURN loc_cArquivoSlim
