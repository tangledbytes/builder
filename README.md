# Builder

Another stupid repository. Just helps me use Github Action as a place to "build" projects. User needs to specify a script which will perform the "build" process and then must move the built assets into `$GITHUB_WORKSPACE/artifacts/`.

To use the builder, clone the repository and run:

```shell
export GH_USERNAME=utkarsh
export SCRIPT=script.sh
curl https://raw.githubusercontent.com/$GH_USERNAME/builder/master/builder.sh | bash -s $SCRIPT
```