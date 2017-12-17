# Fluid
## The Programmatic IDL

Fluid is a low-opininated, easily integrable, and innovated API system.

### Overview of Design Constraints

#### Generation

As an IDL, code is generated from a spec for the client and server.
Additionally libraries are available to translate and run queries.

#### Versioning

Fluid provides an automated versioning system,
so that your APIs can freely progress while supporting older versions.

#### Programmatic

The query lang is a programming language.
The language enables any unexpected representations of expressions often constrained by other APIs.

#### Documentation

The spec is intentionally designed for ease of reading, writing, and document generation.

#### Query language

If for some reason the client chooses not to use generated code,
the query language is clear enough to write by hand.
Debugging is also easier as a result.

### Tooling

Because of the carefully spartanized spec and query language,
the barrier for tooling is quite low for generating both.

#### Logging

Service functions are generated as loggable types.


### How to integrate into an existing API

1. Create an endpoint
2. Add integration code, and inject headers into meta middleware
3. Fill spec with schema
4. Generate and implement

### Query language basics

* Service call (Hello world)
* `addInt`, `if`, `mapList`, `fn`, `do`, `tuple`

### How are multiple API versions supported?
