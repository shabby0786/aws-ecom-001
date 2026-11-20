import os
import psycopg

DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "postgresql://ecommerce_user:local_dev_password@db:5432/ecommerce"
)


def get_db_connection():
    return psycopg.connect(DATABASE_URL)
