import os
import flask_whooshalchemy as wa
from flask import Flask, render_template, request, session, redirect, url_for, g, flash
from models import db, User, Politic
from forms import SignupForm, LoginForm, PoliticForm
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


@app.route("/")
def index():
  return render_template("index.html")

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
  return redirect(url_for('index'))

@app.route("/home", methods=["GET", "POST"])
@login_required
def home():

  politics = db.session.query(Politic).all()
  return render_template("home.html", politics= politics)

@app.route("/politician", methods=["GET", "POST"])
@login_required
def politician():

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
    return render_template("politician.html", form=form)

  

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