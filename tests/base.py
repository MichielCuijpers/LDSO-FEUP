from project import app
from flask_testing import TestCase
from project.models import db, User


class BaseTestCase(TestCase):
    """A base test case."""

    def create_app(self):
        app.config.from_object('config.TestingConfig')
        return app

    def setUp(self):
        db.create_all()
       # db.session.add(BlogPost("Test post", "This is a test. Only a test."))
        db.session.add(User("admin", "admin", "adm@min.com", "admin"))
        db.session.commit()

    def tearDown(self):
        db.session.remove()
        db.drop_all()