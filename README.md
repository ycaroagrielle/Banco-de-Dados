# 🚀 Sistema de Gestão Acadêmica — PostgreSQL

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-blue?style=for-the-badge&logo=postgresql)
![SQL](https://img.shields.io/badge/SQL-Queries-orange?style=for-the-badge)
![Status](https://img.shields.io/badge/status-em%20desenvolvimento-green?style=for-the-badge)

---

# 📚 Sobre o Projeto

Este projeto consiste em um sistema de **Gestão Acadêmica** desenvolvido utilizando **PostgreSQL**, com o objetivo de aplicar na prática conceitos de modelagem de banco de dados relacional, manipulação de dados e consultas SQL.

O sistema realiza o gerenciamento de:

- 👨‍🎓 Alunos
- 👨‍🏫 Professores
- 📖 Cursos
- 📝 Disciplinas
- 🏫 Turmas
- 📋 Matrículas

O projeto foi desenvolvido como atividade prática da disciplina de Banco de Dados.

---

# 🛠️ Tecnologias Utilizadas

- 🐘 PostgreSQL
- SQL
- pgAdmin
- Git & GitHub

---

# 🧠 Conceitos Aplicados

✔️ CREATE DATABASE  
✔️ CREATE TABLE  
✔️ INSERT INTO  
✔️ UPDATE  
✔️ DELETE  
✔️ SELECT  
✔️ INNER JOIN  
✔️ LEFT JOIN  
✔️ GROUP BY  
✔️ HAVING  
✔️ SUBQUERY  
✔️ CASE  
✔️ Constraints  
✔️ Chaves Primárias e Estrangeiras  
✔️ Relacionamentos Relacionais  

---

# 🗂️ Estrutura do Projeto

```bash
📦 sistema-gestao-academica
 ┣ 📂 sql
 ┃ ┣ 📜 schema.sql
 ┃ ┣ 📜 inserts.sql
 ┃ ┣ 📜 updates.sql
 ┃ ┣ 📜 deletes.sql
 ┃ ┣ 📜 queries.sql
 ┃ ┣ 📜 views.sql
 ┃ ┗ 📜 triggers.sql
 ┣ 📂 docs
 ┃ ┗ 📜 DER.png
 ┣ 📜 README.md
 ┗ 📜 LICENSE
```

---

# 🏗️ Estrutura do Banco

## 👨‍🎓 alunos

Tabela responsável pelo armazenamento dos alunos cadastrados.

| Campo | Tipo |
|---|---|
| id_aluno | SERIAL |
| nome | VARCHAR |
| cpf | VARCHAR |
| email | VARCHAR |
| data_nascimento | DATE |

---

## 👨‍🏫 professores

| Campo | Tipo |
|---|---|
| id_professor | SERIAL |
| nome | VARCHAR |
| especialidade | VARCHAR |
| email | VARCHAR |

---

## 📖 cursos

| Campo | Tipo |
|---|---|
| id_curso | SERIAL |
| nome_curso | VARCHAR |
| carga_horaria | INTEGER |

---

## 📝 disciplinas

| Campo | Tipo |
|---|---|
| id_disciplina | SERIAL |
| nome_disciplina | VARCHAR |
| carga_horaria | INTEGER |
| id_curso | INTEGER |

---

## 🏫 turmas

| Campo | Tipo |
|---|---|
| id_turma | SERIAL |
| semestre | VARCHAR |
| turno | VARCHAR |
| id_disciplina | INTEGER |
| id_professor | INTEGER |

---

## 📋 matriculas

| Campo | Tipo |
|---|---|
| id_matricula | SERIAL |
| id_aluno | INTEGER |
| id_turma | INTEGER |
| data_matricula | DATE |
| status | VARCHAR |

---

# 🔗 Relacionamentos

- disciplinas → cursos
- turmas → disciplinas
- turmas → professores
- matriculas → alunos
- matriculas → turmas

---

# ⚙️ Como Executar

## 1️⃣ Clone o repositório

```bash
git clone https://github.com/seuusuario/sistema-gestao-academica.git
```

---

## 2️⃣ Crie o banco de dados

```sql
CREATE DATABASE gestao_academica;
```

---

## 3️⃣ Execute os scripts SQL

Ordem recomendada:

```bash
schema.sql
inserts.sql
updates.sql
deletes.sql
queries.sql
```

---

# 🔎 Exemplos de Consultas

## 📌 Listar todos os alunos

```sql
SELECT * FROM alunos;
```

---

## 📌 Disciplinas ordenadas por nome

```sql
SELECT * 
FROM disciplinas
ORDER BY nome_disciplina;
```

---

## 📌 Quantidade de alunos por turma

```sql
SELECT 
    t.id_turma,
    COUNT(m.id_aluno) AS quantidade_alunos
FROM turmas t
LEFT JOIN matriculas m 
ON t.id_turma = m.id_turma
GROUP BY t.id_turma;
```

---

# 🚀 Funcionalidades Extras

- Views
- Índices
- Triggers
- Procedures
- Functions
- Constraints adicionais

---

# 👨‍💻 Autor

## Ycaro Agrielle Martiniano Nobre de Lacerda

🎓 Estudante de Análise e Desenvolvimento de Sistemas  
📍 Recife - PE  
💻 Focado em PostgreSQL, Banco de Dados e Back-end

---

# 📜 Licença

Este projeto está sob a licença MIT.
