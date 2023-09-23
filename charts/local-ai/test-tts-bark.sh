curl http://local-ai.internal/tts -H "Content-Type: application/json" -d '{
            "backend": "bark",
            "input": "My fellow Americans, this day has brought terrible news and great sadness to our country"
          }' | aplay
