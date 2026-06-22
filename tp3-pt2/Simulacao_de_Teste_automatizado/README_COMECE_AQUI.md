# ⚡ COMECE AQUI - RESUMO EXECUTIVO

## O QUE VOCÊ PRECISA FAZER EM 5 PASSOS

### PASSO 1: Copie o Código (2 minutos)
Crie 2 arquivos JavaScript com o código fornecido:

```
Projeto/
├── src/
│   └── validacao.js          ← Copiar de "validacao.test.js" (parte superior)
├── test/
│   └── validacao.test.js     ← Copiar arquivo completo
└── package.json              ← Copiar abaixo
```

**package.json:**
```json
{
  "name": "testes-automatizados",
  "version": "1.0.0",
  "scripts": {
    "test": "jest"
  },
  "devDependencies": {
    "jest": "^29.5.0"
  }
}
```

---

### PASSO 2: Prepare o Ambiente (2 minutos)

```bash
# Abrir Terminal / PowerShell
npm install --save-dev jest
```

---

### PASSO 3: Execute os Testes (1 minuto)

```bash
npm test
```

**Resultado esperado:**
```
✓ 22 tests passed
✓ 1.890s
```

---

### PASSO 4: Prepare a Apresentação (5 minutos)

Revise estes 3 documentos na ordem:
1. `testes_automatizados_exemplo.md` ← Teoria completa
2. `guia_visual_rapido.md` ← Visual rápido
3. `roteiro_apresentacao.md` ← Script narrado

---

### PASSO 5: Demonstre (15-20 minutos)

Siga o roteiro de apresentação ao vivo na IDE.

---

## 📚 ARQUIVOS CRIADOS

| Arquivo | Propósito | Tempo |
|---------|-----------|-------|
| `testes_automatizados_exemplo.md` | Documentação técnica completa | 30 min leitura |
| `validacao.test.js` | Código pronto para copiar | copiar/colar |
| `guia_execucao_testes.md` | Como rodar em 3 IDEs | 10 min |
| `roteiro_apresentacao.md` | Script narrado + slides | 15-20 min |
| `guia_visual_rapido.md` | Diagrama e resumo | 5 min consulta |

---

## 🎯 ESTRUTURA DA APRESENTAÇÃO (20 MIN)

```
MIN 0-2     Introdução
MIN 2-4     Requisitos e História
MIN 4-6     Classes de Equivalência
MIN 6-8     Casos de Teste Manuais
MIN 8-12    Abrindo Código + Testes
MIN 12-15   Executando npm test (ao vivo)
MIN 15-18   Analisando Matriz
MIN 18-20   Conclusão + Perguntas
```

---

## ✅ O QUE VOCÊ VAI DEMONSTRAR

1. **Caso de Teste Manual (CT-001)**
   - Mostrar documento com passos
   - Exemplo: "Inserir email válido, clicar, resultado esperado: sucesso"

2. **Teste Automatizado Correspondente**
   - Mostrar código JavaScript
   - Exemplo: `expect(resultado.valido).toBe(true)`

3. **Execução na IDE**
   - Terminal: `npm test`
   - Output: "✓ 22 passed"

4. **Resultado Obtido**
   - Gráfico: 22/22 testes ✅
   - Tempo: 1.890 segundos

5. **Relação Requisito → CE → Automação**
   - Matriz de rastreabilidade
   - Diagrama visual

---

## 📊 EXEMPLO RÁPIDO

**Requisito:** Email deve ter formato válido (REQ-001)

**Classe de Equivalência 1:** Email válido
- Entrada: `usuario@email.com`
- Saída: `✅ Válido`

**Caso de Teste Manual (CT-001):**
```
1. Inserir: usuario@email.com
2. Clicar em Cadastrar
3. Resultado esperado: "Cadastro realizado com sucesso"
```

**Teste Automatizado:**
```javascript
test('CT-001: Email válido', () => {
  const resultado = validador.validarEmail('usuario@email.com');
  expect(resultado.valido).toBe(true);
});
```

**Quando Executar:** ✅ PASSA

---

**Classe de Equivalência 2:** Email sem @
- Entrada: `usuarioemail.com`
- Saída: `❌ Inválido`

**Caso de Teste Manual (CT-002):**
```
1. Inserir: usuarioemail.com
2. Clicar em Cadastrar
3. Resultado esperado: "Email inválido"
```

**Teste Automatizado:**
```javascript
test('CT-002: Email sem @', () => {
  const resultado = validador.validarEmail('usuarioemail.com');
  expect(resultado.valido).toBe(false);
});
```

**Quando Executar:** ✅ PASSA

---

## 🎬 DEMO RÁPIDA (15 MIN)

### Minuto 0-5: Abrir IDE + Mostrar Código

```
VS Code
├── Explorer (esquerda)
│   ├── src/validacao.js
│   └── test/validacao.test.js
└── Editor (centro)
    └── Código visível
```

### Minuto 5-10: Mostrar Código + Explicar

```javascript
// Isso é o código a testar (src/validacao.js)
class ValidadorCadastro {
  validarEmail(email) {
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!regex.test(email)) {
      return { valido: false, mensagem: "Email inválido" };
    }
    return { valido: true, mensagem: "Email válido" };
  }
}

// Isso é o teste automatizado (test/validacao.test.js)
test('Email válido', () => {
  const resultado = validador.validarEmail('usuario@email.com');
  expect(resultado.valido).toBe(true);  // ← Assertion
});
```

**O que dizer:**
- "Este é o código a testar"
- "Este é o teste automatizado"
- "A assertion verifica se o resultado está correto"

### Minuto 10-15: Executar

```bash
# Terminal
npm test

# Output
PASS test/validacao.test.js
✓ 22 passed in 1.890s
```

**O que dizer:**
- "Todos os 22 testes passaram"
- "Levou menos de 2 segundos"
- "Verde significa sucesso"

---

## 🔧 TROUBLESHOOTING RÁPIDO

**Erro: "jest not found"**
```bash
npm install --save-dev jest
npm test
```

**Erro: "Cannot find module"**
- Verificar se arquivo está em `src/validacao.js`
- Verificar se é `.js` (não `.txt`)

**Testes não encontrados**
- Verificar se arquivo é `validacao.test.js`
- Arquivo deve estar na pasta `test/`

---

## 💡 DICAS DE OURO

✅ **Faça:**
- Execute ao vivo (não use prints antigos)
- Mostre um teste FALHANDO (depois corrija)
- Explique cada assertion
- Relate requisito ao teste

❌ **Evite:**
- Ler código linha por linha
- Mostrar código rápido demais
- Não executar os testes
- Testes sem requisito claro

---

## 📋 PERGUNTAS FREQUENTES

**P: Preciso de 3 testes ou 3 testes por requisito?**
- R: Mínimo 3 testes automatizados totais
- Você tem 22 = mais que suficiente ✅

**P: Pode ser outra linguagem?**
- R: Sim! Python, Java, C#, etc.
- Conceito é igual

**P: Preciso de casos de teste manuais?**
- R: Sim! Pelo menos 1 caso manual por teste
- Você tem 3 casos + testes automatizados

**P: Preciso mostrar tudo falhando depois passando?**
- R: Recomendado! Mostra confiança nos testes

**P: Quanto tempo leva?**
- R: Preparação: 30 min | Apresentação: 15-20 min

---

## 🚀 PRÓXIMAS ETAPAS

### Hoje
- [x] Copiar código
- [x] Instalar Jest
- [x] Executar testes
- [x] Verificar se passam

### Amanhã
- [ ] Revisar documentação
- [ ] Preparar slides
- [ ] Treinar narração
- [ ] Testar IDE configuração

### Dia da Apresentação
- [ ] Chegar 10 min cedo
- [ ] Testar internet/projetor
- [ ] Abrir IDE + terminal
- [ ] Executar npm test
- [ ] Apresentar com confiança!

---

## 📞 RESUMO EM UMA LINHA

**Requisito → Classe de Equivalência → Caso Manual → Teste Automatizado → npm test → ✅**

---

## 🎓 CONCEITOS-CHAVE A MENCIONAR

1. **Teste Automatizado** = Código que testa código
2. **Caso de Teste Manual** = Documentação de como testar
3. **Classe de Equivalência** = Grupos de dados similares
4. **Assertion** = Afirmação sobre o resultado esperado
5. **Requisito** = O que o software deve fazer
6. **Rastreabilidade** = Cada requisito tem seu teste

---

**VOCÊ ESTÁ PRONTO! 🎉**

Agora é só cumprir os 5 passos e apresentar com confiança.

Qualquer dúvida, revise os documentos em ordem:
1. Exemplo Técnico (entender)
2. Guia Execução (rodar)
3. Roteiro Apresentação (apresentar)
4. Guia Visual (consultar)

**Tempo total:** 30-40 minutos de preparação + 15-20 minutos de apresentação.

**Boa sorte! 🚀**
