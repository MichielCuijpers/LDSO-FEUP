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
-- Name: category; Type: TABLE; Schema: public; Owner: luiscosta; Tablespace: 
--

CREATE TABLE category (
    "idCategory" integer NOT NULL,
    category text,
    description text
);


ALTER TABLE public.category OWNER TO luiscosta;

--
-- Name: domain; Type: TABLE; Schema: public; Owner: luiscosta; Tablespace: 
--

CREATE TABLE domain (
    "idDomain" integer NOT NULL,
    name text,
    "officialName" text,
    "startDate" date,
    "endDate" date,
    "domainLink" text
);


ALTER TABLE public.domain OWNER TO luiscosta;

--
-- Name: organization; Type: TABLE; Schema: public; Owner: luiscosta; Tablespace: 
--

CREATE TABLE organization (
    "idOrganization" integer NOT NULL,
    "publicName" text,
    "completeName" text,
    "startDate" date,
    "endDate" date
);


ALTER TABLE public.organization OWNER TO luiscosta;

--
-- Name: politics; Type: TABLE; Schema: public; Owner: luiscosta; Tablespace: 
--

CREATE TABLE politics (
    "publicName" text,
    "completeName" text,
    "idPolitician" integer NOT NULL
);


ALTER TABLE public.politics OWNER TO luiscosta;

--
-- Name: position; Type: TABLE; Schema: public; Owner: luiscosta; Tablespace: 
--

CREATE TABLE "position" (
    "idPosition" integer NOT NULL,
    "dateStart" date,
    "dateEnd" date,
    "positionLink" text
);


ALTER TABLE public."position" OWNER TO luiscosta;

--
-- Name: posts; Type: TABLE; Schema: public; Owner: luiscosta; Tablespace: 
--

CREATE TABLE posts (
    id integer NOT NULL,
    date character varying NOT NULL,
    description character varying NOT NULL,
    author_id integer
);


ALTER TABLE public.posts OWNER TO luiscosta;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_id_seq OWNER TO luiscosta;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- Name: proposals; Type: TABLE; Schema: public; Owner: luiscosta; Tablespace: 
--

CREATE TABLE proposals (
    "idProposal" integer NOT NULL,
    "proposalDate" date,
    "proposalLink" text,
    description text
);


ALTER TABLE public.proposals OWNER TO luiscosta;

--
-- Name: role; Type: TABLE; Schema: public; Owner: luiscosta; Tablespace: 
--

CREATE TABLE role (
    "roleID" integer NOT NULL,
    role text
);


ALTER TABLE public.role OWNER TO luiscosta;

--
-- Name: users; Type: TABLE; Schema: public; Owner: luiscosta; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    "idProposal" integer
);


ALTER TABLE public.users OWNER TO luiscosta;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO luiscosta;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY alembic_version (version_num) FROM stdin;
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY category ("idCategory", category, description) FROM stdin;
\.


--
-- Data for Name: domain; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY domain ("idDomain", name, "officialName", "startDate", "endDate", "domainLink") FROM stdin;
\.


--
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY organization ("idOrganization", "publicName", "completeName", "startDate", "endDate") FROM stdin;
\.


--
-- Data for Name: politics; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY politics ("publicName", "completeName", "idPolitician") FROM stdin;
\.


--
-- Data for Name: position; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY "position" ("idPosition", "dateStart", "dateEnd", "positionLink") FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY posts (id, date, description, author_id) FROM stdin;
1	Good	I'm good.	1
2	Well	I'm well.	1
3	Excellent	I'm excellent.	1
4	Okay	I'm okay.	1
5	Good	I'm good.	\N
6	Well	I'm well.	\N
7	Excellent	I'm excellent.	\N
8	Okay	I'm okay.	\N
9	Good	I'm good.	\N
10	Well	I'm well.	\N
11	Excellent	I'm excellent.	\N
12	Okay	I'm okay.	\N
13	hello	Criar um quadro de estabilidade na legislacao fiscal	\N
14	Well	I'm well.	\N
15	Excellent	I'm excellent.	\N
16	Okay	I'm okay.	\N
\.


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('posts_id_seq', 16, true);


--
-- Data for Name: proposals; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY proposals ("idProposal", "proposalDate", "proposalLink", description) FROM stdin;
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY role ("roleID", role) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY users (id, name, email, password, "idProposal") FROM stdin;
1	admin	admin.com	admin	\N
2	admin	admin.com	admin	\N
3	admin	admin.com	admin	\N
6	admin	admin.com	admin	\N
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('users_id_seq', 6, true);


--
-- Name: category_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta; Tablespace: 
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_pkey PRIMARY KEY ("idCategory");


--
-- Name: domain_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta; Tablespace: 
--

ALTER TABLE ONLY domain
    ADD CONSTRAINT domain_pkey PRIMARY KEY ("idDomain");


--
-- Name: organization_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta; Tablespace: 
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY ("idOrganization");


--
-- Name: politics_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta; Tablespace: 
--

ALTER TABLE ONLY politics
    ADD CONSTRAINT politics_pkey PRIMARY KEY ("idPolitician");


--
-- Name: position_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta; Tablespace: 
--

ALTER TABLE ONLY "position"
    ADD CONSTRAINT position_pkey PRIMARY KEY ("idPosition");


--
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: proposals_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta; Tablespace: 
--

ALTER TABLE ONLY proposals
    ADD CONSTRAINT proposals_pkey PRIMARY KEY ("idProposal");


--
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY ("roleID");


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: posts_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_author_id_fkey FOREIGN KEY (author_id) REFERENCES users(id);


--
-- Name: users_idProposal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY users
    ADD CONSTRAINT "users_idProposal_fkey" FOREIGN KEY ("idProposal") REFERENCES proposals("idProposal");


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

