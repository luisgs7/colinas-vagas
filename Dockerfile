FROM python:3.14.0b3-bookworm
LABEL maintainer="iadevlab.com"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./src /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apt-get update && \
    apt-get install -y postgresql-client libpq-dev && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; then /py/bin/pip install -r /tmp/requirements.dev.txt ; fi

ENV PATH="/py/bin:$PATH"
