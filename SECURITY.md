# Security Policy

## Scope

This package is a typed client for the Ecommerce Platform API. It does not grant privileges and cannot make the backend trust client-supplied prices, inventory, roles, payment results, or ownership identifiers. The backend must enforce authentication, authorization, validation, rate limits, and state transitions.

## Reporting

Do not publish bearer tokens, cookies, API keys, payment credentials, database URLs, or customer data in a public issue. Report suspected vulnerabilities through the repository's private GitHub security advisory workflow or the maintainers' private security channel. Include the affected version, platform, reproducible steps, request shape with secrets redacted, and concrete impact.

## Safe usage requirements

Use an HTTPS `baseUrl` in all deployed clients. The transport rejects cleartext HTTP by default; `allowInsecureHttp` exists only for controlled local debug endpoints. Provide bearer tokens through a secure token provider and never log authorization headers, cookies, full response bodies, or exception objects containing sensitive data.

AI-agent integrations must keep secrets outside tool arguments and should require human confirmation for state-changing operations. The generated admin client is a typed interface only; it is not an authorization boundary and must be used only by an already-authorized server or operator.
