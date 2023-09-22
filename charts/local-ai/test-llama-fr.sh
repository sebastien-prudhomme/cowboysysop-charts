#wget http://192.168.1.51:8081/repository/huggingface-proxy/TheBloke/Wizard-Vicuna-7B-Uncensored-GGML/resolve/main/Wizard-Vicuna-7B-Uncensored.ggmlv3.q4_0.bin
#wget http://192.168.1.51:8081/repository/huggingface-proxy/TheBloke/Wizard-Vicuna-13B-Uncensored-GGML/resolve/main/Wizard-Vicuna-13B-Uncensored.ggmlv3.q4_0.bin
#wget http://192.168.1.51:8081/repository/huggingface-proxy/TheBloke/LLaMa-7B-GGML/resolve/main/llama-7b.ggmlv3.q4_0.bin
#wget http://192.168.1.51:8081/repository/huggingface-proxy/TheBloke/Vigogne-Instruct-13B-GGML/resolve/main/Vigogne-Instruct-13B.ggmlv3.q4_0.bin

#response=$(curl -s http://localhost:30000/models/apply -H "Content-Type: application/json" -d '{
#  "url": "github:go-skynet/model-gallery/vicuna.yaml",
#  "name": "vicuna",
#  "overrides": { "parameters": {"model": "vicuna" } },
#  "files": [
#    {
#      "filename": "vicuna",
#      "sha256": "c31a4edd96527dcd808bcf9b99e3894065ac950747dac84ecd415a2387454e7c",
#      "uri": "http://192.168.1.51:8081/repository/huggingface-proxy/TheBloke/Wizard-Vicuna-7B-Uncensored-GGML/resolve/main/Wizard-Vicuna-7B-Uncensored.ggmlv3.q4_0.bin"
#    }
#  ]
#}'
#)

#job_id=$(echo "$response" | jq -r '.uuid')

#while [ "$(curl -s http://localhost:30000/models/jobs/"$job_id" | jq -r '.processed')" != "true" ]; do
#  sleep 1
#done


curl http://localhost:30000/v1/chat/completions -H "Content-Type: application/json" -d '{
     "model": "vicuna",
     "messages": [{"role": "user", "content": "Explique le théorème de Thales"}]
   }'
