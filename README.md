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

**NB: current known issue where build args don't override values I set previousy in the build, working on this, but please set any vars using ENV line only for now.**

## Example

```Dockerfile
# AnimeAnything v3, from HuggingFace "diffusers" branch/revision (an fp16 model)
MODEL_ID="Linaqruf/anything-v3.0"
MODEL_PRECISION="fp16"
MODEL_REVISION="diffusers"
# Download pre-built optimized image from our own S3-storage in default location
MODEL_URL="s3://"
```

## Banana Info

### Usage

```js
const out = await banana.run(apiKey, modelKey, { "modelInputs": modelInputs, "callInputs": callInputs });
```

NB: if you're coming from another banana starter repo, note that we
explicitly name `modelInputs` above, and send a bigger object (with
`modelInputs` and `callInputs` keys) for the banana-sdk's
"modelInputs" argument.

If provided, `init_image` and `mask_image` should be base64 encoded.

### Optimization

We no longer support Banana's optimization system.  We do
however provide an alternative that offers even better
performance, but requires either a pre-built image or
S3-compatible storage (see
[this post](https://forums.kiri.art/t/our-own-optimization-faster-model-init/98)
for more info).

Build timing:

  * Primary build - takes about 8m.
  * Optimization step - takes much longer and of course will fail in the end - we don't use it - maybe we'll get a way to opt out of optimization in the future.

Cold boot timing:

* Banana's optimization: 2.3-6.4s init time (usually around 3.0s)
* Our method: 2.0-2.5s init time (usually around 2.1s)

### Testing

```bash
# Run against deployed banana image (Nvidia A100)
$ export BANANA_API_KEY=XXX
$ BANANA_MODEL_KEY=XXX python3 test.py --banana txt2img
Running test: txt2img
Request took 19.4s (init: 2.5s, inference: 3.5s)
Saved /home/dragon/www/banana/banana-sd-base/tests/output/txt2img.png

# Note that 2nd runs are much faster (no init AND faster inference)
Request took 3.0s (inference: 2.1s)
```
