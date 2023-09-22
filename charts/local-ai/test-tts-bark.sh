curl http://localhost:30000/tts -H "Content-Type: application/json" -d '{
            "backend": "bark",
            "input": "My fellow Americans, this day has brought terrible news and great sadness to our country"
          }' | aplay
