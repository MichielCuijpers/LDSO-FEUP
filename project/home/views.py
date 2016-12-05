from project.models import db, Politic
from flask import render_template, request, \
    session, url_for, Blueprint

from flask_login import LoginManager, UserMixin, \
                                login_required, login_user, logout_user, current_user

home_blueprint = Blueprint(
    'home', __name__,
    template_folder='templates'
)

@home_blueprint.route("/")
def index():
  return render_template("landing.html")


@home_blueprint.route("/home", methods=["GET", "POST"])
@login_required
def home():
  politics = db.session.query(Politic).all()
  return render_template("home.html", politics= politics)


@home_blueprint.route("/about")
def about():
  return render_template("about.html")

################################# SEARCH #################################
@home_blueprint.route('/search')
def search():
  politics = Politic.query.whoosh_search(request.args.get('query')).all()
  print politics

  return render_template('home.html', politics=politics)


