FROM python:3.11-buster

# Install GEOS library
RUN apt-get update && apt-get install -y libgeos-dev

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt --timeout 100

COPY . /code/

CMD ["uvicorn", "main:app", "--reload", "--host", "0.0.0.0", "--port", "5050"]
// uvicorn main:app --reload --host 0.0.0.0 --port 5050

ARG PYTHON_VERSION=3.11

FROM python:${PYTHON_VERSION}

RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-venv \
    python3-dev \
    python3-setuptools \
    python3-wheel

RUN mkdir -p /app
WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

EXPOSE 8080

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]