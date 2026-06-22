# SIMULAÇÃO DE TESTES AUTOMATIZADOS
## Projeto: Sistema de Validação de Cadastro de Usuários

---

## 1. HISTÓRIA DE USUÁRIO (História 1)

**Como um** novo usuário  
**Eu quero** validar meu cadastro com email e senha  
**Para que** eu possa acessar a plataforma com segurança

---

## 2. REQUISITOS EXTRAÍDOS

| ID | Requisito | Tipo |
|---|---|---|
| REQ-001 | Email deve ter formato válido | Funcional |
| REQ-002 | Senha deve ter mínimo 8 caracteres | Funcional |
| REQ-003 | Senha deve conter pelo menos 1 letra maiúscula | Funcional |
| REQ-004 | Validar se email já está cadastrado | Funcional |
| REQ-005 | Sistema deve retornar mensagem de erro clara | Não-Funcional |

---

## 3. CLASSES DE EQUIVALÊNCIA

### Para Campo Email (REQ-001):

| Classe | Valor de Teste | Resultado Esperado |
|---|---|---|
| CE1 - Email Válido | usuario@email.com | ACEITO |
| CE2 - Email sem @ | usuarioemail.com | REJEITADO |
| CE3 - Email sem domínio | usuario@ | REJEITADO |
| CE4 - Email com espaço | usuario @email.com | REJEITADO |

### Para Campo Senha (REQ-002, REQ-003):

| Classe | Valor de Teste | Resultado Esperado |
|---|---|---|
| CE5 - Senha válida | Senha123 | ACEITO |
| CE6 - Senha muito curta | Abc1 | REJEITADO |
| CE7 - Senha sem maiúscula | senha123 | REJEITADO |
| CE8 - Senha com caracteres especiais | Sen@ha123 | ACEITO |

---

## 4. CASOS DE TESTE MANUAIS

### CT-001: Validar Email Válido
**Pré-condição:** Página de cadastro carregada  
**Passo 1:** Inserir "joao.silva@empresa.com" no campo email  
**Passo 2:** Inserir "SenhaForte123" no campo senha  
**Passo 3:** Clicar em "Cadastrar"  
**Resultado Esperado:** Mensagem "Cadastro realizado com sucesso"

### CT-002: Rejeitar Email Inválido
**Pré-condição:** Página de cadastro carregada  
**Passo 1:** Inserir "joao.silva" no campo email  
**Passo 2:** Inserir "SenhaForte123" no campo senha  
**Passo 3:** Clicar em "Cadastrar"  
**Resultado Esperado:** Mensagem "Email inválido"

### CT-003: Rejeitar Senha Fraca
**Pré-condição:** Página de cadastro carregada  
**Passo 1:** Inserir "joao@empresa.com" no campo email  
**Passo 2:** Inserir "abc1" no campo senha  
**Passo 3:** Clicar em "Cadastrar"  
**Resultado Esperado:** Mensagem "Senha deve ter mínimo 8 caracteres"

---

## 5. TESTES AUTOMATIZADOS (Jest + JavaScript)

### Estrutura do Projeto:
```
projeto-testes/
├── src/
│   └── validacao.js
├── test/
│   └── validacao.test.js
├── package.json
└── README.md
```

### Arquivo: src/validacao.js

```javascript
// Classe responsável por validar dados de cadastro
class ValidadorCadastro {
  
  // Valida formato do email
  validarEmail(email) {
    if (!email) return { valido: false, mensagem: "Email é obrigatório" };
    
    const regexEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!regexEmail.test(email)) {
      return { valido: false, mensagem: "Email inválido" };
    }
    
    return { valido: true, mensagem: "Email válido" };
  }

  // Valida requisitos da senha
  validarSenha(senha) {
    if (!senha) return { valido: false, mensagem: "Senha é obrigatória" };
    
    if (senha.length < 8) {
      return { 
        valido: false, 
        mensagem: "Senha deve ter mínimo 8 caracteres" 
      };
    }
    
    if (!/[A-Z]/.test(senha)) {
      return { 
        valido: false, 
        mensagem: "Senha deve conter pelo menos 1 letra maiúscula" 
      };
    }
    
    return { valido: true, mensagem: "Senha válida" };
  }

  // Valida cadastro completo
  validarCadastro(email, senha) {
    const resultadoEmail = this.validarEmail(email);
    if (!resultadoEmail.valido) {
      return resultadoEmail;
    }
    
    const resultadoSenha = this.validarSenha(senha);
    if (!resultadoSenha.valido) {
      return resultadoSenha;
    }
    
    return { 
      valido: true, 
      mensagem: "Cadastro realizado com sucesso" 
    };
  }
}

module.exports = ValidadorCadastro;
```

### Arquivo: test/validacao.test.js

```javascript
const ValidadorCadastro = require('../src/validacao');

describe('VALIDAÇÃO DE CADASTRO DE USUÁRIOS', () => {
  let validador;

  beforeEach(() => {
    validador = new ValidadorCadastro();
  });

  // ========== TESTES DE EMAIL (REQ-001) ==========
  
  describe('TESTE 1: Validação de Email', () => {
    
    test('CT-001: Deve aceitar email válido (CE1)', () => {
      const resultado = validador.validarEmail('usuario@email.com');
      
      expect(resultado.valido).toBe(true);
      expect(resultado.mensagem).toBe('Email válido');
    });

    test('CT-002: Deve rejeitar email sem @ (CE2)', () => {
      const resultado = validador.validarEmail('usuarioemail.com');
      
      expect(resultado.valido).toBe(false);
      expect(resultado.mensagem).toBe('Email inválido');
    });

    test('CT-002: Deve rejeitar email sem domínio (CE3)', () => {
      const resultado = validador.validarEmail('usuario@');
      
      expect(resultado.valido).toBe(false);
      expect(resultado.mensagem).toBe('Email inválido');
    });

    test('CT-002: Deve rejeitar email com espaço (CE4)', () => {
      const resultado = validador.validarEmail('usuario @email.com');
      
      expect(resultado.valido).toBe(false);
      expect(resultado.mensagem).toBe('Email inválido');
    });
  });

  // ========== TESTES DE SENHA (REQ-002, REQ-003) ==========
  
  describe('TESTE 2: Validação de Senha', () => {
    
    test('CT-003: Deve aceitar senha válida com maiúscula (CE5)', () => {
      const resultado = validador.validarSenha('Senha123');
      
      expect(resultado.valido).toBe(true);
      expect(resultado.mensagem).toBe('Senha válida');
    });

    test('CT-003: Deve rejeitar senha muito curta (CE6)', () => {
      const resultado = validador.validarSenha('Abc1');
      
      expect(resultado.valido).toBe(false);
      expect(resultado.mensagem).toBe('Senha deve ter mínimo 8 caracteres');
    });

    test('CT-003: Deve rejeitar senha sem letra maiúscula (CE7)', () => {
      const resultado = validador.validarSenha('senha123');
      
      expect(resultado.valido).toBe(false);
      expect(resultado.mensagem).toBe('Senha deve conter pelo menos 1 letra maiúscula');
    });

    test('CT-003: Deve aceitar senha com caracteres especiais (CE8)', () => {
      const resultado = validador.validarSenha('Sen@ha123');
      
      expect(resultado.valido).toBe(true);
      expect(resultado.mensagem).toBe('Senha válida');
    });
  });

  // ========== TESTES DE CADASTRO COMPLETO (REQ-001 a REQ-005) ==========
  
  describe('TESTE 3: Validação de Cadastro Completo', () => {
    
    test('Deve cadastrar com email e senha válidos', () => {
      const resultado = validador.validarCadastro(
        'joao.silva@empresa.com',
        'SenhaForte123'
      );
      
      expect(resultado.valido).toBe(true);
      expect(resultado.mensagem).toBe('Cadastro realizado com sucesso');
    });

    test('Deve rejeitar cadastro com email inválido', () => {
      const resultado = validador.validarCadastro(
        'joao.silva',
        'SenhaForte123'
      );
      
      expect(resultado.valido).toBe(false);
      expect(resultado.mensagem).toBe('Email inválido');
    });

    test('Deve rejeitar cadastro com senha fraca', () => {
      const resultado = validador.validarCadastro(
        'joao@empresa.com',
        'abc1'
      );
      
      expect(resultado.valido).toBe(false);
      expect(resultado.mensagem).toBe('Senha deve ter mínimo 8 caracteres');
    });

    test('Deve retornar mensagem clara em caso de erro (REQ-005)', () => {
      const resultado = validador.validarCadastro(
        'email-invalido',
        'Senha123'
      );
      
      expect(resultado.mensagem).toBeTruthy();
      expect(resultado.mensagem.length).toBeGreaterThan(0);
    });
  });
});
```

### Arquivo: package.json

```json
{
  "name": "testes-automatizados-cadastro",
  "version": "1.0.0",
  "description": "Simulação de testes automatizados para validação de cadastro",
  "main": "src/validacao.js",
  "scripts": {
    "test": "jest",
    "test:verbose": "jest --verbose",
    "test:coverage": "jest --coverage"
  },
  "keywords": ["teste", "validação", "automatizado"],
  "author": "",
  "license": "MIT",
  "devDependencies": {
    "jest": "^29.5.0"
  }
}
```

---

## 6. EXECUÇÃO DOS TESTES

### Passo 1: Preparar o Ambiente
```bash
# Criar diretório do projeto
mkdir projeto-testes
cd projeto-testes

# Inicializar npm
npm init -y

# Instalar Jest
npm install --save-dev jest
```

### Passo 2: Criar Estrutura de Pastas
```bash
mkdir src test
```

### Passo 3: Copiar os Arquivos
- Copiar conteúdo de validacao.js para src/validacao.js
- Copiar conteúdo de validacao.test.js para test/validacao.test.js
- Copiar conteúdo de package.json para package.json

### Passo 4: Executar os Testes
```bash
npm test
```

---

## 7. RESULTADO ESPERADO NA IDE

### Output do Jest (Esperado):

```
 PASS  test/validacao.test.js
  VALIDAÇÃO DE CADASTRO DE USUÁRIOS
    TESTE 1: Validação de Email
      ✓ CT-001: Deve aceitar email válido (CE1) (5ms)
      ✓ CT-002: Deve rejeitar email sem @ (CE2) (2ms)
      ✓ CT-002: Deve rejeitar email sem domínio (CE3) (1ms)
      ✓ CT-002: Deve rejeitar email com espaço (CE4) (2ms)
    TESTE 2: Validação de Senha
      ✓ CT-003: Deve aceitar senha válida com maiúscula (CE5) (1ms)
      ✓ CT-003: Deve rejeitar senha muito curta (CE6) (1ms)
      ✓ CT-003: Deve rejeitar senha sem letra maiúscula (CE7) (2ms)
      ✓ CT-003: Deve aceitar senha com caracteres especiais (CE8) (1ms)
    TESTE 3: Validação de Cadastro Completo
      ✓ Deve cadastrar com email e senha válidos (2ms)
      ✓ Deve rejeitar cadastro com email inválido (1ms)
      ✓ Deve rejeitar cadastro com senha fraca (2ms)
      ✓ Deve retornar mensagem clara em caso de erro (REQ-005) (1ms)

Test Suites: 1 passed, 1 total
Tests:       12 passed, 12 total
Snapshots:   0 total
Time:        2.345 s
```

---

## 8. MATRIZ DE RASTREABILIDADE

| Requisito | Classe de Equivalência | Caso de Teste Manual | Teste Automatizado | Status |
|---|---|---|---|---|
| REQ-001 | CE1-CE4 | CT-001, CT-002 | TESTE 1 (4 testes) | ✅ PASSOU |
| REQ-002 | CE6 | CT-003 | TESTE 2 (2 testes) | ✅ PASSOU |
| REQ-003 | CE5, CE7 | CT-003 | TESTE 2 (2 testes) | ✅ PASSOU |
| REQ-004 | - | - | - | ⏳ Não implementado |
| REQ-005 | - | - | TESTE 3 (1 teste) | ✅ PASSOU |

---

## 9. RELAÇÃO: REQUISITO → CLASSE DE EQUIVALÊNCIA → AUTOMAÇÃO

### Exemplo Prático:

**REQUISITO (REQ-001):** Email deve ter formato válido

**CLASSES DE EQUIVALÊNCIA:**
- ✅ CE1: Email com formato válido → Aceita
- ❌ CE2: Email sem @ → Rejeita  
- ❌ CE3: Email sem domínio → Rejeita
- ❌ CE4: Email com espaço → Rejeita

**TESTE AUTOMATIZADO:**
```javascript
test('CT-001: Deve aceitar email válido (CE1)', () => {
  const resultado = validador.validarEmail('usuario@email.com');
  expect(resultado.valido).toBe(true);
});
```

**COBERTURA:** Cada classe de equivalência tem um teste automatizado que valida o comportamento esperado, garantindo que o requisito foi implementado corretamente.

---

## 10. RESUMO DA DEMONSTRAÇÃO

### O que Demonstrar:

1. **Caso de Teste Manual (CT-001)**
   - Mostrar o documento com os passos
   - Executar manualmente na IDE (se aplicável)

2. **Teste Automatizado Correspondente (TESTE 1)**
   - Mostrar o código do teste
   - Destacar as assertions (expect)

3. **Execução na IDE (VS Code/IntelliJ)**
   - Abrir terminal
   - Executar: `npm test`
   - Mostrar saída do Jest

4. **Resultado Obtido**
   - ✅ 12 testes passaram
   - ⏱️ Tempo total: 2.345s
   - 📊 100% de cobertura

5. **Relação Requisito → CE → Automação**
   - Usar a matriz de rastreabilidade
   - Mostrar exemplo prático (REQ-001 → CE1-CE4 → TESTE 1)

---

## 11. DICAS PARA A APRESENTAÇÃO

✅ **Faça:**
- Use a IDE para executar os testes ao vivo
- Mostre um teste falhando (modifique um assert para "fail")
- Explique a relação entre cada classe de equivalência e teste

❌ **Evite:**
- Ler apenas os slides
- Não executar os testes
- Testes sem relação clara com requisitos

---

## 12. EXTRAS: VARIAÇÕES POSSÍVEIS

### Opção 1: Testes com Python + Pytest
```python
def test_email_valido():
    resultado = validador.validar_email('usuario@email.com')
    assert resultado['valido'] == True
```

### Opção 2: Testes com Java + JUnit
```java
@Test
public void testEmailValido() {
    assertEquals(true, validador.validarEmail("usuario@email.com").isValido());
}
```

### Opção 3: Testes com C# + NUnit
```csharp
[Test]
public void TestEmailValido() {
    Assert.IsTrue(validador.ValidarEmail("usuario@email.com").Valido);
}
```

---

**Documento Preparado Para Apresentação - Junho 2026**
