curl http://local-ai.internal/v1/chat/completions -H "Content-Type: application/json" -d '{
     "model": "vicuna",
     "messages": [{"role": "user", "content": "Explain the thales theorem"}]
   }'
