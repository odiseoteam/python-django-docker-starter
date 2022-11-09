FROM python:3.10-alpine

RUN pip install --upgrade pip

COPY ./docker/python/requirements.txt .
RUN pip install -r requirements.txt

COPY . /app

WORKDIR /app

COPY ./docker/python/entrypoint.sh /
ENTRYPOINT ["sh", "/entrypoint.sh"]
