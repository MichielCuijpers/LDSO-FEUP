import os
import datetime
import flask_whooshalchemy as wa
from flask import Flask, render_template, request, session, redirect, url_for, g, flash
from project.models import db, User, Politic, Organization
from project.forms import SignupForm, LoginForm, PoliticForm, OrganizationForm
from flask_login import LoginManager, UserMixin, \
                                login_required, login_user, logout_user, current_user















