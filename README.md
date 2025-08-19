# 🎥 LiveStream Server 24/7  

Servidor de streaming automatizado utilizando **Linux, FFmpeg, Docker (SRS) e Shell Script** para transmissões contínuas no **YouTube/Twitch**.  

Este projeto demonstra habilidades em **automação, administração de servidores Linux, Docker e infraestrutura de streaming**.  

---

## 🚀 Tecnologias Utilizadas
- **Linux (Debian/Ubuntu)**  
- **Docker** – para rodar o SRS isolado em container  
- **FFmpeg** – codificação e envio de vídeo/áudio  
- **SRS (Simple Realtime Server)** – servidor RTMP/HLS/RTSP dentro do Docker  
- **Shell Script** – automação de inicialização e streaming  

---

## 📂 Estrutura do Projeto
```
livestream-server/
├── conf/             # Configurações (srs.conf, docker-compose.yml, etc)
├── docs/             # Documentação e diagramas
├── logs/             # Logs de execução
├── scripts/          
│   ├── start_srs.sh      # Inicia o container Docker com o SRS
│   └── stream_srs.sh     # Faz o streaming de vídeo/áudio com FFmpeg
└── README.md
```

---

## ⚙️ Como Funciona
1. O script `start_srs.sh` sobe o servidor **SRS** no Docker.  
2. O script `stream_srs.sh` envia vídeo/áudio para o endpoint RTMP do SRS.  
3. Retransmite o sinal do SRS para o youtube
3. Os logs de execução podem ser acompanhados em `logs/` ou via `docker logs`.  

---

## 🐳 Iniciando o SRS com Docker
### scripts/start_srs.sh
```bash
#!/bin/bash
docker run -d --name srs   -p 1935:1935 -p 8080:8080   -v $(pwd)/conf/srs.conf:/usr/local/srs/conf/srs.conf   ossrs/srs:4
```

Executar:
```bash
bash scripts/start_srs.sh
```

O servidor ficará disponível em:
```
rtmp://localhost:8080/live/stream
```

---

## 🎬 Iniciando a Transmissão
### scripts/stream_srs.sh
```bash
#!/bin/bash
URL="rtmp://localhost:8080/live/stream"
VIDEO="/home/user/videos/video.mp4"
AUDIO="/home/user/musics/audio.mp3"

ffmpeg -re -i "$VIDEO" -i "$AUDIO"   -c:v libx264 -preset veryfast   -c:a aac -b:a 128k   -shortest   -f flv "$URL"
```

Executar:
```bash
bash scripts/stream_srs.sh
```

---

## 🖥️ Logs
Verifique os logs do SRS:
```bash
docker logs -f srs
```

Ou salve a saída do streaming:
```bash
bash scripts/stream_srs.sh > logs/stream.log 2>&1
```

---

## 📺 Demonstração
Assista à demonstração do servidor em funcionamento:  

[![Demonstração da Live-stream](https://img.youtube.com/vi/p8mlPS_jHCc/0.jpg)](https://www.youtube.com/watch?v=p8mlPS_jHCc&t=2s "Demonstração da Live-stream")  

---

## ✨ Melhorias Futuras
- Suporte a playlists automáticas.  
- Monitoramento com **Prometheus + Grafana**.  
- Deploy automatizado com **Docker Compose** ou **Ansible**.  

---

## 👨‍💻 Autor
Projeto desenvolvido por **Lucas Vinicius Ribeiro de Jesus**  
📩 Contato: lucasvinij@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/) | [GitHub](https://github.com/)  
