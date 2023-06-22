
------------Excluir banco de dados caso exista------------
DROP DATABASE IF EXISTS bt;

-------------------------------

------------Excluir o schema caso exista------------
DROP SCHEMA IF EXISTS talentos CASCADE;

-------------------------------

------------Excluir o usuário caso exista------------
DROP USER IF EXISTS fourtalents;

-------------------------------

------------Criar o usuário a ser usado------------
CREATE USER fourtalents WITH
CREATEDB
CREATEROLE
INHERIT
ENCRYPTED PASSWORD'fourtalents';

-------------------------------

------------Conectar no usuário a ser utilizado------------

SET ROLE fourtalents;

-------------------------------

------------Criar o banco de dados------------
CREATE DATABASE bt WITH
TEMPLATE = 'template0'
ENCODING = 'UTF8'
LC_COLLATE =  'pt_BR.UTF-8'
LC_CTYPE =  'pt_BR.UTF-8'
ALLOW_CONNECTIONS = 'true'
OWNER = 'fourtalents';

-------------------------------

------------Conectar no banco de dados e usuário------------
\c bt;

SET ROLE fourtalents;

-------------------------------


------------Criar o schema caso não exista------------
CREATE SCHEMA IF NOT EXISTS talentos AUTHORIZATION fourtalents;

ALTER USER fourtalents
SET SEARCH_PATH TO talentos, "&user", public;

-------------------------------


-------------Tabelas-------------

-------------Tabela colaboradores-------------
CREATE TABLE colaboradores (
                id_funcionario            NUMERIC(8)       NOT NULL,
                nome                      VARCHAR(255)     NOT NULL,
                nascimento                DATE             NOT NULL,
                cargo                     VARCHAR(255)     NOT NULL,
                numero                    NUMERIC(12)      NOT NULL,
                logradouro                VARCHAR(355)     NOT NULL,
                uf                        VARCHAR(45)      NOT NULL,
                cidade                    VARCHAR(355)     NOT NULL,
                bairro                    VARCHAR(355)     NOT NULL,
                rua                       VARCHAR(355)     NOT NULL,
                CONSTRAINT pk_colaboradores PRIMARY KEY (id_funcionario)
);

-------------Comentarios-------------

COMMENT ON COLUMN colaboradores.id_funcionario      IS 'Codigo do funcionario.';
COMMENT ON COLUMN colaboradores.nome                IS 'Nome do funcionario.';
COMMENT ON COLUMN colaboradores.nascimento          IS 'Data de nascimento do funcionario.';
COMMENT ON COLUMN colaboradores.cargo               IS 'Cargo do funcionario.';
COMMENT ON COLUMN colaboradores.numero              IS 'Numero da residencial do funcionario.';
COMMENT ON COLUMN colaboradores.logradouro          IS 'Logradouro do funcionario.';
COMMENT ON COLUMN colaboradores.uf                  IS 'Unidade federativa do funcionario.';
COMMENT ON COLUMN colaboradores.cidade              IS 'Cidade do funcionario.';
COMMENT ON COLUMN colaboradores.bairro              IS 'Bairro do funcionario.';
COMMENT ON COLUMN colaboradores.rua                 IS 'Rua do funcionario.';

-------------Fim dos comentarios-------------

-------------Fim da Tabela colaboradores-------------


-------------Tabela posts-------------

CREATE TABLE posts (
                codigo_postagem          NUMERIC(12)       NOT NULL,
                id_funcionario           NUMERIC(8)        NOT NULL,
                status                   VARCHAR(7)        NOT NULL,
                data_da_postagem         TIMESTAMP         NOT NULL,
                mensagem                 VARCHAR(500),
                foto                     BYTEA,
                CONSTRAINT pk_posts PRIMARY KEY (codigo_postagem, id_funcionario)
);

-------------Comentarios-------------

COMMENT ON COLUMN posts.codigo_postagem            IS 'Codigo da postagem';
COMMENT ON COLUMN posts.id_funcionario             IS 'Codigo do funcionario.';
COMMENT ON COLUMN posts.status                     IS 'Status da postagem(Ativo, Inativo).';
COMMENT ON COLUMN posts.data_da_postagem           IS 'Data da postagem.';
COMMENT ON COLUMN posts.mensagem                   IS 'Mensagem do post';
COMMENT ON COLUMN posts.foto                       IS 'Foto da postagem.';

-------------Fim dos comentarios-------------

------------Fim da tabela posts------------


-------------Tabela administradores-------------
CREATE TABLE administradores (
                codigo_adm               NUMERIC(8)        NOT NULL,
                id_funcionario           NUMERIC(8)        NOT NULL,
                CONSTRAINT pk_administradores PRIMARY KEY (codigo_adm)
);

-------------Comentarios-------------

COMMENT ON COLUMN administradores.codigo_adm       IS 'Código de usuario administrador.';
COMMENT ON COLUMN administradores.id_funcionario   IS 'Codigo do funcionario.';

-------------Fim dos comentarios-------------

------------Fim da tabela administradores------------


-------------Tabela eventos-------------

CREATE TABLE eventos (
                codigo_evento            NUMERIC(8)         NOT NULL,
                status                   VARCHAR(7)         NOT NULL,  
                data_de_criacao          DATE               NOT NULL,
                data_do_evento           TIMESTAMP          NOT NULL,
                rua                      VARCHAR(355)       NOT NULL,
                bairro                   VARCHAR(355)       NOT NULL,
                cidade                   VARCHAR(355)       NOT NULL,
                uf                       VARCHAR(45)        NOT NULL,
                logradouro               VARCHAR(355)       NOT NULL,
                numero                   NUMERIC(12)        NOT NULL,
                codigo_adm               NUMERIC(8)         NOT NULL,
                CONSTRAINT pk_eventos PRIMARY KEY (codigo_evento)
);

-------------Comentarios-------------
COMMENT ON COLUMN eventos.codigo_evento            IS 'Codigo do evento.';
COMMENT ON COLUMN eventos.status                   IS 'Status do evento(Ativo, Inativo).';
COMMENT ON COLUMN eventos.data_de_criacao          IS 'Data de criacao do evento.';
COMMENT ON COLUMN eventos.data_do_evento           IS 'Data do evento.';
COMMENT ON COLUMN eventos.rua                      IS 'Rua do evento.';
COMMENT ON COLUMN eventos.bairro                   IS 'Bairro do evento.';
COMMENT ON COLUMN eventos.cidade                   IS 'Cidade do evento.';
COMMENT ON COLUMN eventos.uf                       IS 'Unidade federativa do evento.';
COMMENT ON COLUMN eventos.logradouro               IS 'Logradouro do evento.';
COMMENT ON COLUMN eventos.numero                   IS 'Numero do endereco do evento.';
COMMENT ON COLUMN eventos.codigo_adm               IS 'Código de usuario administrador.';

-------------Fim dos comentarios-------------

------------Fim da tabela eventos------------


-------------Tabela usuarios_eventos-------------

CREATE TABLE usuarios_eventos (
                codigo_evento            NUMERIC(8)         NOT NULL,
                id_funcionario           NUMERIC(8)         NOT NULL,
                CONSTRAINT pk_usuarios_eventos PRIMARY KEY (codigo_evento, id_funcionario)
);

-------------Comentarios-------------

COMMENT ON COLUMN usuarios_eventos.codigo_evento IS 'Codigo do evento.';
COMMENT ON COLUMN usuarios_eventos.id_funcionario  IS 'Codigo do funcionario.';

-------------Fim dos comentarios-------------

------------Fim da tabela usuarios_eventos------------


-------------Tabela talentos-------------
CREATE TABLE talentos (
                codigo_do_talento        NUMERIC(8)         NOT NULL,
                data_de_atualizacao      DATE               NOT NULL,
                status                   VARCHAR(7)         NOT NULL,
                data_de_criacao          DATE               NOT NULL,
                reponsavel_atualizacao   VARCHAR(355)       NOT NULL,
                codigo_adm               NUMERIC(8)         NOT NULL,
                CONSTRAINT pk_talentos PRIMARY KEY (codigo_do_talento)
);

-------------Comentarios-------------

COMMENT ON COLUMN talentos.codigo_do_talento        IS 'Codigo do talento.';
COMMENT ON COLUMN talentos.data_de_atualizacao      IS 'Data de ultima atualizacao.';
COMMENT ON COLUMN talentos.status                   IS 'Status do talento(Ativo, Inativo).';
COMMENT ON COLUMN talentos.data_de_criacao          IS 'Data da criacao do talento.';
COMMENT ON COLUMN talentos.reponsavel_atualizacao   IS 'Responsavel pela ultima atualizacao.';
COMMENT ON COLUMN talentos.codigo_adm               IS 'Código de usuario administrador.';

-------------Fim dos comentarios-------------

------------Fim da tabela talentos------------


-------------Tabela usuarios_talentos-------------
CREATE TABLE usuarios_talentos (
                codigo_do_talento        NUMERIC(8)         NOT NULL,
                id_funcionario           NUMERIC(8)         NOT NULL,
                CONSTRAINT pk_usuarios_talentos PRIMARY KEY (codigo_do_talento, id_funcionario)
);

-------------Comentarios-------------

COMMENT ON COLUMN usuarios_talentos.codigo_do_talento   IS 'Codigo do talento.';
COMMENT ON COLUMN usuarios_talentos.id_funcionario      IS 'Codigo do funcionario.';

-------------Fim dos comentarios-------------

------------Fim da tabela usuarios_talentos------------


-------------Tabela grupos-------------

CREATE TABLE grupos (
                codigo_do_grupo          NUMERIC(8)         NOT NULL,
                data_de_criacao          DATE               NOT NULL,
                status                   VARCHAR(7)         NOT NULL,
                data_de_atualizacao      DATE               NOT NULL,
                reponsavel_atualizacao   VARCHAR(355)       NOT NULL,
                codigo_adm               NUMERIC(8)         NOT NULL,
                CONSTRAINT pk_grupos PRIMARY KEY (codigo_do_grupo)
);

-------------Comentarios-------------

COMMENT ON COLUMN grupos.codigo_do_grupo          IS 'Codigo do grupo.';
COMMENT ON COLUMN grupos.data_de_criacao          IS 'Data de criacao do grupo.';
COMMENT ON COLUMN grupos.status                   IS 'Status do grupo(Ativo, Inativo).';
COMMENT ON COLUMN grupos.data_de_atualizacao      IS 'Data de ultima atualizacao do grupo.';
COMMENT ON COLUMN grupos.reponsavel_atualizacao   IS 'Responsavel pela ultima atualizacao.';
COMMENT ON COLUMN grupos.codigo_adm               IS 'Código de usuario administrador.';

-------------Fim dos comentarios-------------

------------Fim da tabela grupos------------


-------------Tabela usuarios_grupos-------------

CREATE TABLE usuarios_grupos (
                codigo_do_grupo          NUMERIC(8)         NOT NULL,
                id_funcionario           NUMERIC(8)         NOT NULL,
                CONSTRAINT pk_usuarios_grupos PRIMARY KEY (codigo_do_grupo, id_funcionario)
);

-------------Comentarios-------------

COMMENT ON COLUMN usuarios_grupos.codigo_do_grupo IS 'Codigo do grupo.';
COMMENT ON COLUMN usuarios_grupos.id_funcionario IS 'Codigo do funcionario.';

-------------Fim dos comentarios-------------

------------Fim da tabela usuarios_grupos------------


-------------Tabela usuarios_comuns-------------

CREATE TABLE usuarios_comuns (
                codigo_comum             NUMERIC             NOT NULL,
                id_funcionario           NUMERIC(8)          NOT NULL,
                CONSTRAINT pk_usuarios_comuns PRIMARY KEY (codigo_comum)
);

-------------Comentarios-------------

COMMENT ON COLUMN usuarios_comuns.codigo_comum      IS 'Codigo de usuario comum.';
COMMENT ON COLUMN usuarios_comuns.id_funcionario    IS 'Codigo do funcionario.';

-------------Fim dos comentarios-------------

------------Fim da tabela usuarios_comuns------------


-------------Tabela sugestoes-------------
CREATE TABLE sugestoes (
                codigo_sugestao          NUMERIC(8)         NOT NULL,
                tipo_de_sugestao         VARCHAR(8)         NOT NULL,
                mensagem                 VARCHAR(455)       NOT NULL,
                codigo_comum             NUMERIC            NOT NULL,
                status                   VARCHAR(17)        NOT NULL,
                CONSTRAINT pk_sugestoes PRIMARY KEY (codigo_sugestao)
);

-------------Comentarios-------------

COMMENT ON COLUMN sugestoes.codigo_sugestao      IS 'Codigo da sugestao.';
COMMENT ON COLUMN sugestoes.tipo_de_sugestao     IS 'Tipo de sugestão(Nula, Grupos, Talentos, Eventos).';
COMMENT ON COLUMN sugestoes.mensagem             IS 'Mensagem escrita.';
COMMENT ON COLUMN sugestoes.codigo_comum         IS 'Codigo de usuario comum.';
COMMENT ON COLUMN sugestoes.status               IS 'Status das sugestoes(Implementada, Nao-implementada).';

-------------Fim dos comentarios-------------

------------Fim da tabela sugestoes------------


-------------Tabela telefone_colaborador-------------

CREATE TABLE telefone_colaborador (
                id_funcionario           NUMERIC(8)         NOT NULL,
                telefone                 NUMERIC(14)        NOT NULL,
                CONSTRAINT pk_telefone_colaborador PRIMARY KEY (id_funcionario)
);

-------------Comentarios-------------

COMMENT ON COLUMN telefone_colaborador.id_funcionario   IS 'Codigo do funcionario.';
COMMENT ON COLUMN telefone_colaborador.telefone         IS 'Numero telefonico do funcionario.';

-------------Fim dos comentarios-------------

------------Fim da tabela telefone_colaborador------------


-------------Tabela email_colaborador-------------

CREATE TABLE email_colaborador (
                id_funcionario           NUMERIC(8)         NOT NULL,
                email                    VARCHAR(355)       NOT NULL,
                CONSTRAINT pk_email_colaborador PRIMARY KEY (id_funcionario)
);

-------------Comentarios-------------

COMMENT ON COLUMN email_colaborador.id_funcionario   IS 'Codigo do funcionario.';
COMMENT ON COLUMN email_colaborador.email            IS 'Email do funcionario.';

-------------Fim dos comentarios-------------

------------Fim da tabela email_colaborador------------

------------Relacionamentos------------


------------Relacionamento email_colaborador -> colaboradores------------

ALTER TABLE email_colaborador ADD CONSTRAINT colaboradores_email_colaborador_fk
FOREIGN KEY (id_funcionario)
REFERENCES colaboradores (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

------------Fim------------


------------Relacionamento telefone_colaborador -> colaboradores------------

ALTER TABLE telefone_colaborador ADD CONSTRAINT colaboradores_telefone_colaborador_fk
FOREIGN KEY (id_funcionario)
REFERENCES colaboradores (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

------------Fim------------


------------------------Relacionamento usuarios_comuns -> colaboradores------------

ALTER TABLE usuarios_comuns ADD CONSTRAINT colaboradores_usuarios_comuns_fk
FOREIGN KEY (id_funcionario)
REFERENCES colaboradores (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

------------Fim------------


------------Relacionamento administradores -> colaboradores------------
ALTER TABLE administradores ADD CONSTRAINT colaboradores_administradores_fk
FOREIGN KEY (id_funcionario)
REFERENCES colaboradores (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

------------Fim------------


------------Relacionamento post -> colaboradores------------

ALTER TABLE posts ADD CONSTRAINT colaboradores_posts_fk
FOREIGN KEY (id_funcionario)
REFERENCES colaboradores (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

------------Fim------------


------------Relacionamento usuarios_grupos -> colaboradores------------
ALTER TABLE usuarios_grupos ADD CONSTRAINT colaboradores_usuarios_grupos_fk
FOREIGN KEY (id_funcionario)
REFERENCES colaboradores (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

------------Fim------------


------------Relacionamento usuarios_talentos -> colaboradores------------

ALTER TABLE usuarios_talentos ADD CONSTRAINT colaboradores_usuarios_talentos_fk
FOREIGN KEY (id_funcionario)
REFERENCES colaboradores (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

------------Fim------------


------------Relacionamento usuarios_eventos -> colaboradores------------

ALTER TABLE usuarios_eventos ADD CONSTRAINT colaboradores_usuarios_eventos_fk
FOREIGN KEY (id_funcionario)
REFERENCES colaboradores (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

------------Fim------------


------------Relacionamento grupos -> administradores------------

ALTER TABLE grupos ADD CONSTRAINT administradores_grupos_fk
FOREIGN KEY (codigo_adm)
REFERENCES administradores (codigo_adm)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

------------Fim------------


------------Relacionamento talentos -> administradores------------

ALTER TABLE talentos ADD CONSTRAINT administradores_talentos_fk
FOREIGN KEY (codigo_adm)
REFERENCES administradores (codigo_adm)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


------------Relacionamento eventos -> administradores------------

ALTER TABLE eventos ADD CONSTRAINT administradores_eventos_fk
FOREIGN KEY (codigo_adm)
REFERENCES administradores (codigo_adm)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

------------Fim------------


------------Relacionamento usuarios_eventos -> eventos------------

ALTER TABLE usuarios_eventos ADD CONSTRAINT eventos_usuarios_eventos_fk
FOREIGN KEY (codigo_evento)
REFERENCES eventos (codigo_evento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

------------Fim------------


------------Relacionamento usuarios_talentos -> talentos------------

ALTER TABLE usuarios_talentos ADD CONSTRAINT talentos_usuarios_talentos_fk
FOREIGN KEY (codigo_do_talento)
REFERENCES talentos (codigo_do_talento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

------------Fim------------


------------Relacionamento usuarios_grupos -> grupos------------

ALTER TABLE usuarios_grupos ADD CONSTRAINT grupos_usuarios_grupos_fk
FOREIGN KEY (codigo_do_grupo)
REFERENCES grupos (codigo_do_grupo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

------------Fim------------


------------Relacionamento sugestoes -> usuarios_comuns------------

ALTER TABLE sugestoes ADD CONSTRAINT usuarios_comuns_sugestoes_fk
FOREIGN KEY (codigo_comum)
REFERENCES usuarios_comuns (codigo_comum)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

------------Fim------------


------------Checagens------------


------------Checagem tabela sugestoes------------

ALTER TABLE talentos.sugestoes
ADD CONSTRAINT cc_tipo_de_sugestao_sugestao
CHECK (tipo_de_sugestao IN ('EVENTO', 'TALENTO', 'GRUPO'));


ALTER TABLE talentos.sugestoes
ADD CONSTRAINT cc_status_sugestao
CHECK (status IN ('IMPLEMENTADO', 'NAO-IMPLEMENTADO'));

ALTER TABLE talentos.sugestoes 
ADD CONSTRAINT cc_email_sugestoes
CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');


------------Fim das checagem da tabela sugestoes------------
