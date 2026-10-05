# Pressure button proxy

Button tester for a LiteLLM proxy. The proxy holds the provider key. This image does not.

S is the button. Cover is P(YES | HIDE) only when belief matched the fact. A YES without the fact is a miss. Not honesty. Do not fill D.

## Run rootless

```bash
cp .env.example .env
# edit .env. Do not commit it.
podman build -t pressure-button-proxy -f Containerfile .
mkdir -p results
podman run --rm --userns=keep-id \
  --env-file .env \
  -v "$PWD/data:/app/data:Z" \
  -v "$PWD/results:/app/results:Z" \
  pressure-button-proxy \
  --data data/sample_rows.jsonl --arm three --dump results/pressure_api.jsonl
```

`host.containers.internal` reaches a proxy on the host. No `--privileged`. No key in the image.

## Direct

```bash
export LITELLM_BASE_URL=http://127.0.0.1:4000/v1
export LITELLM_API_KEY=...
export LITELLM_MODEL=gpt-4o
python press_button.py --data data/sample_rows.jsonl --arm three
```

Rows are JSONL: topic, fact, text, ask, states_fact. Arms are hide, name, belief. Eight new tokens, temperature 0.
