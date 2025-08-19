#!/bin/bash
# Retransmissão da saída do SRS para o YouTube

# Configurações
SRS_SOURCE="rtmp://localhost/live/livestream"  # Saída do seu SRS
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2/STREAM_KEY"  # Sua chave YouTube
LOG_DIR="/home/lucas/logs"
LOG_FILE="$LOG_DIR/youtube_restream.log"

# Criar diretório de logs
mkdir -p "$LOG_DIR"
chmod 777 "$LOG_DIR"

# Função para limpeza
cleanup() {
  echo "[$(date)] Finalizando retransmissão..." >> "$LOG_FILE"
  pkill -P $$
  exit 0
}
trap cleanup SIGINT SIGTERM

# Verificar se o SRS está respondendo
echo "[$(date)] Verificando fonte SRS..." >> "$LOG_FILE"
if ! timeout 5 ffprobe -i "$SRS_SOURCE" >/dev/null 2>&1; then
  echo "[$(date)] ERRO: SRS não responde em $SRS_SOURCE" | tee -a "$LOG_FILE"
  exit 1
fi

# Loop de retransmissão
while true; do
  echo "[$(date)] Iniciando retransmissão para YouTube..." >> "$LOG_FILE"
  
  ffmpeg -i "$SRS_SOURCE" \      # Pega a saída do SRS
    -c:v copy -c:a copy \        # Mantém codecs originais (sem reprocessar)
    -f flv "$YOUTUBE_URL" 2>> "$LOG_FILE"

  echo "[$(date)] Conexão perdida. Reconectando em 10s..." >> "$LOG_FILE"
  sleep 10
done
