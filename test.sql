--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: luiscosta; Tablespace: 
--

CREATE TABLE alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO luiscosta;

--
-- Name: politics; Type: TABLE; Schema: public; Owner: luiscosta; Tablespace: 
--

CREATE TABLE politics (
    "idPolitician" integer NOT NULL,
    "publicName" character varying(150),
    "completeName" character varying(300),
    "startDate" date,
    "endDate" date
);


ALTER TABLE public.politics OWNER TO luiscosta;

--
-- Name: politics_idPolitician_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE "politics_idPolitician_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."politics_idPolitician_seq" OWNER TO luiscosta;

--
-- Name: politics_idPolitician_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE "politics_idPolitician_seq" OWNED BY politics."idPolitician";


--
-- Name: proposals; Type: TABLE; Schema: public; Owner: luiscosta; Tablespace: 
--

CREATE TABLE proposals (
    "idProposal" integer NOT NULL,
    "nameProposal" character varying(120),
    "dateProposal" date,
    description character varying(500),
    "linkProposal" character varying(200)
);


ALTER TABLE public.proposals OWNER TO luiscosta;

--
-- Name: proposals_idProposal_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE "proposals_idProposal_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."proposals_idProposal_seq" OWNER TO luiscosta;

--
-- Name: proposals_idProposal_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE "proposals_idProposal_seq" OWNED BY proposals."idProposal";


--
-- Name: users; Type: TABLE; Schema: public; Owner: luiscosta; Tablespace: 
--

CREATE TABLE users (
    uid integer NOT NULL,
    firstname character varying(100),
    lastname character varying(100),
    email character varying(120),
    pwdhash character varying(150)
);


ALTER TABLE public.users OWNER TO luiscosta;

--
-- Name: users_uid_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE users_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_uid_seq OWNER TO luiscosta;

--
-- Name: users_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE users_uid_seq OWNED BY users.uid;


--
-- Name: idPolitician; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY politics ALTER COLUMN "idPolitician" SET DEFAULT nextval('"politics_idPolitician_seq"'::regclass);


--
-- Name: idProposal; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY proposals ALTER COLUMN "idProposal" SET DEFAULT nextval('"proposals_idProposal_seq"'::regclass);


--
-- Name: uid; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY users ALTER COLUMN uid SET DEFAULT nextval('users_uid_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY alembic_version (version_num) FROM stdin;
e44510af0f40
\.


--
-- Data for Name: politics; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY politics ("idPolitician", "publicName", "completeName", "startDate", "endDate") FROM stdin;
30	António Costa	António Luís Santos da Costa	\N	\N
31	Passos Coelho	Pedro Manuel Mamede Passos Coelho	\N	\N
3	Luis Telmo	Luis Telmo Soares Costa	\N	\N
4	Luis Telmo	Luis Telmo Soares Costa	\N	\N
5	Teste	Teste	\N	\N
6	Luis	Again	\N	\N
7	L	L	\N	\N
2	luis telmo	Luis Telmo Soares Costa	2001-01-01	2016-03-03
8	L	L	\N	\N
9	Teste	Tes	2016-11-13	2016-11-13
\.


--
-- Name: politics_idPolitician_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('"politics_idPolitician_seq"', 9, true);


--
-- Data for Name: proposals; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY proposals ("idProposal", "nameProposal", "dateProposal", description, "linkProposal") FROM stdin;
1	Alteração Orçamento de Estado	2006-10-01	Melhorar cenas para ficar tudo mais fixe e nice	www.melhorarcenas2006.pt
\.


--
-- Name: proposals_idProposal_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('"proposals_idProposal_seq"', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY users (uid, firstname, lastname, email, pwdhash) FROM stdin;
55	Luis	Telmo	t@t.pt	pbkdf2:sha1:1000$80hRPE87$85f64ca6a099803ade0b7159eed5b1b795eec495
1	Admin	Admin	ad@min.com	pbkdf2:sha1:1000$IMzAgjz6$8ba44a9dd23496b7f766c01fa584c46688a3413a
\.


--
-- Name: users_uid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('users_uid_seq', 55, true);


--
-- Name: politics_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta; Tablespace: 
--

ALTER TABLE ONLY politics
    ADD CONSTRAINT politics_pkey PRIMARY KEY ("idPolitician");


--
-- Name: proposals_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta; Tablespace: 
--

ALTER TABLE ONLY proposals
    ADD CONSTRAINT proposals_pkey PRIMARY KEY ("idProposal");


--
-- Name: users_email_key; Type: CONSTRAINT; Schema: public; Owner: luiscosta; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (uid);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

