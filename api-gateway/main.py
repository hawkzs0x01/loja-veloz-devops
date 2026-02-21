from fastapi import FastAPI
import httpx # Você precisará adicionar 'httpx' no requirements.txt do gateway

app = FastAPI()

@app.get("/health")
def health_check():
    return {"status": "ok", "service": "gateway"}

@app.get("/api/pedidos")
async def proxy_pedidos():
    async with httpx.AsyncClient() as client:
        # Chama o serviço de pedidos pela rede interna do Docker/K8s
        response = await client.get("http://servico-pedidos:8000/pedidos")
        return response.json()
