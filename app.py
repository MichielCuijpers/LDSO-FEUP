from flask import Flask, render_template, request, session, redirect, url_for, g, flash
import os
from flask_login import LoginManager, UserMixin, \
                                login_required, login_user, logout_user, current_user


import datetime
#import flask_whooshalchemy as wa
#from models import db, User, Politic, Organization
from config import MAX_SEARCH_RESULTS
from forms import SignupForm, LoginForm, PoliticForm, OrganizationForm, SearchForm
import Tkinter as tk
import tkMessageBox


app = Flask(__name__)
#app.app_context()

#print(os.environ['APP_SETTINGS'])
app.config.from_object(os.environ['APP_SETTINGS'])
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['WHOOSH_BASE']='whoosh'

### MODELS.PY ###

from werkzeug import generate_password_hash, check_password_hash
from flask_sqlalchemy import SQLAlchemy


import sys
if sys.version_info >= (3, 0):
    enable_search = False
else:
    enable_search = True
    import flask_whooshalchemy as whooshalchemy


db = SQLAlchemy(app)

class User(db.Model):
  __tablename__ = 'users'
  uid = db.Column(db.Integer, primary_key = True)
  firstname = db.Column(db.String(100))
  lastname = db.Column(db.String(100))
  email = db.Column(db.String(120), unique=True)
  pwdhash = db.Column(db.String(150))

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
        #False as we do not support annonymity
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
  __searchable__ = ['publicName', 'completeName']
  __tablename__ = 'politics'


  idPolitician = db.Column(db.Integer, primary_key=True)
  publicName = db.Column(db.String(150))
  completeName = db.Column(db.String(300))
  startDate = db.Column(db.Date, default = datetime.datetime.utcnow)
  endDate = db.Column(db.Date, default = datetime.datetime.utcnow)

  def __init__(self, publicName, completeName, startDate, endDate):
    self.publicName = publicName.title()
    self.completeName = completeName.title()
    self.startDate = startDate.title()
    self.endDate = endDate.title()
  def __repr__(self):
  	return '<Politic %r>' % (self.publicName)

if enable_search:
  whooshalchemy.whoosh_index(app, Politic)
#from app import app





class Organization(db.Model):
  __searchable__ = ['publicname', 'completename']
  __tablename__ = 'organization'

  idOrganization = db.Column(db.Integer, primary_key=True)
  publicName = db.Column(db.String(150))
  completeName = db.Column(db.String(300))
  startDate = db.Column(db.Date, default = datetime.datetime.utcnow)
  endDate = db.Column(db.Date, default = datetime.datetime.utcnow)

  def __init__(self, publicName, completeName, startDate, endDate):
    self.publicName = publicName.title()
    self.completeName = completeName.title()
    self.startDate = startDate.title()
    self.endDate = endDate.title()


#from app import app

#if enable_search:
#  whooshalchemy.whoosh_index(app, Organization)


class Proposal(db.Model):
  __searchable__ = ['publicName', 'completeName']
  __tablename__ = 'proposals'

  idProposal = db.Column(db.Integer, primary_key = True)
  nameProposal = db.Column(db.String(120))
  dateProposal = db.Column(db.Date, default = datetime.datetime.utcnow)
  description = db.Column(db.String(500))
  linkProposal = db.Column(db.String(200))

  def __init__(self, nameProposal, dateProposal, description, linkProposal):
    self.nameProposal = nameProposal.title()
    self.dateProposal = dateProposal.title()
    self.description = description.title()
    self.linkProposal = linkProposal.title()

#from app import app
#if enable_search:
#  whooshalchemy.whoosh_index(app, Proposal)

class Category(db.Model):
  __tablename__ = 'category'

  idCategory = db.Column(db.Integer, primary_key = True)
  category = db.Column(db.String(200))
  description = db.Column(db.String(400))

  def __init__(self, category, description):
    self.category = category.title()
    self.description = description.title()


class Domain(db.Model):
  __tablename__= 'domain'

  idDomain = db.Column(db.Integer, primary_key = True)
  name = db.Column(db.String(120))
  officialName = db.Column(db.String(200))
  publicBioLink = db.Column(db.String(200))


class Role(db.Model):
  __tablename__= 'role'

  idRole = db.Column(db.Integer, primary_key = True)
  name = db.Column(db.String(200))

class Position(db.Model):
  __tablename__='position'

  idPosition = db.Column(db.Integer, primary_key = True)
  namePosition = db.Column(db.String(120))
  dateStart = db.Column(db.Date)
  dateEnd = db.Column(db.Date)
  link = db.Column(db.String(200))

### MODELS.PY ###

db.init_app(app)

login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = "login"

#wa.whoosh_index(app, Politic)



###HELLO TEST

@login_manager.user_loader
def user_loader(email):
    """Given *user_id*, return the associated User object.

    :param unicode user_id: user_id (email) user to retrieve
    """
    print email
    return User.query.filter_by(email=email).first()


######################## ROUTES ############################

@app.route("/", methods=["GET", "POST"])
def home():
  politics = db.session.query(Politic).all()
  return render_template("home.html", politics= politics)

@app.route("/about")
def about():
  return render_template("about.html")

@app.route("/signup", methods=["GET", "POST"])
def signup():
  if current_user.is_authenticated:
    return redirect(url_for('home'))

  form = SignupForm()

  if request.method == "POST":
    if form.validate() == False:
      return render_template('signup.html', form=form)
    else:
      newuser = User(form.first_name.data, form.last_name.data, form.email.data, form.password.data)
      db.session.add(newuser)
      db.session.commit()

      session['email'] = newuser.email
      return redirect(url_for('home'))

  elif request.method == "GET":
    return render_template('signup.html', form=form)

@app.route("/login", methods=["GET", "POST"])
def login():

  error = None
  print db

  form = LoginForm()

  if current_user.is_authenticated:
    return redirect(url_for('home'))

  if request.method == "POST":
    if form.validate() == False:
      return render_template("login.html", form=form)
    else:
      email = form.email.data
      password = form.password.data

      user = User.query.filter_by(email=email).first()
      if user is not None and user.check_password(password):
        login_user(user, remember=True)
        flash('You were logged in. Go Crazy. ')
        return redirect(url_for('home'))
      else:
        error = 'Invalid username or password.'
        return redirect(url_for('login'))

  elif request.method == 'GET':
    return render_template('login.html', form=form)

@app.route("/logout")
@login_required
def logout():
  logout_user()
  flash('You were logged out.')
  return redirect(url_for('home'))


######################## CREATE POLITICIAN ############################

#@app.route("/politician/<int:page>", methods=["GET", "POST"])
@app.route("/politician/<int:idPolitician>", methods=["GET", "POST"])
@app.route("/politician", methods=["GET", "POST"])
@login_required
def politician(idPolitician=1):
  politician = Politic.query.filter_by(idPolitician=idPolitician).first()
  print politician
  form = PoliticForm()

  if request.method == "POST":
    if form.validate() == False:
      return render_template('politician.html', form=form)
    else:
      newpolitician = Politic(form.publicName.data, form.completeName.data)
      db.session.add(newpolitician)
      db.session.commit()
      return redirect(url_for('home'))

  elif request.method == "GET":
    return render_template("politician.html", form=form, idPolitician=idPolitician, politician=politician)

@app.route("/create_politician", methods=["GET", "POST"])
@login_required
def create_politician():
  form = PoliticForm()

  if request.method == "POST":
    flash(form.errors)
    flash(request.form.get('date'))
    flash(request.form.get('date2'))
    stDate=datetime.datetime.strptime(request.form.get('date'), '%m/%d/%Y').strftime('%Y-%m-%d')
    endDate=datetime.datetime.strptime(request.form.get('date2'), '%m/%d/%Y').strftime('%Y-%m-%d')
    flash(form.validate())
    newpolitician = Politic(form.publicName.data, form.completeName.data, stDate,endDate)
    print form.startDate.data
    db.session.add(newpolitician)
    db.session.commit()
    return redirect(url_for('home'))

  elif request.method == "GET":
    return render_template("createPolitician.html", form=form)

@app.route("/edit_politician/<idPol>", methods=["POST", "GET"])
@login_required
def edit_politician(idPol=1):
  form = PoliticForm()
  politician = Politic.query.filter_by(idPolitician=idPol).first()
  if request.method =="POST":
    politician.publicName=request.form['publicName']
    politician.completeName=request.form['completeName']
    if request.form.get('date') != 'None':
      politician.startDate=datetime.datetime.strptime(request.form.get('date'), '%m/%d/%Y').strftime('%Y-%m-%d')
      print politician.startDate
    if request.form.get('date2') != 'None':
      politician.endDate=datetime.datetime.strptime(request.form.get('date2'), '%m/%d/%Y').strftime('%Y-%m-%d')
      print politician.endDate
    db.session.commit()
    return redirect(url_for('home'))
  elif request.method == "GET":
    dateStart=politician.startDate.strftime("%Y-%m-%d")
    dateEnd=politician.endDate.strftime("%Y-%m-%d")

    politician.startDate=datetime.datetime.strptime(dateStart, '%Y-%m-%d').strftime('%m/%d/%Y')
    politician.endDate=datetime.datetime.strptime(dateEnd, '%Y-%m-%d').strftime('%m/%d/%Y')
    return render_template("editPolitician.html", politician=politician)

@app.route("/delete_politician/<int:idPol>", methods=["POST"])
@login_required
def delete_politician(idPol):
  politician = Politic.query.filter_by(idPolitician=idPol).first()
  print politician
  if request.method == "POST":
    db.session.delete(politician)
    db.session.commit()
    return redirect(url_for('home'))

######################## CREATE ORGANIZATION ############################

@app.route("/organization/<int:idOrganization>", methods=["GET", "POST"])
@app.route("/organization", methods=["GET", "POST"])
@login_required
def organization(idOrganization=1):
  print "lols"
  organization = Organization.query.filter_by(idOrganization=idOrganization).first()
  print organization
  form = OrganizationForm()

  if request.method == "POST":
    if form.validate() == False:
      return render_template('organization.html', form=form)
    else:
      neworganization = Organization(form.publicName.data, form.completeName.data)
      db.session.add(neworganization)
      db.session.commit()
      return redirect(url_for('home'))

  elif request.method == "GET":
    return render_template("organization.html", form=form, idOrganization=idOrganization, organization=organization)


@app.route("/create_organization", methods=["GET", "POST"])
@login_required
def create_organization():
  form = OrganizationForm()

  if request.method == "POST":
    flash(form.errors)
    flash(request.form.get('date'))
    flash(request.form.get('date2'))
    flash(form.validate())
    neworganization = Organization(form.publicName.data, form.completeName.data, request.form.get('date'), request.form.get('date2'))
    db.session.add(neworganization)
    db.session.commit()
    return redirect(url_for('home'))

  elif request.method == "GET":
    return render_template("createOrganization.html", form=form)


################################# SEARCH #################################
#@app.route('/search')
#def search():
 # politics = Politic.query.whoosh_search(request.args.get('query')).all()
  #print politics

 # return render_template('home.html', politics=politics)

#root = tk.Tk()
#root.withdraw()

@app.before_request
def before_request():
    g.user = current_user
    if g.user.is_authenticated:
        g.user.last_seen = datetime.datetime.utcnow()
        db.session.add(g.user)
        db.session.commit()
        g.search_form = SearchForm()

@app.route('/search', methods=['GET', 'POST'])
@login_required
def search():
    if not g.search_form.validate_on_submit():
    	return redirect(url_for('home'))
    return redirect(url_for('search_results', query=g.search_form.search.data))

@app.route('/search_results/<query>')
@login_required
def search_results(query):
    results = Politic.query.whoosh_search(query, MAX_SEARCH_RESULTS).all()
    return render_template('search_results.html', query=query, results=results)

if __name__ == "__main__":
  app.run(debug=True)