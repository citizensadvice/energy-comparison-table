# Energy Supplier Comparison Table static website

- [Deploy](#deploy)
- [TODO](#todo)
- [Welcome to your CDK Python project!](#welcome-to-your-cdk-python-project)
  - [Useful commands](#useful-commands)


The idea is as follows:

- bridgetown static website hosted on S3 and fronted by a cloudfront distribution
- the infra is deployed with the AWS CDK, see [./energy_comparison_table/energy_comparison_table_stack.py](./energy_comparison_table/energy_comparison_table_stack.py)

- the bridgetown site is under [./bridgetown/energy_tables](./bridgetown/energy_tables) and is maintained by the devs.
- the site is packaged in an AWS Lambda docker image along with a [Lambda handler](./bridgetown/handler.rb) that:
  - is triggered by a Contentful webhook
  - processes the webhook event and extracts the data to `/tmp` ( the only writable location in Lambda) for use by a e.g bridgetown Builder plugin in [./bridgetown/energy_tables/plugins/builders](./bridgetown/energy_tables/plugins/builders) that reads the file and generates content
  - rebuilds the bridgetown site using the newly generated data
  - invalidates the cloudfront cache

## Deploy

Follow the steps in [Welcome to your CDK Python project!](#welcome-to-your-cdk-python-project) to install the cdk cli, Python venv and the required packages, then login to aws ( `aws sso login` ) and:

`AWS_PROFILE=cita-devops.AWSAdministratorAccess cdk deploy --all --require-approval never`

## TODO

- CI/CD
- Real bridgetown site
- use CA domain
- don't allow concurrent Lambda runs
- find a better way to invalidate the cache when the site is rebuilt

## Welcome to your CDK Python project!

This is a blank project for CDK development with Python.

Install the cdk cli: `npm install -g aws-cdk`

The `cdk.json` file tells the CDK Toolkit how to execute your app.

This project is set up like a standard Python project.  The initialization
process also creates a virtualenv within this project, stored under the `.venv`
directory.  To create the virtualenv it assumes that there is a `python3`
(or `python` for Windows) executable in your path with access to the `venv`
package. If for any reason the automatic creation of the virtualenv fails,
you can create the virtualenv manually.

To manually create a virtualenv on MacOS and Linux:

```
$ python3 -m venv .venv
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

Once the virtualenv is activated, you can install the required dependencies.

```
$ pip install -r requirements.txt
```

At this point you can now synthesize the CloudFormation template for this code.

```
$ cdk synth
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
