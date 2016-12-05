
#################
#### imports ####
#################


from flask import Flask, g, flash
from models import db, User, Politic, Organization
from flask_login import LoginManager
import flask_whooshalchemy as wa
import os
from flask_login import LoginManager, UserMixin, \
                                login_required, login_user, logout_user, current_user

################
#### config ####
################

app = Flask(__name__)



#print(os.environ['APP_SETTINGS'])
app.config.from_object(os.environ['APP_SETTINGS'])
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['WHOOSH_BASE']='whoosh'
db.init_app(app)

login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = "users.login"

wa.whoosh_index(app, Politic)

from project.users.views import users_blueprint
from project.home.views import home_blueprint
from project.politicians.views import politicians_blueprint
from project.organizations.views import organizations_blueprint
# register our blueprints
app.register_blueprint(users_blueprint)
app.register_blueprint(home_blueprint)
app.register_blueprint(politicians_blueprint)
app.register_blueprint(organizations_blueprint)

@app.before_request
def before_request():
    g.user = current_user

@login_manager.user_loader
def user_loader(email):
    """Given *user_id*, return the associated User object.

    :param unicode user_id: user_id (email) user to retrieve
    """
    return User.query.filter_by(email=email).first()