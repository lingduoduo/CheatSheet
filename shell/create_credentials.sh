#!/bin/bash
set -euo pipefail

# Rotates AWS access keys
# Requires:
#  * the aws-cli
#  * default profile pointing to eng account 035088524874
#  * jq
# input your username for eng account
# i.e. abc@rokt.com

username="${1}"
mfa_token="${2}"

eng_account_id="035088524874"
mfa_serial="arn:aws:iam::${eng_account_id}:mfa/${username}"

current_access_key=$(aws configure get aws_access_key_id)

# this assume default role is setup on account eng account
# which should always be the case
cred=$(aws sts get-session-token --serial-number "${mfa_serial}" --token-code "${mfa_token}")

export AWS_DEFAULT_REGION=us-west-2
export AWS_ACCESS_KEY_ID="$(echo "${cred}" | jq -r ".Credentials.AccessKeyId")"
export AWS_SECRET_ACCESS_KEY="$(echo "${cred}" | jq -r ".Credentials.SecretAccessKey")"
export AWS_SESSION_TOKEN="$(echo "${cred}" | jq -r ".Credentials.SessionToken")"

existing_keys=$(aws iam list-access-keys --user-name "${username}")
nb_keys=$(echo ${existing_keys} | jq -r '.AccessKeyMetadata | length')

if [[ "${nb_keys}" -ge 1 ]]
then
    # have more than 1 keys, can't create new cred without nuking old ones
    for key in $(echo "${existing_keys}" | jq -r '.AccessKeyMetadata[].AccessKeyId');
    do
        # nuke spare key that is not used to power current cli session
        if [[ "${key}" != "${current_access_key}" ]]; then
            echo "Nuking Spare Access Key: [${key}]"
            aws iam delete-access-key --user-name "${username}" --access-key-id "${key}"
        fi
    done
fi

existing_keys=$(aws iam list-access-keys --user-name "${username}")

new_cred=$(aws iam create-access-key --user-name "${username}")
new_cred_access_key="$(echo "${new_cred}" | jq -r '.AccessKey.AccessKeyId' )"

echo "New Cred with AccessKey = [${new_cred_access_key}] created."
aws configure set aws_access_key_id "${new_cred_access_key}"
aws configure set aws_secret_access_key "$(echo "${new_cred}" | jq -r '.AccessKey.SecretAccessKey' )"

echo "Deleting Old Keys"
for key in $(echo "${existing_keys}" | jq -r '.AccessKeyMetadata[].AccessKeyId');
do
    echo "Nuking Access Key: [${key}]"
    aws iam delete-access-key --user-name "${username}" --access-key-id "${key}"
done
