from project.models import db, Politic
from flask import flash, redirect, render_template, request, \
    session, url_for, Blueprint

from flask_login import LoginManager, UserMixin, \
                                login_required, login_user, logout_user, current_user

################
#### config ####
################

organizations_blueprint = Blueprint(
    'organizations', __name__,
    template_folder='templates'
)

################
#### routes ####
################

@organizations_blueprint.route("/organization/<int:idOrganization>", methods=["GET", "POST"])
@organizations_blueprint.route("/organization", methods=["GET", "POST"])
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


@organizations_blueprint.route("/create_organization", methods=["GET", "POST"])
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