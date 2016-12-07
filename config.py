import os
basedir = os.path.abspath(os.path.dirname(__file__))

MAX_SEARCH_RESULTS = 50

class Config(object):
    DEBUG = False
    TESTING = False
    CSRF_ENABLED = True
    SECRET_KEY = '\xbe\xe0t\xa1\xca\xb0+\x01&\x938\xa2"\xd2q\xb5\n!f-8i\x12\xc0'
    SQLALCHEMY_DATABASE_URI = os.environ['DATABASE_URL']


class ProductionConfig(Config):
    DEBUG = False


class StagingConfig(Config):
    DEVELOPMENT = True
    DEBUG = True


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True


class TestingConfig(Config):
    TESTING = True
    DEBUG = True
    WTF_CSRF_ENABLED = False
    SQLALCHEMY_DATABASE_URI = 'postgresql://localhost/mylocaldb'
