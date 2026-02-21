from fastapi import FastAPI
app = FastAPI()

@app.get("/health")
def health_check():
    return {"status": "ok", "service": "pagamentos"}

@app.get("/pagamentos")
def processar_pagamento():
    return {"status": "Pagamento Aprovado", "metodo": "PIX"}
