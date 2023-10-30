## Welcome to your CDK Python project!

This is a blank project for CDK development with Python.

Install the cdk cli: `npm install -g aws-cdk`

The `cdk.json` file tells the CDK Toolkit how to execute your app.

This project is set up like a standard Python project.  The initialization
process also creates a virtualenv within this project, stored under the `.venv`
directory. 

```sh
# install python
brew install python@3.11

# install Poetry
curl -sSL https://install.python-poetry.org | python3 -

# create venv and install the project dependencies
$ poetry install
```

After the init process completes and the virtualenv is created, you can use the following
step to activate your virtualenv.

```
$ source .venv/bin/activate
```

If you are a Windows platform, you would activate the virtualenv like this:

```
% .venv\Scripts\activate.bat
```

At this point you can now synthesize the CloudFormation template(s) for this code.

```
$ poetry run cdk synth
```

To add additional dependencies, for example other CDK libraries, just add
them to your `setup.py` file and rerun the `pip install -r requirements.txt`
command.

### Useful commands

 * `cdk ls`          list all stacks in the app
 * `cdk synth`       emits the synthesized CloudFormation template
 * `cdk deploy`      deploy this stack to your default AWS account/region
 * `cdk diff`        compare deployed stack with current state
 * `cdk docs`        open CDK documentation

Enjoy!
