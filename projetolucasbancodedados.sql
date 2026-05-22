-- -------------------------------------------------------------------------
-- 1. CAMADA DE DEFINIÇÃO DE DADOS (DDL)
-- -------------------------------------------------------------------------

-- Tabela independente: Cursos
CREATE TABLE cursos (
    id_curso SERIAL PRIMARY KEY,
    nome_curso VARCHAR(100) NOT NULL,
    carga_horaria INTEGER NOT NULL
);

-- Tabela dependente: Disciplinas (Vínculo forte com Curso via NOT NULL)
CREATE TABLE disciplinas (
    id_disciplina SERIAL PRIMARY KEY,
    nome_disciplina VARCHAR(100) NOT NULL,
    carga_horaria INTEGER NOT NULL,
    id_curso INTEGER NOT NULL,
    CONSTRAINT fk_disciplinas_cursos FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

-- Tabela independente: Alunos
CREATE TABLE alunos (
    id_aluno SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    email VARCHAR(100),
    data_nascimento DATE
);

-- Tabela independente: Professores
CREATE TABLE professores (
    id_professor SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100),
    email VARCHAR(100)
);

-- Tabela de associação: Turmas (Vínculos obrigatórios via NOT NULL)
CREATE TABLE turmas (
    id_turma SERIAL PRIMARY KEY,
    semestre VARCHAR(10) NOT NULL,
    turno VARCHAR(20) NOT NULL,
    id_disciplina INTEGER NOT NULL,
    id_professor INTEGER NOT NULL,
    CONSTRAINT fk_turmas_disciplinas FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina),
    CONSTRAINT fk_turmas_professores FOREIGN KEY (id_professor) REFERENCES professores(id_professor)
);

-- Tabela de relacionamento: Matriculas (Garantia de Estado Consistente com NOT NULL)
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

-- -------------------------------------------------------------------------
-- 2. CAMADA DE MANIPULAÇÃO DE DADOS (DML)
-- -------------------------------------------------------------------------

-- População da tabela: Cursos
INSERT INTO cursos (nome_curso, carga_horaria) VALUES
('Análise e Desenvolvimento de Sistemas', 2000), 
('Direito', 3700), 
('Enfermagem', 4000);

-- População da tabela: Professores
INSERT INTO professores (nome, especialidade, email) VALUES
('Lucas Gomes', 'Banco de Dados', 'lucas@estacio.br'), 
('Maria Silva', 'Algoritmos', 'maria@estacio.br'),
('Jose Souza', 'Direito Civil', 'jose@estacio.br'), 
('Ana Paula', 'Anatomia', 'ana@estacio.br'),
('Carlos Lima', 'Sistemas Operacionais', 'carlos@estacio.br');

-- População da tabela: Disciplinas
INSERT INTO disciplinas (nome_disciplina, carga_horaria, id_curso) VALUES
('Banco de Dados I', 80, 1),
('Programação Web', 80, 1),
('Sistemas Operacionais', 80, 1),
('Algoritmos', 80, 1),
('Direito Penal', 60, 2),
('Direito Civil', 60, 2),
('Anatomia Humana', 120, 3),
('Enfermagem Clínica', 100, 3);

-- População da tabela: Turmas
INSERT INTO turmas (semestre, turno, id_disciplina, id_professor) VALUES
('2025.1', 'Noite', 1, 1),
('2025.1', 'Noite', 2, 2),
('2025.1', 'Manhã', 5, 3),
('2025.1', 'Tarde', 7, 4);

-- População da tabela: Alunos (Dataset de 60 registros controlados)
INSERT INTO alunos (nome, cpf, email, data_nascimento) VALUES
('Paulo Eduardo Peres', '10000000001', 'paulo.peres@email.com', '2005-04-10'),
('Maria Clara Santos', '10000000002', 'maria.santos@email.com', '2004-09-12'),
('João Victor Lima', '10000000003', 'joao.lima@email.com', '2003-08-01'),
('Ana Beatriz Costa', '10000000004', 'ana.costa@email.com', '2002-03-17'),
('Pedro Henrique Alves', '10000000005', 'pedro.alves@email.com', '2001-11-22'),
('Larissa Mendes Rocha', '10000000006', 'larissa.rocha@email.com', '2004-02-14'),
('Gabriel Souza Martins', '10000000007', 'gabriel.martins@email.com', '2003-06-30'),
('Juliana Ferreira Lima', '10000000008', 'juliana.lima@email.com', '2005-07-19'),
('Rafael Gomes Pereira', '10000000009', 'rafael.pereira@email.com', '2002-08-21'),
('Camila Oliveira Santos', '10000000010', 'camila.santos@email.com', '2004-05-09'),
('Bruno Henrique Costa', '10000000011', 'bruno.costa@email.com', '2001-12-01'),
('Amanda Silva Rocha', '10000000012', 'amanda.rocha@email.com', '2003-03-03'),
('Felipe Almeida Souza', '10000000013', 'felipe.souza@email.com', '2004-10-11'),
('Isabela Martins Costa', '10000000014', 'isabela.costa@email.com', '2002-01-08'),
('Lucas Henrique Melo', '10000000015', 'lucas.melo@email.com', '2005-09-25'),
('Mariana Barbosa Lima', '10000000016', 'mariana.lima@email.com', '2003-11-18'),
('Thiago Fernandes Silva', '10000000017', 'thiago.silva@email.com', '2001-04-27'),
('Bianca Rodrigues Alves', '10000000018', 'bianca.alves@email.com', '2002-07-13'),
('Matheus Pereira Costa', '10000000019', 'matheus.costa@email.com', '2004-06-06'),
('Vitória Nunes Rocha', '10000000020', 'vitoria.rocha@email.com', '2005-01-29'),
('Eduardo Lima Santos', '10000000021', 'eduardo.santos@email.com', '2001-08-10'),
('Gabriela Costa Silva', '10000000022', 'gabriela.silva@email.com', '2002-09-14'),
('Leonardo Alves Rocha', '10000000023', 'leonardo.rocha@email.com', '2004-03-07'),
('Beatriz Fernandes Lima', '10000000024', 'beatriz.lima@email.com', '2005-12-05'),
('Carlos Henrique Souza', '10000000025', 'carlos.souza@email.com', '2003-02-19'),
('Yasmin Oliveira Costa', '10000000026', 'yasmin.costa@email.com', '2001-06-01'),
('Gustavo Martins Silva', '10000000027', 'gustavo.silva@email.com', '2002-10-22'),
('Letícia Barbosa Santos', '10000000028', 'leticia.santos@email.com', '2005-05-13'),
('Daniel Pereira Lima', '10000000029', 'daniel.lima@email.com', '2003-07-08'),
('Sophia Rocha Mendes', '10000000030', 'sophia.mendes@email.com', '2004-11-30'),
('André Luiz Costa', '10000000031', 'andre.costa@email.com', '2002-04-15'),
('Larissa Fernanda Alves', '10000000032', 'larissa.alves@email.com', '2001-01-20'),
('Vinicius Gomes Lima', '10000000033', 'vinicius.lima@email.com', '2005-02-02'),
('Clara Beatriz Souza', '10000000034', 'clara.souza@email.com', '2004-08-17'),
('Henrique Martins Rocha', '10000000035', 'henrique.rocha@email.com', '2003-09-23'),
('Julia Cristina Silva', '10000000036', 'julia.silva@email.com', '2002-12-28'),
('Caio Henrique Mendes', '10000000037', 'caio.mendes@email.com', '2001-03-09'),
('Melissa Oliveira Lima', '10000000038', 'melissa.lima@email.com', '2004-06-12'),
('Renato Alves Costa', '10000000039', 'renato.costa@email.com', '2005-10-26'),
('Nicole Fernandes Souza', '10000000040', 'nicole.souza@email.com', '2002-07-02'),
('Arthur Gabriel Rocha', '10000000041', 'arthur.rocha@email.com', '2003-01-18'),
('Milena Barbosa Silva', '10000000042', 'milena.silva@email.com', '2004-02-27'),
('Samuel Henrique Lima', '10000000043', 'samuel.lima@email.com', '2001-09-16'),
('Evelyn Costa Mendes', '10000000044', 'evelyn.mendes@email.com', '2002-11-07'),
('Murilo Pereira Rocha', '10000000045', 'murilo.rocha@email.com', '2005-03-21'),
('Aline Cristina Santos', '10000000046', 'aline.santos@email.com', '2003-06-14'),
('Nathan Oliveira Lima', '10000000047', 'nathan.lima@email.com', '2001-08-29'),
('Livia Fernandes Costa', '10000000048', 'livia.costa@email.com', '2002-05-24'),
('Diego Henrique Rocha', '10000000049', 'diego.rocha@email.com', '2004-04-01'),
('Carolina Barbosa Alves', '10000000050', 'carolina.alves@email.com', '2005-07-15'),
('Igor Martins Souza', '10000000051', 'igor.souza@email.com', '2003-10-19'),
('Brenda Cristina Lima', '10000000052', 'brenda.lima@email.com', '2002-02-08'),
('Fernando Gomes Costa', '10000000053', 'fernando.costa@email.com', '2001-11-13'),
('Alícia Pereira Silva', '10000000054', 'alicia.silva@email.com', '2004-09-03'),
('Kevin Henrique Rocha', '10000000055', 'kevin.rocha@email.com', '2005-01-12'),
('Manuela Fernandes Alves', '10000000056', 'manuela.alves@email.com', '2003-12-17'),
('Rodrigo Costa Lima', '10000000057', 'rodrigo.lima@email.com', '2002-03-30'),
('Helena Martins Souza', '10000000058', 'helena.souza@email.com', '2001-05-05'),
('Enzo Gabriel Santos', '10000000059', 'enzo.santos@email.com', '2004-06-18'),
('Cecília Oliveira Rocha', '10000000060', 'cecilia.rocha@email.com', '2005-08-09');

-- População da tabela: Matriculas (Dataset de 60 registros controlados)
INSERT INTO matriculas (id_aluno, id_turma, status) VALUES
(1,1,'Ativo'),(2,1,'Ativo'),(3,1,'Ativo'),(4,1,'Ativo'),(5,1,'Trancado'),
(6,2,'Ativo'),(7,2,'Ativo'),(8,2,'Ativo'),(9,2,'Ativo'),(10,2,'Trancado'),
(11,3,'Ativo'),(12,3,'Ativo'),(13,3,'Ativo'),(14,3,'Ativo'),(15,3,'Trancado'),
(16,4,'Ativo'),(17,4,'Ativo'),(18,4,'Ativo'),(19,4,'Ativo'),(20,4,'Trancado'),
(21,1,'Ativo'),(22,1,'Ativo'),(23,1,'Ativo'),(24,1,'Ativo'),(25,1,'Ativo'),
(26,2,'Ativo'),(27,2,'Ativo'),(28,2,'Ativo'),(29,2,'Ativo'),(30,2,'Trancado'),
(31,3,'Ativo'),(32,3,'Ativo'),(33,3,'Ativo'),(34,3,'Ativo'),(35,3,'Trancado'),
(36,4,'Ativo'),(37,4,'Ativo'),(38,4,'Ativo'),(39,4,'Ativo'),(40,4,'Trancado'),
(41,1,'Ativo'),(42,1,'Ativo'),(43,1,'Ativo'),(44,1,'Ativo'),(45,1,'Ativo'),
(46,2,'Ativo'),(47,2,'Ativo'),(48,2,'Ativo'),(49,2,'Ativo'),(50,2,'Trancado'),
(51,3,'Ativo'),(52,3,'Ativo'),(53,3,'Ativo'),(54,3,'Ativo'),(55,3,'Trancado'),
(56,4,'Ativo'),(57,4,'Ativo'),(58,4,'Ativo'),(59,4,'Ativo'),(60,4,'Trancado');

-- Operações de Modificação Estruturada (UPDATE)
UPDATE alunos SET email = 'aluno.novo@email.com' WHERE id_aluno = 1;
UPDATE matriculas SET status = 'Trancado' WHERE id_matricula = 1;
UPDATE turmas SET id_professor = 3 WHERE id_turma = 2; -- Atualização preventiva de corpo docente

-- Operações de Exclusão Controlada (DELETE)
DELETE FROM matriculas WHERE id_matricula = 61;
DELETE FROM turmas WHERE id_turma = 10 AND id_turma NOT IN (SELECT id_turma FROM matriculas);

-- -------------------------------------------------------------------------
-- 3. CAMADA DE CONSULTA DE DADOS (DQL)
-- -------------------------------------------------------------------------

-- Consulta Simples: Listagem explícita de dados de alunos (Evitando SELECT *)
SELECT id_aluno, nome, cpf, email, data_nascimento FROM alunos;

-- Consulta Simples: Ordenação semântica de disciplinas
SELECT id_disciplina, nome_disciplina, carga_horaria FROM disciplinas ORDER BY nome_disciplina ASC;

-- Consulta Simples: Filtragem por estado de matrícula
SELECT id_matricula, id_aluno, id_turma, status FROM matriculas WHERE status = 'Ativo';

-- Consulta Complexa (JOIN 1): Relatório Consolidado de Matrículas (Resolução de ambiguidade)
SELECT 
    a.nome AS nome_aluno, 
    d.nome_disciplina, 
    p.nome AS nome_professor, 
    t.semestre
FROM matriculas m
JOIN alunos a ON m.id_aluno = a.id_aluno
JOIN turmas t ON m.id_turma = t.id_turma
JOIN disciplinas d ON t.id_disciplina = d.id_disciplina
JOIN professores p ON t.id_professor = p.id_professor;

-- Consulta Complexa (JOIN 2): Volumetria Populacional de Alunos por Turma com metadados
SELECT 
    t.id_turma, 
    d.nome_disciplina,
    t.semestre,
    COUNT(m.id_aluno) AS total_alunos 
FROM matriculas m
JOIN turmas t ON m.id_turma = t.id_turma
JOIN disciplinas d ON t.id_disciplina = d.id_disciplina
GROUP BY t.id_turma, d.nome_disciplina, t.semestre;

-- Consulta Complexa (JOIN 3): Mapeamento de Dependência entre Cursos e Disciplinas
SELECT 
    c.nome_curso, 
    d.nome_disciplina 
FROM cursos c 
JOIN disciplinas d ON c.id_curso = d.id_curso;