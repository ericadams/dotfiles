alias dcs=docker-compose

export WEBHOOK_ENDPOINT='api/SendGridWebhookEvents'
export SANDBOX_WEBHOOK='https://1daesk3r9c.execute-api.us-west-2.amazonaws.com/api/SendGridWebhookEvents'
export INT_WEBHOOK="https://5upst37au2.execute-api.us-west-2.amazonaws.com/$WEBHOOK_ENDPOINT"
export SANDBOX_AGGS_DB="sendgrid-event-aggregates-db.internal.sandbox-petdesk.com"

function aggsdbhost() {
    workspace=${1:-sandbox}
    export AGGS_DB_HOST="sendgrid-event-aggregates-db.internal.${workspace}-petdesk.com"
    echo "AGGS_DB_HOST=$AGGS_DB_HOST"
}

export GIT_ROOT="/mnt/c/Users/Eric Adams/code"
export VET_API_ROOT="$GIT_ROOT/svc-vet-api"
export VET_DASH_ROOT="$GIT_ROOT/web-vet-dashboard"
export VET_DASH_REACT="$VET_DASH_ROOT/MessageCenter/react"
export BENTLEY_ROOT="$GIT_ROOT/bkgd-pd-bentley"
export ADMIN_TOOLS_ROOT="$GIT_ROOT/web-pd-admintools"
export ALLSERVE_ROOT="$GIT_ROOT/svc-pd-api"
export E2E_ROOT="$GIT_ROOT/qa-e2e"

alias code-react="code $VET_DASH_REACT"
alias code-e2e="code $E2E_ROOT"
alias vs-vetdash="start $VET_DASH_ROOT/MessageCenter.sln"
alias vs-vetapi="start $VET_API_ROOT/VetAPI.sln"
alias vs-bentley="start $BENTLEY_ROOT/Bentley.sln"
alias vs-tools="start $ADMIN_TOOLS_ROOT/PetPartnerProviderAdmin.sln"
alias vs-allserve="start $ALLSERVE_ROOT/AllServWebAPI.sln"

# Terraform Aliases
alias tf="terraform"
alias tfspace='terraform workspace select'
alias sbox='tfspace sandbox'

alias git-prune="npx git-removed-branches --prune"


# AWS CLI aliases
alias aws-whoami="aws sts get-caller-identity"
alias aws-secrets="aws secretsmanager"

# Git
alias cp-commit-msg="cp ~/.githook-commit-msg ./.git/hooks/commit-msg"
alias gpn='git push -u origin $(get_branch)'
alias ci-sha="git rev-parse --short"
alias last-sha="git rev-parse --short HEAD"

# pbcopy/pbpaste emulation
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

alias curltime="curl -w \"@$HOME/.curl-format.txt\" -o /dev/null -s "


alias cd...='cd ../..'
alias cdinfra='cd ./operations/infrastructure'
tf_clean_state () {
    workspace=${1:-sandbox}
    terraform init &&
    terraform workspace select "$workspace" ||
    { echo "init failed"; exit 1; }

    terraform state list | grep '^module\.[^.]\{1,\}_state' | xargs -I "@" terraform state rm "@";
}
