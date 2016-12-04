import os
import datetime
import flask_whooshalchemy as wa
from flask import Flask, render_template, request, session, redirect, url_for, g, flash
from models import db, User, Politic, Organization
from forms import SignupForm, LoginForm, PoliticForm, OrganizationForm
from flask_login import LoginManager, UserMixin, \
                                login_required, login_user, logout_user, current_user


app = Flask(__name__)

#print(os.environ['APP_SETTINGS'])
app.config.from_object(os.environ['APP_SETTINGS'])
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['WHOOSH_BASE']='whoosh'
db.init_app(app)

login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = "login"

wa.whoosh_index(app, Politic)



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
@app.route('/search')
def search():
  politics = Politic.query.whoosh_search(request.args.get('query')).all()
  print politics

  return render_template('home.html', politics=politics)

@app.before_request
def before_request():
    g.user = current_user

if __name__ == "__main__":
  app.run(debug=True)
