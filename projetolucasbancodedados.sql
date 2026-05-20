ALTER TABLE disciplinas
  ADD CONSTRAINT fk_disciplinas_cursos 
  FOREIGN KEY (id_curso) REFERENCES cursos(id_curso);

ALTER TABLE turmas
  ADD CONSTRAINT fk_turmas_disciplinas 
  FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina);

ALTER TABLE turmas
  ADD CONSTRAINT fk_turmas_professores 
  FOREIGN KEY (id_professor) REFERENCES professores(id_professor);

ALTER TABLE matriculas
  ADD CONSTRAINT fk_matriculas_alunos 
  FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno);

ALTER TABLE matriculas
  ADD CONSTRAINT fk_matriculas_turmas 
  FOREIGN KEY (id_turma) REFERENCES turmas(id_turma);