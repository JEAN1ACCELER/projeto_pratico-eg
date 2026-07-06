# ============================================================================
# E-Project - Script de Configuração do Banco de Dados (Windows / PowerShell)
# ============================================================================
# Este script cria o banco de dados PostgreSQL "eproject" e o usuário,
# depois roda as migrations e o seed automaticamente.
#
# PRÉ-REQUISITO: PostgreSQL 16+ instalado (https://www.postgresql.org/download/windows/)
#
# USO:
#   1. Abra o PowerShell na pasta do backend
#   2. Execute: powershell -ExecutionPolicy Bypass -File setup-db.ps1
# ============================================================================

$ErrorActionPreference = "Stop"

# Tenta localizar o psql no PATH ou nos locais padrão de instalação
$psqlCandidates = @(
  "psql",
  "C:\Program Files\PostgreSQL\17\bin\psql.exe",
  "C:\Program Files\PostgreSQL\16\bin\psql.exe",
  "C:\Program Files\PostgreSQL\15\bin\psql.exe",
  "C:\Program Files\PostgreSQL\14\bin\psql.exe"
)

$psql = $null
foreach ($candidate in $psqlCandidates) {
  try {
    $null = & $candidate --version 2>$null
    $psql = $candidate
    Write-Host "✓ PostgreSQL encontrado: $psql" -ForegroundColor Green
    break
  } catch {}
}

if (-not $psql) {
  Write-Host "✗ PostgreSQL não encontrado!" -ForegroundColor Red
  Write-Host "  Instale o PostgreSQL em: https://www.postgresql.org/download/windows/"
  Write-Host "  Depois execute este script novamente."
  exit 1
}

# Senha do superusuário (postgres) - ajuste se necessário
$pgPassword = Read-Host "Digite a senha do superusuário 'postgres' do PostgreSQL"

$env:PGPASSWORD = $pgPassword

Write-Host "`n→ Criando banco de dados e usuário 'eproject'..." -ForegroundColor Cyan

# Cria o usuário e o banco
& $psql -U postgres -h localhost -c "DO \$\$ BEGIN IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'eproject') THEN CREATE ROLE eproject WITH LOGIN PASSWORD 'eproject'; END IF; END \$\$;"
& $psql -U postgres -h localhost -c "SELECT 'CREATE DATABASE eproject OWNER eproject' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'eproject')\gexec"

Write-Host "✓ Banco de dados 'eproject' criado!" -ForegroundColor Green

Remove-Item Env:\PGPASSWORD

# Agora roda as migrations do Prisma
Write-Host "`n→ Criando as tabelas no banco (Prisma)..." -ForegroundColor Cyan
npx prisma db push
if ($LASTEXITCODE -ne 0) {
  Write-Host "✗ Falha ao criar as tabelas." -ForegroundColor Red
  exit 1
}
Write-Host "✓ Tabelas criadas!" -ForegroundColor Green

# Roda o seed
Write-Host "`n→ Inserindo dados de demonstração (seed)..." -ForegroundColor Cyan
npm run seed
if ($LASTEXITCODE -ne 0) {
  Write-Host "✗ Falha ao rodar o seed." -ForegroundColor Red
  exit 1
}

Write-Host "`n================================================================" -ForegroundColor Green
Write-Host "  BANCO DE DADOS CONFIGURADO COM SUCESSO!" -ForegroundColor Green
Write-Host "================================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Usuários de demonstração (senha: senha123):"
Write-Host "  Admin:     admin@ufam.edu.br"
Write-Host "  Professor: victor.antunes@ufam.edu.br"
Write-Host "  Aluno:     ana.beatriz@ufam.edu.br"
Write-Host ""
Write-Host "Agora você pode iniciar o backend:  npm run dev"
Write-Host ""
