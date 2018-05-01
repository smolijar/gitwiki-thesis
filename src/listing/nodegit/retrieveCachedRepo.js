async function retrieveCachedRepo(dest, setup) {
  const repository = await NodeGit.Repository.open(dest);
  return compose(updateRemoteRefs, setup)(repository);
}