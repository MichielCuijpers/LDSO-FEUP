
#################
#### imports ####
#################

################
#### config ####
################
from flask import Flask, g
app = Flask(__name__)



from project.models import db, User, Politic, Organization
import datetime
from forms import SearchForm
import os
from flask_login import LoginManager, \
                               current_user





#print(os.environ['APP_SETTINGS'])
app.config.from_object(os.environ['APP_SETTINGS'])
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['WHOOSH_BASE']='whoosh'
db.init_app(app)

login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = "users.login"



from project.users.views import users_blueprint
from project.home.views import home_blueprint
from project.politicians.views import politicians_blueprint
from project.organizations.views import organizations_blueprint
from project.proposals.views import proposals_blueprint
# register our blueprints
app.register_blueprint(users_blueprint)
app.register_blueprint(home_blueprint)
app.register_blueprint(politicians_blueprint)
app.register_blueprint(organizations_blueprint)
app.register_blueprint(proposals_blueprint)

@app.before_request
def before_request():
    g.user = current_user
    if g.user.is_authenticated:
        g.user.last_seen = datetime.datetime.utcnow()
        g.search_form = SearchForm()


@login_manager.user_loader
def user_loader(email):
    """Given *user_id*, return the associated User object.

    :param unicode user_id: user_id (email) user to retrieve
    """
    return User.query.filter_by(email=email).first()