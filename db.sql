DROP TABLE IF EXISTS position;
DROP TABLE IF EXISTS role;
DROP TABLE IF EXISTS domain;
DROP TABLE IF EXISTS PoliticsProposals;
DROP TABLE IF EXISTS politics;
DROP TABLE IF EXISTS OrganizationsProposals;
DROP TABLE IF EXISTS proposals CASCADE;
DROP TABLE IF EXISTS proposalstate;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS organizations;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS alembic_version;


CREATE TABLE users (
    uid SERIAL PRIMARY KEY,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL,
    pwdhash VARCHAR(150) NOT NULL,
    phoneNumber INTEGER
);

CREATE TABLE organizations (
    idOrganization SERIAL PRIMARY KEY,
    publicName TEXT NOT NULL,
    completeName TEXT NOT NULL,
    startDate NUMERIC CHECK (startDate <= EXTRACT(ISOYEAR FROM CURRENT_TIMESTAMP)),
    endDate NUMERIC CHECK (startDate < endDate),
    publicBioLink TEXT
);

CREATE TABLE category (
    idCategory SERIAL PRIMARY KEY,
    category TEXT UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE proposalstate (
	idProposalState SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	description TEXT,
	stateDate TIMESTAMP,
	stateLink TEXT
);

SELECT EXTRACT(ISOYEAR FROM CURRENT_TIMESTAMP);

CREATE TABLE proposals (
    "idProposal" SERIAL PRIMARY KEY,
   -- nameProposal VARCHAR(120) NOT NULL,
    "description" VARCHAR(10000) NOT NULL,
    "dateProposal" TIMESTAMP,    
    "linkProposal" VARCHAR(1000),
    "idCategory" INTEGER REFERENCES category(idCategory) ON DELETE CASCADE,
    "idProposalState" INTEGER REFERENCES proposalstate(idProposalState) ON DELETE CASCADE
);

CREATE TABLE OrganizationsProposals (
	"idProposal" INTEGER NOT NULL REFERENCES proposals("idProposal") ON DELETE CASCADE,
	idOrganization INTEGER NOT NULL REFERENCES organizations(idOrganization) ON DELETE CASCADE,
	PRIMARY KEY(idOrganization, "idProposal")
);

CREATE TABLE politics (
    "idPolitician" SERIAL PRIMARY KEY,
    "publicName" VARCHAR(150) NOT NULL,
    "completeName" VARCHAR(300) NOT NULL,
    "publicBioLink" TEXT,
    "startDate" TIMESTAMP,
    "endDate" TIMESTAMP CHECK ("startDate" < "endDate")
);

CREATE TABLE PoliticsProposals (
	"idProposal" INTEGER NOT NULL REFERENCES proposals("idProposal") ON DELETE CASCADE,
	"idPolitician" INTEGER NOT NULL REFERENCES politics("idPolitician") ON DELETE CASCADE,
	PRIMARY KEY("idPolitician", "idProposal")
);

CREATE TABLE domain (
	idDomain SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	officialName TEXT NOT NULL,
	publicBioLink TEXT
);

CREATE TABLE role (
	idRole SERIAL PRIMARY KEY,
	name TEXT NOT NULL
);

CREATE TABLE position (
	idPosition SERIAL PRIMARY KEY ,
	name TEXT NOT NULL,
	"dateStart" TIMESTAMP,
	"dateEnd" TIMESTAMP CHECK ("dateStart" < "dateEnd"),
	link TEXT,
	idPolitician INTEGER NOT NULL REFERENCES politics(idPolitician) ON DELETE CASCADE,
	idRole INTEGER NOT NULL REFERENCES role(idRole) ON DELETE CASCADE,
	idDomain INTEGER REFERENCES domain(idDomain),
	idOrganization INTEGER NOT NULL REFERENCES organizations(idOrganization) ON DELETE CASCADE
);

INSERT INTO category VALUES (1, 'Serviços públicos administrativos', NULL);
INSERT INTO category VALUES (2, 'Defesa', NULL);
INSERT INTO category VALUES (3, 'Ordem pública e segurança', NULL);
INSERT INTO category VALUES (4, 'Assuntos económicos', NULL);
INSERT INTO category VALUES (5, 'Protecção ambiental', NULL);
INSERT INTO category VALUES (6, 'Habitação e equipamentos colectivos', NULL);
INSERT INTO category VALUES (7, 'Saúde', NULL);
INSERT INTO category VALUES (8, 'Recreação, cultura e religião', NULL);
INSERT INTO category VALUES (9, 'Educação', NULL);
INSERT INTO category VALUES (10, 'Protecção Social', NULL);

INSERT INTO domain VALUES (1, 'Portugal', 'República Portuguesa', 'https://pt.wikipedia.org/wiki/Portugal');
INSERT INTO domain VALUES (2, 'Porto', 'Porto', 'https://pt.wikipedia.org/wiki/Porto');
INSERT INTO domain VALUES (3, 'Lisboa', 'Lisboa', 'https://pt.wikipedia.org/wiki/Lisboa');
INSERT INTO domain VALUES (4, 'Europa', 'União Europeia', 'https://en.wikipedia.org/wiki/European_Union');
INSERT INTO domain VALUES (5, 'Loures', 'Loures', 'https://pt.wikipedia.org/wiki/Loures');
INSERT INTO domain VALUES (6, 'Fundão', 'Fundão', 'https://pt.wikipedia.org/wiki/Fund%C3%A3o_(Castelo_Branco)');
INSERT INTO domain VALUES (7, 'Figueira da Foz', 'Figueira da Foz', 'https://pt.wikipedia.org/wiki/Figueira_da_Foz');
INSERT INTO domain VALUES (8, 'Amadora', 'Amadora', 'https://pt.wikipedia.org/wiki/Amadora');
INSERT INTO domain VALUES (9, 'Vila Real', 'Vila Real', 'https://pt.wikipedia.org/wiki/Vila_Real');
INSERT INTO domain VALUES (10, 'Covilhã', 'Covilhã', 'https://pt.wikipedia.org/wiki/Covilh%C3%A3');

INSERT INTO role VALUES (1, 'Primeiro(a)-ministro(a)');
INSERT INTO role VALUES (2, 'Ministro(a)');
INSERT INTO role VALUES (3, 'Governante');
INSERT INTO role VALUES (4, 'Deputado(a) parlamentar');
INSERT INTO role VALUES (5, 'Presidente da República');
INSERT INTO role VALUES (6, 'Secretário(a) de Estado');
INSERT INTO role VALUES (7, 'Presidente de Câmara Municipal');
INSERT INTO role VALUES (8, 'Vereador(a) de Câmara municipal');
INSERT INTO role VALUES (9, 'Membro Assembleia Municipal');
INSERT INTO role VALUES (10, 'Líder do partido');
INSERT INTO role VALUES (11, 'Militante do partido');
INSERT INTO role VALUES (12, 'Presidente de Assembleia Municipal');
INSERT INTO role VALUES (13, 'Membro de Assembleia Municipal');

INSERT INTO proposalstate VALUES (1, 'Em aberto', 'Pessoa foi eleita, e ainda não cumpriu o compromisso, nem fez nada em sentido contrário', NULL, NULL);
INSERT INTO proposalstate VALUES (2, 'Cumprido', 'Pessoa cumpriu o compromisso	', NULL, NULL);
INSERT INTO proposalstate VALUES (3, 'Não cumprido', 'Pessoa não cumpriu o compromisso até ao final do cargo, ou tomou uma ação em sentido contrário, por qualquer razão', NULL, NULL);
INSERT INTO proposalstate VALUES (4, 'Invalidado', 'Pessoa não foi eleita para o cargo, e desse modo não tem possibilidade de cumprir o compromisso', NULL, NULL);
INSERT INTO proposalstate VALUES (5, 'Pouco específica', NULL, NULL);


INSERT INTO politics VALUES (1, 'António Costa', 'António Luís dos Santos da Costa', 'https://en.wikipedia.org/wiki/António_Costa', NULL, NULL);
INSERT INTO politics VALUES (2, 'Pedro Passos Coelho', 'Pedro Manuel Mamede Passos Coelho', 'https://pt.wikipedia.org/wiki/Pedro_Passos_Coelho', NULL, NULL);
INSERT INTO politics VALUES (3, 'José Sócrates', 'José Sócrates Carvalho Pinto de Sousa', 'https://pt.wikipedia.org/wiki/José_Sócrates', NULL, NULL);
INSERT INTO politics VALUES (4, 'António Costa', 'Pedro Miguel de Santana Lopes', 'https://pt.wikipedia.org/wiki/Pedro_Santana_Lopes', NULL, NULL);
INSERT INTO politics VALUES (5, 'Durão Barroso', 'José Manuel Durão Barroso', 'https://pt.wikipedia.org/wiki/José_Manuel_Barroso', NULL, NULL);
INSERT INTO politics VALUES (6, 'António Guterres', 'António Manuel de Oliveira Guterres', 'https://pt.wikipedia.org/wiki/António_Guterres', NULL, NULL);

INSERT INTO organizations VALUES (1, 'PSD', 'Partido Social Democrata', '1974', NULL, 'https://pt.wikipedia.org/wiki/Partido_Social_Democrata_(Portugal)');
INSERT INTO organizations VALUES (2, 'PS', 'Partido Socialista', '1973', NULL, 'https://pt.wikipedia.org/wiki/Partido_Socialista_(Portugal)');
INSERT INTO organizations VALUES (3, 'CDS', 'CDS - Popular', '1974', NULL, 'https://pt.wikipedia.org/wiki/CDS_–_Partido_Popular');
INSERT INTO organizations VALUES (4, 'PCP', 'Partido Comunista Português', '1921', NULL, 'https://pt.wikipedia.org/wiki/Partido_Comunista_Português');
INSERT INTO organizations VALUES (5, 'BE', 'Bloco de Esquerda', '2000', NULL, 'https://pt.wikipedia.org/wiki/Bloco_de_Esquerda_(Portugal)');
INSERT INTO organizations VALUES (6, 'PEV', 'Partido Ecologista "Os Verdes"', '1982', NULL, 'https://pt.wikipedia.org/wiki/Partido_Ecologista_Os_Verdes');
INSERT INTO organizations VALUES (7, 'PSD', 'Partido Social Democrata', NULL, NULL, NULL);

INSERT INTO position VALUES (1, 'Efectivo', '1993-12-11', '1995-10-27', NULL, 1, 1, 1, 2);
INSERT INTO position VALUES (2, 'Candidato', '2013-07-01', '2013-09-29', 'http://eleicoes.cne.pt/sel_eleicoes.cfm?m=raster', 1, 7, 3, 2);

INSERT INTO proposals VALUES (1, 'Criar um quadro de estabilidade na legislação fiscal', '2015-06-07', 'http://observador.pt/interativo/guia-eleitoral-2015/#/partidos/ps/; http://www.ps.pt/images/imprensa/convencao_nacional/programaeleitoral-PS-legislativas2015.pdf', 1, 1);
INSERT INTO OrganizationsProposals VALUES (1, 2);
INSERT INTO PoliticsProposals VALUES (1, 1);

INSERT INTO proposals VALUES (2, 'Proibir execuções fiscais sobre casas de famílias que digam respeito a dívidas de valor inferior ao valor do bem executado', '2015-06-07', 'http://observador.pt/interativo/guia-eleitoral-2015/#/partidos/ps/; http://www.ps.pt/images/imprensa/convencao_nacional/programaeleitoral-PS-legislativas2015.pdf', 1, 1);
INSERT INTO OrganizationsProposals VALUES (2, 2);
INSERT INTO PoliticsProposals VALUES (2, 1);

INSERT INTO proposals VALUES (3, 'Criação de mecanismos de monitorização e gestão da parcela da dívida pública dos Estados que exceda os limites de Maastricht', '2015-06-07', 'http://observador.pt/interativo/guia-eleitoral-2015/#/partidos/ps/; http://www.ps.pt/images/imprensa/convencao_nacional/programaeleitoral-PS-legislativas2015.pdf', 1, 1);
INSERT INTO OrganizationsProposals VALUES (3, 2);
INSERT INTO PoliticsProposals VALUES (3, 1);

INSERT INTO proposals VALUES (4, 'Extinção da sobretaxa do IRS entre 2016 e 2017 (metade em cada ano)', '2015-06-07', 'http://www.ps.pt/images/imprensa/convencao_nacional/programa_eleitoral-PS-legislativas2015.pdf; http://observador.pt/interativo/guia-eleitoral-2015/#/partidos/ps/; http://costa2015.pt/', 1, 1);
INSERT INTO OrganizationsProposals VALUES (4, 2);
INSERT INTO PoliticsProposals VALUES (4, 1);

INSERT INTO proposals VALUES (5, 'Criar um imposto sobre heranças de elevado valor (heranças cujo valor global atinja um milhão de euros)', '2015-06-07', 'http://observador.pt/interativo/guia-eleitoral-2015/#/partidos/ps/; http://www.ps.pt/images/imprensa/convencao_nacional/programaeleitoral-PS-legislativas2015.pdf', 1, 1);
INSERT INTO OrganizationsProposals VALUES (5, 2);
INSERT INTO PoliticsProposals VALUES (5, 1);

