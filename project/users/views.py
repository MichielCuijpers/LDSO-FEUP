from flask import flash, redirect, render_template, request, \
    session, url_for, Blueprint
from project.forms import SignupForm, LoginForm
from project.models import db, User
from flask_login import LoginManager, UserMixin, \
    login_required, login_user, logout_user, current_user

################
#### config ####
################

users_blueprint = Blueprint(
    'users', __name__,
    template_folder='templates'
)


################
#### routes ####
################

@users_blueprint.route("/signup", methods=["GET", "POST"])
def signup():
    if current_user.is_authenticated:
        return redirect(url_for('home.home'))

    form = SignupForm()

    if request.method == "POST":
        if form.validate() == False:
            return render_template('signup.html', form=form)
        else:
            newuser = User(form.first_name.data, form.last_name.data, form.email.data, form.password.data)
            db.session.add(newuser)
            db.session.commit()

            session['email'] = newuser.email
            login_user(newuser, remember=True)
            flash(u'Welcome to POLEX', 'info')
            return redirect(url_for('home.home'))

    elif request.method == "GET":
        return render_template('signup.html', form=form)


@users_blueprint.route("/login", methods=["GET", "POST"])
def login():
    error = None
    form = LoginForm(request.form)

    if current_user.is_authenticated:
        return redirect(url_for('home.home'))

    if request.method == "POST":
        if form.validate() == False:
            return render_template("login.html", form=form)
        else:
            email = request.form['email']
            password = request.form['password']
            user = User.query.filter_by(email=email).first()
            if user is not None and user.check_password(password):
                login_user(user, remember=True)
                flash(u'You were logged in. Go Crazy. ', 'success')
                return redirect(url_for('home.home'))
            else:
                flash(u'Invalid username or password.', 'info')
    return render_template('login.html', form=form, error=error)


@users_blueprint.route("/logout")
@login_required
def logout():
    logout_user()
    flash(u'You were logged out.', 'success')
    return redirect(url_for('home.home'))
