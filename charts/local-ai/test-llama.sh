# Comparatif : https://huggingface.co/spaces/HuggingFaceH4/open_llm_leaderboard

#wget http://192.168.1.51:8081/repository/huggingface-proxy/TheBloke/Wizard-Vicuna-7B-Uncensored-GGML/resolve/main/Wizard-Vicuna-7B-Uncensored.ggmlv3.q4_0.bin
#wget http://192.168.1.51:8081/repository/huggingface-proxy/TheBloke/Wizard-Vicuna-13B-Uncensored-GGML/resolve/main/Wizard-Vicuna-13B-Uncensored.ggmlv3.q4_0.bin
#wget http://192.168.1.51:8081/repository/huggingface-proxy/TheBloke/LLaMa-7B-GGML/resolve/main/llama-7b.ggmlv3.q4_0.bin

#wget http://192.168.1.51:8081/repository/huggingface-proxy/TheBloke/Samantha-7B-GGML/resolve/main/Samantha-7B.ggmlv3.q4_0.bin
#wget http://192.168.1.51:8081/repository/huggingface-proxy/TheBloke/Samantha-7B-GPTQ/resolve/main/Samantha-7B-GPTQ-4bit-128g.no-act-order.safetensors

curl http://local-ai.internal/v1/chat/completions -H "Content-Type: application/json" -d '{
     "model": "vicuna-7b",
     "messages": [{"role": "user", "content": "Comment exposer un pod dans Kubernetes à la ligne de commande"}]
   }'
