from flask import flash, redirect, render_template, request, \
    session, url_for, Blueprint


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

@users_blueprint.route("/login", methods=["GET", "POST"])
def login():

  error = None
  form = LoginForm(request.form)

  if current_user.is_authenticated:
    return redirect(url_for('home'))

  if request.method == "POST":
    if form.validate() == False:
      return render_template("login.html", form=form)
    else:
      email = request.form['email']
      password = request.form['password']

      user = User.query.filter_by(email=email).first()
      if user is not None and user.check_password(password):
        login_user(user, remember=True)
        flash('You were logged in. Go Crazy. ')
        return redirect(url_for('home'))
      else:
        flash('Invalid username or password.')
  return render_template('login.html', form=form, error=error)

@users_blueprint.route("/logout")
@login_required
def logout():
  logout_user()
  flash('You were logged out.')
  return redirect(url_for('index'))