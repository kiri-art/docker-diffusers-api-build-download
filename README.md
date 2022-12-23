# docker-diffusers-api-build-download

Copyright (c) 2022 by Gadi Cohen <dragon@wastelands.net>.  MIT Licensed.

## What is it?

This is a small extension to
[docker-diffusers-api](https://github.com/kiri-art/docker-diffusers-api)
that pre-downloads a specific model during the build phase.

It works well with banana.dev.

## Quick Start

Simply set the appropriate build-vars either in e.g. Banana's dashboard, or inside the Dockerfile, and deploy.

See the [Dockerfile](./Dockerfile) for all options.

## Banana Info

We no longer support Banana's optimization system.  We do
however provide an alternative that offers the same
performance, but requires S3-compatible storage (see the
forums for more info XXX link).

Timing:

  * The "build" part of the build stage takes about 8m.
  * Optimization takes much longer and of course will fail in the end - we don't use it - maybe we'll get a way to opt out of opimitzaiton in the future.

