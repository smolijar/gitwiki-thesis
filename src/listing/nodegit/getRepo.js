const getRepo = (uri, dest, getCred) => {
  const cloneOpts = getcloneOpts(getCred);
  const setup = setupRepo(cloneOpts);
  return NodeGit.Clone(uri, dest, cloneOpts)
    .then(setup)
    .then(createLocalRefs)
    .catch((e) => {
      if (e.errno === NodeGit.Error.CODE.EEXISTS) {
        return retrieveCachedRepo(dest, setup);
      }
      throw e;
    });
};