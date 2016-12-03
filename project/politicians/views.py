import datetime
from project.models import db, Politic
from flask import flash, redirect, render_template, request, \
    session, url_for, Blueprint
from project.forms import PoliticForm
from flask_login import LoginManager, UserMixin, \
                                login_required, login_user, logout_user, current_user


################
#### config ####
################

politicians_blueprint = Blueprint(
    'politicians', __name__,
    template_folder='templates'
)

################
#### routes ####
################


#@app.route("/politician/<int:page>", methods=["GET", "POST"])
@politicians_blueprint.route("/politician/<int:idPolitician>", methods=["GET", "POST"])
@politicians_blueprint.route("/politician", methods=["GET", "POST"])
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
      return redirect(url_for('home.home'))

  elif request.method == "GET":
    return render_template("politician.html", form=form, idPolitician=idPolitician, politician=politician)

@politicians_blueprint.route("/create_politician", methods=["GET", "POST"])
@login_required
def create_politician():
  form = PoliticForm()

  if request.method == "POST":
    flash(form.errors)
    flash(request.form.get('date'))
    flash(request.form.get('date2'))
    stDate=datetime.datetime.strptime(request.form.get('date'), '%m/%d/%Y').strftime('%Y-%m-%d')
    print stDate
    endDate=datetime.datetime.strptime(request.form.get('date2'), '%m/%d/%Y').strftime('%Y-%m-%d')
    flash(form.validate())
    newpolitician = Politic(form.publicName.data, form.completeName.data, stDate,endDate)
    print form.startDate.data
    db.session.add(newpolitician)
    db.session.commit()
    flash('New entry was successfully posted. Thanks.')
    return redirect(url_for('home.home'))

  elif request.method == "GET":
    return render_template("createPolitician.html", form=form)

@politicians_blueprint.route("/edit_politician/<idPol>", methods=["POST", "GET"])
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
    return redirect(url_for('home.home'))
  elif request.method == "GET":
    dateStart=politician.startDate.strftime("%Y-%m-%d")
    dateEnd=politician.endDate.strftime("%Y-%m-%d")

    politician.startDate=datetime.datetime.strptime(dateStart, '%Y-%m-%d').strftime('%m/%d/%Y')
    politician.endDate=datetime.datetime.strptime(dateEnd, '%Y-%m-%d').strftime('%m/%d/%Y')
    return render_template("editPolitician.html", politician=politician)

@politicians_blueprint.route("/delete_politician/<int:idPol>", methods=["POST"])
@login_required
def delete_politician(idPol):
  politician = Politic.query.filter_by(idPolitician=idPol).first()
  print politician
  if request.method == "POST":
    db.session.delete(politician)
    db.session.commit()
    return redirect(url_for('home.home'))