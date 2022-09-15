set -e

cd "$RAY_REPO_DIR" || true

export DOCKER_IMAGE_TEST_BASE=$ECR_REPO:oss-ci-test_base_$BUILDKITE_COMMIT
export DOCKER_IMAGE_TAG=$ECR_REPO:oss-ci-test_base_latest

echo "--- :docker: Building base dependency image for TESTS"
date +"%Y-%m-%d %H:%M:%S"

time docker build \
  --build-arg REMOTE_CACHE_URL \
  --build-arg BUILDKITE_PULL_REQUEST \
  --build-arg BUILDKITE_COMMIT \
  --build-arg BUILDKITE_PULL_REQUEST_BASE_BRANCH \
  -t "$DOCKER_IMAGE_TEST_BASE" \
  -t "$DOCKER_IMAGE_TAG" \
  -f ci/docker/Dockerfile.test_base .

date +"%Y-%m-%d %H:%M:%S"

echo "--- :arrow_up: Pushing docker image to ECR"
date +"%Y-%m-%d %H:%M:%S"

time docker push "$DOCKER_IMAGE_TEST_BASE"
time docker push "$DOCKER_IMAGE_TAG"

date +"%Y-%m-%d %H:%M:%S"