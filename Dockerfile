# Dockerfile
#
FROM nginx:1.24.0-bullseye

WORKDIR /code
COPY --chmod=644 files/requirements.txt /requirements.txt

RUN apt update && \
    apt full-upgrade -y && \
    apt install -y python3-pip supervisor git
RUN pip3 install --disable-pip-version-check --no-compile --requirement /requirements.txt
RUN git clone https://gitlab.geant.net/devops/devops-wiki.git /code
RUN /usr/local/bin/mkdocs build --site-dir /usr/share/nginx/html
RUN apt-get -y --purge remove python3-pip && \
    apt-get -y --purge autoremove && \
    apt-get clean
RUN rm -rf /root/.cache/pip/* /var/lib/apt/lists/*

COPY --chmod=644 files/default.conf /etc/nginx/conf.d/default.conf
COPY --chmod=644 files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY --chmod=644 files/hook.py /hook/hook.py
COPY --chmod=755 files/05-scripts.sh /docker-entrypoint.d/05-scripts.sh
COPY --chmod=755 files/pull-updates.sh /usr/local/bin/pull-updates.sh

EXPOSE 8000
