# concourse-sandbox

Playpen and examples for [concourse](https://concourse.ci) CI resources.

Prerequisites:
- concourse installation
- team set up in concourse and target set up using `fly`.

## Git Example: trigger a "changelog" update based off of git commits
[git_pipeline_ex.yml](./ci/git_pipeline_ex.yml) is a "toy" changelog builder that triggers off of repo commits.
A changelog entry is added to a _different_ repo than the one being monitored.
In this example, commits to master on _this_ repo are added to [this readme](https://github.com/johnnason/concourse-output/blob/master/README.md).
One could imagine aggregating multiple repo's commits into a single repo's changelog.

### The example illustrates a few concourse/git concepts
- using pipeline assets from a git repo
- a pipeline trigger off of repo commits (ci-assets - this repo in this example)
- splitting scripts from tasks
- linking output of one task to input of another
- parameterizing pipleine variables
- pushing commits to a different repo

### Assets used
- pipeline
[git_pipeline_ex.yml](./ci/git_pipeline_ex.yml)
- pipeline credentials
[credentials_ex.yml](./ci/credentials_ex.yml)
- tasks
[last-commit.yml](./ci/tasks/last-commit.yml)
[update-readme.yml](./ci/tasks/update_readme.yml)
- scripts
[last-commit.sh](./ci/scripts/last-commit.sh)
[update-readme.sh](./ci/scripts/update_readme.sh)

### The basic pipeline flow
- `ci-assets` repo commit triggers `last-commit`
- `last-commit` pulls and formats the latest commit as output
- `update-readme` takes the output of `last-commit` and makes a `README.md` update in `ci-changelog`
- pipeline does a put on the `ci-changelog` repo resource

### Running it
- update `credentials_ex.yml` appropriately
- `fly -t <your target> set-pipeline -p git -c ci/git_pipeline_ex.yml -l ci/credentials_ex.yml`
- unpause pipeline (UI or via fly)
- commit to `master` of `ci-assets`, and you should see a build kick off that culminates in a README.md entry in `ci-changelog`

### To consider
- this is just pattern code, not production ready
- relatively tight coupling between pipeline/tasks/scripts (e.g. file names, etc): needs better parameterization
- even though credentials are externalized, anyone with concourse pipeline access will see them. Consider using an external store, e.g. `vault`
