from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, validators
from wtforms.validators import DataRequired, Email, Length
from wtforms.fields.html5 import DateField

class SignupForm(FlaskForm):
  first_name = StringField('First name', validators=[DataRequired("Please enter your first name.")])
  last_name = StringField('Last name', validators=[DataRequired("Please enter your last name.")])
  email = StringField('Email', validators=[DataRequired("Please enter your email address."), Email("Please enter your email address.")])
  password = PasswordField('Password', validators=[DataRequired("Please enter a password."), Length(min=6, message="Passwords must be 6 characters or more.")])
  submit = SubmitField('Sign up')

class LoginForm(FlaskForm):
  email = StringField('Email', validators=[DataRequired("Please enter your email address."), Email("Please enter your email address.")])
  password = PasswordField('Password', validators=[DataRequired("Please enter a password.")])
  submit = SubmitField("Sign in")

class PoliticForm(FlaskForm):
  publicName = StringField('Public Name', validators=[DataRequired("Please enter politician public name.")])
  completeName = StringField('Complete Name', validators=[DataRequired("Please enter politician complete name.")])
  startDate = DateField('Start Date', format='%m-%d-%Y', validators=[DataRequired("Please enter the politician start Date.")])
  endDate = DateField('End Date', format='%m-%d-%Y', validators=(validators.Optional(),))
  submit = SubmitField('Add Politician', validators=(validators.Optional(),))

class OrganizationForm(FlaskForm):
  publicName = StringField('Public Name', validators=[DataRequired("Please enter organization public name.")])
  completeName = StringField('Complete Name', validators=[DataRequired("Please enter organization complete name.")])
  startDate = DateField('Start Date', format='%m-%d-%Y', validators=[DataRequired("Please enter the organization start Date.")])
  endDate = DateField('End Date', format='%m-%d-%Y', validators=(validators.Optional(),))
  submit = SubmitField('Add Organization', validators=(validators.Optional(),))
  
class ProposalForm(FlaskForm):
  idPolitician = StringField('Politician id',validators=[DataRequired()])
  description = StringField('Description', validators=[DataRequired("Please enter proposal description")])
  dateProposal = DateField('Proposal date', format='%m-%d-%Y', validators=[DataRequired("Please enter the proposal's date")])
  linkProposal = StringField('Proposal link', validators=[DataRequired("Please enter a valid link to the proposal")])
  submit = SubmitField('Add Proposal', validators=(validators.Optional(),))