-- 1. Ativa a extensão (caso a imagem docker não tenha ativado automaticamente)
CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;

-- 2. Converte tabelas normais em Hypertables (Particionamento por tempo)
SELECT create_hypertable ('raw_telemetry', 'time');

SELECT create_hypertable ('analyzed_data', 'time');

SELECT create_hypertable ('ai_anomalies', 'time');

SELECT create_hypertable ('alarm_history', 'time');

-- 3. Define as Políticas de Retenção (Data Retention) - MVP Rules
-- Dados brutos vivem pouco (7 dias)
SELECT add_retention_policy ( 'raw_telemetry', INTERVAL '7 days' );

-- Dados analisados e anomalias vivem mais (30 dias)
SELECT add_retention_policy ( 'analyzed_data', INTERVAL '30 days' );

SELECT add_retention_policy ( 'ai_anomalies', INTERVAL '30 days' );

-- Histórico de Alarmes geralmente precisa de mais tempo para auditoria (Ex: 90 dias)
SELECT add_retention_policy ( 'alarm_history', INTERVAL '90 days' );

-- 4. Opcional: Ativa compressão para economizar disco (Excelente para hardware fraco)
ALTER TABLE raw_telemetry SET(
    timescaledb.compress,
    timescaledb.compress_segmentby = 'tag_id'
);

SELECT add_compression_policy ( 'raw_telemetry', INTERVAL '1 day' );