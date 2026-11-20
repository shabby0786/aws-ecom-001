# Step 1: Use official Python base image
FROM python:3.12-slim

# Step 2: Set working directory inside container
WORKDIR /app

# Step 3: Copy dependency list
COPY requirements.txt .

# Step 4: Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Step 5: Copy application source code
COPY app/ ./app/

# Step 6: Document application port
EXPOSE 8000

# Step 7: Start FastAPI application
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
