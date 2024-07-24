CREATE DATABASE ACERVO;
USE ACERVO;

CREATE TABLE cliente (
  cliente_id INT PRIMARY KEY,
  nome VARCHAR(100),
  endereco VARCHAR(100),
  cpf VARCHAR(50),
  email VARCHAR(100)
);

CREATE TABLE tipo_acervo (
  tipo_acervo_id INT PRIMARY KEY,
  nome VARCHAR(50)
);

CREATE TABLE editoria (
  editoria_id INT PRIMARY KEY,
  nome VARCHAR(50)
);

CREATE TABLE acervo (
  livro_id INT PRIMARY KEY,
  tipo_acervo_id INT,
  editoria_id INT,
  titulo VARCHAR(100),
  autor VARCHAR(100),
  FOREIGN KEY (tipo_acervo_id) REFERENCES tipo_acervo(tipo_acervo_id),
  FOREIGN KEY (editoria_id) REFERENCES editoria(editoria_id)
);

CREATE TABLE emprestimo (
  emprestimo_id INT PRIMARY KEY,
  livro_id INT,
  cliente_id INT,
  data_emprestimo DATE,
  data_devolucao DATE,
  FOREIGN KEY (livro_id) REFERENCES acervo(livro_id),
  FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
);

INSERT INTO tipo_acervo (tipo_acervo_id, nome) VALUES (1, 'Livro físico'), (2, 'E-book'), (3, 'Filme');

INSERT INTO editoria (editoria_id, nome) VALUES (1, 'Romance'), (2, 'Ficção Científica'), (3, 'Suspense'), (4, 'Comédia');

INSERT INTO acervo (livro_id, tipo_acervo_id, editoria_id, titulo, autor) VALUES (1, 1, 1, 'Orgulho e Preconceito', 'Jane Austen'), (2, 1, 1, 'O Morro dos Ventos Uivantes', 'Emily Brontë'), 
(3, 2, 2, 'Duna', 'Frank Herbert'), (4, 2, 3, 'O Código Da Vinci', 'Dan Brown'), (5, 3, 4, 'Resident Evil', 'Paul W. S. Anderson');

INSERT INTO cliente (cliente_id, nome, endereco, email) VALUES (1, 'Luís Felipe', 'Rua Julio Nogueira, 123', 'luisfelipe@email.com'), (2, 'Maria', 'Rua Pantanal, 456', 'maria@email.com'),
(3, 'Rafael Alves', 'Rua Amazonas, 4533', 'rafael@email.com'), (5, 'Laura Moreira', 'Rua Paraná, 456', 'laura@email.com');

INSERT INTO emprestimo (emprestimo_id, livro_id, cliente_id, data_emprestimo, data_devolucao) VALUES (1, 1, 1, '2023-06-01', '2023-06-15'), (2, 2, 1, '2023-06-10', '2023-06-25'), 
(3, 2, 3, '2023-06-11', '2023-06-15'), (4, 2, 2, '2023-06-10', '2023-06-25');

SELECT acervo.titulo, acervo.autor FROM acervo WHERE acervo.livro_id = 1;
