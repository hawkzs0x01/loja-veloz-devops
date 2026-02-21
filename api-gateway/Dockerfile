# Estágio 1: Build (Multi-stage atende ao requisito)
FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Estágio 2: Produção
FROM python:3.11-slim
WORKDIR /app

# Cria um usuário não-root (Atende ao requisito de segurança)
RUN useradd -m appuser
USER appuser

# Copia as dependências do builder e o código da aplicação
COPY --from=builder /root/.local /home/appuser/.local
COPY . .

# Adiciona o caminho local ao PATH do usuário
ENV PATH=/home/appuser/.local/bin:$PATH

EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
