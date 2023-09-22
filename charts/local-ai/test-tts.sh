curl http://localhost:30000/tts -H "Content-Type: application/json" -d '{
            "input": "My fellow Americans, this day has brought terrible news and great sadness to our country",
            "model": "voice-it-riccardo_fasol-x-low.onnx"
          }' | aplay
