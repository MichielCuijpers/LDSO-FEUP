from project.models import db, Politic
from flask import render_template, request, \
    session, url_for, Blueprint, redirect, g, flash
from config import MAX_SEARCH_RESULTS
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


@home_blueprint.route('/search', methods=['GET', 'POST'])
@login_required
def search():
    if not g.search_form.validate_on_submit():
    	return redirect(url_for('home.index'))
    return redirect(url_for('home.index', query=g.search_form.search.data))


@home_blueprint.route('/search_results/<query>')
@login_required
def search_results(query):
    print query
    results = Politic.query.whoosh_search(query, MAX_SEARCH_RESULTS).all()
    return render_template('search_results.html', query=query, results=results)


