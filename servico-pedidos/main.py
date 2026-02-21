from fastapi import FastAPI
app = FastAPI()

@app.get("/health")
def health_check():
    return {"status": "ok", "service": "pedidos"}

@app.get("/pedidos")
def get_pedidos():
    return {"pedidos": [{"id": 1, "item": "Notebook", "status": "Aprovado"}]}
