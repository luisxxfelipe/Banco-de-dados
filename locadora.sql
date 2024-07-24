CREATE database locadora;
USE locadora;

CREATE table ator(
	codAtor int not null PRIMARY KEY auto_increment,
    nome varchar(50) not null
);

CREATE table cliente(
	codCliente int not null PRIMARY KEY auto_increment, 
    nome varchar(50) not null,
    endereco varchar(50) not null 
);

CREATE table categoria(
	codCateg int not null PRIMARY KEY auto_increment,
	nome varchar(50) not null
);

CREATE table filme(
	idFilme int not null PRIMARY KEY auto_increment,
    titulo varchar(50) not null,
    codCateg int not null,
    FOREIGN KEY (codCateg) REFERENCES categoria(codCateg)
);

CREATE table atorFilme(
	codAtor int not null,
    idFilme int not null,
    FOREIGN KEY (codAtor) REFERENCES ator(codAtor),
    FOREIGN KEY (idFilme) REFERENCES filme(idfilme),
    PRIMARY KEY (codAtor, idFilme)
);

CREATE table fita(
	idFita int not null PRIMARY KEY auto_increment,
    idFilme int not null,
    FOREIGN KEY (idFilme) REFERENCES filme(idFilme)
);

CREATE table locacao(
	idLocacao int not null PRIMARY KEY auto_increment,
	horaLoc time, 
    dataLoc date, 
    dataEntrega date,
    codCliente int not null,
    idFita int not null,
    FOREIGN KEY (codCliente) REFERENCES cliente(codCliente),
    FOREIGN KEY (idFita) REFERENCES fita(idFita)
);

INSERT INTO categoria (nome) VALUES ('Ação'), ('Drama'), ('Comédia');
INSERT INTO ator (nome) VALUES ('João Marcos'), ('Marcos Ribeiro'), ('Luis França'), ('Carlos Roberto'), ('Monia França');
INSERT INTO filme (titulo, codCateg) VALUES ('Casa Velha e os Monstros', 1), ('American Pie', 2), ('Tropa de Elite', 3), ('Velozes e Furiosos', 1), ('EuroTrip', 2);

SELECT f.titulo, a.nome
FROM filme f
JOIN atorFilme af ON f.idFilme = af.idFilme
JOIN ator a ON af.codAtor = a.codAtor;

SELECT f.*, c.nome AS categoria
FROM filme f
JOIN categoria c ON f.codCateg = c.codCateg;

SELECT f.titulo, c.nome AS categoria
FROM filme f
JOIN atorFilme af ON f.idFIlme = af.idFilme
JOIN ator a ON af.codAtor = a.codAtor
JOIN categoria c ON f.codCateg = c.codCateg
WHERE a.nome = 'João Marcos';

drop table categoria; 

-- não foi aceito deletar a tabela categoria, haja visto que foi inserido dados nela e
-- por restrição, não é aceito realizar este processo (necessario apagar tudo antes)

SELECT count(*) AS total_filmes from filme WHERE titulo LIKE 'C%'; 
SELECT count(*) AS total_categ_3 from filme WHERE codCateg = 3;

CREATE TABLE filme_aux (
    idFilme INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(50) NOT NULL,
    codCateg INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL DEFAULT 10.50, -- Adiciona a coluna "valor" com o valor padrão
    FOREIGN KEY (codCateg) REFERENCES categoria(codCateg)
);

INSERT INTO filme_aux (idFilme, titulo, codCateg) SELECT idFilme, titulo, codCateg FROM filme;

DROP TABLE filme;

ALTER table filme_aux RENAME TO filme;

SELECT COUNT(*) as filmes_menor_80 FROM filme WHERE valor < 80;

UPDATE filme SET valor = valor * 1.1 WHERE codCateg IN (1, 2);

SELECT c.nome AS categoria, AVG(f.valor) AS media_valor FROM filme f JOIN categoria c ON f.codCateg = c.codCateg GROUP BY c.codCateg, c.nome;

DELETE FROM filme WHERE valor IS NULL;
