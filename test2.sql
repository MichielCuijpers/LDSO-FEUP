DROP TABLE category CASCADE;
DROP TABLE domain;
DROP TABLE organizations CASCADE;
DROP TABLE organization;
DROP TABLE organizationsproposals;
DROP TABLE politics CASCADE;
DROP TABLE politicsproposals;
DROP TABLE position;
DROP TABLE proposals CASCADE;
DROP TABLE proposalstate;
DROP TABLE role;
DROP TABLE users;



--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.5
-- Dumped by pg_dump version 9.5.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

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
-- Name: category; Type: TABLE; Schema: public; Owner: arnaldo
--

CREATE TABLE category (
    idcategory integer NOT NULL,
    category text NOT NULL,
    description text
);


ALTER TABLE category OWNER TO arnaldo;

--
-- Name: category_idcategory_seq; Type: SEQUENCE; Schema: public; Owner: arnaldo
--

CREATE SEQUENCE category_idcategory_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE category_idcategory_seq OWNER TO arnaldo;

--
-- Name: category_idcategory_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arnaldo
--

ALTER SEQUENCE category_idcategory_seq OWNED BY category.idcategory;


--
-- Name: domain; Type: TABLE; Schema: public; Owner: arnaldo
--

CREATE TABLE domain (
    iddomain integer NOT NULL,
    name text NOT NULL,
    officialname text NOT NULL,
    publicbiolink text
);


ALTER TABLE domain OWNER TO arnaldo;

--
-- Name: domain_iddomain_seq; Type: SEQUENCE; Schema: public; Owner: arnaldo
--

CREATE SEQUENCE domain_iddomain_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE domain_iddomain_seq OWNER TO arnaldo;

--
-- Name: domain_iddomain_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arnaldo
--

ALTER SEQUENCE domain_iddomain_seq OWNED BY domain.iddomain;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: arnaldo
--

CREATE TABLE organizations (
    idorganization integer NOT NULL,
    publicname text NOT NULL,
    completename text NOT NULL,
    startdate numeric,
    enddate numeric,
    publicbiolink text,
    CONSTRAINT organizations_check CHECK ((startdate < enddate)),
    CONSTRAINT organizations_startdate_check CHECK (((startdate)::double precision <= date_part('isoyear'::text, now())))
);


ALTER TABLE organizations OWNER TO arnaldo;

--
-- Name: organizations_idorganization_seq; Type: SEQUENCE; Schema: public; Owner: arnaldo
--

CREATE SEQUENCE organizations_idorganization_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE organizations_idorganization_seq OWNER TO arnaldo;

--
-- Name: organizations_idorganization_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arnaldo
--

ALTER SEQUENCE organizations_idorganization_seq OWNED BY organizations.idorganization;


--
-- Name: organizationsproposals; Type: TABLE; Schema: public; Owner: arnaldo
--

CREATE TABLE organizationsproposals (
    "idProposal" integer NOT NULL,
    idorganization integer NOT NULL
);


ALTER TABLE organizationsproposals OWNER TO arnaldo;

--
-- Name: politics; Type: TABLE; Schema: public; Owner: arnaldo
--

CREATE TABLE politics (
    "idPolitician" integer NOT NULL,
    "publicName" character varying(150) NOT NULL,
    "completeName" character varying(300) NOT NULL,
    "publicBioLink" text,
    "startDate" timestamp without time zone,
    "endDate" timestamp without time zone,
    CONSTRAINT politics_check CHECK (("startDate" < "endDate"))
);


ALTER TABLE politics OWNER TO arnaldo;

--
-- Name: politics_idPolitician_seq; Type: SEQUENCE; Schema: public; Owner: arnaldo
--

CREATE SEQUENCE "politics_idPolitician_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "politics_idPolitician_seq" OWNER TO arnaldo;

--
-- Name: politics_idPolitician_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arnaldo
--

ALTER SEQUENCE "politics_idPolitician_seq" OWNED BY politics."idPolitician";


--
-- Name: politicsproposals; Type: TABLE; Schema: public; Owner: arnaldo
--

CREATE TABLE politicsproposals (
    "idProposal" integer NOT NULL,
    "idPolitician" integer NOT NULL
);


ALTER TABLE politicsproposals OWNER TO arnaldo;

--
-- Name: proposals; Type: TABLE; Schema: public; Owner: arnaldo
--

CREATE TABLE proposals (
    "idProposal" integer NOT NULL,
    description character varying(10000) NOT NULL,
    "dateProposal" timestamp without time zone,
    "linkProposal" character varying(1000),
    "idCategory" integer,
    "idProposalState" integer
);


ALTER TABLE proposals OWNER TO arnaldo;

--
-- Name: proposals_idProposal_seq; Type: SEQUENCE; Schema: public; Owner: arnaldo
--

CREATE SEQUENCE "proposals_idProposal_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "proposals_idProposal_seq" OWNER TO arnaldo;

--
-- Name: proposals_idProposal_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arnaldo
--

ALTER SEQUENCE "proposals_idProposal_seq" OWNED BY proposals."idProposal";


--
-- Name: proposalstate; Type: TABLE; Schema: public; Owner: arnaldo
--

CREATE TABLE proposalstate (
    idproposalstate integer NOT NULL,
    name text NOT NULL,
    description text,
    statedate timestamp without time zone,
    statelink text
);


ALTER TABLE proposalstate OWNER TO arnaldo;

--
-- Name: proposalstate_idproposalstate_seq; Type: SEQUENCE; Schema: public; Owner: arnaldo
--

CREATE SEQUENCE proposalstate_idproposalstate_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proposalstate_idproposalstate_seq OWNER TO arnaldo;

--
-- Name: proposalstate_idproposalstate_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arnaldo
--

ALTER SEQUENCE proposalstate_idproposalstate_seq OWNED BY proposalstate.idproposalstate;


--
-- Name: role; Type: TABLE; Schema: public; Owner: arnaldo
--

CREATE TABLE role (
    idrole integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE role OWNER TO arnaldo;

--
-- Name: role_idrole_seq; Type: SEQUENCE; Schema: public; Owner: arnaldo
--

CREATE SEQUENCE role_idrole_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE role_idrole_seq OWNER TO arnaldo;

--
-- Name: role_idrole_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arnaldo
--

ALTER SEQUENCE role_idrole_seq OWNED BY role.idrole;


--
-- Name: users; Type: TABLE; Schema: public; Owner: arnaldo
--

CREATE TABLE users (
    uid integer NOT NULL,
    firstname character varying(100) NOT NULL,
    lastname character varying(100) NOT NULL,
    email character varying(120) NOT NULL,
    pwdhash character varying(150) NOT NULL,
    phonenumber integer
);


ALTER TABLE users OWNER TO arnaldo;

--
-- Name: users_uid_seq; Type: SEQUENCE; Schema: public; Owner: arnaldo
--

CREATE SEQUENCE users_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_uid_seq OWNER TO arnaldo;

--
-- Name: users_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arnaldo
--

ALTER SEQUENCE users_uid_seq OWNED BY users.uid;


--
-- Name: idcategory; Type: DEFAULT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY category ALTER COLUMN idcategory SET DEFAULT nextval('category_idcategory_seq'::regclass);


--
-- Name: iddomain; Type: DEFAULT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY domain ALTER COLUMN iddomain SET DEFAULT nextval('domain_iddomain_seq'::regclass);


--
-- Name: idorganization; Type: DEFAULT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY organizations ALTER COLUMN idorganization SET DEFAULT nextval('organizations_idorganization_seq'::regclass);


--
-- Name: idPolitician; Type: DEFAULT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY politics ALTER COLUMN "idPolitician" SET DEFAULT nextval('"politics_idPolitician_seq"'::regclass);


--
-- Name: idProposal; Type: DEFAULT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY proposals ALTER COLUMN "idProposal" SET DEFAULT nextval('"proposals_idProposal_seq"'::regclass);


--
-- Name: idproposalstate; Type: DEFAULT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY proposalstate ALTER COLUMN idproposalstate SET DEFAULT nextval('proposalstate_idproposalstate_seq'::regclass);


--
-- Name: idrole; Type: DEFAULT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY role ALTER COLUMN idrole SET DEFAULT nextval('role_idrole_seq'::regclass);


--
-- Name: uid; Type: DEFAULT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY users ALTER COLUMN uid SET DEFAULT nextval('users_uid_seq'::regclass);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: arnaldo
--

COPY category (idcategory, category, description) FROM stdin;
1	Serviços públicos administrativos	\N
2	Defesa	\N
3	Ordem pública e segurança	\N
4	Assuntos económicos	\N
5	Protecção ambiental	\N
6	Habitação e equipamentos colectivos	\N
7	Saúde	\N
8	Recreação, cultura e religião	\N
9	Educação	\N
10	Protecção Social	\N
\.


--
-- Name: category_idcategory_seq; Type: SEQUENCE SET; Schema: public; Owner: arnaldo
--

SELECT pg_catalog.setval('category_idcategory_seq', 1, false);


--
-- Data for Name: domain; Type: TABLE DATA; Schema: public; Owner: arnaldo
--

COPY domain (iddomain, name, officialname, publicbiolink) FROM stdin;
1	Portugal	República Portuguesa	https://pt.wikipedia.org/wiki/Portugal
2	Porto	Porto	https://pt.wikipedia.org/wiki/Porto
3	Lisboa	Lisboa	https://pt.wikipedia.org/wiki/Lisboa
4	Europa	União Europeia	https://en.wikipedia.org/wiki/European_Union
5	Loures	Loures	https://pt.wikipedia.org/wiki/Loures
6	Fundão	Fundão	https://pt.wikipedia.org/wiki/Fund%C3%A3o_(Castelo_Branco)
7	Figueira da Foz	Figueira da Foz	https://pt.wikipedia.org/wiki/Figueira_da_Foz
8	Amadora	Amadora	https://pt.wikipedia.org/wiki/Amadora
9	Vila Real	Vila Real	https://pt.wikipedia.org/wiki/Vila_Real
10	Covilhã	Covilhã	https://pt.wikipedia.org/wiki/Covilh%C3%A3
\.


--
-- Name: domain_iddomain_seq; Type: SEQUENCE SET; Schema: public; Owner: arnaldo
--

SELECT pg_catalog.setval('domain_iddomain_seq', 1, false);


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: arnaldo
--

COPY organizations (idorganization, publicname, completename, startdate, enddate, publicbiolink) FROM stdin;
1	PSD	Partido Social Democrata	1974	\N	https://pt.wikipedia.org/wiki/Partido_Social_Democrata_(Portugal)
2	PS	Partido Socialista	1973	\N	https://pt.wikipedia.org/wiki/Partido_Socialista_(Portugal)
3	CDS	CDS - Popular	1974	\N	https://pt.wikipedia.org/wiki/CDS_–_Partido_Popular
4	PCP	Partido Comunista Português	1921	\N	https://pt.wikipedia.org/wiki/Partido_Comunista_Português
5	BE	Bloco de Esquerda	2000	\N	https://pt.wikipedia.org/wiki/Bloco_de_Esquerda_(Portugal)
6	PEV	Partido Ecologista "Os Verdes"	1982	\N	https://pt.wikipedia.org/wiki/Partido_Ecologista_Os_Verdes
7	PSD	Partido Social Democrata	\N	\N	\N
\.


--
-- Name: organizations_idorganization_seq; Type: SEQUENCE SET; Schema: public; Owner: arnaldo
--

SELECT pg_catalog.setval('organizations_idorganization_seq', 1, false);


--
-- Data for Name: organizationsproposals; Type: TABLE DATA; Schema: public; Owner: arnaldo
--

COPY organizationsproposals ("idProposal", idorganization) FROM stdin;
1	2
2	2
3	2
4	2
5	2
\.


--
-- Data for Name: politics; Type: TABLE DATA; Schema: public; Owner: arnaldo
--

COPY politics ("idPolitician", "publicName", "completeName", "publicBioLink", "startDate", "endDate") FROM stdin;
1	António Costa	António Luís dos Santos da Costa	https://en.wikipedia.org/wiki/António_Costa	\N	\N
2	Pedro Passos Coelho	Pedro Manuel Mamede Passos Coelho	https://pt.wikipedia.org/wiki/Pedro_Passos_Coelho	\N	\N
3	José Sócrates	José Sócrates Carvalho Pinto de Sousa	https://pt.wikipedia.org/wiki/José_Sócrates	\N	\N
4	António Costa	Pedro Miguel de Santana Lopes	https://pt.wikipedia.org/wiki/Pedro_Santana_Lopes	\N	\N
5	Durão Barroso	José Manuel Durão Barroso	https://pt.wikipedia.org/wiki/José_Manuel_Barroso	\N	\N
6	António Guterres	António Manuel de Oliveira Guterres	https://pt.wikipedia.org/wiki/António_Guterres	\N	\N
\.


--
-- Name: politics_idPolitician_seq; Type: SEQUENCE SET; Schema: public; Owner: arnaldo
--

SELECT pg_catalog.setval('"politics_idPolitician_seq"', 1, false);


--
-- Data for Name: politicsproposals; Type: TABLE DATA; Schema: public; Owner: arnaldo
--

COPY politicsproposals ("idProposal", "idPolitician") FROM stdin;
1	1
2	1
3	1
4	1
5	1
6	1
\.


--
-- Data for Name: proposals; Type: TABLE DATA; Schema: public; Owner: arnaldo
--

COPY proposals ("idProposal", description, "dateProposal", "linkProposal", "idCategory", "idProposalState") FROM stdin;
1	Criar um quadro de estabilidade na legislação fiscal	2015-06-07 00:00:00	http://observador.pt/interativo/guia-eleitoral-2015/#/partidos/ps/; http://www.ps.pt/images/imprensa/convencao_nacional/programaeleitoral-PS-legislativas2015.pdf	1	1
2	Proibir execuções fiscais sobre casas de famílias que digam respeito a dívidas de valor inferior ao valor do bem executado	2015-06-07 00:00:00	http://observador.pt/interativo/guia-eleitoral-2015/#/partidos/ps/; http://www.ps.pt/images/imprensa/convencao_nacional/programaeleitoral-PS-legislativas2015.pdf	1	1
3	Criação de mecanismos de monitorização e gestão da parcela da dívida pública dos Estados que exceda os limites de Maastricht	2015-06-07 00:00:00	http://observador.pt/interativo/guia-eleitoral-2015/#/partidos/ps/; http://www.ps.pt/images/imprensa/convencao_nacional/programaeleitoral-PS-legislativas2015.pdf	1	1
4	Extinção da sobretaxa do IRS entre 2016 e 2017 (metade em cada ano)	2015-06-07 00:00:00	http://www.ps.pt/images/imprensa/convencao_nacional/programa_eleitoral-PS-legislativas2015.pdf; http://observador.pt/interativo/guia-eleitoral-2015/#/partidos/ps/; http://costa2015.pt/	1	1
5	Criar um imposto sobre heranças de elevado valor (heranças cujo valor global atinja um milhão de euros)	2015-06-07 00:00:00	http://observador.pt/interativo/guia-eleitoral-2015/#/partidos/ps/; http://www.ps.pt/images/imprensa/convencao_nacional/programaeleitoral-PS-legislativas2015.pdf	1	1
6	Teste Description	2016-12-04 00:00:00	Https://Www.Google.Pt/Search?Client=Ubuntu&Channel=Fs&Q=Isto+E+Um+Teste&Ie=Utf-8&Oe=Utf-8&Gfe_Rd=Cr&Ei=Cvtcwknnmoqt8Weu7Lfgcg	\N	\N
\.


--
-- Name: proposals_idProposal_seq; Type: SEQUENCE SET; Schema: public; Owner: arnaldo
--

SELECT pg_catalog.setval('"proposals_idProposal_seq"', 6, true);


--
-- Data for Name: proposalstate; Type: TABLE DATA; Schema: public; Owner: arnaldo
--

COPY proposalstate (idproposalstate, name, description, statedate, statelink) FROM stdin;
1	Em aberto	Pessoa foi eleita, e ainda não cumpriu o compromisso, nem fez nada em sentido contrário	\N	\N
2	Cumprido	Pessoa cumpriu o compromisso\t	\N	\N
3	Não cumprido	Pessoa não cumpriu o compromisso até ao final do cargo, ou tomou uma ação em sentido contrário, por qualquer razão	\N	\N
4	Invalidado	Pessoa não foi eleita para o cargo, e desse modo não tem possibilidade de cumprir o compromisso	\N	\N
5	Pouco específica	\N	\N	\N
\.


--
-- Name: proposalstate_idproposalstate_seq; Type: SEQUENCE SET; Schema: public; Owner: arnaldo
--

SELECT pg_catalog.setval('proposalstate_idproposalstate_seq', 1, false);


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: arnaldo
--

COPY role (idrole, name) FROM stdin;
1	Primeiro(a)-ministro(a)
2	Ministro(a)
3	Governante
4	Deputado(a) parlamentar
5	Presidente da República
6	Secretário(a) de Estado
7	Presidente de Câmara Municipal
8	Vereador(a) de Câmara municipal
9	Membro Assembleia Municipal
10	Líder do partido
11	Militante do partido
12	Presidente de Assembleia Municipal
13	Membro de Assembleia Municipal
\.


--
-- Name: role_idrole_seq; Type: SEQUENCE SET; Schema: public; Owner: arnaldo
--

SELECT pg_catalog.setval('role_idrole_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: arnaldo
--

COPY users (uid, firstname, lastname, email, pwdhash, phonenumber) FROM stdin;
1	A	A	a@a.pt	pbkdf2:sha1:1000$l7ceGA7B$93ce8c258b1906984c322abf719b875c98c85c15	\N
\.


--
-- Name: users_uid_seq; Type: SEQUENCE SET; Schema: public; Owner: arnaldo
--

SELECT pg_catalog.setval('users_uid_seq', 1, true);


--
-- Name: category_category_key; Type: CONSTRAINT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_category_key UNIQUE (category);


--
-- Name: category_pkey; Type: CONSTRAINT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_pkey PRIMARY KEY (idcategory);


--
-- Name: domain_pkey; Type: CONSTRAINT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY domain
    ADD CONSTRAINT domain_pkey PRIMARY KEY (iddomain);


--
-- Name: organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (idorganization);


--
-- Name: organizationsproposals_pkey; Type: CONSTRAINT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY organizationsproposals
    ADD CONSTRAINT organizationsproposals_pkey PRIMARY KEY (idorganization, "idProposal");


--
-- Name: politics_pkey; Type: CONSTRAINT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY politics
    ADD CONSTRAINT politics_pkey PRIMARY KEY ("idPolitician");


--
-- Name: politicsproposals_pkey; Type: CONSTRAINT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY politicsproposals
    ADD CONSTRAINT politicsproposals_pkey PRIMARY KEY ("idPolitician", "idProposal");


--
-- Name: proposals_pkey; Type: CONSTRAINT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY proposals
    ADD CONSTRAINT proposals_pkey PRIMARY KEY ("idProposal");


--
-- Name: proposalstate_pkey; Type: CONSTRAINT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY proposalstate
    ADD CONSTRAINT proposalstate_pkey PRIMARY KEY (idproposalstate);


--
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (idrole);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (uid);


--
-- Name: organizationsproposals_idProposal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY organizationsproposals
    ADD CONSTRAINT "organizationsproposals_idProposal_fkey" FOREIGN KEY ("idProposal") REFERENCES proposals("idProposal") ON DELETE CASCADE;


--
-- Name: organizationsproposals_idorganization_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY organizationsproposals
    ADD CONSTRAINT organizationsproposals_idorganization_fkey FOREIGN KEY (idorganization) REFERENCES organizations(idorganization) ON DELETE CASCADE;


--
-- Name: politicsproposals_idPolitician_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY politicsproposals
    ADD CONSTRAINT "politicsproposals_idPolitician_fkey" FOREIGN KEY ("idPolitician") REFERENCES politics("idPolitician") ON DELETE CASCADE;


--
-- Name: politicsproposals_idProposal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY politicsproposals
    ADD CONSTRAINT "politicsproposals_idProposal_fkey" FOREIGN KEY ("idProposal") REFERENCES proposals("idProposal") ON DELETE CASCADE;


--
-- Name: proposals_idCategory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY proposals
    ADD CONSTRAINT "proposals_idCategory_fkey" FOREIGN KEY ("idCategory") REFERENCES category(idcategory) ON DELETE CASCADE;


--
-- Name: proposals_idProposalState_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnaldo
--

ALTER TABLE ONLY proposals
    ADD CONSTRAINT "proposals_idProposalState_fkey" FOREIGN KEY ("idProposalState") REFERENCES proposalstate(idproposalstate) ON DELETE CASCADE;


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

