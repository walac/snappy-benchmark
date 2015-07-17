import os

__all__ = ['get_host']

def get_host():
    return os.environ.get('SNAPPY_SERVER', 'http://localhost:8000/')
