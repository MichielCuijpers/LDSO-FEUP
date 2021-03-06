from project import app
from flask_sqlalchemy import SQLAlchemy
from werkzeug import generate_password_hash, check_password_hash
import datetime
import flask_whooshalchemy as whooshalchemy





db = SQLAlchemy(app)


class User(db.Model):
    __tablename__ = 'users'
    uid = db.Column(db.Integer, primary_key=True)
    firstname = db.Column(db.String(100))
    lastname = db.Column(db.String(100))
    email = db.Column(db.String(120), unique=True)
    pwdhash = db.Column(db.String(150))

    # -----login requirements-----
    def is_active(self):
        # all users are active
        return True

    def get_id(self):
        # returns the user e-mail. not sure who calls this
        return self.email

    def is_authenticated(self):
        return True

    def is_anonymous(self):
        # False as we do not support annonymity
        return False

    def __init__(self, firstname, lastname, email, password):
        self.firstname = firstname.title()
        self.lastname = lastname.title()
        self.email = email.lower()
        self.set_password(password)

    def set_password(self, password):
        self.pwdhash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.pwdhash, password)


proposal_politician_association = db.Table('politicsproposals',
                                           db.Column('idPolitician', db.Integer,
                                                     db.ForeignKey('politics.idPolitician')),
                                           db.Column('idProposal', db.Integer, db.ForeignKey('proposals.idProposal')))


class Politic(db.Model):
    __searchable__ = ['publicName', 'completeName']
    __tablename__ = 'politics'

    idPolitician = db.Column(db.Integer, primary_key=True)
    publicName = db.Column(db.String(150))
    completeName = db.Column(db.String(300))
    startDate = db.Column(db.Date, default=datetime.datetime.utcnow)
    endDate = db.Column(db.Date, default=datetime.datetime.utcnow)

    def __init__(self, publicName, completeName, startDate, endDate):
        self.publicName = publicName.title()
        self.completeName = completeName.title()
        self.startDate = startDate.title()
        self.endDate = endDate.title()

    def __repr__(self):
        return '<Politic %r>' % (self.publicName)


whooshalchemy.whoosh_index(app, Politic)


class Organization(db.Model):
    __searchable__ = ['publicName', 'completeName']
    __tablename__ = 'organization'

    idOrganization = db.Column(db.Integer, primary_key=True)
    publicName = db.Column(db.String(150))
    completeName = db.Column(db.String(300))
    startDate = db.Column(db.Date, default=datetime.datetime.utcnow)
    endDate = db.Column(db.Date, default=datetime.datetime.utcnow)

    def __init__(self, publicName, completeName, startDate, endDate):
        self.publicName = publicName.title()
        self.completeName = completeName.title()
        self.startDate = startDate.title()
        self.endDate = endDate.title()


class Proposal(db.Model):
    __tablename__ = 'proposals'

    idProposal = db.Column(db.Integer, primary_key=True)
    dateProposal = db.Column(db.Date, default=datetime.datetime.utcnow)
    description = db.Column(db.String(500))
    linkProposal = db.Column(db.String(200))
    children = db.relationship("Politic", secondary=proposal_politician_association,
                               backref=db.backref('pol_proposals', lazy='dynamic'))

    def __init__(self, dateProposal, description, linkProposal):
        self.dateProposal = dateProposal.title()
        self.description = description.title()
        self.linkProposal = linkProposal.title()


class Category(db.Model):
    __tablename__ = 'category'

    idCategory = db.Column(db.Integer, primary_key=True)
    category = db.Column(db.String(200))
    description = db.Column(db.String(400))

    def __init__(self, category, description):
        self.category = category.title()
        self.description = description.title()


class Domain(db.Model):
    __tablename__ = 'domain'

    idDomain = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(120))
    officialName = db.Column(db.String(200))
    publicBioLink = db.Column(db.String(200))


class Role(db.Model):
    __tablename__ = 'role'

    idRole = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(200))


class Position(db.Model):
    __tablename__ = 'position'

    idPosition = db.Column(db.Integer, primary_key=True)
    namePosition = db.Column(db.String(120))
    dateStart = db.Column(db.Date)
    dateEnd = db.Column(db.Date)
    link = db.Column(db.String(200))