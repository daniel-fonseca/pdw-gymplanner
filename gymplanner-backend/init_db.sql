DROP TABLE IF EXISTS 
  agendamentos,
  exercicios,
  treinos,
  maquinas,
  usuarios
  CASCADE;

DROP SEQUENCE IF EXISTS 
  agendamentos_id_seq,
  exercicios_id_seq,
  treinos_id_seq,
  maquinas_id_seq,
  usuarios_id_seq
  CASCADE;

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: agendamentos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agendamentos (
    id integer NOT NULL,
    id_usuario integer,
    id_maquina integer,
    data_inicio timestamp without time zone NOT NULL,
    data_fim timestamp without time zone NOT NULL,
    CONSTRAINT agendamentos_check CHECK ((data_fim > data_inicio)),
    CONSTRAINT agendamentos_check1 CHECK ((EXTRACT(epoch FROM (data_fim - data_inicio)) <= (600)::numeric))
);


ALTER TABLE public.agendamentos OWNER TO postgres;

--
-- Name: agendamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agendamentos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.agendamentos_id_seq OWNER TO postgres;

--
-- Name: agendamentos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agendamentos_id_seq OWNED BY public.agendamentos.id;


--
-- Name: exercicios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercicios (
    id integer NOT NULL,
    id_treino integer,
    id_maquina integer,
    nome character varying(255) NOT NULL,
    repeticoes integer NOT NULL,
    peso numeric(6,2) NOT NULL,
    CONSTRAINT exercicios_peso_check CHECK ((peso >= (0)::numeric)),
    CONSTRAINT exercicios_repeticoes_check CHECK ((repeticoes > 0))
);


ALTER TABLE public.exercicios OWNER TO postgres;

--
-- Name: exercicios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exercicios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exercicios_id_seq OWNER TO postgres;

--
-- Name: exercicios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exercicios_id_seq OWNED BY public.exercicios.id;


--
-- Name: maquinas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maquinas (
    id integer NOT NULL,
    nome character varying(255) NOT NULL,
    grupo_muscular character varying(255) NOT NULL,
    status character varying(50) DEFAULT 'disponivel'::character varying NOT NULL,
    ultima_manutencao date,
    CONSTRAINT maquinas_status_check CHECK (((status)::text = ANY ((ARRAY['disponivel'::character varying, 'indisponivel'::character varying, 'em manutencao'::character varying])::text[])))
);


ALTER TABLE public.maquinas OWNER TO postgres;

--
-- Name: maquinas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.maquinas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.maquinas_id_seq OWNER TO postgres;

--
-- Name: maquinas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.maquinas_id_seq OWNED BY public.maquinas.id;


--
-- Name: treinos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.treinos (
    id integer NOT NULL,
    id_usuario integer,
    nome character varying(255) NOT NULL,
    data_inicio timestamp without time zone NOT NULL,
    data_fim timestamp without time zone NOT NULL,
    duracao interval NOT NULL,
    CONSTRAINT treinos_duracao_check CHECK ((EXTRACT(epoch FROM duracao) <= (10800)::numeric))
);


ALTER TABLE public.treinos OWNER TO postgres;

--
-- Name: treinos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.treinos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.treinos_id_seq OWNER TO postgres;

--
-- Name: treinos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.treinos_id_seq OWNED BY public.treinos.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nome character varying(255) NOT NULL,
    senha character varying(255) NOT NULL,
    tipo_usuario character varying(10) DEFAULT 'usuario'::character varying NOT NULL,
    CONSTRAINT usuarios_tipo_usuario_check CHECK (((tipo_usuario)::text = ANY ((ARRAY['usuario'::character varying, 'admin'::character varying])::text[])))
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- Name: agendamentos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agendamentos ALTER COLUMN id SET DEFAULT nextval('public.agendamentos_id_seq'::regclass);


--
-- Name: exercicios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercicios ALTER COLUMN id SET DEFAULT nextval('public.exercicios_id_seq'::regclass);


--
-- Name: maquinas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maquinas ALTER COLUMN id SET DEFAULT nextval('public.maquinas_id_seq'::regclass);


--
-- Name: treinos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treinos ALTER COLUMN id SET DEFAULT nextval('public.treinos_id_seq'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- Data for Name: agendamentos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.agendamentos (id, id_usuario, id_maquina, data_inicio, data_fim) VALUES (1, 1, 1, '2024-04-03 10:00:00', '2024-04-03 10:10:00');
INSERT INTO public.agendamentos (id, id_usuario, id_maquina, data_inicio, data_fim) VALUES (2, 3, 3, '2024-04-03 09:00:00', '2024-04-03 09:10:00');


--
-- Data for Name: exercicios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.exercicios (id, id_treino, id_maquina, nome, repeticoes, peso) VALUES (1, 1, 1, 'Leg Press 45├é┬░', 12, 100.00);
INSERT INTO public.exercicios (id, id_treino, id_maquina, nome, repeticoes, peso) VALUES (2, 1, 2, 'Peck Deck', 10, 60.00);
INSERT INTO public.exercicios (id, id_treino, id_maquina, nome, repeticoes, peso) VALUES (3, 2, 3, 'Remada baixa', 10, 70.00);


--
-- Data for Name: maquinas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.maquinas (id, nome, grupo_muscular, status, ultima_manutencao) VALUES (1, 'Leg Press', 'Pernas', 'disponivel', '2024-04-01');
INSERT INTO public.maquinas (id, nome, grupo_muscular, status, ultima_manutencao) VALUES (2, 'Peck Deck', 'Peitoral', 'disponivel', '2024-03-25');
INSERT INTO public.maquinas (id, nome, grupo_muscular, status, ultima_manutencao) VALUES (3, 'Test Machine', 'Costas', 'disponivel', '2024-04-01');


--
-- Data for Name: treinos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.treinos (id, id_usuario, nome, data_inicio, data_fim, duracao) VALUES (1, 1, 'Treino A', '2024-04-03 08:00:00', '2024-04-03 09:00:00', '01:00:00');
INSERT INTO public.treinos (id, id_usuario, nome, data_inicio, data_fim, duracao) VALUES (2, 3, 'Treino Teste', '2024-04-03 08:00:00', '2024-04-03 08:30:00', '00:30:00');
INSERT INTO public.treinos (id, id_usuario, nome, data_inicio, data_fim, duracao) VALUES (3, 3, 'Treino de For├ºa', '2025-04-01 00:00:00', '2025-04-30 00:00:00', '00:01:00');


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuarios (id, nome, senha, tipo_usuario) VALUES (1, 'joao', '123456', 'usuario');
INSERT INTO public.usuarios (id, nome, senha, tipo_usuario) VALUES (2, 'admin', '$2b$10$Fnw7NvI33rTkFO8uOJi2J.EtshaIhzxQ/B/xazW0nx18xCeu6E5oa', 'admin');
INSERT INTO public.usuarios (id, nome, senha, tipo_usuario) VALUES (3, 'testuser', '$2b$10$7iHbJX23Qa35uNhaAGWZsOoz1ge6iTzTvcdMI.QkRVqknwzDkNa3G', 'usuario');
INSERT INTO public.usuarios (id, nome, senha, tipo_usuario) VALUES (5, 'binha', '$2b$10$cAh2nMGxF8/qG0L3GpaymeAWZvutAl7Ca0I9F7XzPAmznwQQYZ5Mu', 'usuario');


--
-- Name: agendamentos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.agendamentos_id_seq', 2, true);


--
-- Name: exercicios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exercicios_id_seq', 3, true);


--
-- Name: maquinas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.maquinas_id_seq', 3, true);


--
-- Name: treinos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.treinos_id_seq', 3, true);


--
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 5, true);


--
-- Name: agendamentos agendamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agendamentos
    ADD CONSTRAINT agendamentos_pkey PRIMARY KEY (id);


--
-- Name: exercicios exercicios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercicios
    ADD CONSTRAINT exercicios_pkey PRIMARY KEY (id);


--
-- Name: maquinas maquinas_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maquinas
    ADD CONSTRAINT maquinas_nome_key UNIQUE (nome);


--
-- Name: maquinas maquinas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maquinas
    ADD CONSTRAINT maquinas_pkey PRIMARY KEY (id);


--
-- Name: treinos treinos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treinos
    ADD CONSTRAINT treinos_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_nome_key UNIQUE (nome);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: agendamentos agendamentos_id_maquina_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agendamentos
    ADD CONSTRAINT agendamentos_id_maquina_fkey FOREIGN KEY (id_maquina) REFERENCES public.maquinas(id) ON DELETE SET NULL;


--
-- Name: agendamentos agendamentos_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agendamentos
    ADD CONSTRAINT agendamentos_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: exercicios exercicios_id_maquina_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercicios
    ADD CONSTRAINT exercicios_id_maquina_fkey FOREIGN KEY (id_maquina) REFERENCES public.maquinas(id) ON DELETE SET NULL;


--
-- Name: exercicios exercicios_id_treino_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercicios
    ADD CONSTRAINT exercicios_id_treino_fkey FOREIGN KEY (id_treino) REFERENCES public.treinos(id) ON DELETE CASCADE;


--
-- Name: treinos treinos_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treinos
    ADD CONSTRAINT treinos_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id) ON DELETE CASCADE;