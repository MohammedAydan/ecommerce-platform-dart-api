## 0.1.1 - 2026-08-19

Added configurable 30-second request timeouts, safe retries for idempotent read requests, exponential retry delays, response decoder hooks, and the public operation manifest. Normalized generated method names to lowerCamelCase and added the read-only production smoke test used against `https://ec-swart.vercel.app`.

## 0.1.0 - 2026-08-19

Added a pure-Dart Ecommerce Platform backend client covering all 135 verified HTTP operations from backend commit `ca7306ec4faae13979af256cd818723e897b02e4`. Added bearer authentication, Better Auth cookie support, idempotency keys, multipart media uploads, common typed request models, response envelopes, pagination, API errors, examples, and unit tests.
