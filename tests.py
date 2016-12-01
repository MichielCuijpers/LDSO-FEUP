from project import app

import unittest

from flask_testing import TestCase
from flask_login import current_user


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

class FlaskTestCase(BaseTestCase):

    # Ensure that Flask was set up correctly
    def test_index(self):
        response = self.client.get('/login', content_type='html/text')
        self.assertEqual(response.status_code, 200)

    # Ensure that the login page loads correctly
    def test_login_page_loads(self):
        response = self.client.get('/login')

     # Ensure login behaves correctly with correct credentials
    def test_correct_login(self):

        response = self.client.post(
            '/login',
            data=dict(email="adm@min.com", password="admin"),
            follow_redirects=True
        )
        self.assertIn(b'You were logged in', response.data)

    def test_incorrect_login(self):
        response = self.client.post(
            '/login',
            data=dict(email="wrong@wrong.pt", password="wrong"),
            follow_redirects=True
        )
        self.assertIn(b'Invalid username or password.', response.data)

    # Ensure logout behaves correctly
    def test_logout(self):
        self.client.post(
            '/login',
            data=dict(email="adm@min.com", password="admin"),
            follow_redirects=True
        )
        response = self.client.get('/logout', follow_redirects=True)
        self.assertIn(b'You were logged out', response.data)

    # Ensure that main page requires user login
    def test_main_route_requires_login(self):
        response = self.client.get('/home', follow_redirects=True)
        self.assertIn(b'Please log in to access this page.', response.data)

    # Ensure that logout page requires user login
    def test_logout_route_requires_login(self):
        response = self.client.get('/logout', follow_redirects=True)
        self.assertIn(b'Please log in to access this page.', response.data)









if __name__ == '__main__':
    unittest.main()

    

    

