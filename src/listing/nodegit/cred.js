cloneOptions.fetchOpts = {
  callbacks: {
    credentials: function(url, userName) {
      return NodeGit.Cred.sshKeyFromAgent(userName);
    }
  }
};