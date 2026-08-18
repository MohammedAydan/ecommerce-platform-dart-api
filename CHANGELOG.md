## 0.2.0 - 2026-08-19

Rebuilt the package as a typed SDK. Added strict catalog, checkout, cart, auth, account, address, order, and administrative request/response models; local validation with `ModelValidationException`; ergonomic domain clients; Better Auth sign-in/sign-up/session/sign-out helpers; persistent cookie support; response headers; typed decoders; and bounded safe retries.

Added complete machine-readable integration artifacts: `openapi.yaml`, `ai/agent-tools.json`, `ai/safe-tools.json`, `ai/openai-tools.json`, `ai/system-prompt.md`, `ai/README.md`, and `llms.txt`. Added an updated typed example and documented the human-confirmation policy for mutations.

## 0.1.1 - 2026-08-19

Added configurable 30-second request timeouts, safe retries for idempotent read requests, exponential retry delays, response decoder hooks, and the public operation manifest. Normalized generated method names to lowerCamelCase and added the read-only production smoke test used against `https://ec-swart.vercel.app`.

## 0.1.0 - 2026-08-19

Added a pure-Dart Ecommerce Platform backend client covering all 135 verified HTTP operations from backend commit `ca7306ec4faae13979af256cd818723e897b02e4`. Added bearer authentication, Better Auth cookie support, idempotency keys, multipart media uploads, common typed request models, response envelopes, pagination, API errors, examples, and unit tests.
