# Sistema de Gestão Acadêmica (SGBD: PostgreSQL)

Este repositório contém a especificação física, carga de dados de teste e consultas estruturadas para o ecossistema de banco de dados relacional de um **Sistema de Gestão Acadêmica**, desenvolvido como projeto prático para a disciplina de Banco de Dados.

## 👥 Integrantes do Grupo
* **Tarciso Ferreira Da Silva Neto**
* **Vinicius Lopes Rodrigues**
* **Matheus Gabriel Cândido de Souza**
* **Paulo Eduardo Peres**
* **Guilherme David Sena**
* **Daniel José Marques Carvalho**
* **Ycaro Agrielle Martiniano Nobre de Lacerda**

---

## 🎓 Informações Acadêmicas
* **Instituição:** Estácio
* **Disciplina:** Banco de Dados
* **Professor Orientador:** Lucas Clóvis
* **Abordagem Técnica:** Engenharia de Dados de Missão Crítica e Integridade Referencial Estrita

---

## 🏗️ Arquitetura do Banco de Dados

O modelo lógico foi projetado seguindo os princípios de **Clean Architecture** aplicados a dados e **Separation of Concerns (SoC)**, garantindo o isolamento de domínios e eliminando estados inconsistentes ou dados órfãos em ambiente de produção.

O ecossistema é composto por 6 entidades principais organizadas de forma relacional:

* **Cursos**: Entidade independente que gerencia as grades curriculares.
* **Disciplinas**: Depende obrigatoriamente de um curso (`NOT NULL`).
* **Professores**: Cadastro do corpo docente e suas respectivas especialidades.
* **Turmas**: Tabela de associação intermediária ligando disciplinas e professores.
* **Alunos**: Registro de discentes com índice único para CPF.
* **Matrículas**: Relacionamento muitos-para-muitos entre alunos e turmas com controle estrito de estado (`CHECK`).

### Decisões Arquiteturais e Resiliência
1. **Acoplamento Estrito via `NOT NULL`:** Todas as chaves estrangeiras (`FK`) foram declaradas explicitamente como `NOT NULL`. Isso impede anomalias comuns em sistemas legados, como turmas sem professores associados ou disciplinas vinculadas a cursos inexistentes.
2. **Constraints Nomeadas:** Restrições de integridade referencial utilizam a sintaxe `CONSTRAINT nome_da_constraint`. Esta abordagem garante uma observabilidade eficiente: caso ocorra uma falha de violação de dados em camadas de aplicação (Backend), os logs do SGBD retornarão o nome exato da regra de negócio violada.
3. **Domínio de Estados (`CHECK`):** A tabela de matrículas possui validação estrita de estado no motor do banco de dados, aceitando exclusivamente os valores `Ativo`, `Trancado` ou `Concluído`.

---

## 📊 Estrutura das Tabelas (DDL)

O esquema do banco de dados é gerado a partir do seguinte fluxo estrutural:

```sql
CREATE TABLE cursos (
    id_curso SERIAL PRIMARY KEY,
    nome_curso VARCHAR(100) NOT NULL,
    carga_horaria INTEGER NOT NULL
);

CREATE TABLE disciplinas (
    id_disciplina SERIAL PRIMARY KEY,
    nome_disciplina VARCHAR(100) NOT NULL,
    carga_horaria INTEGER NOT NULL,
    id_curso INTEGER NOT NULL,
    CONSTRAINT fk_disciplinas_cursos FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

CREATE TABLE alunos (
    id_aluno SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    email VARCHAR(100),
    data_nascimento DATE
);

CREATE TABLE professores (
    id_professor SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE turmas (
    id_turma SERIAL PRIMARY KEY,
    semestre VARCHAR(10) NOT NULL,
    turno VARCHAR(20) NOT NULL,
    id_disciplina INTEGER NOT NULL,
    id_professor INTEGER NOT NULL,
    CONSTRAINT fk_turmas_disciplinas FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina),
    CONSTRAINT fk_turmas_professores FOREIGN KEY (id_professor) REFERENCES professores(id_professor)
);

CREATE TABLE matriculas (
    id_matricula SERIAL PRIMARY KEY,
    id_aluno INTEGER NOT NULL,
    id_turma INTEGER NOT NULL,
    data_matricula DATE DEFAULT CURRENT_DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Ativo' NOT NULL,
    CONSTRAINT fk_matriculas_alunos FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    CONSTRAINT fk_matriculas_turmas FOREIGN KEY (id_turma) REFERENCES turmas(id_turma),
    CONSTRAINT chk_matriculas_status CHECK (status IN ('Ativo', 'Trancado', 'Concluído'))
);