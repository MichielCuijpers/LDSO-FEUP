from flask import Flask, render_template, request, session, redirect, url_for, g
from models import db, User
from forms import SignupForm, LoginForm
from flask_login import LoginManager, UserMixin, \
                                login_required, login_user, logout_user, current_user


app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://localhost/polex'
db.init_app(app)

login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = "login"

app.secret_key = "development-key"


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
  if 'email' in session:
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

  print db

  form = LoginForm()

  if request.method == "POST":
    if form.validate() == False:
      return render_template("login.html", form=form)
    else:
      email = form.email.data 
      password = form.password.data 

      user = User.query.filter_by(email=email).first()
      if user is not None and user.check_password(password):
        login_user(user, remember=True) 
        return redirect(url_for('home'))
      else:
        return redirect(url_for('login'))

  elif request.method == 'GET':
    return render_template('login.html', form=form)

@app.route("/logout")
def logout():
  logout_user()
  return redirect(url_for('index'))

@app.route("/home", methods=["GET", "POST"])
@login_required
def home():


  return render_template("home.html")

@app.route("/politic")
@login_required
def politic():
  return render_template("politic.html")

@app.before_request
def before_request():
    g.user = current_user

if __name__ == "__main__":
  app.run(debug=True)