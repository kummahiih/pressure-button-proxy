# Rootless image. The key is not copied in.
# Build: podman build -t pressure-button-proxy -f Containerfile .
FROM python:3.12-slim

RUN useradd --create-home --uid 1000 app
WORKDIR /app
COPY requirements.txt press_button.py ./
COPY data ./data
RUN pip install --no-cache-dir -r requirements.txt \
    && mkdir -p /app/results \
    && chown -R app:app /app
USER app
ENV PYTHONUNBUFFERED=1
ENTRYPOINT ["python", "press_button.py"]
