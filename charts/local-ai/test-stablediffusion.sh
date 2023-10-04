LOCALAI=http://local-ai.internal

curl $LOCALAI/v1/images/generations -H "Content-Type: application/json" -d '{
  "prompt": "A cute baby sea otter",
  "size": "256x256"
}'
