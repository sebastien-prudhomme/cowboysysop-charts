wget --quiet --show-progress -O audio.ogg https://upload.wikimedia.org/wikipedia/commons/1/1f/George_W_Bush_Columbia_FINAL.ogg

curl http://local-ai.internal/v1/audio/transcriptions -H "Content-Type: multipart/form-data" -F file="@$PWD/audio.ogg" -F model="whisper-1"

rm -f audio.ogg
