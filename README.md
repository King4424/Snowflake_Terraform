# :dart: Snwoflake Database Change Management with Terraform and GitHub
This Reposiroty will provide step-by-step instructions for how to build a CI/CD pipeline for Snowflake with GitHub Actions and Terraform. This will provide you with enough details to get you started on your DevOps journey with Snowflake, GitHub Actions, and Terraform.
### :bookmark_tabs: Prerequisites:
1. A Snowflake Account.

2. A Snowflake User created with appropriate permissions.

3. A GitHub Account.

4. A GitHub Repository

5. A Terraform Cloud Account.

6. Your favorite IDE with Git integration. If you don't already have a favorite IDE that integrates with Git I would recommend the great, free, open-source Visual Studio Code.

7. Your project repository cloned to your computer.

## :ladder: Steps to Complete this project:
1) Setup and Configure Terraform Cloud
2) Create the Actions Workflow in GitHub
3) Create Your First Database Migration
4) Confirm Changes Deployed to Snowflake
5) Create Your Second Database Migration
6) Conclusion & Next Steps

## :diamond_shape_with_a_dot_inside: Start to Configure Your Terraform Cloud Account 
**First Create your Terraform Cloud Account.**

**Create new Organzation, Give it a Organization name and your type your email ID**
<img width="960" alt="image" src="https://github.com/King4424/Snowflake_Terraform/assets/121480992/df6fda1f-5384-409a-ad9f-cf84cc7f3eb6">

**From the Workspaces page click on the "+ New workspace" button near the top right of the page. On the first page, where it asks you to choose the type of workflow, select "API-driven workflow".**

<img width="946" alt="image" src="https://github.com/King4424/Snowflake_Terraform/assets/121480992/e2e4ded3-2573-4628-ab37-f781b4735835">

**On the second page, where it asks for the "Workspace Name" enter gh-actions-demo and then click the "Create workspace" button at the bottom of the page.**

<img width="941" alt="image" src="https://github.com/King4424/Snowflake_Terraform/assets/121480992/e0c13ce6-11c6-4068-9790-045d6e2e20b5">

**Setup Environment Variables**

In order for Terraform Cloud to be able to connect to your Snowflake account you'll need to store the settings in Environment variables. Fortunately, Terraform Cloud makes this easy. From your new workspace homepage click on the "Variables" tab. Then for each variable listed below click on "+ Add variable" button (under the "Environment Variables" section) and enter the name given below along with the appropriate value (adjusting as appropriate).

<img width="302" alt="image" src="https://github.com/King4424/Snowflake_Terraform/assets/121480992/dcaf1cb9-ad66-4f5e-b22b-f335dad670f3">

When you're finished adding all the secrets, the page should look like this:
<img width="948" alt="image" src="https://github.com/King4424/Snowflake_Terraform/assets/121480992/15e2a348-7736-4ce5-b1c7-757bf5f729c9">

**Create an API Token**

The final thing we need to do in Terraform Cloud is to create an API Token so that GitHub Actions can securely authenticate with Terraform Cloud. Click on your user icon near the top right of the screen and then click on "User settings". Then in the left navigation bar click on the user settings page click on the "Tokens" tab.

Click on the "Create an API token" button, give your token a "Description" (like GitHub Actions) and then click on the "Create API token" button. Pay careful attention on the next screen. You need to save the API token because once you click on the "Done" button the token will not be displayed again. Once you've saved the token, click the "Done" button.

<img width="944" alt="image" src="https://github.com/King4424/Snowflake_Terraform/assets/121480992/a3fa93a9-5cf4-46bc-8221-6da3235a70b5">

## :diamond_shape_with_a_dot_inside: Create the Actions Workflow in GitHub:

**Create Actions Secrets**

Action Secrets in GitHub are used to securely store values/variables which will be used in your CI/CD pipelines. In this step we will create a secret to store the API token to Terraform Cloud.

From the repository, click on the "Settings" tab near the top of the page. From the Settings page, click on the "Secrets" tab in the left hand navigation. The "Actions" secrets should be selected.

Click on the "New repository secret" button near the top right of the page. For the secret "Name" enter TF_API_TOKEN and for the "Value" enter the API token value you saved from the previous step.
<img width="960" alt="image" src="https://github.com/King4424/Snowflake_Terraform/assets/121480992/04d438c6-089a-4eff-9c75-131d9e5d97a3">

**Action Workflows**

Action Workflows represent automated pipelines, which inludes both build and release pipelines. They are defined as YAML files and stored in your repository in a directory called .github/workflows. In this step we will create a deployment workflow which will run Terraform and deploy changes to our Snowflake account.

From the repository, click on the "Actions" tab near the top middle of the page.
Click on the "set up a workflow yourself ->" link (if you already have a workflow defined click on the "new workflow" button and then the "set up a workflow yourself ->" link)
On the new workflow page
Name the workflow snowflake-terraform-demo.yml
In the "Edit new file" box, replace the contents with the snowflake-terraform-demo.yml  **You will get the file in repository. Copy it From the repository**


