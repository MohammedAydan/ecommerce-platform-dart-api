# Contributing

## Development

Install Dart 3.2 or newer, run `dart pub get`, and keep generated models, `openapi.yaml`, operation manifests, and AI-agent tool descriptions synchronized when an API contract changes. Do not commit `.env` files, credentials, bearer tokens, cookies, payment keys, database URLs, or customer data.

## API and transport changes

Prefer typed request and response models over untyped maps. Preserve the server-authoritative contract: the SDK must not calculate trusted totals or make client-side authorization claims. New transport behavior must document whether it is safe to retry and must not log authorization headers, cookies, response bodies, or sensitive query values.

The default client transport must remain HTTPS-only. Local cleartext tests or development servers must opt in explicitly with `allowInsecureHttp: true` and must never be used in production examples.

## Required checks

Run all checks before opening a pull request:

```bash
dart format --output=none --set-exit-if-changed .
dart analyze
dart test
dart pub publish --dry-run
```

For authentication, cookie, retry, or generated API changes, add a regression test that covers the relevant security boundary and explain the abuse case in the pull request description.
