import unittest
import datetime
from flask_login import current_user

from base import BaseTestCase

from project.models import Politic



class TestPolitician(BaseTestCase):




    #ensures a logged user can create a politician

    def test_create_politician(self):
        dt = datetime.datetime.strptime("21/11/06", "%d/%m/%y")
        with self.client:
            self.client.post('/login', data=dict(
                email = 'adm@min.com', password='admin'
            ), follow_redirects=True)

            response = self.client.post(
                '/create_politician',
                data=dict(publicName='Antonio Costa',
                          completeName='Antonio Cenas Costa',
                          startDate='02/01/2010', endDate='02/01/2010'),
                follow_redirects=True)

            self.assertEqual(response.status_code, 200)
            self.assertIn(b'New entry was successfully posted. Thanks.', response.data)

if __name__ == '__main__':
    unittest.main()




