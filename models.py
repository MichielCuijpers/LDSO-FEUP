from flask_sqlalchemy import SQLAlchemy
from werkzeug import generate_password_hash, check_password_hash
from flask_login import UserMixin


db = SQLAlchemy()

class User(db.Model):
  __tablename__ = 'users'
  uid = db.Column(db.Integer, primary_key = True)
  firstname = db.Column(db.String(100))
  lastname = db.Column(db.String(100))
  email = db.Column(db.String(120), unique=True)
  pwdhash = db.Column(db.String(54))

  #-----login requirements-----
  def is_active(self):
    #all users are active
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

class Politic(db.Model):
  __tablename__ = 'politics'

  idPolitician = db.Column(db.Integer, primary_key=True)
  publicName = db.Column(db.String(150))
  completeName = db.Column(db.String(300))

  def __repr__(self):
    return '<Politic %r>' % (self.body)
   