# Description:
#   This bot will simplify developer to change the context, check the k8s resources
#
# Dependencies:
#   "<module name>": "<module version>"
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Aju Tamang

module.exports = (robot) ->
  robot.router.get '/health', (req, res) -> res.send "Kube-Gchat is working fine"