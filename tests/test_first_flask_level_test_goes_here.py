import os
import w4156.app as flaskapp
import unittest
import tempfile


class FlaskTestCase(unittest.TestCase):

    def setUp(self):
        self.db_fd, flaskapp.app.config['DATABASE'] = tempfile.mkstemp()
        flaskapp.app.testing = True
        self.app = flaskapp.app.test_client()
        # with w4156.app.app_context():
        #     w4156.init_db()

    def test_hello(self):
        rv = self.app.get('/')
        self.assertEqual(rv.data, "Hello, World!")

    def tearDown(self):
        os.close(self.db_fd)
        os.unlink(flaskapp.app.config['DATABASE'])

if __name__ == '__main__':
    unittest.main()
