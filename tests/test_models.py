import unittest

from flask_login import current_user

from base import BaseTestCase
from project.models import User


class TestUser(BaseTestCase):

    # Ensure user can register
    def test_user_registeration(self):
        with self.client:
            response = self.client.post('signup', data=dict(
                first_name='Michael', last_name='Jordan', email='michael@python.com',
                password='python', confirm='python'
            ), follow_redirects=True)
            user = User.query.filter_by(email='michael@realpython.com').first()

            self.assertIn(b'Home', response.data)
            self.assertTrue(current_user.email == "michael@python.com")
            self.assertTrue(current_user.is_active())
            user = User.query.filter_by(email='michael@realpython.com').first()
            
            #self.assertTrue(str(user) == '<name - Michael>')

    def test_get_by_id(self):
        # Ensure id is correct for the current/logged in user
        with self.client:
            self.client.post('/login', data=dict(
                email='adm@min.com', password='admin'
            ), follow_redirects=True)
            self.assertTrue(current_user.uid == 1)
            self.assertFalse(current_user.uid == 20)


            #TODO
    def test_check_password(self):
        # Ensure given password is correct after unhashing
        user = User.query.filter_by(email='adm@min.com').first()
        #self.assertTrue(user.check_password(user.pwdhash) == 'admin')
        self.assertFalse(user.check_password(user.pwdhash) == 'foobar')
#
    


if __name__ == '__main__':
    unittest.main()