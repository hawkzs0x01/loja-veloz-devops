from fastapi import FastAPI
app = FastAPI()

@app.get("/health")
def health_check():
    return {"status": "ok", "service": "estoque"}

@app.get("/estoque")
def verificar_estoque():
    return {"item": "Notebook", "quantidade_disponivel": 42}

