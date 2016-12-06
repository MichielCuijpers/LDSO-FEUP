from project.models import db, Proposal, Politic
from flask import flash, redirect, render_template, request, \
    session, url_for, Blueprint
import datetime
from project.forms import ProposalForm
from flask_login import LoginManager, UserMixin, \
                                login_required, login_user, logout_user, current_user

################
#### config ####
################

proposals_blueprint = Blueprint(
    'proposals', __name__,
    template_folder='templates'
)

################
#### routes ####
################

############################## PROPOSALS #################################
@proposals_blueprint.route("/create_proposal/<int:idPol>", methods=["GET"])
@proposals_blueprint.route("/create_proposal", methods=["POST"])
@login_required
def create_proposal(idPol=1):
  politician = Politic.query.filter_by(idPolitician=idPol).first()
  form = ProposalForm()
  if request.method == "GET":
    form.idPolitician.data=idPol
    return render_template("createProposal.html",form=form,idPol=idPol)
  elif request.method =='POST':
    dateProp=datetime.datetime.strptime(request.form.get('date'), '%m/%d/%Y').strftime('%Y-%m-%d')
    newproposal = Proposal(dateProp, form.description.data, form.linkProposal.data)
    newproposal.children.append(politician)
    db.session.add(newproposal)
    db.session.commit()
    politician2 = Politic.query.filter_by(idPolitician=form.idPolitician.data).first()
    return render_template("politician.html", idPolitician=form.idPolitician.data, politician=politician2)