const { stderr } = require('process')

module.exports = (robot) => {

  robot.respond(/Get pod in (.*)/i, function(res) {
    const namespace = res.match[1]
    var command;
    this.exec = require('child_process').exec;

      command = `
      kubectl get pod -n ${namespace} `

    return this.exec(command, function(error, stdout, stderr){
      if(stdout){
        return res.send("```\n" + stdout + "\n```");
      }else{
        return res.send("error");
      }
    });
  });

  robot.respond(/usage/i, function(res) {
    res.send(`🍀:Kube-Gchat Usage🍀\n`);
    res.send(`@kube-gchat get pod -n custom-namespace`);
  });
}
