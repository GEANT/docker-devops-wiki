# Terraformator

Terraform unchained, a django UI for Terraform, with VMware, NSX and Infoblox

1. [Docker instructions](#docker-instructions)
1. [Create a new release](#create-a-new-release)

```bash
cd ~terraform/terraformator
./manage.py makemigrations
./manage.py migrate --run-syncdb
```

## Docker instructions

You can build and run a local image using the script `build.sh`. You can use `--help` to explore all the options:

```bash
./build.sh --help
```

## Create a new release

Bear in mind that our laptops can compile the image for a different architecture. Hence we use Gitlab CI to compile the image.

You can add these lines inside your `~/.gitconfig`:

```conf
[alias]
    pp = !git pull &&  git push
    pushall = !git remote | xargs -L1 git push --all
    pushall-tags = !git remote | xargs -L1 git push --tags
```

In the below case you apply the changes to `master` branch and create a tag starting from master.

If you want to create version 1.2.3, the commands below will trigger the CI and upload the files to Gitlab:

```bash
git checkout master  # make your changes ...
git commit "my new change"
git push
git tag 1.2.3
git pushall-tags
```
