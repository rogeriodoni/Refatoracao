-- =============================================================================
-- Erro377 (imagem erro377.png) - Dados de TESTE para "Impressao de Cartas"
--           (Formsigreimc / sigreimcBO / SigReImc.frx - carta de correcao de NF)
-- O relatorio junta SigNfCor (correcoes) x SigMvNfi (NF) x SigCdCli (cliente)
-- x SigCcOco (ocorrencias). SigCcOco estava VAZIA -> o JOIN nunca devolvia nada.
-- SigNfCor so tinha 2 linhas de lixo (empresas 'Q'/'V').
-- Cria:
--   SigCcOco 91 RAZAO SOCIAL / 92 ENDERECO DO DESTINATARIO / 93 DESCRICAO DO PRODUTO
--   Correcoes nas NFs reais da empresa 001, serie 1, cliente ELIZETE CARVALHO
--   (C001000034, RUA RIO DE JANEIRO - BELO HORIZONTE/MG), emitidas em 13/03/2024:
--     NF 000032 -> ocorrencias 92 e 93 (duas correcoes na mesma carta)
--     NF 000033 -> ocorrencia 93
--   NF 000034 fica SEM correcao (nao pode aparecer).
-- Teste como a tela Carta de Correcao chama: empresa 001, serie 1,
-- emissao 01/03/2024 a 31/03/2024, nota 000032 a 000032 (ou 000032 a 000034).
-- Copias = SigCdPam.viacarta (4) -> cada correcao sai em 4 vias.
-- Marcadores: SigCcOco.ncodigos 91..93 | SigNfCor.cidchaves LIKE 'T377%'
-- Idempotente. Limpeza: erro377_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
DELETE FROM SigNfCor WHERE cidchaves LIKE 'T377%';
DELETE FROM SigCcOco WHERE ncodigos IN (91, 92, 93);

INSERT INTO SigCcOco (ncodigos, cdescrs) VALUES
 (91, 'RAZAO SOCIAL'),
 (92, 'ENDERECO DO DESTINATARIO'),
 (93, 'DESCRICAO DO PRODUTO');

INSERT INTO SigNfCor (cemps, cseries, cnfis, noccors, mretifs, cidchaves) VALUES
 ('001', '1', '000032', 92, 'ONDE SE LE: RUA RIO DE JANEIRO, S/N  LEIA-SE: RUA RIO DE JANEIRO, 1500 - APTO 302', 'T377COR01'),
 ('001', '1', '000032', 93, 'ITEM 1 - ONDE SE LE: ANEL OURO 18K  LEIA-SE: ANEL OURO 18K COM 2 PEROLAS', 'T377COR02'),
 ('001', '1', '000033', 93, 'ITEM 2 - ONDE SE LE: CORRENTE 45CM  LEIA-SE: CORRENTE 50CM', 'T377COR03');

SELECT f.cemps, f.cseries, f.cnfis, f.noccors, o.cdescrs, CONVERT(char(10), n.emis, 103) emis, c.rclis,
       CAST(f.mretifs AS varchar(60)) mretifs
  FROM SigNfCor f, SigMvNfi n, SigCdCli c, SigCcOco o
 WHERE f.cnfis = n.nfis AND f.cemps = n.emps AND f.cseries = n.series
   AND n.clifors = c.iclis AND f.noccors = o.ncodigos AND f.cidchaves LIKE 'T377%'
 ORDER BY f.cnfis, f.noccors;
