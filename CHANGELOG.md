## 0.2.0 - 2026-08-19

## Unreleased

Synchronized the backend source reference to commit `b54db56f66ea6e3db2adcf08cf9e8c512f211801`. Verified all **137 HTTP operations across 85 route files** against the generated SDK OpenAPI contract and operation manifest, added the complete `API_COVERAGE.md` reference, and documented the Better Auth wildcard normalization used during contract comparison.

## 0.3.0 - 2026-08-21

Updated the SDK contract to the latest commerce backend revision. Added typed admin return/refund requests and the finance reconciliation facade; added raw/OpenAPI coverage for `POST /api/v1/admin/orders/{id}/returns` and `GET /api/v1/admin/commerce/reconciliation`; and expanded quote/order models with immutable financial snapshot fields. Updated checkout guidance so shipping is selected from server-returned methods after an address is provided, with no client-side free-shipping threshold.

## 0.2.0 - 2026-08-19

Rebuilt the package as a typed SDK. Added strict catalog, checkout, cart, auth, account, address, order, and administrative request/response models; local validation with `ModelValidationException`; ergonomic domain clients; Better Auth sign-in/sign-up/session/sign-out helpers; persistent cookie support; response headers; typed decoders; and bounded safe retries.

Added complete machine-readable integration artifacts: `openapi.yaml`, `ai/agent-tools.json`, `ai/safe-tools.json`, `ai/openai-tools.json`, `ai/system-prompt.md`, `ai/README.md`, and `llms.txt`. Added an updated typed example and documented the human-confirmation policy for mutations.

## 0.1.1 - 2026-08-19

Added configurable 30-second request timeouts, safe retries for idempotent read requests, exponential retry delays, response decoder hooks, and the public operation manifest. Normalized generated method names to lowerCamelCase and added the read-only production smoke test used against `https://ec-swart.vercel.app`.

## 0.1.0 - 2026-08-19

Added a pure-Dart Ecommerce Platform backend client covering all 135 verified HTTP operations from backend commit `ca7306ec4faae13979af256cd818723e897b02e4`. Added bearer authentication, Better Auth cookie support, idempotency keys, multipart media uploads, common typed request models, response envelopes, pagination, API errors, examples, and unit tests.
