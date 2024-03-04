-- drop database perguntasrespostas;
create database perguntasrespostas;
use perguntasrespostas;

create table usuario(
	id int auto_increment primary key,
	usuario varchar (200) unique,
    senha varchar(350),
    nome varchar(200)
);


create table disciplina(
	id int auto_increment primary key,
    nome varchar (100)
);


create table assunto(
	id int auto_increment primary key,
    nome varchar(100)
);
create table professor(
	id int auto_increment primary key,
    fk_usuario int,
    foreign key (fk_usuario) references usuario(id)
);
create table professorDisciplina(
	fk_disciplina int not null,
    foreign key (fk_disciplina) references disciplina(id),
    fk_professor int not null,
    foreign key (fk_professor) references professor(id),
	UNIQUE(fk_disciplina,fk_professor)
);


create table perguntas(
	id int auto_increment primary key,
	texto text not null,
    fk_disciplina int not null,
    foreign key (fk_disciplina) references disciplina(id),
    fk_professor int not null,
    foreign key (fk_professor) references professor(id)
);

create table perguntaAssunto(
	fk_perguntas int not null,
    foreign key (fk_perguntas) references perguntas(id),
    fk_assunto int not null,
    foreign key (fk_assunto) references assunto(id)
);

create table perguntaDiciplina(
	fk_perguntas int not null,
    foreign key (fk_perguntas) references perguntas(id),
    fk_disciplina int not null,
    foreign key (fk_disciplina) references disciplina(id)
);

create table alternativas(
	id int auto_increment primary key,
    texto text not null,
    correto boolean default false,
    fk_perguntas int not null,
    foreign key (fk_perguntas) references perguntas(id)
);

create table usuarioResponde(
	fk_perguntas int not null,
    fk_usuario int not null,
    acertou boolean default false,
    foreign key (fk_usuario) references usuario(id),
    foreign key (fk_perguntas) references perguntas(id)
);

create table prova(
	id int auto_increment primary key,
	fk_professor int not null,
    foreign key (fk_professor) references professor(id)
);

create table provaPerguntas(
	fk_perguntas int not null,
	fk_prova int not null,
    pontos float unsigned default 0,
    foreign key (fk_perguntas) references perguntas(id),
	foreign key (fk_prova) references prova(id)
);
create table usuarioFazProva(
	fk_prova int not null,
    fk_usuario int not null,
    pontos int,
    foreign key (fk_prova) references prova(id),
    foreign key (fk_usuario) references usuario(id)
);

-- Inserindo dados de exemplo na tabela 'usuario'
INSERT INTO usuario (usuario, senha, nome) VALUES
('usuario0', 'senha1', 'So Silva'),
('usuario1', 'senha1', 'João Silva'),
('usuario2', 'senha2', 'Maria Souza'),
('usuario1Prof', 'senha1', 'Gustavo'), -- 4
('usuario3', 'senha3', 'Carlos Santos'),
('usuario2Prof', 'senha2', 'Tania'), -- 6
('usuario4', 'senha4', 'Ana Oliveira'),
('usuario0Prof', 'senha3', 'Carlos Santos'), -- 8
('usuario3Prof', 'senha3', 'Antonio'), -- 9
('usuario4Prof', 'senha4', 'Ana Oliveira'); -- 10



-- Inserindo dados de exemplo na tabela 'disciplina'
INSERT INTO disciplina (nome) VALUES
('Matemática'),
('Algoritimo'),
('Portugues'),
('Banco de dados'),
('Redes');

-- Inserindo dados de exemplo na tabela 'assunto'
INSERT INTO assunto (nome) VALUES
('Álgebra'),
('Logica'),
('Significado'),
('DER'),
('Internet'),
('Algoritmos de Ordenação'),
('Gramática'),
('Banco de Dados SQL'),
('Protocolos'),
('Matematica Basica');

INSERT INTO professor(fk_usuario) values
(4),
(6),
(8),
(9),
(10);

-- Associando o professor com id 1 à disciplina de Matemática
INSERT INTO professorDisciplina (fk_professor, fk_disciplina) VALUES 
(1, 2), -- prof 1 ligado a algoritmo> 2
(1, 1), -- prof 1 ligado a Matema> 1 
-- (1,1)
(2,1), -- prof 2 <> matema 1
(3,3), -- portugues 3
(4,4), -- banco de dados 4
(5,5) -- redes 5
;



-- Inserindo dados de exemplo na tabela 'perguntas'
INSERT INTO perguntas (texto, fk_disciplina, fk_professor) VALUES
('Durante a resolução de exercícios sobre expressões algébricas, o professor pediu para que os alunos realizassem a simplificação da expressão 8(3 – 5x) + 4(3x – 6). Se a simplificação for feita  matematicamente, o polinômio encontrado será?'
, 1, 1), -- Álgebra 1
('Se você tem primazia, significa que:', 3, 3), -- Significado 3
('Um algoritmo é uma forma de organizar a sua lógica, a solução para o problema que está sendo solucionado. Normalmente, um algoritmo é uma sequência de passos, em ordem e sem ambiguidade, que deve ser seguida para resolver um problema. Considerando o tema, tipos de algoritmos e conceitos de softwares, analise as alternativas e assinale a que apresenta o tipo de algoritmo que mais se aproxima da definição: “É uma forma genérica de escrever um algoritmo, utilizando uma linguagem simples (nativa a quem o escreve, de forma a ser entendido por qualquer pessoa) sem necessidade de conhecer a sintaxe de nenhuma linguagem de programação e também é conhecido como portugol”.'
, 2, 1), -- Logica 2
('O que significa 0 em diagrama entidade relacionamento (DER)?', 4, 4), -- DER 4
('Qual é o protocolo usado para transferência de arquivos entre computadores em uma rede?', 5, 5), -- Internet 5
('Qual é o resultado da operação 5 + 7 * 3?', 1, 2), --  Matematica Basica 10
('Qual é o objetivo do algoritmo Bubble Sort?', 2, 1), -- algoritmo or 6 logica 2
('Qual é a classe gramatical da palavra "rápido" na frase "O carro passou rápido"?', 3, 3), -- Gramática 7
('Qual é a função do comando SELECT em SQL?', 4, 4), -- Banco de Dados SQL 8
('O que significa a sigla TCP/IP?', 5, 5); -- protocolos 10


-- Inserindo dados de exemplo na tabela 'perguntaAssunto'
INSERT INTO perguntaAssunto (fk_perguntas, fk_assunto) VALUES
(1, 1),
(2, 3),
(3, 2),
(4, 4),
(5, 5),
(6, 10),
(7, 6),
(7, 2),
(8, 7),
(9, 8),
(10,10);

-- Inserindo dados de exemplo na tabela 'alternativas'
INSERT INTO alternativas (texto, correto, fk_perguntas) VALUES
('16x - 20', true, 1),
('8x - 24', false, 1),
('24 - 8x', false, 1),
('20 - 16x', false, 1),
('Você tem medo', false, 2),
('Você tem domínio', false, 2),
('Você tem prioridade', true, 2),
('Você tem receio', false, 2),
('Algoritmo Específico', false, 3),
('Algoritmo Genérico', true, 3),
('Algoritmo Complexo', false, 3),
('Algoritmo Simples', false, 3),
('Zero ou muitos', true, 4),
('Apenas um', false, 4),
('Nenhum', false, 4),
('Um ou muitos', false, 4),
('FTP (File Transfer Protocol)', true, 5),
('HTTP (Hypertext Transfer Protocol)', false, 5),
('SMTP (Simple Mail Transfer Protocol)', false, 5),
('TCP (Transmission Control Protocol)', false, 5),
('26', false, 6),
('36', true, 6),
('28', false, 6),
('38', false, 6),
('Ordenar uma lista de elementos em ordem crescente ou decrescente', true, 7),
('Criar uma lista encadeada', false, 7),
('Realizar uma busca binária', false, 7),
('Calcular o fatorial de um número', false, 7),
('Advérbio', true, 8),
('Verbo', false, 8),
('Substantivo', false, 8),
('Adjetivo', false, 8),
('Recuperar dados de um banco de dados', true, 9),
('Inserir dados em um banco de dados', false, 9),
('Atualizar dados em um banco de dados', false, 9),
('Excluir dados de um banco de dados', false, 9),
('Transmission Control Protocol/Internet Protocol', true, 10),
('Time Capsule Protocol/Internet Protocol', false, 10),
('Transfer Control Protocol/Internet Protocol', false, 10),
('Total Control Protocol/Internet Protocol', false, 10);




-- Inserindo dados de exemplo na tabela 'usuarioResponde'
INSERT INTO usuarioResponde (fk_perguntas, fk_usuario, acertou) VALUES
(1, 1, false),
(2, 2, true),
(3, 3, true),
(4, 5, false),
(7, 1, true),
(1, 2, false),
(2, 3, true),
(6, 5, true);

-- Inserindo dados de exemplo na tabela 'prova'
INSERT INTO prova (fk_professor) VALUES
(2),
(3),
(1),
(5),
(4);

INSERT INTO provaPerguntas (fk_perguntas, fk_prova, pontos) VALUES
(1, 1, 5), -- v
(6, 1, 5), -- mate
(2, 2, 2),-- v
(8, 2, 2), -- portu
(3, 3, 8), -- v
(7, 3, 9), -- algori
(10, 4, 7),  -- v
(5, 4, 7),	-- Redes
(4, 5, 10), -- v
(9, 5, 10); -- Banco de dados

insert into usuarioFazProva(fk_prova,fk_usuario)values
(1,1),
(1,2),
(1,3),
(1,5),
(2,5),
(2,3),
(3,3),
(4,4),
(5,5);


SELECT count(*)
FROM usuario u
LEFT JOIN professor p ON u.id = p.fk_usuario
WHERE p.id IS NULL;


SELECT COUNT(*) AS total_questoes
FROM perguntas;

SELECT *
FROM disciplina limit 5;

SELECT nome
FROM usuario
WHERE id = 1;

SELECT u.nome
FROM usuario u
INNER JOIN professor p ON u.id = p.fk_usuario
WHERE u.usuario = 'usuario0Prof';

SELECT nome
FROM usuario
WHERE id NOT IN (SELECT fk_usuario FROM professor) and id=1;

SELECT u.nome, 
    CASE
        WHEN p.id IS NOT NULL THEN 'Professor'
        ELSE 'Aluno'
    END AS tipo
FROM usuario u
LEFT JOIN professor p ON u.id = p.fk_usuario
WHERE u.usuario = 'usuario0';


SELECT DISTINCT a.nome
FROM perguntas p
JOIN perguntaAssunto pa ON p.id = pa.fk_perguntas
JOIN assunto a ON pa.fk_assunto = a.id
WHERE p.fk_disciplina = 2;

SELECT 
    p.id AS id_pergunta,
    p.texto AS pergunta,
    COUNT(ur.acertou) AS acertos,
    COUNT(*) - COUNT(ur.acertou) AS erros,
    COUNT(*) AS total_tentativas,
    CASE 
        WHEN COUNT(*) = 0 THEN 'Sem tentativas'
        WHEN COUNT(ur.acertou) / COUNT(*) >= 0.75 THEN 'Fácil'
        WHEN COUNT(ur.acertou) / COUNT(*) >= 0.5 THEN 'Médio'
        ELSE 'Difícil'
    END AS dificuldade
FROM 
    perguntas p
LEFT JOIN 
    usuarioResponde ur ON p.id = ur.fk_perguntas
GROUP BY 
    p.id;


SELECT 
    p.id AS id_pergunta,
    p.texto AS pergunta,
    COUNT(ur.acertou) AS acertos,
    COUNT(*) - COUNT(ur.acertou) AS erros,
    COUNT(*) AS total_tentativas,
    CASE 
        WHEN COUNT(*) = 0 THEN 'Sem tentativas'
        WHEN COUNT(ur.acertou) / COUNT(*) >= 0.75 THEN 'Fácil'
        WHEN COUNT(ur.acertou) / COUNT(*) >= 0.5 THEN 'Médio'
        ELSE 'Difícil'
    END AS dificuldade
FROM 
    perguntas p
JOIN 
    usuarioResponde ur ON p.id = ur.fk_perguntas
GROUP BY 
    p.id;


SELECT 
    p.id AS id_pergunta,
    CASE 
        WHEN COUNT(*) = 0 THEN 'Sem tentativas'
        WHEN COUNT(ur.acertou) / COUNT(*) >= 0.75 THEN 'Fácil'
        WHEN COUNT(ur.acertou) / COUNT(*) >= 0.5 THEN 'Médio'
        ELSE 'Difícil'
    END AS dificuldade
FROM 
    perguntas p
JOIN 
    usuarioResponde ur ON p.id = ur.fk_perguntas
JOIN 
    perguntaAssunto pa ON p.id = pa.fk_perguntas
JOIN 
    assunto a ON pa.fk_assunto = a.id
JOIN 
    disciplina d ON p.fk_disciplina = d.id
WHERE 
    d.nome = 'Algoritimo' AND
    a.nome = 'Logica'
GROUP BY 
    p.id;

SELECT 
    d.nome AS disciplina,
    a.nome AS assunto,
    COUNT(p.id) AS total_perguntas,
    SUM(ur.acertou) AS total_acertos,
    COUNT(*) - SUM(ur.acertou) AS total_erros
FROM 
    disciplina d
JOIN 
    perguntas p ON d.id = p.fk_disciplina
JOIN 
    perguntaAssunto pa ON p.id = pa.fk_perguntas
JOIN 
    assunto a ON pa.fk_assunto = a.id
LEFT JOIN 
    usuarioResponde ur ON p.id = ur.fk_perguntas
WHERE 
    ur.fk_usuario = 1
GROUP BY 
    d.nome, a.nome;


SELECT 
    COUNT(*) AS total_questoes_respondidas,
    SUM(acertou) AS total_acertos,
    COUNT(*) - SUM(acertou) AS total_erros
FROM 
    usuarioResponde
WHERE 
    fk_usuario = 1;


