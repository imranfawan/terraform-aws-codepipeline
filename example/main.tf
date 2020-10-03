/*
 * Make sure that you use the latest version of the module by changing the
 * `ref=` value in the `source` attribute to the latest version listed on the
 * releases page of this repository.
 *
 */

provider "aws" {
  region = "eu-west-1"
}

# To be use in case the resources need to be created in London
provider "aws" {
  alias  = "london"
  region = "eu-west-2"
}

# To be use in case the resources need to be created in Ireland
provider "aws" {
  alias  = "ireland"
  region = "eu-west-1"
}


module "codepipeline" {
  #source = "../"
  source = "github.com/imranfawan/terraform-aws-codepipeline?ref=v1.0"
  artifact_store = "<ARTIFACT_LOC>"
  cluster_name = "<CLUSTER_NAME>"
  cluster_state_bucket = "<BUCKET_NAME>"
  kops_state_store = "s3://<KOPS_STATE_STORE>"
  branch = "<BRANCH>"
  project = "<REPO>"
  app = "<APP_NAME>"
  image = "<REPO>/<IMG_NAME>:<IMG_TAG>"
  spec_location = "build/buildspec.yml" # location of the spec file within the project that is being checked out.

  providers = {
    aws = aws.london
  }
}