from contextlib import asynccontextmanager

import psycopg
from psycopg.rows import dict_row
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

from app.database import get_db_connection


class Product(BaseModel):
    id: int
    name: str
    price: float
    description: str
    in_stock: bool = True


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Create products table when application starts
    with get_db_connection() as conn:
        with conn.cursor() as cur:
            cur.execute("""
                CREATE TABLE IF NOT EXISTS products (
                    id INTEGER PRIMARY KEY,
                    name TEXT NOT NULL,
                    price NUMERIC(10, 2) NOT NULL,
                    description TEXT NOT NULL,
                    in_stock BOOLEAN NOT NULL DEFAULT TRUE
                )
            """)
    yield


app = FastAPI(
    title="ABC E-Commerce API",
    description="Backend API for ABC E-Commerce application",
    version="1.0.0",
    lifespan=lifespan
)


@app.get("/")
def home():
    return {
        "message": "Welcome to ABC E-Commerce API",
        "status": "running"
    }


@app.get("/health")
def health_check():
    return {"status": "healthy"}


@app.get("/products")
def get_products():
    with get_db_connection() as conn:
        with conn.cursor(row_factory=dict_row) as cur:
            cur.execute("""
                SELECT id, name, price, description, in_stock
                FROM products
                ORDER BY id
            """)
            return cur.fetchall()


@app.get("/products/{product_id}")
def get_product(product_id: int):
    with get_db_connection() as conn:
        with conn.cursor(row_factory=dict_row) as cur:
            cur.execute(
                "SELECT id, name, price, description, in_stock "
                "FROM products WHERE id = %s",
                (product_id,)
            )
            product = cur.fetchone()

    if product is None:
        raise HTTPException(
            status_code=404,
            detail="Product not found"
        )

    return product


@app.post("/products", status_code=201)
def create_product(product: Product):
    try:
        with get_db_connection() as conn:
            with conn.cursor(row_factory=dict_row) as cur:
                cur.execute(
                    """
                    INSERT INTO products
                    (id, name, price, description, in_stock)
                    VALUES (%s, %s, %s, %s, %s)
                    RETURNING id, name, price, description, in_stock
                    """,
                    (
                        product.id,
                        product.name,
                        product.price,
                        product.description,
                        product.in_stock
                    )
                )
                new_product = cur.fetchone()

    except psycopg.errors.UniqueViolation:
        raise HTTPException(
            status_code=409,
            detail="Product ID already exists"
        )

    return {
        "message": "Product created successfully",
        "product": new_product
    }
