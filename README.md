# Loja Veloz - Cloud DevOps Architecture

Repositório do projeto prático de modernização da infraestrutura da **Loja Veloz**, focado em conteinerização, orquestração, CI/CD e observabilidade, desenvolvido para a disciplina de Cloud DevOps.

---

## Arquitetura e Tecnologias
- **Microsserviços:** Python (FastAPI) para Gateway, Pedidos, Pagamentos e Estoque.
- **Banco de Dados:** PostgreSQL isolado com volume persistente.
- **Ambiente Local:** Docker Compose (Multi-stage builds, Non-root user).
- **Produção Simulada:** Kubernetes (Minikube).
- **Orquestração K8s:** Deployments (Rolling Update), Services, ConfigMaps, Secrets, HPA (Autoscaling) e Pod Security Context.
- **CI/CD:** GitHub Actions (Linting com flake8, Build e Push).
- **IaC:** Terraform (Esqueleto para AWS EKS e VPC).

---

##  Instruções de Execução Rápida

### 1. Ambiente Local (Docker Compose)
Para rodar a arquitetura completa localmente para desenvolvimento:
\`\`\`bash
# Clone o repositório
git clone https://github.com/hawkzs0x01/loja-veloz-devops.git
cd loja-veloz-devops

# Suba os serviços
docker-compose up --build -d

# Teste o Gateway (que fará proxy para os serviços internos)
curl http://localhost:8000/health
\`\`\`
Para derrubar o ambiente: \`docker-compose down\`

### 2. Ambiente de Produção (Kubernetes)
Para implantar no cluster Kubernetes, certifique-se de ter o \`minikube\` e \`kubectl\` instalados.

\`\`\`bash
# 1. Carregue as imagens locais para o cluster Minikube
minikube image load loja-veloz-devops_api-gateway:latest
minikube image load loja-veloz-devops_servico-pedidos:latest
minikube image load loja-veloz-devops_servico-pagamentos:latest
minikube image load loja-veloz-devops_servico-estoque:latest

# 2. Aplique as configurações e credenciais
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/secret.yaml

# 3. Aplique as regras de autoscaling (HPA)
kubectl apply -f k8s/hpa.yaml

# 4. Aplique os Deployments e Services
kubectl apply -f k8s/pedidos.yaml
kubectl apply -f k8s/pagamentos.yaml
kubectl apply -f k8s/estoque.yaml
kubectl apply -f k8s/gateway.yaml

# 5. Verifique a saúde dos Pods
kubectl get pods
\`\`\`
