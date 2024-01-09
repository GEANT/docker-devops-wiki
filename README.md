# DevOps Wiki

Documentation as a code Wiki using MkDocs-material.

This images provides 

1. [Preamble](#preamble)
1. [Docker instructions](#docker-instructions)
1. [Create a new release](#create-a-new-release)

## Preamble

This container provides a hook URL (`/hook`) to trigger a pull from Git and rebuild the documentation site. You'll have to create a trigger on your CI.

You also need to supply a URL in `Dockerfile`/`Dockerfile-local`, for the repository (publicly accessible in reading mode) where you store your Wiki code.

There is also a health-check URL (`/ping`) which I use from Nomad to determine the health status of the container.

## Docker instructions

You can build and run a local image using the script `build.sh`. You can use `--help` to explore all the options:

```bash
./build.sh --help
```

## Create a new release

Bearing in mind that our laptops can compile the image for a different architecture, we rely on Gitlab CI to compile the image.

You can add these lines inside your `~/.gitconfig`:

```conf
[alias]
    pp = !git pull &&  git push
    pushall = !git remote | xargs -L1 git push --all
    pushall-tags = !git remote | xargs -L1 git push --tags
```

In the case below you apply the changes to `main` branch and create a tag starting from main.

If you want to create version `1.2.3`, the commands below will trigger the CI and upload the files to Gitlab:

```bash
git checkout main  # make your changes ...
git commit "my new change"
git push
git tag 1.2.3
git pushall-tags
```
